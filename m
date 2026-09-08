Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49629554096
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879896; cv=none; b=pj1E1DyJcVamxQOBaDySqFgwEArydxBM06LK2h/K80AJhdXzVWiId+xGmvA0AsNdJdCFFXFs12IvuqczeijY9mEwKpXgFSXGaGC1Et14wB3NBY49Waags8gRIyp13ylSjE2wyPgMlBy+iy6D9Epe1G+0ZbvI+PrkdjSJu3/2M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879896; c=relaxed/simple;
	bh=/ot3bEfw5n53CkqAonvZddrjr4a61Tw39SIgkb+Vx+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw2GEuKQ36+uYEn81/YSFQhegdZinRRGICU09pccQ0UlwojVs9IUzrDsNsLQy70yV+ykPPM4bpT7gNBmRZwptpNf64pbmK5KYCQi66VNiYdTsxr8ALPGW/ikh9aXk0d9sbiFZwAEetseFUFG8xYf6pOYb0Uyf11LEIMqJ1fv/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpT+GGs1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8mSC90W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpT+GGs1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8mSC90W"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1MhO3320649
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 15:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y2IJKD/wc07ehSuWDkX+So12eTaGvIek1NA45XQQAOU=; b=gpT+GGs10MCSsy78
	7HmXhE6f4W0TM8Q2WVlz0dLOBmyWITlcXiLSMZMgz6NWBUgK7XgIUfLbjZqRSqe2
	e2+TJzXDyQ9Yujk/BeUbBwqZwfL11Gt2v5SzeeDTaQeBWkGOFjaNngY1k6narjCJ
	MkoRDTGXnyrwFpXFj7XiwJV0mBtD0OOtR3T4KO0Y5fSuKs/BgKH7dD3ciA1O124z
	Qn3CQBB1YwK9r9XEICXmbXLeTZsI4YfxzfHBRDtZHRIMyqD2IacFCun1AxfDtD+Y
	MB4lMmMjB8I8ZY/kx7pxbdrrxWHn/w48b8C3VnJx0Vj+S3oLz02bf+lu1Ucs0deF
	0t3dkA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwm5qp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 15:04:45 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f4e52682f0so6845535a34.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788879885; x=1789484685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2IJKD/wc07ehSuWDkX+So12eTaGvIek1NA45XQQAOU=;
        b=g8mSC90WC2jYnSLws0VQvKA+/+p27SSlwGb98lSiwCteWLYtiEqjflfAeN/rCOe7tG
         hIAbR7xslnQ6j3A2rJ5PyXP9qDdLF8rt2YyxWgj9ZKskH7AGC5PjeGqduMMp3QeujYMR
         XVz4QvLWWYf1Or3toly5RwRHDwJnC9apt1Jqc7/cJW4TMG0EI8XJA5qXd1ucF18KTVxF
         Iss0kYt6dl/ob8yy41UbSTn18FSyd9XKNmX463Td+eVUlPpkelSOHq30f6HiQ0iV92TO
         b18aQ7ivLL6Ha9gUHAw10/cmLONUtfVb0zr7opODTzPsw8lx0tNPavH3PLbDjQi3B+Te
         1JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879885; x=1789484685;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2IJKD/wc07ehSuWDkX+So12eTaGvIek1NA45XQQAOU=;
        b=qvwsSOICYothKn2/VjA9xlr07lUefUVlASqiKNFPmFSR/C7E2JxXvnRQ2h1rUn74yQ
         FsI3HgRsB3CFCn51xLHcDMV16hjMY7hD1NhZ0FRM79eIYFrsJ8H8AuJ9svAkqtXSLWqQ
         BCMc6ZEgx/oniMHudZTIoPelnux17g6F5+2QAkBLN9yvp2lmxl30RVp8hYtO3ZebGAhA
         KBU1kqkEr50uoA6mxZBLiOBe3atSY32eDXeqgUqPFzeev/YR/zp3bmT8xKwJUcmG6Abi
         t6GEUUcwVPA5fPB4lN2MFRt/IUBn7wxZTpLWd4we5WXxupwsSYNULdN7WfHdctkSddY3
         CqAw==
X-Gm-Message-State: AFuF++mjEq0XLc9nQupbUa+SeBYP258qgSQRZdJijOF+rQ8tSUYl65eN
	APC9wgO7sPi8yr+m65bXRFf1bNaPMqXZ8NilHUbhw9QxZCyzn444+rBdJhMZtYK73UrtJlS+uwU
	n3E4xvQV1YVtH71KyfHwvNBvyInza3Rn9Uue1nUeU5LSryjzcjyr2EcnFt4s=
