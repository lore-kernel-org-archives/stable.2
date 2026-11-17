Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920408;
	b=2EqRWybT4rhkzpqFJBgN73Rsfyu4lw9o6R8MuNluaf9BliBW5st2DjzMqZ+nojR8Dj7T
	 fB7lyISOkEbEYcknjqaGDnhpJjzQM3HS0B5kB8dBUkRnNpZDan19sRBbERryu0m8zNQOE
	 i9haT5LREOXIgEuGmiljMsNkU4N44/glO8OWKvN+DruHdUXbPlECy/RWWaCdzMlvc0Lsq
	 RELFH/fVVHBflaKggoNn+EwNODcKrPm6/VwtqTpG9MGppt+IEtDVmnX3GC5eUqvNSfK5a
	 pZ0ZSdsYoiVUzgyZiN4eeVtEGusjIJg38kAkCmpNgbnxbsojn6scjSQ6I54gOGlvMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920408;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FbeKDoV6eECqsQ8IE0/LumHaHBERp7BdCgLu1NobmM4=;
	b=sSA+MMC5TryDTjJ2EIhRodqrLiSHlO90UjbwSZFS5Bc+AG9OB1u0Ay/sceELcHyF5lqS
	 c9mCP84ER36pC+Jt8MSj+W30gJC3mXejINJKVD22Uiz5w9RZr5kP56WQFjjXe6sR6+DV7
	 Rb/FYOKJ9Nwo092UYZcs/c9I1I1+myf41IZpTxR2yY8UV6EyJaoVs5Gei/NCpQ4A3uuMn
	 dgs4XIql235O1OZuPKkWtVsBsQL4UDH39ajZ1nIeERWyk0pqlbL03SLmbd0CX81XJxZQ1
	 kOCNuVCpJNCaGX7tIcL0WpEJzuywgagK3oEZ4fGEeoN1VsQdl5IqKCXZKcZPe9KEfxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=nN6+6iUi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j94VP86c;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EA606A89E
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60EA606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=nN6+6iUi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j94VP86c
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 056AE1400179
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:00:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Nov 2026 08:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794920405;
	 x=1795006805; bh=FbeKDoV6eECqsQ8IE0/LumHaHBERp7BdCgLu1NobmM4=; b=
	nN6+6iUiE+ogweokvaOGrAyAGzEEv7BoTofq30Z55Vijuuprfs6vW2PPjOeI27xk
	Uz0XQXgZbM//9GLNVQjTKVlsHIBdfLTkXhICcVOlcklD7gbwk/grzYbdkPoiTLtm
	8NcKKIlQawwLA0uxgH6pJf0M/+JVfnlrFByBzfr0ts0vFSQn88hgjrUtbzVZpPLN
	Oeq8O0abwGHDNBud1YhqPonxAbY+pM3/pcKC6OJrldmgrbzCL6EWKMJgzVvX/Hpt
	soNICC4JsxzLryIE/J7Ckzm82TAv5FFfMpWMFUh/9RNs7sY4tKtTFdIcq1DKD2S3
	nIT02toX3yU0BehQAXakSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794920405; x=
	1795006805; bh=FbeKDoV6eECqsQ8IE0/LumHaHBERp7BdCgLu1NobmM4=; b=j
	94VP86cX65JexO2DozZg12tkq1E12KvbVjexHgHf7wQJTA87H66x0TwX6uzc4J0c
	uXWPjXEN3Qyi/pTaBvBBv7x7Tl8Ucax1VaEGIFBJQTLkPMMCiWfvYgw9793Ueid+
	KiYs2Xc0TIIrVDuq0aOwGyFljCk2FYPr4nv9+cwTDpmqKZ/VRLlujdUtSWEiEKhP
	ap/fwb5H5Z4vBE4LYo6/ZYPzWJL/CqQ4rwu1hh9SlL50qXUPWCaUQz5fSSR2L8WH
	N1/DO7bpewI/LMFdg8rO5R6O0jTR4zxKbSz0YBlbfNsuMhsI2gNZuHXbH3JugN6/
	6ETBVeX6Sv/Nggiu7I2dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794920405; d=kroah.com;
	mf=PGdyaWZmaW5Aa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mYzQ0AfKrO0ayQu4GlrGaMVdVTzMxwzEunVZJ/ZTdlmdGke
	uNINqBVa/epXVZ8MBvVm0K4PW8LcIiQZIlMSUVXBRhXBB6aXgyg8/U2z1oEQq4WE
	dtGTP4uo1BK/K2Yw3njp2yE9Kw9X4ccRnpkpLrtz2OFXaielGgdy4kLe7Di79kPt
	uusTlD2gtARYVWTrrz1TwHAD+NcsvZjmAJo2h5UGqzXpS62WGOXfdQKf+x64gUNj
	Vm8/cWAjSEIK5h8d2JFtR2FNYrKV2aNXnLqEQGLCztFVf6yvvqWGABOl71FGx80N
	ieqkRO6a6Xg5L6SwARxfMXARVHNUCsPoVda8lVg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2Tn/+viqbP/r9TIlveUGv/eeuLwzUmFr5XF69AYS8eE=:SPxUh1xo74WX2tiLckfcwEEBVierqLvFRyyZ1SNa3EA=;
