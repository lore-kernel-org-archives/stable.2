Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC236492C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353476; cv=none; b=FuLgiYSQQvm8NO3MgUKyt/36GOjE7R4s94RQh9T3lMuQ88Bu2UMcjCocpzBZb42jtdGmJZFm5H5Pq7GSNTjRG9oUyAwT9CWU6vs/Sl7XjhSOkC1kdCVze7vaOV+FoHq51hq0oM/yzDHlW1VJwxiiHypc/KupYd/YiN5MlR5MF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353476; c=relaxed/simple;
	bh=ccOyiC2jznVKxZDvjoV8BnZRBXz549AenKEwOQZucvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6TBw6Zk7rnQ9FJEcbUoBrp47KnDOghWB9Ds42ADDnfrZYhZ2KB8ZoLcqDB0bv9YtVpuM0Iw3ulr/u1yz/sI4DgR7ilRRufcphdfkfP7siaNAsDTVcOO258nXD4hQSiPpY44CHxrGxr9C7OvgHODZygI/HedRMsud60JFPSVmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=cz9+gods; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="cz9+gods"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-922ff615c14so252506385a.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1783353474; x=1783958274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ccOyiC2jznVKxZDvjoV8BnZRBXz549AenKEwOQZucvI=;
        b=cz9+godsWELFKL37Pussw+O1u/FK5EAqBy7OckwceCTj79RM0/TwjVB79F14NEJhkp
         IhLOxtfnS53ld9v46BkQj8Nm9lMlr0MaSy3moW5qNouXA3kaYiplKXrZDGOA+7/na9Y3
         1nIrXLrbWrSa6wkdIJgNBGqasGrv4ZihJLGmBtyq8iVNT7kvcWwDGTpmyUeweIE9FGp9
         TzdsSWId/rxYcFc6RjUewQ6lveJby1VgknyG4wDIDx1YEov/HYpH5ncy+qd+zcU8Vxb1
         aZERfh76LpD3HKmV7hy50tob6GuKRA4x8pXZui+e1Ssg9fcTWlhgsj1N+D3CaE7J9xkW
         F6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353474; x=1783958274;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccOyiC2jznVKxZDvjoV8BnZRBXz549AenKEwOQZucvI=;
        b=RNfcbQuBpx43nxg+k0axtMfcNd0oxudrJ7pyPw6PhwZsHz3p71QokJigxHCZzwkkVV
         4VjbepE32vETEiqEqb92j2dGAXiCudcaDiRrdRgobxnrjjNrn0IifIHpLyW8Cho9939W
         v7tJoOREs+5RZr76gh+NsJXbrRfTo09KyX7L6XBvzenQQ9ATZCFvEZePiCINORdxmQyH
         GgBYQvA+x6CDhi2P1fE5X+EFhxHf1n+AUY7tSUc/8Tqgi2U25u7dL/TxFTdEPnbEnHXt
         egsoU0N153cw4DR5kZmHz92VYpK6/fNQAvrUI19F/hUt9sVtrezJH2b7/+ep9JYmb/sG
         6F2g==
X-Forwarded-Encrypted: i=1; AHgh+RpLxkb9dKyFE6Lo/TCmRwqWBLja9jsuNoqIf+HXnSsMz1fJkSuvwuZMF6lijqCJjZbclBDEj+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIzl9Syg2KRDpcP3ua6WxAVq7I7d07SxaBy7P/7hekR1D41Bs
	nbD2gt7Ox0s/v41v107WR8wlIc9eaJbRJAdL39QAbdtBXXo4donSsdZ8k68tawQmybw=
X-Gm-Gg: AfdE7ckcW3TwH14GOC/+FFiyVsGvyRzb/2w9xTNwobGnzpe5GHhuR2JuYmsSGVODQfJ
	Ci1xCUSZ2xIlEU1PePBEgbgapydSlakkaZRC+pdbFaTAWE8RtxsqTMIdXoacZ7UtDlHzc9z+oRE
	LuMBvRjGeGCs8toWxoD3bLNcJGNscruQKfE5i7g1iabNeiaQuNQdxs1Dcu9YJT6QePvv0HseHYC
	siW1sH2JdiTkt1yEdjqHh+TjDe4wIfJqwkGIXUyNAVriVICvEHmD9parfdT7LSFHQ9CVrPTpM8h
	DuJXt1ZvA3TZ50raga3o9oWYci3IPA8G0BpJsx7qzfupOQtcQgffu/P9elf12B4TPbQmjRkmBUr
	EqULZVikDI38ZeMDIWI2qi3qgbaWA9S21TGxR6PLVQbG+HfnJlrTDYs06gTudVK5rlH8z0LnwF2
	F4hrYmNYCHCrMcVb8QiA==
