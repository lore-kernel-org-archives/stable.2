Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728076;
	b=HTNvCUlo1fpz2VZIUr6y4EoGEM6rG67ndX3leuwN/pjfVP/775DV1gJ+ufdtgirDtrlx
	 MylrqJGHAw6lF6s2dVWRzO9gF+UO0Ghc6d2tGT0EQBBOsRvcSiad22UPXmSwH9WPuOv/9
	 sYGBXQOlV8T1fIaeBw08HlJBcUU6QJ6uQmnozrPfAudb347PNimUoGhkugHjfF8+IZoEo
	 SnvDsqbGoUfuUD0fUKRaoCKuZabxkUll6KK7yt79BcmdGZ19c+HdYC0J4CtlnPxo1nkJF
	 IDJp3tOAgnrpq+1qnPayyi2W0rkbNv8aWO+FPM/EPC/vndYrRj32FGH2Al0P3gCOR0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n99mPQj1ZJP498NFAs6mVC9Ln+V99W5mU+3ATj0pCRE=;
	b=TJcObIxIaq22ySmLD9Frjal1q3u//SQwO+nROJ5vn3y9w3OZA6y0IATFwiBm+YkLT1H7
	 cuPM/JnB2un0tsnH4yEhoPb5IV1eAjjdBzyxcmHQfIPX1tcJKI4zzjgVpn0cjTUw3PyeG
	 QELfoUzJK6fAh6ccMNPw4+sqoEN9aNIlxFa4P+1lTF2f8I8CMaGwAfxInogm6HFv1yY5t
	 JMVjBE6PsJ5nW0uv2KJILT7tn3R0yvgp6ELkB4uepM2RVguhLDBkgei4hl0oMPKXjRl/g
	 E/yewmy1qRFhBf7OtK1ZheoCgftAxRVgZvSSt54pBGKRFFHGe/MuElloRilkSXzXGZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3KIFfY5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAA606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CBAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3KIFfY5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so38254165e9.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728075; cv=none;
        d=google.com; s=arc-20260327;
        b=p0ZLVvd3S59SWa+2RJSRb+23Vd5yB/faFks6KUVmlT8rLO2JPIitmSGHMFqYlXY4H+
         4WCIXZPBdrOUs7ytea1Nn3zOCCp3r4tr9Ge5euijmXwa+ouNmvgro+4rEMUjyk5HqIYd
         gYn+8tG+XhicUW1iHj3FBfUn3A0erXnSIAnpS3V9sr1xuLrJlzXr82fehqAkmd6T5Veg
         2ZNjyf3s8LLBLrZh7xyWSsOwJKSTwBFCpEK8yx26D2fTvtl4Rn8fInWIeYy+KbE3zAzI
         k5rZbhPkWiSFcfy3QdmBSInZt8emDhwhNIEgfTmQz3LRkDhUvQe8pnADZWcK4Ju43S9d
         QQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n99mPQj1ZJP498NFAs6mVC9Ln+V99W5mU+3ATj0pCRE=;
        fh=IHVOfcMuwBLzW7Ve9vfmGeopV8kmgE/3r1+Uou0Sy1c=;
        b=iJs8aNjtwIZC673DtQgfRytMWkXOjvnzANbDDzYwCZrWf17kBmOn5Ia+2HpfVZlLP3
         S5M/uM3oWIKfsOMxCcwZTxn72u5cioNiLoeL73xEm+1QRbR3DOd6eRJrNMdG3kiAJ2Qc
         T4izizEOJ4Z5LmzzLIjY5HhbiaerRL6cEYncmsyHFtteoOl49VaUavAQEOV6YIS5qKEy
         iEo2cXmyABAcyrWqykmuHYcO+MQoiSfQFFyTsPxUrwBBxW20lkeLRBeWjQuptU+54143
         tRiPRuibeSPmT5QaAxjhnCYJ99xv51KfhRQ+Mn93paLJP1CUiOitoouKKd4k3C/34gul
         ZqRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728075; x=1794332875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n99mPQj1ZJP498NFAs6mVC9Ln+V99W5mU+3ATj0pCRE=;
        b=J3KIFfY59hOhjhOy0qmIXAJZ5B3hDT1mclNiZP6MSPOzRvAjY0eVXa1YJW0/JfzBks
         FP26H3hNgp3zyn1JC3hWXg4OrqjeWmqB1gHwRiKAJDR1NmklcLKqp5Eu6V6CYlUV33A4
         tf+0lhOq4TEPUBLDHXvCWvrAs6QWZxH0hm4qIM3+RsgH3T8zZB6hjoI5wQvVm9HCM6ix
         d8bSnsIvySZtgyN8kb6hdxkUtc42aN49P3jYjt/dGkQPFJWKU4Pi83ByNcxupUrYhbMV
         chEVda0Ayamp7ZFx91m4X4b1QEQuuaK0IWNg4QGTFdVhyqERSUvzflAellxIWFES8kRB
         /xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728075; x=1794332875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n99mPQj1ZJP498NFAs6mVC9Ln+V99W5mU+3ATj0pCRE=;
        b=mlDUQWWWarmuK/3dQaMhtuPeMlkZ7ZFA3ZDnrjR6BernWjqwAwh1Ll8DAl6nk3t2x0
         1OQtW3dGv/E1ohxOcOO6UN4sfBaZsmV0vaO5IIy+uSzWykwEQfq/d9UzDsPZrmrNVzZH
         +ADqdXWB5jlXc4mjqAUCdS0d7dN4H9d6sO0Pk63mehBlqb1t9eAm1cLReh9kiwGoHgSE
         JiiuCkNc/dxB1gxHdLPn7LR7AMJz544GwhG/AjipapNEiKJX8JoMTC7zTC5afhypuhQn
         SQx3ASzEm/HU4HkgDBhpI7hUUXTWdZVYKpEpJ8z8q0L7SfG28WiMu5NLbSJ87dKw98Y0
         +0pg==
