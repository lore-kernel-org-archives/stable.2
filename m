Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764104;
	b=PmJj3jjfQr3L0E91NPpAbapHn8xf6soSPoyc3hWhuX8zVAt9keDvTq0tDud069DA6Vjs
	 c2qtHfPJLQ1uPRzS04Yuj3uKVRs2uIqqnmk5E46L06xsgQWcbj6NZBil6HwfgF16qHez+
	 rC5qEfK0xu9tqoICs4nWMCvcjcx0oMkCAOcSLHQbcwOiJZi7tqlLlhPBWULrSqwjd5//t
	 rimBJwBENlsfeT4OHMjEi7y5uWOgjqKU3WmDwcux4c0urbbUCXtkgyjteWHjqkTzl0oCa
	 asGavpyW2OodU7AGycHdZYiE6DHraypxS+FlZoP7NKq1tQFFU98azoFy5p1W97bTxTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
	b=o8TammsxnW5uE+YxN4x2WcZScf/qdSg6xrdyRT8c1jWkQe4qBBGMs/uE443EDYLlqvCz
	 BzsoHHZ8hkymFO3RcH08a6iFke0Yy6pE/PqJ+0Wt67d/IviT+8BWVZV1VB6eQ9QHZBwKy
	 u7QdIi+X9Bcnp3h+uSH9QkzQNRRyC/GowYiPQ/s+lWBdaWfmVU1BW6Sdrj4UwMM0d3IDh
	 ipOZJZcc+ma+HFHGG6yfJdiP+2NKOfzJo3/dI1WlibIrrAzfut95djJB6gVPVQirmbUrZ
	 8EcWg2sxxeH/dA1njEvKGtEZXJQ3vfvK+7bjYIkU15rdWVD6YU/1YCSmbvFnsdn6pHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB6606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AB6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3ae7c6a2d07so111593a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764103; x=1794368903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=VgUuajXE3fSQNacAxk3tEj3LnGJEDe8eO4Xmi74v6UY6fHz6tM3wa7S4tUAUWkHaBM
         59ho7QGCRoW/e1+9Kfw/D3fuzzPaViTo9tlaMuoP7axIzYO2nEO17qpALd9cEOTLymK6
         UYFvxKM6X9SUGVxJowCEQrtOBdJW/HWvUoAZoEvn5ATujp/55l/zYq78izLTyuuLUSpe
         wSrm7vgT2wQcq1AB79XHUT0+BU5jNvnwTpab77YKTc5ImYJFdywHCga0pB49jTwNEAOn
         YENRyBabanJlUxoJqV4t6/vIXVCXdMjYrbJ26/qhFsUqDm1o4E5sTJf1sc34JPYx5bsJ
         /9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764103; x=1794368903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=ieO8DNgFqbUe3M3nd4gKwDqUqYsium2LCknmA0hA0lwC6FQfPRci2VowvbpF5yIRah
         8cl4D4cyfEynj9y+q+f4Vzaw5BxfTSmmj9evPL/fqSWNUeFL4zaRz2DAPkV4RYB5+H3B
         Vkqr4qdnHyyta47n/6EW5iiSmzTA+ByDvb5z9lsb1odn5kx+yIezr4Z9JYk00ohFKc2m
         1soa81qp3gdzufmqe1eQDHqX0jkiaggktwl4uyMaiMAs8dy8rI2/7oZqNOuX+4ia4Jbb
         l8aa/YKNqz02V1zppT9sB1JJ76VnBr4iWBHFAaw5N9O3qgpEt/FjuoDgYROGVoAU6CJV
         NeXQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5ZLBNH6tB3uCN8uh46XWgCeRlZrWiutlvgZABPp06N7gi3D6AasJP5hSut9z13D+ChqibFmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VUJ+vVlz349RzUUWwHXmroYf7tUzOsFn4VBUblCbu3mSkKE6n
	BPqxh8oT9bl1soTkidWRyQCbZdBHIzIvsS0Ym/SPATAGDzX4fMxomOt746P3bWz7dTPOVw==
X-Gm-Gg: AYBFou1oGkSB447udV7/CC4yYaTptIyNVIev38Rpiu1QcgxhzYyRfhSJNnXlKUm4AM1
	Y5cNBGexVVyVZ5JlwtJRyRx4md/4YEEymXZUOQFx1Ebohvhhp/hlYaKymGNuT2kLLf/4kL6p9Tp
	jod3WguGwmp/0ttQhzGvR7CWFMtklez8aZWrDTqxuj4AJ4FTGU9evDynZpJ+tvi6/J5rjaljHFK
	J8zvh2o6KKkjU5xOaTNuTO8jhOGMm8EUdH8eKYS9QiLizmjvIJztqR/RR9vSKAVocR6C3L4FCvP
	A4GJXAR4HAr4uukQLlghrvZ7WOn2ctudBf8JCqYehGyIIHxpaSE8Qw9cw/8iLD2PZyRzYxnVHkr
	ROkOvxkx9lwajvoxon3uETDPOggUVMz9sGDBYEUsxCW+Un8RkzW3s/Iif7/D/gE1tFpkeDpIQpQ
	k3vDYddDV4GH1J4oc6o1QEzURwDZM7FTZIyEAb9TE98HBuKKFCZ1plat2I4GqBO99V6V5e7gNIW
	yqEZ7HXuy34eaWwNxFWCWAH2p9uL43yMSfK8zvMtguYGEtckukVQxDde1vnmCdVQHhXdoPLgpe+
	XFwNYieinvZM+udFbS9olXsi82a76Ev5RxfYJY0ty3CaEuyrm1rtk/2kBggH00+ALkmT
X-Received: by 2002:a17:90a:ec90:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3ae89831a14mr12516860a91.49.1793764103123;
        Tue, 03 Nov 2026 19:48:23 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:22 -0800 (PST)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v5 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed,  4 Nov 2026 11:48:07 +0800
Message-Id: <20261104034809.24545-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is v5 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor
was correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

The updated selftest passes in a local QEMU run.

v5:
- remove the unnecessary else branch after the multi-buffer check
- carry all review tags received on v3 and v4

v4: https://lore.kernel.org/all/20261030023248.78802-1-testwrzwrz@gmail.com/
v3: https://lore.kernel.org/all/20261028025026.11401-1-testwrzwrz@gmail.com/
v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 2 files changed, 107 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)

