Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851128;
	b=q5ay6sV8KofpJPSys6oZkdBShLuFWgcfnD+Z1SxfnQBbnRnzHOdUEM2jBFbv1jGMluR+
	 bKC+eC8w8YM6fSPBJOYc4Z7jHr+DXg23ZeAd13D32oUx8+3iS8/0149cHAY/kKHLidH9+
	 Ug1OYLOCE/L/10RZO8HZitMAYqA9MULlQQmNeIFrHiSSiwEK3MkZ89T5335/+3oqvvs/s
	 yWzajMpL2SyjiZAvCLfLY0Zw0lo/k+J+EWUVCereRNf/9IOk0aykRhaDPlZHkkrWajJ5p
	 QUatp2+mTbagJl+VGd0fwDjKcS3GP2HTxsfk2yN+c4Y4ivTQbGS9HP7mggoDcP9cP/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
	b=NZ1ENc3yDz8wWlQpE/j/5vp1BYyB2uTei+vrnXhRfeRHYDY69+9zTWskuazv95du8ux7
	 9K/PHbYHpaVAPdXlXG2nGULlmmHRV2dqJPZu+5yCtc+qslPO62XALFbpaldrez31FiEav
	 tW0DVf7pwgLa9e+zIaX6WruKIcbbvFk5LRc15Znuvj0eXL4/mQxRHW7IQsKgQZ67I0XBQ
	 0/jDOA58S90kYS2E6ZK8W/9zLNgtHDf3f0ZnR+l7bGKIP2dPvo/Pd/dVJ3xYuMKmXs3mG
	 ukEHY/seSttzN5RwALBPjHNUYsMJjBvta48yVfgYhTFTRGyofK6EQ6mZYSgF1NFOTXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qN5mw/Re";
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4778606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4778606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qN5mw/Re
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso1632535eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851127; x=1793455927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=qN5mw/ReCB7w8Fr8wpbp17/Wt0LcVzV62xdjLQJ45acFlyX54MQXD0yvZoA6L8h9UW
         SiiD9IQhqeUWGygZQriJ8FqLzFn9RLTs8083oNXLfcKarEq3cvER4owatxsYqXeq8Jkd
         W9C1Sz6G7shKH5U1M8kbiBE6OgQDySs4MCSjBmrQqu9wSo9UlV2qE/T+bfMdQ+GA5fU5
         r0f7O+Yx5nywRv6ffU3HEQ4x2mFkftgZJu4dvT7m66Afx1IY4sR/aYG94t4t1bczeWFi
         mZHgp8AqWv99yVVShTVN2KQTRP9ugWMbOdhS++FaWnokQ19pN6smKvYZi51G1H5Ozps5
         0+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851127; x=1793455927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=omgrSic2KLjMrLZZbtwQ3YwHx++WmaKxfutM1H2Pmtm1jJOT9twZDLBIKs44YuH4EF
         6whHe2fc4U/7jjWpj60b5w58tM/C3zV5fn6KvWF9MQVB2UDG3E1X9HleMdaIcLLHdBa6
         iEKxiyANEtJht0DW355eOrnYjj+1nziTMvfSQYCP/V/mUaQfqjh9RlUKV410u5sB9EiM
         iVcrO708OBtz6cFn9S5JJ1l59VS9PXLXpzXYSm4zSDJV/iW01ofJcAEXsq8VKNtmFbAu
         6p6rOhAB9hg8RNMtu0L9D5ivUSVsYN2KMdWZG8wauAD4SL2D13WYYLIIj1mGZC7/qbc2
         L0tg==
X-Forwarded-Encrypted: i=1; AKwUvBy/AelvjcL7cn6zldQ/lU9gdLC9Lov/1Ro2Hf2W584h7ltkda/G8wU85uCadPq1ukTjNCVEHSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNic3+JZGgKmOea0KPBw4TabdtomYXjObqJQdUGOY374jECC/a
	3X36w+R2FyjcuRo9LfVTRL8z0O7X5bWigzl27G7NG8DwM0Ul9mKPZJe7
X-Gm-Gg: AYBFou3br2+8BWhqV02URCt+KaJ4D1lIcIMCzHfDToNpQzXbRwbxyMuaNkibMRdZeS6
	aafnkNnYgVrqAzNQsWoRgjyRV7/HxkEKhz2GmFo0P7dCEbzHJ533cPNPTT+6IBTqMYwnnuHZDPh
	awkzLEyWGyTE1nZh80IVbB/Ym/65GaTGlzyX3sBTEujG+Jz+KNWf6IchL6CLiMmlikH8/4c0OK2
	aqDkATAQDAcAaZbtC7lvWE4tmRBA1U7QH/ML18GgkWeVRXhIKcwQsdgw3TQ1NO1MnSfONsQOw6y
	gmdwGtlOL2hj+cJwV2Z64DIkJpwgAv7MR8LFmdlwVX7rebCJzZswA4uGumu3JbkPcW1boN0ORrw
	DRhp6TlLyLdG+Yk3plQ7ftPQma09m4yr+zYtW/72wLCZZS1+sGTaQQoG+4GN1QIhyN6diqnPEA5
	rc6kpzGS+5n3MTUQkNhm94NUiwTXAscK0E5O70e8cD/f88DCDc1WXkHQG+uAUbADDygnBbWBaqJ
	kydHZe/PWimCzTFBoyUwUxPQtnp/lis6RjdCqvZMk+esIWS9o4Y4E9DWQKtqH6B0A3wql/LqYl4
	sJ+YAVsqOf1G+7cICtPhFbv7
X-Received: by 2002:a05:7023:a8e:b0:14d:c9e:a356 with SMTP id a92af1059eb24-1993571a2eemr3465311c88.12.1792851126409;
        Sat, 24 Oct 2026 07:12:06 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:6887:87ec:7e6f:2a79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm6366905c88.12.2026.10.24.07.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 07:12:05 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v2 0/2] xsk: fix multi-buffer TX software checksum
Date: Sat, 24 Oct 2026 22:11:55 +0800
Message-Id: <20261024141157.59301-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261024091256.17918-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
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

This is v2 of the AF_XDP multi-buffer TX software checksum fix.

v1 was a single patch containing both the kernel fix and a standalone
selftest.  Review feedback asked to split it into a 2-patch series and to
reuse the existing xdp_metadata selftest infrastructure.  v2 does that.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

On a checksum failure the packet is now dropped after the descriptors have
been consumed.  Metadata validation makes this path unreachable in the
current copy-mode implementation; keeping the defensive drop avoids a
retry path for an skb that is no longer complete.

Patch 2 extends test_xdp_metadata instead of adding another test harness.
It reuses the existing AF_XDP setup, packet generation, completion, and
verification helpers, and sends the same UDP packet both as one descriptor
and as two descriptors.

Testing:
- final exact-else patched kernel: xdp_metadata 1/0 PASSED
- same-config unpatched kernel: checksum mismatch, xdp_metadata FAILED
- checkpatch --strict: 0 errors / 0 warnings for both patches

Changes in v2:
- split the kernel fix and selftest into 1/2 and 2/2
- reuse test_xdp_metadata helpers and reduce the selftest patch to
  86 insertions
- use literal else and unlikely in the checksum error path
- document the drop decision and test it on patched and unpatched kernels


Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  22 +--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 126 ++++++++++++------
 2 files changed, 100 insertions(+), 48 deletions(-)

-- 
2.39.5 (Apple Git-154)

