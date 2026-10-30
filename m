Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338966;
	b=q6ngagc3nNSBMrD3DqoHekqD9HgA3sU0DXIHkPfnYRO3ZsAVWqH7d6jitZD+7p12g8KA
	 vFHDlUT4S5+ppohcITGLfAqblQPbefH6IkuCK+sfg7uP/oc+ljIjtkKo6MO9w+65+UPGX
	 xXKZ1y5KdcIN9Z35/Ho1leA+IEERIEYeqDjqm+nEzeLnHUbAckbMa3DRvhSaoVgYhHL/Z
	 Sz4RWqzUcmJSJ/EYKQaM5zdOMsrnaXsaqTlcfdUI/BEut5v21uHY5/trCY4UxzfrfsQtq
	 oq3szLEms8EYxNfVGE3VnxW7nPKqvDmIyupeVgiWG/Yl0hFtExWV16Dqoy4VeOPoaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6Eghy4HGIV34EY41zufCzUQfo19ToUU6k1Z0m6KPcBo=;
	b=YBXiV3LfsyjxV3VNDPkK1Ey46Q0aWUPngaq15OL/wf+3oaqop4Ysh9cOgeraJBlrfc37
	 irOuV55ixM+sCJsMctRiqk8sSzf0zlzaPCSEgFAJmiVX0vDfi5f00cEH1AgeKK7jrozQf
	 GhZ5rPgYtekojME/gqGiQ3oIH7++CQDhvT4HpTSAiys1a5Id1YZXNQ2RkRTX5o4GHEhpC
	 qUn/cWRrr68sk99kIs1YxOctS7ALJD323LeFgnnS+j9CRd3jcqXvdTmm3JSUTrTjvhA3o
	 aQGIdXzfPlAayjVY3O1ktPxSYVwUx995bl/vEwOEqNzrkhNAgZ3chCTEzjuyf2ESf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=onTA5y0h;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB1606A33B
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAB1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=onTA5y0h
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso335282eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338965; x=1793943765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Eghy4HGIV34EY41zufCzUQfo19ToUU6k1Z0m6KPcBo=;
        b=onTA5y0hK+8YD1yU48EkZVATBW2FA1Y8zlqLl81h5FMIQsPGe53QFhKGHn1DzfQRoR
         yBM7MlfYE2kfkK8p1y0ksr1rFcgQp2XX+qTtcu4qqGkPp47FgSPGXBdLVAoK+UBbWnSR
         NwbZqoJBmH2EypM8Q8Ys232tVctsfuP7qvyoUChHmWllQQge3x2sD/GjfUz+vFiCex4d
         i8sZqfKHCpvkj9WuDKFEeVREG8YiNKu5KU2pne47hhvFkIWKmW8a7h19lUeAATvJmdCB
         UFeg91ZebPlkgRp1dohli9x7RksavJpQ6mk2u+M9xWd0eCHzos3uje/m60ymGr81K3l9
         LSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338965; x=1793943765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Eghy4HGIV34EY41zufCzUQfo19ToUU6k1Z0m6KPcBo=;
        b=nV0oPjYSAZAHvRNORPC4DjJfWpeHGSvzyVDi8Bsw3JA7WaTw5zEyDlmydC/7F5pLG7
         Nvj2iLxJzzvNKHoopcPdTxW7VBYk7PaFH/hsehfzK+Eo2GGsLhGjhlG0oVJ6VMjMjJu8
         f83AC1tJEQAao4RXyxBZvGsEL0KRu7ThA51QaedLIBYAlKIUdKa251w4VIPPhh5ZP7oY
         q6ncIrRyg80de1J6YwW4Enz4touKLTbwoDXrwQyTT0b80Nld+0KtykwE8PvyHJihjE3l
         m2n9QzTXrzamR3rCScztPc7c8U7Ny79jmbj0IzuDgcRgUXRh3kagZgD1i5NNo2xFy+bp
         XRcg==
X-Forwarded-Encrypted: i=1; AKwUvBw9gi2r0DemCpOG/a9IRLU+NQzjRnzcQ5Y6B47tV2FU2FN+dDei4hBvFSBopko9ukxsqCrlePs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZz914LlSiTT8VsDay6o39H0tkTq512fgLpCutUJ5ZbsqG6tn1
	OOu/w0rRKRMmMfMT0/QESDrDuvENpwWlrCWD/+vSpypDZLD+pLSuPLdK
