Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068120;
	b=MlVD2jskDv0INjluGyphKYbsfOVXuXDFEwql7dQD6M10G2ZcaQDEcZeW/HQD8LBEopEt
	 yCUKlEkb0G2qtIeITU9i9m3ZaVVioFQCNchC5DQ7gJGZaOPE6UTT/a1dfmDE3LlKf/Iav
	 B7H9RYvmO00uIiIEZuUjiCBHHZhonjPwelQq8q1pwE3NvLuOLUsATCe7cg8Wafvss6x4q
	 rIUcIRzxwxQhFG7oadtw6adyKSSBgxYWsVUZ6+sWXekSwnzCVw48REUruEKH3J63KAXvM
	 4PL9xZazVYB3SGsJUPb6wUSHTdGSKzsso4WdFS3y6MLQCvPXKlDM+CzKQCbD890UGiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eElTuH9iJDo54lJHraNTWPiaMesP0hpF0wZjBYLDMVQ=;
	b=h2mju8t4LkUjQaz5bMzBxxGS+xq0N2AJOHHBM36/k3yTAGLoh1OatqgDPZygykwwW767
	 Bu7M4rF/4Zg7A/W66Zt6Ibh4sz9/qyCVeSy6NQn9Xun9C7o4HAqRMfqdLH4mGK2Ap6JZm
	 83k95/rNk5lfcHtrh9+ek2T9iZzAbU5x4Kcn2MkfUnofG0gdSHZjAUwRroElINBbRfiv9
	 n/64TcISWi3yhlQwUYkxs4gDIQLmIH5bhihs8uSC5Jd8KbSKBoVW9HhgjI8z6LmcEyWKL
	 cVMJwPcPiiPT8NqLjhqhe5XAjaHUbgZS626JJtY13HLZMovTLMPJ9C3idyvhGH1E26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Nk1ve6i7;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73785606AC21
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73785606AC21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Nk1ve6i7
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06e79e152so710472b3a.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068118; x=1794672918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eElTuH9iJDo54lJHraNTWPiaMesP0hpF0wZjBYLDMVQ=;
        b=Nk1ve6i7ahD7nOOTqQO2w+aMzXDBcYC8nQdpyL8iaawInngKw+/K3t5d5KH1Eqka9G
         nga8d/QHplRxaCCC7D7Ce+QJtgVHDRH/jcVcXArut2FrMF1zM9N2RuQSBnhcnbXCO4iu
         lOMFx0YcFM1KNI/yx1dqP6mv5njnQWxSxjhUnZll/oLn2B1ZAvQeJQAKZT2t7DFQYI7o
         YA0BTUG9NJpHWyh44I5P10JI+4BqsFAJRPViIVle5vkc7bGgb77+/TUlHdJGdF66tJ2T
         mieuuC5ud+zTELCOxv6UXnMS+zeCN5HDCZusJX4Z7xhTBkD97W0jc+orvLYqof5m+TnP
         cmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068118; x=1794672918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eElTuH9iJDo54lJHraNTWPiaMesP0hpF0wZjBYLDMVQ=;
        b=HUjNp9pf71OjJ5X0D2l5yZPdWwo+Qotu7oSIl30m6f02QQGwwuJbiUw2aeSABoEG+u
         IyxtA/WlsW7Lw2Q/1SoTvS6BapSUkEN/+JTIpb7t6uaE/6aFtZNUzBfC3VRKfNvLCQBz
         WP854mLNW0JIA2ADahMSiJp3GxDPifX3PnJxS5ldxjPfaUXDq3UH6UXqilwr31QvCzbx
         1fRgHl1kNgLrONbUckrMCF2cfwtSUO82QbI3aRnO/cMGKnl31OyuagamOv0SgOnxGV+k
         JpohM6+29kispv6tyKV5cK7d9g7F3MIhB//tY1OSX2PSBTigSqx+FzJlKHa3n1oo2eCM
         MqEw==
X-Gm-Message-State: APuU4Z8V+qhfAGtssPgdybKpV4N7eTyxMoeeZ2AODplj0zOrLFIh4HzO
	bE+r4dSyWPdyj6d31ucoGya3cOarrQ0GLamYSKPTNv/hLhgL06CoDs5KY0GmjLSnHr2tE7OUXDo
	V0NTATZg=
