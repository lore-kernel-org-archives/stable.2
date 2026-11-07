Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050901;
	b=kPlO6xf+1trZJYGGCDRmZV4qWRS6rSXwoHr+zvygXqjyccG52wC6fTtvwhsIgJkH3S5x
	 q21w6YgJn4/3ftM1woIPWzAKsZ0na6Zfg2P0jrpI7iW/lB+HmMJ+lZSHWdoMPctTep1KR
	 Qxc+Jp49ttixOwhE93jrQz06CTv33NnJOtg/KJc0vKdmUA9Mz0DYctH3YCX6wCA9iIdAR
	 CVU/lABsuqgCJID+vxmP/E+g768Ht/LqYokd+RczMR6r5Hv8CR2f0n/2zBp7nqaHWEWTj
	 r4+B/OjmltVzDrXiOZAkO23EDJIGlAsKHZyIDXCLWWVbzKbjhvYAUt7SZ5hxAIf1zRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u02Jmj+ZdoKgxyHs/inZObXxM5ROQmbEeMaY5RXkn+8=;
	b=iK0eAaMXdHeJdEnqedIgmG64nJrwaIHW2Bct1a3NQuwfVempR/tqRjxqJOu3sakk3YRB
	 0fF9haNvU+rmhg2EkhBBf8uZV/REdu68JWxhTpOY31SQR1ndgZPAdTnpVZmeKxxusata/
	 pvYaaGVj5WWDugeK3GN3hDaqq8Vvevt/9blxcPQ1dL2pn7J/X1eHxXo/8kkPxsjQy1jXA
	 6hP9V4oWJLm9QekpaL8sgoVw+v7YzUCiTd/Zbtz06KsnHHJ3PkIO+iUMBeiS82QZVhm3y
	 wtaPYQDeL7EUkOchFLclrG00ipu4/tcEOWhPn6DnfYBqyActRMepZ/HzG7H+4DhQtRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnMtcZGH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnMtcZGH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED84A1F0089F;
	Sat,  7 Nov 2026 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050900;
	bh=u02Jmj+ZdoKgxyHs/inZObXxM5ROQmbEeMaY5RXkn+8=;
	h=From:To:Cc:Subject:Date;
	b=bnMtcZGHvs6bK51L0jb35jR7taoXhxiMKs9Wc8PRS2z81sNeN3ezPv4s8uO0rhbD3
	 iEK1LOHpcf/3vKRpsQuJJ77+m0KtsVO2aIMrbBKCLbkm8v+UQKBX+gAFgQCOuX5Ipu
	 t9CmkKzBVXLFXc8vAvG43LdzT/U8PilOR+mmGRDSzbXFIol5dwJfwO8dFPUeuebV8A
	 b2Mbry++4Og+tDhwR2viUQxIE/SD2S/F7Ozyc9uRGU7xE7bzWE0BICJ4fvpPsayP8V
	 MkGrUgY410OPqiYOPVq6Wt5H8NxLfjyFjQtHPJInU+sA7QEk8f+PyTx+VutJR+kb9k
	 +ENxG/1AKCq2w==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Clear the reply buffer before use" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:18 -0500
Message-ID: <20261107062818-failed-5.10-2e63ac76cc08@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2e63ac76cc08ea376ba61fef52f7b7849e35024d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062818-failed-5.10-2e63ac76cc08@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




