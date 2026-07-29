Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28930674E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292247; cv=pass; b=LSEH5UPCr7AC0gQA8q+A2xFhvVKofYc8vbExAzKlKmjUEfsqZMu2yoehCZnoZhDJJxN5wKw0l0VQH2BCRw8dinKoC7CqKOfmOG+BAtIfD+uI4pm8WNtF94zvPDUuuSK9GMO6ijb5+284H8DBFMP4x5IMcAd+9gqpr01Nj6KLFD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292247; c=relaxed/simple;
	bh=fjmeDSFBaxICN1Mdf/QwOr3QjNA7gTxVSUsHrdBoxjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucx7cUWvsaTk0DkiD/RrPQ3CArnEI3wFThAFAy0UZB9WnKSAJrZnlADRjhZ9cgP7bFcWh8gNBIwVjsYFh7435hUjx0GnEGAzh9dypwOOmD9A52YUl6olecq1W6GtoS5bw4Zv0QnqzUvg/Y+kN8dn4Chn5fkrSRYmm52kHGqxjmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABZX4qLx; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABZX4qLx"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so880801a12.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785292244; cv=none;
        d=google.com; s=arc-20260327;
        b=ehSdo7VpNxi6TjsMmqqCOHvDbLCJnEvFfGi5DHWGoUUMz9O/BI9QbWip/FsAdEEZzK
         rH2mhD+rKnKXoUYXcMO6n88BeEhgRG2LaNHX6hnr8UbPWz6ODINDVSajIIk7ARNpREtH
         eNubUImhthZWN3JoEbAiBBGPTPqfmPiTFGB9sxgvDbVRSfdwJ+uHU7m/nRumpyjwsdSL
         PtwiOGVLucUb6JQFLDJOIv2cdTuu/MW2FrUIhGMocmmPq8A1jcCWaRr0PY3oRfrKmwLx
         mgGNUnCFZOkcz2C0M93zht2Cj8YF52yISDsVuj/s5Be1WEnk4NrcQlOIMJLUM4q5xU/H
         TMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        fh=21o//PUx4eAVOl1oKHUT/hvGNit0IZyuiDomrrHZeDg=;
        b=OU9V0vA2bdhSWFpq2l7LEh83jecjpGscnWeItg4XjZ6GBTrMh0/BTT0wmVvsTmThqq
         YWMmlUjv2MXqVMaFEvqbEvjlNfTxIZpdXF3NFN7IS0ccc+HIh5u1F5IBQvGDkWR8OLww
         NqgTqOnYUQPYpoxOpaUZjzsNqWiuverqg4r17q/KriDEWkFwbA5hNRq58nnJVwBwCrFu
         qNz6FiEJRUevRnTsRqFmPH9JK4oKKfHwHxXoNluNK9DlzXlQcWc3KvF0zmcM1mkKII2e
         3QE9TXmZsg53et0IoBtO27JpltEtO0FStTuSkIv0Ilpct2gUuarkdqTcsLHkU3niM7Ot
         Ka7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785292244; x=1785897044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        b=ABZX4qLxkYX25vb65AMxVLsJ1pXnrBS6E8Kc/4ASpQdsTta3TcMbp4AtAzpJPlBYf/
         7IudCz1EEwNi9bxUHdwN+FBTUJrflHo48S00Xl73dPmfMUX362E6Cs4kW9W7989wNzbC
         6Qe4VyWbYzNiJsMwR9WhtBs7qwXtWOkH2M5Y+xB2d6BuuusPjedf+89OF4fiP1BswUcK
         /HlN7V4eVevwH8fMbEF1YbfE5ksbH2YsXswCbCzgqUzssbg3AoJ+D4JaO/gHGkDVdGnI
         eoMzjO3BSFwdGyDQeSj6oyACmQWZ6sWzyHpg4dVoDa5MdqzjK8Ds1YT6+emez1y+OJD7
         JTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292244; x=1785897044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xO+zbVyPD4T3qE/wL11BePM0cGCMKSslJVdpCYIe0q8=;
        b=rY87+8DDejmOi352DcnknF9euPAUgP+tpOiE2V9RB/GPgNrVr2I+k/bT88m5k5YXZH
         33fvguErmX35F9Gxzn+gzzDlLSdV79bgT0y8/qw0i0ndih75oBxe7cyScrnkyHVc1H4k
         ULciGdNUNWufs232Va56PJ958e6yNNncQVeUrpB5DjD7GATYC+VClzhKrMckAHJd+mAC
         EjKE02CYWs3xAHFIIcQPZ6wQ1/0lFspTxmY8vQh6oDrkMR4iQknYvzPxeZ9KbHKy+OV6
         hwfhDSri3VO519bKjDsB+9Y2ZeUDGFzcDDzGt5WCCsT0ni6/JRUiGemYP+tBuq8K0mGT
         uTAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXXZKg0ypKQuBZyhC5ab4nFMlDiSKfpUCfSKjCosJRVgtjiTe08K5TEcuqeaEdoxQ5Tv+8SRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gUgTdXfzLFR4PJI3FepF+3xOeRiLf61oXrJrTikhuWwRZc48
	QD/iGzICViP0yeI7RUCuxVgZosuJF1fjgN1C9m22UUmHBC5yBwUjz8DcMForx0CnRvmbgz067kY
	fx0korB5FSIcsyrNZRyITdshpwFbznys=
