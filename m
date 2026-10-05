Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C34D0A05
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215294; cv=pass; b=LF8ePCm+jjSXWWZzK2tF2v6kEqInqe1TxTIE8sROaFUAe6ICKsLOgQ/GWFHgZmNa8OFJ9kOAXjVo4vuAWZft1oClVNzArcMHya3Zj6xabOUMMIDsqJyZ8QLRKU8IE2vyYfubbyalw4UkiR9aMFVJTA1krYJRcaV7lOP9DFD3Fw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215294; c=relaxed/simple;
	bh=lCgO+hyv0qYkNrN0rdtOfeWSTqt0Q1A4GeKqAbSb+WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svDM2xWDL8zKRkrkOeG8+PG0XifBBQYEgRlZMuApEXEL6WGadvJKSYApm2jnj9tUA756TxXvCvAwFMjGcjIbNlJv2n9naoujyJMvddDA2b9q9+JHVxiP0l2lzXwwGxfjKUYYDBhI8+/NSaQ7MbaiQmXCejrxkqBFxOhJ+O5LO74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SeIVELEl; arc=pass smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SeIVELEl"
Received: by mail-oo2-f35.google.com with SMTP id 006d021491bc7-6de31c745c0so432564eaf.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791215290; cv=none;
        d=google.com; s=arc-20260327;
        b=TlEQvnb57oiPoTEdxlUaBYKbVvFXDfXv83XJIZHKkWQ95eqRSPV0phMitkOqSlMZ92
         1cswd+nPjozcK2YQyWod/zBJf6CejJ6HFy7QPTWm2oMV2spHKqCsEx8IBXzf68fPJ9kc
         8Ydcs64eDyQn2ME762g6ArtMmPp8dlDrbKDglSea4azaSaIumVW49MpmmLC0dDnKnnxn
         Jk3eGtOJbagV3e4S3CHC3u05VT46dPM7zCeBYfTeUzLGGZYwISlwR4VsKNkiKlrWK8IJ
         vA1WChRTDoUXhMAT1kc0mg37Ubb/+lAx2nUdFOSY09wut6zcUvVwNBy0b/ZQPl7tKLqV
         xgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        fh=PLGMbPgZGJflMbNuvMd98LK12q6vKtbnlaVDlxFZ/+0=;
        b=CgakkJRqHV9pKBcw7YApqq02yfWvVUmKQfvuCzPDd9XPdivuwPJes+t7S5wVDi2Z19
         zJ3s9vMqVyFLuIOqz0uocZXNOJYDiZzzxujLYXHpq/o8o7MBJ52JKDxXzw5GmF/r1aTc
         RYP91fIN+DigOks+fEvLYN5fsAtNJPI2WDi16aDzdndU85GX9mcCjOQ6Ta5zrApAxvYY
         GMtaxTzRMtHefu5gtc3xGHJfudMk04zH6rYuwZEskBs6iMcSFTnMSX7IVGBJuavq8Ig1
         hK6LwPyKIZx+DgLPE450b9+eq/BSZOW5IzONO6HbsFaNnhm45U6OWpMXuPyVm5dTKstP
         fqgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791215290; x=1791820090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        b=SeIVELElWPNX3BhSmNmsQkJPhVTv5HVLRuMOp1+tVh1f+pSzRz5p3NfUJ7DdFHHSIu
         ZNzTpNfSO6ta0UCzjMV1BCmofjHl6sgfr8JfrtLAkgvXrW2U0307ir+A+JEke9ogSeiz
         QlSAmwz3A5N2rKExwu/BUoMTIHLKueoChDfyMQA2DkVwWvw5t89hel0Ur23HssrlO7q6
         La24Rn8L39Z1S8a+VYrrnrXRT1CNcIOO0loYlBBxMDQylAqtLJRrhFT+gpeSmICr0ZPq
         U07ZTzaZHMEJa3jz7KVVU4wgKMpu9qElzsPRR478fhj8825k0KpfKQv3QTLL7PKSuSyz
         tBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215290; x=1791820090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        b=SJ2VpEJFxTG83asST1aX+PtinGg8ri1358JvRvXZGa1ntNGGIY9BimCnzrs+YztWou
         9bnOs+cq9f0GQU3V5+Hdvgw0XbRMDds7fD9PtFyf86u32cxaCK4VDcutFlxghh2ntOFc
         OsWwBogsKFRAraj6xcfEc2qZU2bwEDzJPO7aoZG7JUZAUXJ+UjqZU3ezinVv2nQUQThL
         adglIuinqXBMcqG2mndcItgqn122+FL+dLqNw+1j9Uh/i7Ojby8C97o2bi2GkCqmgHW2
         q/psrBa/2P7k9w49kyiS3e3DprFI2OWAYAdvptMZkJcbzuYoMfthUiVehO1JWPXMEw5E
         Gc1w==
