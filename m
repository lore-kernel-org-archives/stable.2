Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055375;
	b=TWQ3JKzUvCv1Q9GdPnST7aMCF5A+ScRLpNW3X5l4y5hOd9mO2f4xHpmxEyNYB+8koa7u
	 pjS7r0PdJ+09TVUbILLcnPtfgLAjH/YU/HnDhS8CafYgzB1DZNts03aHA4xymiK9ks4F4
	 1p0y+KZVK35bcGR3MrJqH23W3K1nMz1diERVkp1LLNlo6vQJ9+ZwhLDwPRMqoxxxXEBru
	 L4num5PaDldtvc5JBtFvM1n6k+OZVrAi20sw9pMZwMVtqDVu8/+wQvZq2E4+aBhCFUyXi
	 VuT/5r2Qv1b/PmMl6dFKrOfFxkcUlqUxgdbN7C16GsasRh+I0BDHNoipjhi51rLNoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R3RAC3wpsc3nzHzfW8jXfqYV5UeokEOIMcXIgp+ydq0=;
	b=LB5JXPWIwsGu2d1ng5dVDw+50lCe2JURC4RRRtoK7xDWdZlKECFiKlCt905hFCb08O9I
	 xodr05CnmN9wxnsNEGHWUZcYk3AB4KlQNqLDecznzezVUoe5BbVjHcFgD7+K3ojDEJemF
	 vX+dEbsksFxEf2pz3hM+2FDKbWh0y/n51OHnmaTLcR4UcRVEVxbhUyXa8sTJroYXN3W22
	 UGzIkl/fdAAxO/KF9zcfAYUwzsgOGKrIQnugUvOCg8t+dyoCBLwQrrF4Zec9lH3u98NMO
	 jHxCa0Nw0NOBfVKa4LLTRV2gaZRlmc4+Gd11zKFk9GlQKqeNRWLeOOLV7d4VtCKamoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAs06u2l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3260A260D;
	Mon, 26 Oct 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAs06u2l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EC01F01829;
	Mon, 26 Oct 2026 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055375;
	bh=R3RAC3wpsc3nzHzfW8jXfqYV5UeokEOIMcXIgp+ydq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAs06u2l2Ksts5smJDW29AqqG9WM+wUANceDv0NwlK3S9rB6LezXfCnS/nSTGjPUv
	 mV7CIHSOq4JO1wBBBapNt4kSFXuQM7l/CH0SKi19iOrB0tVnD5T98y78YiPHkBrjlR
	 2oye1FX79cLdm4VGbXyRD06MfoqQuMpGqv9ert0ecxTxG4NdEIjx34FHicjA9omcxH
	 aeY0oZ9M6+w6lqJ2av7ddIgs5F9aJOMKK68/k1gqSSthV2fxe1QQxJqRtaPxhbFvvt
	 /7eZ9TM+4RaLR6o9b78a+R33Si2CWayGBEzSApg4hnn8P26zNjjucCeP14icTER42V
	 V8Olo4jnSgZ+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	syzkaller@googlegroups.com,
	stable@vger.kernel.org,
	Ivan <ivan.vin.ctf@gmail.com>
Subject: Re: wifi: mac80211: two more check-sdata-in-driver WARN sites (drv_bss_info_changed, __rate_control_send_low) - same family as the 2026 set_bitrate_mask fix
Date: Mon, 26 Oct 2026 18:56:01 -0400
Message-ID: <2026-10-26-1-daily-reply-0010-mac80211-sdata-warn-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CA+hZKY+MDvp5rn-F=wJAP2HR8PAXBkLHiK==4ESeZ6uU2zADoA@mail.gmail.com>
References: <CA+hZKY+MDvp5rn-F=wJAP2HR8PAXBkLHiK==4ESeZ6uU2zADoA@mail.gmail.com>
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

> 1) WARNING: net/mac80211/driver-ops.h:172 drv_bss_info_changed+0x4d8/0x580
>    message: "wlan0: Failed check-sdata-in-driver check, flags: 0x4"
>    trigger: syz_usb_connect_ath9k + NL80211_CMD_SET_INTERFACE (iftype=7)
>    racing interface teardown/bringup; 16 crash instances collected.

For this one we need the full call trace to see which path gets there, and
the reproducer. Could you send both, from current 5.15.y (5.15.223) if
possible?

> 2) WARNING: net/mac80211/rate.c:371 __rate_control_send_low+0x6ca/0x7e0
>    message: "no supported rates for sta (null) (0xffffffff, band 1) in
>    rate_mask 0x0 with flags 0x0"
>    trigger: scan_work path with a NULL sta.

This one is a known bug, fixed in mainline by
ab9177d83c04 ("wifi: mac80211: don't use rate mask for scanning").
It is already in 6.1.y and 6.6.y.

-- 
Thanks,
Sasha
