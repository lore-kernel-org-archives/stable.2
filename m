Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C71560AD4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881249; cv=pass; b=BjhYj0LQNN7DtMFjWjE5Kbf2iz/kM1+oJ2F4DTxOdReOX272vT8VLU8L34njdF9E8b0bXTTq5VeNRi4IrggL7vW1D46eY5PM5Fyo2CD+vfkZwGYNAUFFlbZ0DJlvrmlUWHyMDgABYPc7mJEhju31BKfAqafxpKqgK7fKznGKrAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881249; c=relaxed/simple;
	bh=NpWv1MGIw8lJhJkXRWnWsKfLORSzk3NhbHC5pDb1BIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGSby6b6bT/DsoW3+9de6b9nPRivW6lJdcULhGcYJUG3bEjcBWsKs11v/enWaYICg1cA+xHlpu3La67mb+JgiebFhdqsKVz2bX81mioPIlP4eLJXstxmKwRTQD1pL5/SoVkkP1NHUVafiYsRALVrthmJYQkTzUsTYd/wsTX73FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1p2XThJ; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1p2XThJ"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-96723c7151eso1082197241.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881240; cv=none;
        d=google.com; s=arc-20260327;
        b=TxzKdJUFSi669VI/+hgRpXEiZ573TRQGoH9YV8DzRea/4oagQ+40XLoX2lBsuZdksZ
         7xsQN7e9wfJb5WDehC/NKkrID1R9zZcAoxW/sHCjieC/umou+HttzCUEKOkhxTb4WzET
         /HeRA1yTQseJuCOi7evvVxBGXh1b3ovVdDCg8PyVH+Zy1NNHvas7kXr3/Zwph0z5nbxV
         4/l1BXDZHX53ewYcjGFw25h7KJp9aPt+pVk1dDQFCNB3J4nqhryJO7MdU6P6HObDYDfo
         yNHIqOpRVHYBocMP4sF7CpiAynWQhsAcBqvXWbfROI580Ur9Z6Iwh0tggxThVwAaB5LD
         widw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NpWv1MGIw8lJhJkXRWnWsKfLORSzk3NhbHC5pDb1BIw=;
        fh=Ro6c0SrULzKKfe7lt6+lDGPtXwrNbjozcqjTcZVA5rY=;
        b=p/WxlSDSuNPvFsInuHimVwyIsbV5JwLaHv89aWWduVs+MYOsbEW/rA3IYP2iNFqyWa
         +2Yz/mQB1rmjh1F74odUGqb/tZ7Rm6i4df1xJ1oqcr7/kihr/5VipfXhQWMxRjmr7z3V
         IiSOIf3iR6CWB7N9Mk21VURYMNIh/lq+Pid1iNW7UKf5GXl87QH2hnuiPJUElxbhJk41
         p63zyCTUl+kT3LqX74JyAuenWuRK8J9thyyVo32tteCLFOMdsJdCYJ0QMkIckk0j/iu/
         smtyeZf5eRt+SkLVmlNjolMl45Qe1HXMASJKSJNSh31SaHlCdzlEs76bteFbH/0jmB+L
         gCzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881240; x=1789486040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NpWv1MGIw8lJhJkXRWnWsKfLORSzk3NhbHC5pDb1BIw=;
        b=N1p2XThJ7MPQ6W1JyiFLQjAPF/zeq8dAeqPk5v/cmim9EYeAw6l2VzIbg1SFi5F1ui
         Nu5dnWjC0X5SAmJje6Cjo2T/LF1DjtadEJqtK4JraJa6WqS4gupfpIygNr9Vvn4C96Ai
         5ZI7eVczrNP+aRAm2g8zvhYaAPr1VHCuKGOetnc+u0I7Hz42Gzhlj168GJWfCFH8fNs/
         vWkddnQmHjM4h8bMaZ1Ov4PiTQ8JjztRPcL2oSuyUjmKrgQpbLipvas6fY6QjQIl/zXl
         coFTwYE7UTLdSZ0telsICJ56f9CErE+9ZQ47tPgMxU1eEsHsj1l54q9XJ51JILjiQuat
         r8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881240; x=1789486040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpWv1MGIw8lJhJkXRWnWsKfLORSzk3NhbHC5pDb1BIw=;
        b=UVNA+NZ4BjfPUHzDrrFZvKcpiu93g+vnHeSaz7wCTZ5z88tlUK2vEfCYnOMDldhODt
         K4p3A5iUoRdwJ+cALhJue00A90l6Kzdv3gTQHOlnV7shvxXQ/kWp+DDTUYr4inwQGV5Y
         3D/MGXsAwdSiE/9NBFSg/YQvhg2RyAj9Wv3p3PRnixwG9gDDnbL42SEXyfSL66dd/iFu
         ZrPYqxMIlnu+TBsdj/f+zcwVkRcKuFiNam74d7m+CoBXFDyl9CorjYXpKUXiUnb9E5BE
         YQ4LcleLurJS+kRpKdqt8tYMF5aKwhNR3TA5+mxBlpvVLVrTMcApBS35ImKp8GdMFn3d
         KZSw==
