Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155837;
	b=yuryHhw64pPVv7Il8T02/cIxuAtKNTEcWbO7hUPL7KE0ihb1CYPJu0RY7FlBDmmzF+KS
	 MPI89dnj5cMGXTDAyNZSqeQmWH918i2zljI/flQnuoRvVYYtBBLfUlRexSLUJJGvtp0wi
	 LsRa/gDUnOPMW4yZ6Sf3PU70nshcL6mcGWjIK+EVvCx6fc2wFk5W1zPr/4VKWeUyRZsyf
	 7HGNYdSbzKdm6bYlOjqw6lpCz4uQ2PqzAqQMDDpdoRWEwiR2+kcUxZRFlesCAGw6MEp7r
	 1v0nk+3H70RSUI8USeg+JycSgZORhDnJGczYyNNmSbQ5j6IJ3s4lCG91K9uA+7kP7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
	b=I4VMIPKi6eOB8NTXWpgrvYtzColU0MoNRkEgCzs0X451zFb52okYU8M6K4Dzot8enttW
	 fUJmY4H1L3UrY7EuSOEV9+EGddiQ1FHSjcncJao0b5JOyF/EJWpUMdNVcEs5HxJJ+S/2b
	 /rvK4zP4Y+i2j3Dozf6ClLcyGOhlaIxZstCirUX4sHh8o4wmy/T/dEjZW7gneBhuE7Wit
	 WkpHCa52rySrHQMSEIQm36OJ7vnIlFDP8wS0A9JgWoWU7WMhML8dnBsjyiJsbecESJgP9
	 meATvxabjP3JvPf0oJnpNaYJ3W0sfT55n6vZs3mXXf4vymbaL6zl9K0r7ssZmONW1Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eyx7f7/Q";
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C7E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyx7f7/Q
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so169907a91.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155836; x=1793760636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=eyx7f7/Q+fC5WBU+omNKOxO+4BfKSrMYmI8hYrJpclwUOEoA6wTu7EeAmY7Z94v2oI
         M2TY42zmspkcu6VNsxBjAE+aF4d7IfbfAvfA97oHKZtIeEsT6eInGiG94FMu1Cn2ev7/
         Fszu12V9BVBTIMIahHLC97qq0zzHjq9XpWGOvDUNFrPmjxkCT7wpKB180sqCNkYD7ryB
         eUWUPZVUN5qMpZYuwf/1KjMQpJeVFpWVHh3uDsxU6Wn5FeL8hY5sByuXW7AGfbxKz3DD
         HTubBCzRUHy7MA2t5uuYNN3slB9JE+NzyjvZwmX7KN6tS4KhIhFId4YKXcelvnKIL8AI
         1cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155836; x=1793760636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=zEqMH2XTRPz6tcU+wh9XgmEV004pFauWMAXHUWdisZrbei+5/v4PMf/rzbQjU/yzFr
         apb39b62Yj/7aKHBZCxcMXB1vqhgLgrpYvw3Mw8VVKxOcVPnPT++gMwQu9T7Qfp3+hyY
         OSBM079dwXyu8zZsM0BbdTyE1zuyynBQCaBbnaDRceUbywQcStdHb6t+PZ9K1UUR/nG+
         AjnxNf2gkAkGjAc6HpgHazAvvOXVnejcoiSpGEilfo5yf+3+FqK0bm22RWPgyuZBpHdA
         x1tywRgO0Pcf9R55BnZySvrMZLUIXf2UwuByxT8K4f+DQIwoXoWm7F6SuhZMOmLw6K2Z
         9qFA==
X-Forwarded-Encrypted: i=1; AKwUvBxCI5VfTMAgy9FBmnLozs5zUo/ZaOjWlfhd+uJ4udKTM1SkBc4diZVeLy33ncTw+R27zd3L0JQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA/Ek9StuLQm830x0I9UA2oCxsnzwwWThD6jbT1sGJ0XKrCicB
	gk+N4qBvYXb5kQDJEoeAt9DYa9nvhZk4RR5adRxdJhqUQFAKSxUz1X0c
X-Gm-Gg: AYBFou1TBPCrBarwgpKBrzLblS2h36lQCQGqfMcGCqgsTamJwQZurdwA7w8658bnpZv
	jNOs6Be7Jy865mua3nQ+whM8plwCKwlkBLCQ3Y5azAFsnDrlGUvWwcpfA3s9vrkyRL6aAHNXQDq
	SJPkJlQ+DKYgomdAquy9cHgpBT41uMbVt39zEyeJqfXvHWGppuEbOvH3fCQtrB0xDV1tIg2mqhA
	Km5RbwaIki+OSuXqNi82w3sHdvrcuFDLQxK0eysaZkBIIsAnBw4CwOT4mC6f/b0/CZQt6sz5vwS
	VLoJppY1SCPVWxtk/2NPi4gdk+fDSmhKXEZs8UX2cnqnLyK06/PfVVwcDwZ2VparSGSz7Po3l1J
	R33XeeeurMEpbnkJKhJllAernaNUU1mXt6QcNgi/YdsVbCxCmDjGW9pTvAIU/00T3aH4FuMSvy0
	/aDDlwO4dwt6JgyLM2tW8qwIfrwpSEmYo+ydhn4XMy3mJ2AWrkATeyhsp5ukorJoUtLyus5De2B
	d3jla888BFQjyxUipj8lX/iNHQLujupSIWktKI12pXXBmTbJgETz2KazyYhpJBsHrtBPFEi5EQJ
	1fA/S9Tbk0iZ8ShUEmmIGIzqZq00HgAksl2Sw9u6yn2GF3gIkvdmbhRhFt5ltazlRrpQvXic1CL
	dXmBNtx2q
X-Received: by 2002:a17:90b:3eca:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3ae57e078a3mr731546a91.1.1793155836154;
        Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:35 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 10:50:24 +0800
Message-Id: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

This is v3 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 extends test_xdp_metadata to cover the single-descriptor and
multi-buffer TX cases.

The updated selftest passes on the v3 kernel in a local QEMU run.

v3:
- preserve unlikely() around pool->tx_sw_csum (Maciej)
- restore the binary MAC literals in the selftest (Sashiko)
- keep a distinct malformed-packet counter out of this stable fix; if it is
  useful, it can be added separately for net-next later (Magnus)

v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 122 ++++++++++++------
 2 files changed, 99 insertions(+), 46 deletions(-)

-- 
2.39.5 (Apple Git-154)

