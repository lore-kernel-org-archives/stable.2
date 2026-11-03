Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735900;
	b=x9iT9JPwkoqzYXCOuXyelvlTWq7GrOxOwrJmSCc0AWOjkhg+8/i0eVPvff0a7WjaE4OA
	 3n4gds+sX2UPZU/XPV3gDdG8bwxcRxKhg3Qz4KVuoKD164UEMT9OQvom17CvNxr1Bo46q
	 59IgeiHJalySacggsLfAtxCWfF1szuCBUvYEW5nY2hMo2vMUipsrVKj9jKrV0rJFa+gU9
	 EMR7jvWwmgeUcJ3Rm7Pb0A5MB3x32rx16GW0mMTh1+ntDHjTyaR5M0YuaMSjF5Qxj7f14
	 X3Vle6zRZiH0tMzQB5HTQhQzSyyRyuMTCv/IFkjubIhwni9Zf/YMntuJ618WQtCir9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:User-Agent:MIME-Version;
	bh=MiR7v8ogyBE3UAdwdGXynAVIr+KTNViJqowNL7iiLKg=;
	b=DVJ0HlrsOQF2jCVd9mMsLmLsfWRgxSskozl5fvDHuZopO00XNkJSGB5da72LG5BCX+MD
	 I4mls5oPaeZ/ICEcxQiUgZQIDf3SX4iPyGfrXMJgY2qeCCxhJet2tNMZYX97hBAOMZ4Fu
	 l/qrLwZ6VuDc/CQDpy1aMa4JuaWd7h/dfHXgfLEr6fPjvWmC1MpSxxSWgLFennMnVyEFk
	 vn7wfsz01/A2wBR9SkxZDpLtllgN0+8ooNzboDRlldS3w8ir3SkxJHm136FTUonup8N6f
	 G8h9D+AwN4UyNcK6CIR6hQjWNBIHkr7MLrHJdtzGFMVd3XAslmArlBugEpkxOPFgL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ndufresne.ca;
	spf=pass smtp.mailfrom=ndufresne.ca;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF896606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF896606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917aca1aee5so358576d6.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20260707.gappssmtp.com; s=20260707; t=1793735895; x=1794340695; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MiR7v8ogyBE3UAdwdGXynAVIr+KTNViJqowNL7iiLKg=;
        b=KnbFhjVxnKHdStdOB0RR8+yGHHTGAo0xP4Ie6yFcgdPwTJ9TNh9LB48mFnv8Oj5ziV
         wAFtekhaCs35AWjoXHt4KiMN+GRkbl/FzbuxJhbW1jiz14OtlQ2FFJxkn2yIEXkeKmWD
         mfGN2dKO3tV375Eh+YW1W5THtchWxdumgyRak1t3tXW2sM5XMOI7oGfWC5b6CeLYfgtr
         NIt/U4TQOtHalxLg7RcqdoaQVceF3qa92p/1Kxg1RexhoXtncXv2m35A7tx4kibwv5Bz
         OyMdGs1/0jz3CghYeN/iWzeWD9C4rWu6EEt25rQQzY5LeA6SjFPNWnJIoSruUnvY4C0j
         uzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735895; x=1794340695;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MiR7v8ogyBE3UAdwdGXynAVIr+KTNViJqowNL7iiLKg=;
        b=Ph1aL3ktTHB5KOw9sDB6DLY7OY4pRoK6Zt7v+eWPxF2UHtu6KVIiIOAIlCY9JKqvPP
         qJSdcM1oM8Bm7cNqNtWFrAfOwVzv9+o6wdFuSec03K4wRJ6wf7lqntHrOMHPTwXCp++l
         LlAp/3IC9Gk+3DeYR5dBKemKtr+9L654977xgrRdNll3+pL2V+VZZvBDRUO6Z0xLBFa9
         ouyo9JTrlwFFwP0ni2y6AORPBShoXogubI6ebjMdOmYGJ0bHVxCjBxhMS1kwsSRM+PZx
         mBGnZ5zvI++vAjkO7OKzmw7QU1k0hiSkBkVEtQENVphoCjpbS6g0QR0a8XKsWXAORWjz
         NnkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQwiymuK/nVQ3TuTJsz8KCTDT3cgerfMohxNmdyMUHOIsDE3kGI4FtYYBCBudekVXVkooqARc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B1oKIssuqNMMZU2+sEXOSz20Mu6vzF/PA4RAEwNeU3K1iC2Jh
	80COx/hVsAfoAiEFXWX1sGGZElOIcAf+HsHG7nplbKlFXVwpHqwVvVx7onBf754qAsU=
