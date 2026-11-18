Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027784;
	b=u9mCm3fC7R88Ga6rwM3CXYVdGztNMSS6pg4XuZDom05v+VKt7kBENUWnBKOQUj9xIt8o
	 4UiTbOeggJRf7lGCUQFDWELr4lyBf82Tt5UTYTomPBIcPPJH6EFTkbCT3E2rTBanq0v0e
	 z4KwwHNf5yYL/PP8D/dtXP9dggbSvPeyfUUtNfPgxrvjn00QtlotiEGDEZUiQcoJojCBr
	 h9tw46EdbMVzbCqarxdNnNXI4Myle9ZoUeY1mEKQv+1Ydatf1qB8U2afiLqspcDIz1kzK
	 gi3z/4iUZr02NkubYIY2GrXRGd79o4OtqbR2JgZONCxk9W8/5buW7GvcQ4JduI/62jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=B9P7DvURNMbONNuOK0Blr2zjjbRKurtoh2O12l+4jW4=;
	b=feFC2/QnInVscAAKq3ihik8ig2K4NxpcKUadmhViOYOBk6GMJ6+VGTvjnoZKU4o1bgIl
	 LPSoXDZaoZsGiIHavmSLcR0eOKM804NqH/IoVcjxv6FuBJz6po2yxurfRYh39sK0U6xiu
	 dCWJq9pOj+YiAkJClB+FqAuP3pTMLDQpJXsFyJRK6nlQAqioss7GCPYLp+/SQWRFDVOsw
	 nvKMQl3N5sA+gKEZJ2LWfAD8DpFr2/lJPJcbXnDtsNbwDDj2jHblIPpZkx4mlr+hMpyYN
	 O/s5AzceWxLdqxbdLIlPiiQvwEdyU7gS4/juFNv/deuIo8nakrIN6zPqNaDpS2ksiKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NJsy0raZ;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028D606A331
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6028D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NJsy0raZ
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67db8985419so1837998d50.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795027782; x=1795632582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9P7DvURNMbONNuOK0Blr2zjjbRKurtoh2O12l+4jW4=;
        b=NJsy0raZSppikWGTAJ9ZVLl2ARZI3u8oRBsOmDIGjPWAZQ2+d2hMHGPRB9/sTNG1oE
         DxoHmq6LlI1qDdZkXTA/Oe1vEhESE8W7eQOvTuavUQSB+EHbp24J+B41YyVfK49F3pxi
         CyOrxHUe9EDzynBqUZMjeIKATlPL41OJWRtom79afI4l1i/BMNO4+kMYlC6hK/wbXdop
         5EfERewsWAjINmUUAHdTdLQ3Cl3TFMMvJK4vje9FJDJZoQ1tjLyWbFOTJFSopeZk8KDt
         to28wGyVjsfwFuubEyIpFrcPxppQy1g/A7nIngbuEZeNIhoNrZ+nAE8skzpdHWKSDC6+
         08mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795027782; x=1795632582;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B9P7DvURNMbONNuOK0Blr2zjjbRKurtoh2O12l+4jW4=;
        b=1ODV+7tU7FR/zdHEdnL1ZYHbP73JDltpgk6ndYQOIXXQM0jgicKOp1AVqHeMTe6un8
         xTH38YTEwXNq9gQw8GI7a+1TqhVFlrxqdTAxPdYUJB8bbjvxTRoqeEFuH8wRdZmiRk+r
         KfyAt2P7qHyc1ZISilWJgth0oEi1LNPDGalc72coNMMWAmi8Uaw4VEdCv2MiM4Q0vxZm
         BL7py8FGENG8kEXBXouxm4Y1uuZJjZAfzxx7/gxZL98lw82eOEjOq79I6WpmeTxWJDEs
         Y290F1OHrKA6RtZoEIux9qlyJaAFfm7Hur56olYDW7ZqEN4NlJM5L4rrvqEdt5Tteaj4
         GkPQ==
X-Forwarded-Encrypted: i=1; AL+hErFPeS/ZbEpB1Vp7m87DkhDLHJ99tPpnnOwnqtLxVx8eMi/3T+MuESPH60M5aE99WCkcLyCx+s8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HYgwaaZwDUVimYMzib2MRtyv6M1IE4wf2VKcmyxtq0h7dVXZP
	/2qm5FsjMVeb1uBTANkrIa/WoB3bx6jHrtCMOvqSeHiP6xDkmmzqUm6fd/Uo9l0Lols=
X-Gm-Gg: AZFdTZf6KZcf8Rs36JtuFXKaXty/tyyvJYV1rBRbsKmsBb8T9apjQIFFiUkSp30R9dj
	C+iZjnU1u7AO8xcUeM11bKuHWFRMvcwgLVOu63/P43LhysAmuHdDOtXuBqW+Bpra9+qb76WcwGo
	xBWhZw7ZsszPKC9vtz2ustLmBBQuXLO9gr1Bn8axq5svqLTe/PMiAtjiUptCIhRAgGSZMyhfn7c
	hYw7TnDDjIpuh0p+M88B0CAWtKmwmgdaE+wIuuCuFNQqhTEHmNGtTKIov6jGkdTzRyW7ubD+vxW
	iN7RxrGPYRWALi0WRtgRO/tZvpWS1JqWqFFtAuDuSZqrFijlL7MpQkbwsCBMvPDbLK1N+W4vpRx
	fB+FQLhE44v5upmk6JlEXOJuIfvdnJT4pQ7WnH4sB74VZHH1QgEHsDuG8Q9K23D0Sh1QCjyCuBa
	D09RzxSLPTt5dlrBxX5+ZDDVFKfQgMCKMwyvRAIW9KoaEQNOZBjQZx69AO209XrO4hE06ivgiDB
	uxNRrJ/imZ/XOyLez4c4v9wOd/dEHfTCwWHYy69M3ziVgkYlSyL2cK2tPp5bn6jrwdrv58oDQXm
	7BHLAsKqvn46P9cO+qUK7xhE3dgbdEpv1AXBcW1TE5PVVvVTchVcOJU/i3Po7T+mJbx9/CmtxQS
	dTXC//m541KP5eZCPN6B7sFYRQlJpCejD2QsoJWqNAf+DyQlhX296pzjP/ApTwZNsVLY61zs=
