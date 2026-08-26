Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB336997A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756050; cv=none; b=Qs1nR5Ei1QWyPrDqX7/2iLACNKGlUZvFbge4+SYVRxmMKl6Pz/DH+cwL9fsMHfi5HOFy/kF072DdMz9CrIIKHehPBNciGGoU+0AKIMcrIihuu9XwJKxNQrZ53dTgQgS+rU/05dc2NXOip6/iJOLW6kFxnUF9AqyZPGLVJ++hGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756050; c=relaxed/simple;
	bh=sftiNpcGsFavskhIjJZQmi3SjMjkvbW10mQVnYYS2Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds/2lVJBkls9csdOIMFSz2Urd7dj3yfmvtQms98xb6lOLvQSbAn8yMdykD700113FvTkPkcj2mc6TlgDAYIJOG03F1iW2ElEN8wlJJ+YPOuAfnzSI4cqnO3ImT+GnHzqoNurAadl6RemJrlW5C/QzFLsTzTc2cyhbAOed4j0ovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EszX0Bxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EszX0Bxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542191F00A3E;
	Wed, 26 Aug 2026 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756044;
	bh=TdYvZNW/DXtOnb0kH1kcBjHNPdK6cvyx/1bmYacqkIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EszX0Bxvobe2bBB+22IqFtpjOINrifgwBQjpF6mOvGS8t1e7mqcYzLRM9lnx2C5wR
	 Bq7uxi8TzVJDDxzomcnSBV6S2pZEmjSSTTG1Rsq6dcn/fASC0ImtEF+J6BS++j0oI3
	 dF1Uof6gyP0EK90ZGf1KNnsez4QgJmSfRPc3wCm61qD+tbb5r0z1ry/7ovpKXlfEIJ
	 V9hX3rcJ83UgGg38EkPy8zdL9Z8RH6c6/intiwXYJti+eAA1oEyzoRDT5qehHKaof6
	 nYla0u+eZZEKCIpGyzm63Szpkzy3dIcYAiuSqihPSJ8n/6bXbsd2uzE41mhsRC5yxV
	 H+Ttb0CgjZbpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] nvmet-tcp: bound SGL data length before allocating command buffers
Date: Wed, 26 Aug 2026 10:54:01 -0400
Message-ID: <20260826145401.874903-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826145401.874903-1-sashal@kernel.org>
References: <2026082515-grandkid-mustang-e962@gregkh>
 <20260826145401.874903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Hashimov <security@auditcode.ai>

[ Upstream commit 4a3f00262a044e8e15064b1a6860968bf0500bf4 ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 074ebc26727cc..3a4494ceef128 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -390,6 +390,19 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
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
2.53.0

