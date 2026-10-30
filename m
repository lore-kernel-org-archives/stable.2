Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327581;
	b=BCkBoms3cUpcuKbLJrdKni+cIx6lEshRKZSjrC1OGaqMXRKcz1G36z0hQYW6PIBdLmMi
	 xLxmVexgqcOJaUoOJGd3NIWzRMeTinJjXUiDf5FgqETPJfO95PRGliBTSnA6WLCW33/+2
	 V9qlJ9HvAF2/S0yTevExOSOMshpCgxa3IvLEeqXikd7ihQtTxe3QprhVJWRzfs2r0zXWa
	 aNLEezcj1YH8K+QGssVkre8t3yY7dniMtI4q7q2KteTld0DHD9uWyq8qLivBaQxW39JuZ
	 YVElkrDWiyw4N+6p1VuUY70jvixjWe1boMzbryHg/dbzJf4vs9BW+NKPR9imA4wPNeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
	b=MAELswnMwrwT4DI+SjqIPSR+ru9sY7fuz60kIwg7A6RJyIpAie0HKQniIH1TqCfgheE2
	 z9y5kTaL8ZdNkyF2MQUU1/p9IQq8NAcJlk6ZWW8iJKNtT/h5GnETGuLtyOz6gj1A3mJHl
	 aye5I8fMopXff7fXRTXyWjoiFNQgRtpB49AXP5h66DGBNlBTSuhWQMb3VCld1Zb8UujB0
	 fK7KuRS+LhnLzg2svxWMaRjVn4iDJoAIJtO2UkbhER/FsjXDqJ+Ih3ip2e5pZiHLC5gU0
	 +YoBJV9B0o/5talRUVUbtdn5wCe/TTY3SYQhIZTJ23lyPfcUySrIm/lDMQ0jm2/IPVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67F606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF67F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so101737a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327580; x=1793932380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=I4cVE3zNaa166lxyWLucLPwYv+KKUvcJb2782h1+tYmj2lVTSPBnTdH7SA9m7E9MjF
         0opo8avjoUPnItlZu0TYg2a1aVmH7OVIHTMN9HDYSVB6OTsM+uzbXx5oJMSmRtRxDgQF
         Psf7xF69LvGaOsj8RTjjMLfwRyOAE17xVsMKWn67GPX6PGAQQADemFAaNfTmHs3G/uga
         24/DqDEdEZbMqcql04HYUY8Mabl+kRXlUmp3Aq4hzHPqCDpfDigrJEXAjWyr7+pwGU4Q
         9gJSjAfD5AGxdLhscnnIyTuY7pH3wocg5//cRWle78FoXGuQ4ZLJP094+OwKCV6FPTWi
         i28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327580; x=1793932380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=ZkS6DKOEanAfHT3ENwpEJ8QpcHFx4Ezj+OxoIQQE8qzH6o3TkEUt0AA2htBZuS/Du5
         mr18J/Wz+F60Yfwjz4cGQUce5VvFSvVlJkb5HZdLE9oLwlZS5OQZxy/arYKk5HbfKz5h
         Sgv5LZbuXaaPXgHj8112LoJkT2XlNrB0AeHp4Z92VoIBhjGPWWQY2zstdMN3cevm7tS0
         XwAVbwnO0j5yb+wJ7lasrvZtDW2oAJd3/KLlzZlvbSPz9oLzWefLyV+4zUwLG5YcAd3Z
         wScEw7kpLJI1hdOwxtCvT9AqaV5o784cuGRKMqJ6RXFlcP0lW4VwAlZRCpcK6Z4CP3gc
         6bWw==
X-Forwarded-Encrypted: i=1; AKwUvBxDBQrLotFDjbzIuRWhQf3FLzrVToP2vWr93Fg5XXd9/gDaOeQNhv87WLvnjLQ2zmzlr+8nr9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt4QmnHobHPAqyEoYmsdSc7bVUZbRQk9A3Vkyx8p2crKnrGV1A
	+14qB61KteBaAWEXDiFZwovU7EtRSpgUGAToYqPhBUr9rBjWGkbzfN8rUZQA/BGGI84xlWLt
X-Gm-Gg: AYBFou27GLuB8T13uHTK4IUAbaCtq4XZcdPIl2WVheC5c+ymros1WZ9i9htLGDvH9TQ
	imRr2PfLgBGlbwIKb+sEicmFDlzHTkNrRhYXCmG1Po0TFTgjL82SuYJt+VSEz7JIvYA3PAvgybI
	vh4JjSILjgJnt6raqMLtKQl0ljvb/H/mC9xLVJeogEvJYmkRVhj7dstVxs40kIL/et6YrP4g9oP
	NQ+usO2xwyLVzcElHA5Znhu8wP1zJTKHRBuy0x/HIhmEGMBLMHHzOvR5P7qFtSqkE3pgf1N3x0a
	aH9ZL2hA3g1JemFMUK4BOgxX/SnVbqSeSNWiyFrY+7SW3gc5dSBKby8xMgjMtypEwzGmXeSeR3e
	AY7kEOhCpBWCnGE4ro6Ip92EmTB3HfKkq6IL842Lp6HX8YHM4t3cRHFTmUgZWo/6F3q7WtxKQkQ
	U3oJgnuw/KagZq6HQEYgCveeAI12IaifwVeixmgDniwD6PH+lQok3o+4D+Ll+FeUioug/2XxCot
	w/JOh6IVfMN4PiNLKyHe+9GN0XJmWPeZdfI55bOvB2VKmpiBdqBNdfD8JlzzNEBc6hG8AMyxshV
	YmxPpQYjw0PqvPK8Z66aUM7/USlLDM4y/YCRU6QwDV4TbB3k2HTtNw==
X-Received: by 2002:a05:6a00:140f:b0:89e:f8e9:205e with SMTP id d2e1a72fcca58-8a9bf71c0f3mr783776b3a.40.1793327580059;
        Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.32.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:32:59 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] xsk: fix multi-buffer TX software checksum
Date: Fri, 30 Oct 2026 10:32:46 +0800
Message-Id: <20261030023248.78802-1-testwrzwrz@gmail.com>
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

This is v4 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

Patch 1 is unchanged since v3.  The updated selftest passes in a local QEMU
run.

v4:
- exercise every descriptor count up to MAX_SKB_FRAGS + 1 (Maciej)
- keep the last descriptor within the packet length (Maciej)
- fix the local variable declaration order (Maciej)

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

