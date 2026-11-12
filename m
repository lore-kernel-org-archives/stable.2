Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506700;
	b=clcq43gHMjXQund7HzDS59loGccVYdE4zE7ntISvTMiS7zpTDTanLCS68s63PXJFn5q8
	 1aKlLr2LY8Yv9m7j8n90Na9bgENjtnBBGil02vF8af+wpAPZpRPmZJmwtyy+D4tbW0wkW
	 ynCw4D6akaDmeeh8I2Kwkt35lfG6b4NeF0jr75P2rKsh5N3B7uakpvZbHXRJhVuuQMGs1
	 G8qEzFJA+oeKjGyMgivUY0Bvtlr2kwR+2rPiY5ULi+YySUfFo/BnJvS+nCFw0xC7WIONs
	 0RlJBMKjID6C+IB3JBqPJwRW5LE6qgPnSoy4y6DLx2vTT8fQ4+exaDtuqfX+vIGWi0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bIWDkbxjpmm/7xTStOsWJq0pgwFL0TwKQBYsQzickiM=;
	b=PS7dpWQCHPViW6q3ocFkrmpZzHYb7+U7mjcIMmFmXkI2pbv88sZXa76SWIw52rdU4Pli
	 lYFmGniwOPEjAIrd+cfqRsTvvD75LWLvV78f1BpUMv//aOjLQXgYK3uQZaWqz/7at5oYt
	 pJ2hrr2ImPOmRFtdbgKW8h7lA00smLG7gmqlkhVXzCTY0a7FvSOSkIm4rkbds3G1HUG4e
	 VnP9rOAiVklN8IQMgpYOuNL5+o73L1fVlL7Lo/a7j6VnwwOt1AzAxlwmA2sBlm3UTMCTg
	 PuoRX8/cdULlUI2wMpPJaPZp3xfYjPIu5ReSs7AGgk1Wzrh27JiseaB/xSiA12mAEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=invisiblethingslab.com;
	spf=pass smtp.mailfrom=invisiblethingslab.com;
	dkim=pass header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm3 header.b=HLVF6vjg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DKrQxPcq;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DFD606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30DFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm3 header.b=HLVF6vjg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DKrQxPcq
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2355E7A01D4
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:04:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 12 Nov 2026 13:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1794506698; x=1794593098; bh=bIWDkbxjpmm/7xTStOsWJ
	q0pgwFL0TwKQBYsQzickiM=; b=HLVF6vjg+hSkplB1uifLSRDVNfzWWu9MY+H8n
	hasLjBs4AeEXwYudu6Ac0dM4TjGfUqTnfIIXG+C4jw/PWgyHwLWs1dk40Z0GkExl
	i8nnhXtfrgxJFhvxzGXDQ55xtjCZkVgX/DMOBAvi09jNspk67iWZ3Ms1zN+SWqeq
	cZKFuC3qYtmVx5ZI4ogzlAWEPuwpFO9Zub4tLdUEPnMN6WiNG/pJJZmgismqDPQJ
	bdREuOuS0mYnKsh1IOfz/zYdRWabBhvt1O1Znh6zPszA+5i7sG1ya/zc9F76ZXNF
	tuOMoTEYis975ub2xFgG+AMnQt4l/TXYZiVGQ02825WWZsBdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794506698; x=1794593098; bh=b
	IWDkbxjpmm/7xTStOsWJq0pgwFL0TwKQBYsQzickiM=; b=DKrQxPcqtnwO1xwwg
	tHK7yUrPBHWGK6s+NtQ95M5BGOpdFHSSRSpwKX75WurWWLCvhY+4xDcH/IhbOt3k
	Yt3Bu0DB6WReQqGqj53DcDK3SXsxVFubGHRV/NV4+eJrW6wWpDG4EOQSl8dX+aKk
	eXd7/IcmKLpFmLwSarQloycy2TFfxKVONJFp9wsVwFT9sw74RCy49zrt7nb86ZNV
	RBjN4tuTgLCMlYA5aDQH2k4xJcIyUrnJa4opC3U40bG32nSmFv9XRsjZfFQDS8vR
	ZlVBEO4N1f9x6Qpv6WmWPHCNByOm2h6Gl+iKq89yYgLB6xbdS8xGUVCsaV2Ms4k4
	HAUYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794506698; d=invisiblethingslab.com;
	mf=PGFjY2VrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fEtXzVSIhmVqdDw+XXpoBTq5V+KxC/OG0Zg0YRSwlwnLIi/
	zr3yvi/eKVFB1MYAggFKmTJGvxBOXz+08YDUZabJAAdPlceMD1tOJS98j1cLOpLX
	Bu6RJqcvBQxoDQpqow00b9LoAmII6PMfvOafubndLizzsE7Dh2G2XrCby1rfK7mq
	/K/Dj8KvAqkRG3lcy/MEpZowY3UQRElc2n1TT6tlZQNpNJ4VQa148zQHARrfZ55D
	Uz4qbKa7EwVslSW0xZej+4sQdc/nKu4NDkMFs4BmtiVRFcSbj7iGp8Wgga3r7ntI
	EtTxUClHwYS2zPuZrv873Q0GLDzXIgYN/7YQLTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IvOIwpEJoX1NujdpENhEmYt+bC9JBzJHM3aLQmrVtjg=:bIWDkbxjpmm/7xTStOsWJq0pgwFL0TwKQBYsQzickiM=;
