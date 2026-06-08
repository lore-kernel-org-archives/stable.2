Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496A3AA1B6
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913506; cv=none; b=DRnN8PyE5YhjCeRJHs6YPVA1MGiOC4DGxA7crqammiS0rY3AiFbzMzTMhMxgAjDWPsmWQpsb+u7sgfaaeJBHzljI7n7lp878WDl/aeaAipe0M0uZFkTtiGXhEdBkKgT0iSPZwhX3FsPpxihmF+yMrpWm6wx2ExxeCColcKfIGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913506; c=relaxed/simple;
	bh=ZaYXd74wO4W947HBTLlc43sIaBj9s8ZXEj28ePkAUzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADAkM21FOvp8Oko+FqHUQJ/Wag0rN2dsH9cOPiGKzVdOUJz4ADQjdV41OkgBThIBnwwAXPH5atoYJn1tu98dxiQP1Shci60RgP0edyCMVubGBUS3Vpx24mwP7vnqovShuKnN6vJb5mnB7fvAugpUQIvaFly1sSZhfe2kHm/IVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PbaywxLR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbaywxLR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec450b950dso571761166b.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780913503; x=1781518303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULW3bj4Y9orybcM84cc6zZ+siCehkEue96H8pU01HE4=;
        b=PbaywxLRRJcFc6D4PN+jAuMtrXmWYW0gKWzzt6w7/31C6rL26o8/gpyKZXN5je1LFD
         GGYxgyam+F+73wZAttyjBk/vk5PxHZ3jjXJkRWD1ZpVb1gD1mvs8baf6aGvPiBKW5phu
         nX8/K5rdj4CqWUUSpdkKjg3av7NP41KVAvYXC42KqWGyzOGRY4MMoKrXHJ+VQVex0pL1
         d5+Sj7XOTZjklWAlx/iP0JQQgkHa5Ews2KT5j2UqUd9z8bp7N2sjLgV40OyFCVsPhWTf
         JmGlerg1zcya3T5imp0V+57UTPQEvwekB/Xtn1MrNC458Zc1d8ApVfSX2KMCzDDxSvtl
         IYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913503; x=1781518303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULW3bj4Y9orybcM84cc6zZ+siCehkEue96H8pU01HE4=;
        b=G0XefwSbqtb3WfdnxcXSZ/H/HVhKY46H38bT6wO2h34vRCY6I6OSlV0hu/TPghmXEl
         5+7GsYnIVcncCTV5WT864YnZtsm4atFh72J1L9d8QSsJfR3E/rlR9bTkepsaQquDEiwq
         tCM1As7Eoj9Jt2Bbm4RDmuup9/SR/kM4/oMa3ENycqwhG09F80t2SK92RDpTm28iY89F
         0a5+ZPBWEFAcXVeoRSq745aR0XX0LwcfELOoXwFxhD0Vuz+ITNHk1nK70wqm7NaOsAVs
         KvvWdvkQK2nsJ6gMfvHaklv4n7aGiG3PQRrFY6XBPybvu1pxc3swpCmu95MHG2K9UoDh
         sdAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F9dBctUzPUQG37Sm1l4O8qRZer7qH8+hTqfgzCPd4k4q7NQY9P9D2IQXDt6J4y8w62ejyHco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi72YvyN/x7rqKeC7A/ERiQ5SBYOcRfdBw+jepsu5GsMe4TRlb
	8RrGwnB0+RfYcHFdA5luoEOZe/xaHkCs4+M84wUZpeVk9if9laBCVqrj7/gLcb6+mek=
X-Gm-Gg: Acq92OHkFeZTwzySlb8gGZRuq8oCo7HFnpjox8W9M/IF/LMG2CV+eYtBIMZ2D7d0p12
	5lO829WrF9KKZz5aAH1cMvhNtXUVc2fshRQipC4IlcFrSBHQZERmDk0FDlDi8k5Uh4GMgObah7A
	m2/5xHzOz2HZCoPyKx2d1oTE5hN4nVDlZxylzIs+FusYBJ9EShEG7N2ogSc7pU1y9iaPuXunLLD
	fkrPK/roCDB4sBb94eZLZJYeg5vklDa2yoic3VpQAs3DdemKZQFn0kCvRd54MNC9iUqlHlPrCkN
	5VtAshsomlcCfjwX2s5fx+S20hzTVpxTZcKNWTRg68kFmSnk8NTieTOVNLTjW9mr0B7TUODEHCu
	wJoTop9T2Fg2sZiiT4zKcBg2tRd06J0yLHDH4+IbIa/dM9ic5I+w9VfBPkWDQI6Y0qilpHjgL8t
	RsD7QXUBrP2PPJlUqdG6ZAUdSZxaSCVPzNrgZ20hBXd5llZ5MPnLIBDbEQEr4iA/k=
