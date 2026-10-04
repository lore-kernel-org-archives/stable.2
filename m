Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94538AC75
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112669; cv=none; b=M1WJ8itLYhWNj6bokx4buKWNTZabszK/7UEbYWhUmXX6PXXkxc04XznZF55bltOvuaKiMKoTn8oShMU3UeOCUyo7+h+d9Nk1XWPjbb9hCZcgEqGL8r/5o19ykfI90w+XjjgLs48+R6BxU6ypD+UsrzxYVPX/SDPV48m0x4xSweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112669; c=relaxed/simple;
	bh=Mt2h8LV/WNkvF9rhDfChy/WnatB7KEgOdqPVkHELyr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RA0lbXMo/mHNtpGdvMM5jU7F+NpYYp+SCWqbVKez6oA8ZTwy2ycygQM0jLVyRk4QzQ8B2CP8Opnn94HQ2h7nsML2XZPi8p1Cl+/jg/flvi9E3sQi87TajaGYbCUgWXlE8/hBDoCL5YVuRKP9RTp/95uC4lHq/jOR6BrGMI0oaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=kfOPaDaq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="kfOPaDaq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b02a2359aso363353f8f.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1791112666; x=1791717466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eL39BrBDAGEfSIelgQ0pH7LJpTqjoDddDfMIFB1yeIQ=;
        b=kfOPaDaqEIMNhO7dQPsTs9YlZQQ7pqhAkhM0hxqjvEHGUsuECSOV6quCq9qhc5XIF1
         3w29LL5QpKrUlcKRzzj+oY96u4NtNe8Ul9yBHhGyymqtjuvW1WeiFbevNW0KQMjN8K93
         AuHqCIiN39iFfuVyNnK8IXi6FPKdOkR+LNllGCcGcQExdyhDwoFr0MDy/obbe2ASwBLZ
         ydkXRibxcI3hPNvsM6e4MW7rVGiiJHjUSbaMUlpX1JE73zInPRLQ5JfA+dRgl0j3+C0F
         b/PZ3Fl5yo9XtRWIyyR/S+mK5JJhTUpiQKb2Pv4JJdz0vX6sREyyieBgiXLbQRq4+CKE
         fgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791112666; x=1791717466;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eL39BrBDAGEfSIelgQ0pH7LJpTqjoDddDfMIFB1yeIQ=;
        b=mc+Fqkoksdc41yxNtPBXT5iQjodY4ESnVS4U8vqrRjCsqOBA1EY48FGzG5ftL0qQLP
         ZID5AYM1UCJ6jGWM4cLPx2faPiq7JyQxyLbBJYnpkBLw7WHq/JIEL6asm+jwdLAIweLV
         zwRc/F8ZNYWk87YTw6PS+TFvqDidAPM0BCv4QQlTaj/yhe8B/Tf6yLBGRfp3JUg7QidX
         WrQZNFFhAEBauXBShcvdF9zk73eJ1ydAWFpZi540LlygUljKcAKsrsl1mttOwUUCMRaD
         MlVtJbBPNbil6KKmW+u01NUD/UOaA0Iq432/ikPG/w3ANTcHiM96Z9He5K6RBJZQbg3p
         NCMg==
X-Forwarded-Encrypted: i=1; AKwUvByXTjJLII1bUnyRPriDy6xyrkaAvQCT3v+HjsepFucXZ3oT2d/8JXHsqsuhhMIxzHWpBQcj+wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjtshMBEsNJEesEtINyJ8fktROkFMHP0nAhTkXCdHraQIxcDlv
	wYhmFgUECfC5qHe3O9+wRLSZLOfsCY1SbiEWNB6uFL/NGPtdb7EvBLAHnUJgw3Bc1zBLPB/yvEY
	xLqHw+Kfwmw==