X-Gm-Gg: AYBFou3h9OjhWSTofbRgxWBjaYCPrEjvawS+op2ToRg+6Cndj1woLCRwHlzylm/JjU8
	6LcGsS8ZAqXeVYUwSOFaTufgo4CPurHNVFTj59hYx0dMHps0oV2wC3mw/Er2kg5bogUKtylQOtt
	jDzIVhKY1ugMedwTnFf3XtUzGCXIwR8ch9UBSLOyamGeJvdbfHm0RgEEKbaOGmNsIOLhmVyn/2Y
	2IP46zY5ryqhO6vwv58SKPpDANlOM2QwByff5JOodJAsj9zHlR8rorZC92VlfTtvkJfW+KBbO0e
	1xzZXDCTruCkCF1pG04sX6KEkq2FeHWuZxaTI1mmRqayOydWv/s7DZar/uQ3nmP7bcAFOaikQLA
	jaWrf6UaoC9XbxpogwPt1/UVTbyimiM8V4RrkCXMQtLt9lY3cVEFdpGDn11mN1JWEPmKp7/WF//
	hdzJO+wyANO7WoZDNHzYjq6Y33JkTkms2/uORLYEoMCUQ8CQi/TY1tPEYOm+O3VehQue0a8LDnE
	ULud8uc8sTo5q8nLSegXc5TGh8NCoZxcE1tRfXkwYI0pM0RywN/58X5M9YLl25Ic6vFyRkMuy9h
	//zefDlovnQfzkl93f5bCXlrRAdZD/iBZoKuRf2TdjKjvBlZl809cINTzU+5vO61a51YUXafb8n
	r
X-Received: by 2002:a17:90b:528d:b0:3ab:d45c:59e2 with SMTP id 98e67ed59e1d1-3b110ad7bc9mr1043965a91.55.1794068118346;
        Sat, 07 Nov 2026 08:15:18 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/7] io_uring/cancel: drop sqd->lock while SQPOLL waits
Date: Sat,  7 Nov 2026 09:15:08 -0700
Message-ID: <20261107161514.2499962-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit cb0306c52ffae083a86fb283de67875ae7a9500e upstream.

An exiting SQPOLL thread calls io_uring_cancel_generic() with sqd->lock
held, and keeps it across cond_resched() and the sleep until nothing is
in flight anymore. A zero-copy send notification can't be canceled and
stays pending as long as the peer doesn't read, so the lock is held for
as long as a user cares to. io_ring_exit_work() needs it to park the
thread, and so do IORING_REGISTER_IOWQ_AFF and IOWQ_MAX_WORKERS. With
64 such rings sharing the thread, every iou_exit slot sleeps on the lock
and no ring gets freed for anyone.

Drop the lock around cond_resched() and the sleep, like the main loop of
the thread does. Each walk of ctx_list is still under one hold, and
nothing is kept across the unlock. The thread drops its io-wq, frees its
tctx and clears sqd->thread under one hold after the loop, so whoever
holds the lock and finds sqd->thread set can still use them.

Fixes: 63809137ebb5 ("io_uring: flush notifiers after sendzc")
Signed-off-by: Chris Mason <mason@kernel.org>
[axboe: adapted to the schedule_timeout() based loop]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: io_uring_cancel_generic() is in io_uring.c in 6.1, and uses a
schedule() based wait loop]
---
 io_uring/io_uring.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3392218887d9..866c6ad29e4c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3182,7 +3182,16 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		}
 
 		if (loop) {
+			/*
+			 * A request that runs in io-wq and doesn't end makes
+			 * each round come here. Don't hold sqd->lock for that
+			 * long either.
+			 */
+			if (sqd)
+				mutex_unlock(&sqd->lock);
 			cond_resched();
+			if (sqd)
+				mutex_lock(&sqd->lock);
 			continue;
 		}
 
@@ -3195,8 +3204,20 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		 * avoids a race where a completion comes in before we did
 		 * prepare_to_wait().
 		 */
-		if (inflight == tctx_inflight(tctx, !cancel_all))
+		if (inflight == tctx_inflight(tctx, !cancel_all)) {
+			/*
+			 * A zero-copy notification can't be canceled, and a
+			 * peer that doesn't read keeps it pending. Don't hold
+			 * sqd->lock while waiting for it, or whoever wants the
+			 * lock sleeps as long. No ring is used across this,
+			 * the next round walks ->ctx_list anew.
+			 */
+			if (sqd)
+				mutex_unlock(&sqd->lock);
 			schedule();
+			if (sqd)
+				mutex_lock(&sqd->lock);
+		}
 		finish_wait(&tctx->wait, &wait);
 	} while (1);
 
-- 
2.56.0

