Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323651;
	b=3II5Ur1Q9IMp7ynHwfCj0S2dQWvkP1Yabq/5QXVKcVXXdORePfwddSauQTOaBJj4UUkV
	 vXZDnGYPQcEsT7tTTurdeugaAKtw/EXuljxAnhhltT/n1t4P8BPf7rqDRLs4diKa83UOm
	 ACEgs1Va0fG//bhORoclJNYJDGp1VgPCrg5adLYydfDu/ZV7XHw9p4t6unc40K9Wd4HzX
	 ITIL/kAyH5JTxPWiTGY+3RbNC/LOMjsTed5INb+Agmctgok152O2knzcon5V2n8BzsExa
	 LShEa/rNicwiH4UVtTasUnBv515uQpTMvOgkaFJYD1YttVu6ylDIUU/v6YegFXvytSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PTKAikpOW4Bp9RpuUyN+Xdo5TM7yPMjwYf3IanAnUzs=;
	b=ukY+0uByYLyKKo0tit3ym9lfHtsayb4KiQHDubzkBuML61WLazht699RYeJRn8+miTEL
	 A+8pcK2vYz2kul0ooSpdcYXM2li+HgSJmV6m1bL4r39XbhTwvVF7vVkEAOLuGa3zkFRwl
	 0i3v2EfKmoXQXNO6JHgCT1gXNBMoc42WLP+mmxioO+5iYMSUTy9WWJQsisBuCh9qcF+ir
	 Mr7Rs8F6iEAJQoUQ1OTOZtPRNYjin8tst+B+szYQRid9MKwAd6GVmabjUrK6w/aaBRi29
	 uV2Y6NyChlze1+MQ4RNucqc0fTEjsZ7U2HUyUEYVmGYwx0e0snCjGo72/Y1+3CHs7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ht4GuGHU;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4060A2603
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C4060A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ht4GuGHU
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67be7b9abc8so1808024d50.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323650; x=1794928450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PTKAikpOW4Bp9RpuUyN+Xdo5TM7yPMjwYf3IanAnUzs=;
        b=Ht4GuGHUahIZlpl8lDxoufAxmKNEqsNTOP4bJF8EvWABgAZjxRTtLS5QuvGR4MMZNw
         O71bgPUaVnF8WVbDc/Wmv2Hf2Bb14R7IjbiuodKnJqPsowQysEeWInw44StAegtnhclZ
         RoT5Mpq6YGL3kmAWRlEiNYVF6imv7sJmTAlSbWvtb5HcuAdWj7IzZfzMVk4WWYSMz13P
         bvftDXMOHbdH8YWbu1wqk/+ViYR7ytGVS7A/UwNTlYbQA5+J76rYDm1vQw7YU128ucpB
         6OS/Tzy1C9KNm+woaLNZejdy0IJze/5M66cTzzytTeoaAEmFIDIpBnDqymJFeF9mnkmD
         /ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323650; x=1794928450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTKAikpOW4Bp9RpuUyN+Xdo5TM7yPMjwYf3IanAnUzs=;
        b=w9a8xe8zm0B+jwXGsP8N2ccTCcLyQc4umw7IKXqj0wT+S361wV4I2ggyhuMR6sdgbe
         yg1/zJb3tkMzIrtI72j6zjbIBuWT03m8wbvnMBmrQEuriFE6vjH6s2Z5kHBDOI30BAhb
         kDP44VTlc5DG14GTSziX0N0K3gxI8gt2r7syl9qpVrm8xYz649P2milZW9erA2JuIArM
         8CFSXsT0TXOhrdGZkf/Nw/4FDvi0qpsc/ls9AEzJuuSpYltoHQqzpYy8Ei4W2rKiY1Nw
         qgvHKtC4QTeIObbAl1FXuk8+cdf5WnCAIe7EnHCRz0G0HOoOlfwe+dHjiOSkqg2hqp5P
         I0eA==
