Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272855;
	b=pORp5EqcOxcCB8DF+qYNw36ZS0asSdfjxdtxQMF2Gk35GsKG9BjRUh8U9MpHyr2z90P+
	 f0h78EICZkjUm0t8C/uobfWuyISDij8SencgCMH0ypiurPvEvqjPipMxC8536Ghq3nsQh
	 zMVB6ykregMRPkgiXoBdTILvZnTWTEzDcaEJdypBAdeVl/z6R4m+9B8SI6DdVm5SI16MU
	 bgf5KTvWICU7GIGU983Do4vzn9Mv2ul4jrS6zGmNdX/yvqaTuqgYLCS3+ixhX6TRIfV65
	 RKXlf3q7EsdZY8JiPCtjT0jWrHE03lbcuVtspZyzVI0nL3/e8n/QQtQgbGImzZXZw8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xIKhNlQcZLaZ3CThSCC+S9rT/d/9RNur1x/0Q1JUdas=;
	b=RUuuG4I8YkiWjRKGopiRvCLKt0qy23NhVfI+vUqwo9QD4p3fSVU/vnAX0tX2SN5X8q1U
	 8s9OO6aZMKIJE5OxUKWKU0/JM1l2hK65LguW3UctLvxxQyrlCXc1kSJT5A5/VT2HPntdm
	 328DEgdRkkRzSZ0beLrqItfEsvrwSH7Tv7ATejLcj5yE7K8BVgS2zglhjsFdSdC7CMC0G
	 j0uVjeZL43BRB/fMrNEqGFHXMvvcNrkX+nnDEo2WvdmZ59aHcJcb5tEqo+khXdeQcA9RB
	 hzYnghxwg/Z+pMkOZaVMsNuCCE9kfKhFqaCTjhY38FS3VLTLTHtD6IQt2yFv8Li8+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qncqhmw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qncqhmw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301BA1F0089F;
	Tue, 10 Nov 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272854;
	bh=xIKhNlQcZLaZ3CThSCC+S9rT/d/9RNur1x/0Q1JUdas=;
	h=From:To:Cc:Subject:Date;
	b=Qncqhmw45ykqYitnoH0S9K2s5y3JLBlXyfYrqUnZvYZpedMSD0eNhPuQGBvMY09DY
	 fycZlhNChUCsTMK2Fw7j9rg0/qA9nuMnjHtd0rQlngxZMWbUY1tvA+honwnjYxzO3D
	 X3Ixi6ZiFeA7jpS7cajJcSjB6IaV4OM1yPHnl9oSk8C3jiv+xX7bJ2G4BT53rgeacR
	 QbdKRxkRZ57dBfe2cEnR04UDZju7Ao/Ygt4MzkARv7p3jFbAjqIn9L3ZrXdlc6yncx
	 gfIVy5fLHL8e0XNEwgAcBerUZACaTyRemKW7aEJwmT2ppXk+nXx//sjhjpclR/+5dF
	 QcXpssVmd7Tdg==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: unregister when pr_register() is given a zero new key" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:33 -0500
Message-ID: <20261109200733-failed-6.12-a9d431124fb2@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a9d431124fb2e58215daf0299d6fcf47bbc2d6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200733-failed-6.12-a9d431124fb2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a9d431124fb2e58215daf0299d6fcf47bbc2d6b1 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 09:51:24 +0900
Subject: [PATCH] nvme: unregister when pr_register() is given a zero new key

The block layer PR API defines a zero new_key in pr_register() as
unregistering old_key. nvme_pr_register() sends Replace Reservation
Key with a zero NRKEY instead. The host stays registered with key 0,
and its next registration with another key fails with Reservation
Conflict.

The pNFS SCSI layout client unregisters this way at umount. A later
mount cannot register and sends all I/O through the metadata server.

Send Unregister Reservation Key when new_key is zero.

Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe2648158..d8b6ac4d83bb9 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -128,8 +128,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
 	data.crkey = cpu_to_le64(old_key);
 	data.nrkey = cpu_to_le64(new_key);
 
-	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
-		NVME_PR_REGISTER_ACT_REG;
+	if (!new_key)
+		cdw10 = NVME_PR_REGISTER_ACT_UNREG;
+	else if (old_key)
+		cdw10 = NVME_PR_REGISTER_ACT_REPLACE;
+	else
+		cdw10 = NVME_PR_REGISTER_ACT_REG;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
 	cdw10 |= NVME_PR_CPTPL_PERSIST;
 
-- 
2.53.0




