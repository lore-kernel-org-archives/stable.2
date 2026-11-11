Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415613;
	b=ws6z3bxRnGAjsGWtWMyFRKIIJBwin7ZFwAcJZj8MQ+CvkzMkuOKNMtWOc1/JVFfd/Hao
	 9pwlWu4vBkfz3Bai9XyN57K4zWB6lvV6poCF7zaOMST9FwouX3TMPRvpsZDzfbopFGI+x
	 g3SXyq3dKuOHo2OzzJEl2+/tn9Xsb8bpKUFAcS9C8A0uMt6tBRarMpmZGJfwdgMLsl5QX
	 10tmyZp33AND77RglvI6FL/ukc4nZ1RM/qrGcoRRk/8S9rD+Jihnq+VW5XyqvHEy1bvtl
	 IY585ld73Oi50BrrdDqPOXfM6HFB93E7V+b0zLgrWA0/UM8RkzjDCcMuFgNu15bPMUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=At3gr0xI8sV88qyAuJdAx5sLuYD0lxPoE0Km3U9dass=;
	b=oW2cpIGxm/4DIdN980z9KzHQuajlEwExZE58Am3PVYbsybMXHAWmPe35lXmtWG+CG9sy
	 X9KwWzz4qz2e0LMr3pmI3/tI0agQb7RWRiS8gaoYu0hdnGvAdFw48JfzAAEixHUtg99F+
	 XLperx8Ew9kCXg/79xMQOnUuHrXfSQBHfP9fi79Z8OurC0kKbQgeTZRLmxGpn86byqsg1
	 uIhmb28eteMTjMxUqKmO+vkuAoY8vo8CQthbjR2Nx2sNgc7bLgZ9VAZbdpbjTrqp5/8r5
	 Q6EJlLVEImaKIHvD7cITAubaIEdRXPzbeDn2C90PdEY8XswAlOEhSPsxvYPQhqiCGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7hNcF2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7hNcF2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CAB1F00A07;
	Wed, 11 Nov 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415613;
	bh=At3gr0xI8sV88qyAuJdAx5sLuYD0lxPoE0Km3U9dass=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a7hNcF2KYv2LzRu4o2Fl84uAdJV019KucRVqliqFRV8fvkDBTFSr3m2lFUj5S4n30
	 szJJ1/EAKlV9sActtSGHlVlEZC/qnt2WGfwhwKROziaEidO75JoE627Or9GjAjc/CY
	 VwEFdH+cDsY6Vwq3a2D7t/HAyUBOYp4VDgJgyp1WgWWE6GxcDGtXdzApQ5MI8NJGsD
	 bxix/4kNptL7jUmwY5c1Gae5DriAnUIDXgns7vEnkISopu2sZhMEQzuUgy56eGXrQJ
	 Pppl6a5Az7idWabxVbsmcamuzGJNy4RMNLQlfs7FuElkYOOq1F8KreV1cV/ZW4lsif
	 Z1hWcpJizJcMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] nvme-auth: add flag for bi-directional auth
Date: Wed, 11 Nov 2026 11:46:48 -0500
Message-ID: <20261111164614.3321142-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164614.3321142-1-sashal@kernel.org>
References: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
 <20261111164614.3321142-1-sashal@kernel.org>
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
index 1679663bf8f01..5bac8a34a9a43 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -25,6 +25,7 @@ struct nvme_dhchap_queue_context {
 	int error;
 	u32 s1;
 	u32 s2;
+	bool bi_directional;
 	u16 transaction;
 	u8 status;
 	u8 hash_id;
@@ -315,6 +316,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->ctrl_key) {
+		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
 		chap->s2 = nvme_auth_get_seqnum();
@@ -671,6 +673,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->error = 0;
 	chap->s1 = 0;
 	chap->s2 = 0;
+	chap->bi_directional = false;
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
@@ -819,7 +822,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->s2) {
+	if (chap->bi_directional) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.53.0

