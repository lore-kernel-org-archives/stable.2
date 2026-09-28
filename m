Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B13783C5;
	Mon, 28 Sep 2026 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583759; cv=none; b=u+yVY5W8DRkKzxaDXoCE8B/MqQ0/PDfN23eGxSo2oCR2Jr66DbsbIn2nnF8+NwYumLenzAFMhuUbVUFa7uVH1qKfcvF82/tgQHhtTP/3p+flc9fk6+33P4j7ZBeRzqy3t1DKO6AT4KT72z3AYQQK2aoLrfeC9uYDbCF/xzAk2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583759; c=relaxed/simple;
	bh=71VpvoeXO3LpPfDEq7YVyLxqUvtg8NHlN1NDuMr40OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slL8x19Xejy1JEFzhkCckXBe29tGNdzJAWj9ViD1qkLLUI4bp+XcFxHsYL9o5IUqf2LAcpGMkTO8Ef/zDMK+xAJK2cXuW22mJFmlCo9ZMTlyK07YdZ9a2UAJBD4oB0hK1C8i0kPP8KlOpCqMjiCzAmgV3jZw6I2r+qA8Ee5D5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JWdt5s4l; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWdt5s4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gg
	VRzXraIyqQBjjF/f4890CVZWneX6nCin74kDHMb2o=; b=JWdt5s4lFdQK7yvKze
	jCKdCLOHbllxC9AiuC2/U5OjoaUEsvpu/RXR4A8ItD6h01qdT+B03jUwe2cHxSqJ
	Y2Q9ZgqLQl0phL1S6ToRUXLTX525OqLGmsAgxLcy03zfNLJWqf5AQfHR+Louk5+m
	tCsQkdRxlWETf1rLHd7eo0yFg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXX4GjI7pqCAGkBQ--.42849S2;
	Mon, 28 Sep 2026 16:21:56 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: netdev-bot+sinfo@kernel.org
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Mon, 28 Sep 2026 16:21:40 +0800
Message-ID: <20260928082140.1899337-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179058331782.31693.12350465700616409287@kernel.org>
References: <20260928065000.1749383-1-quchaosheng000406@163.com> <20260928065000.1749383-2-quchaosheng000406@163.com> <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net> <20260928080919.1888649-1-quchaosheng000406@163.com> <179058331782.31693.12350465700616409287@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX4GjI7pqCAGkBQ--.42849S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr18try8GFyrCw48Xr1rtFb_yoWDKrgE9a
	4kZ34DXw4UJrsxWrWYkr4YyryDGayDA34rWrZ5Xr43Kr95urs8ZanxJr1S9F90yF1xKFsx
	Gw1FvwsavwsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUj6nmtUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AQ7sGq6I6TdQQAA3g

Manual code inspection, and nothing reported it before this.

I was working out what else the CAN skb header regression (9f10374bb024)
reaches, and the packet socket turned out not to be covered by the CAN
patch: packet_rcv_spkt() is the one call site of the ll header restore
that d549699048b4 left without dev_has_header(), and SOCK_PACKET reaches
it.  It came out of reading the receive paths, not from a scan, a tool
or a report.

Because nothing had reported it, I built the reproduction before posting
rather than sending a theoretical path:

  v7.3-rc5 under QEMU, slcan on a pty (the driver RX path; vcan resets
  the headers in can_send() and does not reproduce it), defconfig plus
  CONFIG_CAN_SLCAN=y, two images from one tree differing only in the
  hunk.  Unpatched: skb_under_panic len:-65455 out of
  packet_rcv_spkt+0xe1 and a panic in interrupt.  Patched: no panic.

The v1 had an extra skb_mac_header_was_set() conjunct; v2 drops it after
Oliver asked whether af_packet.c was the right place for this, and both
kernels were re-run with the version posted here.

