Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72F37DE9D;
	Sun, 18 Oct 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332367; cv=none; b=hX7B9I8641PzxkKaE1vE76T8j2plY43W2VGpy8ySUNF81aF8GYn8w1Kio2C3jm+IIczxSw2J67/dFjUOk0uWk99p9kytIxItxYxs9KBX9WY4JRagG0Th/zRDglLlrDCgdBSPppZb0bgmtXOiJgPlhKyMu5F7ltmtWYMv28kvHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332367; c=relaxed/simple;
	bh=Y+BkAyRGCN6q34ggcR6L77gKGWOI+LFp0XhltLz2kxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XicKn/v1IWPE48I00a2zfb9VSP07gLgXw7BfrJwZKlZhHO07yLhq/ep+etvKfI6YrlRvfydeTZipkkTsknn17pCs1iCipdsmZAe6pZvnGlP4hXp829UMdqmeMKienL26GUIjFp1azRCdrJ+JYBfoWLztxww71T/2nSChbqbA5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FE81Xfw7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FE81Xfw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792332338; x=1792937138; i=deller@gmx.de;
	bh=DHkZgqiGxD9lmjs14XsvLlPDj5HmdXwayxk/aDf72iY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FE81Xfw7+rraPAB59vTo82+3o+kdX8JMlp9tG5sGw4glViJA6IsIG+iIp6KbzvMc
	 KYFCLwX0tlHk0SRMbhd+MMKF4QsULWbLedQ8JFToMptwitcuwAdewvwKaqaBvGMjk
	 Xh97roclr5MJ8dQlzhvyqyyjHk33WV+3QbTV8jhQu3brSE/cDipSH6YRngE/bHeTI
	 U32rq9/RodaFnVXy3hnJJ0zDlL9NYVcH00a8lHRBQi2UwsDcFdG9hzHesNo6/HlCS
	 Vk8qsNh7Nz3RppcWQfIhGtqJYK5dxmqcZ16hWxQK82xYzDB/pNBv7Mi7cdbBHHtgH
	 E9yAn1XPjlvDdJVV9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1xMrLu2Vyy-005YDf; Sun, 18
 Oct 2026 16:05:38 +0200
Message-ID: <b93a87be-f55d-45e9-8705-74a5c63600ab@gmx.de>
Date: Sun, 18 Oct 2026 16:05:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fbcon: Include font geometry in the rotated font
 cache
