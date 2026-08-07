Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656B340417
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111682; cv=none; b=SFhZx761RI5LO/ug9XaC9Bbi4wnCFzj+clY8DHXFV0ax3yRaKYy/B9RuIbyf0NAn5ubE17AT5IP8BdvL0sffqb4KPrTEZZ39y/rCttkXGqg5Nm9MEPlzGwPCLtTvwrvzrFz+m1KhXJyWTwQqlZibYhThwDX28P7W6TDAReYI+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111682; c=relaxed/simple;
	bh=MrMnKSnRavMONEbHs+AILIrvw6Y5PZZwJhHsMLB6ppY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOp+GvLVKuOMR2FTBzjhSSnzed2r/eafcexTd5q+164fzbbMJULyK2yLMJHPN2lRVScTFiG2MHaGTytNNtvg42KrcWsG/YGff6VlIkvMs0wMuYWLJ8oQkBl6iRilqtaqA3DfFWw9UzwnJk9Gk4YnRHB5CJXq48tKidIEcinfhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omagsIv8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omagsIv8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490791a3e92so2793985e9.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111678; x=1786716478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Awdo1QP64TlSzBVobH6AcXmJzAhmQsXdsrd1UgoF4WA=;
        b=omagsIv8TtJ93sW3+NOa1T+x4UERKnRNwoWlhiUgZEx3TjTfXsHmJsEMICKx5fM1nl
         BICpUycaATk/ONIThuE1VDm0VZKAyfmTrirSqNsLuz6wueYGt7ASbcunBNzPShywObmB
         l0PR0U/nCix0JyuQuq83dYdBS7edq20wy/9JssrLcii9NJxFDC8wvUsbMLXVNmFcwe2m
         eO5aaVPEj57tK+D+HFFOgm/b0/KevMq+arEnM8h/CMLvsG7zov3vsl21dM0bv+OrLmcU
         r4pfaQF7phk8Zy+50w+KDInac+EMguHS4MlfZQroTYBBxoqmBM3baUM/WGhJe0gwvGxy
         rrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111678; x=1786716478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Awdo1QP64TlSzBVobH6AcXmJzAhmQsXdsrd1UgoF4WA=;
        b=fgdhnz8KzLIqFUnMCDwB0ba9WolNgptelkeje7Els8GGRIlnlfFdGBZt6a3Jw2dsBp
         pAgKcxHgYcYmK9VrFa24ucMVvoyi6BXki+sH89f8jKBA8g/18B3sl161EAFQdT62TPfD
         pRhV7BZzVJym+d1JvBjE/MYH2sh5h8G9S9yN1IhZNX0SXpRNd2wznE6d/J045Dp6iw/N
         yLGUzkclN8YNmMGoPkhm1p165yqt7XMQ1HXtpA9G1rwQLYVdAxMBLLgGVUVPLs5MnM/3
         SoXA+/fGDW9VRJ4K2+BdqykoiMrhMeLupijGli0Ezx0b2PEwboA/c9ZX7SQdqrkI0Z7N
         RNmw==
X-Forwarded-Encrypted: i=1; AHgh+RqfSZTbfV5i2lfHBnMr+lg7CoIGvnAUcknn4v78INcLeZ2iN4o9GP/wJkRsVzYa9j6ayxF2S80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH15K4uMulEbh9aQECVyoF/i6IanRCZhTvdWh3BuNkPe1ix1Fq
	oBZcI6V6QQEPDiHA/jtg4+Jw4fGE3zYQBJWPHI8pALxQa7SJ8AOvCrTg
