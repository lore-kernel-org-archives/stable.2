Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323480;
	b=19z02qLylmsUhwzuzcL16LayzzoruBmIisFUoQV0mLHJcTZ02SErxNury8rTcbO3EukF
	 sUkDwURph4uJnrr0N194LoNphIuhMLb9nYTHRODdtzCM6eLHH3AUOjypUZzJIC9QETIDy
	 4H/K9TO84gfc0wVefRzkNVYubtzAVWixl8iJeYTj9mHW0K0SkHalVFz9ZFpmWCnTKlS0d
	 JGic7tHV0NhZN8E+4hpkHMu+p+Mtr9c+TiMshUy0qSM2Ika1Sy6CtKUo4YBS6sUMOBn3x
	 ZJ/DfrxWbpIx0/NFR75ZYUF+/+GQy25auLvoKExWInEBKL9QR3pMWjxEw/y1jHRu5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fFtfEtcSpsmjN4ymDlyAbwugLqNAYnCG5/aGuFQwRVc=;
	b=bBH1a4C4Qfl1I/qI29of2F/y7KMO6pUMHwQCpxVt0TwIE4t1OTb9SXPlQVtHFXcABOoM
	 GA/g/Y3kvtHaV64r3oB3aSbRh1DZXK0iUNl1GC5OPmjBh3dCUEo9b/xO2Z4Vwxc7eSYlm
	 912+4uP+9DdvzZZfAUVaKE5z8xqjFythXZaYjyEm/gvXE9xjORsTHhabF/LF/+YTXbBU8
	 PHgoIzL/6zWecvqSbHG/nagce80g0Cb/Grm9GbOipniCFrSYsNl13vhnj21gFoGKj0W8Z
	 yNKL8juGe3van76gRiRCmQAtV4hYda5qv1jo3nit06qang0jh6yq+BrjjXwGmN0NN0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkHFMygD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A37606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkHFMygD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E0C1F008BC;
	Tue, 10 Nov 2026 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323479;
	bh=fFtfEtcSpsmjN4ymDlyAbwugLqNAYnCG5/aGuFQwRVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkHFMygD/DIYysGOgFBH43clDydzT2q8EdTAhfzrHxN2ZsZRDh0iIfB6vzs/K9GRj
	 gpDKPDNZ5eryeXqD2eO2a10rEO5rZ7pgs0k9c6h2bF7+xyVRVC+W2rR7gOtzDGqbnc
	 nC9FwBRkyC6Q4lMqXIhsvI+eKpOFXhGIPJWM+PVD5UqEyIg7d4wH4H0sPdW1xR5Pqi
	 jLTzYRvH7RVaSdiPoC3eI4uFxMulIZukucQ6BsLLvS5jZANRYC+ALi86eXdr79LuCi
	 vMdzoVsDH+8ttrO1hEkBkh6COumtX4eBev6zLn9K2SILSJhoASFKOrYtzBcESJ1uGG
	 v2VmST1Cq0p6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Li Ming <ming.li@zohomail.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cxl/port: Clear cached dport pointers when a dport is removed
Date: Tue, 10 Nov 2026 10:11:14 -0500
Message-ID: <20261110151026.2046421-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110151026.2046421-1-sashal@kernel.org>
References: <20261107051004-failed-6.18-019560d23450@kernel.org>
 <20261110151026.2046421-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 019560d23450a320f4060ff235563a5277ea8033 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/port.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a7d3497f82c05..01655eeb43a8f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1105,11 +1105,40 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
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

