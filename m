Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794089150;
	b=cUYkSxxwrXM437njKX4MK9eQdkWV6dutMyfkH97o4HlwUHIS7gZ8G+gHPPqkRlQYu0ue
	 4JvtIVOZTmgXN48kkHPHyPDrxMPgrbstT9gawFdEgygpM3wcNZSdWV/U9mkxDPcdaHkTZ
	 uj3oLHzkTWQpVayRlkcThauJWD9CSjRhMtfzNwHqzY8zxKUWmX12T0+cn2d+pVSLuBdMq
	 +lWr1lGu2k/5kcrVtPD4PviPi4DmnSLPwcJZ+avwsAsW/0EJ0cjNfL3IfaZpzlxBQtgIk
	 aP83nue6dfNWJDbz734CUWOf/EYysQLLlimTYrlKxZwp9/DHLEDBKAoWFQLNMULn37g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DkAVpPVqUaM5/OO3qyebRlx/+ki6XiRI4yS3tN5o7Iw=;
	b=LooFi+CleQy0R21yoowLQYfxSCTfBoXt/bhDPus2W7whA6jy+jCs7VK82QpqVTtX+so/
	 K1wTWbm/vMUcF+h2zNtF46X1swvO3tYq5T9dS+UOjmHmK20ctF+GTyj7juRvmIWKg8BUW
	 Y7lCwx+2Iekd09d+jFzTR3AcJh4LvvvBf3T6e8qNsrYPoRZOTdUxsDbWkgUPvEec0ObJD
	 AVhadjUc50gciZw8iI2K6QCQbTCnDB7x2WlzIfvK/i6FVHzozJ5TXT6hXiRsoB6sTk4Ou
	 i8QGUCONk3ZTM9XVHOa3+IEnorjUWXik/AcQdms6IHMrZwN/reiDG5feoTT4gWMS6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cf/E5vZg";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B11606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B11606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cf/E5vZg
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso121655e9.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794089148; x=1794693948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DkAVpPVqUaM5/OO3qyebRlx/+ki6XiRI4yS3tN5o7Iw=;
        b=cf/E5vZgfvjBwwCDczap2r/I/PH8rQhSxiTmwRRidMM58beSJpz4ghZrfQdCEMSJMe
         zAzZn1erHUBe3bnncnBAbVjvIutmZhBnFec9lrbdefhq/uvMukhqlZa4CvGQ3x85+9IF
         1I7Z5StSdDfqr98h1c5p0mqmRWtoFpjd65JzkPQgjr4JyobBktGm+YtpL6qGncV3F0n9
         IecC6vXl4cAB7BCmDdxPptJU7mI5p7BIWSFzQfK1IPYZMpn7sCCA6aKMFuZdPy2DXfO4
         NmZMICLIbmqv4/k85A7VsTcPAQBXoV/Mt6mZQeg87BCBfGD1ZsWzTO4BNce5XN46x45U
         b/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089148; x=1794693948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DkAVpPVqUaM5/OO3qyebRlx/+ki6XiRI4yS3tN5o7Iw=;
        b=kPjgy6HsJ5afITVEgpuDyLEVY3Lxz7SrmtnvZsYnFXu2lviK/67MHL4aLtuGTD4pOL
         bEJzf0UNVAiLX720oS+KJHAmLjC4ggOBVc2gyfGtaX0/N8OFDRAkzDXmkjQJUiTAjmQU
         RWMQxrVWyjbbniRb0Epx0fpiK/4epAVE1at6f9ayd0ct9ybFuGaRUyf74o2YP94t5fX8
         2YCjhGZjR1WxEWGrOUMIPnSW8ZBnHpEq7c/Hw0ybJGWLimrQceL7CeTCZAyEzZBzrv3v
         tJXCdSUUiKomWAGdAGoxqiidbLctCzGDYlM8wTWe7x7vITeswZWyM/CfT3wihaQUXbAF
         NxMw==
X-Forwarded-Encrypted: i=1; AL+hErFfBxRIzdyrthfzLea3KCsTBZ7XIRe+3nFL418u/bnattcRVBuNwYgvh4MbwhWIZoyMNyNTVhM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AZOikF+P3nsMSQEq+4q1Na2wln7zLcePc0Q6woxx6CaxaOySU
	ZKPFV53o2FmBTQX6THUpZUk8VS4IYWKdlHNf9IgSCRGUX8hU7PzGXDNX
