Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DC489877
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576811; cv=none; b=LQJRFhcfQ9s9bLwNJCvRBAk24FNscNxaHBEnNhVlAU5rOzMoXwQ1lJ3GGlGhWfMpx2pbIGHVESeclVzTku67cF3BLz0IS8i7+tyT1vzT1E1+yPP/HqLpLjqWcBrvgIgv34IwU2UgGDJJx4hZCAE4pq7rTn+VEdAyYOlOyl0kg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576811; c=relaxed/simple;
	bh=VBVCzL78Ra13MLbQJJF8TciSUPmNnFPCNfvbXK94TbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8D3lgsFXksMoSKrOw/bi0XwBLkF4jUBKQlLedv4ONIf/bLhamM88IrYVdBpwOD6r8t8Rz9WMBC1IHNmYL3KbkSA+6KrkqdG2V7W6y5R6eZYLS9Ak/b4nfzCiDoUUsFA8voXQRsz65jHFpoA3cQLu7snzfKruO6DLSEvwEIrU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1/iwbJN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/iwbJN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b06f58380so16897f8f.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576808; x=1792181608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6c98E3bQDB/GO0f+bN2P00CEjl+2+qvBif5l3vTdniU=;
        b=H1/iwbJNg2TfAAn2+qNLuo2m9LEqLr/Vhxp0uO2WHc9PWl5G3ABJO5iqZYOIt6awXY
         BFteL5NPRtRdewYm7H+/9yvRK68F6jX8a7SwYMBfe1mciWRGbtL9pIzdP3WyAjooWOXE
         kbb2qE3V96hGcg0zD//pP/xhaFQ9oZdGNfoxDdwRESLJFlf/KcglmQKoNv6IVpWM68H0
         u1lCy7JECa2FCl0d8ydWj229KZNsHpc7qVc3/TQGOvkOjrX5AX5vMItl48pUS0TwrnnM
         hASi+qjsAt1K1Rwg5adiBvoGX3YoLa7Vykmj0vWaIPHKmFiAI8yuYxljtYkqF5gJu9kc
         iFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576808; x=1792181608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c98E3bQDB/GO0f+bN2P00CEjl+2+qvBif5l3vTdniU=;
        b=mpQ5G0M+FIYWY+N5GJGPn8KvMroX872mQZ8TeLp/cAcEqBvm4ixwfrTv69567CkLq+
         OFef7Tl50rN84OIt9kzK2HO+L0e83B/EtCRwcEJ/jWF+qjq+CxQyNnYzBcHWm3PKXUjl
         iLTeVbS2rQQGQhnmg4V2KMwjofkpYqETwDrj1Yz5ozvUlfjDID3PRuUX4dWCdG8mJFt4
         y5BBikH/ljJuob8cODXg/agaoVfMSx2mwKQ9/Sl+z1QzeCqY1H3nOQhaebWy7oXrgp02
         8L5ppfhoWwgfMyvGhsoKqGUO2m50wKM9NPPS8JhA2qd2XsoYzi0YJCOhCoL7Uu5oQ8GB
         JFcw==
X-Forwarded-Encrypted: i=1; AKwUvByWGeupf6aj4W5m67MyenI9ki70pJFGm5YvJKn/ocNBzkeCa1gw9Co9bsS9Va5FB+gylW57xRI=@vger.kernel.org
X-Gm-Message-State: AFuF++kXu4A+/VT2Cc9Qoxqi3utxIAZuEDJRSuGYoeuHfWe+eALYxnKA
	4pAWqBLhAbkBDsbq1zXxxUsnumVJiGZw2pO+wV92K7H87Anw0K35cNcb
