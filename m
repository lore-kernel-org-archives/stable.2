Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C3EEAF9
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790514630; cv=none; b=HiSf2oq7VEybUcrM3ZHkFAUOJfOZoOI7NgHqEKTF48TLO9ooavaeRAJqNoWnAdjwQ8U2k2wsGqf/EyOigrW6PDLp96QvsG9QNMBxhwy8wo/OdJg3240KojxefbBjic+J8lulMMhbh17Mq5C4lwTLdeyH5HEsPE49sttIQP76348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790514630; c=relaxed/simple;
	bh=HBEZ8gvSuuTPFRjoDeYmiebMx2iMq5KUi9vEstX2HoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYEqYwonc/uLPMNopOEyYLt0oAKnZQBtd3XJLzD4SaUrqXMMNtTxR5MPfH1874q7NlBqlGTJyNJAn80Ji4DwzaERhwYU2t1TTrCgrI0yEwdi3KlzjC1ZC3dTLrv+XD65Hho49iXA1+2/Xw5NI86d1kXEuW+UinnCOtYcgncv1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktd/Ke2u; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktd/Ke2u"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so957358a91.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790514629; x=1791119429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bkDmzZIfjmIBLLdMK74q6txJ55ZXC/oT66ennoBB6nM=;
        b=Ktd/Ke2ulLTbNok0HLAA7F3DBiha7pSO5tXXOAW6iMLuHYuKRH6BT93iJnlgZMEdUa
         b4rIOmhNg3rU8um8FVopGudbry66y1iftvcNVHX96vSI3Ue3z3kkAQuBRz+uEB0WDt5P
         u3XmALWq1EPmZyzjvSsl1oSchdrORzwzJjjCv6lmNOeUriKtPkxduN7dHcN0X7q/CuUh
         HmJ0C2B+bHdnWx1yF6E3mOjXHSKEQJs78ppNz5u8i8vjhmFnr6+4eRrRNRfriXgLIGvB
         DEfGUVx1V39Ib/Wb1xSBoEOwWv24Wbfy0UEBGXbJixB2sTC4h4l+rOWxbQC54QmA/Jtj
         NcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790514629; x=1791119429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkDmzZIfjmIBLLdMK74q6txJ55ZXC/oT66ennoBB6nM=;
        b=jCz2//BgyfnhqI+hp+5R/+L2ew5HajMGzvFAdyAglvTvlCxpa03wUEhi1fgOm93KbE
         vdReBotp0mUNzkcP8P7RxjwlcMJNTvU/jmP3tHlcGNs3ori3m86a8DF+nx39uRXrqkhL
         yuaQoZkIjfr/wO8xYCVnBHt9m/I+ZM/GWmzaUhAiK5NK2clkyTYvAsFd05rrb3xR2VWw
         h3G3e/veOOMpgQH5UO10eYGmWaFVs0gu4ML95+vXigwwfuaww1t0uxOM2hBd7lZHrQk7
         ZPQqJ/oGGWzFWEpjFjPRgUMjnFX0dMz9w9KqkRRv/o6CICA7nllN5+Pu6/tjdpyz7GI7
         OKiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUOFGnLRPBGk2m1s6sXyyXMTnfsLXZyKQxBQB+/xwaam+Wo8wTD80mAB71ehIfTBveI/HIiB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl8jBqPP/SAJ8F06dFYcAu4J5zhBk9uQUkxYbepMnpQEae6tJD
	nRzUStTqPhW+W15Mm2i72DBvI/i360TslRuU6S7jhTlxAUDUQsLcAzo6
