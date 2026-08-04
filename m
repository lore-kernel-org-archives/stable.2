Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0338734A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834068; cv=none; b=N58F2Erf1jKj5AW0FQmEC0TVvx7DR4yF34jd9ELeL7wPDt+VW8dUxTGLz79PiXRbvEoB+sodJzLQHvrj2kJWYoijpE8cmkcEhtZ1jTvKEIqdgHK5PPCE0obNmDjTaJEATsXOndGpuVXNhR2A85BWLymGNoYUiJUTqfbLBFqtogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834068; c=relaxed/simple;
	bh=C0712y9v+3Cnwu+fzKHEe+5eb6C88dqmH0oQugUbpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3Oz40cOVvVvUOS7k2Ibh8+Iiy7KrGLjL2+Mk6LRt6hCrSxLageduDtPZfQGz+IiLYs75T5pobRojhHTYkZhQr52iFtuZycqifUSgTKOAop68PuMSnKwFOo5l5TmXdM+DzLss0ln/hQGZSFfH0piwIYe5Bb0VlY5fNUZQuaCcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQZ+GzIi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQZ+GzIi"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485ab7c382so457571b3a.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785834067; x=1786438867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=nQZ+GzIiXL/jZF6WMNUPzVKlyAAEtNZN4Laj49AN6olWefgWC8fEV3f4AJOxpehBRj
         wBmQ8hvSp5LaIZzu7odBhxjS97zJMm5WbOtcqU2OEoezkbGucZ6QLPmeo4JCAq/jvZst
         XOK4I742F16is1I2bmzUpWTMcZz22/QiBIn3yZjmUB4zrEUsdp0lno/DQgy8IcHdRrvh
         AcM9avYZ+OEpjO71TfsHpTBlto+w5hwb1T4/dFf1G4zjOCf9C7NuzxoKdQXus2yu9kOW
         If1Ys6B+MxLug3HN5pUoM1XYAhZGXesAOjxAr3OeWVM3xEsRaQJ5qsRVabvlVv3lcL0+
         /Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834067; x=1786438867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=hqpynYBneoRUfdnVHTy0JgDJ1UOPU7HlWsSEEe4LwdVPuvL0W+Khpcn5+klTEXwh67
         7E233RGwGLsRFpLOViMOHyvOx9LiVVCIZKRCxfEZrgY0b+EO5U8Db2zco4vufI+Tadv8
         lqj6luTSbIHIbLgPSpu2DaBWumHFemUPUzo7eVMG2tLiky+srSYe4f89FwqGjbqaZ0OX
         VhIXF3tK0oeq9acr5WP17t+65RIv8J9+ZDp+KrrsaoptNS0D6pmZC21f1o0KW54iYNz/
         u1eQPdpsVlwP7ViBfy2zT+FyBhIssbnlzMiuH/NoY6KoL2J9bJgp7iF3aiGKlfbYrs/1
         07RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrF1kQ1sObv51+MQK0osOFoL/sAe3oLnKY6nSoU3gsdbpeQYj3Hx0xk12D3SM3A55w+4lvjUmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO43qwKx2ZMGgKf/T+EdWl6oxHwfVsa0vKzb7fF7tUHin+lzVq
	m7pisXkq0BGepyK1JKisEdoKtrnZOEXxXticXg5rC577mPBDIyoyrpxk
X-Gm-Gg: AR+sD10VnOCLXC5LtXs6ehiGMIcqX3K3kvxQejHYIEs4iNBNL3+jZRPAve9GVzmg3xr
	0czYphv8w4OEYSmcCd3Bz1FyIZ0VOXYi5ocZglGPWCO3s1wIZidnhvxS4FSTtki3vqKeWkBuB77
	fswuaVaETuUWxtF3ZYDbDSh9aSzJtR+4qznjKw8hODa1JMx2e84YzRSJPqKlbxbR9N2WVnWgMgs
	CaHc+y3U2OMN4SOWrooG7nohEf3sWXkpQ3dlZ4TmclztG16McAIF20pt8L/4wWMJLC4VT5HuoGo
	K7cpYiTeuguwjH5zZ40pdK+blk2WWMm5/q4aP0Jed7vJ9YnzNs08tGj1/8z49qftUCUYjmauiQa
	67xfdZniILnAlpRHmbdR0jdP5Z/0D+BTOzNKxqBkdKtHdf5pCeHLyvcuTK1Zbxixq+8BtA7ZtuB
	N5KGaUnw/npxfqhZWHyp15YIboCx683CmBiuMwhvaHdU0FNWDeXP2iOot4WNanPhxlXqHDbUO68
	ftHJejY5lV/xEoH5bXCV5CKR6aTBvNbShuJN/wLBElGwjguSa0=
X-Received: by 2002:a05:6a00:bc7:b0:84e:b5a9:ca3b with SMTP id d2e1a72fcca58-84ee4587f4emr12275640b3a.0.1785834066642;
        Tue, 04 Aug 2026 02:01:06 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm4813032b3a.41.2026.08.04.02.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:01:06 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 0/3] net: fix hard_header_len races in packet send paths
Date: Tue,  4 Aug 2026 17:00:13 +0800
Message-ID: <20260804090016.33353-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

The packet socket TX paths read dev->hard_header_len independently for
skb allocation and header construction. Concurrent netdevice
reconfiguration (e.g. bonding device type changes) can change this value
in between, leading to mismatched headroom and copy length, and in the
SOCK_RAW case to out-of-bounds writes.

Patch 1 removes the CAP_SYS_RAWIO zero-padding branch in
dev_validate_header(). That branch sizes a memset against the live
dev->hard_header_len while operating on an skb whose headroom was
allocated from an earlier hard_header_len read, so a concurrent increase
can write past the reserved buffer. Removing it first keeps the later
snapshot fixes bisect-safe: they do not replace an earlier skb_under_panic
with a silent overwrite.

Patches 2 and 3 snapshot hard_header_len once per send and use it
consistently for allocation and construction, in the non-ring and TX_RING
paths respectively. The separate SOCK_DGRAM consistency problem between
hard_header_len and header_ops->create remains out of scope, as noted in
the commit messages.

v5 -> v6:
- Fix Signed-off-by to use full name (DCO).
- Add patch 1: remove CAP_SYS_RAWIO zero-padding in dev_validate_header,
  before the snapshot fixes for per-commit safety. Suggested by Willem de
  Bruijn.
- Add Reviewed-by from Willem de Bruijn to the TX_RING patch (given on v5).

v5: https://lore.kernel.org/netdev/20260730082925.93759-1-q.h.hack.winter@gmail.com/

Qihang Tang (3):
  net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h | 11 ++++------
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.50.1 (Apple Git-155)
