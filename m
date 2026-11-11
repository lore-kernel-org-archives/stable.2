Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415544;
	b=T84wJMJYzu+WxJFpP+wlRoMk8hoHvUGxSfIJbiNZ95judVi+PLrY8ZYKsi21R234jUxe
	 ut6TCUQHt/f/fzEo1PjdjHBaAacQ8ngjHPSCRcce02Y7iv1+/XskXH3a38vbH4VGECxeM
	 uHVfHSrxply98lqv4DmfDdvKnwVNt1oVf+wcOJJbXMVpFu5twas3Nz6mP7Zm1DmkOA7tA
	 dTo03STvhKX4UgxgA6rgo/kS+ciOSGPb37QWKpJNSOLMFDrC0sUMML2vgnqcQNcu8U85N
	 H2ZaOtyagjDikrllbbAxzJZoOXR3tIE8dg0Dv1+Lew9x0ss20ZYVzdvyWcbqH/+YQ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VOW8RRHaz+rLMRygqacojD8JQx5uHCNw1MbgGWo55AA=;
	b=cpaeR/DRrBXV9ZLVzOPKQtVi7r8b3vLyKZw4mtlCo/206EanJTzOCn6RGkUc/NlIkHXS
	 zOKpBJI8f6K91NLanc8w71+pqq5pu3CVhXZwa2lnCq2YyXhTBZFBVzWtKsV0Bmu76DhAn
	 Av/IZjqBbVp6thF+ZQ7bpI6BmHhjI/6BPDrFVneVIl2OGeJOZESv+ZqzA21lYwEBtM9Si
	 qNwU/u0xPRiM4oty41jcumRUcnM/VsCsRd+qaTHNrKxsefh7IkeB3lNTeNTzUxeyLZVpH
	 i93lLhHYiofUASg9maaZEZYPY0KSqJgmd5B1WsGgloDRjQgdsa+AFsW3oIgwWlmjMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBuBD6JX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6110606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBuBD6JX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB711F00A05;
	Wed, 11 Nov 2026 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415544;
	bh=VOW8RRHaz+rLMRygqacojD8JQx5uHCNw1MbgGWo55AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBuBD6JXch3yt9+D3n+GSs8AE2NRArbNxbHEo4XTTpeyWD0A1N3QsHiiHMWL71OSQ
	 kOHfWKbjQLyvQ6h80ub705r8tBhBL4F0iXSuZNqHI574FcX8lDc8Uvsx2BK21SmM1N
	 UaWvFwJKJnBPjKQXja8DuH4J4qeIIpkNLL5MzoKzh5Ary25uX41U5wAD4C9PYHiMwF
	 12v0gtWWLWTAkVUQfBu/QZXHMfqa9avKwxwLstYPxDxFX5c8momDEq4dbHJavIwLju
	 nktTc5GTwPD8xyVPWA6b2vdxsTwRrOfbKbUWG2uR+xX+hbazm2Zrh23CU1iHwIbDmv
	 V15BHyq/XOD1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nvme-auth: add flag for bi-directional auth
Date: Wed, 11 Nov 2026 11:45:41 -0500
Message-ID: <20261111164516.3303260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053428-failed-6.6-f9e43d924bc7@kernel.org>
References: <20261107053428-failed-6.6-f9e43d924bc7@kernel.org>
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

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit fc1e03eacac8e5ff8664ce2ebadabba8604f09f4 ]

Introduces an explicit variable for bi-directional auth.
The currently used variable chap->s2 is incorrectly zeroed for
uni-directional auth. That will be fixed in the next patch so this
needs to change to avoid sending unexpected success2 messages

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Stable-dep-of: f9e43d924bc7 ("nvme-auth: fail when the controller does not authenticate itself")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9f2a6472802e7..6903c1a4e7692 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -29,6 +29,7 @@ struct nvme_dhchap_queue_context {
 	int error;
 	u32 s1;
 	u32 s2;
+	bool bi_directional;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -313,6 +314,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->ctrl_key) {
+		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
 		chap->s2 = nvme_auth_get_seqnum();
@@ -664,6 +666,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->error = 0;
 	chap->s1 = 0;
 	chap->s2 = 0;
+	chap->bi_directional = false;
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
@@ -826,7 +829,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->s2) {
+	if (chap->bi_directional) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.53.0

