Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526986;
	b=fk3YSb0NDe9LDjxMZGy+yj+CN2NJVvFv++ICpIuooQ2YhogvLctCLKC+15ClhCKhF+Dw
	 /cykfClPZuuNaWhAb2cXZwBqp8adokWV3zqiZRggNk2MNAaNGNIhB5KtkkSONIcvxf978
	 XGLvPXcx8OlUo+O1VaIhFkDJRtgso7XSBAAjcEUNonxI0NFFpfI8aFU2jtuqmB1WTWn8G
	 d4I4JALG72QbIZqTGSkQ99HXZm5Bm9P5ZrwD53aLs5WoOGcU9x0u1FHzX5IkpvVhWxQQv
	 B33KWQRgI0ssRjBbzdURE/UBVzVbEp3kvjmv/hblgnG2npodIXoNTLzsmz+OJSRITgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526986;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=Ea7e0dr0A0efw/0izD5fHfZwxSDHa2lqh6cctINYdzI=;
	b=yGdt9/kjwFiHNzo2ZXmkhDs1mtmDzgEWXD3WL54j4QlqcYgOYp7u0fcMrGdVnRWQv+7X
	 5LeJUQWIXEa+BYb3UyFgATiIrogVQ4oIuDbDvYuuN6VI2HksUOU++M54PfvTEGIz+0mfp
	 OToc+Lwjd7Ty8dNVNiKLJTb7b8D5ZCJ7c4ReJZjSehNdP/dVGI8h4CXeyTmAUEPJk2z+9
	 G1oxclT8DoxcTUUzuwiVFNwPl9oDeSlOFu39dUsLJnxwtIgVJgCPe3eHr1Vi1F60IbCht
	 azpiH0FJVyIduOn/2mrXMbp50Ti2aTHYEAXy8rR9BIeV5GnWY8hq8cxiQtJC3GgUc/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=grzts+Kv;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00073606A321;
	Tue, 20 Oct 2026 20:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00073606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=grzts+Kv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792526982; x=1793131782; i=deller@gmx.de;
	bh=Ea7e0dr0A0efw/0izD5fHfZwxSDHa2lqh6cctINYdzI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=grzts+KvK++Hgl0nbcd2Rp8H8WmIj2c1DziUFMWmP6R9PrbupDij0zjLR0Bb5V+m
	 sEuQ7gDOtkKrJuUc+Wun3CFbaXVN3qRi2ygP2A1bzhqW5YS9BE1A38Cv0YcN2qwkC
	 uFmoGNBUlODzhS6AmqD526pSE5gDawRx2rN1uDaG73QPii6AQKmFSGMRoTFswaQFo
	 ZUth1mAdZ8OMhq5HBCAyzQv/iJEGB27H6Fy7a7gYtDh1mljGvpH8egy2zp32ka8+L
	 rBzCvNiGeprVaWnH4rTYw+hQVhsMLua89CdZnevoN3bXaju+Zic+ri2HKDIJ4ig+k
	 mYmPmJYBvAO7f8C3Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1wYcpT0z8L-014E5L; Tue, 20
 Oct 2026 22:09:42 +0200
Message-ID: <cf9859c1-2789-4f4f-8d03-aaf1eb73ff74@gmx.de>
Date: Tue, 20 Oct 2026 22:09:40 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: bitblit: Fix glyph clipping when fbcon pans
To: Tingjie Zhong <catme0w@live.cn>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpOm91Lf0wzp/fR6llXhKtRATck8EZQvxZyVoT/J4Oetwt9f1w2
 9Z2pBSuDh4Gk1ZW0UsnbVJZD0d+b54v/8PV/aHnmfLNw16+OV9KeOYb/Nmr+aTq6lPGskMB
 neJLDqjD03HCGQlBGmy6Tr5cx2s0t05WhAD0NPNyTdE4oeRl8uHDLGdNU2rtSoq7ykPSuTI
 jLR432OmU+ZI4sEuFgdEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SPQKMUIY+VM=;RXsJqyNglk7++9HRUM/FGTttL5N
 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
 3mKAGDzX7uUyybu/qE2AhCjjfLlHs=

On 10/20/26 18:46, Tingjie Zhong wrote:
> Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
> vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
> fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
> so after the first pan most new text is not drawn until the next full
> redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
> FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=3Dy.
>=20
> Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
> use as the drawing area height. When fbcon does not pan, GETVYRES()
> returns var.yres, keeping the existing bound. When fbcon pans, it
> returns var.yres_virtual, which the framebuffer memory must cover
> anyway for panning to work.
>=20
> Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vma=
lloc-out-of-bounds")
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32=
135c2f99@suse.de/
> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tingjie Zhong <catme0w@live.cn>
applied now to fbdev/for-next.

Thanks!
Helge