X-Gm-Gg: AYBFou2QmYKYkfDSBYVzeDbOe2EjjNdMTUjrzZQ8gJFo5wXtO04okXq3I/5sH5nMkMf
	BWmxKMwkE0kcW8Qk2oIj1P1m8rCx+WxVr/ol306WyMwMzRtuBdVVMjDBfVQ+FsnvJKg1bMGAS50
	paHTFv+dDwBrh9tWvKuej11LH6v4vuCvenN6e1+ZK8oc8AmswIVGGG8oPc8hTzMJCLG1F1ctN/E
	5HecRvtPUJSpe1JgzGut2UygK44i0R7xnoLiNDdfDa4TeGgQoxKU0yR0MRqfplfHCCkkSS5iCWz
	FXUvHRblVKWO1S/+1BqYEnruOoiMWvU+YVgw1bg7/UMkpukvLza/mHTjG1c36M29Dz3SXW0uJKq
	2jt0BZCpNeQyo2UgOL+Yt8JxV2LKwG0BaFBaQqWUvlP+bwGokMlCOE3tzLDR9HoWnZiW8RfBPO8
	WXp+J+DRXSoLLGEgFnIDRC7wtzE1CNbVtAYPk15cGEiJunDgquecI6EAb9zFefRQb/CByeNoYaY
	iTT28pQOinGvSG8qCzn8QgbenQHX9B6+u2xYU67aDQnjc5GBgGyCAWuDkkHeJ7e1t2FBGI7Yx/c
	9d1Ndjf/67j+NmtrtOnn4gojAGPqPcnEZzwFDG7NrqhkT8d8ACcCUHCeBg==
X-Received: by 2002:a05:7301:7306:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-36a4235f4a1mr2065782eec.9.1793338965145;
        Thu, 29 Oct 2026 22:42:45 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm4380426eec.26.2026.10.29.22.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:42:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: tglx@kernel.org,
	jstultz@google.com
Cc: sboyd@kernel.org,
	mlichvar@redhat.com,
	akpm@linux-foundation.org,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2 2/2] tsacct: keep task begin times stable across suspend
Date: Fri, 30 Oct 2026 05:42:27 +0000
Message-ID: <20261030054227.35453-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030054227.35453-1-dennylin0707@gmail.com>
References: <20261030054227.35453-1-dennylin0707@gmail.com>
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

bacct_add_tsk() derives ac_btime and ac_btime64 by subtracting a
CLOCK_MONOTONIC elapsed duration from CLOCK_REALTIME. MONOTONIC stops
during suspend while REALTIME continues, so querying an existing task
after resume moves its reported begin time forward by the time spent
suspended.

Calculate the begin time from the wall-clock boot timestamp and the
task's CLOCK_BOOTTIME start timestamp instead. This accounts for suspend
and adds the nanoseconds before truncating to seconds. Keep ac_etime and
ac_tgetime on CLOCK_MONOTONIC and retain the existing rebasing when the
wall clock is adjusted.

The new begin time can be negative: setting CLOCK_REALTIME is bounded
by CLOCK_MONOTONIC, which excludes suspend, rather than CLOCK_BOOTTIME.
A permitted backward clock adjustment after suspend can therefore put
the task's begin time before the epoch. Clamp ac_btime64 at zero too,
instead of wrapping in the unsigned field, and retain its positive range.

Fixes: f3cef7a99469 ("[PATCH] csa: basic accounting over taskstats")
Cc: stable@vger.kernel.org
Reported-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20130611200600.GA15168@redhat.com
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Clamp negative ac_btime64 values to zero without a 32-bit upper limit.
- Precede this change with the getboottime64() sampling fix.
- Add Cc: stable and rebase onto mainline d89e1d186ec9.

 kernel/tsacct.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 5c153106e642..48320684c7c0 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,7 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 now_ns, delta;
-	time64_t btime;
+	struct timespec64 btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
@@ -39,9 +39,11 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
 	/* Convert to seconds for btime (note y2106 limit) */
-	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
-	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-	stats->ac_btime64 = btime;
+	getboottime64(&btime);
+	btime = timespec64_add(btime, ns_to_timespec64(tsk->start_boottime));
+	stats->ac_btime = clamp_t(time64_t, btime.tv_sec, 0, U32_MAX);
+	/* Setting the clock back after suspend can make btime negative. */
+	stats->ac_btime64 = max_t(time64_t, btime.tv_sec, 0);
 
 	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode = tsk->exit_code;
-- 
2.43.0

