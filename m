Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795318060;
	b=rcD6Wh5SkoD0nIHUSIXS2Gm/yzR2suUmRQf+EIyZlOmyOjygnNhtVnaZ8X3i4sFoZi6P
	 ieS124DnYhM8ZNifEEl706lPSxlp0nGFfLHfmeIjUIhbCpILkxjcE7N4eONlsC0XcXFHz
	 XPlOVbFY0qlUgFbVvUTUhP2WVJ6lthfLMRmtVj0joTCMbsQ+roPStutaMqEFAIFtJbGab
	 Fi84lRVSrwDdstjiGSiWgRcXI/lmapdVfdUrOVaMx8sEa61Bv16UsY7yIhUUVVT4VPehS
	 iwY+au4zcd03KimeT8SjvuXnoMoHyHQ7c8zCfJib7vwgsfMEQ398UrvCmZEiRXyMTkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aQuu64Lnrpq9I3PH64EXbxDYmc8Cf7fUiyLVTDHPmr4=;
	b=ORxV7k+TzT7WgV3+t1SgCJQSbsBGo565vj9bjEp4vRuFBSNamYIWi4w9lFUk0b/wCwrp
	 OtrGgn0YzljN0yGzXSFsPygf0Wd+r/C/OPnGKU3LbrTKAyvJSWj3Wwp3CauS2+uOHLS7X
	 gpRK0Oa/WFa6YBI4yglWgL4xtzbHBuOBVfswGbxVAD1Djy3Xu7d3nKUFv1jjyIYokYZm8
	 0jq/99iVnwWHPQwzqQVgF90QZ2qFWaO0Ib6qp7qBXnNGImthG8MsEahkYfAJkpXJucso2
	 jimvg7jJBxNUaBqiiVcawgmoocGcgoQbhfvxenQlunmq++tA9/LTCGTadU+C5MoYMHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="G4/77Ugo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C2606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 161C2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G4/77Ugo
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55be673e029so152161cf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795318059; cv=none;
        d=google.com; s=arc-20260327;
        b=ktXq0sgYiEXpb+fSkGWdeqPDmgMRMnxBvAd4KOFbsOObKYDPACMKycC8zA2iGvxrRB
         uO4TW/+qsUCXAvrSD8dMETpgSv3WG+f448iJsrzvPByc1mzWdvUZaNoHwiJJ4yqNHD/1
         unBx2pZF0p//OU0uEHYpAnUdnR9ZySFsxAAXX8yOYUOY7SHTRPUYbvpHDA1yIAG+W/Ni
         rsbgHUhCQerabPm3JzaCMAycNg3fx912ZPKhnQpGbmOUao8F2nu1UNflXa0rXiJOQxYY
         QalEH/+apmxde0O5poxu8jD0wiPEP2yELc0LjXIm6ABuzNmhC8kg6IqfmX6A2TGKb4c4
         jB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQuu64Lnrpq9I3PH64EXbxDYmc8Cf7fUiyLVTDHPmr4=;
        fh=vs63Q8KQge8vc+yVbxkn0AEuXtP/yWaW3UWjiAtIC5s=;
        b=peCbpwXWwTbEOF9kuGq9WMV95gxREVe7BkEhOAcpK87hckmohCYnftnPfXcIsFSTfa
         BiFr+vw1xxDRNGZItNFrn1YmkoJP/ENJNHRXQBXmcCD05egSaNx51vYyyXbY6o60hJZk
         hSTq0D7AorGXhOPUbC3qBy1HyV1DnhI+0j9Oa7QO/mtAV42XyoJ46+NIALc6+iXby5nW
         F45fmP6veoMUWKhWqszHY2A/sMW0FjNi5+lOtDKGlpYM+ImUF301RMLaljGgcA3NJqgy
         vxg3imG9OFMB0A1Kcsq4CmJuY0WQcuEkzRHK0ke2BcAcdR9MSJn5me585Ko+f40Hfiki
         eOjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795318059; x=1795922859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQuu64Lnrpq9I3PH64EXbxDYmc8Cf7fUiyLVTDHPmr4=;
        b=G4/77UgoUvYhrFzOl4QL4j5eXcBT+MELt4Qvv951biDEBRHDetuhA4tREx9b24impj
         Fe5WUSIRpPbLoF+ebXPTXMoIBFFyEoLttyMDuF4Hi7hwMReFArahZk3r7/4ITtDjUxlR
         h7b35I/xhlyqAzJ3dQHSbMnPukEQ67fUabKBCZxkfbUuMYTbrQ6N1Tgk05jsoyx6Ld9L
         Bf0532ehcNerGntvDmd9HdpeqRXWKEjv89QFZZK8ysva/W6RsESSqDznVFJP3MeKpY1J
         k/OG57jMriEBvkVMHLQbr/ALARpANLrbaXC9HHrzdlatSQ4vBBHarAmDGAtylPb480Mt
         ufXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795318059; x=1795922859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQuu64Lnrpq9I3PH64EXbxDYmc8Cf7fUiyLVTDHPmr4=;
        b=HhRlahOUWU98lKdPCRyCTEa2qUn6OXiyVbIbsB64dH2X07640IOQYYf3sM1TDHFN5g
         ebm8IRucMclEcUMDZyjP0MSTCfUhrzpCfhPHyKDjUPRSEwA/OPG3WoS5kyPFuc3io5wD
         S6CphngKdK4x3gk6FmKhYlr7T+VkaRV4BN/FeB3LC0AHQJwkgtk7SicUlWr+Ivft5aeu
         BzTx0kr19vyIlQU0OiNlqMegeCwTTek8ja0LCB8XcC403yuP+VLyAxhEmwuTrOdJUVIG
         KAJH0sfaXuOONnB+f4wdqQYmPMFLlTwzBP5GdJEyDmCkwDsFZxxSh0WIyePMjpj8Z2bF
         CzsA==