X-Received: by 2002:a05:620a:17a5:b0:92e:7e4f:eaf8 with SMTP id af79cd13be357-92ebb4d8ad6mr158283285a.23.1783353474136;
        Mon, 06 Jul 2026 08:57:54 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::c41? ([2606:6d00:15:e06b::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba7e62sm979531685a.13.2026.07.06.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:57:53 -0700 (PDT)
Message-ID: <06f42aae24e2e441b04549bf5be2825cf1f8e2df.camel@ndufresne.ca>
Subject: Re: [PATCH] media: rockchip: rga: quiesce IRQ before releasing m2m
 state
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Fan Wu <fanwu01@zju.edu.cn>, jacob-chen@iotwrt.com, 
	ezequiel@vanguardiasur.com.ar, mchehab@kernel.org, heiko@sntech.de, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 06 Jul 2026 11:57:51 -0400
In-Reply-To: <CB4C9604-8CCF-4A2E-B8B0-FC49AAFEA514@zju.edu.cn>
References: <20260704022853.77291-1-fanwu01@zju.edu.cn>
	 <ba54b43f90b46960ce4e57f99ead11e4200d283d.camel@ndufresne.ca>
	 <CB4C9604-8CCF-4A2E-B8B0-FC49AAFEA514@zju.edu.cn>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-E7tq3eJKSti7xqM09Bs/"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-E7tq3eJKSti7xqM09Bs/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 06 juillet 2026 =C3=A0 23:27 +0800, Fan Wu a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks, that is a fair point that RGA is not a free-running IRQ source;
> the interrupt should only be raised for job completion.
>=20
> I looked again for the abort/drain path, though, and I could not find one
> in the RGA teardown path. `v4l2_m2m_release()` only frees the m2m device.
> RGA does not provide a `.job_abort` callback, and `rga_remove()` does not
> reset the engine or disable the IRQ before releasing the m2m state. The
> driver also leaves the devm-managed IRQ installed until devres cleanup
> after remove returns.
>=20
> So unless I am missing another path, teardown does not actively abort an
> in-flight RGA job; it relies on there being no in-flight job by the time
> remove gets there. In the normal case that is probably true, since the
> hardware is not free-running and the submitted job has normally completed
> already. The case I was trying to cover is the narrower one where
> unbind/remove races with a still-running job.

I've never looked very deep into that, and so this report isn't a bad thing=
 at
all. With the m2m frame work, we have m2m_dev (which is in fact the schedul=
er)
and m2m_ctx, which are the instanced. The second are found to open/release,=
 the
first is probe/remove.

I don't know by which mechanism, so I'll try and learn that, but we expect
platform remove() to only be called once all the file ops release() have be=
en
called. If that is broken, we should certainly do something about it.

Now, about not having RGA specific code to abort, this is fine. What the m2=
m
framework do, in the default ctx_release() impelemtation is to call
v4l2_m2m_cancel_job(). That function optionally call job_abort(), for drive=
rs
that requires it, but otherwise, it will just wait for running jobs to fini=
sh.
Since most m2m, specially the simple case like RGA finishes quickly, the de=
lay
isn't a problem. After this, no more jobs will be scheduled, and no more IR=
Q are
expected. Meaning protection against late IRQ is defensive. We've seen some=
 HW
bugs with other drivers, so its not generally wrong to do so.

>=20
> That said, I agree the explicit irq field, `devm_free_irq()` and the long
> comment may be too much for a defensive corner-case fix without a
> reproducer. I can drop this patch, or respin it as a smaller ordering
> cleanup if you think that is useful.

What I meant is that a hardening patch based on quite hypothetical case sho=
uld
come with matching wording. Reading your submission, it felt nearly critica=
l
(and it could have been for sure). Let's investigate the remaining bits abo=
ve.
Then you can either reword or drop.

Nicolas

>=20
> Thanks,
> Fan
>=20
> > On Jul 6, 2026, at 22:22, Nicolas Dufresne <nicolas@ndufresne.ca> wrote=
:
> >=20
> > Hi,
> >=20
> > Le samedi 04 juillet 2026 =C3=A0 02:28 +0000, Fan Wu a =C3=A9crit :
> > > rga_probe() requests the interrupt with devm_request_irq(), so devres
> > > does not release the IRQ until after rga_remove() returns. rga_remove=
()
> > > currently releases rga->m2m_dev before that point.
> > >=20
> > > rga_isr() uses rga->m2m_dev through v4l2_m2m_job_finish(),
> > > leaving a window where an interrupt can run after the m2m device has =
been
> > > released.
> >=20
> > I have a doubt that this can really happen for this type of hardware. I=
ts
> > not a
> > free-running HW that emits IRQ randomly, plus we have the abort sequenc=
e
> > that
> > ensure all jobs are completed before we pull it down.
> >=20
> > >=20
> > > Unregister the video device first to stop new userspace submissions, =
then
> > > free the devm-managed IRQ explicitly before releasing the m2m device.=
 Move
> > > the command buffer release after the IRQ teardown as well, so it is n=
ot
> > > released while a completion interrupt can still arrive.
> > >=20
> > > Store the IRQ number in struct rockchip_rga so rga_remove() can free =
the
> > > IRQ without looking it up again.
> > >=20
> > > Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> > >=20
> > > ---
> > > diff --git a/drivers/media/platform/rockchip/rga/rga.c
> > > b/drivers/media/platform/rockchip/rga/rga.c
> > > index 43f6a8d..118887a 100644
> > > --- a/drivers/media/platform/rockchip/rga/rga.c
> > > +++ b/drivers/media/platform/rockchip/rga/rga.c
> > > @@ -828,6 +828,8 @@ static int rga_probe(struct platform_device *pdev=
)
> > > =C2=A0 goto err_put_clk;
> > > =C2=A0 }
> > > =C2=A0
> > > + rga->irq =3D irq;
> > > +
> > > =C2=A0 ret =3D devm_request_irq(rga->dev, irq, rga_isr, 0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(rga->dev), =
rga);
> > > =C2=A0 if (ret < 0) {
> > > @@ -919,13 +921,21 @@ static void rga_remove(struct platform_device *=
pdev)
> > > =C2=A0{
> > > =C2=A0 struct rockchip_rga *rga =3D platform_get_drvdata(pdev);
> > > =C2=A0
> > > - dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rga->cmdbuf_phy, DMA_ATTR=
_WRITE_COMBINE);
> > > -
> > > =C2=A0 v4l2_info(&rga->v4l2_dev, "Removing\n");
> > > =C2=A0
> > > - v4l2_m2m_release(rga->m2m_dev);
> > > =C2=A0 video_unregister_device(rga->vfd);
> > > +
> > > + /*
> > > + * The IRQ was requested with devm_request_irq() and is freed by dev=
m
> > > + * only after this function returns. Free it explicitly here, after =
the
> > > + * video device is unregistered, but before v4l2_m2m_release() frees
> > > + * rga->m2m_dev, which rga_isr() dereferences via v4l2_m2m_job_finis=
h().
> > > + */
> > > + devm_free_irq(rga->dev, rga->irq, rga);
> >=20
> > I'm not saying we cannot do that, but its quite verbose for something t=
hat
> > probably can't happen in practice.
> >=20
> > Nicolas
> >=20
> > > +
> > > + dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rga->cmdbuf_phy, DMA_ATTR=
_WRITE_COMBINE);
> > > + v4l2_m2m_release(rga->m2m_dev);
> > > =C2=A0 v4l2_device_unregister(&rga->v4l2_dev);
> > > =C2=A0
> > > =C2=A0 pm_runtime_disable(rga->dev);
> > > diff --git a/drivers/media/platform/rockchip/rga/rga.h
> > > b/drivers/media/platform/rockchip/rga/rga.h
> > > index 72a28b1..f76c45b 100644
> > > --- a/drivers/media/platform/rockchip/rga/rga.h
> > > +++ b/drivers/media/platform/rockchip/rga/rga.h
> > > @@ -81,6 +81,7 @@ struct rockchip_rga {
> > > =C2=A0 struct device *dev;
> > > =C2=A0 struct regmap *grf;
> > > =C2=A0 void __iomem *regs;
> > > + int irq;
> > > =C2=A0 struct clk *sclk;
> > > =C2=A0 struct clk *aclk;
> > > =C2=A0 struct clk *hclk;
> > >=20

--=-E7tq3eJKSti7xqM09Bs/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCakvQfwAKCRDZQZRRKWBy
9OVfAP94FHLtll5BlcbiiLMERXWh7DIgX6IEnNzCIlpoODQfiAEA6nGpiFHNTGzm
fvKnFRG59nQFWkLb0cCxj2cuEXoyogQ=
=jDV3
-----END PGP SIGNATURE-----

--=-E7tq3eJKSti7xqM09Bs/--