X-Gm-Gg: AR+sD11dE5XbSnPO/S0LR2AcnI14Lh2kkCqBtCr5khHhNUsNrhEcw0jRjg1bppoGgJ9
	+NTihYBjwBN6rCvErLeyVVs/tr1dAvysjY30nqyeknT98FamaGtTED/kojZVHI7Y5Pxh4Fs3WsT
	PlM9hTzj9ENGYZNcuACMxWjh4VK6RjcFpnUgNdOfxVnaBt2jgaR+C0P057F9uwV3vlt7henMWH4
	uS/uGUSYShc4OqpV9b8JtK7Uf9uMg5tp5qVucwHXAukg4Cd+rqspN9g3rmaOXgIst1o9Sqe9FBc
	2zvTaYoMYZqCdYIPjEXgNqJgJ21ZXpiviezsfdCCLd5E7RD7BP5bWw==
X-Received: by 2002:a05:6402:1469:b0:698:3b7c:3b2e with SMTP id
 4fb4d7f45d1cf-6a052fcd957mr173743a12.16.1785292243802; Tue, 28 Jul 2026
 19:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com> <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
 <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com> <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
In-Reply-To: <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
From: Santosh Kalluri <santosh.kalluri129@gmail.com>
Date: Tue, 28 Jul 2026 19:30:32 -0700
X-Gm-Features: AUfX_mxVpg2ZriGy5QdqN1sNbku_hPFXDN8lM15zfP0uq9nPhGP4krYEF-iunX4
Message-ID: <CAFUOXOmP_bF+JL6gKsz5usmT+K=O4zFtw0MrCwi5CMxbmKRDxw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

I tested the patch-paolo-mod after correcting the hunk count locally,
and did not find any issues.

The attached patch does not apply as sent: hunk 5's declared line
count does not match its body (16 vs 11). Could you resend a
regenerated patch?

Thanks,
Santosh Kalluri


On Tue, Jul 28, 2026 at 9:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jul 28, 2026 at 10:03=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> > > On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > >> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> > >>> On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > >>>> Since there is already a
> > >>>> synchronization point for both reader and write while acquiring th=
e
> > >>>> fastmap_lock, I'm wondering if something alike the following could=
 work ?!?
> > >>>> (completely untested!!!):
> > >>>
> > >>> Your approach has some holes, example misses the most dangerous par=
t -
> > >>> destroy(), etc
> > >>> I will mull over it and see if it can be fixed to handle all the
> > >>> issues. I think it's possible i just need to put time to
> > >>> validate/test.
> > >> I would appreciate that, thanks!
> > >
> > > See attached. Untested (compiles) -  addresses my destroy() concern
> > > eaerlier _i think_ (unless something pops up in testing)
> >
> > FWIW, the changes LGTM, thanks!
>
> Tests on all PoCs worked.
> I will give Santosh and Victor a chance to test and will post the
> patch tomorrow.
>
> cheers,
> jamal
>
> > Paolo
> >