X-Gm-Gg: AYBFou2SOcOmmXgWffr7hHz92ue+bt3Wsqnc3K1Fo0jYLlXqlSqp+t539ZjcRib4b2C
	9OOWJ04UyoK2Wkf6Q+HUszxgkt31x6VUAWSjpeNZ4eWgfpbyYIMLtqp5A84Y63YERuqcmL4hoWj
	UZ05x6FIi05xRbncNizsdecr2m1tVpUZyk0l4PeQkm0VUzuKk3v9q+Zd4c8RJrfDfUcw/NKlIMo
	PtNZNdVWvA1FLAFo8vvwzUaBhKsgYTNWafCcAScjVhmjRKy6qcHKLipwqFhcGQOT9TkjhIhV+nD
	eEcj5PvYHOdjTt23m3msAW8ESrxyajMBzJTdaZ1WMnVKfup8iLmWcZWHP75cEbvshJBpUTm2Zrf
	FemuSTWHIfM6zk4GkmNYKfgWww0RbScSTiz5yCDAkv2tZcvT2+IRr9MnUTrK07mK46ceOw1xXPV
	A3pv4N4BHTwaCCNVRH1pXGu8oLnnWL4mvlmHutauMOnT6+EtwGwHy53Cai5Bds9jblZ5WkKI2Rg
	vcz8OCZxA5XisFISzaWHtgdCwURk+6rBjrD2VVumrpBH8kOPSE7hj3h6jGQZQJl0vIuNW485g5T
	dVAe5vVqXI8nSVJxifHSCgUyMhXtAbWoCj6F7ayAJF8=