X-Gm-Gg: AYBFou0ZiwEgcFqy/K7KAVekaA8gTGKOCTVpzgxIz6FR9EQ+jF4X7PAsF2LagGY4V26
	7syTQOmq1Z+N+W7N8hmYD4UolWdvOGHsC+31DSDE3XzIq3abLgLtt+rmEa19oldH6j02GoHQHVY
	OYlSqB0pi4qbLfdTYVuqPwBvWZq7AKgzUp270rj0401oEQ1L2/D9NhmqxM+mqp8tL0PHt2KProj
	WKoQb5dLWq5/XvZdUuTt47HD+pLTtuN/iPEF9BURY+OWf8zcuVvOTAcJ9kPXAiSbX4nuomazjiF
	hkz3Y9xKiT0dWVvrVs1af0qorVUyEd8rTkuzvrwtVayKa0FZX7Jn9n8+Hc/OjdxRaZAts3mfVnv
	ht9E1BVrQYAHa89LfII80Oq1ioTleyNz5m9AUEzhyr2T7dfxHon0ysBgSy7ydTd69XfOIURT7i2
	IVJzECzeIov7EWOywQbNAEzRuEwQDeStW1P4YCX/fueCyGYcyJuLgw6PuJy55pMe50iijw4qI7y
	CwrrkU8n2Ohu51LDsc16Y+km5O4efaAPavnJtmqF0DQnVnLQUbYE7aPVOuDvQiyHvYPdpZDmg52
	dH1s7eXczOoPwVMkfLxrywpXfJI3mIBsmnzSs79LKzYNyg8gCev7iCg=
X-Received: by 2002:a05:620a:3705:b0:93f:19fe:e6ca with SMTP id af79cd13be357-94421745e9bmr2481703885a.43.1793735894598;
        Tue, 03 Nov 2026 11:58:14 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:bf53::5ac? ([2606:6d00:11:bf53::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48648e3sm14608285a.35.2026.11.03.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:58:13 -0800 (PST)
Message-ID: <30feb9f9c859c39a8e5e5fc5aba7fcb0f20cc820.camel@ndufresne.ca>
Subject: Re: [PATCH] media: v4l2-mem2mem: cancel job_work in v4l2_m2m_release
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Tristan Madani <tristmd@gmail.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Date: Tue, 03 Nov 2026 14:58:12 -0500
In-Reply-To: <20261024205711.4041369-1-tristmd@gmail.com>
References: <20261024205711.4041369-1-tristmd@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-m6t4otkvc0ZAfwx/Sa22"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-m6t4otkvc0ZAfwx/Sa22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le samedi 24 octobre 2026 =C3=A0 20:57 +0000, Tristan Madani a =C3=A9crit=
=C2=A0:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> v4l2_m2m_release() frees the m2m_dev struct without cancelling
> m2m_dev->job_work.  If a device operation schedules work via
> v4l2_m2m_try_schedule() and the driver tears down the m2m context
> concurrently, the work fires on freed memory.

How did you tested this ?

>=20
> Add cancel_work_sync() before the kfree in v4l2_m2m_release().
>=20
> Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framewo=
rk for videobuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index a65cbb124cfe0..311e2e08d066d 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -1207,6 +1207,7 @@ EXPORT_SYMBOL_GPL(v4l2_m2m_init);
> =20
>  void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
>  {
> +	cancel_work_sync(&m2m_dev->job_work);

Seems quite insufficient if you compare with the actual implementation in
v4l2_m2m_cancel_job(). Is it really possible to call this without having
released (closed) all the context first ?

Nicolas

>  	kfree(m2m_dev);
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_release);

--=-m6t4otkvc0ZAfwx/Sa22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauo81AAKCRDZQZRRKWBy
9DboAQD+g0qmmTqL10aTTYNwr7O71NtKH/nesIag4peMvjYksAEA89aQb5aBypy+
2Lk0A0j1TWtGJ6Yo5ZLVnzWHxCy2hAE=
=e7sF
-----END PGP SIGNATURE-----

--=-m6t4otkvc0ZAfwx/Sa22--
