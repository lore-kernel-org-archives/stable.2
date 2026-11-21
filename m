Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296725;
	b=vREReLb6pfG/jzIbiBUvLccElllAC4QWa9GuwQhlGX6ZsDzI7D2nPR23vX07YkndfzkU
	 aSzsAHnkzUSY2hUIdlT+xmMwdzp3PkO5mtmntgZzdun1POcwNlU5a+zkEiS7MKtbAzhAp
	 U701o8BV/4WQpQhUqyH7bZKtStIuBDNJRq1P35ZjoiIbqKoKrEKlDEGZRKPQ3/iWj9OYC
	 du5fayz97sWH+R9frEtWWuHyAyaChzgnZis/KRZRdb+lsrY1Bj7Amn/VKKUiJcEPOpMMm
	 Qz3Bj3BiUoYJMudUix6qSpND3pMuBLRyR+n++FCFJxxeGrw+gFUaRVr9vxNRNMaZ+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5KPIsVox40t98CGZBUpYGqTBjwhu5sh6eKsDiesWnNc=;
	b=qHjNZuZSngw8Uzl4iUPg3fmiNzkX0xvPwZVt1Pj1K8tRLnsBAC0otmSleDUgsE8jFbHf
	 64XsBBkPwV90bsi9MNQYjVrxS4XD+rtum5X3oXKp1Yj5dnZq8s19pqUxLL2NXzByr9Kdr
	 USNu4PUV5pkxsE65VIaO7BuOx/1G8T8xRkAgRN3wbwttIOryhqaAZTu7bsUsSsypUxNdD
	 5cxihvNKq7WZ9/V+jtEG7akir5J3wF2sSSBpbWZ21bIZqzvRBz6Kzmy0wuOKuFmmMB0a2
	 z0DCcxWbc8xJEWj587lqRohT116UNJwOioQZcJ/oNZWKfB9EUubPu09O2bL6iQ+IGPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WJHXHGRp;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324A606A33E
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D324A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WJHXHGRp
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ddef424972so1733515eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296723; x=1795901523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5KPIsVox40t98CGZBUpYGqTBjwhu5sh6eKsDiesWnNc=;
        b=WJHXHGRppZVjjmniQhONyOkBverI1lxLZTgp/plYmu7nu7B3jsD0HB2n1TlQO/mlhh
         8fhfxVPW9DpVME4pkoS5ZFH+FEgGJR/rg0rMg42jJwUouIbeuNeIgDlQLE+t51aguv+k
         vJ/FKOlAVSrJ6WxBj/BM2AGYSOdV+G1TYECLSV4yPbxOG/08Bc21259u5vjYM1Gh+UYu
         UXvsdUDYip15xJaq68lLWBy63D8V+nR2OcPEC94hCVAGml8XAh/BQJCrjah8+DxmsZJ2
         P4YYYbgiPm6w+jYvr24Tk0gqUh8T1nGpQZAZ2dsaO/j5h8Q8ITjeWv+ofrosrMibuZn6
         xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296723; x=1795901523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5KPIsVox40t98CGZBUpYGqTBjwhu5sh6eKsDiesWnNc=;
        b=Rsbn6Wp7HbRZjM6TErYl/w+NeEYV9ZgDGZEDe4JUth2OntsrjgkxpN9jN3vSv/3mK9
         tDpPD5nqyVY4aMQsnqPf40Uo9HMXjlzjuZuYdVpizUU9GEKak1fzQkdNpsaZr8IItRsR
         EUQmdt23643lIoxDifX964h0l+BH8kASx7PhEaQlkoqC9rmJCfyIvfs51aa/mi3C+5d/
         8+axHp3IeftSdsLKzn1xYWaGnngfNq2KG1WmPYuB69bI1aaY8XLXeHm8nAS38J6K+ioP
         hK2T4uDqNq90eJmZ1N4A+5y3SI+aye26God9ycPxIrPfqXBq+uicqsThCjasu+IJuqe/
         1Cvw==
X-Gm-Message-State: APuU4Z8yWyaZfChXbcmibWRvctmqSyv3m0D6DP+2Omr9dQDYIiRvdELH
	wvUN3w98bn58ubpm2Tl/3prHO5/y4Fw0ksUT1CV/y9ayZQO48hKdvUcpqhnPjnWJa1NHUnDKz2+
	G5oFdTBw=
