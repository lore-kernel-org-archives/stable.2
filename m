Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273956;
	b=12m2ypPlSnOfK4E47+luDdIPJlfYj3tI1uxhhhNqO3g9NJ4zX/1lp+vG4WB47iEpBqYB
	 IuhKBTW7aO5vUX1PRaJcbeMprEXfgLevZj4Q4imCpYihtoT79+pBh5kn6KV8oCL1ulp20
	 H1tSk62Vl6FkkBvjjzJRgPCxoj/RIK3H4X83NMO+OVq6msWhifxyyiqgp0AXtn6YwClL1
	 YR94WN2Z64ut9YXnliWW8lUbPTEmHk5AsHF3uXPlyB38oOj32t89wWjJAIFsOEq+TH/Ef
	 gkTkbHcZ55FTcaUMv8pPIm2aP7RZmQfG2NoiQ0e/cRLvgkoLzBtroSF0WDCoDyp9+0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MkeF3HdVNEnc6SL018lV9r6WZrXYBcLuAoU6f+o5qBo=;
	b=EdReeDOxPWVUwpmVIFEY+vQoxHgcFCK4rdcAVpWSwWWKwDHBwIKMFeQGKvjj77f3FNHa
	 WEhf7JZedtjRIYm75+/O0t3ACsHam1ffhUIvi/zX60xa+EjzVXVy1x8SNBnh77TcoOMeC
	 doe6au2TAXCgyCtdcyjKvg6l2sLpL8B64209n3LU5V52dx4agc9R/asgFx4c6hsoLdMVa
	 2os9+bnXIMqtGrbEy1bKdKEfsUBdyziRcAyh5ef/4nGwEJu8qjIgdZu65UlQunGMPKm5V
	 dlML7sJ2Ya3xJO/yHb7qEKktUHk5oJCLIhpnRG95l3Zth/pxzLTHkivPxJi35MsZVFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkJVNCOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7A607187C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkJVNCOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D591F0089F;
	Tue, 10 Nov 2026 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273956;
	bh=MkeF3HdVNEnc6SL018lV9r6WZrXYBcLuAoU6f+o5qBo=;
	h=From:To:Cc:Subject:Date;
	b=DkJVNCOwVgcYthm1dR0uoNJbl4pekIwL6CDpMFCrwqHKHGnjqPkPE9LU7jdAWau3+
	 A4qYd7hRISgNiUfgLbJEJbwMiJr3SGFzUjOARk7QR+I2hfsvG3XbeHN7Yqb3jhttuW
	 H/1tv9zoEdm6woqUioTvtgIjE9HkZokGm6k3Kp3OCjMaYvHqlZLHOZpT6/XxuKZsJ0
	 2LCsg0ni2blvVNc1wVfR+NhYko0pr1FeXBaqFOFMtcC5L2LovQL2LOZ9uPhCab59It
	 mUUSVnMiO90CfEZXs7q7ZJZcKiwapfvX3QH+KNFVomwPIKu8UuI0lOt3Pc2KEsiZP4
	 +kzh/iNIJhDUQ==
From: Sasha Levin <sashal@kernel.org>
To: x-professor@outlook.com,
	yangxiuwei@kylinos.cn,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: bsg: Report synchronous data copyback failures" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:54 -0500
Message-ID: <20261109202554-failed-5.10-a52f2ad45726@kernel.org>
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
git cherry-pick -x a52f2ad45726d788755b525adcf51f65a6b836ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202554-failed-5.10-a52f2ad45726@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a52f2ad45726d788755b525adcf51f65a6b836ff Mon Sep 17 00:00:00 2001
From: Yingjie Wang <x-professor@outlook.com>
Date: Fri, 23 Oct 2026 16:23:04 +0000
Subject: [PATCH] scsi: bsg: Report synchronous data copyback failures

scsi_bsg_sg_io_fn() ignores the result of blk_rq_unmap_user(). For a
data-in command that uses a bounce buffer, unmapping copies the completed
data to userspace. If that copy fails, SG_IO can report success despite the
copyback failure.

Capture the unmap status. Preserve an earlier sense-buffer copy error and
otherwise return the data copyback error. This matches the error precedence
used by scsi_complete_sghdr_rq().

On x86_64, a virtio-scsi INQUIRY with an unaligned PROT_NONE destination
made ioctl() return 0 in 20/20 runs before this change and return -1 with
errno EFAULT in 20/20 runs afterward. Writable controls succeeded in 20/20
runs on both kernels.

Fixes: 10e8855b9451 ("bsg: add SG_IO to SG v4")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <x-professor@outlook.com>
Reviewed-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/2561d633cc8cef513d75eb1df260046a4971e783.1792772194.git.x-professor@outlook.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/scsi/scsi_bsg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 5eec248a77a6b..37393a8dedd84 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -199,7 +199,7 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	struct scsi_cmnd *scmd;
 	struct request *rq;
 	struct bio *bio;
-	int ret;
+	int ret, unmap_ret;
 
 	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
 	    hdr->subprotocol != BSG_SUB_PROTOCOL_SCSI_CMD)
@@ -273,7 +273,9 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	else
 		hdr->dout_resid = scmd->resid_len;
 
-	blk_rq_unmap_user(bio);
+	unmap_ret = blk_rq_unmap_user(bio);
+	if (!ret)
+		ret = unmap_ret;
 
 out_put_request:
 	blk_mq_free_request(rq);
-- 
2.53.0




