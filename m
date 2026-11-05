Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917487;
	b=IUma7ARCey6mbbl20U0EsnsqVdPQj3uRJM9nT2inmZQOeRbmjWo5HTSYN5T7cdisp/gh
	 OIJQ64aPTK89R9kDcx0vYvNRl8AINR9Gb08hiJGM8IMltdfntDi+8mPgut5ViYRhCAlef
	 2xux7c0uvKg/SyCKc3Th7jHR2Z4O9fz01Eg/pCaVFTzVP3Zzw2EUxUe7BfM432BqcDpsO
	 5RpJlePM9a26L2oldvhkvOpAx6wF91ZYOM9PKkD4jJKk2Zfq8xczFdIw6xCPxu0+u5iF2
	 pIliDL2ZIs/uR311CPpstlLnkHb8TGAHDDv9H5mvjZlohqSvlTwFYwluZai0eTSimKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917487;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Yz7JrxYN6No13ZjrdbTD9ZQ4YJkDr+Zb2oOBnQS0qwA=;
	b=YOWFlnGM6fvZEzb+KwAoJ4O9uOJVdPLVKj/1pFX9U5D+qO3KHxZ2BFUsWN2NC1HkJxEd
	 7FvRSwZ+zFrT3QMIuCybjLFd21Ev28npPNFxEQ5Bbi4vkQHaEaqEY22FKIMcs0R1J//xr
	 DurPj9qs0pUWuFWbxsOhZtoMelG4FqoaknympPZUDb762dCBnk5cExfrcu1O34USA7JNv
	 mbZbS9gmdsfoFBoT9eqEwX5BsWRkABp3h7i/29OUv6nU7Zf2ZtdyuKZ41Io6yogcxMutg
	 9g6IozOdyVOWP4yo1f25jknup4wSbN5AzECotDBpGbdGvb6dOIk4/k2HpdLtNrjGa1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=enVbN5Mn;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64900606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64900606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=enVbN5Mn
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0afe09854so13637a91.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917487; x=1794522287;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yz7JrxYN6No13ZjrdbTD9ZQ4YJkDr+Zb2oOBnQS0qwA=;
        b=TQAMgubAl3sXVYiGPZ/pMiUkA1ygeBJgT28iUevkxOUNcNOsdR0OSbwusUvUdqiimb
         lB7yqA0ZJzdv7Z+1C5pzR9WSVpU595IFvVTkfDrNnOk/3NAQL1jbZjqHEzUGMuP5CeyE
         JJWDJnucMjkbV+0JkR71Al3mTGxPw/rfTn/PbUQYO2zctlEL3mOF/NQcr64/6OAXrt9S
         h/zbL2j4gMSCQVjDgerDu11Z+PbZaugxgdfWuZ30f3Aqymq1J6lxM7OeR8tTnDUjCEJ/
         uenVpy7EWqW8W0PhUfTsYnh6rxQYdLXsJBTHmYrPYJ37O+dZ9GmtIGl1tGEgXKkGxjnu
         0aAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH4eWQNrxQhc9A9C1E1FqirvcZ1e0our/8RkDtq+1XSZntri2bo7gG6Abc56DZzzehywC6t5Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I+TNhPWH/ZC4bz/Qrf17cHqDdGEAiC37deubianfrnmdzGgaT
	itUoX7n4F1mFWgNBFmHkeWpkDCOQFXGZRXgSUI6lfg0yEAVPJ18WlxXQTK/dJE6wIz8yWVNwD32
	a/6iQYZQSa4PU69pMZBgh+nYkOZhRMDT+kOdejhERWsWDFyPecdAHpEPH42bCdpjrUdlKEhHqBW
	8j2F1coyMZBpRyX2JSNDKWyKz1RRkK8vPmIoRrFIVIew0ZolCKvxdqI2C69TgfKnihe7PSzjnTA
	cPMAGvE
X-Gm-Gg: AYBFou3vUaqTBSVjuZBM4wRlx1hn05mE7qdz30zOq9Jip474CHgNZ9zgdAlyyFknP0R
	/0J5UrXcoRVZ53SSbo2i7lcK7Xp9VAGk4mWYgLUJU1cb2309KEZaj3jp1oI9KkTYu3rgnp/4YFl
	dqsoDzXyGwM/jydwolCj7+Uc9flEInDuWJaUs7a1YFfdiyvdTaY0B2KewLzFg0moDADZ8FDjeet
	y38nhZ2IC0kWNxNdt5TiEibGw54Z3gOPzrZy8L+kzFEy8DgTyVPvUj/+JxJESnHt38NYxteiXxW
	2pWw5IRFW89++uSHUQ6cyubW+cUKKibzMO5RwW0go3/Y7dhG6cygrqMh5VCDI51Ri9kewfhEbdl
	Z5p60p/+BJTUbWMkPtbhIFRUn4jMS1DFzdBXahhKKRerLlNHqxG8IUbuk9IcaMI4xwHgGSPgzSN
	MayLgcZj3wockiZB1HDjGvv8BIYdEQyrhI
