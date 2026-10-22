Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685918;
	b=hTxx4gKRmcJjg/vRHUoyIeg3/LP0kIysYikOFaNZXK8Rez9TIjud+Gx3HloREabGqNBY
	 Vb+UvwsSUSR0Z7NRPQWpSrmEHlDRFN0IAZTK5g8bIkDIXPs7fZ3zLFd9V8536rg3SiD1d
	 WyiC5a1a7oBxu7X9eYMeRGPZTYEJG6bGO3+hZ4pEeS9jtHa/jnlCM9slyLhbpFDojvIlV
	 oDpcvOzFLS1a5Bm7aVP583S0fQ9Dni0/ahc4E3XMaUVJGryBI5gzCFHb3R1LbNW/bRkL3
	 V7OzxGrWBGSIAEHeKP7puccrOYtMBXW/cYARR4meUX3IWbyC/s0lrbNOu6Hp6aMxM6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685918;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dwTDr5uc/SBBJPDGJ0dO1kirHSFGDURAgKoYw4Q0Cy0=;
	b=pIJIeTBgs0Vq+WiCU9kZANUsfpcT/yVpqPhkZIL6gwceldp+Bo2GQ8mDY/QhT2BNA2fd
	 L08DVH7pcBcvEcIspA17zgzlh90Kkig7XyFS7bwf3QebdpdbQB/boC2iWzyNXqYNQZ5aI
	 NWtPYsQBVhnjtzyWHgAW0HjNWUAIRCoWQTUDUS+fr2qPrVSnlaiAcJtPbdYbCNEQWFaGK
	 v7OOkp8OnITO5o2ZaOjM3IDP14atbDyb8drlhZDRuOYpfDp1fKTTsw044h3i0SXQwgnSR
	 ZhfNo1ENKa6CfcPRoL5i0IpplXW3e+jsGAAyab1RYd8dpm3CZzsevP+2bxPO7TtVGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=hnBxWGlT;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ljxTLPsy;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C84606A31B;
	Thu, 22 Oct 2026 16:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C84606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=hnBxWGlT;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ljxTLPsy
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792685896; bh=dwTDr5uc/SBBJPDGJ0dO1ki
	rHSFGDURAgKoYw4Q0Cy0=; b=hnBxWGlTyQuooPr0ZFbZ+KMEzkFia3onbcoN2jCTW2xwxzL1Un
	KeZD00xYSN1uQCaUv63GsPDNRKAuhSypZ3lziCHfBfnaGPEoxlERwexFed3vX8Jvt5JMqJSOdks
	pzPIdb0aOhlhAjg0Wu9Is/7SayLCO3d0YJ38yX0AJWBvJ3jQcE9G31NqxbNbf1SFUKMkAsl0PZP
	HypwlTHeSUVxLAf4mTR5qjhlAKvfzJFAJT0tiaBvuC0L+2Dlx1m0bEd5TJF3Be1I6HtB759RL0o
	UWqTN77yk0jaVu2471rA18Ykh1izapjf6zV7aXYmJxKfebNy6hmDKV5o8X1l37zagPw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792685896; bh=dwTDr5uc/SBBJPDGJ0dO1ki
	rHSFGDURAgKoYw4Q0Cy0=; b=ljxTLPsyJLqdmlINwd+ls8V2oDnuBN9Wy6pmiRO0kwPisXMwqc
	bGzfegTe/qcnRqDPIV12HBAyGZR8pa69oBCg==;
Date: Thu, 22 Oct 2026 17:18:16 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Hungyu Lin <dennylin0707@gmail.com>, bsingharora@gmail.com,
 yang.yang29@zte.com.cn
CC: akpm@linux-foundation.org, wang.yaxin@zte.com.cn, wang.yong12@zte.com.cn,
 xu.xin@linux.dev, jiang.kun2@zte.com.cn, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_delayacct=3A_Preserve_de?=
 =?US-ASCII?Q?lay_extrema_when_aggregating_taskstats?=
In-Reply-To: <20261022160648.37411-1-dennylin0707@gmail.com>
References: <20261022160648.37411-1-dennylin0707@gmail.com>
Message-ID: <8E09DEA9-9161-4E32-88BA-DC4147DB3849@mainlining.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 October 2026 17:06:48 BST, Hungyu Lin <dennylin0707@gmail.com> wrote:
>delayacct_add_tsk() adds each task's statistics to the accumulated TGID
>statistics, but overwrites the delay maxima, minima and peak timestamps.
>Consequently, the last task determines these fields, and a task with no
>recorded delay can erase an earlier task's peak despite a nonzero total.
>
>For example, a four-thread process has a worker writing copy-on-write
>pages and a last-created thread with no WPCOPY events. With the group
>stopped, getdelays -d -t 49 reports the following before and after the
>fix (WPCOPY excerpt, spacing compacted and timestamp column omitted):
>
>Before:
>  WPCOPY count delay total delay average  delay max  delay min
>          4103     5163661       0.001ms 0.000000ms 0.000000ms
>
>After:
>  WPCOPY count delay total delay average  delay max  delay min
>          4101     4680983       0.001ms 0.049292ms 0.000208ms

