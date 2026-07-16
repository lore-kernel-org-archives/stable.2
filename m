Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4028505E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164636; cv=none; b=Gn/TIDbq5Xka0AFUfKenBYa5LUgsQ63jqhdWIRBG+umrzqhp6+nH/Won9Zsuah7fLeehFGw4J1Zi8dZkrxrxd3I1ffyEoQeDqJJTD23ksi3QJqlkZqzrQU8K6PqkY0iZdVZpKE6V9UOQGbmIbBcRhO5YkQpO5pj5gegSOSoXh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164636; c=relaxed/simple;
	bh=4gjINh65ZZwX5uEjIdDWnnxpUrNUUlM/wkLHg4zBaGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3NPAt4yygTo2+RTQ3dJdle1JAeokOqYxRdZSVpj7tQtm3D8BHLdzkHiYE2t5jbsu5HnqvLKYRBCoP55zUnTARFrUAShZYidaiAV2/DNr/HOBDGSespwvdoVk9fUsLYw1kT3m6KcvNmHELsXdhGHQmKgc31Yu2CjnQvd1hyHxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=r+hHIvjS; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="r+hHIvjS"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8e5be46f663so19270946d6.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784164633; x=1784769433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/oN1wSwP4UvaqVHTQHo6/s99KohGdqm9m0b1NPOizY=;
        b=r+hHIvjSq3AHvSMDB0U6stKDGXNR4CyF7jKPO/CqAi1E4dnUuW1i6ifY8CIL/d308+
         0x09j4WnOjEMtHIGtJWNrki5CfaBGf5cfZXPWkL5dG8VPcyTkBQuM/3PX939+X0CMmoC
         B3T0LP1PfxXjwRbvKDbKt+F41oiJeiMzRTd9h0bkOFJYzEymMN4nkAzRHqPRC0lhddij
         L/FNYQcfr+2aQmAjz0zsxlnJqUpjJo+LoUKGGpZykoUa+YCMk9PZO896PQNNGoFTEnf9
         OCspcfzZZTI9E9rZc0U1yqwOWQ2eNvXTJpiHd3uH+PIEUwn+vJXT6gYk8AZhdNF9STW+
         0Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784164633; x=1784769433;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/oN1wSwP4UvaqVHTQHo6/s99KohGdqm9m0b1NPOizY=;
        b=YPCGcX5jqX3xa9Sg0yKWs4pWRcf8wWZ9M0DzMcafWDIj+2LExfAHRUm6ITKh2xORo6
         1wkvxlvPeqH8x0BhCj+wHLvBAFOOpn2PvwLaje8xGsv3xcyVz/PUa6IV3emWOESPUKLJ
         4qJyqU2qok8Xmw7Ge7wTznjwxTpFm6mrMQt11hFcSaVWZm/SiRLz9SdC5UpMFFbVXDBl
         HjWD6u+z4tLmKygSkeuEHrlGLOneTTzsP9Jq4SfByIAJYw1O2BAwq/shhkY4RHD2lo7k
         j2Pt7RUlyYStguP8SnuUoFGpxrnBcw/Ype5DrkzH3x57N5IwuShQC+s/2/bBtBUyLHib
         nYVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEYXwHaZTFa14xN7W3FKclxE58audlgXeN2Mj9hFyh/13emhHrvVXGUtuGaGZVdeKGE6lW0Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH161aYyyZCO45nxmiI6S91UyzTNJvONqfdGVvh4khC9ek3Yny
	hwoy6V1rD/gwSjiJx2m5wGqhcFlF9dwhuVpp7TiXBukTAcmHDGRsSGxVLEhH8nwu09E=
X-Gm-Gg: AfdE7cmnuMSWIDU0Gvwq9saEPvwS+fRchSSdRezkYx2k6r0UYtHeCIA39SMYSJoKg/O
	PYQuEaw0q8GmBuAbgmTQ4iSjGC1U5CPXfJcUjtd2gw7sJt4HdRa04egIDfSkFmOMKNtqgdhRKAN
	Xg8xMWh3W0nTHgDI8TivX47qoeo2yK/oSlq8Uw1t+1jdsomNW67m7WUsGUMCfy52KWLTMl+gNcn
	Yjom+kP3IuKE28FgCB3iukPjVjFnyhle60hoWk3NLPChWex0xuTEuzklYGzGB2rhsuCVSrCcZ9Q
	SnkvPlnsZ4xgoY5W7w2E/SOPc6wfTccXuALIrNm+GcNtxOLKDRzEduuxJzgZqV2CiwPDRV1w1zJ
	OA/N7jdx9/j8Y3/Zi6JWhwkWPgbCSmJkpwF0sll8+gKJybIv/ChM75MCkUU/8uChTl6ilOBrd1m
	6DW4D+7tM=