X-Forwarded-Encrypted: i=1; AL+hErHLQa3q/9DIgOXkNGPtygH32yj0Xo7sSrA5WabymJfsTALEPVVyrow4sTwwCI8DIb2IXsDFrzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mK4oafEFzKxi+Dj33p7rTl30f04LlazDTFB46nIWyXzfb3e1u
	VjQgG1x3cQNcBc+XUNp2s2sUwTuysFSanZmMCEyUsWHK6cBL5tOQInwrCBMJihbA7EreuYh8FgY
	lh1Ne3j2hIrY2eKAjMtxAO1nMUI65UpgWUpN2R1RnY/dYWwr41gCiFMIr2Rw=
X-Gm-Gg: AZFdTZd1l88aanFckvEqG2sNgazTMQxhYyFYdKXWMpBm/JG/K9vHAu6oQTd+iMsyG9o
	T8KJ39GhK9YonctnNwnTLd9funCTP0GFg6EYqDwsREN+PDN0vhN3/b9LGdQdJRcPsUhBUffpcA8
	mIqxcFXe7YFGzbK6ht4Pye5wAAlKInzCI3NNKDCpjo7rDg5wRMEBNL0jUAdspIip/CBtYMnu3AA
	gcDVKXmfYCjH8+AUxwbd1YYll60XUEgVchC43Xv1BMmfEgmhllRHkqKTovKJF+VORG+vPhnJWMf
	yRsOULRq5z1x1FNnJvw00iHQkY1xaVmxoely19Me3I6+0oKxjxQb58uZsi2MTNejFjXMnegYKGe
	j2Lnr4NLAbzbJETuJfJWHNYwoX/b7v7pakvAKDDO+fkDonIeQD7cqMAwfN/BR4jseNlUv6uA=
X-Received: by 2002:a05:622a:5594:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-55d8900c88cmr12803541cf.9.1795318058238; Sat, 21 Nov 2026
 19:27:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org> <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:27:27 -0800
X-Gm-Features: Aa3M54pbSuLu1xqUqKb1UsA0ciFH-QHE34ZIs3C9DZaD8srMEy0uzBAMlfeJdPI
Message-ID: <CAJuCfpHipq2N9xHwj+Uc4M=Xxw2fe8yJgKnayYvC3H9uZc-uyA@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/ksm: only interrupt unmerging on a fatal signal
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ollie Wild <aaw@google.com>, 
	Adrian Bunk <bunk@stusta.de>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 8:03=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Commit d952b79136a6 ("ksm: fix endless loop on oom") added a check for
> pending signals on KSM break, so that a lengthy unmerge could be
> interrupted, with the system call then restarted via -ERESTARTSYS.
>
> However, it assumes that the callers can always restart whatever system
> call started it in the first place (the commit message questions whether
> this was wise).
>
> Well, it turns out that it was not wise, as this baked in an implicit
> assumption about system call restartability, and it was and is not safe f=
or
> mremap().
>
> mremap() holds an mmap write lock over the operation, which an -ERESTARTS=
YS
> drops, meaning that the restart is not in a consistent state.
>
> This was made considerably worse with commit d23cb648e365 ("mm/mremap:
> permit mremap() move of multiple VMAs"), which can result in data loss if
> you encounter this issue.
>
> Consider an mremap() specifying MREMAP_FIXED | MREMAP_DONTUNMAP of two
> KSM-mergeable VMAs, where a signal becomes pending part way through:
>
>     first pass                          restart
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                          =3D=3D=3D=3D=
=3D=3D=3D
>     unmap tgt1 range
>     copy src1 to tgt1, move page tables
>     unmap tgt2 range
>     break_ksm(src2) =3D -ERESTARTSYS
>                                         unmap tgt1 range, which now
>                                           holds the data from src1
>                                         copy the now-empty src1 to tgt1
>
> This results in the user observing a successful mremap() but with src1's
> data missing.
>
> Without MREMAP_DONTUNMAP, remap_move() would find a gap at the start of t=
he
> range on restart and fail with -EFAULT there instead.
>
> Fix the issue by only breaking out of an unmerge if a fatal signal is
> pending, returning -EINTR when we do. This makes KSM unmerging consistent
> with many other signal checks in mm.
>
> Target commit d23cb648e365 ("mm/mremap: permit mremap() move of multiple
> VMAs") for the fix as this made the issue significantly more impactful.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: d23cb648e365 ("mm/mremap: permit mremap() move of multiple VMAs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/ksm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 623a2cdb3924..5d320a200951 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -627,8 +627,8 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned =
long addr, unsigned long en
>
>         if (ksm_test_exit(walk->mm))
>                 return 0;
> -       if (signal_pending(current))
> -               return -ERESTARTSYS;
> +       if (fatal_signal_pending(current))
> +               return -EINTR;
>
>         start_ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
>         if (!start_ptep)
>
> --
> 2.56.0
>