X-Received: by 2002:a05:690e:4501:10b0:67d:b472:88b0 with SMTP id 956f58d0204a3-67dd45b46e4mr1055606d50.86.1795027782440;
        Wed, 18 Nov 2026 10:49:42 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd5864a67sm2128473d50.9.2026.11.18.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:49:41 -0800 (PST)
Message-ID: <85c26064db32f34da57b313a2e5d505f60ad1df4.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: validate uid and gid mount options
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Lei Qiu <750592120@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 18 Nov 2026 10:49:40 -0800
In-Reply-To: <tencent_684DDE3E94F7C2470E5E02BF79AB1A1DB906@qq.com>
References: <20261117024431.21914-1-750592120@qq.com>
	 <tencent_684DDE3E94F7C2470E5E02BF79AB1A1DB906@qq.com>
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
 tXWRGxx4to6FwARAQABtCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT
 6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQgHAgYVCgk
 ICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSwayDwYDvgWW5
 EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb16Uz3PC93
 nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8E0O7lVJ55
 p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD4Xg9YE/X8
 pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLVmWWSbgosZ
 D6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0ZlStfp0kf
 VaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7CUjbX9DHwe
 GQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZTyOLVJcAA
 lVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWHfAMjjkInI
 Pg7RLGs8FiwxfcpkILP0YbVWHiNAabQmVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvL
 mNvbT6JAlcEEwEKAEECGwEFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRVwwtrZ87KC0
 La2wQ5XNnC34RAdQUCaBpeTwIZAQAKCRA5XNnC34RAdew7D/48vw8dfTLcVjp4j6qUH9rOuXp5A2b
 jCEPeI0oOwRdqkyiGzUfUprHM48owvvye5u1mUZnKp8BWDDsjX4ddmhdloY0+6ecRAG73xlWMFKVK
 4P5XGnHU9A2JOtRhnOWQfPTgFhy69BSYyOeG3e5J+xPyUUBeHajbMVPKnD10NMCx8Ux1D2bv8OWbv
 3DvpUNx9D46UhBmkwIfrQWBkr0OGD2AXFfPqo08c3jcJMOAEc2vBI08Fij9o1gHwP2suFaG0X6jUN
 sy6KPOKg7TVMXtMzxNsKGyFxC1pG7lv+oaEBT6TJSVs/pm71ZrOezQANRzvBeXNUixWienTdAEG8a
 x4uOf3EF5WvYUhDiY8XBJyRv2ZnKJmBxZ3jPStadSuh3Bmo4mNgRVpFXrfb7h8oJC1l1WGdJa9aWi
 xUedku0/nH+nZMTqrtWYkXoLxaMswVM5S4f3pYKd7VlHxtlZiQ95RqQd5uWYcEN6xaSvAO3Cs4Co8
 D6etTHtKPcx1+d0x6BvkBvqNJ5yCiuzPPnKE6E0ss52KKvQt3injPyfe8ffofbW4s2nlEL1s0DoBv
 JslCebuQ6+Orb/Sl6zictIsv3XMq3jGFeZcDg2hXzngOC255+b0Z/To7jINTxYQot8jCOJQOLplxc
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 16:28 +0800, Lei Qiu wrote:
> The conversions to the new mount API declare uid and gid as
> fsparam_u32
> but consume result.uid and result.gid. This bypasses make_kuid() and
> make_kgid() as well as the validity checks in the old parsers. As a
> result, both filesystems accept the invalid ID 4294967295, and IDs
> supplied through fsconfig() in a non-initial user namespace are
> treated
> as raw kernel IDs instead of being translated through that namespace.
>=20
> Use fsparam_uid and fsparam_gid so the shared parser translates the
> IDs
> and rejects invalid or unmapped values before storing the typed
> result.
>=20
> Verify both modules with W=3D1 builds and a before/after QEMU test
> covering
> fsconfig(), legacy mounts, and a filesystem context configured from a
> user namespace mapping ID 0 to ID 1000. The fix rejects invalid IDs
> with
> EINVAL and preserves the mapped ownership and valid mount options.
>=20
> OpenAI Codex assisted with identifying the issue, implementing the
> fix
> and reproducer, and running the validation.
>=20
> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
> Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount
> api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lei Qiu <750592120@qq.com>
> ---
> Changes since v1: realigned the new fsparam_uid/gid entries with the
> existing column style in both option tables (no functional change).
> ---
> =C2=A0build.log=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 35380
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0 4 +-
> =C2=A0fs/hfsplus/options.c |=C2=A0=C2=A0=C2=A0=C2=A0 4 +-
> =C2=A03 files changed, 35384 insertions(+), 4 deletions(-)
> =C2=A0create mode 100644 build.log
>=20
> diff --git a/build.log b/build.log
> new file mode 100644
> index 000000000..abd0bdf55
> --- /dev/null
> +++ b/build.log
> @@ -0,0 +1,35380 @@
> +=C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 arch/x86/include/generated/asm/cpufea=
turemasks.h
> +=C2=A0 DESCEND objtool
> +=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/x86/kernel/asm-offsets.s

<skipped>

Why build.log has been included in the patch?

Thanks,
Slava.

