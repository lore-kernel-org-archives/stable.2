Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608549;
	b=YX+p+UnKbhur4Ca3t8FFXziM4CcqHYJIZZoAHQM1GWAsVIQSYs4IlfHfhP8MV/tlcgIK
	 LwvmTDiCo6O/4hGhJm402a0kCmYjq3CbSwM0OkFdwPNj5NmMTWqCXgnm18yiQlsc35kYs
	 wneBEPKQfiSPzADoOGRz4ByOZ0bGttyx2VwzafjIj7dWGtFWxROKsPDSKPzJFCdq4Sxr+
	 MmzcSMDTCwNmTXXj1vPYH51URU0gQPTWjqu4ejEUrId4IIM1E94ezmH07SSrYTP9xZREX
	 hKLGkEryI0qAgTy47JG+ET2x6SiupI4jywuxYTP/BtFf4ygd7caOdFh3/lwmrGvyksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=q+pas6iyIgctKAn1tCXhNYxNGSLbjoEgQaK/+oTuUAc=;
	b=4CwmBsIOT4gB5lxPXgJyGBy0mxldz9AHYr1GsIpTN+j+4hLpsKr3QQgTCw+8rkz861tt
	 y2x0O3ZS7IBKNOtgXZDQRdgB8b1uPYvamwxjz4ST8s44bnir9rwyJN0WJtug1ZJl1S6pz
	 JoJ/6c0oI63AKCZByfQmWmoCWL+BLhpP4y+mcHgfKU2uiNb9XlOPma/tKmlx4Bq7jHBYE
	 TGESE332Uwwtu9A8XpvtIdT4nFZYLAlMBGaks1v51isUXlo436YnOBTtGUVOpTb4zvAOj
	 dMTfuZV0KzJGHTb90xfxEuY7evJes2cFvcKRWW1APPSNnOkNry63w7O7FecEWkJk9Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tTBGWGHM;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FC606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tTBGWGHM
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df4f7ccf4so406813f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608547; x=1796213347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+pas6iyIgctKAn1tCXhNYxNGSLbjoEgQaK/+oTuUAc=;
        b=tTBGWGHM8E+gzVeGSjQnKU1H3VkHzPOVDxC+1S6hQdKhEDqDyka7RVDS1vuO2suFwx
         W1Y2WFGYTav3vLDw5NJQdkrPBv5f8yPEGXa3df2hv6uWaEiAr0aSKPtKS40ub5SKiZtx
         1qf8/fMFo4tlXbYikAnAVoHw4EBS3e0PS5iDFd2/V+j1zAkvYn/1gREyMzI+Xcrtg/fz
         gNw23KaV3ZeSrk2g4ijEr7jSqO3VNUV6ASUoSRjmiCAwazBQMmsH1cCyNFVoe7FOlEKl
         gwjozYUEZSoKOELJFbxoNJ42Wbu6MVtITKQZ/5nfTYk48f4CLwcDQU6U1I0camSVtGmA
         9rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608547; x=1796213347;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+pas6iyIgctKAn1tCXhNYxNGSLbjoEgQaK/+oTuUAc=;
        b=umv9qnDj7e+Fd068LeKlVOcTqyJ1DQiebpzH/VFnpUePqcX4bNouBQVQylQKHO0vhh
         F0LA2rN3Irl3H8JdH3/bAyJV/zmKhF7iIeXJKMySCH7aZptiS70h4zxQbeJtTtMxKuem
         ljrvI4cZkmSywfxvGxfVrvFJEWV2MYgHdgnqKxBmI4wVrZDiFfbjcCMVBWxeawCHME9C
         q5TdtGhR6pLmQVxgn2RZfEVmFSBYGocRFUHESPpLZG5t1QiBl+hnIzPaJZYAL8Mwgeni
         yOXP3ZqhUc5K11g9UIPv9sO0/4NlGAHiflUOI8TIfXv2wPqw/iEctm0A9IBHjMg6JAUy
         UbzA==
