Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DE4E4C5B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774284; cv=none; b=ZmCznnyTDzcM2c6cWiknYZk08hN/WFH7uE2yAX485J386iYNShKur5tsbcWlpIFRafJDX4iNr+YroThnOVGotnazyv96mSNJMpSxlxwVXlisLctD1Dk8Jrq2Goo3bSpTSieF9r0nDKSs2dykJ61bEPkboIU383kwIY6NOzTSFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774284; c=relaxed/simple;
	bh=RPlStI4T6DBmtlwLNFGXO1a9HGvDVlORY2C4NARYEdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZsWsh9jBNFhVKPwvM1Qa25nKLTdNKNXPYHjyYin/c5raCbosEvq4gpBu41JHxYPtBrxNnhIn1IlfD/LejFPWqVl/6z1pe5KoPPro2TX8BgnoCfTT62PyWRFHl+GruiI9deCjmVppkTRuCJnnwwhHXk3MeneXootvFsbzW4jdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV7MA2nQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV7MA2nQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D31F0089B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774271;
	bh=FxyrFbIDAO99GJasIdJ7Sp1XctD4pjs7yD0DQzyO4ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eV7MA2nQFaDZ+nUKTDYhD6UrNycTMuA+dAh369a44Y7VyM3dizHWQfndOzDbfz6Yy
	 W7GrUVTlnaoIimzd4T2tf+6zVAcgJ4PCBBDYFNyeTjqvvVskjVAp2BR4t29Oi4fKYm
	 FI6wAMqcCZWSwdPbdj/Ee8klej9AU62Bx4XWR0r6+dWgZVcHXH95VwPUfR5P7dlQsK
	 csVjWM8xsdSGwYcL7SbY3DWnTa5Xk9a1d7wP9F3ZZMO8aM/lHUhkBK7Y+lrV5nvXoH
	 gbsuLw1TU1rAWGOM1XOEBoa2PDcCEQWs35LSysqmPU7+jo7AE08hNcOnI6CYo4pkvS
	 IWqXsee/f9rCw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6c8f6a53fabso1453866eaf.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:17:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkC9giUWo/AyT4I9z+80Qx8dPexbXgN+KTX38vkLcEF/uuAeirPEqvO6+uOGSotbQG/ruE+IY=@vger.kernel.org
X-Gm-Message-State: AFuF++lmLjAK3vTh8RkM7eSRinp80oDw1B1lG7TYLnFt60ZUpcmHS0LF
	Vd34J6JsuaE8S2PQMRN9MVn72xdysXOqpWbd+GKx96zg4vQHjbueOHFzpfew39O7fkFQaChZsoU
	Zn2Jv0uE2t0x3ZH41fEsiCfxe19g/yNg=
X-Received: by 2002:a05:6820:4c11:b0:6d3:abd1:9b97 with SMTP id
 006d021491bc7-6dcf6525a6emr1100268eaf.61.1790774270280; Wed, 30 Sep 2026
 06:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917135056.2153959-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917135056.2153959-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 15:17:33 +0200
X-Gmail-Original-Message-ID: <CAD++jL=6bofu+5U8FG-PPqdjL_VYYh5oNRJtY-ZT3Zp8B282Eg@mail.gmail.com>
X-Gm-Features: AclHuK-roK4N3HZhE9WekVRJ8H5Cio2_Fu_cQePi4YQjQ0SNOogyINHDJvz-3Yg
Message-ID: <CAD++jL=6bofu+5U8FG-PPqdjL_VYYh5oNRJtY-ZT3Zp8B282Eg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexandre.torgue@foss.st.com, antonio.borneo@foss.st.com, 
	jiashengjiangcool@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, 
	zmw12306@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:50=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> stm32_pctl_probe() obtains one clock per bank with
> of_clk_get_by_name(), but none of the error paths drop those
> references: the loop returns directly when a later clock lookup fails,
> and both the clk_bulk_prepare_enable() failure and the err_register
> path return without calling clk_bulk_put().  clk_bulk_disable_unprepare()
> only disables the clocks, it does not release them.
>
> Release the references on these paths; the success path keeps them as
> the driver needs them for suspend/resume.
>
> Fixes: 451bc9aea9a1 ("pinctrl: stm32: Add check for clk_enable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Patch applied w/o stale tag.

Yours,
Linus Walleij
