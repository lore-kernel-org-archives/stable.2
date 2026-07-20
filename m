Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC23DCDAB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556638; cv=none; b=WV1tVHKhsiPl4ZHJ1xwYV/+5l83bK8o/WQ+QThlAj5ypDi3mUR30hiMhMi9EW6g1riKMo3eLaw0pj5+JzyHvxo3JXoMNs+w93h0oqwh6N0DKt9UDfujf/e3bMD2jm29TJEAA0Kmio555qcJ5Ar2RTzgELk8nFxeR2LcHYuLHyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556638; c=relaxed/simple;
	bh=N/865bA6GgUHnp7FJNzA/QzIqo4TeKX5X7Db7qUtN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnbA0ICKqZoykvT+kUxn1BOIqxoped5+GPwlWGEpTnmWAf4+3n8ky1W7kAPb+mEqlOcQf6hpW7Mz3XVZNcsJKzbN06CzcIHpPXtRc66k3d7/W2R5HAp13IzTQPUFxGlVQ3ZgNcEo6HPzj1f/RyF5+GmKZRc3gCAEg6MBSGV6stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq30UUTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq30UUTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCEC1F00A3E;
	Mon, 20 Jul 2026 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556637;
	bh=lW0/DKg6r3hegGR8aHW3pfRMmVRXPacgYjoY6dC6CWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kq30UUTZdTsO3e3VFco7ICsNiDsoWr17QTIcX2SmZuG3/W7SV59ZA6TNXspZ+uB8z
	 qQQG403PY+vk1HfZCbhfgaKgCS5hgPGogh2XfnALnzF8VtC7huEWlLwPqO/sy7bCPD
	 pUO+qFSqiXcxipq7QTq/2l8DP4RJIV7Qj3v3Wgg6ttPofNK/KuqD55ksJMUpOsACew
	 WZsBQOCzfzxRp8EJ7TqQtcSvWmb2fjBV6+JCAQWygsbjUw7IZ3WZn3m6u1a+OvOCVO
	 OqHts7cZ3BNz4dMis4X9LJpHMSjQY3EJ7mq/SaYqRKESjHIEl54iu10e4tM9Cv4j09
	 JE22TczdpKK9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] nvmet-auth: validate reply message payload bounds against transfer length
Date: Mon, 20 Jul 2026 10:10:33 -0400
Message-ID: <20260720141033.1500263-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720141033.1500263-1-sashal@kernel.org>
References: <2026071506-ankle-quartered-9eb2@gregkh>
 <20260720141033.1500263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianchu Chen <flynnnchen@tencent.com>

[ Upstream commit 3a413ece2504c70aa34a20be4dafec04e8c741f9 ]

nvmet_auth_reply() accesses the variable-length rval[] array using
attacker-controlled hl (hash length) and dhvlen (DH value length) fields
without verifying they fit within the allocated buffer of tl bytes.

A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message with a
small transfer length but large hl/dhvlen values, causing out-of-bounds
heap reads when the target processes the DH public key (rval + 2*hl) or
performs the host response memcmp.

With DH authentication configured, the OOB pointer is passed directly to
sg_init_one() and read by crypto_kpp_compute_shared_secret(), reaching
up to 526 bytes past the buffer. This is exploitable pre-authentication.

Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <= tl before
any access to the variable-length fields.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index a78f2d5c7d5c85..ccd5dd3dac85f9 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -109,13 +109,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data = d;
-	u16 dhvlen = le16_to_cpu(data->dhvlen);
+	u16 dhvlen;
 	u8 *response;
 
+	if (tl < sizeof(*data))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	dhvlen = le16_to_cpu(data->dhvlen);
+
+	/* Validate that hl and dhvlen fit within the transfer length */
+	if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %u\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 data->hl, data->cvalid, dhvlen);
@@ -287,7 +296,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		dhchap_status = nvmet_auth_reply(req, d);
+		dhchap_status = nvmet_auth_reply(req, d, tl);
 		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
-- 
2.53.0

