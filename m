Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911436;
	b=Cs1JDK6DwBo1TseKqiaCZ2/s1gKijpwCP4Vh3KzUfRY98bJQl0mHXFfS4lLM3LGIvjEo
	 Z82nsBBsKJg0ODotXUa/S6W2TDsF8YHGC3dQPBjqU/R0iCdztuMNq154nMRwmggrlmYhk
	 NKAkQ2+q3k9sZQxCQ9LzmqD9JcskF0F7r0Gr9FkPawNymovrCE0t4zeNByHi/JLs2Z4nR
	 qAggoJ4wPr89tao69AjrHwi7SCyvCuC3hPEkyzR3GMsJk75Gr1nWgX6wEKwzz3SkODHGB
	 L+VDfzoSX4CbKsO4V2PG3E/EdxaJKQdprswiqeMBJAr1C6LHD51EPOH8iHDbpzoC9wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911436;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=G58POVnkJOmscsV/mcbbCJVGrHCnzQeug7Sy0k1+jsI=;
	b=lxDQL4OmH51v3nnWPPXgwLUqUtVZov77XQVOiz5DYsMTTuAnuzWvWsUADbLrfTQS/fDJ
	 00ul1uG0wco9wmqvDsUJOYpwyB40FiXEcdnSxi08plVmzyBWNfJIKo7u17j0zL5E4bmtS
	 6Y+P40vnsu9sYn7ARNQ/9HZcGPLNcAQrOnMjBVcrja/XgQT6RhsyvTcHFJ+2ljZwVzQ7D
	 aN60lNRNeIrMbrS0VP4DQJud1ujebUwSdqBm2vKYybHbSlTlZOP28nmTi5TacCgnaZyss
	 bJ3I6atAd9rZVbthUe95xSRiCtdFUnDxruxb8X2puExInGiVFA2Rp1Xkp79hxtkY+IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=W4gtE8pM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2701606A336;
	Tue, 17 Nov 2026 10:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2701606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=W4gtE8pM
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A9D5C205A24;
	Tue, 17 Nov 2026 11:30:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794911432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G58POVnkJOmscsV/mcbbCJVGrHCnzQeug7Sy0k1+jsI=;
	b=W4gtE8pMZomiTiEb1X8WBuBz86BHGZrtjOcLclJ6qFhovPKZlh9Y2jVciUzitvVBeSWX5p
	Bd+aJ1tXqOdm/AzSI5hK++AEKk6w0kMAVDd1nUIHTcd9PrQgyXtsiRDYDf0mvyaMqsFe0I
	u0b2f+vElweEzhFpzyTiUaj54DmXm9iLxFnwcSJbTvTIhqGeFhOcwARILC59iiQPx6p4Eh
	GMtdnZgmDtEqxhFaFZn3JyRKRM9tL0AoW2S3rEQyEHGy3OgOcqZbdJBqpwPov5iT4Zlfy2
	1ILSaRxZ1ljU/GzyyxBnJdatNXBp7t9fzy/j1mHWvQjg+R4DvH1WHt1ml7RpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794911432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G58POVnkJOmscsV/mcbbCJVGrHCnzQeug7Sy0k1+jsI=;
	b=W3iIj+nPXk0H18gn62QQU4jfz5mb382W+lvbguFdL4v1mPhau8H04UA48ntRsAPNs+7Gn6
	tvev2YD/upM9FYosc6U1cVYU66GgM7woJdCDJM60xPhwE9RpDT+K8rjuHZNmsRY1ENdYWe
	Vte6Hz1bP0TCsKZzocS89TkmIP03mkSSzBuREJPNlQQQgRy1bUM6InXe6BzwuGgz3KmfdP
	KG7n7JVIQNsO56BKRl72oz3BwqoxX49g6cVAPmCyq7OAOG2LTGmnoolcmHuY6nCG6EPo7I
	mdnv+H5oQLdxXfXypH8uYtSzIyrVTy/AHGDPoQjXU6x/kBujdOQY99QNSvXEgQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794911432; a=rsa-sha256;
	cv=none;
	b=VskqGrQI8gPVke0LpwNrcyq/K8rzv0aNOb7ONxYBTCpx0Nj/HWel2/cktRPG2NyY18rrYh
	qU5aPzx8rI4VSEP+QD7ue8IYMvz8jDWr9fi5Kq9WaYYxBvO4Owv3s+24MJpXhzXNJ2omQA
	QhiRwKZ9Bg+fUxx5fJNWOto5uyVjQehvpf+CAIk26Te4jMjolAiZyq0FVva44xOTsjCnoL
	jAWai647xLkj7/nU3/v5KdlEOrC9GH7gIQJhgmDTioohsaQZGWFRm3l1opO6LwSH99B1ij
	xS7J5x25DjGLhq9zRzMh78GnZYFGxh+U1LFP27Ef+CZAiSjvkKmjg4RePLVf1Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <b9ca3ed2dfa418145eb84ca12889bb16540f4342.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: core: honour optional resets when the GPIO
 fallback returns -ENOENT
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yang Siyuan <hsyysy@163.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:30:32 +0100
In-Reply-To: <20261117095503.14115-1-hsyysy@163.com>
References: <20261117092008.12130-1-hsyysy@163.com>
	 <20261117095503.14115-1-hsyysy@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Di, 2026-11-17 at 17:55 +0800, Yang Siyuan wrote:
> __fwnode_reset_control_get() honours RESET_CONTROL_FLAGS_BIT_OPTIONAL by
> returning NULL when the requested reset is not described in the device
> tree.  The reset-gpio fallback breaks this: when
> __reset_add_reset_gpio_device() fails with -ENOENT, the error is returned
> even for an optional reset.
>=20
> This is reachable on Allwinner SoCs, whose pinctrl uses three-cell GPIO
> specifiers.  The reset-gpio fallback only supports two cells, so it
> returns -ENOENT and a consumer asking for an optional reset fails to
> probe instead of falling back to its own GPIO handling.  mmc-pwrseq-simpl=
e
> on the Anbernic RG35XX family hits this: its wifi_pwrseq node has
> reset-gpios but no resets, so the SDIO WiFi adapter never probes.
>=20
> Return NULL only for -ENOENT when the reset was requested as optional.
> A reset that is described but cannot be used is still an error, so
> -EPROBE_DEFER and all other failures are propagated.
>=20
> Fixes: c721f189e89c ("reset: Instantiate reset GPIO controller for shared=
 reset-gpios")
> Cc: stable@vger.kernel.org

This won't apply on top of c721f189e89c. The surroundings have most
recently been touched by commits 1f10008aff71 ("reset: use lock guards
in reset core") and 9035073d0ef1 ("reset: convert reset core to using
firmware nodes"). I suggest you drop the Fixes: and Cc:stable tags.
You can provide a backport if you need this on v7.0 or older.


regards
Philipp
