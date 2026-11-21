Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296664;
	b=ZfRiH3JcikqLAhK/+fkOKId/tJDRFL8Irdrz11xH0/vmB0ebRXjrtB7x46yRZ2XjxDss
	 bwg9V4qMNhSIdbeMEiXnN47P8X9XVbeJpHuUACHbEyBXDGDBa6AC5IAG9vXNbeC5PMM+R
	 D8FAmvqpKQwt3uMNHvv1CkZ8lS7vaDbsZItnfOLHkPypk8o7kHkxKZKUmoYQbMLFJwKkq
	 0foUm9YZYj3UFWYaT9jtGll7ba9T0o2gvt112VmNxmI817PAbDFrs/FhqnhTX4X6ExMC8
	 Q00pi8ImIqW2Ue4V0yOmAJFXdlS+3MWUCfEigoob4uV6WaroYSbPrA2SJgzVfRl0qog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fpwL334O1X+K2bp1RFvGup8roujLmKQZ1Cno7dlsEmI=;
	b=qIqJqi6g2oPRlpZHt6oxBDq/1vdWpXVBrGzOaaGjXzb5dUaB2wqghBs78Ih9Oy9R6uM1
	 hsJESxJMNge/EKK8BoTZDziU/goma+jhW6/zt99Qt8HVTnbmmdza/vs5rpyzCtg739QRW
	 NYMuu7y6sUQpAE3XdRREH5H082gPNjVml4dpfmBggUYSXuat9mmr9c9/Ec5RXqod/WICb
	 d4rWI3dHdicFYgOAnwnsJlssC4yhaOBnBgmjBm3/ZIMoriryge6uw1WbesfIeW2L//cFZ
	 4KsB6KMx78qPGGUMg2019Le2hMgTT7bbCT2zyYyNlPV50eXIYSThUoG34Fi2n7N04zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=iEu1UhaT;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B3606A339
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481B3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=iEu1UhaT
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702fd86d674so1402364eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296663; x=1795901463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fpwL334O1X+K2bp1RFvGup8roujLmKQZ1Cno7dlsEmI=;
        b=iEu1UhaTYvT7TUmHXffvEOl6SDdcdV2KqPLnDjaQV/GUIkdOU2MIFPdRA3XRXRs6Wd
         003nZILY9Vz6nXFTxNt1vUtGEJnd9PxDjGBBIpSfEYpsCOwMXjz8Uy6wTdPriwJGBnbB
         j0MIJUQdAOzfz5ibaFq7BiF+SVXSpjVziPduMuHr4jelkGG2bNDUKIUjJVDpaxpsyr0n
         8ZgFqlXVUZ4JAL/xZ0aOWm2a1pYdSpM4N3i7aoq0tHfsH11Tc8Ym3ewV1Vx43Pwtn4MB
         CyerpyBLvQF7JEdA/TJdaqqrxpfg8gKasN4dFV6E2kQIqm/6hbSEoH7H7Qeec8C8iGjQ
         7NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296663; x=1795901463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fpwL334O1X+K2bp1RFvGup8roujLmKQZ1Cno7dlsEmI=;
        b=toukDkRPcxnqWf1VwYa55rqAhGO4CnpiIIdf0oprKFICv7FnlqGfIsGL2m+Lujg5gJ
         Y2OCCrf4kZXZLwTVdmYMu3+UFYqAoobDmBl/9BnoG/2igcCIX31Mx38/KlOO9mIvmGo7
         qtADMJavATUVCnhGblFZVSE+3Vs1jKqtBtDNpT4jPcjlNi9hAq+krfbF3vVjp7OTzS+F
         rwaUs/41RvydTB5u7RdNk3rhae2K6nRe5stjBIQjfD8Bm4glegbWicqvEk60Jdn9y7JT
         l79UJFngavoHTvhE9uYaVnJMkvelRCLyQUyaI5ykADe9cKqfnOEa8Bp85VFIzzhmuxXX
         VyRA==
X-Gm-Message-State: APuU4Z8DQkxS6Oets/Vilum0ySZFXOjNn5EUjJ6ljDm1fbuOAZFemtqj
	KmrmZyQxfaQl3H1UttiIx3dGUna+eg2UFsbb960QeFixg1zalv9PhZuXLQy6C8fm+OXGjth6pG2
	tUBbJbtk=
X-Gm-Gg: AZFdTZe6zYZQ7vd1zRHSiwHvazLIVqg9x6JiOxbmaENYr2QvhtLBf/Gv6VOL4p963mB
	PJ8VYq58XRB3VoFr6dtyhiK3XMg6HvROPPjLMMcOs9pE0+OWwl2INbh8+ttDJv8+vzFTZntXnhz
	YVLKOaWpE53JP4tyJiw9ElWJ9gEuzA5Z0+rb6U89lYwn1TPnBwZD0p5d/2Uuxz+xuPQ8750qvfY
	Kjl0Cx0iYX7K5RVCmqPwMFQpov9KzBEZOe1lFGegaZ97SnoomUp/o1rukLsYO/IeuTwDmwF+ul3
	0txjtNqnnvVHd9NksMQG/j8i3gexFSOPVedU56jdhIFZpCT6uCVO9/o2eRlvutEqhhLTsG0yJVM
	EL5kOCiMy6tkWsGrv1+PlD6JkSRdqSkluoOdMSoCnMZsNzf26bGf9fEH2NeZ1IrSuZ2pHgNNnPy
	rQUWQHmdJha+RFpLxHvLYtZuJUSgmUPq3uKP1ELA1POlnF9EAb+8hgfJQ2aVcJ/ljDsWG/m/HJk
	+HahPRhMc/Hzu3YlF7cl/hJKrCF859ud6rwWAytDdiFpB8Hkv6kCxzRIhwkUkDYgbIMkFfTam1N
	OMGt+q/QPeSZpAMzRGPNsuy2Ssi64hb9X6bh/EGSW4Hq6Sdv3y8f/jRM6Jvv9rxiXnDBTh0/myk
	wyevq1czFx212M9CFemCfMwjyYrEKefLQsCIm
X-Received: by 2002:a05:6820:a74f:20b0:71b:1715:7cee with SMTP id 006d021491bc7-71b3956f5acmr4259739eaf.35.1795296663187;
        Sat, 21 Nov 2026 13:31:03 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 09/19] io_uring: wake SQPOLL task when task_work is added to an empty queue
Date: Sat, 21 Nov 2026 21:30:39 +0000
Message-ID: <20261121213049.1788332-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 78f9b61bd8e5466f0e90823e64e3d87c41f6258c upstream.

If there's no current work on the list, we still need to potentially
wake the SQPOLL task if it is sleeping. This is ordered with the
wait queue addition in sqpoll, which adds to the wait queue before
checking for pending work items.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3fd27002f4f7..895011a3d8ce 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1409,8 +1409,13 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 		atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 
 	/* SQPOLL doesn't need the task_work added, it'll run it itself */
-	if (ctx->flags & IORING_SETUP_SQPOLL)
+	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		struct io_sq_data *sqd = ctx->sq_data;
+
+		if (wq_has_sleeper(&sqd->wait))
+			wake_up(&sqd->wait);
 		return;
+	}
 
 	if (likely(!task_work_add(req->task, &tctx->task_work, ctx->notify_method)))
 		return;
-- 
2.55.0

