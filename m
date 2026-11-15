Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794732649;
	b=n9Dr/BYqPWxELzmQBZRJn+z4AJ76dDogB1JDaMhVNNy5m1zNICzBKPPe/sjB5ct/gwgW
	 KFanAg5OZKz7ciMB3zwKz2tbtEFRHhPxEt0qHUTTGpqpKDTOkDKg7hFQIY1r7q8dX+JKR
	 gjP0W54iaqU/4a/WJhx2jz1Nk3sz/bnX0VYWJZbEVUx7R6yOAEhPxdTOTVXwoBQzbW1lY
	 j7gQXYoPL0/Z97XASTVS4UedLJmxdv35IgBf3MPUQtr3BnwhQXXPqEeJFPjySNiCnWZwz
	 wprAu7eRtmP3No9eCBPheRXYX+OmughaOWe5AGCcrHkO7phucyneGD+Wge4vjC8jQZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732649;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1SLobgO+XdP4qfweA06oyBZa+bHh3rqcaF3Z4e+D+dY=;
	b=VeToIq1aW6PQsKxYRqgJWrVUzbYuO3XsTijw/tOzqSje4iMkATaDJHUxYW3j4QjwBHt0
	 2ZDudmoRRx3I6iWd71HT2Zyy03IErzqap05KX67kMeGA1SN0GES00vaznlQPe7+BwTpLI
	 6wBzuobV4Z0FK/V5b5GPghe6eGsBARwfgS+mF3sEMU8waJyR6/7c71y+czichnVB26wvY
	 3gCfQaKnqt8ZdDCkHyYEl67hbK3M4YcncR+dNyBF2ARcyvmB9I2QmwLkBvNuucERPbS2E
	 +TxpRgU5abRwqJgf+cG39BU2RkJO/Rg6q1quQ6ak7DMq1TOOdADo3O4CyVoavXYJaXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dz66k5Vj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B9606A31D;
	Sun, 15 Nov 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dz66k5Vj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794732649;
	b=CFcQfsOc5mjENN58Pe2TEPytIBq8zudKIobrJzyoKCZaEzghqJo17jJKcZw+JvH1JmIW
	 shElwt8BGAyRuDoZp6MsOySeYoUjmwTorFMPOU5xQaZhBhxFAuVIKSVMXonHCZC199Erc
	 plL0SPIfhUSZm/dboXWtMS26fQkywfI0XM74YkPb8XCLBQY5M+6uwexN45YtkqGWmus7K
	 V8ly3fcQlAATE5UQyPMxmtY8dDptp4ZqYXEek8h+C6uErQaRcNJ5CPVpQw4E3dD3QP+m6
	 Aa7KCjxo1VUGd0iZr1z7twV0LzMZscXvctlOMezZoNoTG2P3sX20JSdghH1tgM+fcfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794732649;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1SLobgO+XdP4qfweA06oyBZa+bHh3rqcaF3Z4e+D+dY=;
	b=iZ1GYcCsS1zp/4We6IKiJzu9jLZPL4AfQOndSfO65I9zT7OuUY9psTR9RcRxYfduejO1
	 jrK0ZMSyJ96EMPsdrrmzxEucKrFloi7ueMpg4dCFscsBLXYbG5ShjG4IofcaZp05ke2vo
	 avZJTFfJ+IHvdTYeClJUK1yHlJ/5E/c1TPgM6Nkb5PsSh1wl5Ue+lwF5gxEDbrFJW5yff
	 YaluUmjV95wdjB9Ncvstksw7JW7uIme29ZsicNm9cUAgp0dDPVtrSANomxRl2XCQjZBTE
	 BMd6v4dB44BMGMH97R5R1Kp2VRcQGZiQvJuOx1z6KjjHgBwEchBX2VyFjSDBxyoNfNw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 90E9F1F000C4;
	Sun, 15 Nov 2026 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794732649;
	bh=1SLobgO+XdP4qfweA06oyBZa+bHh3rqcaF3Z4e+D+dY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=dz66k5VjJh6mZaOPUNHCqAkkd2FXirpnX/6w9/WUgfIo/s869pONZC+1JeeYtX5yc
	 CEkvJqwwU3HLYb2s0RNJQDsshTeiYPVBVAtjpyupvPtc617wkPCKTzhf2aTD4iJM02
	 BrDYk/nnQTIUkI7dylw6Sg3umyde/1KEI4ItuQtN6DoRJ6HttkVJTkqgFn43qI1KTm
	 F81Aqi1z/l2GY+KmSS3n784kSrt/K+xTIKlzFTQBIMdsuuFa2T4maV8bwFGVwV+JUk
	 uokGYMpeDY46R0+5/XDfUgjTJTRyR4+k8be7Oumgn8HdWBNGq7bZk7HEncT3YKLTOs
	 T0+JnCtghqMXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06CD849FF3;
	Sun, 15 Nov 2026 08:50:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:50:48 +0000