To: Yao Yiqi <yyaqia@gmail.com>, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-2-yyaqia@gmail.com>
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
In-Reply-To: <20261016073023.490430-2-yyaqia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5cBx0zqkWGvctlrRQ47HQ6YmnfVtt2dGG9glshvNcoN35m/B6o7
 aajPVzNaCHl0lqvTKf10S7LBdMdNIeOkKa0nzr4d4YFGKwGXO4sYhfaK7BvaS3+nCHfPZmr
 aMALjY9f8tcrFb69nW7Hlde187ySwZdI1QfzTtGFn8T2D5hOIbKnR/2fPoYsz0XMSjU9ivl
 qAxy5kmPr7Uq60kIalXlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vDR7KkXlrGE=;HBhf5laLFZSEsMwGC9gYQM4BntI
 YhOZ13CFFRlakFsSmBHh3a8CUy9WfDAklzWj1izcX0NYu7ckA7GPlaXEdN3eND4DAPeChL/t8
 K+m1tU28HplsF0xwHBg3+bghr0CDJnkjphG4OuZMVUP0h2EKoTnGt2sabziJfWyrSfI9DnXja
 oJxy7ikm89xnBMifewsatRxAVha1EXk68IRvOcsJwBIj7V5U8c8UaksxunXECIUDdGPPe3XFp
 HN8P6qIqSiC0mJyem1xMdypvfUwOmFXZMxdRsFY7kJdwbuRXP0ZT4yqtzF0+LMoPmfHf1RW6K
 ue+PtaykglYoCcAXNKGS6A+WvtnYvGRrbr9lSZpAalQkvnsBgM3+MaKI0cwHFnwbsPmAt244n
 SU+HTa5BeYJQuB/IEGgyt6t6O0tHTOPI8/HxroHAustIIeE0hThePl3oouSZnXo9/+pxFkuo3
 im3Vn3mvweXBFdYl/hPlKi5zIFwYC44JHQNRsHi1Wq3OU8fh6DlBwuQtmCFhf1yZ7jUal59AX
 bO4vENkt/jaV7fHvlptBjrbj4qL4OeX0hdLi4hUGGRPlTyO4KQQzssQgSGWecMrT/hk8uZ26A
 BI9V+wYTWaMEhCSFuk/XGOiaVNFyzoZ0dZqMZfG1I+9cEiHw1eXSHmBB00CyPeb8qevnuU2/g
 NGnRK/zuVf4ujaHj8GTlTZALTjR3b/qtBrQAzbYASLxI4KB+eY8tpgCnkz21VIKbr4vL/hjjH
 nmeTLK4eprzPVyFJF4O5Fw78WaEnSA+UYg1hYSeHN3a96MtKHUgiOslFtRUkp85WjI7O2RcOj
 F1YwKHtrUAX98Nka40e8qZG79EJCSjQDs8RRIo+DJha2Yw348wLNYg2lXWV2J3l2wLbSVOajW
 irDyVUH+BSGxJdcUn69Vt1EfZCfhWpWydTMUOxtdrBfURKkykDA0tY43AeZ+xm2ZNqUjJTR14
 ZhOeO0//iUqVjvXJkY+YZ1+4X8p3N/S0VUZG2oieYxdQCu7rGyP/ZQlk2c+HhlGquJi/bMjGo
 n0HoieTsz2s9G92LctXzSLEu6tInmL3v+lEgAk32RD6msCsTxY358dKEyUDp6o9T3DHqTyyD1
 X+azaap7QESIFQfhveL0BLQh87AMBc+lAwsjFengSH+Xyi+++7KLlvTdVeDKoer4URqJOgfTX
 VlNf5YYuSC2yafisAnrX+yhly9BxUyWiPSipaRrfEn0x92EsA85DGUo9nTlOuNCew8gsL0e1l
 1bFbgb+H3OhRTs7AQf650AJTk9rR3VL78IwTKUiPUMXqxDENDoH0cM+PCRH3nKm34ce0JhpCo
 yVBg4rjXfR6mdmphmWMw+v0J+lcG0zpt3rBiRZpM8xM64qBr7PwW4shV+LbhSBdUKs3qjvA6M
 xb9SmNWiFzzS+DZx8fVrfxCiXV4azckcDX1pJRmPHyR+ifHIDsLTDPYC0TYtPFr5fMZP61Ogx
 MHrNObGaMIvYCzHVwANgv6ZruoaSbGLvkd07jIpZG3qcq+8P4dpxJmazwQdQwy1LmUxGTy7EG
 LMXyuHVKgXOZXJ2F8j5PtgkTVH4ym2jW/9ZNmp8PQwIt/Df/px5/YQ83K9BMEh7vKvhNd9v6a
 +PRZUy/axsskCRaY2GiPOogSInxWcB/ssxqfliWz7CgMNmRyvs8nnct36VOt/hso/p4pH71OR
 lwHeSLWzxBsLwzsW8tAD/2KwTUI70bizpXxbPMklKTknw7aQr8Yj/WFtuBt1EAf1q+84QmlLd
 HdiiOWE5zfUTlBAC1jNtxNOd2WelX6PfqQLPqL6hrKatWF8j9UADG9W+ceNE691nJ9Ok2qiQ0
 DcSMpnrr+f/OJE0zyyJSWCwPTfqG/fkBKveXkfCxYtSf4v6720a2Px8TXtfUZ9d4zHwvWiFzt
 yKFOngdqwV+NhI1LZJX3Qavh4P6sEzcQ88YI4g75fq9HUiwoKH96b1U8Z8eFBIQZE8t2+BIj0
 Xp+yw2wHt9jPvUFzTuQ5l8s8eeX0gnA8c2+DwjB+FOLH7rKp7GQwb1AEv9siAVaX4mHPRW/rG
 nCmxKcZvYxhFvjel2aI8LywrvTD+Kg/Sd3M1eGz3UaWe7AhjfZ2y5U+KW6sSCroJiiY/AjXda
 RBFzubws/ibkomRNxtzFOuVy7SkQdMR6rIDCgG9OULQgDF84s62jQYNgfeUbDVEmFyRza4Xjc
 y4U5qRewKACLQf0pUa0IJdahrFZzYn1mYissbaVmEIOYqcMZDzTW+ipfpuAdRqBi4tPFZnI10
 Zy7lqBtHYiTtZ6pSqt9GKWd1nh7PHFIXp51uacbLN41i431ctSFCNcv/mwMMXAMNkvyzKSUbq
 AW/1QB8Nsm8EfukHv13UM3oqMFtWNHUlKJ7e9EsdKqY+0GU8496j2XDZenDUWxtFY7UMexkVI
 3+JOPXaR73z7pZnu7Ry3hYm3Octt28rQUeDtRJrX45QrlxFypSeEOUKG6k046dasD8r5A3QTQ
 tb5eECcv9qsVrAcXnEmXpFVwfdQWW5WlSSUHCq9MDShglN1Y3pElqluC5Uq3tC8a2OQI9tul9
 yc1P7qghFwWvOarpY6ILtE88sH5WRCQnhh5Fy/NtY4s5g7RBe4V/SAqqKqBq9W4HcLjB/2BTg
 YHYekn+fc9yq9h1D4d7zKga9coVheQ8NyGG0dcsekVsdZasS7wY2uVgvsX3mf+TO9HSe7UowJ
 aKTMPZXGswES0QG3l+wUR/UuoBsy394od52gtZLlaO9HTx6OgIXI5QPdtUkG2a2qTbWmbvKqY
 WxR9codlBHp3L/9hmaI+K3QIWfAMmFJlPAkslfURlNmqOcFohaYAbl9Iq46UYD8B6RuIPmjTb
 Ut8NN1Cm0EYhEFkiiwMIQest3W61XZybo/jBAhXBj153fOYfpIIRotlZUf7UsOBLigIx7jzXU
 oNoqNWoJ8BqDawRIlph+pfeMcW+WrzOSxUYNwHKG8zcbpayxlqe1SR3mKpKMGVxMiG2Jof4Ez
 U0HkziAnZLs/CyL7NXTm4lkNnHhCDFXEweEZaoLsABQ4D4BujEnd75KxDuDxAOpBkWdVjV3w3
 lnjdN5Gnq8/ZR8RfPTGs6AFicOT9c89F0OXpeCUAwkGwnUZBTULCCQ1txP6Xb0uOw13ke6SO3
 eQQ2AVWhOF5AY37TgAroLmF3ikZj9rQr2aNjlz2WhYOlTm2ZCh8l/FnrzvgMdCF70uVf8cMMn
 ve4voSaj7Y7N3gONw+XQ26MLZuN0jzszLx/oCPVUN2qQ0AktH5B+PGfJ3h4NMdruwf4wUEJPH
 Mo+tSlUqCBW/hjiKCtqANmzDq9YTJgVYjwdEj3+A7KOaEuGHISLqcTtnVbmx2+0ZerXf1MRBv
 rNUKj4xINzXrVeyHpS5pMI8L18OiNpmzREdlYIPxidFi3m4wPXGLGG3Lz81tuLIrMMAyFqA3a
 jvKFirSetA6987t03SgWGoq2FOWohTmVnDn01/dQTP+XUN7+JRIhvNYB0IHy5bSrA0Axvs50z
 oAWadfJMsfSq+09SHebqqteIldw9bTIUyR24v4Qtj9k9Nn6eb74RFurH72NvcoXxcwa3Rqk8C
 MMYr/yM+TKt6nPxsp7r3aZEam5P4PG6sLsH5bFIMr4rISYBUA3+ALkUUW137pwoWSrlsPbTQ6
 naIM/2zpMZUOSUaR4XnH729dpvnp1Y2vyMQRH+YFF9DIil/yDd8A9ypHc6uTD0lg3kz9QTGd4
 MHtoYXfwltQZ4lDWQq4prgvPDBeUpl2tN/Mi/3P4jZ5er7tPulY2GmIg9DkwbH7Y1WTmKkln2
 J1onscGeol+f3Y7BkY4IEsNVvB0z/5TnfY19eXpfAM/jMj2EhVoPbMBsm/fNvu3yI3pnW2lni
 YC56gvzQVHtCMNxbjLLqW9djgAomju/p/T6TZwopCpXpk5QhX4xVbonYymr5/5gBunfjawkRJ
 +hNB4ZJYN3YadNN9q3FgprOtqTmBvziHW/ZfBpw2Y56/LPSfQtZTmSu9acrRB7hiWjrLZSrj2
 eJQBU51WG3E/eIXMr2xOIbbL6JAk7Io8U+Sfq9a+WVnJIAgwhpNI7Hyf/Mb6pQ0ujwlhAvk+l
 Pos5Z/1GmxwLyUc2RRJJIXYPj67h1ZnwHUPDOTB5a01sKJxZYrFJ8tob16FtkVW1myCm7dNK2
 0TO/dhKICDfu4dsaPCzdaSnYX6+V1zA0bN4hdGhi7Rtep/heAAB0hT4hUuBjWXPstGFr3SAJ1
 7OBVZrdTX+dkZk2frXEZN7wU/l8i407Yvx+F+QdV0LzMBp8I81xgOYC4v65PgN4DNWythz+D7
 Mwlv653IDlCoMPlu7ijqp9fctvAUX8vhH+KBqjSdVmVz/b8oJEODn1SxxHKmte7W4F/oGtydY
 2BlMH9WFc5CKecpUxsQdPdLspBzyJcq2C1pfrtGjRoR5gTMV4fYI6sOAX6LvaXxILs/YI4Suo
 IPPqZnIJj9oj0AgYv+1aEcd1uMhmUlOpyhymb4nA1g9QgA0HqgyzQmF5glmjaubAJRW+VPLaG
 Y5Gkm8GNLlIqvesWVlD4GshDtKL4kvM8cne1905KOHA31ScBFBh7YsyTkhcFr2nvb0nMOZZwK
 nDzpPeL/l7IzN3nr3/bUkstjPaUWT9gYE7FcuDwrpGE8030bluEa8XzreZMO4YoVoQnQuIYE8
 UUUT5XpYKSyPdRrA3INL4ydv579gaS1cDHpMIyvNYbDTDu7+PtkSZOug8GTHdR1CWo9ISCHbj
 vxajXyvSHbrY7XrBGJTU2nhBWmRJJ6xqPypob3fjWq4uHwhn+sTFIj4YtScYtSAl5vxgfDv+k
 zgbb0FbB/CEa+yuxbNEOfPGKNTOcpJ9TDKytpeMwUtJi8JVX9cR2aJilnDE1yMr12P1FIz0Ni
 5u8udVjCsPzAhliFAyjSOWBquSUkoZub4A7+61yZUHTS43p0L3WyfvONGqf7ZVltrLeJmqsXc
 qZW1GuWdV4eQTL+slswLjYtN/hVsg51Wi3t9lpg+lPaSfD9Ld/SlzsSiAH2G875HbFUHcOgbq
 cWAnKtewsfxLRoUOgOYrHzI8GTHfngrdFE5bZIenrn1HrK0VKDIfml+Uy6KtjO08rnTWT0QZ/
 VLTBolrEOLo2oUR67aBjiagXr2RSPJvSKqZSLaTKSg3hBXM8A5wILynH2rg92lsLKl62sc79k
 UrP+gOeqD2IAUI187/72vfR1ZxLN5L5MZRrzp8Pa3yntmHFG8TYbtX9J/2E4ZWyPDZM8SPSCr
 UzrdfiALrGkq0pTEw4f5VNGrWCIiqtcsBWmK4ui8mENLohoO742mA08hSUsu25QYxJAo7jwHR
 FsJUeS/UYu0gZTSnu5L0sqOxUucV2n2RPaBArxwYmSNNY2J3GElo2itRMWd9ADoY6Kzx5A3kG
 jDpkD8xHbUmy4dhaexjAIavFMCaFjnFceLidOUdakO21sD1roqT/h622K/FH4uOTEfYdI0uai
 Ln8xg3qujyARvqN/PPBeG0vKFxy3ycOW+e0FzATTJARz77qdamCKCZ03tZEh4ScHyfXYx+F/q
 iCFdVwSR5wYi31vled3o2JYCXU2izMgSLTJ1EUyrULWRqPHkoZ2JtkQ5lxlPVp3E6huSjzJM/
 18LsaT8VG9KvO5zhBBYuGe72S1JYQ03RfvHu6NXPvnDD6RIsnPwhi6Suw5MQg/ZGQSmc2t2vX
 vBaUBmGxmxBl4r40OEzFEZc/eY9MmLarfmo8oo+ToQhjNjFcSsn8F/qB4WGQn6KNZF85LzsJ+
 c/LadfOMaNcneYv/83b091lqTFCBVaBqVba3WBA150McmbytDhsnG6/W9rWM2W+RObquzk1EZ
 ifYRikyMDY1HsVROhKe/mk15APoljermMRrTV726liPzL6IMdcDjosfLT6U8B353TNhfaNJJz
 D8QcsdzcVQL1jfMazAdCsO0XZFRH2jSpSC8sjUlhp1ev9YTO/VisxP1ZpTyeRsTHPiS7YTDRH
 k/MS+iOYIutFIv0JSkHyD9LC/u26qLJ1Ox8BCi0fuaeo5gm8/1tTf1wCCiKlpj7ug/jjqt8xb
 +3xL0F2mbqo80NNdVICmfEctkCA3r5BKAWAK+oKRDDWqRic8bE2E497+9CjTro1crh3zeFbC1
 0gltxw7yAji3NdYjALzMByDnrk0/zOx08ue8ZpOPyThLutfLPvVcYzr4gwyHoAV4T9MTMRGNX
 +PasI2AAXTJ4rCpiaeA7fl5PcUqqRNOkN2+fb9TcBIcmZNwP6Av7fG8BpcF7TwJt7fbFu2IIt
 zKuvQIV4YfHH3OZF4nQSr2epZJ9TRsdQ9dBdN7NjqJuwg57oEs4hLECnxgefyEP/eDNUlrIXN
 tlOZFVW06r9fK+E1UtkYRuZhaIEEtq0IIuYCDCRmLyL1WVcCEHb1Y7GzP8SJMSn3kZwhqPaJo
 SVIejueQW+rBh0zd28IGaOOer7m5Db3UU/6APQabsHMD2pCSsy2u6D41K7B18jBdFjFK3xYw8
 okRwLbyFmS6M4SRun/l/MI9ZIMQs6BXnr1a0k37+4+YPOAvIJyuzWQijEdPfWSXfsjDiSz63S
 PqzFz+3mN8X/47IiGzhf2M6t+zI+GCVmaQMvuaso8cx/xVas+qw7whJHfOeLdDHefhbFwqFQT
 Kwaj7oFiWMOxcK1lu72SupLVtwkp5xpu0oOnXpuS7DvkShdhsI2zz1eu/QCEv+pBvCloNQ4YA
 hgRdmh061Kt766sInC8s=

