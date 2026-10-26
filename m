Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026483;
	b=lZlQOhNoP7+fR1o/XjN87ykvGkXf1qYOCZP7isUQIXsechM6PMWaV9VZjefFx6FkR169
	 HF7DvluKKvMvY8XORVV8G/nFLgNAGhvnCdYOaV9wffPPa12dWGRs/gnZ8p6V/f5sH1ioT
	 zTwFreGw65zC4jDqn2SOG+0MKhle0PPrbfqN8vcMuKzWGzfVt4wWMAEiRshTkSvQKUg27
	 RoojMtmfhzZZn1FwwRPK4t1RJjUUJmO7qnT5gO1bL91tNalPOmcLH5EqVWbCN9obAv4OP
	 1f4wTl4qH6UTpBe6pueS9PNYTlPg5xjGO3teJFWMev8KC7o2aqCVuRprF8FwNYWdNkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026483;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s7MAj2ti75+TfbmqJXX9kbJbekSfgI36oXgVy6VMyW4=;
	b=e7iJrItup2PMP6zd6SQUJUN7Mo+MfxUoWCRlzqaogCrKxmurS2bqvBAg/GW5rZ1sqcyT
	 6M3FMrsQeaRWkOu0N09gZ6v6G2BkKiYMzhL+rtpXcDrtVZOam3KyIkHhXxcCcdUCQFaPE
	 mIeW2VVLKmNSqZCuMN7Y/2rC6haKCYitl3ReGMndO0z8Y5L2Px7BKejl61iPMkRUwbdt3
	 WQ94rOqoti63LsJ13m0zqzKvfTxOeHZayeQKZ917WiH8F9YELXzWJ8JhRDyc3UQqiG1xp
	 hdo+iu6FCMszVp45PP/l6szFGerI83IPEDeZdP3WLtQIUhdnMi6O4bV/61DXqlNFBGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=LBX+NJLU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q+eYVkRR;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49B606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C49B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=LBX+NJLU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q+eYVkRR
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A713EC0A29
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:54:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793026477; x=1793112877; bh=s7MAj2ti75
	+TfbmqJXX9kbJbekSfgI36oXgVy6VMyW4=; b=LBX+NJLUrfDjoFZjWaO3725rbV
	DvoRJCHJyjeqZp9e2QvI9cUliTllJwS+p6hTWONrzjhmk0QbFsQZEsjs8dO9smsM
	Pht5VmtLC5xzfArEoycePOHpD+5HoLIUcGHRr7NyLPA75wOoNzpzUmbQ4A0yj6SN
	LCkQfNztC7kK1iKd1COuRaZY7807e9CaVkAGLfe0M2CnLuIFSZt7DC0WXJfl9JUa
	/oFNtm3vOnO9J9gBtq+k3dR8RTOY8PER9ppgJkPSySwwQbJIFrpWPqnOzDnbEvM3
	v9Cn0ynhbnEZcGCVB4JcM8o7p8EaSOT49iTZMgSlrit5ylEpekRIMLw4d5lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793026477; x=1793112877; bh=s7MAj2ti75+TfbmqJXX9kbJbekSfgI36oXg
	Vy6VMyW4=; b=q+eYVkRR2av/d7HUgfA/wUvMMlPWNo1iuTwZEL60PzseMiNrehl
	BxkEIgX4j3r/l1PivafyCGdF/T30hCAImvAfg2o0mWUVolmnG0KI+I7zd/E1LkT8
	8Hf0x8rFcUo5AnGYSsaVuzoTQDTrALmbFPrrXNQh6r0WfsrHKdvNEksuXBDeYHRZ
	7ZJgfxqj/Z6Pkvun51IBbxdl9ln7NCGjtlyZS3TTElXKIpi5j+RYXbjvAHzEYCaV
	rRGfwBRLgLLKEoBd+GILfnBzHX9grivpbGKylndEwE7pLInL6DYNPukaEUJnnfDw
	Yr1e7iCldYkS+gnKQQI+d/2GGFJNCYSgS9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793026477; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:m0PT1m9hBFBtxUBfe3FD06C4gQvAGnp8cQVKrL5iRUP73iQ
	AS8TwDDU+Waryuq3WgTWZuNZr2TIPr1Q2ONX/FGAUAC+E4kKzR9uUf4uX2v+qCcW
	EBBn2FCy4G7j/HWmaHVEiC8wziZfQau6XSYFEMAFcnHQ+9YXNR9ppQEwTTfHkm9f
	l4GD6dFCI4tX2KUP/jRWnWgMxCNI5UsoVPwAK8y2ByoTX0X9xyyeR9InWAq+3Ni+
	UpQQjL7YO9G6ktrXUrPhdYItin1Lz7ykWqN2bCDRIos3VwA2cy01qwRCG/eZRAA2
	UTYE0JUQUgoSxZsGRkotv1dCZvBDxVzfKmPn0CQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qrUygladX9pS2mNhhJppvH8zyvzQPbvJLYxM7IX9wGI=:s7MAj2ti75+TfbmqJXX9kbJbekSfgI36oXgVy6VMyW4=;
