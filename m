Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738609;
	b=MU/ge8Tyow1wQcKvKfV7PHx6XOsr3s2kP29KxeZDOI/ncsPQE1uz67oiafDFkVkEQGUm
	 UMttRbkpgcMGcoCCdhz9wmP37Fuga2wJw4WdJM326aDq+C6FUURRHi7VFzsqOFaQwZAE7
	 8nT2qfyF+T/TbkWaD2cj+/mTpm+hyESgZJ/4JoLN3CzY7ai2i/O4x2kOgH4H1tL6+dPuD
	 omiOYdmwj4eE469ymH+nISsPgMpmN+mejxWYR/DxH34qtbHfwTDyrkxUgirIuqq1Bi62c
	 VYiRY771//jByF6Q2iTIWYPQbK4YRpu2j/UWOAvmXooJ9HYnprCUwbQLle2hbhb5Z2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DaucjX7EGKxhjPytfA6PE6Q1xmcvizrq4bihC56pvSM=;
	b=pDzPcfS165BBk9FVMk51DeshEnOh3xND9y/vDly34z73gvWrRsmeoUo/79FFgIb8cDrR
	 IzJTR0y6Ot3wQ4C7dqFhpE3vJeuYI1cNEMR3tLAtszW4zehxBeFtSL94J2ldWy5XBgiCO
	 85nno0MLCGd0scQJP/sN+ahHmwKHzmZ4t4Ohc3IQgF5UokhLgdThrY10/3YuoQ1EoL/nj
	 ucGNd8bhQKIOFRr3NxYeKGYpgcC5pUQqUrg35XrKF5+X8KvvHLCjD7rLJZCg8HnpTKEr6
	 dUpn5f5iqDEYIVQZkOe2hPVLsBdoBK4+FhFsSUlJiWkWmecT2n94tC4R//e/vvdchTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwLIWbsQ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BF606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A6BF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwLIWbsQ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso40557805e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738607; x=1796343407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DaucjX7EGKxhjPytfA6PE6Q1xmcvizrq4bihC56pvSM=;
        b=lwLIWbsQhHcHN3CDna52sVsq9gSO9DJklq6bzGLe3Els2E42gC4pjSTwi8CBXWLj69
         Y6xmDtc6vsito++1VpPJRTsurb0wgyvDhyMIg+LD/l26p52SEGOkBsnM4H/sadwjMOqP
         yqZVtUrGQauUYqpHZDGlRuUHH2sCLzuOyxWAaDjFw2nfdIdTw3taHA64sqf7Z8bP4d13
         8Z/U3f1HmgsK3yj/WRRhDbndUus2MBgUPvB2KPMI6ZVKHsF+COYApylXIc+drZgLM/Bk
         Ed4rW/K8emw3n7dCq2ap1AUGQmklHOyJbD33q+73qeC/NDNq5fnm2CwdYHjz+hEdCPim
         22Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738607; x=1796343407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DaucjX7EGKxhjPytfA6PE6Q1xmcvizrq4bihC56pvSM=;
        b=1FHQ1CSaEKoWzuc0wq+JXvlEprmXeZ+Q+28+vFW0qlRKJeiLncqn/PxY4jw+BqWfjw
         wj2cxmcsY2rrDaeK607Mkq5prUpbw3opX56pclKwvxzNm7dipA1qikvLGaEFYslYv0tn
         oR3mOnvAcHgle+pD3L7rZerJcFAhTCvg4P2C8ujTt0H+zkyVVQT/mu6i/vvL3Seuhol0
         SWNv0oOQnssoDuhU0OsChKlC9qbZ9aBWa/ahol4hp62I+J3esOsBh6ZO7ZrpUICI4Z20
         +VetF0ECi9AL7TCE72fThDOZ/yuvBqveL5YiBFP0W9UtmxCWMJ2yjMOVJwbkw3gzlxFF
         btIQ==