X-Received: by 2002:a17:90b:3e4f:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b0db6218c8mr483626a91.5.1793917486492;
        Thu, 05 Nov 2026 14:24:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b094f88ab5sm1903777a91.1.2026.11.05.14.24.45
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 14:24:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3acd4b46482so11976021fa.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793917484; x=1794522284; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yz7JrxYN6No13ZjrdbTD9ZQ4YJkDr+Zb2oOBnQS0qwA=;
        b=enVbN5MnUrYeRMcl7A2l3aXOKj31JPIIOxK4ynheoNb/DWV9wsFD4BhZ6H+AaBTIYF
         Lggvcs2opOuNlYox0NYu/UnZ3VgOhhtJXm+ttGqOkI3AaqcbfCmBnjxj8t3xSFGcw7U5
         tYKJJRah8ctr2ghgiuk//k9Hoe9JygFAbx194=
X-Forwarded-Encrypted: i=1; AKwUvByKmBPM3j4PLhHN7szH7NfvUmQcB+iLwOycfITCSmY3OCoimuLpjnxKhYXdpdh+NePDoA2hkGE=@vger.kernel.org
X-Received: by 2002:a05:651c:1612:b0:3ab:2a19:8624 with SMTP id 38308e7fff4ca-3acf3a11804mr1195931fa.5.1793917484074;
        Thu, 05 Nov 2026 14:24:44 -0800 (PST)
X-Received: by 2002:a05:651c:1612:b0:3ab:2a19:8624 with SMTP id
 38308e7fff4ca-3acf3a11804mr1195891fa.5.1793917483605; Thu, 05 Nov 2026
 14:24:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-2-zack.rusin@broadcom.com> <DMMXHJ7E33NS.3QACG0ZSMROU5@broadcom.com>
 <CAO6MGtjWexwciLEQyqnHciZCvHSNmrKC=ezHJbc82C2ySZR5-g@mail.gmail.com>
In-Reply-To: <CAO6MGtjWexwciLEQyqnHciZCvHSNmrKC=ezHJbc82C2ySZR5-g@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 5 Nov 2026 17:24:30 -0500
X-Gm-Features: AclHuK8oEKPcSCrkkB3sTCTBXKIwDm-ASO51dMhGdrTIRsSX-NPXBdtzCDszGkM
Message-ID: <CABQX2QPVwBvs79t9c-Md4_O++NsFUZFixEmDqyH1Kn6v0foQkw@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each
 plane state
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>" <maaz.mombasawala@broadcom.com>, dri-devel@lists.freedesktop.org, 
	bcm-kernel-feedback-list@broadcom.com, yunfeng.li.nb@gmail.com, 
	tomas@slax.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000069f6e7065f8ef625"

--00000000000069f6e7065f8ef625
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:05=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com>=
 wrote:
>
> This is pulling in peices of
> https://patchwork.kernel.org/project/dri-devel/patch/20260414200819.88506=
-1-ian.forbes@broadcom.com/
> I'd prefer dropping this patch from this series and completing that serie=
s.

Looking at the changes I think we probably want to do the opposite
because this one also handles bo's lifetime and preparation failures.
Wouldn't it make more sense to rebase your series on top of this?

z

--00000000000069f6e7065f8ef625
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEkL
YtXy8vqSaakQpuDMrBR/v9DCeaKT3qvxWU8+ZsDZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEwNTIyMjQ0NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAC6CUm+xDDjd/0qvzMd4E1wQSK4mBPmy3iUCx+E5
/D8AeXV0tAP4p8jbwv02kDXic+YFfbI2XkxLgQBzWxnsaRJspa0cGoFfL6+g+ZCpYriOnp7+iSd9
C5qfVRiuPGK2V43yp0P2xy/axutwgBMaQkX7k+i/G5OGPbhKAQ4y/jvkZFJye0RO3UDvSF2qhtdl
OImEUW7PoI2ObaEFX/a47EwQdocunAvWQft8PxV+43u4IvRFMvPxFbmJHG09VirQkGw/tNGTVBX5
OkeKe8Xku2CNV2PrtbjVCs8mhAo9l7R2V017tSAXOWQu9Gvwej/FaN0sYMwe+xThwqg8rIEUpGE=
--00000000000069f6e7065f8ef625--
