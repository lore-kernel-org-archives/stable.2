Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824793;
	b=0xRTceYhg1UGAK21wV5O3e4Yi/0J2EazbI+HJ6VH1AVaeDG9+Lcp+9MV9ey8ifuoZnCU
	 hjSvpAgWvW/y6TLcLHOOb0Ywqk25rR2xJkwIs+fWfxDviX4e9ys6zeTQlaopw7hR/5nyb
	 kCToj01pviiJc4wui3mJnFCHzsW6R/E4Fwc5c9levyZE1VzNseDKuhP+AbGuZ6gfORr/j
	 JQkvswmdK7KGnbkMjXjAtPViHE4LsM9ezgLzI9t4I6hB4b0u3HUdwiOQmMk8phzNDDK5F
	 0gPSVnr6kcgiLwSZD0EupaqeFctTiils1QQkHET2TeW9/kg/IotyHCWGVSLmEvbXH/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824793;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=DYJysCRkozuyf0vA/fbADpVJ5+e0RHgQ8rZ/k4d59lU=;
	b=gZRos2QC5hewrxSVeWKgmat+ixCFRk+1mpKOFfM963mdK0KCyWqz7MDajL133dOA+Wh7
	 y05PngTRI2T18Itc+ENRHsqQeyI55P7JikkNtK4AeZgSTLA6jKdF/xnLb4ScwBw5gqkOQ
	 R+iJ4U8KFDk2LhutQiDzJlp7mGtOlu8cBiM35M7ovyj1ZB0QLVA4bHhptyUyO57emuUYE
	 8NZe7i+x6qTiPwCUAG6CWqAy4tOO32VbeD7aDEwSEtMaigg7Nf/R5FbeydipLYLvHde4F
	 YEKz7zdR/MdG1iWbaKEm8tXjyG5SpDSf9TQL+yQQkszM7teWT9oHc5pvr2vFAANRQ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b="iIG/mmWD";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Gyz2cnf5;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A6606AC12
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64A6606AC12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=iIG/mmWD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Gyz2cnf5
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E3BD8EC0223
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:39:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 15:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793824790;
	 x=1793911190; bh=DYJysCRkozuyf0vA/fbADpVJ5+e0RHgQ8rZ/k4d59lU=; b=
	iIG/mmWDJnRj60kJj+bLIorOcNzlr7je8mlHt2StNoue+sgP+fciGiXpOu4SU+fh
	2CPpNmSKSWNy3hL4Xn9IvFSmQDzB72U+8G2/LjVZnzZakqXGsF9Hj+UMmv67+EqX
	V2mH+IXf0vpJjzweMerCeqLwi6FKYZ7TcdluDkXRTtiMHM17JGFkhiaxIEpNRREi
	2tgKeEY3k/6QlP0Zil2NTsMF7hZapvwEvb5+e55bhWHANi36mhtPm2wdRIa51znt
	4DZRoXUAX0Z5ZBYJZUIN2gB6ejaQBcP97NrmsdrOq7TN1CtUm6cxDhg5MnhPJLVS
	y9gs5Ci95aTn3clOoGD0WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793824790; x=
	1793911190; bh=DYJysCRkozuyf0vA/fbADpVJ5+e0RHgQ8rZ/k4d59lU=; b=G
	yz2cnf5fb7ft7lu3qFOkLGYZv+QzySH2w+3+DUPyXkOHDCx+wGUXxBI5bFT3IpX5
	gXvC+nYvzLk7bwmTxPcD73VnSTAETI2ri7De18ig9J0EHp2cYpe3gjaiXHAPApQ1
	MYVrMo4JWJyG23Dl6NWud9TxrAfE7aWt0hze8FniIKOY3a1g4pqF/0sYBrSNXJyO
	RBly1kOhcHpx2vtwvaiEo01hOj5GI5EXZ3eNMyQcccCNJYFXXCB94nbpx9DPGpWD
	og4WmcAP/lgp1BRTmOpNF5JQKNhby537xVBXYCuZ+ZpRKU+nu9RAXLOA1vUDH3je
	KTLL5gVC7o2wJtnY4LKUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793824790; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Co99N5E/U4hjy6merUgU0nonXGrg7/eO2W2NydQmmTiIG1+
	o0pkAakCH0IQEyZe4qB9qDM8rj9MhRxI8SDH0CKDRKQls4MNr0/OrztP+78d/a7b
	HH+NWsuCBmnah6XLrTzLJ0U1bkcoxSS3T+VYX8lEPrDBe1HmWvF77TsMuY6LvpeZ
	ryd9JDEWAgtzknsI0Dyd9DoVpmc6JxZOEQc6yA8JBJaqirHiQEBrcb+XNG1KSWu3
	8eT4aKv+U/Wd2Lv0Whqca4gxMkCUPQKXn3WTuorLry55cgw08U35DE73CCYTvfdp
	GpeIbqvIrQLoUUGzVxw8GjX/9xMuxfnzXw64Hpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tP2nrZIwnn+0LwVOb8PHfjnXh5z7R3SmxG7aBq//CJA=:lhFIDgdLRmkRcInSJZF5JEKOz6K0+wYJEJPb5IKPwsw=;