X-Forwarded-Encrypted: i=1; AKwUvBx/eFQJUa2EKXtldf1NIAYbwo9tYYzkBinMLFzWu/5DWp63Mjh9Ve4qi+MWK02VUeZtublXtuY=@vger.kernel.org
X-Gm-Message-State: AFuF++kWLyczw8ejf+BGV27veJ5L/n5CBMCZ1I20O/K6uxrOoJ341EGN
	YxCeUoFR3uXhoHhiMFTb4wIEIR9kvhbWlGhTKEY61pOIF5siIyl8uYxhUzDQdJIxw/NJGuYzOln
	5EMUglLpGg2jAHahBecXOnHSDMKRyF6x2SPAPz4i0dg==
X-Gm-Gg: AYBFou33MciSf5rSN4I134UcrF0lL3qLDS0n/uKP+sEEEJ37ZN1FOxpdvMbf44OKEKE
	m79YuzXjgcVUja+Ow80OhHoqa70n+huOCtHyQCz/PxT3nkOK8Xiwg4SLiW7y5fFlVmL3bsC4oqR
	Rwhktdn8xdSIFKZ5ZBxXa9CeRmvdJRQiqUqYb+p+1qbXsYyjMIsmJFf7rSYSlHj5UMnpSpSo2UB
	YC/wc/I2EQROG6Z433nnQphM2roxBTKoM4N2B72EOfcV/UOou1FTLULC4b1/7xkTtzMzlBsyhTS
	G1Tb0aUvQh1irGFws+n/PNWVWoAHZ/Ljh+JlRLGXthCD/AThIPNZxZ2wdrbNXhxY/4LHjiT40j9
	c+h1YJ5LT99YfGFavud8=
X-Received: by 2002:a05:6820:150a:b0:6d9:ea50:f44a with SMTP id
 006d021491bc7-6df357418abmr8292012eaf.64.1791215290453; Mon, 05 Oct 2026
 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002102447.148835-1-bruno.produit@trailofbits.com> <179093698536.1402591.16703491801413392699@kernel.org>
In-Reply-To: <179093698536.1402591.16703491801413392699@kernel.org>
From: Bruno Produit <bruno.produit@trailofbits.com>
Date: Mon, 5 Oct 2026 17:47:59 +0200
X-Gm-Features: AclHuK_EjtDLkxbH3jFds8cqgFV0udpfcmHoFvOHa6Bnt_BLajOkWE2xSjD_Z3E
Message-ID: <CAN3w+PN2rf9eg2h3qK1yc4bkvDHNpuDpKoo5nBWUQG=gCQ3nyw@mail.gmail.com>
Subject: Re: [PATCH net v2] xfrm: espintcp: reserve partial message during allocation
To: netdev-bot+sinfo@kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, we triggered the issue locally (KASAN warning in this case) with a
poc that I can share. The (shortened) output of KASAN:

WARNING: at skb_splice_from_iter+0x380/0x7a0
   tcp_sendmsg_locked
   espintcp_sendskmsg_locked
   espintcp_sendmsg



On Fri, Oct 2, 2026 at 12:29=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
