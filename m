Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631728;
	b=yRByVH+Q5Hm8mOu7lY71BcJhdLD6ov4ANYAolcmJaW9hMtsDscrMQNGndYcsDwqZ5S8Y
	 t5lUUsuR/yp3cHybKX2uR/j0mCaNZ97vvhPnYCzR15XlvpMw81PLTDNTcZAu9PJEqK6CZ
	 BA9Q3ew5F5MAivoxS6kjSsK6ySfIlTzCAohWqYUSP9ipJ2VvXCFYV8gs37XLF5i1wHPIX
	 kpWvS1O4WrmlSXKQlLvlO+TMYPxaCDRmAv7Dd027f5ZmLPQVXIUYPMwbIvaz8OIVrnH0i
	 z4uUfrrWI/yTJ7QSO2VApRQZcQCQfaRLABHi3B3Hj9ywXCfBqlmz5uGMvdIYx5f82Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
	b=16LlswMcXZe3abzb9wYR0vSp8b7B83Hn9W/C9cObv/v+Hlv6+q1pErC3xL3fy/QEfSFP
	 x8ZNE0GWADwV9ooDmQbdkIal/Ta1R7VNCE/gcU60PkRlZ/tVksWWOX2D9Jr3EejSiA3Wa
	 8Qzkl+yVnDe1qOh2k/O05W/XACClReEhAut3cC+aaCsbviFRluorVQUmZAN1xkXC/cC2x
	 SSZ3b0Z2fGwAvYVzv7t+DpBQPFHdJXsWLZMtij3pr5MnJ+G4QzY0Uc8W97HvRFETjGRF8
	 XBKyRrR+VNyfe/0RWudBWGe3YltIApVViBvxV4jJ32T6DYKk6yX9ipiNBMoDr+/0h+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwxnj0DD;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1C6070C9D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E1C6070C9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwxnj0DD
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18cdcfc05ffso3524277c88.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631727; x=1794236527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
        b=xwxnj0DD1DKAFVLGNqn/LX/iHKyCUG5RpZ06KLrANvWczMx7mNH3POOJaQTlSKKzRX
         cZokFQKAXKVzNglOBI+mQ4XVUBXTw3W0475HWABkQPnUVW1CHwj5YTChR68ZEugPnfvV
         VR7yyicuAN3XPeGZ8SHMJtyfpwb1LLZSI3s+OVfQd/VHWnC/0G3nYNVyrxSnGZpDVkry
         O1qqcfiVmZjs2LNHitVY20/0RrsRk0HpKvjncr6ifd6OwHirJ4jFSDXYiULwnPsLuvUX
         5MbjirEj6mMVPT6QVtRrDz3RXhx558Mz5K4uQlOzS1WbBAOylrFf7qch6ZcRJMh+w1G2
         O24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631727; x=1794236527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
        b=fz12YF7e+mXDbRatarDnMKg0hggoeZeezOIVtijTxYlvJBSj2oq24/pnpsTj+tLuD2
         Lbpx+ws2owNhM1v6TavOxJdJVB3iWWnitZQ4n6hbukZZc4plmRPFTlj8YZIasIW94Je3
         oZPjXDfaQjeDACAWfMIivMCCDYaxtDEseXkrsHt4eOfGNnk+0Mb37u0sUYJJqYdIqhGT
         EvLEf1eyCbsF3kuEh89DSY13EzdhbmGCgemtXPZvGVh7Eb6pr9xPX1xNXyofPRXHV72l
         H5yxX4zkYq4jiFw2h7+QTwt9shxE24KqXOkARFdYTs7+37DLEORJRJOUGUlx4zljqJkv
         /ELA==
X-Forwarded-Encrypted: i=1; AKwUvBzeuAaSQnT26LuNNqhhLVlB4AuyJoPkJXaGUG33BlaMU82hbML0o38w3QiAJ0O7gmDfGKF8K5E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4ALZ8tEjwMJjY7rS498Yvr5RI5A+GtinZ8KnPzgMd+Zb3gHeF
	afF4EZw951Pi6D/9hgok4f1EP/Dd29LFthXNX7rnYnJGOdYOQ/oBUKVA23V7xeDqBcU=
