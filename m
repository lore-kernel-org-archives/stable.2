Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66F1E0E14
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786277701; cv=none; b=p1YzOapYpcIbBwLakpLqFeuEcBIrYq9vdaUiDVZma+6kdtBo/p8X5YzBBQrmRJISYV3jI94EofQOz23a1WOvFSKcwCEsPyMuApV/ffrnFBfGWhW7YlUC9AdjFh8FX39Pkq5TeCrUN1AlRdvTwI16IRbNsZFNi5HgxnhuFN10Kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786277701; c=relaxed/simple;
	bh=klnf9MkQOZEuNAusvbaqGOTptHp+TZ19A5wrN75Ehm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fy3fJong2PKnk7gLPR+XEnUw5dimj4uUcnOTAkhkDlUFZXAFgVOJhTgkh1V8J6c/kUbtum1BPMq2WAa3XHOo1xY6ZTyQnvB82bca/2kl767P/BzeitVlxeZmM5I6psUNxpqV7/lphbWo/dhrTO4todTy249X28qoEjDEmZf8ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbMXsqAo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbMXsqAo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so981585e9.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786277697; x=1786882497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B1k8I62v4BSaNdCWABrCbb5cCPW1YuTo+r9jTUQOp0=;
        b=RbMXsqAossq944bNBtQeSkiVTUHdjttNoUWz/uqjeYsTFIHy1ED09jRdt6oOlvfQV9
         1feBV54ZbmEem9YIQuMeO1+YRNFfm8AKh4ZHlai0nKxaSLoVusuQdaPfSwhnkIzXjD7q
         MRdd8mEbH/8xa5+xtnkvvJK6OKSPhacDjaKGOOb/BcX6gVaUi9bHCKxhKRD99Cm4jZYE
         e9vIB+HHgiM2g4oCBFdZMARYp1w00a8Kpx/siBXy+1KuvHBWAN5MTAzYxa86jkh7ugz3
         0rcj/dbKYuzTL0r8c+LvSLP+6rgtSo7jOPtWTOkhaFMbWSiR13etWh3tny4OMJAXAyrv
         p+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786277697; x=1786882497;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8B1k8I62v4BSaNdCWABrCbb5cCPW1YuTo+r9jTUQOp0=;
        b=bv3TrElbiSGcZSyoI/k7uA3Ns5oV4gtGcSqJbjL4328CzYprJGA2Myyt8tZYkm9NR3
         hLC8MINA7lJyX+WdUSiVgFYnURXxktIm0Xv6VchSdo1uxcm4lnJfJCpQCv3EsSJg7aYX
         cH7kFvq8rPB6OTl+G2VgKYK9tDkuoNHcRn7nYlNh4CIpKmZkHsrGd8eSIdp2JwgkOiL8
         kMv9KtAYnMF/swQwoSYyP/pGgZllR8RFh0H9/9DqUPJK7+/hgQu1Tz4+CQ1Qd1jSghyF
         s72AiszIAXwHDachwNv50TXEXaGicBtCxH6VR0jcFxkdooE4KHERb0x9ddpx9MC/NZiR
         9TLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqc9+Pu1KokztkgpJng7APMSLsfTfELz1rfEhxlfxvqMUsAuhhqSzA83h8AQSi12M10E304Zzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBy18JUX4eY6/EnsXtm5uRWqYZb2LSREg5yWpYTlYPiQyv7je
	pzDQTmk1ipTet8jT+XvrsaWRuptO+LjCfami86B1x5TCeTRpL0Seyzuw
