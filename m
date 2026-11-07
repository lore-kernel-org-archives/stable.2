Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050897;
	b=Zg8oY3+j9FElwjLx7albOUH72q4WnR5jmpQE+xYxM2X9gMFZljfAAE+G/v0tDwLqYw6V
	 LnO3EMkwJUWZbqTZz0ua/Mvs641N/t+MckPTuzCh7kvFAqx5xwX+aWEccIS2mRG87fFXi
	 Aj9IQkkProo/oh1oSWShr7zh75CszBh6UhQ6NXCR0CbrTmIomzT1PMT/NLBCJIdt9ef1G
	 a06191/XJntSFvVk2jniucmLfw6PCoqGIvxwC2Jwe3PIzjq1ddvimcKtp5tCu/bxPt5fr
	 N1Fit2SRtzFc1BMsVbg1+UVX21yw7EF/911jWmXn5EnQ8waNr8E6mkPMsCqFyhsMP/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sqr7YSohbL98vK4HIThH3OEbNtYZnA0sCj+B3JYf5hw=;
	b=YDSGPN4GsJbVMDy6OaHl1KC3puNJmFLCc+HrgSF5BkN7Pawg9AJ29Jb4qSq15eXoeaxW
	 Yk+A02BWvfmVnpy/xgODJL4Hqy5ouuxtQonDaBnxyRzIFzptGtH1gsSmwlJuXr++qYPL5
	 SaAO6lvFvabOqodlrMixfcWlB5DD6agRQtoh++JEd2MSiL9q0k/7UmEJM2W6Enm53h3Iw
	 uj+7zrq1NZyoFwv3q+SjxfxNmVUhekpAEJxfckMFoILoGfr4gGIzzMfWzh7ezhJwN/G8d
	 rSfyku0AZs4dPzvGfzI0pK1+TdiWU6WoYjM23vveUga5TeBaWF2GYj4ML+t7jukBW8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLnz9edE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E469606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLnz9edE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC91F0089F;
	Sat,  7 Nov 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050897;
	bh=sqr7YSohbL98vK4HIThH3OEbNtYZnA0sCj+B3JYf5hw=;
	h=From:To:Cc:Subject:Date;
	b=iLnz9edEz2uk0We7ksHPCH6RsAtYq6lA2uvWu5leAyCDQ3B8EKoqM15FOn2KcLfAY
	 ehEosmF0AvV7nNdmOvUgUdh52dIY+Lq0wkCB1KNFNQyPUIHxJOs3NfhCXI2MeZuJaH
	 IC5VUWe2MA0Y2nwnRKhGz4zoUh8Ut4WgnjD/qAe/jhO2GVdhG8DHgMTVOzIyd+7NqB
	 YcHoQoJl5PdNBJ8rRpGUxL70FkU6c0ZoFptDXmjWJj4hVP2pEAmcYIyvQutzZ6kFBb
	 ji7oGEYdw6YXqbStWpw/g59hEH8TVYLjxQK/NSAEakm/LC4KZCoojzlT8WqaDeelI7
	 5CEVjajVVhoYQ==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Complete the job on error" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:15 -0500
Message-ID: <20261107062815-failed-5.10-cc0ce3fe8fac@kernel.org>
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
git cherry-pick -x cc0ce3fe8fac073ecded4f32c8ee5b89da1397e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062815-failed-5.10-cc0ce3fe8fac@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cc0ce3fe8fac073ecded4f32c8ee5b89da1397e8 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:51 +0800
Subject: [PATCH] scsi: ufs: bsg: Complete the job on error

When ufs_bsg_request() fails, it returns a non-zero status without calling
bsg_job_done(). bsg_queue_rq() then ends the request with BLK_STS_IOERR
without running bsg_complete(), leaking the job's device reference and
mapped scatterlists.

Always complete the job via bsg_job_done() and return 0, matching other BSG
transports. Requests failing with a negative errno now return it from SG_IO
with the 4-byte result in the reply, while positive status codes still
return 0 from SG_IO with the reply header.

Fixes: b13a3539eb2a ("scsi: ufs-bsg: complete ufs-bsg job only if no error")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-2-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 7a66917b3fc0e..18c318d781224 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -195,14 +195,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 	ufshcd_rpm_put_sync(hba);
 	kfree(buff);
 	bsg_reply->result = ret;
-	/* complete the job here only if no error */
-	if (ret == 0) {
+	if (ret == 0)
 		job->reply_len = rpmb ? sizeof(struct ufs_rpmb_reply) :
 					sizeof(struct ufs_bsg_reply);
-		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
-	}
+	bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.53.0




