Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4091402BB6
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156244; cv=none; b=pCQ+gFlOwc95I0IbUEpz90fAzx65gx5qFM35uItl8R1J31NoVnIhn8bHLSbXcY6m/W5yc+6bmaRIYUEW8ghLbaGbWtrCFN6iiPOmSRghU4Gski+kH+p5SlwDZ686brwyb4jYaTTauZlfAovfp1V1bmZUFG4c8+3bjAO6d/M6cZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156244; c=relaxed/simple;
	bh=osiZIaKt/H9KkiKD2Zd349Zodx2nxxdEriMDMsZpQBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYnVhTEPQEsOgkKsR6JSZ8YnhJGcGQ2CvH96qLRzGJi2GXS5iB0bGM+FwO1fJ1Gvp8MDBrUTF7NijCHA9yypYpmAVkSEQ378eGmRDkaYb2aeW1ljqsaZA4KXsdi6tUAiPkv8Rdqy53rv+xnP2W2O6nrU5kogmLeQf4cUuN0N74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2M4xAly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2M4xAly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C31F00A3D;
	Mon, 27 Jul 2026 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156242;
	bh=xrZz6mRIgQbjo++WlbyvkTVin8gsozXdjRXhTe0F2eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2M4xAlyqa/x6IzIPH+TxYDP3DeTArSLQwaaMpJHvrRPJWeKmml0z+iL295lmclbB
	 9dOGEPPCus8XGeY6PoNhakiGWb9G9ojG3zGUcu27/CHF+5NrM/aP7I0PhUC2ix6Guo
	 HOTzBawbR6A7dAxTIYucXEMSKDmjPXuseTrmkCGqPAhZSLh9EY+Ufraow/HbM7w+rR
	 8YGPEnThpPq/sNmFm6+D//OascTAx+xBi+5GDUqJ0bdy8Tu8htxzk7lDPCgz4gEczc
	 9kCrnXyQDvPJd4P2esnBbVQmXC5GotKlmW5ClweQWjfRsiQVbjdnLY6vZrnAPfxr2F
	 MJ6kT44TR6jMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nvmet-auth: reject short AUTH_RECEIVE buffers
Date: Mon, 27 Jul 2026 08:43:59 -0400
Message-ID: <20260727124359.172046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727124359.172046-1-sashal@kernel.org>
References: <2026072058-flattery-mammogram-5fea@gregkh>
 <20260727124359.172046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 779575bc35c687697ba69e904f2cd22e60112534 ]

nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
after checking only that it is nonzero and matches the transfer length.
In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach the fixed-size DH-HMAC-CHAP response builders with a
kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
nvmet_auth_failure1() write past the allocation; both only WARN_ON the
short length and then format the message anyway.

Impact: A remote NVMe-oF initiator with access to an auth-enabled target
can trigger a 16-byte heap out-of-bounds write via a one-byte
AUTH_RECEIVE allocation length.

Compute the minimum response length for the current DH-HMAC-CHAP step in
nvmet_auth_receive_data_len() and report a zero data length when the
host-supplied allocation length is shorter, so the existing zero-length
check in nvmet_execute_auth_receive() rejects the command before any
builder runs. The SUCCESS1 minimum is sizeof(struct
nvmf_auth_dhchap_success1_data) plus the HMAC hash length, because the
response hash is written into the rval[] flexible-array tail, so the
minimum is state dependent rather than a flat sizeof. CHALLENGE keeps its
existing variable-length guard in nvmet_auth_challenge().

This is reachable only when in-band DH-HMAC-CHAP authentication is
configured on the target.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 74fb7b1b4bd73f..07f2581529d53b 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -445,7 +445,31 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 {
-	return le32_to_cpu(req->cmd->auth_receive.al);
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 al = le32_to_cpu(req->cmd->auth_receive.al);
+	u32 min_len;
+
+	/*
+	 * Reject too-short al before kmalloc(al), since the SUCCESS1 and
+	 * FAILURE1/default builders write fixed response headers into it.
+	 */
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return al;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		min_len = sizeof(struct nvmf_auth_dhchap_success1_data);
+		if (req->sq->dhchap_c2)
+			min_len += nvme_auth_hmac_hash_len(ctrl->shash_id);
+		break;
+	default:
+		min_len = sizeof(struct nvmf_auth_dhchap_failure_data);
+		break;
+	}
+
+	if (al < min_len)
+		return 0;
+
+	return al;
 }
 
 void nvmet_execute_auth_receive(struct nvmet_req *req)
-- 
2.53.0