X-Gm-Gg: AYBFou34hIUBixip596JAzhfcYFKQ+tCBxhVR6CDEq9xU/mVaddhVhMg6OrcisBFecd
	Sgl6KlQwvDM7Z0oXGC6xtx5MFIlYg3gZqYmy4Jh1o5U0qfzukMAiYQefNLCO/yqS9dQYydUf5hs
	DnlsQs5dGSLUGaseLDqpRZOngadpOQU75j9xQOMAgGXV1suXojuu11yn5+uN8FaAbb41kgIn3MF
	wfdkdAEdaMMgZQa81puNpU27OCDV9jYt6c4PlWUZ/WHrhv1hDOCUuPA4xE30qXSsEWQLstde/tb
	CIy/xXv2xDY6Cb1B2GW579vLytJkE59zihJ3TKQAi/NcEHRPRE7kSs1yQuecQIi8NyVaiknz02r
	QJm6d/0BcPKfwVLiOxZ7OadHNAfEVz3KRthOY4HaEBufb/Tewpyc7EDbQrHxoVCDNtmD8L6Pg8S
	1ui+7zKbt7WlrAq00E7v6H4RVeFlpBV98h3bWSoh0sDNQUNYaga84zdUUBHbK7zASTqMzWbL5Ic
	NZzbDt6dqSzgD/nDy3u90sNmThpJzxKDTk=
X-Received: by 2002:a17:90a:d883:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a098dff5b4mr8264184a91.51.1790514628797;
        Sun, 27 Sep 2026 06:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:84a7:e3d7:8c7e:980a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm14890506a91.10.2026.09.27.06.10.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 06:10:27 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH net v3 0/2] net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()
Date: Sun, 27 Sep 2026 21:10:07 +0800
Message-ID: <20260927131009.24250-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two issues in cake_overhead() that can lead to
corrupted rate shaper accounting or long dequeue stalls:

Patch 1 fixes an integer underflow when segs == 0. When an skb with
segs == 0 (such as dodgy GSO packets where gso_segs is not recomputed)
reaches cake_overhead(), (segs - 1) wraps around to UINT32_MAX,
multiplying per-segment overhead by ~4.29 billion and returning a length
close to 4.29 GB. cake_advance_shaper() then charges that length to the
shaper, stalling the dequeue queue for tens of seconds at 1 Gbit/s, and
for minutes to hours at lower rates. This was introduced by commit
c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()").

Patch 2 validates the transport header offset computed in cake_overhead().
When the transport header was never set, skb_transport_offset() returns
the ~0U sentinel (~65535), which inflates shaper accounting by ~66 KB
per segment. Furthermore, if preceding egress BPF filters (e.g.
sch_handle_egress()) or cake classifier actions (e.g. act_bpf trimming
headers via bpf_skb_adjust_room(BPF_ADJ_ROOM_MAC)) leave the transport
header stale (bpf_skb_net_hdr_pop() only re-syncs it when it aliased
network_header), skb_transport_offset() can become negative. Because
hdr_len was declared as unsigned int, a negative offset wraps to near
UINT_MAX. Patch 2 checks !skb_transport_header_was_set() and ensures
hdr_len >= 0. Both hunks date back to commit a729b7f0bd5b ("sch_cake:
Add overhead compensation support to the rate shaper"), so they share a
single Fixes: tag and stable range.

Changes in v3:
  - Split the v2 patch into a 2-patch series per Simon Horman and Sashiko
    AI review so each logical fix carries its own accurate Fixes: tag and
    matches proper stable tree backport ranges:
    - Patch 1 Fixes: c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()")
    - Patch 2 Fixes: a729b7f0bd5b ("sch_cake: Add overhead
      compensation support to the rate shaper")
  - Clarify the timing and code paths where header mangling can occur
    (sch_handle_egress() and cake_classify() before cake_overhead()) rather
    than inaccurate "post-enqueue mangling" wording.
  - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/

Changes in v2:
  - Accurately describe the impact as shaper accounting corruption / stall
    rather than OOB read past the allocation.
  - Fix integer underflow when segs == 0 by checking segs <= 1.
  - Import companion check !skb_transport_header_was_set(skb) from
    qdisc_pkt_len_segs_init() to prevent unset transport header sentinel
    (~0U) from inflating packet length to ~66 KB.
  - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/

Yuchao Zhang (2):
  net/sched: sch_cake: fix shaper stall on segs == 0 in cake_overhead()
  net/sched: sch_cake: validate transport header offset in
    cake_overhead()

 net/sched/sch_cake.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.53.0