X-Gm-Gg: AYBFou0o/9Pl99TjZRBXtq2RhdsQL3fd7plfXkLVHrNtHuTf8ZZDoqIVjiwzY8SJp4L
	rcPWZAm2fX5EzA5JkDB58nB59CbJ9hsd+6C0E8jCLOozAkJFi5u4Dn7a8GvJMUXVXUJrbX1ecZy
	XvrRo0QcROk2FypJ3NF9CCEs+7dirnloMoLXPV+8rhpFqQT9LyOY0WetC8nRFcnYolDCq8MvN4i
	J8OWyL6Vt5Imv2UDwpDpFhJav12ZbWMpwmCoqVzcR1nulWCkoFYavTxC/SYFnf3o1jmBa/zJX7U
	YFlzLL0gd2l9Nx02os0Y2QgwAESnJUDRh+vqHZcIl+tjnC1Fblu3Y+kZg7aIzyv5VYKAeMtUIyo
	1wg9QWiUBNlFHXudnP4sm6FpB11SkogqeRez08w8prxPKa9sQljHKpbZA8E3GQ+0ngmAkaGgan9
	QZmQ5wnF+0qe3WtnSAafFHwZc2Hmwc46ZUkVn0WKUunVa5XOWpziXJM532INp2yvqDX1dT6K5l3
	ih/nEwYSI39QeSePTkkf5/lBWvutjo08k8Gq96CCMzGf4aVeCeLNfgvxcp1TPryy+Gpz6BMJKOg
	DEi6Zjm2B5L5ZKDzBeaBXGMKr0gdqPVpeYHa
X-Received: by 2002:a05:7022:92b:b0:1ab:fe29:5055 with SMTP id a92af1059eb24-1ac5bbb9041mr19879405c88.9.1793631727135;
        Mon, 02 Nov 2026 07:02:07 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm34406419c88.18.2026.11.02.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:01:59 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: andrew@lunn.ch
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Mon,  2 Nov 2026 20:31:00 +0530
Message-ID: <20261102150100.44615-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Hi Andrew,

Thank you for the thoughtful feedback and for digging into the git history.
Your point, together with the Sashiko AI review report on this patch, makes
the architectural picture very clear.

1. Analysis of Sashiko AI's findings:
Sashiko correctly pointed out that guarding only nl-mac.c is incomplete:
- net/ieee802154/nl-phy.c: ieee802154_del_iface() unconditionally reads
  dev->ieee802154_ptr->wpan_phy when dev->type == ARPHRD_IEEE802154.
- net/ieee802154/socket.c: ieee802154_get_dev(), dgram_sendmsg() calling
  wpan_dev_hard_header(), and ieee802154_rcv() / ieee802154_dgram_deliver()
  all unconditionally dereference dev->ieee802154_ptr.

As you noted, sprinkling NULL checks across every one of these sites in the
ieee802154 subsystem would just be papering over the real issue and hiding
bugs rather than solving the fundamental cause.

2. Audit of other struct net_device subsystem pointers:
I audited the other pointers you highlighted in struct net_device:
- ieee80211_ptr (CFG80211): cfg80211 does not rely on dev->type to infer
  wireless_dev; it uses dev->wireless_data or wdev backpointers, and tun.c
  does not set 802.11 types in tun_get_addr_len().
- dsa_ptr (NET_DSA): strictly managed by DSA slave allocations (ARPHRD_ETHER).
- tipc_ptr (TIPC): managed through explicit bearer enable/disable, not dev->type.
- mpls_ptr / mctp_ptr: managed via rtnl/subsystem netlink ops rather than
  arbitrary dev->type mapping.

ieee802154_ptr is unique because drivers/net/tun.c explicitly recognized
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len(),
allowing TUNSETLINK to stamp dev->type = ARPHRD_IEEE802154 onto a TUN device
without ever initializing dev->ieee802154_ptr or wpan_dev. The entire
ieee802154 subsystem operates on the invariant that any net_device with
dev->type == ARPHRD_IEEE802154 is a genuine wpan device with valid
ieee802154_ptr.

3. Proposed resolution:
Setting ieee802154_ptr to dummy ops in TUN does not make sense because TUN
devices cannot function as 802.15.4 radios (no wpan_phy, no channels, no
PAN ID, no MLME). Virtual 802.15.4 interfaces are already properly provided
by mac802154_hwsim and fakelb.

Therefore, the cleanest and most robust fix is to disallow setting
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK in
drivers/net/tun.c (returning -EOPNOTSUPP or -EINVAL).

This single change:
- Closes the syzbot crash in nl-mac.c.
- Closes the crashes identified by Sashiko in nl-phy.c and socket.c.
- Preserves the invariant throughout net/ieee802154 that dev->type ==
  ARPHRD_IEEE802154 implies a valid dev->ieee802154_ptr.

Alexander, Stefan, Miquel: as IEEE 802.15.4 maintainers, could you please
confirm if there is any legitimate use case for a TUN device claiming to be
ARPHRD_IEEE802154?

If you agree with this direction, I will withdraw this patch and submit a v2
fixing it in drivers/net/tun.c instead.

Thanks,
Kalpesh

pw-bot: cr
