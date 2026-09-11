Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1238E8CB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140493; cv=none; b=aDnhECf8hP0x5f2lzPlvAZ4zS1JomisRU173wNMX4QMZjU3MA8YPQRLMUhPnB+zrBX5QEv7N19+acusfYBjXrah2l4yApbW4UqlfBt8/Z75H5EWMeGGcToVBpfjPiGq6cDrCOP9zcH5mNEziG/rhzqCft+pX4LDWe7y8OVcxhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140493; c=relaxed/simple;
	bh=FhC1BGc+izFGRSVhsr6TbpR9BgsKGiF2SuSQ1pALooY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tKkx9K7JfC6JL1P1Mf9ur84OuvObqKD7NUk4d7cUWkFfjqWUr7px1l+zPUnbhQcneudbQw+oqsOXHR1xNKtS9J2ZlpZO3BdRweQLXY/XW8+9V3rKGXd60PoWqTbSb2skeqtJuWw08Ai5Gd7kj6UHySslktnigHgdy2e+cCBUnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryUTerWU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryUTerWU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8565d77c277so12056477b3.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789140489; x=1789745289; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wQzcuFPYkAadTcMKWgFjkOZlpHbtRvNH6B7KXfZ46WU=;
        b=ryUTerWUF3R4IkMvaNV1k5u2/OHYEhgHfcxKb62+78w/vZaarAMoev+UPQjMVCcZf/
         D31h/Zoy7/rPNKtqflKdVWE2lN/f9sD8ChZyWDsxNehadFqAPdcoT9bW3ClFxv+kK7Cq
         kCDYFj4+3vCbmWmqvBcUIvVO2lDY0axCsuqABEO9ig+bJFhDfgXfR3BM5iK8Gds2a24s
         S6VY/pd9SA6pHDDzqTOV9VIWwo8Y04l4FMZrnRd09W7XMdoN3h+EmZd9OB1mFnVbdtzK
         xr/+dq0bE79gM1IjOFRdVc61EE9PRu5VJp0mNDGugjIAz2cSkufFJvZ+uOHH13ri9RlU
         N25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140489; x=1789745289;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQzcuFPYkAadTcMKWgFjkOZlpHbtRvNH6B7KXfZ46WU=;
        b=GF1vvkLDIMS7sWYy63RVo2JKMbfWfExFIuxixHtBOtoo6vPsIcbMIIV/JZ5z9AXdBN
         fs1p4h3LHJ3b5HP2zArrjhPvqsL2I+GEDxwM9yVCUsRPeh3U65lbn/8TXpqHMAwQmBGD
         GnrSSzpFive+gphfNFORaPQ7zJ5IQv2W4sGRGsy1vnPwucS5SxCejpyPcbBnjw6AKzhV
         5NNYuJ9N1uhybbIiIUaet8lOpvC7tkoR7a+kILiStjlZyuvZNn1woTfvuN0r3jwgkLkO
         bZJh9pBETueysVWC5uVyoe0bgOFqKZ8gEanaWAIGHDmN86GQX5Ebx+FPteG7ePB9Hfyx
         IkJw==
X-Forwarded-Encrypted: i=1; AKwUvBzUFARLwW+CUz3z8q5r5CghN3bl4l6ixJTNdFYdxtUUXBWI2wE1H+6pF7r3Rkg8AovQtSIQ7qQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n6wUSCZ/eLiOlT17hLbe0rELnbyCFutONGvBZXcjmAQ50aV6ty
	iC+4yG4lyom5mfFUNgMYD5bBWrd3q/Lhpm5sISQKxGVLYsuQEK16j+gw
