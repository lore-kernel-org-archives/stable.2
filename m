Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793259734;
	b=WuNe4SRWvN6lSqtk2SktgQ0tiG0zlNnVHHk+b0YW60+u/B6MKqcYBnDxj/Ez+w1cKrP0
	 AneoVsbhxt97xZw+MJTxtBScovQFC11rRSgBLhdlqJNMQDMSHK97ZxzJ/g77nmC2Hgtlr
	 Y1Q+lfnZC6dBvSKGxw8LmPmIYPJ0HJzhbedZnFZWaNMIkp44W9NR+EZx1al9ugFkyqAsC
	 2PGlLJNlKDa6RIS0tmiNEinPByleVR3vT17RO0TcFhs6j6FVAUjsvPGNG+jeZ3xOafiHZ
	 +7f/jnV8EhW8xPA6L+vL7jPgWrMytBbfcTLmc/snHM+rrN5Sf4cr0SFLoCm2IRH8RNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nRUCr4NQ66GLUUzHJ4QDNjrj6aEkhbXAp6tE51ISY0s=;
	b=HX49h3v1r+wm9iPhOU6Qb7sCkatG//ZkfaYPMhhr8n5QTaHD2v/iSVDIP7sganIh/FRj
	 8DvgeoWmB7Kac6krs/gFKbn/PrqFzhW70bCUVR0wETROQI3panfeoxNoiIq/ng+bSWAnw
	 SJ6RzJcTSzj0xgxAx2f4QstjjSg6+Z0gtuWGTus4G1/9ccx+bX9cRJQbmMp7woFtXve8d
	 918kj8gbwNbxAiaupbrHWz01iONwwwXgL6p56vazpCaF1LnpFGFO5imH9zFhcEkLq8GKM
	 CAwoi3jHtK6V4CjDYB9YUdL/W1YPA4S89SAYnH1COCBvPPpUawGugxxXTXPYQ8T3tqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGc0Y9V9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB3606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEAB3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGc0Y9V9
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e8c710847so248149766b.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793259732; cv=none;
        d=google.com; s=arc-20260327;
        b=CXsuUp+N54Iqimi2/SgnRDAl8xqrpH7rWPZHBcxhULZrXGt607D8r9XdjLXWI9js7s
         vKUAvWWqwMlysuwoxULPI+MxK60BRW+h+8aaJRaG3jaxNwjU2UpvR2P5HUsxbeNiAUvA
         aXUiFpNIukzldIM+zak8ynqpdvdqpbdZ+0QYLGBdIS2War7TiB6l3E6E5DNvsDBO08NT
         mXPoZp3kpWuv2cR8OwC28hM7NoNTYcJQhUylHnu6RitYWcHFLtfDZuv/q6tQXuZJ2ch4
         mwI2/+0vN7Pffvz+ky7Rkvng+vwjLv658TPe1jw3bF8KoqWAKCrl7PZRDWZBMyr9Hjb/
         Npbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nRUCr4NQ66GLUUzHJ4QDNjrj6aEkhbXAp6tE51ISY0s=;
        fh=rdandaTnHuCmbj9VWqxn2EyHnBYK+pMjZuc4PgCj3t4=;
        b=QEXqlV6QuDpVfxayRUmxub5F9XjBByzVGHT9UnYVESOfLGtyFDJUPHBv/sCc1ahtzk
         zasmLk9AbIti0HzRWjKmWQ8ZOZC81Qu+OUOQufjtmzdlu1vgJl8VrsYPEpx0NHscWHT8
         MsTfR96JY/sXa4mMZHOrxTQGM6LAzPLWSWx90nRlVX9de09IUUjd+BmmluqGOy9h96Zz
         2pHE1BZIBXbLuanVU0bcIF2afD7zWwepRNktDrhex31s5ct9u6OBUtPc1djvIviCsnxB
         39rnbwJcufookvqpJ2tiBmf3a0j1VoEwvRlPKiO3nJVn+dSBdbGmrQ+cViQz/GztGqXS
         sX5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259732; x=1793864532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nRUCr4NQ66GLUUzHJ4QDNjrj6aEkhbXAp6tE51ISY0s=;
        b=zGc0Y9V9yQhkIss1bYi176ej2dIv7fz3bctn8ItT8bqV4TE0UelQmq2Gikz9hLf9Hz
         vNHl+yFKBv76Vfu7Mg4/OWVcFBObMsIzU0zhaG3Uq3plDzVC/AP2q2OCraNH2ris5/im
         Zqb7RhRuV0Q1CZHmUEiYbs4cJE6Mg+Tkv665xqAuAvHX5O5/PC+Z+ZwaQoJQ0oBKybhE
         Mpf81dGZ9wDrJnNiMpbsgK9LEX42jxZxNRQo3HCEkH2W0TlP81/EcvOZ6ZEfPoGjABXN
         PoQlOF76E3JGhpf0sthOBkS0X5fUgRGZVYUW/Ft2YJqpukUhNo+w/IqwKx4EuoRIxc6G
         CEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259732; x=1793864532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nRUCr4NQ66GLUUzHJ4QDNjrj6aEkhbXAp6tE51ISY0s=;
        b=a3AlvoQ7nYtgan4V0I+inDiFSVSlivpYWAP8eG85eVVVbsMmK9fiCsXDiL0cf+X+fO
         GHqeCpufc4HsIkbthSQF1sZIhKydVIaRtiNXn0G1fAN1XAeuj5R8jICNLpBOe/WYdZpi
         qjcTadhpwrQ17eooSUt7cmx2weD8C08+XUhH/7LzlLtvQwCphXJryH2Wbtn9QW3kqnNA
         2oWVpoRsAFXo17D73LlXbCd/7bxWDXYBu8btQDIV+t1LIu9G/z3flNoGmfshb15hJf5W
         vD20n9tu4ZLZPDVsYYrj91rgwXyR/p0CglqDssnkb+lY9qQUDEkSRaaviwb7TlrCQXh2
         9mtg==