X-Forwarded-Encrypted: i=1; AL+hErEoOCvvYzopDPVbMcw52/UwHyYFLHzXmWNnpgX9mntwmpIN5eiqxMx9LtG5XLUT9kyw1+y8cYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z92IoyW6f9YCw4JNnT9QVq3prrCnemAiYPOdoivTXJVAACtxL7n
	Ji0c7EgN54hykNaRpGaxbVyglMcLJ0+lev3b0gLS7OUpgulke3o3LaEI
X-Gm-Gg: AZFdTZetpcZ0gOOWBUvScIn7kHii+r3KFtIajkeoijPIVIuOK+/83RwGSClfKEh38AM
	V/sq4OgotFpFmWge5OFFcdi2Q6i+dyG2eYQCidGMTyf4Pd1MOCLLOZdTJZNUzbjy/9TB+XNE/Dl
	iKxlhal87nxzh739Lhkmmv4kdXTwy0fb81QZxRXzoACLTQ2Ko7JwGNj22WCuyzNF9ApZft9NpkA
	ffuYTBF+CnW2TpLYpGBD27G3x1TspDm9KieB+4Q640aeMij+Sf8n/W4uI+zp4OhrYOzyWFEbl6j
	D+glFtJBjpk8aEBGMPEy4bpGj1/WTEfmbvMHLYuZfX9/8tULDC27ZLmXqTl1xU/F3hZEbwoD2l8
	mgkRwAIi/OKXDfZc92uBN76d3WmeOVFdA+uC8oeJyGH+j8z+BQBqiFB8i1XR9GlHe5gzHCNCiw/
	prxCNMuBi7od3SxpBG1fnKlXe3l72gp/WqpIsR5bX87djSNZrxUM9gcAWbKFD5qEtZ5LYaZEJ+A
	UDnYF9FRf+ZS9iavSx/zch5A95veAsjWm0lYphACPqRWV1kDLPu8+14fFUUxumVI9edj/4Wpm1y
	ZMsYVpB3SzGXoPD/a1NQv8bz0b6bKbJbXFe22Mb+CeuNabnJhSqVCEuTew==
X-Received: by 2002:a05:6000:2210:b0:4aa:8fc3:28fc with SMTP id ffacd0b85a97d-4abad0dedc8mr35898701f8f.1.1795608546671;
        Wed, 25 Nov 2026 04:09:06 -0800 (PST)
Received: from scheduler.schedules ([85.100.65.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm34561159f8f.53.2026.11.25.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:09:06 -0800 (PST)
Date: Wed, 25 Nov 2026 15:09:02 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Wenwu Hou <hwenwur@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Wei Yang <albin_yang@163.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Avoid counting sleep time as run delay after
 migration
Message-ID: <awbNyJl7j4z4wZ5H@scheduler.schedules>
References: <20261125115519.2373653-1-hwenwur@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125115519.2373653-1-hwenwur@gmail.com>

Hi,

On Wed, Nov 25, 2026 at 07:55:19PM +0800, Wenwu Hou wrote:

[snip..]

> Link: https://gist.github.com/hwenwur/61cf383f8df72d4270ad9918b1d4edc8 [1]
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
> ---
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 515b9d0353ce9..043885c66365e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2198,7 +2198,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	psi_enqueue(p, flags);
>  
> -	if (!(flags & ENQUEUE_RESTORE))
> +	/* Delayed tasks remain asleep across migration requeues. */
> +	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed)
>  		sched_info_enqueue(rq, p);
>  
>  	if (sched_core_enabled(rq))
> -- 
> 2.43.0
> 

Wei Yang is already working at the same issue at here:
https://lore.kernel.org/lkml/20261122121823.2572209-1-albin_yang@163.com/

And here:

https://lore.kernel.org/all/20261024042753.2276779-1-albin_yang@163.com/

So I'd just suggest dropping this patch.
Or atleast working something out. Adding Wei to CC.


Thanks!

Kayra
