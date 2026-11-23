Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417298;
	b=HLB94091R/nD1XDSIab8ZXkt6zXk7MjFpT4u+o9sUniZNODPzEtzxO4aoxMCFcZFN7iy
	 VTHIVHUgxWc2mYHvXHNT2ABRuwgnRVq1MJcA65FlUNzcftt/UTnIoatIFzF2TLXYpmNqQ
	 csbEJTIBMM1Vd7HEG0/BL+8pSJsNG2ICBCBo8v4LSbC/lnTKWF7rRp7fUZyKzqwNa8SNN
	 C+dgIpO2/wNqFnU7tLvF2XnLiCMIcMSfpQCfFmCF50GkUNZqqVZ9nGQRv2On/etIro4xd
	 ESWh/av4BVuFhgIOxo/rD2PofWnXvPBZMwqa6Dy6w3oAcQM4PZrwnAJvgxOv+5HXj4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417298;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PQaIU9jrGjv/IX920EaZ+vwMDt6FU3NtgK/Ci8DsQtE=;
	b=YGqDmwrhG5nfVU5o8gZg/X/ZiO2UZNeyRTmUi6x/dJh8izogyQdxHdq1kyfxjORjVXZs
	 LRWl01IZVtKh7XS02i1rrUQ6kMzBWmwClaymVUoz2+ZDaPBVCeieLnTe7wkSmPr5/ePIv
	 /MWf6+7C5HLVbjIVTuEfWQeVrwRpn2zkPA3SuOPEmLQauUmy8haICLVW4w3nhICic5oiV
	 cg+KglKmi7d/Brtlpm1Pj2TgckO8tGq2l5mBZGHqOjIzD2Bawt8Up5LJ/YQhpFh0/Xq1s
	 gJiN9+7BNSkrB3Jd6THvtJv7eo7cDGX61QW6MZs2rL310vnTp8JehxB4APTuIOwdsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=PZGvQW09;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Sc/41PEo";
	arc=none smtp.remote-ip=103.168.172.137
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58706606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58706606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=PZGvQW09;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Sc/41PEo
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 9E04F1380379
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:01:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 02:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795417296; x=1795424496; bh=PQaIU9jrGj
	v/IX920EaZ+vwMDt6FU3NtgK/Ci8DsQtE=; b=PZGvQW0962OyMG5BJwRrDEtmu9
	DxzJInKMx6H3ZTUoF3vb5HOh9hIvMIHbTKvgTX674ldd5vJHhF2oG9fAf52k7FDS
	3O2fA5bY4TsmpfRnthlqubgu2BbE5xwdtA346Euao9f8ChmUKq1f41aLhdFQ+wCG
	s4XxirvJ6fi4+ozKk9tD/S1nVBIogBNAND09ynrBhNuEB6llbh5IHhfpmLpct+ay
	ULyywCbgywV/CRE6wLxLptIChSIWFQlcq6eMd/nsv4d/ZR1prY+uGM94ndkR76fB
	gue0avqsxE+BR1dLNdeji1Ww8av6nfyzhPmIetMP1gMB7LBRZVU34b35XXfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795417296; x=1795424496; bh=PQaIU9jrGjv/IX920EaZ+vwMDt6FU3NtgK/
	Ci8DsQtE=; b=Sc/41PEoRKOWhtuAgJA3fFw2JJQWUOcWIWAKrXolQyRXiGkUvuh
	WccGRA4zqLkKbp83RobU5Ap1oMLk7HTIQhYGeOUR7Xm07v0fzaLd0cu/joOytQ/E
	kMr1kij/3feor6jjIltXNomRMg8BhYB+DDAfnVYy4y0OM1kgS9gI4Xo0c9UYg//v
	XBrVt+ib0i6J0gXHDmxvONBo6pDTSQ4xlfGOH/xdzHX2foOr5FSNLxAJX9XexMaO
	vaOutHhxqPagY9cYuVQUbK6FFsWnarIeQR6zR0f0leGDZ5FbywDWo3o5DsIBntau
	TWPLWn0xU9fZpZSDF51Q4JMAgGrhklt63lQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795417296; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:eioVrFnYGjKGH2/XIsjFXAg43R6Xou4VYx5mlMNJ6DrFvkC
	1kRtOBi2ftxVX1o1XyxrCeQrBHLU47bQ8XX37P0pQMoUOiWo8WflZdNVLJZRjZ4b
	FpA3BWJUFzTP6Zkag+lJj7D9K+5mv0vDRatj40v7hw5x4xED72cSmz7RDpo17VQY
	hVc5f1xEfdEr4WC7mxyrlURftBOl+1gqROILUX4ktB1zrz1z6xwQdpHcyk9cTag3
	umtPVTmj4D0C885xI0upWIbUWgYpigfFqDdMcyIqu6OdmrzDYkywBAY5yTqc2X+8
	KCTxGeQoRo7G92seL8E5dZrCtobKGhK6iB6O/hQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VAdcf7p/xf9lxpcqIoRZEf2GByXwU0QzE50CpNp2b3o=:KP8em782QFBhNPcrfc4hjVjWWapiSXNBTFzw3UUOr9c=;
