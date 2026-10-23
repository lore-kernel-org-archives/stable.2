Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791280;
	b=WxkzrZ80Xj3dNPQ8sC8L9/xqzj6FkRXC2FzX6CYRREhu4MC3PuckrxgPx3YQ+s9G2dN1
	 yT0iqTiTXO0OOZ+r3F8S4P1rM28eXxUxGRI9cRJBxDnP08rnTWu8JH746X+urUgjrQpQH
	 lh7d1NEdMkP63ZIOyb18iBMgHW9LUN4akNDxRN18tnye3pbw26eYt8bzdH0XF+F7iHT/N
	 /SZa0o7pKWjIBJxWZ+yom0ZF1uPT73tBYNPA0dAnK/1Tu1kuEXQMv2SzlTL0Fzrl5YYkG
	 /xjDDqQjq4Hh0o0tX/ou2gQ3lMJ0+m/Q7SfctvjFoTK8qWJtIohczIfF8r43/1OjOAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eesM4V7nSI+jbVwdqW3OP3XkNj+CjBTD1XOjhY7hHuM=;
	b=me9RsKkudO0FayGrger0GjSpYFx4d4VduWVRbESKI5LdfnEmYUDD+ochMR7BkS8dYEj9
	 MSaivzYSTYwCkxeP8cFnmGLWAZl3F3A6onMvgksBxsW8AgF6yvJfg7rdsx5z3G3uSRIlZ
	 8/nF9B2bwKHNmi3RVkQ/GQvYdw6IWiOjcH3K13hB0KlZnCNXPaF1m/Hyp69O0Op4POwdX
	 qogNDfCAWA/YElrpYv55JEIrQY69NK40T6ZlN2mtJOwoRXUi4AmlSASCVsf+mLy6t34ow
	 Sq3Gf3KkYVP+KEuQW/BH4vReO73IvIngrZBjKK330cVasQHfdPiYDmza5D+mJCoH6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rScLXPxM;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D0606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 21:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rScLXPxM
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso858145e9.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792791278; x=1793396078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eesM4V7nSI+jbVwdqW3OP3XkNj+CjBTD1XOjhY7hHuM=;
        b=rScLXPxM2L9viz/qPsXuEN08sKN0SYqLWaw5Z24q+qeAaeF3CAsds0ywZ5AxKuo6yf
         x36AVCr0DUivP7cvbyALZ8rsrSeVhRY8Yf3Br4nLSF1PMVycG01m0YuUkcKy8c5EbCyD
         CjQwI2wpkhrVDJC3XeAhtclhdQsqlAqgRDfIvLPhPb92k9X9paeageS8dh3y1cos82CZ
         Af3J8VoLDi07zhfFffVGM7wFy8N+PVTcJopUb+OnMxCCZUun9prxFiKu69+SxTJeoI9P
         Ur8bJHaFoYY81M3s+kSooXzvAMisf9qb9iWeLfX3qLOIANWvYkLhyPXjQG1tVHJd7iqn
         87kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791278; x=1793396078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eesM4V7nSI+jbVwdqW3OP3XkNj+CjBTD1XOjhY7hHuM=;
        b=O7eFERGF0xF/hnLtM6/32ZaePj+jvzNLRZUkJO3TNTxh3JdLQJakuALc3LonSNouqi
         MNHU5ZPFUm9YxQyKcKGpTl1+TTMPQISoNEGfF/liURXfZoaEdMXRfo64madBxEAm33Ry
         iNP3pSSxqa+KHR2QOCC4u5foKYA5NRW2QCBTLHTNVR2pp/op3BDpGPmyX3Ui+jP0jzce
         CGKlc/4M0RkhF30CKw2e0TH4W4WqH9ghdd/Uu/++1GnGwz7OCYMtkzSLr9GZeIVr+IxK
         frMRYLLhtUOmURrcmV/rCeTlohnkeNFjVyTJfqq6/4IbRPAbVUzCllove1dQw/Yf17it
         tbgg==
X-Forwarded-Encrypted: i=1; AKwUvBzfC8YvB5Ucc9VcMSyX55ZIwQg15edvguEHSFAHSPPhiYg4Apk8zmOfzhvS8bHDiPd0jS6M+10=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWMOgJrEBhTWK8MglSfjm7iBxyf+BURAzYBOI1bi1HSykJOewH
	cPMwbxzL8d0NhuQ7oGDZ1miC/POcGuo4mgPynM6CxikTi20a6cUQzsGy