X-ME-Sender: <xms:1U_8akMBe-YxJKSbPeTj2W3Bi-SOdAudEZQKWAaI3253kpHkGnceRQ>
    <xme:1U_8am-5_cmVrm3GuAaeoRIDKf6Gc3PTkZLAhZmAAo-8oC7IQEWzkYeSfrZbUTU2T
    lxrU1_tkL9iqi6fLshUmpVxc_RuWnBBczugfhsCOscITEljyw>
X-ME-Received: <xmr:1U_8atf-uKxRRrvxCU4KfhMIkldW7d_ndO8Dbg_Zvimn4hw5aKG11ahRVDZ1ff1IFFjhZQ>
X-ME-Proxy-Cause: dmFkZTEGn5++qhROk0bEMDp+IH+5NF+P5+lDp8zdZX6m/0VmS9lPSrquhyBjqJwI3wFnWW
    Ceywx01iEEPCLYI+Ua1mqUOFw1o80BrofAJqWJ0NOFEyl5GofxVxBiixlrpcdbuuD5Bxit
    alco4XY6FHzogbRzpu6ajNGv1q+Xy/+uLOEy2PukFTrUormzMZlR8Ykf2PQcmzBgHMg1Rf
    fxeWvVWompEpza9Njt6BF61CI5WwMZi7mLwO07BHyPHoZgwszaE/JGvtPF9W+0KfgBlgI8
    vZfGHR3tx0XOeiPZnXWsgKD4HUMbz4s94WesOxudPS48ly69176NKq3zZMp3r+FL06sjbB
    AVPf+4IzOLSvuQJMj2/sdUnrKxBbp3f80yZAsihnortXjZVuVu6xeBhDMygHm/QgIRwvXY
    4GPZCw5KdtdhErbWCuhk6qOG/uLIGwe5wX7nxCH7hkrAOW9XG1bOM5zUA3u81abH2Z+/XI
    MCXek7HNefA3On0vTKCq9/005qrEdYDiVFVZ69FbraxfF0kDnDRt96YnWEL4QQqSDXSgkl
    +nwoAnQiZras9utE67x6Ju6SWd5SSB3pzhy6aryTL6m1j2oj+T3SaYFEg0y8ko1dbyGjgR
    TczdJQZoXwz5Uv1Rs+BeEXbtmeU9MsTQfoGJQk1f1fGAmI1jshQLXig32Lbw
X-ME-Proxy: <xmx:1U_8atyLoVJ6EQBWu9c2VzgIiF8IJ4mn31pkRFNk5P5vSBjSjvgODg>
    <xmx:1U_8aqIJXpCuuYKpabW3B2LBM_d5IaJ2Rs9iOmNhn1XOqK8g9xLgZg>
    <xmx:1U_8anFbll-CR9oEYW2osHvrJwruowj3c73swtTIo9kqg_zbXsUl6A>
    <xmx:1U_8au-k2JQ7lkbQ-a2-Q3PX23ecINNmC06K4Nff8ZN6H-aQp5l2WA>
    <xmx:1U_8alLiB3DGizkGZD5gsWgRJD7X67iUXvet989nT_tddx6lllIPvwEP>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 08:00:02 -0500 (EST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] leds: as3668: Propagate chip ID read errors
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: Siqi Chen <chensiqi@uniontech.com>
Cc: Lukas Timmermann <linux@timmermann.space>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261117083917.3304865-1-chensiqi@uniontech.com>
References: <20261117083917.3304865-1-chensiqi@uniontech.com>
Date: Tue, 17 Nov 2026 13:59:50 +0100
Message-Id: <179492039009.10764.11872681480059926447.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794920402; l=194;
 i=griffin@kroah.com; s=20260910; h=from:subject:message-id;
 bh=SPxUh1xo74WX2tiLckfcwEEBVierqLvFRyyZ1SNa3EA=;
 b=PpUfYXhqnei7p/3VFe6ai3Sz+aAjeGzQvmqGn95mCUiErdRMrT+N22cJjLrazFYgTsuOMEl8b
 fvzHayo6eABB7AEUW6wYx0P8Z1ux4TUv7Wi6xgJcpSpiijLVVZ/EGGR
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=HlyUkuZAN9I5qlPbOHN5N9xxdQ5sT6AbPgC4TsLCxzA=

On Tue, 17 Nov 2026 16:39:17 +0800, Siqi Chen <chensiqi@uniontech.com> wrote:
> leds: as3668: Propagate chip ID read errors

Reviewed-by: Griffin Kroah-Hartman <griffin@kroah.com>

-- 
 

