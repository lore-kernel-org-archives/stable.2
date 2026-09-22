Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591139E6C9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045508; cv=pass; b=NvkLmSuR7xcHeWENsd86UogeVLprRKaPH6J+GY6xs+c/sJd07FhtDT+ZFC/mSxC+AIbCVpTFp9b+FVReJDtCUgVrdZKt6yP99IxwMxstzPstbzlyxsjJFYQ3n1htcuC/aVsz8BkcgWFRh6/cSw9HBpyG2ERpX1Hs3TKoM8pmgVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045508; c=relaxed/simple;
	bh=EHJZ/r8nwiYCre738712xb4acVlAi73WgKf0YgXYQQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjvBXxIfWu+2lRcGp1nmydaIIdbsJrtJXgmDwV3hkil7mpujqOsy1SGVYPVwKTpNrzQECVYZ8m4GNVTocgZUWl7X3bGRhNTiIAkabLOJaLTgZBT1Snb55OPT5PriboDMm4ILyPAEHF/Ui+Rmmji2ldiXuSXdmJkwDqKY/WqEVw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgGJWGD+; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgGJWGD+"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae314aso2841363d50.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045505; cv=none;
        d=google.com; s=arc-20260327;
        b=ZAfqhL34OEhRdSMUCjf+Uv6N2P0UUSXJkw2kPDygfMogJZ+P5zYgoXlbhve+J9fvNg
         QDmC3m70d5p8uXrtgK7g4+476E6kof9xlxhyzS3Ixd3JNy2FpZBZmZdAIZgD0dJ/wyaZ
         OGVhUA0qFACF3r0258eeg4U44gBYOtz4UnVQo47xSlxcdxxqnbCDmFZBtYP2gtvHyxL6
         BrezlrwPrqBp0lGYuPpn5r2cQt8dDxh2THnMwbpf4VbXwTJYFYm4qdBjUCJte5I3HNzz
         OEcQrpFZZAIPMnyRDBOua+HuytTdQnPrKU5DpKYjXTHSUCitGWLfEmHpG6dY7+qcJKT4
         XUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DC37hLz+Eyp/AOht/Mn4hvJpHHJG9yS4sKZLRKsXmYU=;
        fh=QO2h8vUc5x4we+MKvdgy0hSdPv39BdePCLPzrL7sDik=;
        b=pHIk0WlPAAzuNw4HY7q7TrLj3B5RYMHwv0cYwCLAC7J/C5ghJvyS/pgXuXxdJVlYrS
         nlDFveElvQtAtMLsuWt8K5CngaF4GBhYLzxJnsb7XA4bUe8pM622hQOwxfkV9ELCgdyK
         ojibX+VV5eI6/xNvqcYp5yryvBzcSa9bKhkOsgJtvqgSjWVDoE7s65ToOEkemdbE5cX0
         j4dQ5U/8iKcQ5UWtZKazNyRqAFcxRDXjiWPFsWZtvGAcSKN59r/J7WKq9QUypIys1cut
         iHsisUeiyZn9zPKJNd/T3vpaFv9g2htCUGOEVzzErOicOq6Q79zPwMolp4O3fkaIVc02
         QMhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045505; x=1790650305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DC37hLz+Eyp/AOht/Mn4hvJpHHJG9yS4sKZLRKsXmYU=;
        b=mgGJWGD+El+25CHEJ7hiTLtVCFAmQxcDzb/hrsxGgOxRtPVU1282rLBGPu0ViiTkCg
         qP5+xr2KD49GZ2AjFlIR7xKr4BR3/O2Dsb8nkzmrdB8bKUoZbV0XccrYWSZqnGx1UciC
         Ywf/wRuaz87ocTYSD2wUlGdbKi989GYldohAKL/8vh040cy0dnTjiukGX+7kI4fGHlRz
         RCa6hqeaXEEMFHi6vKRYmcNC9ZoDm8cDZo1J7XUK7MoNTmUQYD5xXpHWIRSZoMezasZp
         7JOJ2mTR6rsXmUorriIyZNF503qvSXB0ARpM8s/u5Xu4+UbLU1dh/aKU5B26j4aA1laD
         6dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045505; x=1790650305;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DC37hLz+Eyp/AOht/Mn4hvJpHHJG9yS4sKZLRKsXmYU=;
        b=s0z+imEPj3nq21BgcS06JsV0tWnFmeaNMLvcNEI7n2/Zsq2Vpd79mjBX22UpN00Sf3
         wLyFK4RlFYpvVIxA5i+hbAumsRgQn2JvI4VxrkZLGwRBo3Zsez5sxZS4I5J+bWngL2TE
         aYIVpPnuqU/D4UcY/dJoj7iPcs6CoX+cPkqq+RvVPjMnZ23lDqNXjZ/ORI5srvgn7gbR
         Z470JbtC5ONUbJkqIg517E4iBUnHeu82H/kGNPUojVdLaQbYPwhX4+DtWBsEuk9FMMiW
         eTLJ67vE849S5IyV7Gl8FxJQPt/wXsnulyDlsvg235HAsJfJ9bPl44ELa5gy/zVlzspz
         1daw==