X-ME-Sender: <xms:FpjramnBFnuHz33GXwHZFarq3kKMaUugAjP9uV1QO5cZ47d5zSOStA>
    <xme:FpjranTlgeIeyiTghGF4vchZjdEBcQnatGcvrYmQZqW8pZuXEkcNnW5zBKNYlxFiA
    kM2vwG16mjdBL8GDnSjSj0_vwtglDiMCafek-V5vZ4IlimK>
X-ME-Received: <xmr:FpjrakM4-5IKecpAbJITEnh0vSVkvFXDiU1WI6myCqj-Cn0lSG55ZkLV19OA4Q>
X-ME-Proxy-Cause: dmFkZTFX2KFmyvDni0LYRtkPnk+6E9rF0DQcrIUFdh3lyBn/7Z3FjLRzLVxLJEg1Zb5wHQ
    9RPSkMaPbKFODN10hemWHb9yleVdGEgDyJVqrG1OLXES4QtTAPI932q/FJFRjWIEeZS/tP
    pB/xTH1tqX+yXw1ar8I5ZgImEFFWmgydskeccExqRtKjz4U0D+f1mXU3MTKM1HAqZ2aW5b
    CiO8BSmZnK+smtW7zbIp0umO+4JgRxpPZnPK9qHdqSzhXeLWbc+T9k6NSZhDpjhcnTJoS0
    klgDLPZxyMI+XLu4b1gjgXZCV+yjvXUuOswhlvpQ+GsKNI6O2XfC3R1S28CuM7PCsldvZ6
    SrVY6hHGkDRCcOZPSQZ/xfE2Subpnec/qsRcqwNQMqB3/JazHiPjLrohRg+L8w+W+9/21v
    wBoj43sMqBrQM6qu5AN8u99llojYL/INh56mMGvlxiVuJiH+i5E+Y96Oz43HMgLfI0+xFW
    4Y+4AWBDaUX99gvWCAYQ7PNbUSo9QjcgMu6+cBly9TYr+6LvLOVlM2+w18ieFMrImI4bsB
    Zad5B8F+aKmilW9SCbnGx1Ehv4Zdn/n6ihNcIKtQRnjIyGDltF2T6aiyWkZgyCkVJ4Yvda
    ZNVHiAOlw1ZgOmJqbDwVkEGMtpy2kRx6sIPutzuNRvAspVDhz/2tFONdlEFQ
X-ME-Proxy: <xmx:FpjragU6MsldneV9z0p1p7cniL7IK1GLXDwnd8InpPdMhSscz7PfmA>
    <xmx:FpjrarcYTLgBSD5r4NceW0jTt8Be8LM7o7X2LHus5t6eMxCw4eaWOA>
    <xmx:FpjrasuCYfSQW_JubbwPEmXi-Z_yQ8yngljGOMAeHWjQFMhZUSUO_g>
    <xmx:Fpjraq88zMupoktzyLEm8Kx2tpmWJvzihbSpjLuFvFWDSTMwLyNzNA>
    <xmx:FpjrarW4I1ywlT5ubqnx2IDc_oTwiHAd_bCzZ4l_HT2PG8kPeaJp-Zhf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 15:39:50 -0500 (EST)
Date: Wed, 4 Nov 2026 15:39:37 -0500
From: Greg KH <greg@kroah.com>
To: "Gong, Richard" <richard.gong@amd.com>
Cc: stable@vger.kernel.org
Subject: Re: Add commit "63e91c199789 accel/amdxdna: Add support for AIE2
 revision 9" to kernel 7.3.y
Message-ID: <2026110432-discount-coral-3596@gregkh>
References: <a5659c47-3967-4a78-b0b8-2e31f188f773@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5659c47-3967-4a78-b0b8-2e31f188f773@amd.com>

On Wed, Nov 04, 2026 at 12:27:24PM -0600, Gong, Richard wrote:
> Hi,
> 
> The following commit addresses an issue where the amdxdna driver fails to
> recognize AIE2 revision 9 hardware on AMD processor from family 1Ah Models
> 70h.
> 
>     63e91c199789 accel/amdxdna: Add support for AIE2 revision 9
> 
> Please add this commit to stable kernel 7.3.y. Thanks!$a

Now applied, thanks.

greg k-h