X-Gm-Gg: AYBFou3DEjKIha2qZA8H9KpaQIZ5M18r6HLailwqU+QOmR8ZaH4zhECNnt66ZkWS4wE
	LUHsurZ3qN6g4Uf84CMdhPF8mYc/ZqhZHQqcr76pOwfvBY4+9hgoWr4a68t4Ym4C4qKT57XqGNH
	mFZ43ArOKG0LXTWxBMTRxdGfuV3jZMeHQE5ee1kLdNDxcLi/Acwgfzq3MgxGkLw3Cv2N6qP27oJ
	hthMPvblnnFQrbFRapbByLEMTBo0Hpj+KjPJIlf0v5zPFXVzF0HnXVQaWdfkIUgV/zmkKoby5ak
	rfNN1PNIBiw///3eCMN+89n0OB2l9RN/J8YxXwLYKD8XdbYuu43Tvq+/+l0jSVT4oY839Sf/L04
	pz8UEC/587kCMBrJXG7prphkXVON9nG0CAITxgPwiB09UBawPBv+X/hzpWXZ0
X-Received: by 2002:a05:6820:1515:b0:6b7:46fc:1d9 with SMTP id 006d021491bc7-6b746fc02damr16325286eaf.56.1788879885108;
        Tue, 08 Sep 2026 08:04:45 -0700 (PDT)
X-Received: by 2002:a05:6820:1515:b0:6b7:46fc:1d9 with SMTP id 006d021491bc7-6b746fc02damr16325213eaf.56.1788879884446;
        Tue, 08 Sep 2026 08:04:44 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm36456508eec.12.2026.09.08.08.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 08:04:43 -0700 (PDT)
Message-ID: <a5534789-351d-402c-b7a0-bdd98b68fcd3@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:04:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ath9k_htc: fix possibly missing barrier in
 ath9k_htc_rxep()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260803104424.25880-1-fourier.thomas@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260803104424.25880-1-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6aa0240e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=IsJrftOSqqLFh19Q65YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MiBTYWx0ZWRfXzt9jlDznQmKd
 n7KmgqZKbgktXteOFb8XUGG7iCRvZXxwLRqyoXRrFMaV8qfcBQVzM1ooH13wAIhJxOsoyN2FOw3
 hWGpa95akj1F0f/F/z7cdvWbKGi1eZP7xIQvaa9BhH0d4Rx8lsXytEoINfP8H6DB/W8AT9lqdtT
 5FT2Ypds0IHD9pm8CEytoDpi0HfvCwRMt683nN6kltjEXYCpxPRyifH7L2Z6cgQQQ/bwzqJTVIv
 EFNyfyEb8t1D4NUtK0m15oCgz/KNEjOQ8czWIsQTtX4gzHZ3rUCG4ylQCS/pOpxL2xX0AGi3Lwr
 90wueC8clAcFq/5hSqKQJM/cd02NNF3CdYfUAxLg/xnll6d66PXEEXB3eCK97OvBYivlP4SmtfN
 wEJD3VTntUVO59I/kPC7TCb6X2urqswifeqhYqypsUjkm61X4mS6GH2k0ovBbvbGxnQUlq+M1Ls
 e8sGK3WcjJQA/yV392w==
X-Proofpoint-ORIG-GUID: RqD8ZpetKRTDZBKHQhbnwihZPNuGpj5S
X-Proofpoint-GUID: RqD8ZpetKRTDZBKHQhbnwihZPNuGpj5S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MiBTYWx0ZWRfX/h+1GZ9cILSF
 H5dlvJWyhONbwzeNt5TEEnkAUQJhzNATil+eBU+E1U6cgeK0JJ1heW/Eye5t1/HcSdnlV0HnvsR
 8VOzvlmjlE0QlP8vy1i9B39gjesPdZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080162

On 8/3/2026 3:44 AM, Thomas Fourier wrote:
> ath9k_rx_init() initialises the rx buffer and its lock then calls a
> memory barrier and then sets the priv->rx.initialized flag. However,
> ath9k_htc_rxep() reads that flag and imidiatly takes the lock. This may

s/imidiatly/immediately/

> cause the lock to be taken while not fully initialized.
> 
> Add a barrier to prevent speculative read of the lock before checking
> the initized flag.

s/initized/initialized/ (or initialised)

