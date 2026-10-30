Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366615;
	b=B1WpnnK7u32JlIn1Em9JImAeTk1DuoCgBoY4GnofLF3yeBXMeS8BX8HMIOj1XolO1zBr
	 3TMiF4KX6G7X4JyYJTwosyYK+MU3+NpOFnZPHKSB3XeqdAZFa9n/apMzGXdsyjh2U3VkU
	 WhEsW+dxzukWpZ/fmmp6dtqsow0+LJSyKf9Z4HcwdHEECyILAZhGph4qSYrHxxvAOgJ38
	 eU0yIsl+auxTme20qXmcIApZrZJDGXk4Sk/ljjBxL+WgM7lNfLbsOxVUfAN/FopFiQ7wI
	 y6T6CN19hHxNwkkTDSSw/rpxjiTchN3Lq7Zo30mgjzv6hPY84UhjX3snsEBgZRnUOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366615;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3iFFSDMFcLLNzrnpdKibwgYyXoRd2Mab2qyNz87t56A=;
	b=1xEktB0IsLbVlQb8GfrteEnC/zVqYmyArjfIxAP5sB/2qgHu6sM/Z7HlYX7HcrI1E/50
	 F9pCQtPc3CqSAg4aFAoz+VWbzirLL0E6g9rWcSamoZfQG1i9MuHTnSaXbcfaDiyTPl2WZ
	 SHmrk84HSKfKLDy+dvYJWSMdUTp3o+HwJQ9DWM7cyJulELIioMwwOxffl3vldkmJcl5yr
	 UyhOPv1gp/YJqn9Uw0TYyC0kLs9kRP8BhUz3VAw63hd++/S4v/xyCi8YJNmJt8rAD6mQ2
	 Y+NxLgzm7DGBKSNyRdMy4Xt4qXSowROl/dNzghXPd7J/ffn3aOEdCm9rFsacJpnXLag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=ipbDjU6v;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iaNV8m4q;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9A606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=ipbDjU6v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iaNV8m4q
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2727214001C4
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:23:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 09:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793366613;
	 x=1793453013; bh=3iFFSDMFcLLNzrnpdKibwgYyXoRd2Mab2qyNz87t56A=; b=
	ipbDjU6vMBgFlYgZ4nv//SqUjhran7lV5JaohmdCW6FccCrD2bHWiy5sza8RokiC
	zvSERorqVtqS/8FIOLvdOgt5W5j35J3YjvuWPKCIl9UhhKHcLLFXH29q9uaEhdo1
	T5KX99gHvFffmqt61ZRmjRIqlkbaAk3Em7mwHa/AgU/U4zFGpj9mBY/Kjupc4tRJ
	1VDybcv+NEe7K5yqczACaeP/j/eQa1VI/wL++0RhqiJbjR7WONpXSg6fRSHLjbdl
	7ohCltsFiy8jdQ4WbnBivawN2qg/0yb7F2I1PeKvQ4RuNLeAMyek8xjtzJAiHyo9
	7HsyAcWAbmGw34y5OXGmeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793366613; x=
	1793453013; bh=3iFFSDMFcLLNzrnpdKibwgYyXoRd2Mab2qyNz87t56A=; b=i
	aNV8m4qA5vBZ5Yx9Wh3y0kNE+d4UfeBKhaX7RloXs3dQ2dcN/bEjUvbdJ+mY9c7W
	/yruBJS/UsDp1n7vf7oYM7n4tRYw+fcCHkEnRhKJRzn4BBA/KQiA5m7Z7/zAx/S0
	03VAn50kXVyj4egAxlWUy1kbb7Ra65ch2bVOnQZ9FrRYhJ4E5Yw+qXCDHRf0H9PS
	jG75A8xVxvmH1Nph49Nr7+7wCRn5BV0EExXcETzC8J40u6hmtRT5j2RsIqhqpKGG
	XwT+sxDhY0nbVURADJksOIa+2EHUiDZ/zO/CPRZ15FnJ29E4EPG64g1Xo1jxFABY
	texKJn3rg4fnTULYIrObw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793366613; d=kroah.com;
	mf=PGdyaWZmaW5Aa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VsvxevTpIyyblzaaa7o6hBnLNZBU2YxO6hrszr4B92+gmbW
	XegoRqH5DgQrCxZMXeJlVtWHtoPZrg4Iao8ZY3CMkJHsnXg8JHnzVkQw6OhCiFca
	gcsZdmdVc+ylL+n+9Tw9iUFcVmB0lay/H5lKMa9U7NZCIbJUH+xR4b4gZSW4JWz4
	LWSfMVVL1HS0GrdYDuBmpomWAVzcYDmFH6uaIk7YC+d/87u+RapoU9kjQyRR7cr/
	nOspHHdWha8cFgOS1o2e/O+qH01XoJJUx5ux5C/V239XVvegFalF4gIBquGKG+ZV
	hJp7K1KdR5657DEre2hVrQcWCWKP9UWp+HLH7+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VERx+3TZYQ5BgoeARkcwD7V3+61VQjl81BzhkNXBJ0g=:npABc192swzfsTp0K+i29xh2HGvrl0+1pYiHUAsgToQ=;