X-Gm-Gg: AYBFou0/26o7Rw0M3YfqoF1qySS3RR6yhoThjWTcwz1f7tNONYG2YaIFxQhBtZrfNMW
	PITVDoWRatesr7rILwrQ5yPJ+7G6LtG2bMWjb8UKKB+jPghd01RWgIjL6zHjtV9bTA4cioZn/FM
	xHRZ8QSCtO2II7+VE4zP6KJg8XBKr2oLSvEQ23ZIP5kX58KFe27sIN1kAsOhqav3rLFzcF9zcD7
	brG4TN/Q5V62qAXrVp6xi9O4S7Z8zj3/QQg8H18j8ma+LPyo5kbNflYoRCD/xuHjH3wE6dtx2LN
	bzYEInZQazV5Y/rZAXXhitlGtLEUysgqKKE4lv+gO0oADRPmUpKpBz1JyNfz+Z6P8x0PsT1CZZk
	ELdxFICdCyuYZnfwuXS44/EKcZ2FRjn5VEWVtxc4AO+pA9tkyTIcCtcylO3dsXUm6Vgl/wkwHmA
	vbIMY3agxSzYSoFkm3HIQ5aibttHQ61uT3ZjTBs8VtQy3rPjxs79Gc4/UHICqaONbaK7t3NgdXq
	GbfjLeKnG75hj6jyZMW1lQn6aRy9ajZimyEap7ITlbCzhcIvjvHdgV6Dxhi8hYANC6O86nn4QKd
	d82HRLuE9mmoq5JvkGM1yLi220AjLHH1CqBznJvWfxYsvOqtHferC0M0XzB4D9E6zar5agMLyGn
	1c49h4VHOhJFnru7/+kHSIlZqCPNuOaOZEh6QkDXvEa3VJWAvKuien7hSyqCTwJMiOBkbecHtGu
	ioRHVATI7F
