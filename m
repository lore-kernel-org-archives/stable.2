Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717133321C2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058364; cv=pass; b=Q//mYzoGpxXMHq3WL+ZL59vlPz7DE/upMqqG7Hx1no/iP72aIcgCbs+yxXDgrDkVlErNaM0P8e7s3LThhEXr4zrs8tBfuqmiUCQuSNCUyhZIaPqAzXDGit4nXmJG9V6VtkZnEhPqFa6hcP+RjlS9+Ul/HzewCmHP8tPu7m2Eg/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058364; c=relaxed/simple;
	bh=NWlgqNLKweH3ATk1geLVbMIqFIA0/0ejdghv0i1bg1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiWTMkepqfGRzOp3Kr+Rt+ccf2tzJucZu7Qder9J1AGwW4DcWDI7bVfWu8IorCYYCHc3JEBz7N7cRtFZyB3OXkjclsJcrLzjPEPXtkOZenjCTwT1J2srAUIIeIQV9UvpluzPyxa6+X3lvJ0RbkNtkm0jITCX2fs/uGgVzYhD0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOzihiQj; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOzihiQj"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-66e4aa8d881so3872802d50.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790058357; cv=none;
        d=google.com; s=arc-20260327;
        b=qfYqfGBCNaU2IZcIvcPEdxXdO0DzqJeCJNChVYqLg5qq0ooE5ACsaN/64poj3Ty7zo
         AufJttfQc8OQ+TGxSxxk7Kth/pcPMyS2JXQ21SWiGWmhphZx2yYeHw+AUa1I8ZIM2PIV
         qHEIaAhoxk9qA2etUFsBqR51Tosa0d5I2KRtg9UdA8U4T113E4ZuthmT+sFjKmKgM6SL
         c9XURWEPZE3j5a1IfZb3ztdWRNUeHr2Fli/zhyfOHYPKkkrfV+Rqrx1IXOeNHDb+UPSx
         LaYGaeja0UFrB4mpbBvZp4tjizlqktkndr5zRd7p9bqA509q+Uv+eHmT4V99KN+oYEIU
         TX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E+nJqAVEVSsrZdHd6yhOuTvFgC2p55IdzmRHZTpxGUs=;
        fh=DuKSTS1qEURnOytlQE5/F8UFSjZLoV+/qfXUE4ee0TI=;
        b=Tgr5ZzUIiQpXSDRIt5Q/Ut5Pwi2hG5xfzWbhpFBcu4bEj6IbUtGQet0sJb/aCk5pjy
         d4Y2hZMVhJIEjpd8pGaIw9/y5WsEAD1/UtvgrQneznb/FT8u9XgSIfjcGp1k7BE3aNnu
         OmhWwjgL0pKZBFgYCAYDHF1t8M/lZ2cm9mhOU3zc0lysz0+B6Qb4FIjGj13ijPYonEs3
         +J6VEePlrTA8pMxTcw0v9iHugbt8J80yYssWueAgxbtwzilYMhG4vx5WsRhjft2C8K9W
         TZkyLvAO+P7wshaerzxV9+C6N9cd/+sGdmI/KjNV7lxAWeFYOcHp6MXjDRyms1/NqmwR
         Y/nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790058357; x=1790663157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+nJqAVEVSsrZdHd6yhOuTvFgC2p55IdzmRHZTpxGUs=;
        b=DOzihiQjXLcJm6qn4b+5VvGgcptfWoDu7cL3i6R9uTLueh0OVXRSlxOj7KtD4f1J4d
         1MzKAIY2zpavA+hc0nLxtp50gX6zdzyuvDMCuaPUl94rD5HzYAW6320pdNmYGfasP+M9
         tNhDiOTlteUvOAVlVy1CDTXPox6q/z1YYpAMIy2qiKU/URtS4WGHakzITp/ExFxVy3eC
         qCPyu4EDQLJo9m9eh/cejwGZ8vwXOtt+5RrdoITQFrOqVQ5AfA4sngw6y1viLhBcKI4M
         /JVoSPoIGW+AexoRPFu/+BCxayYkRkpKXZH/FvCiRMKmlOTQzvqB2dpSKygjWt3jtGEj
         lI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790058357; x=1790663157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E+nJqAVEVSsrZdHd6yhOuTvFgC2p55IdzmRHZTpxGUs=;
        b=IOjpzJ2NvWvOgfElxQ6mmbAWmdhRp1Gz8IaA7qyCAYd0Aq++nM8bqj7sgfA42MfM0f
         ExBauvG7g6t7RIEensWMNbUtC7zHJDd+6L9Os1etogxqp+wUSm9LYJITEK4dVWMLw7d0
         uS7HmfBRkeAxJWtgY3ENUu/9SZWYh8rAhlSJDT+jtQ/1M6W+MXeWxTFuqJADBCLbddwj
         aPgnRhKli9HPUYXLl3UukvLb9fj1gAEGaszbLSWL3D/TE1zedXeeKZup7mRKc/BI/t/C
         UA9WNNtdGnCJGSIJjrESJLMc/6KErvT00gufSUeJU3OEy1H0DwzYGDXf2ed6mq6js6ov
         gqIw==