X-ME-Sender: <xms:VJrkakuTr6yVHY5ssnXklm8njIajhSKtgEBiKmu11-P_RFMsBR1vOA>
    <xme:VJrkapnqOUNW8iaU7Z6gKpjJC-StUG1uJrK6PkdUAyM384OJVMJJy5mpnrqOCTGvw
    averxZafmF0xOWLEMAx72btJBl8WHWp4qrcJpFg91K71fmEQuxS>
X-ME-Received: <xmr:VJrkavRmE2Wb7WbJ70ykM8SM2LhUms6lwX8rK8-Ol3H-Pf5ypQ6GGOOk1b8-YC8oxBI>
X-ME-Proxy-Cause: dmFkZTGrQ9ERLFaBKIwVbIetyXJ03PlGFnJXk6lW5sR7vq77CBIZF/yfVrvnZOnJNsRs7v
    9SQVc4rRLF7fmXlkvn22Ia7us8+VCF1dxXt5+DVof+jPIQEfxnfHN/wwcOYkwnMDTbn4b5
    lYe5KPinDKTWjZhGXlemaqWJDZXhQ2q8BhYw7xXOXoiElSEg4zL2D2lCGbDjIAO2uMxKBf
    Gd9fXknASByuIm+1tpKBKJhS7zxJlLv5/45KZnDrpFFhXWBcJwsWnzz0N3Q54R/eQ/qWUH
    Is1Knh+BByUNF36x/bma5Jo5IkhItuucCBdgqFMNDj7/kL+SFTK0KOS1aNzDZeARTiIpg8
    ae13XMrF4MrNhMsQi/A+7E/angESrvPSvw2T2qM+Vs6W8tJFm1kdIisY4pagJaGek4R9Ts
    ftT6t97dN9/91SnN5QfpRb5N0wVW0V/oxmubNk8cnMAA1k8pSMT7nXizSrbwM3r5sx4wQp
    HnZAmfFlcCnajXs1XJBKV3VETWsLVGBApfMlrf9aYPfwLMpm2fkVfkMehQBjRLfyNnp22S
    prI2M14ZyR0L3vRHHLksWx5WFtJONo3EpSNy4XGvID9ij63twWNhtpq8Hiud7JiY1/my4D
    fiYQtkFluReKVi12LS+ueQTdt+qkSROFi8hfsSxRJU7sqUlfZux7ExqrnXTg
X-ME-Proxy: <xmx:VJrkanKMHEs_uyMgGiycU4FW2YVbEgr7RWCcopNzSy82Ku2ufkghJw>
    <xmx:VJrkahFaXnPbZtuRTU-xKAqcXbPZDMD_SdEHR4KQSjHbklfvTCZkuQ>
    <xmx:VJrkas0-MQ8m40wBS_Ths3vZQkb_VBFfx_mFr_9xiT0G5I6alW1DKw>
    <xmx:VJrkahL2SfrYQBVC1VUX3C1XlIcDBFQIXSXKexAsb1N5kiK2AYKnsw>
    <xmx:VZrkapL2DExd5SglAtqcQdKKd3RpNr_uvzCDpl5l6D1xZRUL8ovSj4wC>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 09:23:30 -0400 (EDT)
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
Subject: Re: [PATCH v6 4/5] leds: trigger: netdev: Report invalid interval
 to user space
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261027113349.383147-5-alexander.sverdlin@siemens.com>
References: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
 <20261027113349.383147-5-alexander.sverdlin@siemens.com>
Date: Fri, 30 Oct 2026 14:23:25 +0100
Message-Id: <179336660572.12256.13380616711233326853.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793366610; l=414;
 i=griffin@kroah.com; s=20260910; h=from:subject:message-id;
 bh=npABc192swzfsTp0K+i29xh2HGvrl0+1pYiHUAsgToQ=;
 b=RLvWDp1lFv4PcXCMdTdySgvaxoeYhcbnoa5npr8oLI0nT/hKL+5hX77+TBvizfCje3oEosEzN
 rY01YbO8vN2AeHZMHzgFSwWkNHS/0hbonRnASj1ivqGHBf9slkAxbTZ
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=HlyUkuZAN9I5qlPbOHN5N9xxdQ5sT6AbPgC4TsLCxzA=

On Tue, 27 Oct 2026 12:33:44 +0100, A. Sverdlin <alexander.sverdlin@siemens.com> wrote:
> interval_store() silently accepts out-of-range values: a write outside
> the [5, 10000] ms bounds returns the full count as if it succeeded, yet
> the interval is left unchanged.
> 
> Reject out-of-range values with -EINVAL instead.
> 
> 
> [...]

Reviewed-by: Griffin Kroah-Hartman <griffin@kroah.com>

-- 
 

