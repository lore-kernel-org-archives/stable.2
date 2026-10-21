Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598719;
	b=RE2/c4zzw3DcwoksJyZiZHqmmV4k9AwaEcIO5JKGzJf2OfAobXsJj9nfGdfWb+08zKBg
	 MZBslPn4XkZxjvvAjSGm23XxSjfLKzo1aqBZB5KAbr56Bp9ztHxlT5YiChGvWKAajAGo1
	 V/dHqT8MIUF9ZMtBnEx9no3jTL5xc9wW8Vz6jlUROAYJjpssF3GEGIGzn6W59xUAkpZ60
	 US3vqrdW9KsTPJyssIzcu5jJpdjI5qGcofY+wLN6jSg0G5rSllfhp9xuKLkpVeK7EbPow
	 /nuGTSXN22MB3uFcYe3Q6cCJVVM7SZa+22UgDB8iW5MLUQrUqrpOxh/ZQWoHI4uY/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
	b=xGD2rZSQOwZR0eGF45RC7C9pUSefAqw66Zp+vWP2UrApG/aNdlKxNDvjQZT7FDI3nI/P
	 +1tmaKMBiZ+53pPMC5X/Op7pIhyHEIqAm93BoLCVEBDsrfPZgHmtDS3GoLBMBmP8Ct29v
	 ZQ7hbgK3+1pUEKS+nNnrsIvEF2b1KDFKSkbcwJw+B4cZnZRPfg7Z/lIINrJTXx4FX20wG
	 AwZml3gKk0FazfKKPdw+vLh7FNg3NfFguhLstP5wKbvg2UT2D8sIyY0Vx0tMfY5KFGVZU
	 dum7X08J8X9KenhmIpmPfRIS4cpHtwAQbxe0guFL3nVhrx0uL2zi7BismcWQkTd2vcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kC+JIqff;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD9606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DD9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kC+JIqff
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c413dea9ca6so138821266b.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598717; x=1793203517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
        b=kC+JIqffK4rC46rQzGkmweYrHwrBuORYof+4Q79ymYrFiYUH108zupB7/K+ZHWFvg5
         6xOMEzcIQKk42FqsC9rXViLfn/HI7mrYkiMCwCjy2GLBSIHSe0jlf9ikeluMqB2xJCvf
         wuw08XQMARxGWnTiO3lAYlKBfESmd88wPoPL7a3CpuKi7CYtbUDBE+cz55xyBQx0hlxN
         OHpkYrJGlCPqGb7vqH8696iSHlKSLDP7PRnmkwVILribmC4FvskE5nRy0nKReHoeTeXY
         Ou9d9YdojPlS0rfqT4vfA5lfxBlWF6zjswU8Vkd/PQThdLBkIpim9CpG1Gp0SWIJnh3j
         nwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598717; x=1793203517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
        b=v+mHYBr/7XtJjZywCsZcOlqogeSKN3S6If1oGj2tmbdhlK3Wf7EBnV5KLqwp6rN3PH
         YLexdSFEwU8+RM9gauRWsR4zgGyqaBN4XrXEju/q/d+e8fRo7HQDeWWv+aAsOG+N+WkN
         usUpFf6Sg1BVz+4WtWgEqoOllMrx7Uk9nyRtKs16wcPOIrjoCVFtFz/WspAgsuXCVgOR
         QsfPP3uWdkWnb57KJZ860zGcOfaQVo+QAy0O2jgD0v3Upc2GJfKcYSZrIVrGMT/kCiDw
         eapqFW7AKo04WAPYdApRZyNSz7BhUpS58c0BH1XhA7H8hs9rYX9MWdgm3D9AH01SJVO/
         ZKtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHEpPZoECEijgx3RbNlDN1Wed3LL/Ss1W/xW5rnCNIB8FEFsBkYqd1go+zrKPSY0LaJIAIe0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGmQNzsXzgGF9gsDbhterZAGsPblWpM0PQA4rT6+gHekJDHWWQ
	mLDIRt9CEdLfQKXHh5n7VbQAlqPeteG7W10e/QJ9z1oX5FPr+gFEmeyS