X-Forwarded-Encrypted: i=1; AKwUvBw16jzEcKQNAiscUEUZeJSHU2DS7vFoz3gFB3ZG+3DsS+dlhMVSlRnFDRz+GgApgYR3DLPoyto=@vger.kernel.org
X-Gm-Message-State: AFuF++kaoW0apsvuLuzGmL3VPUTf68E1RX5vhojlftGFW7ZtRU6Wo84J
	M3yD+4NKwf0ceavmjsaH5hl04Ap16zWzb3tc+I+9pTcM28FQrmqEDX3+56XiNlAQIKSMbE+sa/9
	Ixcj7tnHe8IPYMopYxe/tmSspqrNj+v0=
X-Gm-Gg: AYBFou2oZKn3m/+9s0o4UUMxuyyFiXxy8PrFu+qj/HBkEiWANzGPDt6ACdCTi2kHnAF
	Al7Cfm8RWatw67jYWOsudA99nWylFrmPtL7m7QI+vFFIIc0DO3kggkyqtBBr5uFX61OsJfzg89A
	QmkYh6ZIjlf42TOSFHyc3HkDwFagzC3I+F8r+Dg52OjIGoQ6ECjB9hKRcAywpnlbY2h9iBr1NPK
	tY3IrIgF3VfKvOeVbkyqc/D0OESX6w47Wi2CoVGudmKua87Sp3yEd1CAGkYC3kmDv5cZaKukkeI
	VCOw5+enmtvAJpJ6tV5h1JWjt50HYwtC/bdjIOkqaVy150x7RbVVrbhG+gvBH15jT5xHzw==
X-Received: by 2002:a05:690e:43c5:b0:671:471b:b94e with SMTP id
 956f58d0204a3-6717fccee36mr3255064d50.39.1790058357330; Mon, 21 Sep 2026
 23:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
 <arFKFmkpldopUIMI@quoll> <89bd2593-e0ef-4b9b-8c9b-833aff327a3e@kernel.org>
 <CANUHTR91qqHtCbaFHSqcMa8eZuD7EnTqyFSfDMwX=LsiMiHoEA@mail.gmail.com> <20260922030548.GDarHwjL6ocubz8Lzp@fat_crate.local>
In-Reply-To: <20260922030548.GDarHwjL6ocubz8Lzp@fat_crate.local>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 14:25:43 +0800
X-Gm-Features: AcwNN1ViMdpAb4FKUbrVTSa-026gbS39xDlV0FFXJxS0Xg4qeiM5sdxARfwH7qw
Message-ID: <CANUHTR8qLrArRSgBrtzbeqnqiOsXNUXsXQ4Lxsta8HOUoxGsqA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init failure
To: Borislav Petkov <bp@alien8.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Borislav,

On Tue, 22 Sept 2026 at 11:06, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 22, 2026 at 10:11:36AM +0800, Guangshuo Li wrote:
> > We apologize for the pressure this caused to the community. We will be
> > more careful about organizing patches by subsystem, preparing proper
> > patchsets, and following the kernel contribution guidelines before
> > sending future work.
>
> If you're wondering how to really help the community, try to review and test
> some patches you see on the ML. Whatever you choose - there's no shortage of
> patches. You can even let your AI run on them and see what it catches.
>
> This would be a lot more helpful than only dumping patches on people and
> waiting for review.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks for the suggestion.

Best regards,
Guangshuo
