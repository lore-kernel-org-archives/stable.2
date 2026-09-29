Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3F3F12EB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715979; cv=none; b=UWUi5iV3cNfLWD+5VGVHFAE09UbwswHt6mjwTSKfIrc4t6VQLSxJiaF9u/yK+vou1xh0eWPDkyx6ATkP6rae7dzLSkc5mFbIodUa2YV4Siln5glByIpBDLfVoj5o8dLQMAbQGivnr3sgo7OnX5fAoRxm60BclrsKvuhAMhAJp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715979; c=relaxed/simple;
	bh=mK6Mulvd+6WzWYA6dTVzp3jfz6d98sJor5h6S6M4KlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6genzeyDUQEOalQmsnFXmJaBSkvIElSiFCyQ7X1DkPZ5Lk0ZkA4Zv9NMYW1tzhabju3KkI7VDG8bjXnhRVgflFr/nbE2bslviC73dwDas4hMfb0BtuOvP4TH03/Ym6GrWbeNF5wZcjo3YDnLBkT3UPLe9R4mWfyuloEGzy5IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=to/pfk49; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="to/pfk49"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-533342a38ebso38668791cf.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790715972; x=1791320772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LFOvHs5vGrtobfr2ePGnKbAMOPISIpzHqSP7jz8iLA=;
        b=to/pfk49Pg79h2HQij3Xz0T1LCc4kyltwvU7PQmpkW9TRVpUFoYqqH1omsn6yVMxRO
         q/UWFkBulkHBeuUtCXXRZXy0hzY4/WTJ1ej5jCmeP+yzMlKir6GQr1lt6LGJo4BHuech
         NF2PqNv/UfNsPsf8+v2lyB4+YK0PedhdlD35AE8GeeD9/YK7sT71gtlhIXOOLYsggIN7
         RWDU8zyeYCiC+fZo24Kvc67zgVQX/vBdvTJfflaEFIBy5YBnn+QR4NNrJMRElqmAmSvB
         RgqmLYt4qSc0CroB2gP6N1Cy8saX+vX8502yQF/78pS7R9feR/cK9rmVXpS4Sv7eFA12
         PPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715972; x=1791320772;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LFOvHs5vGrtobfr2ePGnKbAMOPISIpzHqSP7jz8iLA=;
        b=Zv6Mh8561aroE4cVz6BSTsytsN6KuCI6o6nIR9RS1pyqx15bbqqawnJLU3AntbnGli
         KFz8fIFjW3P/bCeuBVvzHCyp339U9tnqjHqu78DX9RKU/dFiRaIeBugj3YVoEYIZvcPc
         u4RQ0XOtZn+5IhoU6PVWibT9JWnSebcgnUKqfKp+0qKiMnMws/8KbseoxIPcBeukwRu4
         3whWsvv535vsU4cHY6uLmFuBwc85Ms4C0VHWr9uXoe2m4O1lPIxMS4ATVLwwwsvFaply
         9EuMW8fZb92R7zkhazckZhJxKPyKGe/30QOsxY1Pc44yVJXcP5A7+R77ZV2SCgMGCff0
         Qg6w==
X-Gm-Message-State: AFuF++mJZhtXOxn5eiu4zYevMcxPAWfdL8pbOA2nDtS47J0J8oE8anmy
	c1k11qHZaGgrQnmL/szIpujgckaW8fTcdrtMXM3cdUD02Rt0+/NJ7gdADVzyDQO3BRk=
X-Gm-Gg: AYBFou3LJc3SlLBdVqR0zwQ6YtnCtBxHFcKP8YBCRisd1jK1YgLzyITWSOuakHl9T4a
	llUrQ3BBDYuVGumyM9s5D3ljWG2IytLnOkMyZ2XJJe/GFnZmghtO1+WMSQKcyXPAV6NNC+C5UmI
	gtFS916op9XqhC9I9w/Dg+gFXHhZgfwJrLuITCqLELzBgolQshe5M/yRCcdC0FRR0N+oSVZXUTD
	DFe56NnbN8x/1bI/rKd5J2M3LuzFfYheGfR71RqFAweDLaCQFlQsu7NL+94jvP1Rao586P+cvKD
	Di6wkaBKbpXOKmeixXIK7TPA6o/DaB90hiYUzTapZoTbUk0eB9xQh9f0MSGWBpx6f808owcDTec
	1RR2NUHznjmLHxYLOqshdYBHPY7aznmvtRe35NsLeNjzbg2x3ji4xkUywDs+YVcGZMQ5FBoLdgF
	YM/ntgijjVlL3zSIS5kNoVgYDm6EFKG47UYeU7xDwPrnKVJAPR42aFYPsZbLxySHPRyAAxH6NPM
	44e4azp6teHvQ==
X-Received: by 2002:a05:6214:c27:b0:917:9504:374d with SMTP id 6a1803df08f44-91799b6daf0mr7450606d6.36.1790715972169;
        Tue, 29 Sep 2026 14:06:12 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917987e2746sm4263186d6.20.2026.09.29.14.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:06:10 -0700 (PDT)
Message-ID: <0741e05902488b491624e5e05098092245242a1a.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vpu: release reserved memory on remove
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Guangshuo Li <lgs201920130244@gmail.com>, Minghsiu Tsai	
 <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>, Yunfei Dong	 <yunfei.dong@mediatek.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Hans Verkuil
 <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 17:06:09 -0400
In-Reply-To: <20260915121025.2412446-1-lgs201920130244@gmail.com>
References: <20260915121025.2412446-1-lgs201920130244@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-JBpDEv9eNq9BIPUlwiLE"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-JBpDEv9eNq9BIPUlwiLE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 15 septembre 2026 =C3=A0 20:10 +0800, Guangshuo Li a =C3=A9crit=C2=
=A0:
> mtk_vpu_probe() may assign a reserved memory region to the VPU device
> with of_reserved_mem_device_init(). The probe failure path releases the
> assignment with of_reserved_mem_device_release(), but the normal remove
> path does not perform the corresponding cleanup.
>=20
> As a result, removing the VPU driver after a successful probe can leave
> the reserved memory assignment associated with the device after its
> lifetime has ended.
>=20
> Release the reserved memory assignment after freeing the VPU external
> firmware memory, matching the cleanup performed by the probe failure
> path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 3003a180ef6b ("[media] VPU: mediatek: support Mediatek VPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/vpu/mtk_vpu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/medi=
a/platform/mediatek/vpu/mtk_vpu.c
> index 8d8319f0cd22..16b5bdc2f2c0 100644
> --- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> +++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> @@ -966,6 +966,7 @@ static void mtk_vpu_remove(struct platform_device *pd=
ev)
>  		destroy_workqueue(vpu->wdt.wq);
>  	vpu_free_ext_mem(vpu, P_FW);
>  	vpu_free_ext_mem(vpu, D_FW);
> +	of_reserved_mem_device_release(&pdev->dev);
>  	mutex_destroy(&vpu->vpu_mutex);
>  	clk_unprepare(vpu->clk);
>  }

--=-JBpDEv9eNq9BIPUlwiLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarwoQQAKCRDZQZRRKWBy
9LIrAP9JLK9HAtBMScpQ1KexiHDip4nmcCWrHasuo3ANeEljAgEAs60FyYFYBqgL
Jt8fxtvRcoN2QASZVOg0X0uof6Yp8g4=
=0P79
-----END PGP SIGNATURE-----

--=-JBpDEv9eNq9BIPUlwiLE--