X-Gm-Gg: AYBFou25A8RshNWzG9FyuX9DWyla5hwe0sZ2m6Moy3ZKgMrUhg64JqeLBzEDd8sXCeh
	a29W4wryIo6EY3vFNrxyyAYc/cVzBmokx3ZOPsKyMc4B6IBqRyWolDccSp8p9OTctW2FYgiSuO7
	2DvYBfQHPEnCM0xIU0Xuk+Rae7aCe19T3kvDBhm3gzTY7pnwg9At5adEoGDduPYR7WKTk3N2otl
	HW3JwsmWI4CtM9CTTtkIn+FBMrEoRmQ3s523lQxEKSSIuA7KWL+uXHxBJUXdN8w9/jKpAtfohR+
	0yVppYix070cq6OXMFV5C3m5LHFCPwP+/ktKrnTtTC7nvO1SHkLISbCX8kQ1tIzuvedK/xRZZcj
	3RGsXTRREeIKvNQeSnCuwS1Vx+MvzrbaobgGCvn7JrAirflxsEZZ5O3Iz9EyFqQnmWHmMCnQhRN
	ij8IcjKAvpjnDVyrslFd6+QGw+zk0uNWuLve0iVmld+xUWfRWwwGJiP3iTwy84Wl5zXpE+/gj00
	lzNbfOE9QD0guvk8DfCvNTPqzZCxST19y/Osx8sjXND+772p5dS3edyoJT9qoBs6w==
X-Received: by 2002:a05:690c:660a:b0:873:5c6b:a2f7 with SMTP id 00721157ae682-884b23029e1mr17446467b3.37.1789140488900;
        Fri, 11 Sep 2026 08:28:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884876e5780sm11951597b3.27.2026.09.11.08.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 08:28:07 -0700
Message-Id: <DLCLDD3KN3WJ.2PUS28BYG2QVK@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <linux-kernel@vger.kernel.org>,
 "Aohan Mei" <henrymei@tencent.com>, "TencentOS Corvus AI"
 <corvus@tencent.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Hash lock addresses in rqspinlock violation
 reports
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Aohan Mei" <ljp1205831794@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260901114755.1165703-1-ljp1205831794@gmail.com>
In-Reply-To: <20260901114755.1165703-1-ljp1205831794@gmail.com>

On Tue Sep 1, 2026 at 4:47 AM PDT, Aohan Mei wrote:
> From: Aohan Mei <henrymei@tencent.com>
>
> bpf_prog_report_rqspinlock_violation() prints the attempted lock and
> every held lock with %px, which expands to the raw pointer value.
> The report lands in the program's BPF_STDERR stream, and that stream
> is readable through BPF_PROG_STREAM_READ_BY_FD with no privilege
> check on the read side: prog_stream_read() only validates the fd
> with bpf_prog_get().
>
> Any user with read access to the program fd (a shared fd, a BPF
> token delegation, or an unprivileged child) can therefore read back
> the raw kernel addresses of the rqspinlock objects, which are
> dynamic allocations whose placement depends on KASLR and the slab
> layout.  The verifier-facing log path gates pointer printing on
> allow_ptr_leaks; the stream path has no equivalent gate.
>
> Print the ptr_to_hashval() hash of each address instead, so the
> report still allows correlating the attempted lock with the held
> locks within a boot, without exposing the raw addresses.  Fall back
> to printing 0 if hashing fails.
>
> Fixes: ecec5b5743bf ("bpf: Report rqspinlock deadlocks/timeout to BPF std=
err")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> ---
>  kernel/bpf/rqspinlock.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 111ec80ea958..5721dc1a9577 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -16,6 +16,7 @@
>  #include <linux/smp.h>
>  #include <linux/bug.h>
>  #include <linux/bpf.h>
> +#include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
> @@ -673,6 +674,7 @@ __bpf_kfunc_start_defs();
>  static void bpf_prog_report_rqspinlock_violation(const char *str, void *=
lock, bool irqsave)
>  {
>  	struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_locks);
> +	unsigned long hashval;
>  	struct bpf_stream_stage ss;
>  	struct bpf_prog *prog;
> =20
> @@ -681,10 +683,15 @@ static void bpf_prog_report_rqspinlock_violation(co=
nst char *str, void *lock, bo
>  		return;
>  	bpf_stream_stage(ss, prog, BPF_STDERR, ({
>  		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqs=
ave ? "_irqsave" : "");
> -		bpf_stream_printk(ss, "Attempted lock   =3D 0x%px\n", lock);
> +		if (ptr_to_hashval(lock, &hashval))
> +			hashval =3D 0;
> +		bpf_stream_printk(ss, "Attempted lock   =3D 0x%08lx\n", hashval);

No. This is not necessary.

pw-bot: cr
