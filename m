Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BF547053
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669413; cv=none; b=S8KqkcdnJts/InJF+wDq2pABZ03Lub62Y3mw/vKGnEoE6uCJjpkIr+jM6R/ewybE+C+9JDDFHdUpd8LPmefccxTQK8suYaghhQyRRXXWKJwDo9RKbhhqSo+8xBq87GlOGm2sDF+JSB/9Gj/BhdJKXwQjBqSTLkuT7FwJvd4+TPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669413; c=relaxed/simple;
	bh=xXBmJEPdDTIauo1QIvoEFRcXpwauiBTUrGweuFyxe4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqqDtdjyT+b/KiZ6ojvz+Lo54PyGq1s/np6khWARrhXQRhJ+IsdnG2RIa0geXFKVjtQMgVyU6J6DxmjnbiluE3hc8nRB9f/Mx7phCpp7+bUsYVeoe5E/mozDRoq3zEAF8Pb6ehSzVFgfW6msaBtc6zML9JFG7+yfNGeMSfVLyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PusStOHv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xo5Kg2fR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PusStOHv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xo5Kg2fR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789669410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDPWA2x/XShhRvPN2CAJ/FdnJPiyLxgST24Qp2ARue0=;
	b=PusStOHvZpdeo3flxF8JRSO9AwOliQC0+Abg3zpPa22CAX6nZQWJjDetY7YDuvhDQU3UUL
	kvuWGlR7E9SsrSh5bTS1FHgFJmuosphChNnHVPIMojYcHFnVaD1p60LMPeHWYv33li3RJG
	PZZ7EhEvMO/o6YT2+BMsKsXiG9tw0gw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wG3lGajcP66AWBkZDZP12g-1; Thu, 17 Sep 2026 14:23:29 -0400
X-MC-Unique: wG3lGajcP66AWBkZDZP12g-1
X-Mimecast-MFC-AGG-ID: wG3lGajcP66AWBkZDZP12g_1789669409
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e80ce3597so25178636d6.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789669408; x=1790274208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WDPWA2x/XShhRvPN2CAJ/FdnJPiyLxgST24Qp2ARue0=;
        b=Xo5Kg2fRNt1JF+Zowh2pMidPztKCGsvHHRa8Dg8e8/1MZz6HbNqyTS4xKGAFvkR/As
         2zlYAlAdto80Cinu3r8r12UpBXN69B2s3JMBiNB4/xx//U2IeQKSdcm4DtwnbZiSDywJ
         xfr7DVbgK01aPK61xFeKRWjOKQrYP6TchwfUwMYskpNu7HHHSQmAzBubfKYUhQRVoiNV
         e4RT0iuSWgYdY19kmaolzj03q22PQoFXf6MuOr6deAKnNYetlbQE058BWxmhfwBcZ3VB
         ziyvRifXIExfIkFW81O9c0byWgd4HiC5j9YsxBuGbfW0Yx4MLHnQouqAAe4REAnX33kK
         Dw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669408; x=1790274208;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDPWA2x/XShhRvPN2CAJ/FdnJPiyLxgST24Qp2ARue0=;
        b=hTmszjNuwHg9hQbBG2rC36luRJSGOub5nv+sgNhCmrBU7xRFjx4eU61jZIc18pyLcx
         vBY9jFgDH3M6gfPKR8LbKHWSHkCng9BbOEtUdWPTHT7OKLeLdF3d6iILyIiceZhAFqC2
         jdM7AqvSurGIJN/Fn1NfXfggv9Io1IpbgDvMyJwkgWlHNk6EcWgHKdZcRb0W+kn6pD39
         moK9iAGFoqtaTPEzpK8FIiwEbzmJWX6Q1AmIqKEhMrqXTMSt9wnRaLnn9uX9sJRPuO9F
         qFhlp+j6YVzWyY5ZrrWsa1qoro93/NcXpvh8pJcvpDdAjYI73lnj8uHEkInKd4CK7rNy
         8ShA==