X-Gm-Gg: AR+sD12fdmfGWRg6O4/B3VClwdoNkSqZ2Ae4UdYDFsnTxClw8KV00RfF/eYdNGEwxpR
	cdUD47iq/4PRe41cCOzTrDeXjFPDATe/TDcHnCtanYRhfj3odbNunlwqpsnQFLvUKmvtt8JVxAl
	fVWsJyCbS8vAgQtTlr4tVcETAAPdsypxmMRH2DZBpXR85lQbYwbCsptv+wb44vvGYvMLVRcOtjg
	501GvucX547dLpUpQGSYKdVrT6F9WZbe8fz9RAlp3onBqYKooGScMumkvyUiFJH97CiOIJy2FsC
	5Ch7eSEJtEl7jW6obCfTsf43/UGKOGIsnBgXwxaZzrZNrea1Ze7JIn9Emj+VjXFBFgSwTBO/N3s
	4KolwaIwxfXnOhwg9gskIMiVj+35DTM2pQNvsWucF4KGgvVikjMlOY04Ja+LDU7feO/aquRIb+k
	NAYceVlvaKDZCUQnMcmNQ/34/l67TVYrG1UphDF2rEVrgy4OjXNPNEqpuMZeIdvcnlCWPgIXi/R
	9s7NkFQeVD8dD6hMULdDeGe1ZTv5oFdi/wT51AOPlL7Qg59TpWFQeHAZ7+EMPX1efZFJ4c9scR1
	I4bngp7rZxJ0eDccG8hZ