X-ME-Sender: <xms:z-QDa0z_PHMAW-heXRGqUy2KGJ1y2Imkn6RRuWfmo8bq5EjnwRpBPw>
    <xme:z-QDa4cXvN0O0Rg2ObS5CW25jCKyexGaDeXGIpXV4DkpFUPZzoHETLYcDQ-T2ftkA
    AGeAsMNsih9QEEEOV_34-WbkBGLDnnCMncnH_JnuEPCCSrdrc0>
X-ME-Received: <xmr:z-QDa4-zkHx7Evo-YD2Z0gUazpnTPmlc4N_1yqRdZeqysauTw0pqybVOjfFuv8LeVzSLXpcWw-dZkHE8zETsb7gFtv4MJe5Mefv9UOEh8Uw>
X-ME-Proxy-Cause: dmFkZTFyV2tzmNnMG6GVBnClF3a5MYEONstRqY1OpQbaDJwJqBfAWH//7vc37ygX/vlCeR
    aMDvp4KuBt/yGakYvtjFbCPhvferKFkBz2KEKfRa9mw335MuvaNEliE3r+H9UOHwi0fCT5
    Iid9UUTXzJNvTw3SFuLP8qFdvif5sEvxb50PKBkU9sqwVCegl2jj8LLSORfmBpC6+xOI2y
    +5fvP5RqM1OffM14pPDyADlYjVrW++Jay9M6fHOYD6aa5C82lpJ4okll5eX83J0MjgGVNs
    2DC69Xz1O72y8L+b8KA7YrG4xRJANCqBqkk/mzZmEFMpgtcryaKJMVTs6neV35rB70lYCK
    EB0Usa8u9qnybAreq0+5RWnGq/isjiXmBOJCli6iBZTIdiYVANM6dC64lEPGav9988wmsZ
    IDRR5o7xGg7LBp4munwoRu71Ie7uqGnQytHkJdcRWxZ+QIX0HBUfrFrDGpv4jmTzLFMCMf
    +uQ9dvVGjDyT2JMUzBMmxFaeDRcpi19y6O6an1GgOvR9/hEA3VoTR1+piCEqCJLZbr1r0d
    Cp2V4Fd8xSYRC97CMEXcz3Lpp3bA9GtDCpaQbztP7im2m7Bz3ITns7DAbVBQ5tpzfjOSa1
    HnLfQnpwPUXmNM0DLwmsI1dS289VnP3gy8/9V4ibav/SlLUuXup2X7bSt7UA
X-ME-Proxy: <xmx:z-QDa-HkQuveQbNZhAt2uXLqoK8x7OE21fLMZ81Cv_z2lTZeSKt0Dw>
    <xmx:z-QDa6COazf6ibVpdhfCQCD3j6iRpKlf-q6vziLcr56TD9ZnGA5tyQ>
    <xmx:z-QDa8L8ORgVroRLQzv-WgpCwh3KiBBixwllPrhcZhVSAQ4FNV4WAQ>
    <xmx:z-QDa4w2O-WvaOoPFaBoaUFX5j3dXyv3FkmUgD_I-azye3sVz_SdjQ>
    <xmx:0OQDawV5JUDOdAoWXTCYKTbUk033HLb4cAH78l6C0kVWheUieZZ_kNBk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 02:01:34 -0500 (EST)
Date: Mon, 23 Nov 2026 08:01:33 +0100
From: Greg KH <greg@kroah.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	ihor.solodrai@linux.dev, daniel@iogearbox.net, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alan Maguire <almagui@kernel.org>
Subject: Re: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer
 libbpf
Message-ID: <2026112357-corncob-exclude-7266@gregkh>
References: <20261116233301.1531563-1-asmadeus@codewreck.org>
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
In-Reply-To: <20261116233301.1531563-1-asmadeus@codewreck.org>

On Tue, Nov 17, 2026 at 08:33:01AM +0900, Dominique Martinet wrote:
> commit 087f3964f4b3 ("libbpf: Support layout section handling in BTF")
> added extra data to the BTF header.
> 
> This extra data is ignored in the native case, but when building with
> different endianness the bswap code in old libbpf would check for strict
> size equality, leading to build failures such as this when BTF data is
> generated with a newer version of libbpf (through pahole)
>     BTFIDS  vmlinux.unstripped
>   libbpf: Can't load BTF with non-native endianness due to unsupported header length 32
>   FAILED: load BTF from vmlinux.unstripped: Operation not supported
>   make[2]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> 
> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, so take the header 
> length comparison fix from it instead.

Why not always just use the libbpf version from newer kernels?

And why not backport the full series, one-off are almost always more
work over time.

thanks,

greg k-h