X-Forwarded-Encrypted: i=1; AKwUvBw70xqHGNFz2Cwqty6xEEssj/DAZtzIedkwRsammM+ARQWEt+MLtPqlsxXIIlY8MdqironCHbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF9JqwHWhQYvYUXIpvsQy/i43kF5EXm5Ua3saUntoz+g0A3nId
	YWqd76AIOYk8HbXLgyTPLFNrTOH5x5Q4wV/fGJZme2ONPNQeBH9do6EsPODI45hnvk9eWF5IPgh
	RK7/E+UDj2xzWDmi/oD+rFhPbAYFEYII=
X-Gm-Gg: AYBFou3JwVa81BA/kJJcgtfMDdvSoYpfBUdAq83WlzpdtRPU+E1G9EvIsc3condJhlV
	DXcdffU/fhPa0Q0IwDzCtID1uL9mBp7tTCJcHIuFfftXCNJ11Vgt8ByW0Be8q9nMbbFtkw+eBcw
	UJG6ltWm2Qbtyo5Dm4gCQBfJ7K3KCuK9VaYk8t18vaWOgyG2LJY6Ru22jz3pHfLR87LgeyVDSaN
	mZOwETX6x8RdYUpYCIFPoUGn6Ytnx8D2UNdrIwyrQZpnAzAMxjwydgZr86T3wYpEi1tyvHjAqy6
	j9CUowWPt91VoF40c2KjP1Xy3zKdgofz5W+u4FKtj4wMytxVmjLAJ8G+E1lWyQdv+PXBQNd8jrv
	U60SLayE2hA47uPmhcziAgoQa5bubTH778nvMwJM=
X-Received: by 2002:a17:906:fd45:b0:c49:bf6a:28fa with SMTP id
 a640c23a62f3a-c49bf6a2c46mr282671766b.28.1793259730604; Thu, 29 Oct 2026
 00:42:10 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792988985.git.zhoubinbin@loongson.cn> <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
 <auIe15pAb8ZZWbnV@lizhi-Precision-Tower-5810>
In-Reply-To: <auIe15pAb8ZZWbnV@lizhi-Precision-Tower-5810>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 29 Oct 2026 15:41:57 +0800
X-Gm-Features: AclHuK8kbVDGgdNrbovyTyakUo3h504IwuEClXkjkVVljd7312xDrPpt32lzyXs
Message-ID: <CAMpQs4KMbvRpF9axnnEbO6Rcna77WqHQykv4jvw-EOnSbH8FBw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dmaengine: loongson: loongson2-apb-cmc-dma: Program
 CNDTR when advancing sg
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank:

On Thu, Oct 29, 2026 at 12:12=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
>
> On Mon, Oct 26, 2026 at 12:31:22PM +0800, Binbin Zhou wrote:
> > When configure_next_sg() moves to the next scatterlist entry it updates
> > CMAR but leaves CNDTR at the value left over from the previous entry.
> > The controller therefore keeps using a stale transfer count, so the
> > hardware does not move the amount of data the descriptor describes.
>
> How it works at 1c0028e725f1? not test ?

Let me clarify how I found this and what I actually tested, since
there is a fair concern the patch may be redundant.

I hit this while debugging a CAN-FD driver. Reading through the
Loongson CMC driver I noticed that loongson2_cmc_dma_start_transfer()
programs both CMAR and CNDTR for an SG entry, but
loongson2_cmc_dma_configure_next_sg() programs only CMAR. The
asymmetry looked wrong, and I wanted configure_next_sg() to program
the same set of registers as start_transfer().

I instrumented the driver to read back CNDTR before and after
configure_next_sg(), and forced a non-uniform descriptor by
temporarily making period 0 shorter than the rest. With the CNDTR
write in configure_next_sg() reverted, the read-back stayed at the
period 0 length for every subsequent period, and the TC interval
matched that length =E2=80=94 so the hardware was reusing the first period'=
s
count. With the write restored, the read-back tracked each period's
actual length.

That test required a non-uniform descriptor that I built by hacking
prep_dma_cyclic(). As you know, cyclic mode itself is uniform by
construction =E2=80=94 buf_len % period_len is checked, and every
sg_req[i].len is set to period_len. So in any real cyclic user today,
the hardware CNDTR preload mechanism already reloads the correct value
on each CCR.EN edge, and this patch changes nothing. I2S audio works
fine without it, and I could not have found the bug from userspace
alone.

So yes, this patch is arguably redundant for the current in-tree
users. I kept it because it makes configure_next_sg() consistent with
start_transfer() and removes a hidden "all SG entries are equal
length" assumption, also I'm happy to drop it.

>
> Frank
>
> >
> > Program CNDTR together with CMAR so software and hardware progress stay
> > in sync.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson =
Multi-Channel DMA controller")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma=
/loongson/loongson2-apb-cmc-dma.c
> > index 8b8d530d60c3..c654e0572902 100644
> > --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > @@ -266,6 +266,7 @@ static void loongson2_cmc_dma_configure_next_sg(str=
uct loongson2_cmc_dma_chan *l
> >
> >       sg_req =3D &lchan->desc->sg_req[lchan->next_sg];
> >       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req-=
>chan_reg.cmar);
> > +     loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, id, sg_req=
->chan_reg.cndtr);
> >
> >       /* Start transition */
> >       ccr |=3D LOONGSON2_CMCDMA_CCR_EN;
> > --
> > 2.52.0
> >


--=20
Thanks.
Binbin