Subject: [PATCH] media: v4l2-mem2mem: Don't leave the context aborted when
 STREAMOFF fails
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-b4-m2m-streamoff-abort-v1-1-03d069fd446d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnrFUp6UDV0EMSeOAkdIgOyCkq
 ncnpeMb/l/BWIUNLt0Kyh8xKUsDnTqYH365M0psBte7iYhGDCNml9Gqss8lJfShaMUYaYhTz34
 4E7T4pZzk+x9fb4ftHZ481/0G2/YDxOVqXnoAAAA=
X-Change-ID: 20261114-b4-m2m-streamoff-abort-dd13d60ea351
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794732647; l=2190;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=BuQkZRj7ByvS1NUQNOI5Oe3+pEoeToFjAE2b+Y7gZv0=;
 b=31LFjhg6raOEK+/4BmBo3P4wFiBpFI5mErQ8Jc9DyB7SPwYS9ky2pWUvv859FlNhLz4yBQOMO
 /kXF0tOLV54BKZxtRYH4WWfVnytW+2qGaFOlkKqR9k41bxERHfdtlIt
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

v4l2_m2m_streamoff() sets TRANS_ABORT before vb2_streamoff(). If that
fails, e.g. for a single-planar type on a multi-planar device, the flag
stays and no job of the context runs until a successful STREAMOFF.

Reject a type the queue doesn't have before cancelling, and if vb2 still
fails, clear TRANS_ABORT and reschedule the context.

Fixes: 2ad5389b3412 ("[media] v4l2-mem2mem: Don't schedule the context if abort job is called")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi 5 (RK3588S): after a wrong-type STREAMOFF on an
RGA context, the next job ran only with this patch.

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed it.
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index a65cbb124cfe..03d9f492fbe9 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -874,15 +874,24 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 	unsigned long flags_job, flags;
 	int ret;
 
+	q_ctx = get_queue_ctx(m2m_ctx, type);
+	m2m_dev = m2m_ctx->m2m_dev;
+
+	if (type != q_ctx->q.type)
+		return -EINVAL;
+
 	/* wait until the current context is dequeued from job_queue */
 	v4l2_m2m_cancel_job(m2m_ctx);
 
-	q_ctx = get_queue_ctx(m2m_ctx, type);
 	ret = vb2_streamoff(&q_ctx->q, type);
-	if (ret)
+	if (ret) {
+		spin_lock_irqsave(&m2m_dev->job_spinlock, flags_job);
+		m2m_ctx->job_flags &= ~TRANS_ABORT;
+		spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags_job);
+		v4l2_m2m_try_schedule(m2m_ctx);
 		return ret;
+	}
 
-	m2m_dev = m2m_ctx->m2m_dev;
 	spin_lock_irqsave(&m2m_dev->job_spinlock, flags_job);
 	/* We should not be scheduled anymore, since we're dropping a queue. */
 	if (m2m_ctx->job_flags & TRANS_QUEUED)

---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261114-b4-m2m-streamoff-abort-dd13d60ea351

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