X-Gm-Gg: AYBFou3LfnsJlcc8qBEMnOHX5DfXCoLzrgMBlJWtj39VxVS77z4RNsH46intKqKTbDF
	nyEajJp8CcIBePFvMT2OvsmCSLHHazr7kY5ww4RGUBBcnbBln5jDdUc34XSFXneDotnQ2ZWKnFL
	fQy3P2n8FthLvWyyexk57+QXY8Mmikp/ukPwDqDHkKMtzS2AIcNpZKSXzOcEmXUykSP5JpdK5FV
	gB0t1SnPMtew5yrC+qLFl5EcFt1Y+BOmnpcrxtXSjLlJGJu0GsF4OHTWW34YE0a5PfKvsl6mEHL
	MOQF9zr77uzQBzDIlHsJVBtt0M7Kf3lH4etfiOOKh+9FSXuk+LJYJ+RY0MOSqjIXZORadN2CZH1
	TXHaHzrCcXryO8oVRRGbchz8A/yLRHvAsqe9V+UM4qMmpYkcmFMxHp7cfnylD2/GgSx8lElI86k
	eHSzzTGTr+zTcmsRMBn5YY2S8R4zMJIXLaoNS4DJsPTu8OuR/idqu2LXgUQapVwlPcgUqbA/KlX
	Bn5HTAf//98GlwX3Tuwz27O+94gZTuWgfN/i1RArRzc/u3otTR1tEKhM5qBy//uBPjTx9AEobll
	I++tvwyQfViWLtteNA/fmtF7S9hE1lZmI6RfzG5cmiAJdHlc5aPo4FU=
X-Received: by 2002:a17:907:d08f:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c4679623434mr231451966b.20.1792598716864;
        Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c98sm6093433f8f.28.2026.10.21.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:05:14 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/8] of: base: Fix stack overflow in
 of_parse_phandle_with_args_map()
Message-ID: <o4uzbsrfnpm4isk7kh7f6tsccd5qghur7vkjkyumgwrylvu2xl@dbeuv5cuxvxj>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
 <20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
 <20261020155841.59037c99@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020155841.59037c99@bootlin.com>

On Tue, Oct 20, 2026 at 03:58:41PM +0200, Herve Codina wrote:
> Hi Ernest,
> 
> On Tue, 20 Oct 2026 15:00:12 +0200
> Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> 
> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > 
> > of_parse_phandle_with_args_map() reads the #<stem>-cells property of the
> > provider referenced by the consumer into list_size. It then copies that
> > many cells of the consumer's specifier from out_args->args[] into the
> > on-stack initial_match_array[]. Both arrays hold MAX_PHANDLE_ARGS cells,
> > but list_size is never checked against that limit. A malformed
> > Devicetree with a larger cell count therefore makes the copy read past
> > out_args->args[] and write past initial_match_array[].
> > 
> > The cell count of each provider selected by a <stem>-map entry is
> > already rejected when it exceeds MAX_PHANDLE_ARGS. Apply the same limit
> > to the provider referenced by the consumer.
> > 
> > A plain reference to such a provider, without a map, now also fails.
> > Previously it succeeded with the specifier truncated to MAX_PHANDLE_ARGS
> > cells by __of_parse_phandle_with_args().
> > 
> > Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > Link: https://lore.kernel.org/all/aq1CSswlo57jZpMH@monoceros/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > ---
> > v3: New patch (Uwe)
> > ---
> >  drivers/of/base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index f63a9486b130..5abadab22392 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -1587,6 +1587,11 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
> >  	if (ret < 0)
> >  		goto put;
> >  
> > +	if (list_size > MAX_PHANDLE_ARGS) {
> > +		ret = -EINVAL;
> > +		goto put;
> > +	}
> > +
> 
> I would be stricter here and avoid the usage of MAX_PHANDLE_ARGS.
> 
> First I would check the arrays size to be sure that they are consistent and
> then check list_size against the array size.
> 
> --- 8< ---
> 	BUILD_BUG_ON(ARRAY_SIZE(initial_match_array) != ARRAY_SIZE(out_args->args))
> 	if (list_size > ARRAY_SIZE(initial_match_array)) {
> 		ret = -EINVAL;
> 		goto put;
> 	}
> --- 8< ---
> 
> IMHO, this is more robust against modification of the 'args' field
> definition in struct of_phandle_args or modification of the MAX_PHANDLE_ARGS
> value which could lead to some inconsistencies.
> 
> Best regards,
> Hervé

Hi Hervé,

That seems reasonable and like a nice way to do it, thanks for the
suggestion. I'll incorporate this into the next version.

Kind regards,
Ernest