X-Forwarded-Encrypted: i=1; AL+hErHynzcOGFHjgIHaxUB/WB0oIhgEq6VHW2LHV0ugk+9JkUj2LLDC9y2G8FtqgZB3xfFnDJS4QkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CfwAv3fMopt/HTw3XDeIHcl5gHtazhKC5GHA2hmcMCTR52a3J
	8GX3v/sUyDs1OllXkZI9jfFSklEhGmvvm6ti/GOPqKuAFnyrjcNHi6k=
X-Gm-Gg: AZFdTZdRKznHpqEjPize24byVE6gNj6dxbM8NAZX06HgVSHQ1OMKKWq2rm/vbKi0Q9L
	RdJE5EJ1SBc8Bat1JBOd94ajziJPhnty8R99QeJs4UY1oUwibYALRXwVnHwOiucHStfTLmAkKBL
	s1UkGN6L9ijF7L33m94aKua0Bw6z93b7vmmX/Q9ITeQKUa3FGEtjcU6MX0zkt0q0kKPs9TMvMHV
	PkzWRJmR5p4fd2Wn5aXmsH39EEz5zfPugzn2B5PIyLS8mA/iku/Av80DhpUgYR4BvxeBaFBfP5v
	XlPAykpvNtNBefnOP2RhZa23b58YxInXT+q9Ah1gvyXa0eEPMGeTtYryAhlKmOlIQArWCua5ncS
	v+BTg5Frs9OfmMsaV/SBEVD3MfQJMXhHprRSzYOPrx/F1w3z5trKnVTTfGfZHCFEC7z7wLigWFM
	rFREI5LeG3qKPD9uVnkEKvaVz6ubeLK6KqFIF7FET0DUCtG32vWCIBMaSF5n/F+Tm4YZW1lat0z
	qTUtArgmZMwhkVjf0CQWgtR+v1xI4A/Z/syM1ZsOh7bteW6RzjKf731UPJ2WCVOczXk2P+MfJzZ
	HEy52wYJTbsCtig=
X-Received: by 2002:a05:600c:3f0a:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb8880cde7mr439388735e9.22.1795738606729;
        Thu, 26 Nov 2026 16:16:46 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 nf 0/5] netfilter: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:32 +0000
Message-ID: <20261127001637.1026589-1-tristmd@gmail.com>
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

Five netfilter callsites read file->f_cred through the
sk->sk_socket->file chain under RCU without pinning the file reference.
Since commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU"),
the file slab slot can be freed and reallocated within an RCU grace
period, so these readers may observe stale credential data from a
recycled file object.

This series pins the file with get_file_active() before reading f_cred
and releases it with fput() afterwards, matching the pattern used by
the recently merged cls_flow fix (commit 59cf9e6f48e5a).

Changes in v2:
 - Switch from get_file_rcu() to get_file_active() per API change
   (get_file_rcu was removed; get_file_active is the current API)
 - Reference merged cls_flow fix (59cf9e6f48e5a) which uses the
   same pattern for the same bug class

Tristan Madani (5):
  netfilter: xt_owner: pin file with get_file_active before reading
    f_cred
  netfilter: nft_meta: pin file with get_file_active before reading
    f_cred
  netfilter: nfnetlink_log: pin file with get_file_active before reading
    f_cred
  netfilter: nfnetlink_queue: pin file with get_file_active before
    reading f_cred
  netfilter: nf_log_syslog: pin file with get_file_active before reading
    f_cred

 net/netfilter/nf_log_syslog.c   | 28 +++++++++++++-------------
 net/netfilter/nfnetlink_log.c   | 35 ++++++++++++++++-----------------
 net/netfilter/nfnetlink_queue.c | 35 ++++++++++++++++-----------------
 net/netfilter/nft_meta.c        | 16 +++++++--------
 net/netfilter/xt_owner.c        | 27 ++++++++++++++-----------
 5 files changed, 72 insertions(+), 69 deletions(-)

-- 
2.47.3