X-Forwarded-Encrypted: i=1; AKwUvBxHA4nMLu3G/M4gyZJJkYmbQF3mbKTbFss8ns0SPkmNQZbPit9XBy5xrGT7B0Bjr1N/y3ju5Zw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E4BXOJ2moOitRN/wMpm9CbSTxRNR8bsrCBpGlnVSy1TecGEn0
	Hdh8F1oOuJw8SBITL2wOVs9E3h29QIFeVbmCNhuzN2tz/gGq4r01M9/WSTPe188G3aA6lskeAxa
	LN7YaLjUygr1WHP47HTuQVzNDdwRN4o8=
X-Gm-Gg: AYBFou2fBuwQiTfHYj75C5wRDutGm3eiauYOfR/QGy+o6UR2GMuMCv9l6iSedLsXVXA
	lDE4dFAR2KxVtcWMEQCJxraU3TWTxj2lUrg+QHjMPgWMiEOTVuFjlk2rHcKjVk57+4bX0zHSd+n
	49IpKKG0K84c24UXoROBjWuXSWBp571fqmGn9s06al2f0K4RS4VyWFJ8u/FTMeo8O/lQz/h4hHv
	xYmXMmHcUXv3gD6VdfqqEm/Wr3mte0bwJ8x0q43A09IQqDCfFMlGR+gnyyqU0rmwJ5a/8E0338A
	pbcMfGf/ro3HGJZiVFBjgOdYTVwahip+LJuUe2mHL2T+waKudAike0mAX9dr6AKw7ml7vgj0w70
	zbg8edCF1SekQgOTVbmuCMM8PO0eg4exzhg/e7RzyGlJBjmGCOPcXJXSHJUJEW4p6T1xI
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr323859765e9.2.1793728074629; Tue, 03 Nov 2026
 09:47:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029130037.5505-1-izaiahsun@gmail.com> <auoLrJPq9eRAbeQa@p14s>
In-Reply-To: <auoLrJPq9eRAbeQa@p14s>
From: Yuqiang Sun <izaiahsun@gmail.com>
Date: Wed, 4 Nov 2026 01:47:41 +0800
X-Gm-Features: AclHuK_glufPx3VPzKUbs-tqY6RCK_e-0Xc3jXhDCTseeM-7NDt0oT0ktRFS9Mc
Message-ID: <CACdDPuwmyAjC3kje+nYJ3yz7RePg8JzXsKGkzx-Ksxb=-_CZ8A@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: core: Do not put the device when device_add() fails
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Unfortunately I do not have the time to read through and digest what Clau=
de has
> generated in the changelog.

Sorry for the long content.
There is a human-written summary about the bug.

> The documentation for device_add() is clear, and looking at the implement=
ation
> of device_add(), I understand why put_device() needs to be called here.

