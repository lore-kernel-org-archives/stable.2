Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049874;
	b=aN09ILU2pQmBQoLo3b8RghdZ0JXh2EwxL3mk2RWSeq9VEWbJn3NUf4NZdsHUI580jaPf
	 aOMUA/Q0djkjlJCPQJHHqGXQ/dU5vsPYgtw9ekQ8O0fstCFnd+WjocGEflboM11TIsHcR
	 kIziFDtGAkx79NPPMwHfSgzrZ+QEIjy+5ZY/V/UzFQ7EKS7G5Y34PBqoYtBQeZbMrXw23
	 gR1shDf4Jg01ZSnTQYxm7FBKIZUPXd2+YVVaEtZJK1GnmIa3JqePuIZyPHKUyG1OZH2BL
	 INoGK4eX+EX3D0Y7Q0jRpxWMlCmKLUwan+emGx7XzwthmdOQdmCLIP2ugSxtys1Ba9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3KCAyI3toiNsOr5GnruCIie9yDz8gYI2NJN8IA5sdjI=;
	b=FvU1DrIJHPFqZzqAamH+ZeeHv+PH0RbBncrWWPT1hxmwIClnHohjvikttqAaJ6yaqBnc
	 QibQRFp0Yvn8aduEwHLi/LMEBb3MtyGEJGg9npAho1Lz+RH3S/siADRSbj1JBtzi/xnJT
	 9IvhQNHJ/CI89TEcyQ+cvxuKhyGu5ph2+BP7Gvw/aB/73GbG86+J7CBDppgfsJ3gOL/Nf
	 QIRe06Xn1OMFXsWe/2/k5UUjF1Qf0/WGY0ztOEqsW2CJnAZs6W6GeGEaDZ+L791ScWxFR
	 aFUv2fzHAf+2iEs7cmYNOB/f3xiaAFRl/sUYsJu7/3J8i3jeo/DH1NE5mgYEhBmbK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ew+OEHTL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F84606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ew+OEHTL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A591F0089F;
	Sat,  7 Nov 2026 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049873;
	bh=3KCAyI3toiNsOr5GnruCIie9yDz8gYI2NJN8IA5sdjI=;
	h=From:To:Cc:Subject:Date;
	b=ew+OEHTLionqOWPaU2FaBN7AFAxYwUFCiqpLYffJHk6epDyo8jvQ06UyP0gfnsGAE
	 VKzBOsXanEM2JO0vJb418+mRePU5DQxVxlBZThDgYbKrbkRNplmIje94FQc89JoAb6
	 TNKftzGLO1ERrluhaLTKMNEU6ltkv6Ovy2mY+IUgGZutHx1qRLEOzdDcw+rfm+WMFu
	 X7uNCFtNTNqSX+g8sW/su/qk6K1SKN0/iTsZOW27Z4R0q/r4e109fr6yFFKGDMOgjD
	 ZDxQgzKaMnyIWj9HN6smIIaRoBMPmFpmAXhY4g9yA+As3RETS51lGOK0r9vg7Rk6u1
	 1NUdbH8GwW3mg==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Clear the reply buffer before use" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:11 -0500
Message-ID: <20261107061111-failed-5.15-2e63ac76cc08@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2e63ac76cc08ea376ba61fef52f7b7849e35024d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061111-failed-5.15-2e63ac76cc08@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2e63ac76cc08ea376ba61fef52f7b7849e35024d Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:52 +0800
Subject: [PATCH] scsi: ufs: bsg: Clear the reply buffer before use

The reply buffer is allocated once per tag and reused. Requests that
complete with a positive status do not fill all of it, so user space
receives bytes from an earlier request on the same tag.

Clear the whole reply buffer on entry to ufs_bsg_request().

Fixes: 95e34bf930ea ("scsi: ufs-bsg: Add support for raw upiu in ufs_bsg_request()")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 18c318d781224..545ef7b79ceb5 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -140,7 +140,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 	int ret;
 	bool rpmb = false;
 
-	bsg_reply->reply_payload_rcv_len = 0;
+	memset(job->reply, 0, job->reply_len);
 
 	ufshcd_rpm_get_sync(hba);
 
-- 
2.53.0




