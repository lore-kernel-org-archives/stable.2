Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415611;
	b=4caz9v1++9Z0U/OA6C5vCuRoeDj+JeQGCzuKcn57h+QK5pjLVaDYfCkbAtw63OQiBhop
	 o3IF746OjDpNaq6oLrzFvGMNsJ3r7nEz5aeaJmSK8NN8Al/kjx8vcobbOWgeX1s8bcNKy
	 vSPrPS4pnir50hkUunORaKn+XMem0gtlq/YBEV4vgNsfHDspDxuen+BoYCKh1nBJKNI0T
	 PV5DtK+EpeEazU2lShq1333wk8Qr0nEw6+igs9rnNbXvGw6AM5z5QDJgusCe1pdXb47Fz
	 vWubRBRs6680q8a7bOkWKqN/irBzH4j7YzMC+IzDHVLDH2iKbGGu38d7TsLC3Ogzv0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TO7BglJHlOmQ2cWeH3rlmVjCTPhNJVMqS/r/lvct7FE=;
	b=TWQma31PMk2ZAVgtaMvSvarEuhNRLBkBIOrbKV4H4W1kZ4MeIVbgbfaBIZdnUkFx4k43
	 ZdmZ6Cp7iziqHYXATv428sg/Io/uumekjbMCswHBkp83KRv189CTBNvUt7lcXVTInKFXY
	 fJpYTppwq9k+qDLGChn8aRRWOUAHuNwISr42Rg0kgvvYWrHoVmKDYhg1FfCWso4np2397
	 O2TRqVW4UmeRyaY+6Y7VlyB2GqEq1GcAKlAByJoQUOWlHskRWnB5dl67WrFhaHhn2Z1rx
	 7Ahtib3VTOCqjwzSd6QrHmdDQdHrek88zcVRXWuNGcBrRmAwu/FdlT14s8ASx2cQUPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmm7g5bu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmm7g5bu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E48C1F00A05;
	Wed, 11 Nov 2026 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415611;
	bh=TO7BglJHlOmQ2cWeH3rlmVjCTPhNJVMqS/r/lvct7FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rmm7g5busx1Y1xKrkCCJeLVXMl/8N4jalEMZnDveEltB6CdcIRE1QcPGDgV7XCP1t
	 nyKiUtKrG6PhbLATUI3/j2DvGL0zVI0Kl9NgYoS2xa8dFMH8H3EEAQHKO5QUr5hYcZ
	 W5kBj0ZXH50ETIz/+xAzRGl13lk7t7UY7gBQzN7rqytnxwOM2omkFaRiO8/g8pWFSj
	 mJi4aEFHBRKVkOV2THxBxufiLEcfPquSOy/NzAM5g9D82dpa6eKRgZCo4SO4raf1xE
	 kZteIX9me4Z+biDWRkwF8+PzPU8ArY2WoolxDV81v9PKEU7TzGy/Xv8gPmvyyS6FXy
	 oG9RMnMoheJAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] nvme-auth: check chap ctrl_key once constructed
Date: Wed, 11 Nov 2026 11:46:46 -0500
Message-ID: <20261111164614.3321142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
References: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 546dea18c99928bb81392de63092da0e25d07b10 ]

ctrl ctrl_key member may be overwritten from a sysfs context driven
by the user. Once a queue local copy was created, use that instead
to minimize checks on a shared resource.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: f9e43d924bc7 ("nvme-auth: fail when the controller does not authenticate itself")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 69aef668f1056..c741539afa55c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -344,7 +344,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (ctrl->ctrl_key)
+	if (chap->ctrl_key)
 		size += chap->hash_len;
 
 	if (chap->buf_size < size) {
@@ -819,7 +819,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (ctrl->ctrl_key) {
+	if (chap->ctrl_key) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.53.0