I agree that as documented in device_add, the put_device must be called
if it fails.

But in st_slim_rproc_alloc() (drivers/remoteproc/st_slim_rproc.c), when
rproc_add() returns the error, the driver calls rproc_free() at its err
label, which is put_device(&rproc->dev). With the put_device() in
rproc_add(), that reference is dropped twice, and the driver uses the
rproc after it is freed.

The same happens in every other caller: xlnx_r5_remoteproc calls
rproc_free() too, and the other 23 use devm_rproc_alloc(), whose
devm_rproc_free() does it.

That is why I did not change device_add() or one caller, but
rproc_add().

If necessary, I can send out the full document and PoC on
how to trigger the KASAN.

Thanks,
Yuqiang

Mathieu Poirier <mathieu.poirier@linaro.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=B8=89 00:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 29, 2026 at 09:00:37PM +0800, Yuqiang Sun wrote:
> > When device_add() fails, rproc_add() calls put_device() and then
> > removes the character device.  The reference it drops is the one
> > rproc_alloc() took with device_initialize(), which belongs to the
> > caller: after a failed rproc_add(), every driver frees the rproc,
> > either with rproc_free() or through devm_rproc_alloc(), and both drop
> > that reference again.
> >
> > So the rproc is freed inside rproc_add(): by the put_device() itself,
> > or, with CONFIG_REMOTEPROC_CDEV, by the cdev_del() that follows, when
> > the character device drops its reference on the parent device.  The
> > caller then uses the freed rproc and puts it a second time.
> >
> > With one allocation failure injected into device_add() (failslab
> > restricted to rproc_add) while st_fdma probes, KASAN reports:
> >
> >   BUG: KASAN: slab-use-after-free in slim_clk_disable+0x38/0xf4 [st_sli=
m_rproc]
> >   Read of size 8 by task insmod/69
> >   Call trace:
> >    slim_clk_disable
> >    st_slim_rproc_alloc
> >    st_fdma_probe
> >   Freed by task 69:
> >    kfree
> >    rproc_type_release
> >    device_release
> >    kobject_put
> >    cdev_default_release
> >    kobject_put
> >    cdev_del
> >    rproc_char_device_remove
> >    rproc_add
> >    st_slim_rproc_alloc
> >
> > followed by use-after-free reports in kobject_put() and
> > refcount_warn_saturate() from the rproc_free() in
> > st_slim_rproc_alloc().
> >
> > Remove the put_device(): the caller's rproc_free() drops the reference
> > and releases the rproc, as it does for the other failures in
> > rproc_add().
> >
> > The problem was found with kbound, a static analysis prototype that
> > checks whether callers rely on an object after a callee returns a value
> > for which the callee may have released it, on v7.2.12; it is present
> > in rproc-next.
> >
> > Build-tested with x86_64 and arm64 allmodconfig (W=3D1, sparse): no new
> > warnings.  Run-tested on QEMU's arm64 virt machine (TCG) with KASAN,
> > using a device tree node for an ST FDMA with a SLIM core, so that
> > st_fdma_probe() reaches rproc_add() without the hardware (no clocks,
> > MMIO windows only mapped), and failing each allocation in rproc_add()
> > in turn with failslab: before this patch every failure in device_add()
> > (9 of 9) gives the reports above; with it nothing is reported, and the
> > rproc is released once, by rproc_free().  Not tested on remoteproc
> > hardware.
> >
> > Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failu=
re")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5 kbound
> > Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/=
remoteproc_core.c
> > index b88bf179507d..e4f44a3c8b4d 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -2309,10 +2309,8 @@ int rproc_add(struct rproc *rproc)
> >               return ret;
> >
> >       ret =3D device_add(dev);
> > -     if (ret < 0) {
> > -             put_device(dev);
>
> The documentation for device_add() is clear, and looking at the implement=
ation
> of device_add(), I understand why put_device() needs to be called here.
>
> Unfortunately I do not have the time to read through and digest what Clau=
de has
> generated in the changelog.
>
> Thanks,
> Mathieu
>
>
> > +     if (ret < 0)
> >               goto rproc_remove_cdev;
> > -     }
> >
> >       dev_info(dev, "%s is available\n", rproc->name);
> >
> >
> > base-commit: 82d0bbd67c42a44f0e18b0b7b0da0f3ace0c9527
> > --
> > 2.53.0
> >
