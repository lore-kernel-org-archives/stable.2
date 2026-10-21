Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594475;
	b=TS6C9OE5PS499nigahRZFqK3a+za1TxSHNXkvVfiwmltcNCdBB5Lr12tIlH6MBvGNkYv
	 lpu0A/88R0grOXLBOmHQ/+hgI3tZ4UpeVI1OMn9wE+WNBEswQXfhexiqtm3Flfw7jVCXV
	 rAeyB5hQn+cNaO0/H2w6sFdXZ6keK4RJaG454HyKKW2qc24dHruXLyV6kqKecLzU1lqiu
	 FMVm8iSQWmYivKqXa0DeSkTxzrujKSySI0nGSPvUyacP4q/ExcutQF96uHjmeqNeq7bIV
	 aQqA8wgINiReD9FzyJPfCASWUo1epnbSWg18Ia6C7dW02vutZd4LfZy7gcwjvEhKqPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594475;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X5JRoySFiY6bkHp0BdDDpNRJ+W26NwqLDrqSns3Y6zI=;
	b=z9oDtTZCTorRWWNt/ofHHI481xpFZ/Hdqv/j/kpW8aqqjSAHXKA4I4VS+QmV9XvCLHua
	 JtPFxIeD8Bgfc6z3JnfaUVPOoZ/ILm+Ab8aIv8Qz9iMQdDbFdu/Z1X5PWBO8KwdWif6GU
	 nL/I4Qu22gNhEbjLi72u1ir0F1k53jVNqBF+QsUT+WAToiMLGTEbjWf5hkLP3H1jTlaW7
	 fZ8y/AQJr3tHX8QgmBjiKXe09EF1aW6Pr4GTkRa8M0d81MYZ8WrjsQhTBSbLL4KtPZTPU
	 GwZ+FUJ46vnPp3KWAFqRQHs3M3g6k4I9MGC2D1vhnz8UiZWXfVDR2PDicKm/YMAL3dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=n2U6CiE9;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=9lMD2A8a;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427160A2607;
	Wed, 21 Oct 2026 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1427160A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=n2U6CiE9;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=9lMD2A8a
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792594466; bh=X5JRoySFiY6bkHp0BdDDpNR
	J+W26NwqLDrqSns3Y6zI=; b=n2U6CiE9iTrnhHOw7EKkWmJmDj+RpeRKYGzH+/1PkQshoM9I87
	fqBaKl6srnp4295El7b802Z/6NFUs9ixqH+vOaHIMOKon3fgq9J2Fk7RH02Ha7PnfgXiV5afWgG
	QsIfeshmbKtSEVVHsIOPccQL7XsEsZbWbobInssXpPrDVwOoGsCT+q7Ag2nZzeZc6Nbpbi3gbN1
	HP38r5ZA4pnlP/fns3vxyDmX5sPt0CHTYxitLqYLQ5v2g5/UlwdYxhLUCgCT3y/449f8uQd8AcL
	GYefFd3OJjiG/2h7AUbFxydXTHqadRW4EU6ZR8kDpqkQTb2J0Hr6L6GQkTVIT+i7SPQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792594467; bh=X5JRoySFiY6bkHp0BdDDpNR
	J+W26NwqLDrqSns3Y6zI=; b=9lMD2A8aUGghbk9cB1hpgvBq0DcYdLbYy1r70IkaU/DfbGhzP5
	ox2kxhlrcatS7ippvZRPxuQFfeh7nRo+4ABQ==;
Date: Wed, 21 Oct 2026 15:54:27 +0100
From: Bradley Morgan <brads@mainlining.org>
To: dennylin0707@gmail.com
CC: akpm@linux-foundation.org, bsingharora@gmail.com, jiang.kun2@zte.com.cn,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, wang.yaxin@zte.com.cn,
 wang.yong12@zte.com.cn, xu.xin@linux.dev, yang.yang29@zte.com.cn
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_delayacct=3A_Preserve_dela?=
 =?US-ASCII?Q?y_extrema_when_aggregating_taskstats?=
In-Reply-To: <20261021010022.85881-1-dennylin0707@gmail.com>
Message-ID: <B170F35B-5CEC-4EA8-AA85-92E552F7D74A@mainlining.org>
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

On 21 October 2026 02:00:22 BST, Hungyu Lin <dennylin0707@gmail.com> wrote:
>delayacct_add_tsk() adds each task's statistics to the accumulated TGID
>statistics, but overwrites the delay maxima, minima and peak timestamps.
>Consequently, the last task determines these fields, and a task with no
>recorded delay can erase an earlier task's peak despite a nonzero total.
>
>Keep the largest maximum and its associated timestamp, and combine the
>minima with min_not_zero() since zero denotes an unrecorded delay. Apply
>this to CPU delay and the seven delay types handled by UPDATE_DELAY().
>Single-task queries still start with zeroed statistics and retain the
>task's values.

Hmm.


>
>Fixes: 658eb5ab916d ("delayacct: add delay max to record delay peak")
>Fixes: f65c64f311ee ("delayacct: add delay min to record delay peak")
>Cc: stable@vger.kernel.org
>Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>---
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

Makes sense, thanks

Reviewed-by: Bradley Morgan <brads@mainlining.org>

> 	d->cpu_delay_total = (tmp < (s64)d->cpu_delay_total) ? 0 : tmp;
> 	tmp = (s64)d->cpu_run_virtual_total + t3;
>


--- Thanks!
"I'm not a very positive person" - Linus torvalds