X-Gm-Gg: AZFdTZduBX//Xi6Ihj2lI03klUCIVN+dv4uOTB8jIhJ2h7CqCvT9cxXgwpxu7GiKsjb
	c1cY0wnXkQ1j3CWkfkKYllJiEviGZabn58QSSUS9soSgqozrf+PAaXiZWlciNmHs9gm6N8M5xmF
	EFpeMojfwyr1GOns4TRhI9C4MaX3G6FJnMtTyWNSULOy9WkMG3zXGTjWFLQr1om5bLUiW6AWAk6
	g5GFv3vOGqNbs1ThTN/r9mZy4eODLTfR2bIbA9BW6jYdyWN3s6Erh1qJHNOgwiHn25JcV8JLHYR
	TNmoK/4EDqoikgTiPze0JGY/FiRe2K5zpcaBXvvUZmm4uYoMko03zSuIgYk3cV8hnOfM3xiM7SF
	tyglFYUd1utdJ3ahj2mebajMVcPD5Z3xZA58alkS4XpGeq4prHwftNhuXt20P7QHu++ICvyWffn
	vMG1E17W2eYAM+OgpmtSpD7iUEUED3lNjD+cMgjmpoo2+lZbgKXvhj65Q0Z0kTj/lFK7mzKJlWh
	ap4by/m8czfQvWwlzHImLGDIoikHldH5GZEZP0FUjPgkFQjN4yGB+6tYgx2iq62vOAA/qgv7ry/
	K4Z59+rWFTZxne1whkc2d78SfsPwUZapYQOyTJPNABRYyO6O8FOQh3istQ87XlQ3Wm2EpLBWVdV
	abIeHEtMFn6MSq0lHzBV4fUQ23tPiceVTWDgRcM/OZ2cfUH1feOvLgW2Hmw==
X-Received: by 2002:a05:6820:5048:b0:71a:e389:9270 with SMTP id 006d021491bc7-71b39583502mr5017630eaf.79.1795296722739;
        Sat, 21 Nov 2026 13:32:02 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 5/9] io_uring/io-wq: show stuck workers rather than WARN on a slow exit
Date: Sat, 21 Nov 2026 21:31:50 +0000
Message-ID: <20261121213154.1790334-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

Commit d4912d6440bf6d255e1fa1c360c8ddb39d0e01bd upstream.

io_wq_exit_workers() triggers a WARN_ON_ONCE() if it has waited more than
IO_URING_EXIT_WAIT_MAX for the workers to exit. That can be triggered at
will, for example with an open on a FUSE mount where the server never
replies to the lookup. The worker can't be canceled, and the exit waits
until the server goes away.

The stack trace from the WARN isn't useful either, as it's that of the
exiting task and that is always the task exit, exec, or SQPOLL thread
exit path. Print a message and show the workers that are still around
instead, that's where the interesting stack traces are.

Reported-by: syzbot+b0d54b9e81de55179e47@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io-wq.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 6b9395060262..358f32888a85 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/debug.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/rculist_nulls.h>
@@ -1444,6 +1445,22 @@ static void io_wq_cancel_tw_create(struct io_wq *wq)
 	}
 }
 
+static bool io_wq_worker_show(struct io_worker *worker, void *data)
+{
+	sched_show_task(worker->task);
+	return false;
+}
+
+/* The exit path is always the same, show what the workers are stuck on */
+static void io_wq_show_stuck_workers(struct io_wq *wq)
+{
+	pr_warn("io-wq: %s/%d stuck waiting for workers to exit\n",
+		current->comm, task_pid_nr(current));
+	rcu_read_lock();
+	io_wq_for_each_worker(wq, io_wq_worker_show, NULL);
+	rcu_read_unlock();
+}
+
 static void io_wq_exit_workers(struct io_wq *wq)
 {
 	unsigned long timeout, warn_timeout;
@@ -1465,8 +1482,8 @@ static void io_wq_exit_workers(struct io_wq *wq)
 	 *
 	 * where completely overloading the system with tons of long running
 	 * io-wq items can easily trigger the hung task timeout. Only sleep
-	 * uninterruptibly for half that time, and warn if we exceeded end
-	 * up waiting more than IO_URING_EXIT_WAIT_MAX.
+	 * uninterruptibly for half that time, and show the stuck workers if
+	 * we end up waiting more than IO_URING_EXIT_WAIT_MAX.
 	 */
 	timeout = sysctl_hung_task_timeout_secs * HZ / 2;
 	if (!timeout)
@@ -1475,7 +1492,8 @@ static void io_wq_exit_workers(struct io_wq *wq)
 	do {
 		if (wait_for_completion_timeout(&wq->worker_done, timeout))
 			break;
-		WARN_ON_ONCE(time_after(jiffies, warn_timeout));
+		if (time_after(jiffies, warn_timeout))
+			DO_ONCE_LITE(io_wq_show_stuck_workers, wq);
 	} while (1);
 
 	spin_lock_irq(&wq->hash->wait.lock);
-- 
2.55.0