X-Gm-Gg: AR+sD11BIYyurvreYPNJSvC1yOQ/fL+p+q+fEHB6Gurapnvds8tkXcO9v4ZDpY1YGTq
	0O9mCgg0pBNRJDz9rqHi20EsirscLrKIavdS15Xf26P45wdSJhIFT75I2BKw6P+jswJNX4WB1qi
	iOUJNuayRiNWC1NeXTkEdcxZ8cs7H+z4xjpKo5DxBBqSkc7kPeQM+cwBz6sXbpAag9Kq+UgkFrI
	esUAt1E0j2IoXDRTE54n2HREaSEQP65XBWWMoohzb19W/char83DgreE1qFz8hbggenhYEFilPt
	QWzPhbg/WvvvQWQYgt6iWJAPQ5+SWVs3G7MXECpCfidEjg4AOmXGKa4LXsZQMZFDsGuLMWvEDS2
	E2R3vZQvuOxgJ6wuFcRxJHuF6J8mVYfLFxCZzmEUSO8MrKHJCIJI+OUGEbC0bzdZADITugzFeBd
	sM+xV3b74y6fMK/dwc83EjDyQWLw8s2aYDhb/P15WwYOcHV/oMAKbRGZ/XFccDm+bblEoH8N2DO
	ejy4606hEFlQL3r9DssZmy22MQBuvEq+J4N9ZwqGkjd44BA1/GBOu9l3/+be9CV3i064pSWCkdX
	iasmkR2Q2ioXH/xG3hk+bwY=
X-Received: by 2002:a05:600c:3594:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-4994e7bd084mr158843815e9.2.1786111673554;
        Fri, 07 Aug 2026 07:07:53 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm5980064f8f.11.2026.08.07.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:07:52 -0700 (PDT)
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
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v5 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Fri,  7 Aug 2026 16:07:46 +0200
Message-ID: <20260807140751.1351-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP requires per-wire-frame tags/RCTs and sequence numbers, and
duplicate discard is per frame. RX GRO and TX GSO can present
multiple frames as one skb and violate that assumption: a super-skb
is either rejected by a constrained lower device, or forwarded
without valid per-frame trailers and sequence numbers.