X-Forwarded-Encrypted: i=1; AKwUvByssyTfCGpzapzmuVLXMciD3rAehJhvt+7GmEIF1WP1ng705Mlu1zKctadSeWCCKTuQg67x+5I=@vger.kernel.org
X-Gm-Message-State: AFuF++mXcOCP/KtS9eRsHlCVZmMuCfu7XQIIp7uJdN/QxW14INaibAR7
	Gow9WGC8Zh/+3oH9MlXcifi5VQ2Lk5eGMRLLSzgfkUGAN0LQ7E+Re08gv9bUmqt6UCkIKKmCObJ
	NG0MjFXcy8wtDoO4GzXwk0rs51zJNV40v4H2aMTzFb7AsI8W8H2O5YFxoEw==
X-Gm-Gg: AYBFou0jh/SXVp1i0qUyi8eHoMbrPw+ygg9nKmAvACzfltXhYVz2vgpCaGb3OXLckkm
	SLqPzmsQLQ8OixPo7CW0fFmo0uB0XYkFX9ytJB8fRpADuB3oWo479/EwjMTwrBusSlMcQPcTosr
	TO/qkPG1E8Qd4xScOyjx0JWcBBAwdSBWcwtzNUfQ/oMv9I87l+8XRuG3Cp/pliQCsQmidel4Cbx
	hdBJ1r28iN6zdsdT6TKTtmOZ0pnDl/dqqtm2CEdUgO6LXzoMbb+c1CVnWbfbRaBTHC+IqgtKSPg
	qwJ1TLyWL6mPpFuFtATIyJO0PFwLbHmJP4/oWl+FduvmdhBOWFYksLCHBB487a+0tAZg3LHT
X-Received: by 2002:a05:6214:80d6:10b0:90e:98c9:548 with SMTP id 6a1803df08f44-91254ba3a7dmr883596d6.1.1789669408632;
        Thu, 17 Sep 2026 11:23:28 -0700 (PDT)
X-Received: by 2002:a05:6214:80d6:10b0:90e:98c9:548 with SMTP id 6a1803df08f44-91254ba3a7dmr883226d6.1.1789669408180;
        Thu, 17 Sep 2026 11:23:28 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252d17cecsm3762106d6.44.2026.09.17.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:23:26 -0700 (PDT)
Message-ID: <fc7bae477fdeab0bcbb908863b4f434dc03844f2.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix runtime PM leak in
 nouveau_connector_detect()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: bskeggs@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, nouveau@lists.freedesktop.org, simona@ffwll.ch, 
	tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 14:23:24 -0400
In-Reply-To: <20260916180342.2090360-1-vulab@iscas.ac.cn>
References: <20260916180342.2090360-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Wed, 2026-09-16 at 18:03 +0000, Wentao Liang wrote:
> If nvif_outp_edid_get() fails, nouveau_connector_detect() returns
> early without dropping the runtime PM reference taken at the start
> of the function, keeping the device powered on until the next
> successful detect.
>=20
> Balance the reference on the error path like the other exit paths
> do.
>=20
> Fixes: 0cd7e0718139 ("drm/nouveau/disp: add output method to fetch
> edid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index cc239492c7f0..4a750d4bf1f4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -600,8 +600,11 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0				new_edid =3D drm_get_edid(connector,
> nv_encoder->i2c);
> =C2=A0		} else {
> =C2=A0			ret =3D nvif_outp_edid_get(&nv_encoder->outp,
> (u8 **)&new_edid);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				pm_runtime_mark_last_busy(dev->dev);
> +				pm_runtime_put_autosuspend(dev-
> >dev);
> =C2=A0				return
> connector_status_disconnected;
> +			}
> =C2=A0		}
> =C2=A0
> =C2=A0		nouveau_connector_set_edid(nv_connector, new_edid);