X-Forwarded-Encrypted: i=1; AKwUvBzI44SM31Hekmz3nURf8q9+f90c9Averw5y8UrN5xvVTj6a4bDxmaMB9quIa944TFHRdU2weOw=@vger.kernel.org
X-Gm-Message-State: AFuF++kd5TOD2jjFRn/o9etpAwg3zAJH7tvjeTYxhiIQcp3mej4OVh14
	M6f9NrXydkFEMGmiery+8k9WzPaOsccAePkbcU0DlHj1LmIUHgTeAJgGXhpr3zkGzqpgb8rjtNB
	xgqxWssCa2l/uCi3ocFiBJaLFelYikYmQcX23jXjgwnIU
X-Gm-Gg: AYBFou2n5NEF8fbsc6u8fRvb71XqL0UcYWIpmvRgndu7QSs/8LPtURx8q6Re1N0qNoF
	8M/gHQnLEFIdwOH/lMcKT5SLaGlWyfHU7Yo1BxWlSCwM15DQ0uTUaApDN1DGrl0OtoSNdl88Lpd
	OGdkhJ4WjvSZldvqU96AEL09fDt1NYRKc/k00N6+554HTZNYWYYC7RqtaSLXIWvAL6OdqiK+WzI
	rkccDYQxPv6W7YtcwQWXlEAr7svTBbrn0KIW7XwcaV9Id6lK5/PWZFG8WghsW2YTYrNVP/A/F8L
	risXeW6QjOW79/fCLaJwBYl1zMd+l4d9wuh212uMiMab2fqBcyKPygfSyg==
X-Received: by 2002:a05:690e:1241:b0:672:bfb4:5f4c with SMTP id
 956f58d0204a3-672bfb46f1dmr1042907d50.101.1790045505504; Mon, 21 Sep 2026
 19:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915163407.2487869-1-lgs201920130244@gmail.com> <arFJDKtpHSmxkhVG@quoll>
In-Reply-To: <arFJDKtpHSmxkhVG@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:51:32 +0800
X-Gm-Features: AcwNN1VLwtCaM3Xy2OnZ5t0yp926pSurVM_42Ia3AlykAbM73ddOrECv-XxjPlc
Message-ID: <CANUHTR-pX7NrnehBT_p41oAd05jdbcnuLvmLfFE2nfQ1zqbWTQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: intel: fix OF node reference leak
To: krzk@kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:11, <krzk@kernel.org> wrote:
>
>
> On Wed, 16 Sep 2026 00:34:07 +0800, Guangshuo Li wrote:
> > ebu_nand_probe() gets a reference to the NAND chip node with
> > of_get_next_child(). The probe failure paths release the reference with
> > of_node_put(), but the successful probe path keeps it for the lifetime
> > of the device and ebu_nand_remove() never drops it.
> >
> > As a result, each bind/unbind cycle leaks a reference to the NAND chip
> > device node.
> >
> > Drop the reference in ebu_nand_remove() after the NAND teardown using
> > the flash node stored in the NAND chip.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: bfc618fcc3f1 ("mtd: rawnand: intel: Read the chip-select line from the correct OF node")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/intel-nand-controller.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
