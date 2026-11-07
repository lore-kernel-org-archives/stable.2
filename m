Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068191;
	b=JFOKT3V1PcO//cT6v3JXZyfeksAxKYvXbv4bUcWpUR0OmswWKw2Ut6qinkgvu9fdMJQv
	 yr8OAmuwq2yd0ph9E1wLbYWt0r21G5lfhEbqjAwDiqIGxjKvsrdu81QWNNtzR54ZSRnDD
	 m5ek8Gptg60Lfy3HMYKuJz0G4RkinUp/aZULuEXP1Uk3JrOdI4po/7V7pQkgRplbBQqL9
	 hXeJF6NbV+nageWgXx+2O8u5CNE3eWup6hsCeCx22Lu5W3sMSETyWKXwSU60Eaid0uFox
	 p84+k5+d1nYi5EoQ7o84gUpJ6dGf/+JzcprHaaAEI4sfASidkVVEudOcGosjxe2Jk1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HvXAluNt0UP21yEL8x3kwKcydwTMVrSMqKaF7XkVqtQ=;
	b=40Ybhs92GuBdLlR8JbLVCrxOyeoHUXyLMWnwnfekelEtSSL3fc/AEB05rdalBuv+aSFR
	 kCisUvWXlOExiVbV0anzwlPkWxJd0OI61NluWbwpf6A3PR4uaQQPTahyl4Wm7cpXA0x22
	 RysLRohkUTvNIdPvy70tM1zzd3LUwv23/YSsG9fXUmWOYOgMGh4E1H0w6G0dqGHf5qGXm
	 2m/B6bZ4wGx3U913XBGhE+ZrxYvAhZG/CnOc4ZAFDYPnUW91P5XawbTpGpV6QD4n2v3bF
	 RAe0S+5NuFBS8UcmSpw5Tk8OiJEsPfVdsafKeza7yEJ+MN8AjGFtYBq4LRuD5+XNP7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eERAWA9k;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1B606AC1E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA1B606AC1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eERAWA9k
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd69954c755so1084103a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068190; x=1794672990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvXAluNt0UP21yEL8x3kwKcydwTMVrSMqKaF7XkVqtQ=;
        b=eERAWA9kaEbCzJ/tJpXpwMn2yT+o+BtDJcVrNs49YsPowCtamknEkKSNlrbRYQvWWg
         FvEQKFyz0avIkcvd8mpNpInY0Jf8i195ASbR3BlFixns4YvIscW5pGDNs/8Qn8yu9IcG
         s4eHd0Aq0jNmHC7vPX3jgRwQUC+RQF2Q4PzI+Eh8Vi3MMyrQruXfN+y2uwSyhaul/xEQ
         5EtEzxzuxVOnpre6u53SC5P/nZPEN//cdy2WWkXjL3B+cSCAmC+2NWuBMuLusGrdkquh
         Fptw/lN2oVScCmqs/APhpA1aSdYZM8HDsYddn5C9OkujKEdfd7KXkWfolaSCr+QLROdE
         gWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068190; x=1794672990;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvXAluNt0UP21yEL8x3kwKcydwTMVrSMqKaF7XkVqtQ=;
        b=reBGbemu/vfpEm3j5DquDo2tHd3HNg5ocjbaU/kKDbSvBMiCFsbXNcRxaKXYFGyHXZ
         atO4Q3+xCuDM6+NHPUX9/lSYtdVLtmu78/PAiYTKyTF40e8FZ+HFkgRfRJSg78slEkpf
         oHaZoQCWYRTLcIpsG55RtJSZSJHTnec4BjOpB1fBlYAHsZ7pHuEZl4y0y2tfIDwLmL/j
         RlQ9S09i1WAm+CaLavbFOlzWLoPfl9l3YSt9ZBl9zkdocw+Yj7fn4IDpW/BF+HzPGoKp
         ekcM6gK+izUKjsqw49TTKDoCQiX2ZgzE4cZTHAiUrMsspXzn1uIQDGcri4/p13ECjga2
         qgnw==
