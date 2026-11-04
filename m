Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793815030;
	b=AVwNxijk+Gde5gVghjyH2pf57qWkQ/UKONLLBPBfHL1Sq6HFxHzsThON35DQae05P5hx
	 J41UpyGizAlLeqDtzGZMnjoDIrCwUn+or0+LSvUrk5+GRAaCYNzYuqpbglU5cfDiiVCJE
	 MufVhYcBKTZLAiqfcKMedotpO2PExuTxYCS3RlV/o5T33vdCJJxgBBnTaGSSizuq6LW0G
	 9IfmZvzoZc1AVriYlrMpI5Pa4ohceoy7/q7zlBzN/YTfnUkj+Mv1IJMHDl/yN/EsDEdRB
	 U0SXIrU34kc+Mgu9N4brevWZcD9gzydng+3JxhS4WBuCxVAclBUKKP5EZWY8CH2pIIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815030;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
	b=EtV1sdvValhaNMhax5Wkczr+eBOozGcLXL1JtNiI8Dr/p4Mp3GIqsWRpI8QiMMJhmuts
	 0PclAZ04t/u6KSUq8FK0Ak1Tu2tMYCijdeqYc1OHOrib9yVL6EpomB93jgj3D2VHCSli/
	 N2K0xa7Tj6cCdOLXHJIpwnQ+yUTp2XucMXRKYmPhliTRANSBJdUkRiUfNcP7Lmzeomfab
	 cquH7LtFvh4iBEa08ro2D3HwkaAO8a6wXk0kdehpYQhBuddoMl2fNsRch93kPBi/aALim
	 HMBb9y1tlIGzdLH75rccZ7E3aoAnVEdR30zRVSnfDnMmq0oTIuhnvxbYuorMCo876Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="RQLgT/9/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="mlAC/jFj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF8607168A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15AF8607168A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQLgT/9/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mlAC/jFj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793815029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
	b=RQLgT/9/LCYB2tLGWkjNAyspMrh4zk6ZGjOJ+fclDucidd5Wgxed5dVp9c1nL3M5UlkF4F
	+OCuWUo01TVEFCek+Bw5vma3PEmhEEs0Brp3Y16g2Ta9CueoNqP/nuzlqJDlkc0vfqdnM/
	giIkw4fq+vaxWDowTLP8ots0YbPkRQA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-9mnRl_ElOtKgcr_h2XZp3A-1; Wed, 04 Nov 2026 12:57:07 -0500
X-MC-Unique: 9mnRl_ElOtKgcr_h2XZp3A-1
X-Mimecast-MFC-AGG-ID: 9mnRl_ElOtKgcr_h2XZp3A_1793815026
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab2027d661so1032121fa.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793815026; cv=none;
        d=google.com; s=arc-20260327;
        b=B2X+ITilCncmnQwgmuymGdb3egNLdpDWJRIy/CrA8Qrs9Qn2ncFUNkv+E5ov04i4c/
         v4gC9FllNnmlR83H8Nz466lLsE0m+YmFAEKW01Thr5CAgJO2WLTAY+Yv3auS6F7iBrqG
         1kFNoO909xSJtK4nXVZX4EXVSYF9DrV7cMlfDi7FzThoGpcnjKGJw2/bcxayW31G2/Ee
         0BJ9C2M8cRE2LTaKQSPVfemLC1k7Mhducji7d938yxTW9w3Oe+9LAIscyuYOSGtSBhrU
         YbEywgIDZ+ApVMWZvHWpG/cRZrXOKCJdrGYzIxNxbDMi/ZxavvOFaOHko/+QPn23UEDs
         CK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
        fh=2bAHCm9PgDW75xL5/ErA8M6lJrEasOqQS9bGyzA3wtg=;
        b=k27e9tSB9LmLYzpqz6u17KTyFOshIKxkvtWPwxt+FM30c1jkry/CxDEiVdbXILiw9W
         dcsW/bjmAiL1OKZxwx1sw9TmOwKDpVIMQIocPGn5b4IZy1l2aHYnpXsWgel118wjeqyI
         WzsuPnq9vULji/99EDD5Ab3+c2p0pTBGYKQKq9acBcmMo79LNQQJGI8DIyetXs6UZouT
         w4OGjQHgjBe/2bJfFpDCEAeCdK7KTZJKim/LwDXdSA6qnflUGiXlhtx+WGL7Ap5hwXer
         Hv3K5ECi/JslWnuhr0jVTWVcQqcSnRWy/43Gk9q2Mf54cG26CNmxO60ibrV2EUrHa4pV
         i4Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793815026; x=1794419826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
        b=mlAC/jFjz7oK817vV7DsYBvrbyux9dgwk6qV1AApQ/4L5OV0xk2T4pZBrepTZiT2gR
         MggScLQmHF20PTh2VdRd4nFSOfIGL09xvuPV8v6httK+OlIZGqibynpX5DMCpc/ytxpm
         rV7W2VKOcmevoZcngrouKLaIT185InHTR8ytAO/SmUcCz3ut2+4zOzJeRfwOK7DrwiQo
         1EN6u8ogVIoyVMkqKz/vfZ1MZ49feChmZYgAwNu+USpBGUh8fPIexE6r/J6ZspvTuH46
         WEbEnh3wFKroI0XHXAHX5ir5n2U/gR7F3Z/5r0q8WT/EJXVF9GSaqA9yOR/wF2lQn716
         KZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815026; x=1794419826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
        b=IgtCrHfISso1FPF57LNRhuU6ZtHkaNH5OlIOuDbMRbSRY/ZOLuAP0lWu9D0N/+wjiS
         SFuHGJ3fdTUx22W8Ge4kscNhQP373FCli4ForyfywyORUsbby0SogeoFYfx6SAC1FQ17
         jMhD2Dp0hy7qir/2MAX8bahVhWEAa+2iCE9Rs0kS83g4UvVUitPacjeYB0MwuDsU98cr
         Uwe4ch6zrCM4Db9MXUBjDS/lY0pUWi9EQF5kadqJYQssKT6p88pSTgtUkQR76pvxL7qI
         epx9EdoyzJ7YiExdoQSxxx6SczZ8I9/8f31/yIXUiqYdzDfsJGh81rOPs20J7k3HdAP7
         v06g==