On 10/16/26 09:30, Yao Yiqi wrote:
> From: Yao Yiqi <yaoyiqi3@huawei.com>
>=20
> fbcon_rotate_font() caches a rotated copy of the console font in
> par->rotated.buf and skips the rebuild when the cache appears to be
> up to date. The cache is keyed on the source font's data pointer and
> the rotation alone, on the assumption that an unchanged fontdata
> pointer implies an unchanged font.
>=20
> That assumption does not hold. Raw font data (font_data_t) stores no
> glyph geometry; width, height and charcount are tracked separately in
> vc->vc_font. When a font is uploaded, fbcon_set_font() deduplicates
> it against the fonts of all consoles with font_data_is_equal(), which
> compares only the byte count, the checksum and the raw bytes. Two
> uploads of the same data that declare different dimensions therefore
> end up sharing one font_data_t, and a console can install a new
> geometry while its fontdata pointer stays the same.
>=20
> The early-out in fbcon_rotate_font() then skips the rebuild, and the
> rotated blitting routines index the stale buffer with cell sizes
> computed from the new geometry:
>=20
> 	src =3D par->rotated.buf + (scr_readw(s) & charmask) * cellsize;
>=20
> Rotation swaps a glyph's width and height, so the size of the rotated
> cell depends on pitch rounding and differs between geometries. A 4x16
> font whose 4096 bytes are re-uploaded as 16x8 on a CW-rotated console,
> for example, grows the rotated cell size from 8 to 16 bytes, and the
> largest character then reads past the end of the 2048-byte buffer that
> was built for the 4x16 geometry.
>=20
> The key has never included the geometry. Its exposure was limited,
> but not eliminated, while the deduplication in fbcon_set_font() also
> compared the consoles' font widths and total byte counts: with the
> charcount restricted to 256 or 512, differing uploads could then only
> trade height against charcount (such as 4x18x256 against 4x9x512),
> and even those can change the rotated cell size. Commit 1e3c49aa03fb
> ("lib/fonts: Compare font data for equality with font_data_is_equal()")
> dropped the width comparison, so identical bytes now share font data
> across arbitrary dimensions.
>=20
> Record the geometry that the buffer was built from and compare it in
> the early-out, so a geometry change always triggers a rebuild.
>=20
> Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to r=
otate font bitmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
> ---
>   drivers/video/fbdev/core/fbcon.h        | 9 ++++++---
>   drivers/video/fbdev/core/fbcon_rotate.c | 9 ++++++++-
>   2 files changed, 14 insertions(+), 4 deletions(-)
I've replaced the v1 version of this series with this v3 version
in fbdev/for-next git tree for further testing.

Thanks!
Helge
