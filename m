Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136716;
	b=hFg+j8vbALNlrT+8ImCo7xHTPCrN2I7yddf/Mqe8XuQHTi5jjUZV7HAlFMC0zUjZdhDG
	 /Q2Md1EYHbqJ+QuZgYj7J/DV6Ht+TGiEoZn3NjdHvJAWUgiFKDHJABXnc82wLvanIN9r4
	 eEY/FRgcDjUFTOEh0ktm6F1IpqKD6iK+4UQ4TRMNwmNErJ3J/woRZGUI49pssrWv5J0s4
	 MlfIr8Wx0naSo5w/pHhlSkVyhxj3CcJZmh6vWg6g9IOPXmrur4C47/ZuCv5LgPxrIomMy
	 5bjYvLrNPBUMeA5b9k9uxD3o02euRL9xAp/rU7LYT/g97ldV0f+681S4bpUSai+vONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
	b=BDTmkpUYE/l5yjE2FMckmwPZAblZE43jctZN4dHUK4QU4ZJVuRcPqdYfah//OxqmNqur
	 Rd6w07XRJpwDqud5HwxLTE8/HtiUcEQZUcQRYKDmDMMx8l/6/aTRZrOcp3WMkmn5nlE4l
	 mLGpZQOvG2yiS1mA9A1BIbBSydjT1OOd+uPfRLTKe08vkGC+3dJJwo2QPFE9nOPWliTQx
	 SsK46Ka/GbLEDZF8e5X/XIU+ZpnKkWUNFhBoUdYxPDDtxpPIUU42nsAlcq87UgNaggUy+
	 hlHP3qcUnYpg2D35YVo4+UoU+eJu+5MUpnaCRUuwsG3VuSGy3gK/djsQ61/ZxVAX9HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5430606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5430606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so124377eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 03:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794136713; x=1794741513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
        b=EJnjOekExMq+4XmCNDBgz8AvVL2Qyl/i2Lo1WR48gl6hs9cQXZzHDQ1HapMXFjF9kg
         CoWyta09y4OCZXpJ1mCMFiHQCHpxRgeO1BPT4fQo9F4HK5xVnbRZfQ1u75Df10xFHntL
         qKJvJDRq0PGo7Af196CHJ5IxuV4G8r1eq6+fJMI1l9wAciNP5ilv2Sf0PSZQoA/061tE
         Mc8DOjlRE7/X6Hirj2CZ5tLASWT8l7h1yVhcHydsQRDvUcE/8ioh+S1Dv9FPvtVKvhUM
         L81Dka+AVaT9V00BM5BBT/iwQEFM/WKWQMGpYprg89dAM7cXT3qn92RmeWeCWpOkeBHS
         /z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136713; x=1794741513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
        b=vTR4GIFR9ZJXFbkKC6Wox7x0M7XyxY7dNwv6ij43BCDy9WeVHpaMpXST3B/ypyZwee
         K+PoBS9gg+i84k9AoT6joyWSN1GGRod10fGpzXh6UcqOC16mUot+Mx3QFJuAP1sbOVdC
         7OLHDvQkqxbYLWJWaJpIwLklkac6AWUFyi8nLWf6AS+0ET/43KDXeJ+euOnmcP0hm1ok
         CBYqFJ2wrlZTQHoxtzMhkTf/e7lQqHjLmnCx0z3DlkM0By3ePgmPS7VEk6VRcjRiI1Aq
         TrDwLaEIoQUqXtGF71bTHgqRaLqzbcWzIGyG12M0fuIODryOZ9Kx4t5rQpMwQ9shgi9t
         zNeg==
X-Forwarded-Encrypted: i=1; AL+hErGobuCfoxu0PSgK7mHcQ/dF/qWoW36ZyCx3+uMi9XleXo436XBO3r0ENzwaNJyoM4LURG7/W3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/16ftcKav+N1Swii60sfeohcfyGC8iq4y2cjG7pF5j/m1tEM9
	yNvFKp2kh8MY/GnZmjMUD0ZiCBdvsRacEA07jK9+5WcMQi1L9tbLbp/YlbHoS9ix83w=
X-Gm-Gg: AYBFou0Nz+AbtjTcx3qgjmu5r06+kbasxiqNon9afjXyAuhEetRo4pcoPpd3TEQpDVd
	Ie2S+RahjcxcQolJibf/2KlBJ/fEpXaKgu6QJZXTCYimX7lezeEhcEeVx3dJL8WcTzy6qGerUhf
	5VZ7FVaM6e+mr1I7lL7ZlDZ/vTqO/aSUzVFTSBbbkaGYA7VDTSAdW1H5J5qgt2djYjdc9JBxswa
	35yYKleKsGSFE73CscTOBDrcWn0KcaDl8YQqUEB5gBapgQ1Bj/F6pD0ZzAJNHcF0a1lz9yKETcI
	6vWhdyqRow88NdkO6iGQR7TryzKi/2B4wklzKCK2SLAMy/5rHOR9OTVQmwucD3xl+4m/0seb3ZN
	emYC62hKHCFEHkAIfiDWQMRxHaQncE37lh4eza+oelh+i0JKJZ0MP+rmDnriMoulvo/0uiIXqV4
	0qsboZUuMFh20H50d1ge2Zj/11/P1wyc0kImbcAZQpXDFGN9yit5BRPE20dTG+QyMqzJCGJDz7O
	/XqnTDhgc4Aos8prJybmCVGBdyRSA44Gf8pdi6jVEeoY7C0QTLRyRmcAdCapcLkPkkvw5l9Lbmf
	0vYm4BJyftv31I/NfKN/Eqj8hjIb1HJ+fd459qT0V+XlGIMzL/AYl6panOFrnjKaVTL64J9ul9c
	2YSOitaS8MB7gOuqaE7Vx6n6SxQ7rlNrL6K3oqw==
X-Received: by 2002:a05:7022:2209:b0:1b3:2692:2274 with SMTP id a92af1059eb24-1b39ff060a8mr2675802c88.40.1794136713408;
        Sun, 08 Nov 2026 03:18:33 -0800 (PST)
Received: from localhost.localdomain ([2406:5900:1044:110c:9c49:6b89:2201:42e8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm4582119c88.15.2026.11.08.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:18:32 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: netdev-bot+sashiko@kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	pkaligineedi@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow rules query
Date: Sun,  8 Nov 2026 20:18:23 +0900
Message-ID: <20261108111823.2803947-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411928865.994134.15713036918131150201@kernel.org>
References: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr> <179411928865.994134.15713036918131150201@kernel.org>
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

> Could the commit message also
> mention the write overflow for more than 1024 ids and the multiply wrap on
> both paths?

All three points are correct.  1025 or more ids overrun the 4096 byte
rule_ids_cache, and 1 << 29 rules or 1 << 30 ids wrap rule_info_len to zero
while the count still reaches ETHTOOL_GRXCLSRULE and ETHTOOL_GRXCLSRLALL,
neither of which needs CAP_NET_ADMIN.  The bound in this patch rejects all
of them; only the description falls short.  I can send a v2 with it
corrected if the maintainers want one.

KUnit under KASAN, harness not in the patch: a bad count from the device is
a 4136 byte write into the 4048 byte rules_cache at 47 rules and a 4100 byte
write into the 4096 byte rule_ids_cache at 1025 ids; both are -EINVAL with
the patch.

> does gve_adminq_process_rss_query() in gve_adminq.c need the same kind of
> bound?

Yes, sent separately:
https://lore.kernel.org/all/20261104070041.1902653-1-yhlee@isslab.korea.ac.kr/

Yehyeong
