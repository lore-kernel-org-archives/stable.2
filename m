Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218863;
	b=br+fQAzOWtds9ryrfhzKPs+x0ef6sGV9810m9VoOxJEhFfXNaQoNZ2PHut9tuR+FTG+p
	 SfwspyTN43cLF40cU3wuMTsVOXQ9R54At5QrWI3iyiJpjxmxahKef2dRiXHo0FpEY2OAx
	 MtNUvmrxhYcoc3FpZalcEFBLQUx9hfLc8IhU7RXHQne3pNdSl+7p1UQJU5Sd52RxTcsWy
	 ovCn/B4jwQaDB2iS4G7r60kZbqzHz4+22u/LB7QkB/DPXbEXi26tpgHdDVFz+61o76Wev
	 61CtvkoErFehpCX0uGaBYE0H835XhuxKlnd3sAV6hV3U5dETfrW0lMO484AwjP3lvrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7DqEQVPhr6GusklbRo0OOnhzJ3BLe/1hpOgbosdDgc0=;
	b=G7S7sftLXFaFhxrVhzb2OKa90sj8QUiaeEJhyAe2FrK3AsC3osd/sPHcMiByvMr6eNhM
	 Al4eelFQK/s6JTkM9Rr1HfrjWNGas9Up9ceo2iZgJLOX1V+k883q9CFUqsOF8t2e+WDu2
	 pUoEmHcsJcH9AzH1V7NdMGIP57WH18mozopioC4g2GVxHUwv9r5Kko3fwMrfqPDsRvCJ+
	 wFC7JMu9J/v7iW1MBgs6wZ7y3QlXBM/zjXYqSBo6FjbshxCNNMUqoSSikhL+D+RWVyHH/
	 H4jMv5K6zU0EPLPMdcKdO2GUS5JoIqNg9p6tdu1ozTCCLeP+byCn+6WaX4DzCC0bR9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKhq0UOe;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996C606A699
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6996C606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKhq0UOe
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so11463755e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795218857; x=1795823657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DqEQVPhr6GusklbRo0OOnhzJ3BLe/1hpOgbosdDgc0=;
        b=qKhq0UOe0Qr2kxLEutjuUqpHAhrmC9Dqv3mB07Hf00AC98Ax8lIaMxr8zNBLDU/E4E
         mXzB8JthOrW9YmCtE0y2jdUaIPsWArhdL55i7ckNMG1WjkNiz7MHODhxNBZ8Ng7VcnGC
         RbqzhhCCqfPTbus9VFMiXzypMmdB63oB8vU1xvcnAn0zqSfwMEdduF+QjijZjJkCdjkK
         Yr911Tnget0k2LKUwmPIIdmoye6tRpRX4a3K66A4mE3u2Yk1xWn1CEciU41lgfLwXOeJ
         bOh5IkQgQYugP19L0ZkLSEPQN/DJMP82NhzswkfKB7+/fbGzigN2Sx7B9kuowQe7wT2r
         149A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795218857; x=1795823657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DqEQVPhr6GusklbRo0OOnhzJ3BLe/1hpOgbosdDgc0=;
        b=2tlOrCWN708F49a301+yWhdN70GRlsqfVGeL6UNCXwwFtYmQ3xkPk8FXMLU/ykDRo0
         DhAcljsnlkCUdmCbCvXlBHlbGB7T2kuKuZW9MiiWjGrb/mSUrfHqYGcJT4qEAtGusuIB
         a/ZArUxTjzMgLRmlt7jLL9yKDTQFgeQcXkLMq39G34k2MAYF3hhs5zSCI8Hol+cePbbt
         Cpptq8LYShxZ4MpoQ2tUXnXt4V+bOfftbzD06D8/u3Yz7FNdQVmLCNBe97TVecXRCtpx
         mvNngIVjElVPfalVJfIY7vszTKKVLlvjXR7zC8nqvGfYoVIFmYEps4OzZpE+sRbWO4cU
         UoXw==
X-Forwarded-Encrypted: i=1; AL+hErGcLWTgwcoUBB4AyM3aMvRbx7POq3WnwnM6Adj6BYni9kOWVWvdfwYg5B+ztWt9RvMSqASmv/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XxTwwcIE0Mzaelw9AUn35kUyrLFX+T1ffbcPfTnx6CsWK/MJQ
	Zn9c0ZcNYgpvWlHQh67qjcjaxpqZ3IQJgn3gS7u15D/rhP2tntl2R/Y=
