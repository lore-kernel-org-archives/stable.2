Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046207;
	b=G1p0kIanjsmnTlEtL+gWGDRy3vsI+LIgngW6lItlDXqy+isT3RIQhcJ2g5Xl2BQpt3Ja
	 ATPFX45dAjOpVOPF/T/iEJcBfweDFLRbCnrglS9bKeAztcvOwTCOboujDOfX0mEq8U6i9
	 pHx/nwSmWGoF6erDnuLwNlFOHkrgJHn8SlwsBVMKMHusudi4XsUTwO7YlzQvofdHrw8To
	 eqVVf8JNsXNgbzltwHce9jabiICYk0BN1GE7EzbRisNlJA7+AOgm33Swtix4BwnNTLJuK
	 P0Y7HP0oNkjwUsUkUHoPThw4SS60PoSLj006xtiWtjV+3LJfUvZmDawB0Pt3iYFT09w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/P8A4m6JQDO0pdOr+r9UyijVwOZWyHturJT44jKpKJc=;
	b=CD+P/CxfDvJZnr9YEtCJkgpmItKvzx5XkaT0yhaDxzYimj7hsiaj0mUWlTLcXrKRAf9+
	 trla2GdbLjH6VrSm5vdFaZmifb8E6oCoMuhN0JTbBm32aOSqQ8Q0JslKKKWQXPn2Nd1o9
	 CBTJl1KejbhqferFqRu0GF5TfZ3g24bcmW3ECLKDC7CP7lx/I5paBWhQvyxgyOuoebkta
	 HHefg1T4/Gbit8yvvQyRPC6cBd3AnDK1vREfSPfd6OdRfs0s5fR0cYrqVe4TaCSzoQHsq
	 cfEqb80k/GNz7dp9qIlgAsjf/qAbkci+YDm/4JR1JWuoH03v4++3MSEvtUXmqDUaG9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkuUDD+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6017606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkuUDD+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8395C1F0089F;
	Sat,  7 Nov 2026 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046206;
	bh=/P8A4m6JQDO0pdOr+r9UyijVwOZWyHturJT44jKpKJc=;
	h=From:To:Cc:Subject:Date;
	b=CkuUDD+G/UcujpPVeaXGXWUEbYBaztifCFKPspj3+54AFBharb4/H9njFF6kTVqT4
	 Lm5ZcgoPesSzUrm4Jr0eYB7TLn9pVhmPBDsK8LJusKTclexmTlh2uXI5x+qFAFh8He
	 I0Zj0Ab3eNxIp9FJv3CwCsP/cnvhaSVM1qaZLBx7JLNjSFoEhAh/eO1+F3hi+yeZbA
	 LRyM0jOTzku1K1ty/d4FX7RWMQXm3GtVnNj4zoh2ByR91EHwnAoRdioNenrnaQb3Cm
	 JNXbhWCCsIxu3JCP1bgla5fL4GTfwWPxDq4P7jZN1yCQnhsBMqw3Ij0OjOC5nOSqNk
	 E3DvzhUCLq5Cg==
From: Sasha Levin <sashal@kernel.org>
To: dave.jiang@intel.com,
	jonathan.cameron@oss.qualcomm.com,
	ming.li@zohomail.com,
	gourry@gourry.net,
	alison.schofield@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cxl/port: Clear cached dport pointers when a dport is removed" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:04 -0500
Message-ID: <20261107051004-failed-6.18-019560d23450@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 019560d23450a320f4060ff235563a5277ea8033
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051004-failed-6.18-019560d23450@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 019560d23450a320f4060ff235563a5277ea8033 Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 1 Oct 2026 08:47:42 -0700
Subject: [PATCH] cxl/port: Clear cached dport pointers when a dport is removed

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
Assisted-by: LLM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20261001154744.1095902-2-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 95c0be57ed538..ecad766737aaa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1097,11 +1097,40 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
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
2.53.0