X-Received: by 2002:a05:600c:4e04:b0:4a1:8dc1:7a4e with SMTP id 5b1f17b1804b1-4a18e47d752mr55640965e9.2.1791576807953;
        Fri, 09 Oct 2026 13:13:27 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-093-130-185-162.93.130.pool.telefonica.de. [93.130.185.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm47053065e9.4.2026.10.09.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:13:26 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
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
	xiexinet@gmail.com
Subject: [PATCH net v7 0/4] net: hsr: fix super-packet forwarding and ordering
Date: Fri,  9 Oct 2026 22:13:20 +0200
Message-ID: <20261009201324.17-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP requires per-wire-frame tags/RCTs and sequence numbers, and
duplicate discard is per frame. RX GRO and TX GSO can present multiple
frames as one skb and violate that assumption: a super-skb is either
rejected by a constrained lower device, or forwarded without valid
per-frame trailers and sequence numbers. An oversized PRP aggregate
can also truncate the RCT's 12-bit LSDU size field.

Patch 1 keeps software GRO off while devices are direct HSR/PRP
members, without rewriting wanted features. Fixed-on or driver-required
GRO_HW may remain enabled.

Patch 2 replaces the forwarding lock with one consumer to avoid
stacked-HSR deadlocks. It preserves per-lower submission order for
locally numbered frames, so old HSR peers that drop late sequence
numbers keep working. Only sequence allocation holds the short counter
lock; forwarding runs after it is released.

Patch 3 segments valid GSO before per-frame processing, so each wire
frame gets its own tag/RCT and sequence number. Patch 4 tests member
GRO policy, GSO forwarding and local submission order.

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

Valid PRP frames from older senders remain supported. Patch 2
preserves submission order for locally numbered frames without
changing the PRP frame format or requiring peers to upgrade.

Some old Linux PRP senders incorrectly append one RCT to an entire
GSO skb. This violates the per-frame PRP requirement. Patch 3 drops
such intact aggregates when trailing bytes extend past a known,
nonzero IP length; zero lengths and GSO_PARTIAL are not covered by
that check.

The mixed-version test uses two PRP VMs; the host runs no PRP.
On virtio-net/TAP paths, disabling GRO_HW in patch 1 can make the
host segment an old sender's malformed aggregate before it reaches
the receiving VM. The RCT then becomes transport payload, which the
receiver cannot reliably identify or remove. In our QEMU 8.2.2 UDP
test this produced an extra six-byte datagram; the base receiver
delivered the original data correctly. Upgrade the sender or disable
GSO/TSO on its HSR/PRP master; the latter avoided the failure in the
test.

Validation:

On the net test kernel (7.3.0-rc5-gb0fe53dd6370), the installed
ordered selftest passed 5/5 cases, including supervision, concurrent
producers and sequence wrap, with complete, loss-free captures.

GRO passed 11/11 with the preceding helper. The later cleanup-only
fix does not affect GRO cases. Failure-injection checks confirmed
error reporting and cleanup.

Earlier queue-stress and PREEMPT_RT results are retained. Paired W=1
builds had no additional diagnostics. These checks were not repeated
for the helper update.

Based on net 6dc989ea46b9 (2026-10-05). Integration preserves the
upstream interlink promiscuous-mode exception and setup-failure
cleanup. The series applies directly to this base.

Patch 3 depends on patch 2; no stable backport is requested here.
The remaining HSR dev->stats races are left to a separate series,
as Paolo suggested [1]. Pre-existing shared-skb mutations are also
handled separately.

[1] https://lore.kernel.org/netdev/4fc3b9f1-4bef-4b34-ae7a-e89037cce829@redhat.com/

Changes since v6, including the NIPA and Gemini review responses:

- Replace recursive, one-time GRO disabling with persistent member
  policy and restoration of the latest wanted state.
- Preserve submission order with one consumer; remove the bitmap
  prerequisite and use core per-CPU counters for new RX/TX drops.
- Handle bounded 802.1Q/802.1AD VLAN stacks and reject trailing data
  beyond a known nonzero IP length before segmentation.
- Replace child-process signalling and fixed readiness sleeps with
  namespace-bound sockets registered before traffic. Bound cleanup
  under signals and preserve failures.
- Check packet contents, retransmissions and capture completeness,
  rather than throughput or average sizes. Use a standalone Python
  helper, with no embedded Python in the shell entries.

Veth tests do not validate hardware GRO_HW. The generic GSO bit need
not be off, so tests now check GSO_MASK member types. The claim that
the old test always failed was not supported by its actual feature
state and recorded passing runs. Shared-skb mutation is a separate
existing issue; both reports about new drop accounting are addressed
by the per-CPU counters.

Previous postings (earlier design, newest first):
v6: https://lore.kernel.org/netdev/20260809121455.1745-1-xiexinet@gmail.com/
v5: https://lore.kernel.org/netdev/20260807140751.1351-1-xiexinet@gmail.com/
v4: https://lore.kernel.org/netdev/20260803222211.877-1-xiexinet@gmail.com/
v3: https://lore.kernel.org/netdev/20260731090224.18-1-xiexinet@gmail.com/
v2: https://lore.kernel.org/netdev/20260724161253.79-1-xiexinet@gmail.com/
v1: https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: keep GRO disabled on HSR/PRP ports
  net: hsr: preserve submission order without a forwarding lock
  net: hsr: segment GSO before per-frame forwarding
  selftests: net: hsr: verify GRO policy and ordered forwarding

 .../networking/net_cachelines/net_device.rst      |    1 +
 include/linux/netdevice.h                         |    6 +
 net/core/dev.c                                    |   10 +
 net/hsr/Makefile                                  |    3 +-
 net/hsr/hsr_device.c                              |   66 +-
 net/hsr/hsr_forward.c                             |  233 +++-
 net/hsr/hsr_forward.h                             |   37 +
 net/hsr/hsr_forward_queue.c                       |  294 +++++
 net/hsr/hsr_main.h                                |   18 +
 net/hsr/hsr_netlink.c                             |    4 +-
 net/hsr/hsr_slave.c                               |   60 +-
 tools/testing/selftests/net/hsr/Makefile          |    3 +
 tools/testing/selftests/net/hsr/config            |    1 +
 .../selftests/net/hsr/hsr_gro_superpacket.py      | 1088 +++++++++++++++++++
 .../selftests/net/hsr/hsr_gro_superpacket.sh      |    9 +
 .../selftests/net/hsr/hsr_ordered_forwarding.sh   |    9 +
 16 files changed, 1784 insertions(+), 58 deletions(-)
 create mode 100644 net/hsr/hsr_forward_queue.c
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_ordered_forwarding.sh


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.43.0
