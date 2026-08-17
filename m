Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC308330B0B
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966077; cv=pass; b=IV+VRQODoJiyYNvPCTnMsGZY/fyj+Mam+lneEygqnsxDMmMaQQHnVTGb+4y3cQzap0bQV4ucvSzsUknMC/U/p6HZKz3aK066GL3QID3WuO1tY3kiJALNiBOsMZZ//Hlv3k1UbURFBBnfH6Y6hqrefbYYhS+Nl4OoCBGoGr/+s9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966077; c=relaxed/simple;
	bh=/ebIgpNA+MjvXNkdAbOZa9K3g/95qLqHkMH2RA74dSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ++0oq+Pg7VequninqVYQMUrnH/c/gjeakAclR24XC024KwWQ4n+saLJqCPWF74Q1ihMcZg67QONv3xBgREHvjDn/jRJ0gtZg+M3e7QFmWdABTKE6ADgwn/NxCc9du55PO/BP3e4FtKV6UYX7HNQTgFydYSswtnuwtuPvWS8fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czEgbpAx; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czEgbpAx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3961324a91.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786966074; cv=none;
        d=google.com; s=arc-20260327;
        b=hrVlIaHFrmL4MHLDTnD9pGNKHRJvic7CyRk+Ez72bKEqEXW3eJzAakIF/f2+Y2xeb6
         e9MBV866v/VnKeVIFou9czEr9CKjOilqbV/eZhZShrXMbwzbEFs7GrWJ2Js7bvOlSOw7
         Q3QW4tBlLGtNgodWkRJMv2gNkbKucutm9+UTrYUG2dcuid7JwPF+3s2Bx6TAPS3XrCzh
         FlSYODZu5Ps/ctBkaJbYd+xFb0l9SsdWooMOfyswml7YZDCk/SbI00tmAWG7HzWD8Edi
         2mnv9KRVb0FCbfTOmDyHtkZyR3UXE4LTia62Zxqfqte3R75Ag6cOOPHkv/x0+OLqxJ1C
         nK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        fh=tIu8cikXaTEAN4ezVZU3jb8fJQIkpNFzhTiZm9ci8Ao=;
        b=mpV8NcnXzHR9MGsUhex+zAJVWj4zu1RS5lTfRaohlu+9nyb6N/W6Qj4fVA1jaEyqGz
         cgWGopv1XOSapXXjokqukJu9C/ofhfvLLWtWiBnUPBdXk3V+hC23oNfdH0g6XlNDX0+L
         mmdWr8jc5DfgJNG/chVGOZ1lOXRO1sxdI7ikHHRaVobUQa73UTOz2zqS5bvx59wdzsa+
         J09BcwnSlJLOZMqpVMDyK3fgrUeGdWwvcIoHK9zRYEI1NNnawo0B5JtnCjPFknKyL3ZR
         Nfkx7b6fvd4WaS64tsfEEaGLz7Sku8poTrJ1dWUX2rML1EbOiTngX6Azg4cOHqfRaG7V
         WvUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786966074; x=1787570874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        b=czEgbpAxVN/OzmXMFMVk1WAP642fY4qLVzxRQvsHWSDeLcTySNpk6a1CUlBVwpkBX3
         cOvlgPWbVya1dtiaaBOHRqSzoA8xQstxebTRE81+BUsZ7wd9tSon0dBKKQbLmLkzdurJ
         6SieZEFfstA9wi9GpZJNYdDrepHvX8KMDsPPTSkOiDf8OFby1Hm94r/0CGUbQq+qaQoC
         UvPIg6AJ6NzcJ40iIR3WmM5zK+h8/dHPMsN8D23btiBwJ2PEq4zozW47xnLQD0HAJeNq
         CRJ+ek0+WFBzLlzUli/tSecAaCnFnzpB7jo7fis+sztcGmsjoVkcv/iTcSlm3NKRHV+/
         kpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966074; x=1787570874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FnWCUzpc2hGcsgmvu1JYUerITuSwcRRCsK5vmeDMJBA=;
        b=akYwZbko9sZUOYdJorDJ/pwsbzZyvFcVdtqXdxk8FdCvPPc+eF4KCZXh5hMutmFoLG
         Apl2T9nh0pWL1JWcpAnFb5Fb14wHASPQ2Qs7ZCqCxXNYOP/vdJ0tKfuSBC+eVKkUPeYq
         6fdy6aWA227jmENhUNsnhf6/7yxdQ8qY9wKdMkJrsGo4l5PCJHG2ABYxO3C5Muc+WaM2
         I8Jv4Jt8SRgdGP2p04N7ayiPMsrXI4avC7I842EnEA4ZFrMAADvAp7mdxgfCIxoE3BkT
         ph7lc4npYyBsJDVRFfsWoU8dlBEMoh+bAR++MUIhAZGI6IT04S6LI93Btcj+NojZ+mlR
         oZdw==
