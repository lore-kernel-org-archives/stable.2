Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890D38422D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011116; cv=pass; b=driHetfdFg5NMWGQTR05JcM+i8W8kaIf++DOo4oI1BHrUmti5Qr9Xwz5IiDUDCV4gb/Ql1qCZQeOqbQIyhlGKY/8AIniDd0rvxTCt/lcuB0AJv/5ayWacIcg37UM+WKBJH0NkQsQNbrhkVXaCinRn7hlA7gcmtsWN57lvZT6Tno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011116; c=relaxed/simple;
	bh=y8xHWmkJkqubTyz+Whxf6Mqk6P6YdMklCfjtCXAS0DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mICaOQvy2qfWBD4+iWBFD3sAqhsFb0WuCf8P9AZjXquiuunSmxfHux715S2T3YjYhmWPFCdzAzCpzH+fVntXVOYYqdCNWmcRIcUs81FCMWgV+soq9xFok2mg2RFMTarhLkhsReNVicD4nyVwAEUTg7MIhqL7sME3MhkdbkzYZXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCtyWsHf; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCtyWsHf"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664ce3000e6so606446d50.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011112; cv=none;
        d=google.com; s=arc-20260327;
        b=khtHPU1O7vpQArnYufKp1iAtFFdfP1Ev6dZd7pI3QKgASabokiHWUQAMnSM+dsfwSO
         ZfW8JZXJo1up/Nm36tqURcGmcsQGATQ1WjHlIzgx79+ONbgasTvuD5mGKjEryY12ueF3
         cHPEFpsoIcJ+itEmlkxtydkIrdJXy2yCTZOHywprE/dNaMDOSsryrL15NcmKsx1RFB90
         66Szgwj9ycimVlWVWnYbdshBbm79tl8NctkqPPC+CKVa4LwMLHfVITN/I7+ueFCxy3Vf
         whPtSDC1Pxou3rOVO8yt3VVPOPJKu8TZnfhd6bEbVzmsimIVKYnUt2JP6beQZjufQ5tK
         dAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        fh=RhCYkjFy2Mu9+ldovypHx6VEpA0gcS6ESnRWX05f18M=;
        b=KaZ4M+VfPLYwy1GC24hdy5J863MFdEvBhLkrJHyJ04A5tjOgkztWQOChxoZiVcpbXJ
         W2Vn+/kKDURvLF6nBKsDG2fj6dnqVVIIaze0CklDQtZqqkIAYJZ2mKUbuzrGrK5pa2qM
         ZfFBz6xMTp/VzOwL3WEK7lj7yg+BXX8K8nyi3MnuSia3rYhM8MUuSD/Su7SSCPs1Sti0
         577UVNXgnc0S34lOrPgsQ3OizEBkoNPa9/A81pSYfQrbRq8j6bExZxsydv4+h5Vs1SWA
         F6mOy76Xg2Rt1GU+ankuFKOXw7b0pe9q4Uu7eYSzVBNkTcwU2jZFtxpTzeAZeh82SeZj
         eaew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784011112; x=1784615912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        b=DCtyWsHfFa34WGsH/FU/ot7DL5lVk21Ch+IuYgixgMS4QZv9kbkkyRzqYaBoFEvX4C
         bFcorL8VOrUHln/Gvpjdv+/KUfjoFj/Lojy5roxQZ+cQn2yWNIpEgWdssicH9SQ8lykD
         haxzX2zUNadlg4BEJ+bzMTTAAzPINuCa8Ls51MmfrXccgxxhKZCiI2NTgR6X8MA1U9Ty
         rGAh8DbmKdOdzA8Ru30bTsolChfKwIC/Z27EezlEX1WIcmd8ZEDwGiMb1t7NosDGZnAz
         WwWp+32sQXQoc8UutywqsInzhfmWo1DQ2V4A4gsA3n6NOr6abhr0L73gw3YHC6maGr1C
         z9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011112; x=1784615912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        b=cWi0J/1sEap4rNe8yHxjB/mVfBfQ3jAblYmE/djWnipU94BfM+F2K40kzWfQ1+3jau
         zovdgnftx1DVa3DqaLEuNi29oSlydUqjJflMrcOX2l8LkXpJC/Ue4Waak0d+t16VfDI/
         eawAGJjgvpFsYB1tRqRuDkrIa63IRpGoRMKUwChJHJ/S8YdlPaYU9ukMkLHLsV5Reuho
         z5+OYKrk5a2XI7P3pHZ/2a7rvBJcdLIniG+JAS7wu8nPSM3dBtYtcSJfQYFYbdES5Ur4
         P+3aGBWOc/FzR8sQO2bFPGPeRy7tb0FVQTJdI4eWsWzf/90IIym09x0DP6R/MHxZ5H+s
         1ijg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9kXFSzDuDNAgeV6bxhtJ4s+SKVs+UVTbdHPdab1cGNjx0ppY1CXNDg20GcTYPFfOpYPMRgfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4coDaneJm8Jfok3t4zXOw3lAFBhX8PCQ7a8noHsoc1XxTvuG
	vau2r9UaIG8lzVyYh3t+kvnySUXsrXcp82dgwrhjhs/tlUzPqWb+EGncknOr/DnUYs5G/bmKENt
	R1il67JEjAoi6Uab7NFwPdo/OCAVelkw=