X-ME-Sender: <xms:yf_1akSf3HbeEWYbkNf3Jdei6uSY3kfrUHtoMs6_B05MifF5on6XgQ>
    <xme:yf_1arFXpIHOJ3M-xOTqAZfcv6GRzGcgLWns-nJytmWuKQD3V3DiV_vS54Xt6qo8F
    p933xtJy0J4Jmp74atvh0gvGW7tbqvdoyn43mG_3l4Mf7SsR3vt>
X-ME-Received: <xmr:yf_1apErZJW0RX7PL1VX0pGQc5V_5l-5fMbfb5UMwBJNIYs4S41Z4xpP5Ja4Gb-HQJsbW22nliBBJw>
X-ME-Proxy-Cause: dmFkZTE70pgyBIH+aLE1nO4vfhAc2Fh45MC0V7eAwpRWq+pL1EzXbOZx7VJlFp2RmxRleN
    WOKex6pnVtDR0Fzbgw8iNzr0KlKr8fzcZht7wtWZFmBtm2sAWnWumZIG9h/oO1r4CJOneG
    WyUxwRjwPOsCXpEO/I7BdPwgbHNk/YQIhDv1b5HEtWuqmeusfLxC5bEWIbH6PTyLHRMqId
    RaIy4bpuPQQ/FnGjJQLddFwy4PNUN3sjavomqClkyAYvFwbFLsRtXnibb3pSm+mX4a6ZFl
    OXqf5DOi/4gvvSggMVo32Sf5/sEo2z4luO2Lg9cGTbibn55JONSVs1AYjTUijug8Qwgdrf
    T03INJxvbJyHu0vwlvg6XSy6MMNgluCUnew21+cyxEdpo998WdMTq8toVCOHxX8CLVmA4T
    yNdMBbycQUipar4NpzeiTVBFwizDKrTRliurCLbTAiLK85Hzux6UehrTZx6u8Qb6cNzfGs
    z9D92FOzitS3lGl1kNwrGpmv3q85s/wjeFLQ4ToOejrXmLGtbNnADdTxKUed5A/vxy3PMB
    lNFMKnVx/FmKs9sIE4e0q9DTo+J2NVj00PZS3Z2BDgeaL4avBLhx8Pk2e+te+Rifwko9bQ
    Dk3PXVmdpzcjr4TKHTPEyk4caxEYguKXftLds8ztFoGmU6SZPs8RaWOLCuDQ
X-ME-Proxy: <xmx:yf_1apTxphFBxzBvSbWTUoc7exEVizLo3MyTvErokOy8hZ7zaJXqKg>
    <xmx:yf_1aqJKmJt98TcPRuKikK-7Vjs1InvBgECMEMHWKz0c3UZbPM8USw>
    <xmx:yf_1akZXC1udW-kTY_qlWlIMCSBDEMX_XwDKJA4MqJ7NJl31hwZpsg>
    <xmx:yf_1as_oCAg1ZUFuUFlNV7g_jAZfPGgurHD07-ilEL-ixoCALQyoFw>
    <xmx:yv_1amD09BtkRtbVkapA2MN5rmkhKnj8pIPnSQrAOo_mt0M4BshHgRqf>
Feedback-ID: i792e4853:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:04:56 -0500 (EST)
From: =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>
To: sashal@kernel.org
Cc: marmarek@invisiblethingslab.com,
	hch@lst.de,
	bob.beckett@collabora.com,
	thomas.hellstrom@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV" failed to apply to 7.3-stable tree
Date: Thu, 12 Nov 2026 19:04:36 +0100
Message-ID: <20261112180436.912177-1-accek@invisiblethingslab.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050332-failed-7.3-77f704158f09@kernel.org>
References: <20261107050332-failed-7.3-77f704158f09@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No backport needed: this change is already present in the 7.3 tree,
went into v7.3-rc5 via drm-xe-fixes as commit 141008dec735
("drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV").

Thanks,
Szymon