> 
> Fixes: b0ec7e55fce6 ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_rxep()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> index bed7ea2425a0..97d61f3f0aad 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> @@ -1145,6 +1145,12 @@ void ath9k_htc_rxep(void *drv_priv, struct sk_buff *skb,
>  	if (!data_race(priv->rx.initialized))
>  		goto err;
>  
> +	/*
> +	 * Make sure all the ath9k_rx_init() memory writes are visible before
> +	 * proceeding.
> +	 */
> +	smp_rmb();
> +
>  	spin_lock_irqsave(&priv->rx.rxbuflock, flags);
>  	list_for_each_entry(tmp_buf, &priv->rx.rxbuf, list) {
>  		if (!tmp_buf->in_process) {

I decided to run this though my review agent, which has the following analysis:

### Overview

The parent commit `b0ec7e55fce6` added an `initialized` flag guarded by
`smp_wmb()` (writer) + `data_race()` (reader) to prevent `ath9k_htc_rxep()`
from operating before `ath9k_rx_init()` completes. This patch argues that the
reader side is missing a corresponding `smp_rmb()` barrier, allowing the CPU
to speculatively read `rxbuflock` (and related structures) before the
`initialized` flag check is confirmed.

### Correctness Analysis — **This is the central question**

The claim is that without `smp_rmb()`, the CPU can read `rxbuflock` before
the flag check. This deserves careful scrutiny.

**The actual memory ordering concern:**

In `ath9k_rx_init()`:
```c
spin_lock_init(&priv->rx.rxbuflock);   // writes to rxbuflock struct
list_add_tail(...);                     // writes to rxbuf list
smp_wmb();                              // store barrier
priv->rx.initialized = true;           // flag store
```

In `ath9k_htc_rxep()` (before this patch):
```c
if (!data_race(priv->rx.initialized))  // flag load (unordered)
    goto err;
spin_lock_irqsave(&priv->rx.rxbuflock, ...);  // acquires lock
```

**Problem with the patch's reasoning:**

The `data_race()` annotation means this read is intentionally not ordered —
it is a deliberate racy read. For the `smp_wmb()`/`smp_rmb()` pairing to
work, the flag load must itself be an acquiring/ordered read. `data_race()`
is not `READ_ONCE()` and does not constitute the load half of a barrier pair.

**The correct fix** would be to replace `data_race(priv->rx.initialized)`
with `smp_load_acquire(&priv->rx.initialized)` and drop the `smp_wmb()` on
the writer side in favor of `smp_store_release()`. That gives a proper
acquire/release pair. Or, simpler: replace both the `smp_wmb()` + plain store
with `smp_store_release()`, and replace the `data_race()` read with
`smp_load_acquire()`.

Adding `smp_rmb()` after `data_race()` is also questionable because on
architectures with weak ordering (e.g., ARM64), the `data_race()` load of
`initialized` can still be observed as `true` via a stale/forwarded value
while the `smp_rmb()` fence only prevents reordering of subsequent loads
relative to *prior* loads — but the load that matters (the flag) was
already done without ordering guarantees.

**In practice on x86:** The `smp_rmb()` compiles to a no-op (x86 TSO provides
load/load ordering). The concern is real only on weakly-ordered architectures
(ARM64, POWER). There `data_race()` + `smp_rmb()` is not a sound barrier pair.

### Specific Issues

1. **Wrong primitives for the problem.** The correct idiom for "publish a
data structure, then set a flag that a reader checks before using the
structure" is:
   - Writer: `smp_store_release(&priv->rx.initialized, true)` (replaces
`smp_wmb()` + plain store)
   - Reader: `if (!smp_load_acquire(&priv->rx.initialized)) goto err;`
(replaces `data_race()` + separate `smp_rmb()`)

This is the standard kernel pattern (see
`Documentation/memory-barriers.txt`, "RELEASE-ACQUIRE" pairing). The
`data_race()` annotation is semantically wrong here — it indicates "I know
this is racy and accept it", not "do an ordered load."

2. **`data_race()` semantics mismatch.** `data_race()` suppresses KCSAN
warnings but is not a substitute for `READ_ONCE()` and provides no ordering.
The comment in `b0ec7e55fce6` used `data_race()` to suppress KCSAN since this
is a benign early-exit check — but that means `smp_rmb()` after it has no
memory ordering contract to stand on.


I ran the above through another LLM instance to check the analysis:

Issue 1 + 2 (barrier primitive mismatch) — Partially valid, but the framing is
overstated.

The reviewer's core claim: data_race() + smp_rmb() is not a sound barrier
pair. This deserves scrutiny.

data_race() is purely a KCSAN annotation — it disables the KCSAN
instrumentation and compiles down to a plain C load. On ARM64, the sequence as
patched is:

ldr    w0, [initialized]     // data_race() → plain load
cbz    w0, goto_err           // branch
dmb    ishld                  // smp_rmb()
ldr    x1, [rxbuflock]       // spin_lock_irqsave

The dmb ishld prevents loads after it from being observed before loads before
it in program order. Since ldr [initialized] is before the dmb ishld and ldr
[rxbuflock] is after it, the ordering holds on ARM64 in practice. The
conditional branch plus smp_rmb() does close the window.

However, the reviewer is correct that the idiom is non-idiomatic and
semantically contradictory:

- data_race() explicitly declares "this is an intentional race / unordered
access" — which contradicts using it as the ordered-flag-read half of a
barrier pair.
- The standard kernel idiom for "publish-then-flag / check-flag-then-use" is
smp_store_release() + smp_load_acquire().

Verdict: Valid, but the stronger "technically unsound" characterization is
debatable. The right fix is to replace both primitives for clarity and idiom
compliance, not because smp_rmb() alone is provably broken with a conditional
branch preceding it.

The reviewer's recommended fix is correct:

/* ath9k_rx_init() — writer side, replaces smp_wmb() + plain store */
smp_store_release(&priv->rx.initialized, true);

/* ath9k_htc_rxep() — reader side, replaces data_race() + smp_rmb() */
if (!smp_load_acquire(&priv->rx.initialized))
    goto err;
/* no separate smp_rmb() needed */

So my question: Are there any flaws with that analysis?
