Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80762332614;
	Wed, 30 Sep 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781804; cv=none; b=c4ETTMdppTINKlBE9IINwSnXaFNaX8m3XcVg2OZM7NnKU+yxaeBZvSZ/QKK0HkOolG+S+ss8eY1X7tA1yX1HLOZy6+WkzgX8pOYxHVTGNumvXcsk4VdtwvhqXIQ9fC+6S1xPSSXVZdmpg1nZGZ42SJYBjWURG+/dRg/IjrhMWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781804; c=relaxed/simple;
	bh=Ctae4GbCsR+ZIcRGbALIdMVB0JGtBJgthgoy1B3RCIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klAsqz/ZfgcO0Ig3h01c83MFhwmxtMHP9Fw/V3OY1YgVZ4HXD0wTWTmud3sq7mlN/v475i7rdAJSXAncA3+4Q2RtwJ8NoYkeoAf+PlrlipzboXL9I+qQUCr3Bn1Yw8gzXFJ2hvBCCh33IzNmQv5dYhEoC1MisQ1uS2RJ+SKh4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7161F00893;
	Wed, 30 Sep 2026 15:23:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	stable@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH v3 1/3] cxl/port: Clear cached dport pointers when a dport is removed
Date: Wed, 30 Sep 2026 08:23:09 -0700
Message-ID: <20260930152311.4164036-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930152311.4164036-1-dave.jiang@intel.com>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch decoders cache dport pointers in cxlsd->target[], and nothing
clears them when a dport is freed. Readers then dereference freed memory.

KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
reads (abbreviated).

Clear the matching slots from cxl_dport_remove(), walking the port's
decoders the way cxl_port_update_decoder_targets() does on the add side.
Scan all nr_targets slots, the target[] allocation size, and clear every
hit.

Fixes: 8330671c57c7 ("cxl: Add helper to delete dport")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
---
Found by KASAN while stress-testing a separate dport locking fix, not from a
failure report.

Reproducer: cxl_test, CONFIG_KASAN=y, 12 concurrent readers cat'ing
/sys/bus/cxl/devices/*/target_list while cxl_test is unloaded and reloaded.

With the fix reverted the UAF lands ~1s into the first unload, on the trace
above. With it applied, 36 cycles across two runs are clean: no KASAN
report, no WARNING, lockdep never self-disables. clear_decoder_target()
fired 2916 times during those runs, so the new path ran under the load.

KASAN only reports once per boot unless kasan_multi_shot is set
(report_enabled(), mm/kasan/report.c), so the reverted-fix run cannot show
a per-cycle count - one report is the ceiling, not the frequency.

target_list output is unaffected. Clearing a slot truncates the list at the
first NULL, so that was the regression to watch for: 88 target_list files,
no empty values before or after, and the multiset of values is unchanged
once the ida-assigned decoder names are stripped.

Enumeration is unchanged too: 15 memdev, 12 port, 15 endpoint, 192 decoder.
---
 drivers/cxl/core/port.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..6ff3353865e3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1089,11 +1089,40 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
 		device_unlock(&port->dev);
 }
 
+static int clear_decoder_target(struct device *dev, void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_switch_decoder *cxlsd;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	/*
+	 * A dport can occupy more than one position of an interleave, so
+	 * scan the whole target list rather than stopping at the first hit.
+	 */
+	for (int i = 0; i < cxlsd->nr_targets; i++) {
+		if (cxlsd->target[i] != dport)
+			continue;
+		cxlsd->target[i] = NULL;
+		dev_dbg(dev, "dport%d removed from target list, index %d\n",
+			dport->port_id, i);
+	}
+
+	return 0;
+}
+
 static void cxl_dport_remove(void *data)
 {
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	/* counterpart of cxl_port_update_decoder_targets() */
+	device_for_each_child(&port->dev, dport, clear_decoder_target);
+
 	port->nr_dports--;
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
-- 
2.54.0