X-ME-Sender: <xms:rGnfavIY-gXzjDF7HRsCzu5_jC4tTkm3VK3oVBnCwlZsF_LKP2e3DQ>
    <xme:rGnfajnBnyrywb8M1Ox9X1sB1o-h-QyIHINqlwEg2de3hPsVswEHABPP8H9AiGJMY
    odnD3ivIp5yCc5wArJo8JzcpNU0IG96Won-appyPRTnfFADL51WCMA>
X-ME-Received: <xmr:rGnfaoZ3MQXGgyja_7SEgxL2ildLnYh3TtYupWECWAfe917cBUSKjiyu1PXA8T4sWWYagCwN7AF6VDa9izN_2NtNrZju0oF6>
X-ME-Proxy-Cause: dmFkZTGWSmJSwIvL/umBN9Uq5lxEdqwI+x/ixhjdF2mQiv9DYlzBaBsqjB65IMtREd2O0q
    7WRPYlwggU29oEo50E16y7rFiFjcNWG8sG3i4dj8RlcwFPV2t+LJMsimXdZkC2ePBjQOV8
    wcd8igTbpDTp0cCVHIvCOYw4vWXvThZKEY5ImWv7tNb50asGRvHyYnkLz5ZRmEtAanbCvJ
    kfefsMi7tMQbCC8DrRFRSNFzFEjEht2iTs2v6CD6YWZb0No1mZaJvJTDso5XMPji/AapZN
    6kGGfxL2fthiK0O/edzhEMUKTycTYZt6ot9qiYy0o3FxxuKyL4cnkDQasVgF/FEn3zu3ri
    ZfxirgFmrX+ppR4US7ns0/e/NBZCegHeduINpTw9lXUhdrNlIG0RiNkQOI0AEkFA/7A9j+
    gY8dPF/VNayebpQuHN4+ltVhjSdYl+UYQ4Lu1aEDlHW6e1tZAVPaDRct0gzGpQXIdLmkns
    LVA7ZK8X1GLzgeJ26uHrKEm1q1a5qEB26sfX4biWKQ4J3v/3UZXN2J+LdHYae4g8no3ARW
    LfHX7Ej4btsA10YQWvBt1kwFkXo5s97tH8wnvNEmwygOkLmXJUbKZyp3pl1ZD8W6CgUyou
    QdggSCdCRI+KCMoK4Jr8Q2FrhlHbJAzSN6RRDtTSsS0IWcIk6sSEwxJgwlOQ
X-ME-Proxy: <xmx:rGnfav8uxoLSqGIjgkJsi_BvV-scmFbQSUdFgHXSsHGZqjXyCC3BTw>
    <xmx:rGnfanZVVaW4ax7EGCnXbpj6fC9ald3NKQw0oF6rj2GzFpwz-chXfw>
    <xmx:rGnfapdoWl3X15yqCf8TzBrZNS-bMdnvHFi22Z78JrQVf-SCo2dN6g>
    <xmx:rGnfakkKyLLMFHhZnhgiK9UPCh7nvHYYfwKPdg6ecwjJDgT_mW6erw>
    <xmx:rWnfakQ-_s7R93BtbeqHN5iKOxJBwK5wBWwtfsUWVVqBxVcWKC4t8Suk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:54:36 -0400 (EDT)
Date: Mon, 26 Oct 2026 15:54:34 +0100
From: Janne Grunau <j@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: AQC113: Initialize struct hw_atl2_priv
 fully
Message-ID: <20261026145434.GA707866@robin.jannau.net>
References: <20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net>

On Sat, Oct 24, 2026 at 07:19:59PM +0200, Janne Grunau wrote:
> Leaving parts of struct hw_atl2_priv uninitialized breaks data
> transmission on AQC113 NICs integrated in Apple silicon desktop Macs.
> Commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
> slot, MAC address") replaced a memset of the whole struct with memsets
> of a few fields and initialisation of l3l4_filters[].l[34]_index to -1.
> This leaves other fields uninitialized.

As sashiko pointed out this is false. The intention of the change was to
use fields previously initialized in hw_atl2_utils_get_filter_caps().
This wasn't obvious to from the commit message.

The issue I'm seeing is that hw_atl2_priv::l2_filters_base_index is 9 on
the affected system. This is mostly handled correctly in hw_atl2.c
itself but w_atl2_hw_packet_filter_set() wraps
hw_atl_b0_hw_packet_filter_set(). The latter doesn't know
l2_filters_base_index and enables/disables all filters from
HW_ATL_B0_MAC_MIN to HW_ATL_B0_MAC_MAX.
If l2_filters_base_index is larger than aq_nic_cfg_s.mc_list_count it
will disable the filters set in hw_atl2.c including the one for the MAC
address which breaks data transmission.

Disregard this patch I'll send a new series fixing the root cause.

Janne