X-Received: by 2002:a17:906:7950:b0:bed:2a8b:3e72 with SMTP id a640c23a62f3a-bf370c66fbemr645648766b.21.1780913502989;
        Mon, 08 Jun 2026 03:11:42 -0700 (PDT)
Received: from u94a (218-164-53-75.dynamic-ip.hinet.net. [218.164.53.75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4b60sm16012687a12.15.2026.06.08.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:11:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:11:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
Message-ID: <aiaTZCQLWy-96M9O@u94a>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>

Hi Zhenzhong,

On Mon, Jun 08, 2026 at 01:09:55AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This series backports two BPF verifier scalar range-tracking fixes to
> 6.6.y and adds a selftest. It fixes a verifier state-pruning issue where
> an impossible linked-scalar path can be kept while the real success path is
> pruned.
...
>   15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
>   16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
>   17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
>   18: (bf) r7 = r0                      ; R0=scalar(id=1) R7=scalar(id=1)
>   19: (55) if r0 != 0x0 goto pc+6       ; R0=0
>   20: (67) r7 <<= 32                    ; R7_w=0
>   21: (77) r7 >>= 32                    ; R7_w=0
>   22: (b7) r1 = 1                       ; R1_w=1
>   23: (55) if r7 != 0xf goto pc+1
...
> I also checked bpf-next: bpf-next passes even when the d028f87517d6 JNE
> refinement is reverted, because newer kernels also have the later
> 4bf79f9be434e ("bpf: Track equal scalars history on per-instruction level")
> precision-tracking change. I did not use 4bf79f9be434e as the stable
> backport base because it is a broader jmp_history/precision-tracking change
> for linked scalars. For 6.6.y this series keeps the smaller stable backport
> path that directly follows the bisected fix: preserve scalar bounds after
> conditional refinement, then add the not-equal range refinement in the older
> reg_set_min_max() layout.
...

To be honest I have not figure everything out yet, but I really much
prefer we backport commit 4bf79f9be434e ("bpf: Track equal scalars
history on per-instruction level") to address the issue instead. While
'bpf: make the verifier tracks the "not equal" for regs' itself is
self-contained and reasonable, "bpf: drop knowledge-losing
__reg_combine_{32,64}_into_{64,32} logic" comes from a much larger
series[1], and taking that out of context seems rather risky[2].

More importantly, 'bpf: make the verifier tracks the "not equal" for
regs' does not address root cause of the issue, it merely mask the issue
by making the two states different enough that the two is no longer
equal, which works for the Rust specific case you have, but won't work
if the value was slightly different (e.g. "r0 == 1" followed by "r0 !=
1").

The root cause to the problem have been stated by you already, it is:

> The relevant pruning point is that regsafe()/states_equal() accepted the
> real success-path state against an earlier cached state where r0 was an
> imprecise scalar and r7 constraints were loose enough to cover the current
> r7.

Looking at the verifier log you have, in the impossible path we have
r0.id == r7.id from instruction 18, where as the real success path (that
skips instruction 18) does not have that relationship, thus the two
should be considered different, and that seems just what "bpf: track
find_equal_scalars history on per-instruction level" solves by having
the correct precise mark.

Could you give backporting the full "bpf: track find_equal_scalars history on
per-instruction level" series[3] a try? For 6.6 it should be doable, and
hopefully for 6.1, too, but not too sure about earlier ones. If you prefer I
work on it I can also give it a try later this week.

As for the selftest, it would need to be send separately and by itself
to bpf-next, and picked up there, before it can be backported to stable.
I suggest you look at [4] and have your test placed similarly, and
mention that your test specifically test a Rust/Aya pattern.


Thanks,
Shung-Hsi

1: https://lore.kernel.org/r/20231102033759.2541186-1-andrii@kernel.org
2: https://lore.kernel.org/bpf/20260601182508.29C811F00893@smtp.kernel.org/
3: https://lore.kernel.org/bpf/20240718202357.1746514-1-eddyz87@gmail.com/
4: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com/

[...]
