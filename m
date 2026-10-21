Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621574;
	b=sXEqVYBDZFKITzKuFnUzYPMHWWD1y/NowXfdQWbPJfB5j8AEFSvahOz5ZHnbGcfw/ird
	 jE8bUXi5OG3p+KiOUzIZZGFpB4vSkyoa6P+QsoR6jKDQOpgoXRBonJwKaX0W12L3x0zSH
	 icyJGFPxLowahMwQhjEm5cW3WP8KeWJN2xEAl5q1Z/rufJAUnGVwy5Gv4ZGXM6oOjNS3a
	 88C7Ci4ERubdQWsb0eOP+JK2qezRv+U8Q+w/4gKrQoqerEyLpmdScShRI7LK9NrxBbqDI
	 crx3x4Ke/uK9t+NQgmsrbI4KwdVtLyzNR5xUZrQYf3QwXO2JfOyjIhnDyDPeZVERIYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=NroIrz8qWTqeDCNildcP4OTICrkYNZIFAPA8lK5U2hw=;
	b=VZgq3WV0gA0GuTap678B7+zNUWIE4Po0qwT9iOmYBOtYvgC04l6tBtmsMT728eL1kXv8
	 WaMJPfPu4bMpQxTVChJvd46X51nw+nRXZ4C5yeqah8lByGBBcyv68jJ991pB6T3DIW+99
	 1VI+61F5CfpFbJSnqlyv4UgRI8WR/vDGb2MBN2tN5g3woRbRtTem7iscvhuyU9/jtkfeU
	 tG9e56IPtVrYjl+Tw7V+jzTSimzlVokopvGjW84Lx2rCC/LgHyDaIiK7jzKD1auuErwrA
	 jWHVH8RPouI8SsLdgL0eshSHFzPxJKjTHwt7DNOh1bn1IEu5OO3mp8BP3YI8KFlYLow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hLdjX5hn;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D96606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 22:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hLdjX5hn
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8aea7b7ca0cso11235077b3.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792621572; x=1793226372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NroIrz8qWTqeDCNildcP4OTICrkYNZIFAPA8lK5U2hw=;
        b=hLdjX5hn/+5D+RBXVWHNfzNA760vWbSaywCvvrfSX899MgR3yunT/occcWh7Xea7Gc
         acspu806ck/QDcGEkYuzAW4HMUG7vEow+t9Af+/I5jjMt7nk1OP25FKd41ttWSFt49LQ
         wf8XlxH8+B9ETe4SThIhXz9eokRsOEXHCxVJV36tsPmDm+zkjTQ/+h+3nwPM0zRQqazw
         flPwTO7YBY/lI9tuSbW1YF9dup9I37nOgMDlR4HnUVQW67y6t71NlYcYP9CUavCxESYG
         QzoTVhLUoEMEXjIEUXRhvU8q2ZKS8rfCgxCWzGL80Uk2NyPfv9TJjCnJvy0j9CrQt199
         aLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621572; x=1793226372;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NroIrz8qWTqeDCNildcP4OTICrkYNZIFAPA8lK5U2hw=;
        b=vTnq1CZizKRSnq29ptpQEeR/g7gs3Bqqyd19PYL96YYG3Iz0Z8fLugNwHX5CHWNrUm
         U6ecM/sQ6pe/lwmLe8OPUmgP0EMzFKa/fFxTWCjNvoVB830XVLThakiErJL92WgS5YNa
         IcTQd4BfAtCiJoJv/CACTA+1twvZxpdhM7rxxr5aKIn2xFkLmcLRck5Kny+lIPaSc7R/
         xhrCBgfcb6BTV513YtraITBDhxd2En4ukUdBaGkhpLcajduVsBPqg83eHHFYMYKmgUMc
         kgJkyS5N/zXiVOS/bBRwNYYTK5duIG7SaJCB/ZveIg0MwSVGSOV5UmaAwHOzwQEdlzFg
         aZxg==