X-Gm-Gg: AYBFou2C4B3Mc41Kd1d2ZMd1K6x0WiYeuNtfzZGyWL5vX7M3W1Px19qx+yQ2s5eMiGE
	WJhzncT9V/upzhwpIahZj0u0hPCu3khfVt9mRiURPKbg9OTxeJ/pUkdQO85QjGpIoqSgrwERq8X
	Ne5v8+Cm7UoFz3JLi4hEEMGKJ3jNu4w9Im/lEywaLZNfTs8W7TqsCXCyu4bQKdXxvikB5W8NbEZ
	k2dc3np9LDiqXeE1ZSC4qLN5bf1vSZbwKiFeZve/Q6BGjM4qXKNOGz34Dp3+tEJxVUh7RjfOsi7
	qki6i5aHe+XzphyyVN/Lm15vLNjfwZlRDYM1y5KdlP98jpF1HRmlJyled+sJnilNw/EL94AgJFy
	Gg4tg7GCOxwUqVqT8yLrPQxaoc1PsG2dnFd3rcWsWVJGj9mLEK+oi1tZ+TAsw+Z21fAFGova4fR
	bx+D8u5czP+481JuEKMjU47tdoNd2ywvUahqxnTYEsjui8UMDJl3eY9wAJtA4kBGCd/27buizt5
	rwYyrWzMbPx9SB2meCZKhdtl+UeFvIp0DgOfNiaCru3+9s3PnIL1u+QAE8DdLHwP5LMi6O44M8E
	mzmU2kZYEy8ckd30fCVuVimfMzOLLYqOQGyqtFLW
X-Received: by 2002:adf:edd1:0:b0:48a:fc74:2156 with SMTP id ffacd0b85a97d-48b067c4defmr16138748f8f.22.1791112666400;
        Sun, 04 Oct 2026 04:17:46 -0700 (PDT)
Received: from ?IPv6:2001:1aeb:400:6f00:73f4:bfe7:a3e6:c16f? (2001-1aeb-400-6f00-73f4-bfe7-a3e6-c16f.ip6.tmcz.cz. [2001:1aeb:400:6f00:73f4:bfe7:a3e6:c16f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b383065a4sm16730166f8f.44.2026.10.04.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 04:17:45 -0700 (PDT)
Message-ID: <8ea77a207f6f99d4f20610670e5f88fc56df3faa.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize context lock before
 firmware setup
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, tiffany.lin@mediatek.com
Cc: andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
 mchehab@kernel.org, 	matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, 	linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, 	stable@vger.kernel.org
Date: Sun, 04 Oct 2026 07:17:43 -0400
In-Reply-To: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn>
References: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn>
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
	protocol="application/pgp-signature"; boundary="=-N6yzswm0lU7qZmLZZ6MH"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-N6yzswm0lU7qZmLZZ6MH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 30 ao=C3=BBt 2026 =C3=A0 22:48 +0800, Runyu Xiao a =C3=A9crit=
=C2=A0:
> The VPU firmware setup registers a watchdog callback that accesses the
> encoder context lock. Initialize the lock before selecting the firmware
> implementation so the callback cannot observe an uninitialized lock durin=
g
> probe.
>=20
> Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect enc=
oder context list")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  .../media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_en=
c_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv=
.c
> index 4e4541b2f..e6cd3817a 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> @@ -255,6 +255,7 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
> =20
>  	INIT_LIST_HEAD(&dev->ctx_list);
>  	dev->plat_dev =3D pdev;
> +	spin_lock_init(&dev->dev_ctx_lock);

I'll have to reject this one for now since the theory of a callback taking =
the
lock while the probe is happening does not hold. The very first place the l=
ock
will be taken is in _open() and that cannot happen before
video_register_device(), which is kept last. Please demonstrate what the is=
sue
you are suggesting if you'd like to see this merged.

Nicolas

> =20
>  	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
>  				  &rproc_phandle)) {
> @@ -308,7 +309,6 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
> =20
>  	mutex_init(&dev->enc_mutex);
>  	mutex_init(&dev->dev_mutex);
> -	spin_lock_init(&dev->dev_ctx_lock);
>  	spin_lock_init(&dev->irqlock);
> =20
>  	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",

--=-N6yzswm0lU7qZmLZZ6MH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCasI12AAKCRDZQZRRKWBy
9D0fAP9lSFbuAS00fVndTGbGVuCWhD9paS0BD1BT5qJExQWHOgD+M/VqV8OTjN0r
TJV6llyZfdBtx5qmuyep65FyxrPNTgs=
=O4hg
-----END PGP SIGNATURE-----

--=-N6yzswm0lU7qZmLZZ6MH--
