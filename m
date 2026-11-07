Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048829;
	b=5RGLnaBrbJj7xRbxf92GcPR95w0bVEiqztt+W3AVxYZs0Jc6yfJoiQU3rQ+hD1kU6tNn
	 w/VOaKBzPnev/jIFQZqCYE4oymd62OpPkZkXSNgkaXGDygHmEs22NXuijvVIpEVgC+1Xw
	 uyvsZ4a7FlZAg4dEDejgRV/csOHPQ51vbWgiKcjllFnwtZnXQY16TZ5QWWhS8fxHjPpXa
	 b9AFD9zVHhZcuihOg4ddp+T0PZ23xoSF05zYGJ3nnWrB0Kvt5FDUCKDnOnaTueXxsgH79
	 DASHckztU23I6b/2Vn2bWHHn0A+2GTEeGybYxOF5k+QaVob/BtTkakcG9cQkDWX2rgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2uZCaONLDFetMKVY/hGPVXEG6rK9KvedORy92n6I2sw=;
	b=dUF0UPOyAyNbNPgcV6Xcdl7rwdcDPD73ZUWbgAi/q/od4labYYeH/KIIXfT1bPNUS6rZ
	 aBEPqEjg5aNirL7EYts2FuMYnuQgIzT1iDMFUB2oByjX0jJqddlYCZOMX+3qnONtO0tDy
	 UWlZ6TCYIV76bIFtz0DGS9Gdpm4g1+pcU3jewluQSKrVP3PZnKiczWHrTP0EsQjrGlivu
	 oSKZoROfO5la1ZIn94ctWlYZxQBOG6PW/kE+XhJCeGGtQd1BXQF6TxjgFg1JAs1PF+1Os
	 uZzJM3EvSLr6ZEGP5lZqDcYkpfPAMpe0Lca+kbGL307NLYwedJYXyg1ID5/91uf+5yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k9k7/FPh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25850606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9k7/FPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5756A1F0089F;
	Sat,  7 Nov 2026 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048829;
	bh=2uZCaONLDFetMKVY/hGPVXEG6rK9KvedORy92n6I2sw=;
	h=From:To:Cc:Subject:Date;
	b=k9k7/FPhD/DM4ehQOYC3EXD+7fmiu6Mjm5N5WcCoUFFY92YLXkGsegNcJRXITP62j
	 +GTCyJPFBWulM9Cybfi67bulrLlS/JO3dttp8O6Kr7s521Fv6zci55GTc1qwJ22SmP
	 E3PrNcE+309WWPgPGU5Lo955KvPuqr5pQ/fjkPcTqR7ZGI8z1j0eC6ksGUPoCbJbFl
	 ilHzD/xJv5BSU/An8if04fQKqGg/5FBZWgFLylAU3lz99/0KRNw3fsUBtd3mQfnXNY
	 rBEBMloRBpnDUwdGJM0nIhc+7Bl/lD7CKuEzngsI7Sz6OVaVhm2oEQmlicRUWlFL0U
	 vXJxXVl8AQl4w==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Complete the job on error" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:47 -0500
Message-ID: <20261107055346-failed-6.1-cc0ce3fe8fac@kernel.org>
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
git cherry-pick -x cc0ce3fe8fac073ecded4f32c8ee5b89da1397e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055346-failed-6.1-cc0ce3fe8fac@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