X-Forwarded-Encrypted: i=1; AKwUvBzZ81KYNp561uj7FeBizOfUUdrGqvudv5aWFLvs5+EucOotouoqrugjR435x74R8SrcwpLWhrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnY5TXrkAyoDHH8s5UDAklCVxIhDHskCECzRxbwB5DTwXnvIE4
	M5gH56hHRqmwJ0M5t/Vb7oFcLp6XOIdPHVZ2pMOt6W+FWSpEmWlRiy6nlC30ePoHgyh4s2tqQs5
	FU6UGpOE=
X-Gm-Gg: AYBFou0w5EUKV2UE2C0eIB0FXYMxeLKFELtMUqmLfmMzTlDDLn7SLiSZWsUNvbQFZvW
	IT97Z9u+Fni9ARZjqMFH3rc9pEZwLRGuu4iVh1ZLlYaHWBtoQohuyaT4+ohVpvhvAX8lMpn9DRf
	ocGsDoUTCAq0CrDKM1QOsOFoOgiqXESSqB1pzC8kirQDmoXA4N+Jsisu1d00BsDs7ix4VjUKoMN
	lPSCCOiagMoQ0wmNQcfY4ew7aoZmQCEFHeL+syHDCFUQwPLJ4re125ohsJvPVWNLTzwNNm/e4cS
	UpMN56reKes1zEQ1MXKxnNjp20msNGszCl3vRUE7iGqgkekd/lVzrngxADBylme2v9w3JEX0LMf
	LcG90aen2sQP9HoEBWzsUb5fvoKdG8U/px0klyQRj2pN8YhfGpClunVW4aHqCW6X9XeZFCRjO3x
	L3xK3zCp17g+vmkvES5F8I4jNGaKonVb6782ParlySgOxqwI5Vq7qSMiCu9ei0s8eSS3g0QXcsW
	PUHYSoT29cxR9YtNz7wkoTEBXPx7OR142Tdd+GedGNIhC6zbRsXRu2Mj6lNG8ZjRrQudAsFs9Qv
	GsWOxfV44kDrJmH08CduPN+t/HF09K8QS6CcfvwJ/XOuybLKdjl4pPRg/GNR34+Prw0Jnj9ATn9
	GTg5JgWW4
X-Received: by 2002:a05:690c:962:b0:8b0:acc6:8e89 with SMTP id 00721157ae682-8b133fa1bc8mr16414697b3.11.1792621572385;
        Wed, 21 Oct 2026 15:26:12 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:de6:d01d:526b:32a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300a7299sm18068657b3.16.2026.10.21.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:26:11 -0700 (PDT)
Message-ID: <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 21 Oct 2026 15:26:10 -0700
In-Reply-To: <20261021153141.311425-1-hengyul@cs.unc.edu>
References: <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
	 <20261021153141.311425-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 11:31 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Mon, Oct 19, 2026 at 04:29:16PM -0700, Viacheslav Dubeyko wrote:
> > Frankly speaking, I don't see how your modification can fix
> > anything.
> > From my point of view, the current logic is correct. Probably, the
> > call of this method is not in the proper place.
>=20
> Sorry, my description was not clear enough. Here is the reproducer
> with the actual CNIDs, on a freshly formatted volume:
>=20
> =C2=A0=C2=A0=C2=A0 operation=C2=A0=C2=A0=C2=A0 allocated CNID=C2=A0=C2=A0=
=C2=A0 next_id afterwards
> =C2=A0=C2=A0=C2=A0 mkdir z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17
> =C2=A0=C2=A0=C2=A0 create a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 17=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18
> =C2=A0=C2=A0=C2=A0 create b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 18=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19
>=20
> rm b calls hfs_correct_next_unused_CNID() with cnid 18 and next_id
> 19,
> after b's file and thread records have been removed. The catalog leaf
> records are then, in key order:
>=20
> =C2=A0=C2=A0=C2=A0 key=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CNID
> =C2=A0=C2=A0=C2=A0 (1, "untitled")=C2=A0=C2=A0=C2=A0 dir=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> =C2=A0=C2=A0=C2=A0 (2, "")=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dir thread
> =C2=A0=C2=A0=C2=A0 (2, "a")=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 17
> =C2=A0=C2=A0=C2=A0 (2, "z")=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dir=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 16
> =C2=A0=C2=A0=C2=A0 (16, "")=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dir thread
> =C2=A0=C2=A0=C2=A0 (17, "")=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 file thread
>=20