X-Received: by 2002:a05:600c:c8c:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-4994e7c7327mr236237495e9.3.1786277696982;
        Sun, 09 Aug 2026 05:14:56 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-133-135.77.12.pool.telefonica.de. [77.12.133.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm25158434f8f.20.2026.08.09.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:14:56 -0700 (PDT)
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
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v6 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Sun,  9 Aug 2026 14:14:50 +0200
Message-ID: <20260809121455.1745-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
also incidentally serialized the master/interlink tx statistics
updates in hsr_forward_skb(); those are now updated without the
outer lock, and consistent per-cpu/per-queue statistics for all HSR
paths (including hsr_deliver_master() and multicast) are handled in
a separate series.

Patch 3 unfolds GSO super-packets at the forward entry with the
top-level GSO dispatch (__skb_gso_segment()), so each wire frame
gets its own tag/RCT and sequence number. Admission is decided by a
content-based classifier, not by the ingress port: plain-Ethernet
aggregates are segmented on every ingress role (master, interlink,
and LAN slaves), while aggregates whose effective protocol is
ETH_P_HSR or ETH_P_PRP carry per-frame trailers that software
segmentation cannot reconstruct and are dropped. Aggregates with
unreadable net_iov (device-memory) fragments are also dropped: their
payload is not host-readable, and software segmentation would produce
segments with uninitialized payload that are silently dropped at
transmit or expose uninitialized data where netmem transmit is
enabled. The classifier unwraps accelerated VLAN and one in-band
VLAN level, and treats NETIF_F_HW_HSR_TAG_RM lowers as plain by
construction. The trailer-free premise of the plain-aggregate path is
proven for in-tree software GRO: its IPv4 and IPv6 length checks
reject frames with trailing bytes beyond the L3 length, so an
RCT-bearing PRP frame is not merged. Device-specific fixed-on GRO_HW
output is not claimed to be completely covered. Locally destined
segments are delivered to the host; the rest are forwarded per frame.

Patch 4 adds a kselftest covering the series, including a LAN-slave
plain-GSO regression: a plain SAN aggregate entering a PRP LAN slave
must be segmented, with local delivery and per-frame arrival proven
by independent counter oracles.

Patch 1 is a safe, partial, best-effort mitigation and is
independently stable-selectable; patch 3, named by subject in its
message, is the fallback for plain, trailer-free GSO aggregates.
Patch 3 depends on patch 2, and patches 2 and 3 are selected for
stable only where the sparse-bitmap duplicate discard is present,
which accepts out-of-order arrival. The stable tag names that
prerequisite, which exists only in 7.0 and newer.
Older branches need adapted backports.

Validation:
* the v6 kernel builds cleanly;
* LAN-slave plain-GSO regression on the v6 kernel: aggregates arrive
  at the PRP master and are delivered per-frame (SAN TX avg ~38 KB
  per frame; prp0 RX avg ~1476 B per frame);
* interlink super-packet test passes (DUT LAN legs avg ~1496 B per
  frame with the SAN emitting ~38 KB super-packets);
* fixed-on GRO_HW: unchanged from v5 (patch 1 control flow
  untouched); with a virtio guest negotiating TSO without
  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, HSR setup succeeds without the
  v4-era "failed to disable GRO!" splat (v5 evidence reused);
* the bounded server-readiness/reap waits pass on the v6 kernel;
* hsr_ping, hsr_redbox, link_faults and prp_ping all pass;
* checkpatch: 0 errors; shellcheck unchanged from v5 (0 errors);
* the series applies cleanly with plain git am on current net.

Note on the net-next conflict: this series conflicts with our own PRP
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

The resolution was independently proven by composition on the
current net-next (4fa4977a0d90): the composed tree preserves the
Type-30 RedBox-MAC TLV and EOT construction with one balanced lock
region. This series' conflict-relevant hunks are unchanged from v5,
which applied and validated the same resolution on an earlier
net-next (2fbade662450): the composed tree builds cleanly and
hsr_prp_redbox.sh passes on the composed kernel.

---

Changes in v6:

A confirmed defect is fixed: a GSO aggregate carrying unreadable
net_iov (device-memory) fragments could reach the forward-entry
segmentation, where the software copy path cannot read such fragments
and would leave the segment payload uninitialized — silently dropped
at transmit on most devices, or exposing uninitialized data where
netmem transmit is enabled. v6 rejects such aggregates before
segmentation (skb_frags_readable() gate) and patch 3 describes this
accurately.

The selftest is hardened: the server reap now polls the wrapper's
status file instead of a recycled-PID candidate, server-PID
validation retries across the fork/exec window, and server readiness
polls the listening socket instead of a fixed sleep; all waits stay
bounded.

Further changes:
- patch 1: the comment now names fixed-on GRO_HW only (plain GRO is
  always changeable).
- patch 3: the prerequisite is named by subject and commit; the
  hw_features wording states the unconditional GSO_MASK removal (only
  GSO_MASK member types become fixed-off;
  generic-segmentation-offload stays changeable and is cleared at
  runtime); the classifier comment describes its own policy.
- patch 4: the message describes the new test file, the header
  documents the LAN-slave case, and the master-RX bound has its own
  named constant.
- maintainer feedback adopted: patch 2 mentions commit aae9d6b616b5
  ("hsr: Implement more robust duplicate discard for HSR"), uses the
  commit-annotated stable tag (verified equivalent to the former
  7.0.x floor: the prerequisite exists only in 7.0.y/7.1.y), carries
  the syzbot Reported-by/Closes pair and the two Fixes: tags, and
  moves all statistics work out of the series (plain increments
  restored; consistent per-cpu/per-queue statistics are a separate
  follow-up series).

The remaining review findings were assessed and left unchanged: the
one-way best-effort GRO disable mirrors dev_disable_lro() and is
ethtool-recoverable; the kernel-doc already names the re-enable path;
out-of-order emission is tolerated by the sparse-bitmap duplicate
discard on both ends under the stable floor; the remaining statistics
races are accounting-precision issues covered by the follow-up
series; the software-GRO RCT claim holds (IPv4/IPv6 length checks
reject trailing bytes); the generic-segmentation-offload selftest
oracle was verified empirically on the identical tree; test cleanup
re-validates PID identity before signalling and has a netns-scoped
fallback; in-place skb mutations during forwarding are pre-existing
and handled by a separate series.

Previous postings (newest first):
v5: https://lore.kernel.org/netdev/20260807140751.1351-1-xiexinet@gmail.com/
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
 net/hsr/hsr_forward.c                         | 109 ++-
 net/hsr/hsr_slave.c                           |  16 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 678 ++++++++++++++++++
 8 files changed, 835 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh

-- 
2.43.0

