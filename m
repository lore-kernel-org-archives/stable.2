Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047907;
	b=EAxfOAYRQTuPC2IKjgNGhFDk7fwamvl6gqhcY41vMmfdq7OLC2Colzt7qnGkHrh3HTzc
	 5FvKGM3vG/vhsZ2hW5AIkT+g9MiDt1K9wwgNiPda6R8JKkkgeHNcEHTCNWiRocIEeLeyO
	 pbeeAH8MVC3y4tghaC5RL5sfkSX6d60bzEM4AA6CLZh/PwR2tV7uOVGyTz+wZcM20hH4Y
	 Ht932Y97CIjjfy4PtdnA8lsr58rPIqNDivZeLKHnG0N/IuROQ2AArgLCLypNB1MHJiDZ+
	 8UPDDoxWbkpxWoDfK+smkledFseovQWlaqcgcuGORDYjv8tc0NxkPJ35LvrTF+eUoVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wKLdWtu5IflhYAzS3Z6Am92s1X/hQTlO/0kPDk/iz+I=;
	b=DfkFzpgnq6YfFSpSjfuFBCu8l0I7gOVZttZbPA6AqeccbWaICBDJJjs2QyfsBmQ76sqb
	 9dPpnWG19as6g2IshO18mGXL7hDaaCPRvEBULlDoWY8ZspAPmEtB7qItfGddMiOaangPk
	 sIOutXObPqDNVh3aNbgByk0F3LCaGgxdU8nv3ZjhoTvNEQo0u2TAmTwXb5Ss6xxQLyNgM
	 Cq/xnZEDiZDAApL3i22JxtJfvbR43ZNQE0HGKNX4Q+nIyulru2LqZbk8Ll1QJyVtQ/SWq
	 g34q2h45SLgYKF5Cs0yo42whxe+ctd2w8jccaaZ8NjRQO3f0eli6XuG+Yh8fV2/Ba8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXEB8eXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37285606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXEB8eXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679561F0089F;
	Sat,  7 Nov 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047907;
	bh=wKLdWtu5IflhYAzS3Z6Am92s1X/hQTlO/0kPDk/iz+I=;
	h=From:To:Cc:Subject:Date;
	b=SXEB8eXeQILHKcseEXMkkg6vrdRQ3eX3CwYYDiQtEKIz+PENzHGSVpCw8gSSpAJtL
	 WKGuq8aAzaMFkR1YFVB3BbbY7FgAvECvUVX2E6ss1mqXrsbxHm6wXbf7RK73MmtNO/
	 fRmFTjLESY4oS8kw9/KOws6i6p1jB0G+VB9i9DbNNDoPA/0Xn+Heq7LW9KR0S7/9NN
	 TSC9ugtFQAAcqxux9DPCoQS5L/ut1lkaK+z3XMUk/h8N/l4zDCkGTGKz4WbY2ZZIzJ
	 tILaVvXibHq5LaDSSLtqSCuUL/uFy+LRCb5kzP7fu1tFXQ+b8obE3mZ5XIqShlb4nt
	 BwZPnqsRez6Bw==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Validate request_len before accessing request" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:25 -0500
Message-ID: <20261107053825-failed-6.6-42aa44371810@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 42aa443718104d10dbdb6f258810b425eb2451f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053825-failed-6.6-42aa44371810@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 42aa443718104d10dbdb6f258810b425eb2451f8 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:53 +0800
Subject: [PATCH] scsi: ufs: bsg: Validate request_len before accessing request

ufs_bsg_request() and ufs_bsg_exec_advanced_rpmb_req() read the request
buffer without checking job->request_len, which userspace controls. A short
request causes an out-of-bounds read. Found by syzkaller.

Reject requests shorter than the structure each path reads.

Fixes: 64d4864714c2 ("scsi: ufs: bsg: Remove unnecessary length checkup")
Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-4-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 545ef7b79ceb5..0db830e54ef0f 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -73,6 +73,9 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *j
 	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en)
 		return -EINVAL;
 
+	if (job->request_len < sizeof(*rpmb_request))
+		return -EINVAL;
+
 	if (rpmb_request->ehs_req.length != 2 || rpmb_request->ehs_req.ehs_type != 1)
 		return -EINVAL;
 
@@ -142,6 +145,11 @@ static int ufs_bsg_request(struct bsg_job *job)
 
 	memset(job->reply, 0, job->reply_len);
 
+	if (job->request_len < sizeof(*bsg_request)) {
+		ret = -EINVAL;
+		goto out_complete;
+	}
+
 	ufshcd_rpm_get_sync(hba);
 
 	msgcode = bsg_request->msgcode;
@@ -194,6 +202,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 out:
 	ufshcd_rpm_put_sync(hba);
 	kfree(buff);
+out_complete:
 	bsg_reply->result = ret;
 	if (ret == 0)
 		job->reply_len = rpmb ? sizeof(struct ufs_rpmb_reply) :
-- 
2.53.0