I think I see your point. So, I think that fix is much simpler. We need
to add the thread records processing here [1]:

			if (rec.type =3D=3D HFS_CDR_DIR) {
				found_cnid =3D
be32_to_cpu(rec.dir.DirID);
				hfs_dbg("found_cnid %u\n",
found_cnid);
				hfs_set_next_unused_CNID(sb, cnid,
found_cnid);
				hfs_bnode_put(node);
				return 0;
			} else if (rec.type =3D=3D HFS_CDR_FIL) {
				found_cnid =3D
be32_to_cpu(rec.file.FlNum);
				hfs_dbg("found_cnid %u\n",
found_cnid);
				hfs_set_next_unused_CNID(sb, cnid,
found_cnid);
				hfs_bnode_put(node);
				return 0;
			}

#define HFS_CDR_DIR		0x01	/* folder (directory) */
#define HFS_CDR_FIL		0x02	/* file */
#define HFS_CDR_THD		0x03	/* folder (directory) thread
*/
#define HFS_CDR_FTH		0x04	/* file thread */

The current logic simply misses the HFS_CDR_THD and HFS_CDR_FTH cases
processing.

Thanks,
Slava.

> The backward scan skips the two thread records at the end and stops
> at
> z, so it changes next_id from 19 to 17, although a still uses 17. The
> next create gets CNID 17, hfs_cat_create() finds a's thread record
> and
> returns -EEXIST. The correct value is 18.
>=20
> So the call site is not the problem: the records are already gone
> when
> the correction runs, and calling it earlier or later would not change
> the result, because z still sorts last. The problem is that file and
> directory records are ordered by (parent ID, name), not by their own
> CNID, so the last one need not hold the largest remaining CNID. The
> patch keeps the call where it is, so the drNxtCNID correction that
> generic/736 needs stays, and only makes the scan take the maximum
> over
> all of them.
>=20
> The unpatched run in my previous mail matches this: the first create
> of c failed, and the retry got CNID 18, so the failed attempt had
> been
> given 17.
>=20
> > I don't quite follow why do we need to change this check? If cnid +
> > 1
> > is smaller than the maximum one, then cnid + 1 is in use yet. We
> > don't need to execute any additional logic. What am I missing here?
>=20
> Nothing; both checks return early in that case. !=3D additionally
> returns early when cnid + 1 > next_id, where the cmpxchg in
> hfs_set_next_unused_CNID() cannot succeed anyway. It is not needed
> for
> the fix (in the example both checks go on to the correction), and I
> can drop it in v2.
>=20
> > Why do we need to check something for previous one? If the bigger
> > cnid is in use, then we don't need to do anything here.
>=20
> The lookup only runs when cnid + 1 =3D=3D next_id, i.e. the deleted CNID
> was the largest one allocated, so no bigger CNID is in use. If
> cnid - 1 still exists, it is the largest remaining CNID, and next_id
> can be set to cnid without walking the catalog: in the example,
> deleting 18 finds 17 and sets next_id to 18. Because the fallback now
> walks the whole catalog instead of stopping at the first record, this
> keeps the common case cheap. Only if the lookup returns -ENOENT does
> the patch scan all records, which also covers files without the
> optional thread record.
>=20
> Thanks,
> Hengyu

[1] https://elixir.bootlin.com/linux/v7.3/source/fs/hfs/catalog.c#L349