Hmmmm... Looks feasible enough, it's a very tiny result.

>
>The timings vary between runs. Before the fix, the zero extrema disagree
>with the individual worker's nonzero values. After the fix, the group
>extrema match the largest maximum and smallest nonzero minimum across
>the individual threads.
>
>Keep the largest maximum and its associated timestamp, and combine the
>minima with min_not_zero() since zero denotes an unrecorded delay. Apply
>this to CPU delay and the seven delay types handled by UPDATE_DELAY().
>Single-task queries still start with zeroed statistics and retain the
>task's values.
>
>Fixes: 658eb5ab916d ("delayacct: add delay max to record delay peak")
>Fixes: f65c64f311ee ("delayacct: add delay min to record delay peak")
>Cc: stable@vger.kernel.org
>Reviewed-by: Bradley Morgan <brads@mainlining.org>
>Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>---
>Changes in v2:
>- Add a getdelays -d -t before/after example to the commit message, as
>  requested by Andrew Morton.
>- Add Bradley Morgan's Reviewed-by.
>- No code changes.
>
> kernel/delayacct.c | 23 +++++++++++++++--------
> 1 file changed, 15 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/delayacct.c b/kernel/delayacct.c
>index 479e860aff70..ea1424524654 100644
>--- a/kernel/delayacct.c
>+++ b/kernel/delayacct.c
>@@ -12,14 +12,18 @@
> #include <linux/taskstats.h>
> #include <linux/sysctl.h>
> #include <linux/delayacct.h>
>+#include <linux/minmax.h>
> #include <linux/module.h>
> 
> #define UPDATE_DELAY(type) \
> do { \
>-	d->type##_delay_max = tsk->delays->type##_delay_max; \
>-	d->type##_delay_min = tsk->delays->type##_delay_min; \
>-	d->type##_delay_max_ts.tv_sec = tsk->delays->type##_delay_max_ts.tv_sec; \
>-	d->type##_delay_max_ts.tv_nsec = tsk->delays->type##_delay_max_ts.tv_nsec; \
>+	if (tsk->delays->type##_delay_max > d->type##_delay_max) { \
>+		d->type##_delay_max = tsk->delays->type##_delay_max; \
>+		d->type##_delay_max_ts.tv_sec = tsk->delays->type##_delay_max_ts.tv_sec; \
>+		d->type##_delay_max_ts.tv_nsec = tsk->delays->type##_delay_max_ts.tv_nsec; \
>+	} \
>+	d->type##_delay_min = min_not_zero(d->type##_delay_min, \
>+					 tsk->delays->type##_delay_min); \
> 	tmp = d->type##_delay_total + tsk->delays->type##_delay; \
> 	d->type##_delay_total = (tmp < d->type##_delay_total) ? 0 : tmp; \
> 	d->type##_count += tsk->delays->type##_count; \
>@@ -174,10 +178,13 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
> 
> 	d->cpu_count += t1;
> 
>-	d->cpu_delay_max = tsk->sched_info.max_run_delay;
>-	d->cpu_delay_min = tsk->sched_info.min_run_delay;
>-	d->cpu_delay_max_ts.tv_sec = tsk->sched_info.max_run_delay_ts.tv_sec;
>-	d->cpu_delay_max_ts.tv_nsec = tsk->sched_info.max_run_delay_ts.tv_nsec;
>+	if (tsk->sched_info.max_run_delay > d->cpu_delay_max) {
>+		d->cpu_delay_max = tsk->sched_info.max_run_delay;
>+		d->cpu_delay_max_ts.tv_sec = tsk->sched_info.max_run_delay_ts.tv_sec;
>+		d->cpu_delay_max_ts.tv_nsec = tsk->sched_info.max_run_delay_ts.tv_nsec;
>+	}
>+	d->cpu_delay_min = min_not_zero(d->cpu_delay_min,
>+					tsk->sched_info.min_run_delay);
> 	tmp = (s64)d->cpu_delay_total + t2;
> 	d->cpu_delay_total = (tmp < (s64)d->cpu_delay_total) ? 0 : tmp;
> 	tmp = (s64)d->cpu_run_virtual_total + t3;
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