X-Forwarded-Encrypted: i=1; AKwUvByZIRi9rd2pZuc265AVFuS33FKBEzN3+r/gB22A75NaAsllK924lVC2KrF5nmhk1w82gFdMLXw=@vger.kernel.org
X-Gm-Message-State: AFuF++kr2DMBtRIDXsm2KcwsE8J0XjlglX6EXx6p3dCbw4CspKMMDN23
	MJpNh24Ljhutp8BVHjZcDI4jUSCwQfiI19zaJbAtPn7JodORyj85UVQmo00cDlhMoHkp9GCLF/2
	g+Aq05p7inms9Hqcr94fuD5j0x1D+jV4=
X-Gm-Gg: AYBFou3Ggaw2asYudBDVrf+9yZi8AcLKrhmq0Vuo+f8DHlHgtyIsyEYhzwF/V+QN+nH
	MMDd4fiFQLXNoghuVUdOd70JyttFaj0U835gGhPZUj0QTD7XIbW5yIUY3GOiwoMXDLhyL75upqL
	j5L6f3nDYL1pIhYYqH44cJzjTJu6oZ5NnPeXVn4krUFSQ7+/MVyUBIZmpi6faYi3BbHa6CMJEH4
	Uhu7Bq//Fs+QnEUyJt7u4eiLQaUCLoK8V6Jia+rk2EWbLNCnpZNOaR/JedSnl1XdhQyD0jmn4gL
	PW4VCmUtORtCLhwFntwvKB9IFLIUe82VI6p90KhKOgovJn4Mze1WAPUatuWAJUU0Oi/2LjcqcqW
	zkmv0pmmoyAL1v0uV3QF3vDPVJwJNkUL+IwSrWIammdtlSzIi7Ocrw/3aq8NPid1xZgdCysENkD
	9JcwLqDFZf1NVIZqJV0G4UsPKNEsKI0KXR1t/Seg==
X-Received: by 2002:a05:6102:3b05:b0:78f:7135:b4ff with SMTP id
 ada2fe7eead31-78f7135b567mr108498137.2.1788881240558; Tue, 08 Sep 2026
 08:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-submit-sunxi-nand-ecc-step-validation-v2-1-6e3ba6200948@gmail.com>
 <87zexst5ze.fsf@bootlin.com>
In-Reply-To: <87zexst5ze.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 8 Sep 2026 09:27:08 -0600
X-Gm-Features: AcwNN1XTfSZyHBIe8pqnaVApbMCPBzAi1LuuzXv-U_kf3BpB2aghA9-Ue90Qud8
Message-ID: <CADvTj4rFxwgYZgKzcHZG738UV0_94gxG1Dhy--ET9jC=E1dgoA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: sunxi: fit maximized ECC step to page size
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:03=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hello James,
>
> On 04/09/2026 at 16:39:27 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > When nand-ecc-maximize is set, the driver unconditionally selects a
> > 1024-byte ECC step. A NAND with a 512-byte page consequently produces
> > zero ECC steps before the available OOB bytes are divided by the step
> > count.
> >
> > The older sunxi NAND controllers support 512-byte ECC blocks. Select th=
e
> > smaller of the page size and the preferred 1024-byte step, using a
> > 512-byte step for a 512-byte page while retaining 1024-byte steps for
> > larger pages. Unsupported smaller steps and controllers without
> > 512-byte support continue to be rejected by the existing checks.
> >
> > Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> As reported by Sashiko, there is another use of 1024 down the road which
> must be modified accordingly. Although, in practice, 512-byte page NANDs
> have disappeared for quite some time, so this is a theoretical fix more
> than a real problem.

Does the v3 I sent look like it should work?:
https://lore.kernel.org/all/20260904-submit-sunxi-nand-ecc-step-validation-=
v3-1-931cec317c10@gmail.com/

>
> Thanks,
> Miqu=C3=A8l
