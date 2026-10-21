Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602515;
	b=E0YVXxDjTbLLY4ZP6AJQc1C3qDR+dtH9mCNKaLOKknQUcmkU1dZmHuvd1AsHwHTXwgJP
	 xtSZ5qx+sTtkcK+tLp8yu996lt7CUau0cVoMRkWLQBnImSMHSP5Vyxaxgw7VlU4nVizEi
	 99cJaA8Moh6O09m97HWsfScsrsBedP8Z+CFFtEmVuK8pfscS+srD4AKnxg0repgVhQtG5
	 MpZVd1BdKrEIwnW0OC1pDI704QGhfLa9U61Hwu3KTxGLguTR3vsDAYZqfPFrz9nadvRP/
	 F/iU0qoiZtWMctHdz8MR2RIMFzpBAMRi/kK07j6BopZXh4RZ1l7xT+qyme9bQU64tzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602515;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SpeOiKGmueTw3TsTXSAJpn9bI2PcB926uv7ozXrY3UA=;
	b=ftnbV6zsk/i1pzOKGg4JGCiz1sQG4LmCpVw5aVoh5X95B3kzhhOeCvy4XPdmJB/+a5iV
	 plngqNe/DuLMXrNK/qXlcKZF0hW2L8VpD4RK5uvp9zS8DqV9LRL6uTlpNszZHJbLvLyZZ
	 AyRQ/zmwQVuBMNbBqG/XAE3e4sj1loi7DY8m8qoBYqpttQmP2dlagIkVss50UyjdrRCol
	 B2gMJM13Bm1tgYhxX5/837Y/FVlFgWMb/upRlXq/wjYf16sLa8tXi2IIhKxhzl8e56RuL
	 Aw273kepuT6qPP0So5MhULIdypdA7QELBarX9BM+4dqimVhiN8/oDiEM5A3ynogyyDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VCGxrWoW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD0606A31A;
	Wed, 21 Oct 2026 17:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4BD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VCGxrWoW
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D85D720177D;
	Wed, 21 Oct 2026 19:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpeOiKGmueTw3TsTXSAJpn9bI2PcB926uv7ozXrY3UA=;
	b=VCGxrWoWgTUjDjORA45qF3qS6wf3jwTtY8gzIzA1/D72bU9K2YWamp0Dl0xpWEsXEZalqU
	D35SFqBMa3eoOqU3yMt/rmjBL7f3CWkyKKi4Q/+ydTRTKIHZH//wtRANTtxF/s5R9qPfBM
	I4PCKYysNNLeSbC3yj3bmcjVbFqS/peEA8LyB4AoaPrV3D1RqcFBOPa7lYScn7pF3q1KDh
	8etwdl/cAgpMp1M5W0cLQ5nUjEa3z++niJmlwF+DcKpYWakXQG5BbHx7d9irbAPkm6L4FK
	VRvfgJ2Q3HQ8mwg3kPeUkr1sQsQPX6+HK6keN/zqhXxOscjx3q0uAYS6QeTV/w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792602508; a=rsa-sha256;
	cv=none;
	b=ZILVKHMlxR7eau+K20ZpgiWwOZdXUCTwonG3B/g463//+Yp65H2RK2RjnN+Mj3n6W3BuhZ
	W3E7XAJXsuFoJXklAA/LY31b7TheRJgYIFZWfxmMUzdQPavnG430+Ayd0VH2y6HKrnvD1g
	FU+dQI9zKwufO/+8eaTWzysPPH0vAsHprpb7fOBMX9aETikMiwCaJ0T14DdbGkMjwlzJri
	Db6FbeqMaAkgTMUpgsfTWyBkHOp3Xp6exh3qwBtbhBPt/qoFYzNXqDPfz3F0aTNM4aDxV4
	GQ1+TG6wc4oBsuQ7TT7dWBkC2isyDIW1O2/LpYHOlTOG0ypWHNI03TW8rWsY5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpeOiKGmueTw3TsTXSAJpn9bI2PcB926uv7ozXrY3UA=;
	b=QR7EevQzxrI7i6P91RkNd3zCJqr7Dj6dJpRUGtplvQtNDyJA87VJDe9wwjbdmyMQW3bR0Y
	RW5NZOenSw1h6aBM5UNzIn3He3YCGOXJxVM5XAgb1ujaXEs48MvifEZicJi2xAPT347Eto
	o0GnwpyBrKh+3FEiNDEN2p9TFQQMvXe3MHVHfyyKINfxcqrI4yhHR+cSOi+MJeXvs3Ko0T
	cz3d6ivGi9/yxjX9F+I20FpwQfRqIdVcBaVqUzbbK7B+WhnSACmsBhjhQGDAF+aenfMM54
	8WllGXurWIknbuy0uzQylmi/0/ZsvGtGXfFaMKrKt2p2Yxb2z7sw9247BYz1zw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJZng-000aUx-2Z;
	Wed, 21 Oct 2026 19:08:28 +0200
Received: from hardanger.blackshift.org (195-200-20-154.mclarenap.oninferno.net [195.200.20.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 04FA15D0407;
	Wed, 21 Oct 2026 17:08:27 +0000 (UTC)
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
Subject: Re: [PATCH net] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute
 sizing
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
 nsekhar@ti.com, faiz_abbas@ti.com, s-anna@ti.com, fcooper@ti.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com>
References: <tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com>
Date: Wed, 21 Oct 2026 19:08:22 +0200
Message-Id: <179260250294.2007736.11072636488246144106.b4-review@b4>
X-Mailer: b4 0.17-dev-d58fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=584; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PiJw0VSpx8dA4BHXBBD/ydOSpYUXczQ7nTrc1l3W80w=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi68bHDiS/rQGiN7vf2fRLzdH7O/ryX6ZTNOtNP/+avP
 66XLadT1lHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJKGxgZJgo3GUez6s4y/fj
 0bPXFt74wpPb/K9in/vyr5dnStYHZd5l+KcmE3h6zdvL50qs8jnt1OccqGF5q9f065JBiu4Ty7f
 zs/kA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On Sat, 05 Sep 2026 00:20:58 +0800, Zhu Ling <zhuling0805@qq.com> wrote:
> can_fill_info() emits IFLA_CAN_BITRATE_MAX with nla_put(), which consumes
> space for both the attribute header and its aligned payload. However,
> can_get_size() accounts for the payload only. The resulting underestimate
> can make filling the netlink response fail with -EMSGSIZE when the skb has
> no remaining slack.
> 
> Use nla_total_size() to account for the complete attribute.
> 
> [...]

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