X-Received: by 2002:a05:6214:568e:b0:8ef:a4d5:1523 with SMTP id 6a1803df08f44-904011898f8mr225409936d6.42.1784164633345;
        Wed, 15 Jul 2026 18:17:13 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4cd1sm206194006d6.16.2026.07.15.18.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:17:12 -0700 (PDT)
Message-ID: <d4676bc9095c2c1efcd2c0f5ff4559bac7d1e47b.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: fix use-after-free in decoder
 release path
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Doruk Tan Ozturk <doruk@0sec.ai>, tiffany.lin@mediatek.com, 
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: hverkuil+cisco@kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 21:17:10 -0400
In-Reply-To: <20260615140526.52617-1-doruk@0sec.ai>
References: <20260615140526.52617-1-doruk@0sec.ai>
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
	protocol="application/pgp-signature"; boundary="=-Mck6WrMHKU/Fcl8cNGIP"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Mck6WrMHKU/Fcl8cNGIP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 15 juin 2026 =C3=A0 16:05 +0200, Doruk Tan Ozturk a =C3=A9crit=C2=
=A0:
> fops_vcodec_release() frees the decoder context with kfree(ctx) but
> never cancels the per-context decode_work worker first. Although
> v4l2_m2m_ctx_release() waits for any in-flight m2m job to finish, the
> workqueue handler (mtk_vdec_worker) may still be running and accessing
> the context after v4l2_m2m_job_finish() returns. Once kfree(ctx) runs,
> that worker dereferences freed memory, resulting in a use-after-free.
>=20
> Cancel the pending decode work with cancel_work_sync(&ctx->decode_work)
> after the controls and m2m context are torn down and before kfree(ctx),
> mirroring the fix already applied to the encoder release path in
> commit 76e35091ffc7 ("media: mediatek: vcodec: fix use-after-free in enco=
der release path").
>=20
> decode_work is always initialised before release can run:
> fops_vcodec_open() calls mtk_vcodec_dec_set_default_params() (its only
> caller) unconditionally after a successful v4l2_m2m_ctx_init(), and that
> function runs INIT_WORK(&ctx->decode_work, ...). A context can only reach
> fops_vcodec_release() via an open() that returned 0, i.e. one that passed
> that INIT_WORK. cancel_work_sync() on a properly initialised work_struct
> is therefore always safe, even if the work was never queued. This is
> unlike the 2023 msg_queue->core_work regression, where the work item
> could be uninitialised at cancel time.
>=20
> Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video D=
ecoder Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> =C2=A0.../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.c
> index e936ed8dffbaf..30906b24c608a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -313,6 +313,15 @@ static int fops_vcodec_release(struct file *file)
> =C2=A0	v4l2_fh_exit(&ctx->fh);
> =C2=A0	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> =C2=A0
> +	/*
> +	 * Cancel any pending decode work before freeing the context.
> +	 * Although v4l2_m2m_ctx_release() waits for m2m job completion,
> +	 * the workqueue handler (mtk_vdec_worker) may still be accessing
> +	 * the context after v4l2_m2m_job_finish() returns. Without this,
> +	 * a use-after-free occurs when the worker accesses ctx after kfree.
> +	 */
> +	cancel_work_sync(&ctx->decode_work);

The worker is active if there is a job active, but v4l2_m2m_ctx_release() w=
ill
exit this condition by synchronously waiting for jobs to finish. This is co=
mmon
mistake in AI code reviews.

Since this is redundant, NAK

Nicolas

> +
> =C2=A0	mtk_vcodec_dbgfs_remove(dev, ctx->id);
> =C2=A0	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
> =C2=A0	list_del_init(&ctx->list);

--=-Mck6WrMHKU/Fcl8cNGIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalgxFgAKCRDZQZRRKWBy
9Dh4AQCTKUlNcYoVspmnfPi3kRDiedLAR04fgYSBHBeC17x6BQEA2KPgwYaGAl39
qG4Hzu4Df7JcnRfEiS0whfRNWQzYewQ=
=gnTg
-----END PGP SIGNATURE-----

--=-Mck6WrMHKU/Fcl8cNGIP--
