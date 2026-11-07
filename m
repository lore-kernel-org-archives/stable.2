Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050904;
	b=MLaaj4wqiF1Ic9lsyVGa8z0foijv6gHKATLPbKhk2r1gnfmxEiDKoZmMRlXTTSMbUvtI
	 0wxJbPqcm6ckmfuDB82+1M0mMqLG3hKUg8GUb7Ix3P97CtudmRu12ccDZW793VHKfn5Wx
	 OjFMSMZK6xQad7cC/TeCJhQcs9q45fXzYeSA1ecij0bOc+mq8n7u8MHESEJLXHte5IXCD
	 lal6UUwPKg+4yRTdGhpIhrFY/en3PAU2AU5fiswenSGsux+5qoUVPddqpSDUxSJAncE7Y
	 pTsmdLa5P94cG79pskl1HlHTpy5BpOdXqyGZvAtDJDn6OA5O8itFOKdF0Iv9sEH+Ffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050904;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9EyPjBwGZDHeGJUE1v4aQY/NSxcFupCMpVhbG8AzJw4=;
	b=y1NjDIXJAKqeINtW8SgZ/CKxM5uQn4gAVYzbWQKCtjHfMSqF00kSA1QijejcI0NNVZVD
	 zBJL9e3ujGy1NCggUaiN4LpQorjdw2gbVRwgHslUAMoapQYItfyeKkb4paEOJINaPe8r5
	 cqt2WGvwDr1GoVLW5tnZLJf28tnRu9JUxOStPtbVTlut0jjAoTex6QcdRwY/UbogdC6Pw
	 xVv2tzrQAsvA4U0tgWZD5Zj3Z+nWzigD+rbtLqQVHg+4m7KrBKpvvrv3yQsYDY7KkrHL1
	 sLTzJz4sk86Pl4w+8PNFoF0CgJCAgeC3wGA72BUZXmZUqS8yGhZfPfWxD6U6/mrjhCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpxWKyhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E0606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpxWKyhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C46D1F0089F;
	Sat,  7 Nov 2026 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050903;
	bh=9EyPjBwGZDHeGJUE1v4aQY/NSxcFupCMpVhbG8AzJw4=;
	h=From:To:Cc:Subject:Date;
	b=TpxWKyhVfnT7pGqJWe7PYpw23ZYreHj1VjZthPsjvVXyp6UYHyJfcSkzcFmp5LDCM
	 r3NPa4OmS3qayuLcZAIVofLY/HTvjgVH+wqIi4uYYZ6UzRCzM3eWrMA46CfezCMnPP
	 8ZShtmBJaR+Pxh9NRHYE4sMReNMOSCJ0Zy2DrH0qCzcYh3O+n8IFQJTz4N4mpU2nSc
	 W7ujJMI0zE1j70t8jKX+RJC7XPa/udwpoiIh2qHBLiYRwgnIdZwjAEET80R19OR+5M
	 4/qQQC6jQ1EYNZQJwkMAF4eB4VuDB3l8bdp45mmWlDEZDwv/k7xZV+zt54Z7C1gaGx
	 W8JPBCK7HXamQ==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:21 -0500
Message-ID: <20261107062821-failed-5.10-1ae42513205a@kernel.org>
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
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062821-failed-5.10-1ae42513205a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1ae42513205a38b811afedb6797f9f9c4de37b90 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:54 +0800
Subject: [PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result
 byte

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Reject UIC commands that have the result byte set with -EINVAL.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-5-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0db830e54ef0f..cadde515f040b 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -179,6 +179,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		if (uc.argument2 & MASK_UIC_COMMAND_RESULT) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = ufshcd_send_bsg_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
-- 
2.53.0