X-Gm-Gg: AYBFou2NaZtXWcl8oh8OokXb6YPGLR+V3jQKQt+rEJo8L4RI1+cjljQdnG24ImBS3pD
	NobQM0BrLx0vPJx8Yv0G4DYKcpBH31KGsXzPL0jcvDQkHPVy9pgy+063gXHfv8i8y6747AXICaj
	r0xWyTBP0aOI9vy6fvaNXKQR3cacmd6SdaUbLWo3Mihw8D23hn19V9rOXbmK5zrp+zZNvDv3OpY
	QsvhGmdkVNoHvdXIu9v6lq+iSSsfd3Ce+vhpAvp8Tdkr5kLNCYYnSPbUzc/At9UNzwFip1Vr4y7
	FkFdh/BQCeH2egzqYOQ27zE18PJHGYxs49XqQjjBjrd4Pe+BSBYmxmI5ZjVTxXp7GnqWafkN7UL
	JNbqrtK6ZqBgR2G/NxeK5XePzsDAi6iGi6a3aPyJKwOJVLAwIrm94VKjRKUkW3J2ptPw7CzR++N
	xkEE9uPtLqm4s2Gf+9Q0juoAdRB/uAfpfX1WLs0ap8Y5f+60To/De10kZuhENHiuOPWYoJoSSjS
	Z9/ENQUCLh07MvHoJBNfZ5YpPABLfJEk0Wo/mJfBjp3Vddz1+MFuPPDccvn+gzhH2byDUMZC9Uh
	FvJBIG5RFUP4brc=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb8882672fmr115640335e9.6.1795218856735;
        Fri, 20 Nov 2026 15:54:16 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm29426445e9.2.2026.11.20.15.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:54:16 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 net 0/2] net/ncsi: fix RCU list entry lifetime on package and channel removal
Date: Fri, 20 Nov 2026 23:54:05 +0000
Message-ID: <20261120235407.1911365-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The NCSI package/channel/device removal paths call list_del_rcu()
followed by immediate kfree().  This races with concurrent readers
(primarily the unprivileged NCSI_CMD_PKG_INFO netlink handler) that
walk the same lists with list_for_each_entry_rcu() but never enter
an RCU read-side critical section.

Patch 1 adds the missing rcu_read_lock()/rcu_read_unlock() to the
reader paths so kfree_rcu() on the write side has matching readers
to wait for.

Patch 2 defers the free side: channels use call_rcu() with a
callback that also frees filter sub-allocations, packages and the
device structure use kfree_rcu_mightsleep(), and the work is
quiesced before packages are removed.

Pre-existing issues noted by sashiko-bot review -- dangling
active_channel/hot_channel/preferred_channel pointers, unquiesced
per-request timers, and the ftgmac100 unregister ordering -- are not
addressed here.  They affect the overall NCSI teardown design and
are better handled in a dedicated series.

Tristan Madani (2):
  net/ncsi: add missing rcu_read_lock to netlink and device list walks
  net/ncsi: defer free of removed list entries to an RCU grace period

 net/ncsi/internal.h     |  1 +
 net/ncsi/ncsi-manage.c  | 39 ++++++++++++++++++++++++---------------
 net/ncsi/ncsi-netlink.c | 32 +++++++++++++++++++++-----------
 3 files changed, 46 insertions(+), 26 deletions(-)

---

Changes in v2:
- Rework as a 2-patch series fixing both reader and writer sides
  instead of a single patch that only fixed the writer side
- Add rcu_read_lock() on the reader side: ncsi_find_dev(),
  ncsi_write_package_info(), ncsi_pkg_info_all_nl() (sashiko-bot)
- Defer channel sub-allocation frees (mac_filter.addrs,
  vlan_filter.vids) to the RCU callback so readers cannot follow
  stale pointers during the grace period (sashiko-bot)
- Move disable_work_sync() before package removal in
  ncsi_unregister_dev() so the work function is quiesced before
  any structures are freed (sashiko-bot)
- Fix Fixes: tag hash from 2d283bdd5b20 to 2d283bdd079c
  ("net/ncsi: Resource management") (sashiko-bot)
- Include discovery method per sashiko-bot request

-- 
2.47.3
