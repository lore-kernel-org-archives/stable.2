Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9C3CF203
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153649; cv=none; b=QHnYHC5NsZRUHEJSpouU2av9opkHmkZYJ+0aMjv5uK6RdI3R/x7IIkU02B6hJDx0bsNJYH/XdKrjDEz+Ukxtz9t/86RBVNKEEEVrKr2LHgtRlU0Q5EcWOHVJjhXHl28aLPLQXt11XZVrpvkztfYN1eKa4x4J7pUnUPwd7jsmGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153649; c=relaxed/simple;
	bh=zv7zBBHEVFrZFhegSNQC7c15VkKnra2hEFqcOuOvBp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PzRgOVL1o7T4LL7PlJyxujDlyI4dOzoclzlK2MlKlAEC69B4DIoduMZILNXo7p+U5KYusl8RMIy4PFyJjXtHqSHNMUCr6uaXAwsxC5+nokQ1Vd+nNFA/nGDAJQuaFZk5Mw/gpzaX7tRtmcekzJFzLeZEG6TpaLVH+9jLGeGA4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=AsiWk9Bu; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="AsiWk9Bu"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so804246241.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784153646; x=1784758446; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1eiqgwkrfrfTFMwyHLkLw09ZsFEe9n2BSSTo3oTqVlY=;
        b=AsiWk9BuwobyVo2XRNWffcPFMWJReRYiCFtg1m09ncX5+QNzGHYsQnD5QzZs8ibXhn
         k//uDre4VViBxv9q0NQLe1cjfnpEgjFAE+RHGVVn7aA0ZDGsnpxivifRq8w64C9FgykX
         QANPhplYlkSEEslH+67Oj2z014h2I/nmgL+OrkhhtZd/fMwCn2v0fCsgj+hvzckth2Al
         tXfUf1yKEDTiuS/P+5In6c0AJQGWGu9Dj3B+AhkfW7+tlo4stm8dgnVsgqw123zM/I1T
         bBos0xVCpsuVKQQ/TBZCZ7y8rHu6n6ZmtIZQJVke9Yi3UF/7e5kzcOCi2f3IIQRQQhry
         a2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153646; x=1784758446;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1eiqgwkrfrfTFMwyHLkLw09ZsFEe9n2BSSTo3oTqVlY=;
        b=ro/hCVQQtCEtZ1NGJjeZA1RS9FvIoWb/tpbzCvg87DJztcWpUw4y9xu4BiZdVEBzAC
         lvZrSrna+CnWCYd1FzIhfGnXdtPxmI3U0cmKVGG8G7Dy9k9ob3KIYPwkui30JbPzlaPg
         vg+k3q75Api4/5ayukVrPWHD1HsIhpJsz3wtxzKpIW1z7uEYTrpKteitKxQ0P/iD6hbW
         FM9a2Zka5AA1gbJFfvp6t1SAvjIVYAxG6vYmG+hx9vZxIhoxWGGv0vSM6GLbyrkSdAy/
         Vrl23jttcAMJ8UpElkNp/MtyZHuEMOy67pM7KPPs6D0CqEX2vwYQOuytA03XX9nVa3uS
         4M/A==
X-Forwarded-Encrypted: i=1; AHgh+RrD/sHRYUmFItpBtoUvT1YI/cXrD3bu+8PYVnFEpd1eoGXHSKH1dVCs65seCQ3NH0bmzjwNGJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzikRN3v9U94z9r9gfMWFjyQCbot+9+4HpL7sIrZZRT3uNyVKp
	j+e4B4YJCxCMFrgHcyqIlJt38F2eY/bOxGGqu+TlnAoJ7Sr7XdcZoWafXbqWx3oxwKE=
X-Gm-Gg: AfdE7cksbgHlgllPmF7y70bkxo/8sTh3qQoG9tOGbFJ0Jhb60rc2iy0cyGX4VzyiFgQ
	zHSwq2BsyuiJW2hS0SdsmtiJfIgbY8qukanYPVTSBsalhPIpknTraHcA5gSkauFlOKVc361xZmg
	gbpUdlSK+fcEFTAIbz9Brx/233kZdWnExpoG0gUtKMp4X1/DknWALeV42Ff55UwxNG/gIuoNk69
	nlqMqHhaTvOiEGunOy1A4CLs5sG3hgKj+qNpKc8zLmE9of3fli2Y1Il3N66dgSabSjUD6uEpRCI
	wMrZSGp5u2maWk8lK/JeX67nDWJBp0qKGy82gmPAmgIil/k/QKPktaCORnBNszNz+8MddHG+NVJ
	D4KwVPH7Z7RvJ2xvACfWszNH4ol72OFbc/6nte+D9gMCQtp8qhS4whHH3TmCOSdyO5KUIM2JKD+
	5mFBBeQyw=
X-Received: by 2002:a05:6102:26d4:b0:737:783d:1900 with SMTP id ada2fe7eead31-74533bddb5fmr11097481137.9.1784153645735;
        Wed, 15 Jul 2026 15:14:05 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6e38b3bsm12689139137.10.2026.07.15.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:14:05 -0700 (PDT)
Message-ID: <71a3fa9710cf1afbb80ebe850878557c3e95a1b2.camel@ndufresne.ca>
Subject: Re: [PATCH] media: vim2m: keep transaction buffer count stable
 while streaming
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Younho Choi <gdool88@mju.ac.kr>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil+cisco@kernel.org, 
	laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, 
	benjamin.gaignard@collabora.com, ysk@kzalloc.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 18:14:03 -0400