X-Gm-Gg: AYBFou086BAWzxKu9kQkokwdJYuuv3+/uaS1Rk8u+EDLKy1q4do44JaQ0y92CcbwNxz
	tFzrIsBxQJsZYH8KkZtp7pn27jR869QUoZlqiKaKtPvZF1eELWxXaI2yhTQiYMoft2LuC0RHbOL
	TcY75DC1riI+DjZd3vbpo7QIBF90Dn3UVBR3Kxb6CLprPEq5A9fgIZC9aFhX4MkdvpxBUCigpbZ
	tBWDFcqF7zA+q6QwmP1fk1mnJdyzbEebbaTCfBYGnrmCXAyTmneXmwYbpu/kAafsLyvkb7QRyYC
	f+qDzfJq3QRZb/hnhwAgWpAi+U8i0eIzGjxUWFLuRa50QExG/lxNPnh9CRX1pWSfYIVCkhG6xpA
	zLna4KehKSsiD+YC7U/NFapI5qpbR45HLwsZGE2CtfxRfKEZlDVEI3gwgiJw+pwMB17tlaet5Tx
	Pcl8ZXBtP8khRZEQNCQhzvkAoKJqlYuiWDlJA2ApAcfEgX0aSwh03vTaIpPU1FGGZfpYkUUs+h1
	2iU+p1euW26otEu6BvmDrYHyGmE1w60HzbAzSDia1Aq3mKz6fqbeZLiELZHIqcM7vhu7RirMarQ
	f168YYYzDteClYw=
X-Received: by 2002:a05:600c:4e45:b0:4a2:d82:11bb with SMTP id 5b1f17b1804b1-4a35acbf5e7mr1981825e9.30.1792791278019;
        Fri, 23 Oct 2026 14:34:38 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm34604505e9.1.2026.10.23.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:34:37 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 70FC1DC0579; Fri, 23 Oct 2026 23:34:35 +0200 (CEST)
Date: Fri, 23 Oct 2026 23:34:35 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Pavel Machek <pavel@nabladev.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.2 000/242] 7.2.13-rc1 review
Message-ID: <atvS68GhCvmAphrQ@eldamar.lan>
References: <20261023163713.816071858@linuxfoundation.org>
 <atvHKoRHHjKV4l8A@duo.ucw.cz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atvHKoRHHjKV4l8A@duo.ucw.cz>

Hi,

On Fri, Oct 23, 2026 at 10:44:26PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 7.2.13 release.
> > There are 242 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Either something went very wrong with our testing, or this fails on
> all our targets. 6.18.59-rc1 does not seem to have those widespread
> failures.
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2982452623
> 
> Example failure is:
> 
> I'll look some more to try to figure out what is going on there.
> 
> Best regards,
> 
> 								Pavel
> 
> 
> [    1.238864] Yama: becoming mindful.
> L426[    1.238864] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> L427[    1.238864] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> L428[    1.238864] VFS: Finished mounting rootfs on nullfs
> L431[    1.238864] BUG: kernel NULL pointer dereference, address: 000000000000002c
> L436[    1.238864] #PF: supervisor write access in kernel mode
> L437[    1.238864] #PF: error_code(0x0002) - not-present page
> L438[    1.238864] PGD 0 P4D 0 
> L441[    1.238864] Oops: Oops: 0002 [#1] SMP PTI
> L446[    1.238864] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S                  7.2.13-rc1+ #1 PREEMPT(lazy) 
> L447[    1.238864] Tainted: [S]=CPU_OUT_OF_SPEC
> L448[    1.238864] Hardware name: SIEMENS AG SIMATIC IPC227E/A5E42630598, BIOS V20.01.11 03/15/2018
> L449[    1.238864] RIP: 0010:rest_init+0x33/0xd0
> L450[    1.238864] Code: 34 ff ba 00 02 00 00 31 f6 48 c7 c7 70 a2 e6 b2 e8 52 d3 28 ff 89 c3 e8 bb 2d 34 ff 89 df 48 c7 c6 80 db 85 b3 e8 9d d7 2b ff <81> 48 2c 00 00 00 04 65 8b 15 63 6e 45 01 48 89 c7 89 d0 c1 ea 06
> L451[    1.238864] RSP: 0000:ffffffffb3803ee0 EFLAGS: 00010246
> L452[    1.238864] RAX: 0000000000000000 RBX: 00000000ffffffea RCX: 0000000000000000
> L453[    1.238864] RDX: 0000000000000000 RSI: ffffffffffffffea RDI: ffffffffffffffea
> L454[    1.238864] RBP: ffff8cf23ffed080 R08: ffffffffb385db88 R09: ffffffffb385db80
> L455[    1.238864] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8cf23ffed0ab
> L456[    1.238864] R13: 0000000000000000 R14: ffffffffb380c040 R15: 00000000b43e8000
> L457[    1.238864] FS:  0000000000000000(0000) GS:ffff8cf287953000(0000) knlGS:0000000000000000
> L458[    1.238864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> L459[    1.238864] CR2: 000000000000002c CR3: 000000000d630000 CR4: 00000000001006f0
> L460[    1.238864] Call Trace:
> L461[    1.238864]  <TASK>
> L462[    1.238864]  start_kernel+0x7a2/0x7b0
> L463[    1.238864]  x86_64_start_reservations+0x24/0x30
> L464[    1.238864]  x86_64_start_kernel+0xcd/0xd0
> L465[    1.238864]  common_startup_64+0x13e/0x158
> L466[    1.238864]  </TASK>
> L467[    1.238864] Modules linked in:
> L468[    1.238864] CR2: 000000000000002c
> L469[    1.238864] ---[ end trace 0000000000000000 ]---
> L470[    1.238864] RIP: 0010:rest_init+0x33/0xd0

Same here indepently, but not yet bisected.

Regards,
Salvatore