X-Forwarded-Encrypted: i=1; AKwUvBzwtVBlT59j0L/2ZkGCl/7aQbo0N2Z5baY6No/O8mpTwQ9CJQBi3x343gSXVt8zRXfBL1EvTBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bwTomxFVDLMwQZsSz/OpfAx8LDnNLBRru9gL/zGyxcCGZBuMK
	htfYZ2+g9ZIvDRiCwu847nbUIJY0QX3Fk1uwfevYgrx05nytZd7457uEF/ndusFRPJZaBmrOydv
	3NFd1P8oo1Oomwz/PKkoLorYNK/ub7KP3nQCT6bTiyWgjoVQ//Qpil+WcG9CQyNILSlZntsfP5M
	jbTo3Wmd4dJUrqqiB7RJh00ux50BqdPChP
X-Gm-Gg: AYBFou25q11kg21sq3SyhrOiB5huHzzBnJctd8sGsPPTKB+zbgwzkIrA6xVVDyS2hgR
	PbdLFvTEE/cKRe8qWeIuqrCZYGmq2ZPls5zF1yOZCr58BijKAEQPMdEA45ZuMYaLSPhpWRECan0
	X1vL1ybsr2pahDYzLRB3HAUdlss7tRMJNxGBeoxF6T6mspuDUloyKXNwNu
X-Received: by 2002:a2e:97c9:0:b0:3ac:ddd5:55ee with SMTP id 38308e7fff4ca-3acddd55907mr4690821fa.2.1793815026108;
        Wed, 04 Nov 2026 09:57:06 -0800 (PST)
X-Received: by 2002:a2e:97c9:0:b0:3ac:ddd5:55ee with SMTP id
 38308e7fff4ca-3acddd55907mr4690781fa.2.1793815025627; Wed, 04 Nov 2026
 09:57:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com> <20261103154246.S-8NqN99@linutronix.de>
In-Reply-To: <20261103154246.S-8NqN99@linutronix.de>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 4 Nov 2026 18:56:53 +0100
X-Gm-Features: AclHuK931Qz4UJ3O8Has-FEwEeK34WYcv8yPrDJgYS60eLd8ID20u55CvxuZARw
Message-ID: <CALE0LRsLS9Hsr_vUZ7k6YA4DJB6Su=E9r-F-btpyOXSvv6cMZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix NXP STM clockevent bugs causing lockups
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thank you for the review.

On Tue, Nov 3, 2026 at 4:42=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-11-02 22:16:19 [+0100], Enric Balletbo i Serra wrote:
> > This series fixes three bugs in the NXP STM clocksource driver that can
> > cause soft lockups and missed timer events, particularly visible on
> > PREEMPT_RT kernels running on S32G platforms.
> >
> > The NXP STM generates an interrupt only on exact match between the
> > counter and comparator registers. If the counter passes the programmed
> > value, the match is missed and the hardware must count through all 2^32
> > ticks (~32.2s at 133 MHz) before firing, causing soft lockups.
> >
> > Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
> > hardware's 32-bit compare register width, making it possible to program
> > an unreachable compare value.
>
> This looks fine
>
> > Patch 2 fixes the overshoot detection in set_next_event: the existing
> > check only detected counter wraps, not the normal case where the counte=
r
> > advances past the programmed value during the read-modify-write window.
> > Replace it with a signed comparison following the pattern used by
> > timer-imx-gpt.
>
> okay=E2=80=A6
>
> > Patch 3 increases min_delta from 2us to 20us: under bus contention on
> > PREEMPT_RT, 2us is not enough margin and the counter frequently
> > overshoots the programmed value, triggering repeated -ETIME retries.
>
> This all sounds like the hpet trouble on x86. I'm not sure what heavy
> busy contention means and why the device is enabled/ disable during
> setting. I would assume that the programmed value hits the HW after the
> wrap so you wait until the counter wraps again for the equal match.
> Worst case would be you read back the expected value but the HW sees it
> later (after the wrap).
> hpet_clkevt_set_next_event() does in principle the same check as you in
> #2 except it compares against the "min" value instead <=3D0.
> Would this make sense?
>

Yes, it does make sense. I will look at the pattern used in hpet and
send a new version.

Thanks,
  Enric

> Sebastian
>