X-Forwarded-Encrypted: i=1; AHgh+RriDhiECqnZ2xQ7+DIkweBXFKW7WlPzRK669TFepbI5xmaqGyGxE1mdsVNVXGfh2GcN+qxgNZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VBblqGVWjM4Do0xAFPwW7d45xpfsNcG84t7L93Cbr/ule4cp
	1/r+JJyEwCsB/xYwWvXESb+nvsFmSgRVPw+lkqDJNFEKMwdnZrOr2mvG9eK48scUuDjtLDWOM38
	jdUbAbAJ38f2VLZhmk4O3IBXbZWrjnzg=
X-Gm-Gg: AR+sD11wW7RTO4n7pvK1rCX+WSOumvqeK7t8zCV5RY9EMzQBcwtHp1MpJl5Lx1s5w2b
	W+vvRI7OZ5LcHY+fhNZEj++F/OmszmyDzzSFXBc2JcPnWbW4k6jak5QWLxCjPPtZA04FV8siK0c
	2urp0citQZonC+WWe8klaBnqAIq0euNxMnil36g9I10eVoI9QQsdlENTA9AfkXfKiv94EAgXhMN
	8IcDL0WDyjjTOed2qNosWAzL0gHY0bsd8Vfw1zEmViISgOkgAEfqW3Jzzc52yryXOjjBcJytZ8r
	bMdABcDX0MTH6Jlon6UHtvXKCwmC2+8U0H9rPYb6lcYAJGlyjrLErtcinDUvDxGIMAZUgOWNffC
	ooQ==
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc71fb5781mr27074633637.24.1786966074030; Mon, 17 Aug 2026
 04:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
 <aoLbbZ--FrkVN3SU@stanley.mountain> <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>
 <aoLs4RsoS7bB4v_2@stanley.mountain>
In-Reply-To: <aoLs4RsoS7bB4v_2@stanley.mountain>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Mon, 17 Aug 2026 06:27:41 -0500
X-Gm-Features: AcwNN1XuZgB0WlpMb9gXJ4QbT5QzpE2tg9p_k_kFF7jOhON2Dj5Hn65jFmOfAYs
Message-ID: <CAHYQsXRnCYkmVyjB8JbMH1M3yQY4durhVSjhYGOo93gHCeLDcQ@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
To: Dan Carpenter <error27@gmail.com>
Cc: moonafterrain@outlook.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
	Teddy Wang <teddy.wang@siliconmotion.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:13=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 05:49:33AM -0500, Yuhao Jiang wrote:
> > On Mon, Aug 17, 2026 at 4:59=E2=80=AFAM Dan Carpenter <error27@gmail.co=
m> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wro=
te:
> > > > From: Junrui Luo <moonafterrain@outlook.com>
> > > >
> > > > sm750_calc_pll_value() writes pll->M, N, OD and POD only when its s=
earch
> > > > loop finds a divider combination with 0 < M < 256, and returns 0 wh=
en
> > > > there is none. ddk750_set_mode_timing() discards that return value =
and
> > > > calls program_mode_registers() regardless, so sm750_format_pll_reg(=
)
> > > > reads the four members uninitialized and pokes them into PANEL_PLL_=
CTRL
> > > > or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a m=
ode
> > > > set can ask for a clock the loop cannot represent.
> > > >
> > > > Consume the return value and reject the mode; hw_sm750_crtc_set_mod=
e()
> > > > already propagates a non-zero return. Initialize the structure as w=
ell:
> > > > sm750_calc_pll_value() returns early for SM750LE without writing th=
e
> > > > members, and returns non-zero on that path.
> > > >
> > > > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > > > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > > > Assisted-by: Claude:claude-opus-5
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > > > ---
> > >
> > > Greg is not taking AI patches unless they can be tested.
> > > https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/
> > >
> > > I kind of hate AI commit messages...  They are so verbose, confident
> > > and reasonable sounding.  But they don't answer any of the real
> > > questions I want to know.  How did Yuhao Jiang find this bug?  What
> >
> > We're working on an LLM-assisted system for vulnerability discovery,
> > and this bug was found by the system and checked by me.
> >
>
> I feel like this is always part of the story and should be told.
> Regardless the firm rule is that everyone agrees on if you can't test it,
> then that needs to be in the notes under the --- cut off.
>
> (I sometimes skip this, but I've been doing this for a long long time
> and everyone knows who I am.  I should follow the rules too.  #shame).
>
> regards,
> dan carpenter
>

Got it. We will follow this rule in the future. Thanks for the guidance.

--=20
Yuhao Jiang