X-Gm-Message-State: APuU4Z+hy5vfEqZFoC1tjJihrrRR6NdkO9KDT/7iytDmjNCvoLdAdHSP
	tRcpji8O8D/f7gxVM/MNxtKKiTdyQvtnSR5UtMdesFqx3zH1qKuiI1USJ+f6Wpr9wQ4g+mXbw1Z
	piQmU
X-Gm-Gg: AYBFou0/JPKNqxfCjgtVrir43OwY9SS6U54pMJaBSsxKb4L4yiixBTeVW2wRQsGtFQm
	/UFmCoiH08gR9kLXIZ9t1xLGEqfUr69XVPPwXU+NrgPIt06UuN8xXu+AbUC5yPgtSr3uwENUUmX
	ZSIKpWhL9FP8bFwRT5Ct9xv/o+5wW5gpentQejly3COpLvKXtSfCI3C3NwdugYHvU10WiH3uTBV
	yHj6jXE70iXT926glsXBzZhFrjRInI6G0sGjXVYZU5GY5MAWsV+HSkWRBQc4sWfcYpUoLH7JRXd
	wT2+AcnJyZafnMjePRXYa3vX/CcdOByeMFTe8VfH7SaSHJYv0/Eqzkq4K/BBNi5lfjCPlsmAiTg
	CL+juNEsGjSG8KZnX8jqYA/FEXQsxF2EMMpQtF3gps+9jvBeP4GV/G+gYSyINIoRZ+5dtRLuaa+
	QPLd5jrHzja2iOTQgfoVAQFMHPV+iYCZ1KNfBbDSbyOmaO5xjWUHKK+FkjBCMJtmWhj8WotURY+
	HPMBZEi1C401bYsOAHHFqgX8nxKe0j7HmnLADiiVj+ZFr9uM8VZtw7Z+0FnPKXYKoTyCZkB7FUg
	qZOOXOw17iq9soh7YKrSJtyxmhSrmXbomoIg/Sub1Y9+GvtSAOrNOoq7MYYtKqjGOOv6PvAxxHg
	=
X-Received: by 2002:a17:90b:288e:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3b0db5f718dmr5609679a91.2.1794068189834;
        Sat, 07 Nov 2026 08:16:29 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 8/9] io_uring/poll: don't poll a writer for urgent data
Date: Sat,  7 Nov 2026 09:16:05 -0700
Message-ID: <20261107161606.2500384-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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

Commit edeac4546a71b6c1db4ba006a2dbf7c863f54e9a upstream.

io_arm_poll_handler() starts the mask of every async poll with EPOLLPRI,
for a reader and a writer alike. A TCP socket reports EPOLLPRI for as
long as urgent data sits unread, so once the peer has sent a byte with
MSG_OOB, the async poll of a send that waits for buffer space is ready
on every re-arm. The request spins through task_work and
__io_arm_poll_handler() until APOLL_MAX_RETRY is used up and io-wq takes
it, the same spin that EPOLLRDHUP caused for a half-closed peer.

While it spins, the request is neither in the poll hash nor in io-wq. A
cancel issued right after the send gets -ENOENT and the send stays
pending, until a later cancel finds it in io-wq.

Only add EPOLLPRI for polls that want to read. Urgent data is an event
for a recv, not for a writer.

Fixes: d7718a9d25a6 ("io_uring: use poll driven retry for files that support it")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.12 sets up the mask in io_arm_poll_handler() itself, with
EPOLLET]
---
 io_uring/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 7884ea7b23c5..c1a9f697a023 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -757,7 +757,7 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
 	struct async_poll *apoll;
 	struct io_poll_table ipt;
-	__poll_t mask = POLLPRI | POLLERR | EPOLLET;
+	__poll_t mask = POLLERR | EPOLLET;
 	int ret;
 
 	/*
@@ -774,7 +774,8 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 		mask |= EPOLLONESHOT;
 
 	if (def->pollin) {
-		mask |= EPOLLIN | EPOLLRDNORM;
+		/* urgent data is an event for a reader only */
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 
 		/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
 		if (req->flags & REQ_F_CLEAR_POLLIN)
-- 
2.56.0

