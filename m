Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356524;
	b=xCGm/n+A41042xqm3tesgg49B29htNWU9+HNuL8N8r0CeHLRuCgxElKzc5nDOnBzly3g
	 8ydruHT+gmIBnD8AbId9nsV6wEjek1MM3Vt2gGrHoKWjRya6X2oPqGMrB5cR5vfjVs4y8
	 EsXW/a/qoSv2jbBkF4gOZyWOi+3ThRfqDGIrfPr7b/dhvy2mWEe5r2Cucz0DBX4Sbkn/N
	 YKvLJlo6ZlH1tYUd0J2f7nRK9XYekpT+rrsECjmY9lZ324t/1pWUw35kFS9r8rUY+jI3d
	 lgq6z6SxpiDqTIbj3YQJvpLvWfmmJOwsRsB3UWZNeMLDELTAPVK0679dfLSdsp+yyAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kyl4tY1plUiDZZfonfp8qCL7WeuNUjcvxWMrKf+wwgE=;
	b=uv1Pz35W2eLPvUo5+Wk/9xP6Xp74A160r3XDvTpBVHxhIUJB/KZ9JvWrUtkICa49Yc0Q
	 daUnJY2dtHDmxkMw+8D2sCCd64dfqp9dj4o6rdFImYaNWyVQdlw1TPd2n06qoSLDeu307
	 lXH0Zpv7bybaOs67zxM87s4sSWtKi5yV72y2U1ap6DVgRMjmJ4YgDZWt24Dhc57TF8qQ6
	 ImBV0xFzqFKGUyCYYQt2sXojlv0xPmRMDdqEkvd6K7qY3VBkCUESKZtXwPwpiU1VRwN8h
	 K8EVZlfvM1MijU7MylYZmrjjNpJsVUHwyPmbOCnZpsFvqKr2Iuzt+JE7LWDkn5aGCbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EY2z7w/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661F606A320;
	Sun, 22 Nov 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EY2z7w/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B01F000CA;
	Sun, 22 Nov 2026 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795356523;
	bh=kyl4tY1plUiDZZfonfp8qCL7WeuNUjcvxWMrKf+wwgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EY2z7w/ffVjkS1vKejnu8gIqi8qxJEdRtF3m72nSL2vPo4chAGki5pZvMMoyLqdyj
	 nqTznp2p541ESTItXqefxtzF9i4qWPbKg8TAl10Cx4XNn1nfoCdP1KdOQKpPgJmnnp
	 6h4RMD0lUdUrk9muUMvKiQueJhUX8F6f2vZPsYHW6J96b4N9XBizpjnTXn+NHiTaHa
	 9y6S3d/nMsf4OfL15cI4YT6GDb4gWthOxq+A1ffmfuQGNO/hDsj57FZ6EMrnXg0xF1
	 1JUjPqoYlu0Pyy3sxIpEyh3n+HdVWGGVFSgfY9t5iqiQ82dF+BEB7C96Ns7e4X3BqR
	 oUucYXe2BQhVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan Cochrane <bcochrane@google.com>
Subject: Re: [PATCH 6.18] bnxt_en: Take RTNL before netif_close() when aborting FW reset
Date: Sun, 22 Nov 2026 09:08:38 -0500
Message-ID: <2026-11-22-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <18ea344bdf5a5efb.3137322e31392e3133312e3730.20002c.0000sendgmr@google.com>
References: <18ea344bdf5a5efb.3137322e31392e3133312e3730.20002c.0000sendgmr@google.com>
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

> commit bf83b257423bb557b970df3d7ece32fbd85f3bd4 upstream.
>
> netif_close() must be called with RTNL held in addition to the netdev
> instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
> and NETDEV_DOWN notifier chains it runs rely on it for serialization.

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