X-Received: by 2002:a05:6000:220d:b0:48e:eb:56a5 with SMTP id ffacd0b85a97d-49583dec0camr553117f8f.4.1794089147943;
        Sat, 07 Nov 2026 14:05:47 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-077-189-161-157.77.189.pool.telefonica.de. [77.189.161.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597b1f969sm358958f8f.50.2026.11.07.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 14:05:46 -0800 (PST)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com,
	lukma@denx.de,
	fmancera@suse.de,
	danishanwar@ti.com
Subject: [PATCH net v8 0/4] net: hsr: fix super-packet forwarding
Date: Sat,  7 Nov 2026 23:05:39 +0100
Message-ID: <20261107220544.20-1-xiexinet@gmail.com>
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

HSR/PRP requires per-wire-frame tags/RCTs and sequence numbers, and
duplicate discard is per frame. RX GRO and TX GSO can present multiple
frames as one skb and violate that assumption: a super-skb is either
rejected by a constrained lower device, or forwarded without valid
per-frame trailers and sequence numbers. An oversized PRP aggregate
can also truncate the RCT's 12-bit LSDU size field.

Patch 1 keeps software GRO off while devices are direct HSR/PRP
members, in the requested as well as in the active features. Fixed-on
or driver-required GRO_HW may remain enabled.

Patch 2 refuses bridge, bond, team, OVS, macvlan and MACsec devices,
and devices without an RX handler such as ipvlan and VRF, as HSR/PRP
ports. This closes the syzbot report of recursive seqnr_lock locking
through a bridge whose port is a second HSR master. seqnr_lock stays as
it is.

Patch 3 segments valid GSO before per-frame processing, so each wire
frame gets its own tag/RCT and sequence number; segmentation runs
outside seqnr_lock. Patch 4 tests member GRO policy, port refusal, GSO
forwarding and local submission order.

A typical GSO source is a container connected to a PRP RedBox
interlink through veth. An existing TCP/UDP GSO skb can reach the
interlink with GRO disabled:

  container/netns                  host PRP RedBox
  prp0-peer ---- veth ---- prp0-int (interlink RX)
                                  |
                           split GSO into frames
                                  |
                           sequence number + RCT
                              /          \
                           LAN A        LAN B

Compatibility with older PRP senders:

Valid PRP frames from older senders remain supported. Some old Linux
PRP senders incorrectly append one RCT to an entire GSO skb. This
violates the per-frame PRP requirement. Patch 3 drops such intact
aggregates when trailing bytes extend past a known, nonzero IP length;
zero lengths and GSO_PARTIAL are not covered by that check.

On virtio-net/TAP paths, disabling GRO_HW in patch 1 can make the host
segment an old sender's malformed aggregate before it reaches the
receiving VM. The RCT then becomes transport payload, which the
receiver cannot reliably identify or remove. Upgrade the sender or
disable GSO/TSO on its HSR/PRP master.

Validation:

On a lockdep kernel with the series, the GRO selftest passed 15/15
and the ordered selftest 5/5. The syzbot reproducer reports recursive
locking on the base kernel and nothing on the series in five minutes.
It needed one adjusted ifindex, because the caif device it counts on
no longer exists. Down/up of an attached veth and detach of a veth
attached while down hang or hit BUG_ON with v7 and pass with this
series.

W=1 allmodconfig and allyesconfig builds show no new warnings against
the base.

Based on net fafbc4051123 (2026-11-05). The series applies without
conflicts to net 30c71476d842 and net-next fa5196392691, where net/hsr
is identical. The net-next conflicts reported for v7 came from the
sequence-number changes in v7's patch 2, which this version drops.

No stable backport is requested here. The remaining HSR dev->stats
races are left to a separate series, as Paolo suggested [1].
Pre-existing shared-skb mutations are also handled separately.

[1] https://lore.kernel.org/netdev/4fc3b9f1-4bef-4b34-ae7a-e89037cce829@redhat.com/

Changes since v7:

- Patch 1: also clear GRO and configurable GRO_HW from wanted_features.
  veth adds and deletes its NAPI instances according to the request, so
  the v7 split between requested and active GRO could hang
  "ip link set down" or hit the BUG_ON() in napi_enable() (the critical
  NIPA finding on patch 1). GRO is no longer restored when a port leaves,
  as for LRO; the comments only claim GRO off for direct members.
- Patch 2: replace the ordered forwarding consumer with a check of the
  port type, as Sebastian suggested [2]; seqnr_lock is unchanged. The
  rule is by device type rather than "no lower devices" as I wrote in
  the thread, because DSA user ports are uppers of their conduit.
  Dropping the consumer also drops the review points on its admission
  limit, supervision budget and PREEMPT_RT behavior. Narrowing
  seqnr_lock is left to a separate net-next change, where Hangbin's
  patch fits [3]. Ports whose RX handler is in use or not supported are
  refused before any state change too, so a refused device keeps its
  GRO request.
- Patch 3: segment before taking seqnr_lock and number each segment
  under it; the lock moves from the callers into the per-frame helper.
  A still-shared GSO input is unshared before segmentation. New gate
  drops are counted once on the entry device.
- Patch 4: the GRO checks follow the new policy, including the
  requested state. New cases cover down/up while attached, attach while
  down then up and detach, a request while attached, and port refusal.
  From the NIPA review: CONFIG_MACVLAN and CONFIG_BONDING in config,
  captures scoped to their case, read-back instead of ethtool output
  matching, PRP trailers decoded only on PRP LANs with the kernel's
  fallback, capture sockets bound before they receive, producer errors
  not hidden by the barrier, INT/TERM blocked while namespaces or
  handlers switch, completion on the expected frames rather than a quiet
  period, and only the common prefix compared where supervision runs
  through the lane cutoff. Unused code is removed. The helper stays
  standalone instead of using net/lib/py, which has no in-process,
  namespace-bound AF_PACKET capture or stop-after-failure TAP handling.
  The remaining low-severity remarks are addressed or went away with
  the consumer.

[2] https://lore.kernel.org/netdev/20261014151838.6RyMIRVM@linutronix.de/
[3] https://lore.kernel.org/netdev/20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn/

Previous postings (earlier design, newest first):
v7: https://lore.kernel.org/netdev/20261009201324.17-1-xiexinet@gmail.com/
v6: https://lore.kernel.org/netdev/20260809121455.1745-1-xiexinet@gmail.com/
v5: https://lore.kernel.org/netdev/20260807140751.1351-1-xiexinet@gmail.com/
v4: https://lore.kernel.org/netdev/20260803222211.877-1-xiexinet@gmail.com/
v3: https://lore.kernel.org/netdev/20260731090224.18-1-xiexinet@gmail.com/
v2: https://lore.kernel.org/netdev/20260724161253.79-1-xiexinet@gmail.com/
v1: https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: keep GRO disabled on HSR/PRP ports
  net: hsr: refuse forwarding devices as HSR/PRP ports
  net: hsr: segment GSO before per-frame forwarding
  selftests: net: hsr: verify GRO policy and ordered forwarding

 .../networking/net_cachelines/net_device.rst  |    1 +
 include/linux/netdevice.h                     |    7 +
 net/core/dev.c                                |   15 +
 net/hsr/hsr_device.c                          |    6 +-
 net/hsr/hsr_forward.c                         |  154 ++
 net/hsr/hsr_forward.h                         |    1 +
 net/hsr/hsr_slave.c                           |   94 +-
 tools/testing/selftests/net/hsr/Makefile      |    7 +-
 tools/testing/selftests/net/hsr/config        |    4 +
 .../selftests/net/hsr/hsr_gro_superpacket.py  | 1376 +++++++++++++++++
 .../selftests/net/hsr/hsr_gro_superpacket.sh  |    9 +
 .../net/hsr/hsr_ordered_forwarding.sh         |    9 +
 12 files changed, 1668 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_ordered_forwarding.sh


base-commit: fafbc4051123d5459ea6950899cec08ed946e278
-- 
2.53.0