X-Forwarded-Encrypted: i=1; AL+hErEDb6izDpJRUGYhiPWoxGLIFcF0Liu32aB4VeIBTS8BNKPQlBkAssFcYbRoRAe0rDWrBgBC4y8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RPRWbQRloI/gb7wQDAoptAMSE9vuPcQfU5FfP7lMf8sSu0YLV
	hE8MN6qq+zTL7SstS/SuA4RsZ4AALbezBaKYbpMGXsnTOh5U+AqrNQGK
X-Gm-Gg: AYBFou2J0x17dwgRA6fGbw59W7UINX+nVm5azMXhPo53xReqdpMCVUyIXJOU0cKdTjR
	hh8PxtwR03kQmaSbiRtuIbtj+EKVPKtXo6zx8zFJpSNV3DN4BhTjG61rpRRiDZCg8SwHwhNe7+1
	GgfnVeHZ4bBOfdLO7bq4IDFEY3grWVucv7wBFti5O1P1JN9aYMcA9ULgO5bVZU98ei4juBg51Dh
	5ittA+yTxRJdVHNDVlyJBRCzlolI3tQ+oXvmJfP9y8MarlxT+7GMgH6x+aFD0QlbqbG+HrQfEeK
	TwhcSQBwKPa+YbndMUkbASgnkhZiilhvjtI/fP5l8Q7B94HTc/xMXTQpOX0fW7E7up/etVMONg8
	xBjKAY8UhfrL5OnIW784SJQnJZv8gsa9piHyeiRAvybDuSMUme+mqRmMS1NxUY/gqZe4tG1xgn4
	ynH1DPGET/8ZVJRd/iSHKr37XQPkZMAC/fo3TeAfwNAtjjgoGSK6d+HPy9aclcicZHEReJS91CH
	kOpia7NxZSyUyAEkSXc8o5MyfKUaclipHoPIXQe5uRleC+KRw/gdqKb3HXUh5+W18EorfP/uSUU
	I2YdJ1RgdaoG8svVncJ77pMo3vrOaJAoYaQnf86oDvWqZZN9FfJPS0ljRr16FGuUyRyCQSMxdBm
	L76HPpsVR2eXX2mLiRcjRUtxEzZMZO3uF+fRDKfBzEDJNTwh2mzIIf9g02QU=
X-Received: by 2002:a05:690e:488d:20b0:67c:17fb:eca8 with SMTP id 956f58d0204a3-67c56751129mr1182083d50.32.1794323649911;
        Tue, 10 Nov 2026 07:14:09 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c5860c429sm2138674d50.0.2026.11.10.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:14:08 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	ryncsn@gmail.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/3] mm: fix swapcache writeout and cluster table races
Date: Tue, 10 Nov 2026 07:14:04 -0800
Message-ID: <20261110151407.789960-1-nphamcs@gmail.com>
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

Reviews of vswap and v1 of this series found bugs in existing swap code.
Allow swapcache writeout without anon mappings, publish cluster tables
with the allocator locks held, and leave tableless clusters to the
allocator.

Changes in v2:
- Rebase onto the current mm-unstable tree.
- Use Suggested-by for Kairui in patch 2, as he requested.
- Add patch 3 to prevent stale tableless-cluster relocation, addressing
  both scenarios in Sashiko's review.

v1: https://lore.kernel.org/all/20261106160432.2552507-1-nphamcs@gmail.com/

Nhat Pham (3):
  mm: vmscan: allow writeout of swapcache folios without anon mappings
  mm/swap: publish cluster tables after reacquiring allocator locks
  mm/swap: skip relocation of tableless clusters

 mm/swapfile.c | 113 ++++++++++++++++++++++++++++++++++++--------------
 mm/vmscan.c   |   3 +-
 2 files changed, 83 insertions(+), 33 deletions(-)


base-commit: b024a51b0184b1efb6f55b11aaf7b15a490a6307
-- 
2.53.0-Meta

