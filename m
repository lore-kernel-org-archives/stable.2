Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048845;
	b=K0bR4cksKFAiia+/5oIJWyXIJ/0a91srxR3rrB37TRveo5D4HovWAVd7DvG+U7YxufXL
	 3YXjUJ6njV29bGE9WnvqYDN3epteEmIm0BzleW8JuH2H8R00txee77ho7DZm9gYWyxNS/
	 PU3RZKM4Bs73mF2IY3enYuc3A4250ocd3x/MNt0N7zHyOqQ4Iw7C6evDxdFxs439bUXC1
	 23GV7TIho7SU0rIXwjGe2xQT0lg5WgqWN7Hes2lP4008QQo0nC0ijBFOTEkv6vHu4rtHc
	 Y0o3DvtgpKw4Av+qybd3J/EMIwL5K2ZLlA9UdF0pxp6PB5pl8WCQ98H1kzL1OK1awHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yzF/vRbD7CzGZzjBKdbbmAXhNpuACk6lF5gKw400/lA=;
	b=Y0ohacFta5kp+ELw6mPmiyPDMalub5S0cMKIFE1ik09c+rnNnzt1VmsxfRgdkzSpT5Sk
	 xcrDqJZxqCdiLpaQSbu36eLDo+5M5ypyJXCSiXBORuYn3imWWerxjdvpBnlOW2LjTvTuY
	 onsMjd32wn7NKP+2sppyE2H+i/nSCgdQ2qUIeqE1Pica2UKxNBg88v62SfgMWhKjOQuMb
	 qt3bw4YYPRpu4uHmTbLSza+dhtYKSJt7ldM85nVbfnW/i9TJ9fvCRRtmdEbL4D2hXFu5V
	 jJt5C/cGmTbGoOT/Tm8TRwDKbfM0o7197shGWoPgPq9DGm0HFrS/eoIQKZ5on5JW2ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNfFwL+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E9606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNfFwL+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FB01F008A4;
	Sat,  7 Nov 2026 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048844;
	bh=yzF/vRbD7CzGZzjBKdbbmAXhNpuACk6lF5gKw400/lA=;
	h=From:To:Cc:Subject:Date;
	b=QNfFwL+h3mfn7w+will6qPh26SWvzn1q3eSqeDeR1PsDsoNeV4YRzB/CQBnnc3An4
	 bB+QEWo6j9TAby5RNwngD+1/dJKqxhl+bw649jD+7juYwqKHx5Kml41dZxElihJrQd
	 DV5kvKkvN+GN+fBEJj4DrkvjbSJd87JcSaRdjxsZLPGrrkUcXl39bFsGesYGJbnx2v
	 9AJ5D60L2n9HP8lLelf9D6ST3Z4J77psbTvvGld38yquPYxJ2WdbtI4C5eH338W90Y
	 XmSLJTDiaQdR3KU3RQhtpkRVXcMCCeG6cM76t3+FrVXNtjy3rNcumZY6TKhaWk5SgH
	 unVfjiAl1LDkw==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:02 -0500
Message-ID: <20261107055402-failed-6.1-1ae42513205a@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055402-failed-6.1-1ae42513205a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