Patch 1 adds netif_disable_gro()/dev_disable_gro() and disables
GRO and GRO_HW on lower devices at HSR/PRP enslavement time,
mirroring the existing LRO treatment. Disabling is explicitly
best-effort: a later privileged override can re-enable GRO, and
devices with fixed-on GRO_HW (for example a virtio-net device
negotiating guest TSO without VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
cannot be forced off, so enslavement succeeds whether or not the
feature could be cleared.

Patch 2 shrinks hsr->seqnr_lock from whole hsr_forward_skb() calls
to the sequence counter updates, so the segmentation work of
patch 3 never runs under the global sequence lock. The outer lock
also incidentally serialized the tx statistics updates in
hsr_forward_skb(); those now use the atomic DEV_STATS_* helpers.

Patch 3 unfolds GSO super-packets at the forward entry with the
top-level GSO dispatch (__skb_gso_segment()), so each wire frame
gets its own tag/RCT and sequence number. Admission is decided by a
content-based classifier, not by the ingress port: plain-Ethernet
aggregates are segmented on every ingress role (master, interlink,
and LAN slaves), while aggregates whose effective protocol is
ETH_P_HSR or ETH_P_PRP carry per-frame trailers that software
segmentation cannot reconstruct and are dropped. The classifier
unwraps accelerated VLAN and one in-band VLAN level, and treats
NETIF_F_HW_HSR_TAG_RM lowers as plain by construction. The
trailer-free premise of the plain-aggregate path is proven for
in-tree software GRO: its IPv4 and IPv6 length checks reject frames
with trailing bytes beyond the L3 length, so an RCT-bearing PRP
frame is not merged. Device-specific fixed-on GRO_HW output is not
claimed to be completely covered. Locally destined segments are
delivered to the host; the rest are forwarded per frame.

Patch 4 adds a kselftest covering the series, including a LAN-slave
plain-GSO regression: a plain SAN aggregate entering a PRP LAN slave
must be segmented, with local delivery and per-frame arrival proven
by independent counter oracles.

Patch 1 is a safe, partial, best-effort mitigation and is
independently stable-selectable; patch 3, named by subject in its
message, is the fallback for plain, trailer-free GSO aggregates.
Patch 3 depends on patch 2, and patches 2 and 3 are selected for
stable only on 7.0 and newer, where sparse-bitmap duplicate discard
accepts out-of-order arrival. Older branches need adapted backports.

Validation:
* the v5 kernel builds cleanly;
* LAN-slave plain-GSO regression: the same frozen script fails on
  the v4 kernel (the early slave-port drop collapses the stream into
  retransmit-only single segments) and passes on the v5 kernel:
  aggregates arrive at the PRP master and are delivered per-frame;
* fixed-on GRO_HW: with a virtio guest negotiating TSO without
  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS (rx-gro-hw on [fixed]), HSR setup
  succeeds on both kernels; the v4 kernel emits
  "failed to disable GRO!" and the v5 kernel does not;
* the interlink super-packet test and hsr_ping, hsr_redbox,
  link_faults and prp_ping all pass;
* the series applies cleanly with plain git am on current net.

Note on the contest report: this series conflicts with our own PRP
RedBox support now merged in net-next
(https://lore.kernel.org/netdev/20260717201457.54-1-xiexinet@gmail.com/).
On current net it applies cleanly (re-verified by a full-series
git am). For net-next the conflict is confined to two sites:

1. net/hsr/hsr_device.c, send_prp_supervision_frame(): net-next
   added the PRP RedBox Type-30 TLV and EOT construction where
   patch 2/4 shrinks the seqnr_lock critical section. Resolution:
   keep the lock release immediately after the sup_sequence_nr
   update (as in this patch), build the whole TLV chain (LifeCheck
   payload, Type-30 RedBox-MAC TLV, EOT) unlocked, and drop the
   two stale unlocks from the padding-error and normal-exit paths.
2. tools/testing/selftests/net/hsr/Makefile: insert
   hsr_gro_superpacket.sh at its sorted position.

This resolution was applied and validated on the previous net-next
(2fbade662450): the composed tree builds cleanly and
hsr_prp_redbox.sh passes on the composed kernel.

---

Changes in v5:
Both v4 Sashiko reports (NIPA and Gemini) were reviewed in full.
The two blocking findings are the patch 1 and patch 3 changes below;
v5 also addresses the server-wait and message findings. The remaining
reports concern pre-existing issues, intentional behavior, disproven
claims, or non-blocking test/documentation suggestions.
- Patch 3: a plain GSO aggregate arriving on a LAN slave is no
  longer dropped. Admission now uses a content-based,
  VLAN/offload-aware classifier (hsr_gso_effective_proto()): plain
  aggregates are segmented on every ingress role, restoring local
  delivery and valid forwarding; only aggregates whose effective
  protocol is ETH_P_HSR or ETH_P_PRP are dropped as unrecoverable.
- Patch 1: the netdev_WARN() in netif_disable_gro() is removed.
  Devices with fixed-on GRO_HW (for example virtio-net guests
  without VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) no longer splat on
  ordinary HSR setup, and enslavement succeeds whether or not GRO
  could be disabled. The commit message states the best-effort
  contract and names patch 3 as the fallback
  for plain, trailer-free GSO aggregates; Ali's Reviewed-by
  and Tested-by from the v3 thread are not carried since the payload
  changed.
- Patch 4: adds the LAN-slave plain-GSO regression and bounds the
  iperf3 server wait.
- Patch 2 is payload- and message-identical to v4.

Previous postings (newest first):
v4: https://lore.kernel.org/netdev/20260803222211.877-1-xiexinet@gmail.com/
v3: https://lore.kernel.org/netdev/20260731090224.18-1-xiexinet@gmail.com/
v2: https://lore.kernel.org/netdev/20260724161253.79-1-xiexinet@gmail.com/
v1: https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: fix packet drops caused by GRO superpackets
  net: hsr: shrink seqnr_lock to sequence counter updates
  net: hsr: unfold GSO super-packets at the forward entry
  selftests: net: hsr: cover GSO super-packets on PRP slave ingress

 include/linux/netdevice.h                     |   2 +
 net/core/dev.c                                |  15 +
 net/core/dev_api.c                            |  21 +
 net/hsr/hsr_device.c                          |  17 +-
 net/hsr/hsr_forward.c                         | 111 ++-
 net/hsr/hsr_slave.c                           |  16 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 631 ++++++++++++++++++
 8 files changed, 787 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh

-- 
2.43.0