X-Gm-Gg: AfdE7cmPzbKdFad9yP3QyTgdovmFqQbvb2sRnOR6flx1/63ZCfY/Cl94i3czIPxg7bL
	xzp6Dhy95aJVWZCfw3JngM4I9dUuLvrhwnvS2dERPvuTEycbCVZzFSR28cuOUpFsKyWQoZ1g3Ri
	5ewtjkP9kTY2ZEfbkPj1b8+Oe74iSysCJ1kDCnsk/0xLfQTHNpwcJ+c/i67Ve4PrrqPKK4KwqSC
	VGqoeLkP5ORzk/+660eBTLUCNfjX7iu0K47b5SolWA1gERUX2R664BODxXqBS+n7l4wCzpUTYsm
	/TxItLNLT75wFeQINS7I83MUFRBRg1iKXvsx6oljsASE86nJUBg=
X-Received: by 2002:a05:690e:1447:b0:664:ae6a:ee9 with SMTP id
 956f58d0204a3-667d7be0259mr7772187d50.71.1784011112312; Mon, 13 Jul 2026
 23:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
 <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com> <alWsBzShn4sgDRl-@u94a>
In-Reply-To: <alWsBzShn4sgDRl-@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 14 Jul 2026 14:38:22 +0800
X-Gm-Features: AUfX_myWt_NEQQv-BJRVLkgSebpkvKsdZl_YXe7JCUgTiKFP3vZHGE0QBxAv-Pg
Message-ID: <CABFUUZFJ6N6uC3kJM+qRcMFk75S2+6mTK_+052u3zdscz=DErA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:32=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Mon, Jul 13, 2026 at 01:47:18PM -0700, Eduard Zingerman wrote:
> > On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
> > > The raw_tp_writable_reject_nbd_invalid test relies on availability of=
 the
> > > nbd_send_request tracepoint, which is only present if the selftest ke=
rnel is
> > > built with CONFIG_BLK_DEV_NBD=3Dy and the kernel built from current B=
PF selftests
> > > config lacks.
> > >
> > > Without it, the bpf_raw_tracepoint_open() call always returns with -2=
, leaving
> > > raw_tp_writable_reject_nbd_invalid test always passing without exerci=
sing the
> > > checks bpf_probe_register().
> > >
> > > Cc: <stable@vger.kernel.org> # 5.2.0
> > > Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > ---
> > > Not sure if fixes tag is the right thing to use here, so use the cc
> > > stable tag instead to get this config change propogated to other stab=
le
> > > branches to make stable BPF CI's job easier.
> >
> > Shung-Hsi,
> >
> > Thank you for figuring this out.
> > I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
> > from the test module to avoid the config dependency and let
> > Sun pack all of this as a single patch-set to simplify backports
> > (if such are necessary). Wdyt?
>
> Make sense, that's probably for the better.
>

Hi Shung-Hsi and Eduard,

Thanks for tracking down the CONFIG_BLK_DEV_NBD false
pass and for the test-module suggestion.

I'll fold everything into the v5 series:

1. Keep only the necessary effective-start check in the verifier fix,
dropping the BPF_MAX_VAR_OFF and size < 0 checks as Eduard suggested.
2. Move the attach tests to bpf_testmod_test_writable_bare_tp(), use
subtests, and remove the NBD configuration dependency.
3. Add the PTR_TO_BUF negative-offset verifier case requested by Eduard.

> pw-bot: changes-requested
>
> @Sun can you make sure to include the follow tag for [1] when you send
> it? Should give a better guarantee that is will be picked up by AUTOSEL.
> Thanks!
>
>   Cc: <stable@vger.kernel.org> # 5.2.0

Will do.

Best Regards,
Sun Jian