In-Reply-To: <20260526122205.1019913-1-gdool88@mju.ac.kr>
References: <20260526122205.1019913-1-gdool88@mju.ac.kr>
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
	protocol="application/pgp-signature"; boundary="=-ggulcSm1IMF9eVivF0Nb"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ggulcSm1IMF9eVivF0Nb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 26 mai 2026 =C3=A0 21:22 +0900, Younho Choi a =C3=A9crit=C2=A0:
> V4L2_CID_TRANS_NUM_BUFS controls how many buffer pairs a vim2m
> mem2mem job processes before the job is completed. The driver stores
> the value in ctx->translen and device_work() uses it later to decide
> whether the current transaction should continue.
>=20
> Letting userspace change this control while streaming is active can
> make a queued job observe a different transaction length than the one
> it started with. That leaves the transaction state inconsistent with
> the buffers currently queued for the job.
>=20
> Grab the transaction buffer count control while either queue is
> streaming, and release it only after both queues have stopped
> streaming. The V4L2 control framework then rejects changes with
> -EBUSY while the value is in use, while still allowing userspace to
> configure the value before streaming starts.
>=20
> Keep the control handler alive until after v4l2_m2m_ctx_release(),
> since releasing the mem2mem context can call stop_streaming(), which
> now ungrabs the control.
>=20
> Fixes: 96d8eab5d0a1 ("V4L/DVB: [v5,2/2] v4l: Add a mem-to-mem videobuf
> framework test device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Younho Choi <gdool88@mju.ac.kr>

I think this patch make sense, though I was pretty surprise of the private
control offset, which I've tracked down to an undocumented change made by H=
ans
in 2017. I've delegated this patch to him so we can sort this out first.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/test-drivers/vim2m.c | 29 ++++++++++++++++++++++++++-=
--
> =C2=A01 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-
> drivers/vim2m.c
> index bb2dd11eef0e..f4a2c4083829 100644
> --- a/drivers/media/test-drivers/vim2m.c
> +++ b/drivers/media/test-drivers/vim2m.c
> @@ -205,6 +205,7 @@ struct vim2m_ctx {
> =C2=A0	struct vim2m_dev	*dev;
> =C2=A0
> =C2=A0	struct v4l2_ctrl_handler hdl;
> +	struct v4l2_ctrl	*trans_num_bufs_ctrl;
> =C2=A0
> =C2=A0	/* Processed buffers in this transaction */
> =C2=A0	u8			num_processed;
> @@ -1258,9 +1259,27 @@ static int vim2m_start_streaming(struct vb2_queue =
*q,
> unsigned int count)
> =C2=A0		ctx->aborting =3D 0;
> =C2=A0
> =C2=A0	q_data->sequence =3D 0;
> +	v4l2_ctrl_grab(ctx->trans_num_bufs_ctrl, true);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static bool vim2m_other_queue_is_streaming(struct vim2m_ctx *ctx,
> +					=C2=A0=C2=A0 struct vb2_queue *q)
> +{
> +	struct vb2_queue *other_vq;
> +
> +	if (!ctx->fh.m2m_ctx)
> +		return false;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(q->type))
> +		other_vq =3D v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
> +	else
> +		other_vq =3D v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx);
> +
> +	return vb2_is_streaming(other_vq);
> +}
> +
> =C2=A0static void vim2m_stop_streaming(struct vb2_queue *q)
> =C2=A0{
> =C2=A0	struct vim2m_ctx *ctx =3D vb2_get_drv_priv(q);
> @@ -1274,11 +1293,14 @@ static void vim2m_stop_streaming(struct vb2_queue=
 *q)
> =C2=A0		else
> =C2=A0			vbuf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> =C2=A0		if (!vbuf)
> -			return;
> +			break;
> =C2=A0		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
> =C2=A0					=C2=A0=C2=A0 &ctx->hdl);
> =C2=A0		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> =C2=A0	}
> +
> +	if (!vim2m_other_queue_is_streaming(ctx, q))
> +		v4l2_ctrl_grab(ctx->trans_num_bufs_ctrl, false);
> =C2=A0}
> =C2=A0
> =C2=A0static void vim2m_buf_request_complete(struct vb2_buffer *vb)
> @@ -1380,7 +1402,8 @@ static int vim2m_open(struct file *file)
> =C2=A0
> =C2=A0	vim2m_ctrl_trans_time_msec.def =3D default_transtime;
> =C2=A0	v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_time_msec, NULL);
> -	v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_num_bufs, NULL);
> +	ctx->trans_num_bufs_ctrl =3D
> +		v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_num_bufs, NULL);
> =C2=A0	if (hdl->error) {
> =C2=A0		rc =3D hdl->error;
> =C2=A0		v4l2_ctrl_handler_free(hdl);
> @@ -1435,10 +1458,10 @@ static int vim2m_release(struct file *file)
> =C2=A0
> =C2=A0	v4l2_fh_del(&ctx->fh, file);
> =C2=A0	v4l2_fh_exit(&ctx->fh);
> -	v4l2_ctrl_handler_free(&ctx->hdl);
> =C2=A0	mutex_lock(&dev->dev_mutex);
> =C2=A0	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> =C2=A0	mutex_unlock(&dev->dev_mutex);
> +	v4l2_ctrl_handler_free(&ctx->hdl);
> =C2=A0	kfree(ctx);
> =C2=A0
> =C2=A0	atomic_dec(&dev->num_inst);
>=20
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

--=-ggulcSm1IMF9eVivF0Nb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalgGLAAKCRDZQZRRKWBy
9OEOAP9WF4Mmi/Dv7Hsjv6Dl52wgqW3txL+8HcaV2b49BjHUAQEAhRzFY7hQhUi9
8CNvJtcVHOlKgzWzgmzbYHNKkpUToAU=
=TpHf
-----END PGP SIGNATURE-----

--=-ggulcSm1IMF9eVivF0Nb--
