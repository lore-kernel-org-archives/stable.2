Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAB287246;
	Thu,  9 Jul 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603567; cv=pass; b=r/w2+Nd8+mQL2mvhJg8bDltEt3TY6V5S7dUbn3LKyi7+pLIRCZ9cHv+/QtOGZEGIjn6tB6UbKFV0XsJ5HlRaQ1z1TB/yjEeFZMQXIQI+bg4oX9/hEHoP8iLk8aqrfnjMz4Ry/tf/SO4xmuRzRQLIoGsZ1n5PyHnqf8eUPyBqCGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603567; c=relaxed/simple;
	bh=SUm33TG7oyehUUEn6PJeLoyXUxdzAEPdLu6jD+HEky8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLKHzb4wtE6cgc2txDpfPSRx1mmwwL5NpyQ9D212+wBgn2hsjsatcZQmOWfcs0StANNabkgSYJhw+wmbUrrml9MzCbEPtsF3bCPafL8Bkg6ZcakfTYLVAhzaKlt+N6SWVxHbvXr4NHo9QCS0m1iBAtQIzOzsCpNxXY0SKOjU6LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=no3o6hVT; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="no3o6hVT"
ARC-Seal: i=1; a=rsa-sha256; t=1783603538; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VGvhlole1gh0L+KK3kc7WfTGDaRuxha3r9KJISQqZ4K7FGmZMvrj3oXwYuKGIT+kCpFgIh6x7PuBD5c4DB182xaDf4d2w5gsyhCZXD7qQ2mKvZidW5t05+IRczi8yoc+kii04lmon2vowtWQjoU96QoXPwzo+vU1updnTYGX/2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783603538; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6EazHcCpxTMOYPXHnKySZkKLvpgVBgFJqjzlEqbGvAw=; 
	b=RkOh9dujmbl0WeYXIF0Rw6ydFehtEmD6C1mNO7GKD5MVxMNav6ukoKlcwdE36+GXbTEn05wy4+jkTsq3uUX5xDGbhz9qwRetIZ0IuU9iKUcjSytF+3xBbYp94sC5Y9GEVOWD07PEgM6rOgP6AZrnuz2CxZ+7gWOsAHtECBpHYvc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783603538;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6EazHcCpxTMOYPXHnKySZkKLvpgVBgFJqjzlEqbGvAw=;
	b=no3o6hVTfpVcBkN6D8rvm1zdDkQ6cwX45xHkOOP32e9gO3bKexqpppntdMWGDo23
	z/zSuBONEj74i+uFZ63vijaaMQthQAMmDMnc2ct1Cf9G5Kq0lpPJDR+3xF7e3Pjj2wm
	M7f89UNm4Rss8VsbZqACaYl5rkFx4s0XyfapbOdM=
Received: by mx.zoho.eu with SMTPS id 1783603536013840.1233240570712;
	Thu, 9 Jul 2026 15:25:36 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: bound SGL data length before allocating command buffers
Date: Thu,  9 Jul 2026 15:25:33 +0200
Message-ID: <20260709132533.44195-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nvmet_tcp_map_data() reads the host-controlled 32-bit sgl->length
and, for the in-capsule offset descriptor (type 0x01), checks it
against port->inline_data_size before use. Any other SGL descriptor
type -- including the non-inline transport SGL data-block descriptor
(type (NVME_TRANSPORT_SGL_DATA_DESC << 4) | NVME_SGL_FMT_TRANSPORT_A,
the type a real host uses for out-of-capsule writes) skips that check
entirely and falls straight through to:

	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);

with len taken directly from the wire, unbounded up to 4 GiB.

nvmet_req_init() only parses the command and never inspects
sgl->length, and nvmet_check_transfer_len() -- the only other place
transfer_len is validated -- runs later, from req->execute(), after
the allocation has already happened. For a write command the target
responds with an R2T and parks the command waiting for the host to
send the data; if the host (or an unauthenticated peer that simply
never follows up) never does, the sgl_alloc() buffer stays resident
for the life of the command. NVMe/TCP has no mandatory authentication
in the default configuration, so any peer able to reach the target
portal and complete a Fabrics connect can drive this with a single
crafted command, repeatable across queues and connections for
amplification. This is unbounded kernel memory allocation
triggered by a remote, effectively unauthenticated peer.

Validate len against the same NVMET_TCP_MAXH2CDATA ceiling this file
already uses to bound per-PDU H2C data, for every SGL descriptor type,
before doing any allocation. This closes the gap for the non-inline
descriptor while leaving the existing, tighter inline_data_size check
in place for the in-capsule case.

Runtime-verified on a v6.19 KASAN stand: with this bound in place, a
crafted write command carrying an oversized non-inline SGL length is
rejected before sgl_alloc() runs, where the same request previously
drove an unbounded ~256 MiB kernel allocation (up to 4 GiB) that
stayed resident pending an R2T the host never satisfies.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..c605653c66f2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -422,6 +422,19 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (!len)
 		return 0;
 
+	/*
+	 * inline_data_size only bounds the in-capsule (type 0x01) SGL
+	 * descriptor below. A non-inline transport SGL data-block
+	 * descriptor skips that check entirely and would otherwise reach
+	 * sgl_alloc() with an attacker-controlled len of up to 4 GiB,
+	 * pinning that much kernel memory for a command that may never
+	 * complete. Bound every descriptor type here, before allocating
+	 * anything, using the same ceiling this file already applies to
+	 * per-PDU H2C data.
+	 */
+	if (len > NVMET_TCP_MAXH2CDATA)
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
-- 
2.50.1 (Apple Git-155)

