Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76E481B1
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488550; cv=none; b=q8qN5ydEm0aB/QNOVHklG/d4j2XB8DGEWWwSOGzRaEWU/X0Wwzgsyw8TKvEcGyWeDkcOS2Axtn2LjWj0c1QluXodTmHET3Rqcj3AcCqRawEbZkVJpuyHe2Mx5S68uR4Vaff48L7Pomtx11McrVzGVsHW1hcvXXusYJhqu9jgSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488550; c=relaxed/simple;
	bh=Rz5nAQxD9dzi7f1HZQXIEM2PVcmvgnNeWMsMmOJ3iM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BaydNyqqOVbbljvebAW7vpQJkxVl/d6bkR0Ub9bOuz/fnho+/MHiL6eAgDeI47tE9FfOKoDaF+vNf8zjbcDP3rhH7vTUsyj24oipE0pqEZ9zh73+4WGXvz1zznFcdHc6sfM5bcjJnf+5UhVzWyxHM8z63WtiaryddzYx0sTANS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juTvJyC1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juTvJyC1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f25e3fe44so67352f8f.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785488547; x=1786093347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+eM+ORJQphpBEjlLS6lBhvY6W8A+kEMRV5W3folsyVI=;
        b=juTvJyC1U4VfLKHHBwFnC9Wf9uEgyhRkDiyG2lMG7807JtCi9tUwPz8oCapruSWNst
         VFHmYuMum7b9Idr5fHuEco2ZECM/e4bm3b5nCjO7sWYJ5Kd5CVCyLtDo/e0UCwedBRap
         yZVXMnf3ZmFy6C3PyE98H/ZL9+wEZKjLFATTKGiZGguEl/EwjDuoIN2JW2I4EeGeD5gE
         2sl+tjZ5SATryp7Vst6rM/qsDhJ8DFceVHSxv4U0eiMIKVFayS4ynegWMfgwQmwLFbuh
         9fTb83z3nLSz6yPPC2gF2mIWEcJ8zFCGC8J3yMIc5PNCRzWxUW1mH8xZn1MyS4xDVo9+
         Kj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785488547; x=1786093347;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+eM+ORJQphpBEjlLS6lBhvY6W8A+kEMRV5W3folsyVI=;
        b=DEBJrjn1WLrxXcmVAOqFWVh6TAm+Ll3Y0lBVrchfzdfwMasCWA8SBgUxpnyd5ridsp
         l3x6piQzes6CUHtB68QjhWbsmkmxB5ylJOvmsskFaKp0HL4yw7SHDse13mR3lSwOfySF
         plspybXL9VHS5xjBECTxwjgFYN3oFAliSOOvWzSb8UyhKghkSXvrAGQwxDWSxKZW7sVW
         Xkbwi/aTei8cYmaZiw7LfqV6v22A4/WCnLmC/SsIDbDYfzNNHZzZ5YZkB2EAeHBNCtGw
         pDH8hKB/lFKnEG3hMwyOfjtJzCUrP44u7g/DDmFtRyhH47OubDyDpchGR1aiZ21BpWYK
         2Nxw==
X-Forwarded-Encrypted: i=1; AHgh+Rpse/4sNBPVBovt/l9b2VWGwVCTG54tRsJMPws/Vaah0NW4g3LUxK27SnygWqW8fFnBXwaQspE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/C/HCndeArebs6/HghPLGzmfwZXU7njOMGxfW5Z8gHRhX98r0
	Fsuc56yIC9t0zdbG5omPYctMqDfygybHmtyVazUOnrlHIGFlEfFy8Ff5
X-Gm-Gg: AR+sD131x2rlvkypz7zZDTtaevwZt3HM1KZh0CXowqHvY2AkZualM1bafKFHbk3vDx5
	cL27/1x1XWluY45ji7l2v47wSpr3tvBduLMfBOBqaFamF6RogS8zeoBt0wA98wy0bOFvZLurBse
	7zkHYsq62N9xV3kfMAJTCRxsv4zBHA/iZIyQkMUKXBFxpFM7X2+YPMWqFn7a+hXzmD7HitajJxM
	UjNCXMSnMyQG659v+5L4zIDwkJg3hE8xeZGbuL91VNlMVMNAcd3yCBykTYTjXclOm1+mVDw3Bsg
	fIRo0/SmrbBOCoqKA4Qi7seBxt83MI6KVwr5n3nrMV2n+6DjcFmNrpuNfZGksJBp9cdifOp6X2q
	4unMbGv9FdCoP73kQT2m/ziLYRG28VYHSfwORoY8v/s5+D9/nDrRHcFUkF/MeVriEVNAphO1dIA
	V4x1S9oXxql5fSGlwef+CI0Glkth5Gdg5V7XRPpLgQh5TxCPRLvAAMnTOaWP8NRAJe8Q2mESlq6
	VY3xxVEi8yRGj0X+fnZXdquwcJbPsTHGJdMCE7tKmvIe4699MD/ZUNeRlW5OfSk5B7/RxGf6OCq
	MbdmfknGXZUyWLTOOE0yXw==
X-Received: by 2002:a05:6000:4202:b0:47f:6c7e:b32d with SMTP id ffacd0b85a97d-47fd2abd5a9mr3197342f8f.1.1785488546264;
        Fri, 31 Jul 2026 02:02:26 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-184-219-058.77.184.pool.telefonica.de. [77.184.219.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm2965051f8f.7.2026.07.31.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:02:25 -0700 (PDT)
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
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Fri, 31 Jul 2026 11:02:19 +0200
Message-ID: <20260731090224.18-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HSR/PRP forward frames one by one: each wire frame gets its own tag
or RCT and sequence number, and duplicate discard is per frame. Two
aggregation mechanisms break that per-frame assumption:

* On RX, a lower device that aggregates frames into a GRO
  super-packet feeds the HSR receive and forward paths a single
  skb instead of the individual frames. Depending on the lower
  device, that super-skb is then either rejected outright (for
  example when it exceeds the lower MTU at egress), or forwarded
  without valid per-wire-frame HSR/PRP processing: its single
  trailing HSR tag / PRP RCT cannot represent the per-frame
  trailers and sequence numbers of the aggregated frames. On
  memory-constrained devices processing super-skbs in softirq
  context also pressures atomic allocation.

* At the forward entry, a GSO super-packet (locally generated on
  the master, or delivered intact by software NICs such as veth)
  would be tagged and forwarded as a single frame, violating
  per-frame wire semantics.

Patch 1 adds netif_disable_gro() and dev_disable_gro() alongside
the existing LRO helpers.  HSR calls the public wrapper at
enslavement time, while the networking core handles the generic
feature update and recursive lower-device traversal. Enslavement to
an HSR/PRP master therefore strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device. Disabling GRO on our own lowers is the cheap,
always-correct default for this problem: unlike the bridge,
HSR/PRP must attach a tag or RCT and a sequence number to every
wire frame, so leaving GRO enabled and re-segmenting later (the
bridge pattern) would add per-packet segmentation cost and still
could not recover per-frame trailer state from a super-skb. This
is a setup-time default, not an immutable feature policy: a later
privileged feature override, or a lower newly attached below a
stacked slave, can re-enable GRO without re-walking the HSR
enslavement path.

Patch 2 is a preparatory locking change: it shrinks
hsr->seqnr_lock from whole hsr_forward_skb() calls to the
individual sequence counter updates, so that the segmentation work
of patch 3 (per-segment allocation, checksums and forwarding)
never runs with BH disabled under the global sequence lock.
Patch 3 depends on patch 2; their automatic stable selection is
limited to 7.0 and newer, where sparse-bitmap duplicate discard
accepts out-of-order arrival. Older stable branches require an
adapted backport.

Patch 3 unfolds the remaining GSO super-packets at the forward
entry with the top-level GSO dispatch (__skb_gso_segment()), so
each wire frame still gets its own tag and sequence number. Patch 1
and patch 3 cover different sources and neither is redundant:
patch 1 establishes the safe default on our own enslaved lowers at
setup time (a later privileged override can re-enable GRO, and
patch 3 is the fail-safe for that case), while patch 3 handles GSO
super-packets that legitimately arise from locally generated
master traffic or from untagged SAN ingress on the interlink.
Segmentation is offered only for those two roles, whose frames are
known to be plain Ethernet. A super-packet from a LAN slave may
carry per-frame HSR tags or PRP RCT trailers that software
segmentation cannot recover, and an already-tagged HSR/PRP
super-packet violates per-frame wire semantics; both are rejected
by ingress-port policy. The HSR master also stops advertising
NETIF_F_GSO_MASK so locally generated traffic is segmented as
early as possible.

Patch 4 adds a kselftest covering the above: GRO disabled on
enslaved devices, no GSO/TSO advertised by the HSR master, and a
TCP stream from a TSO-enabled SAN through an HSR DUT. The stream
evidence is direct: the SAN's TX frame-size average must exceed a
fixed super-packet threshold while the DUT LAN legs' averages stay
below a fixed per-frame guard, which is aggregate evidence that
super-packets entered the forward path and bulk output was
segmented (not a per-frame maximum proof); zero retransmits is
reported as a secondary health signal. The one-shot iperf3 server
is confined to a private mktemp workdir with its real exit status
propagated, so on every path exercised by the test itself (normal
completion, server startup failure, client failure,
never-published PID, and baseline/final counter-snapshot parse
failures) no process or directory can leak.

Validation:
* build: W=1 allmodconfig and allyesconfig, base vs patched - no
  new warnings (final run on this frozen v3 candidate: all four
  builds RC=0; 342/342 normalized warnings in allmodconfig and
  345/345 in allyesconfig, base-vs-patched diffs empty).
* selftests (all on this exact v3 kernel, QEMU x86_64):
  hsr_gro_superpacket passes (GRO stripped on enslaved devices; SAN
  TX frame-size average ~38k bytes > super-packet threshold; DUT
  LAN legs ~1.5k bytes < per-frame guard; 0 retransmits) and fails
  on the base kernel: the LAN per-frame-average guard fails at
  approximately 1.9 kB on a veth lower device (aggregate evidence;
  not a universal MTU-drop or per-frame-maximum proof); hsr_ping,
  hsr_redbox, link_faults and
  prp_ping all pass.
* functional: IPv4, IPv6 and VLAN-tagged SAN TSO streams unfold
  per-frame through an HSR DUT with clean dmesg; the counter
  assertions show super-packets entering the forward path and
  per-frame output on both LAN legs. LAN-side aggregates and
  already-tagged super-packets are dropped by ingress-port policy
  (supplementary, reused v1/v2 evidence per the same patch-id
  argument).
* concurrency: parallel interlink-RX (GSO) and master-TX streams
  with supervision timers running, under a PROVE_LOCKING kernel
  built from this candidate: both streams 0 retransmits, no
  lockdep/WARN/BUG/sleep-atomic findings.
* lifecycle: normal completion, server startup failure, client
  failure, a never-published server PID (live-but-unpublished
  proven), and forced baseline/final counter-snapshot parse
  failures all exit bounded with no leftover iperf3 process,
  workdir, or namespace (all re-run on this exact v3 script; the
  parse-failure paths are new v3 evidence: a baseline-snapshot
  parse failure aborts before the iperf3 client workload, a
  final-snapshot parse failure aborts before any counter-delta
  verdict, and both leave no process or workdir).
* physical igb lower devices (supplementary, reused v1 evidence:
  patches 1-3 are patch-id identical and the only upstream delta
  in the touched files is an unrelated 2-line hsr_del_port()
  change): GRO stripped at enslavement; force-enabled generic GRO
  super-packets unfold at line rate with a clean dmesg.

---

Changes in v3:
- Fix the selftest's early-abort path: both TX counter snapshot
  blocks now validate their values as decimal counters. Previously
  the error flag was lost in a command-substitution subshell: a
  baseline-snapshot parse failure let the test continue into the
  iperf3 client workload, and a final-snapshot parse failure was
  only caught indirectly. Now a baseline failure aborts before the
  client workload, and a final failure aborts before any
  counter-delta evaluation.
- Wrap the remaining lines that exceed 80 columns (tab-expanded)
  in the selftest.
- Make the selftest's network namespaces instance-unique via
  setup_ns()/cleanup_all_ns(): the previous hard-coded namespace
  names were deleted unconditionally at setup, which could destroy
  unrelated host namespaces and made concurrent instances collide.
  Also re-prove that pre-existing namespaces survive and that two
  instances run in parallel.
- Patch 2 message: state explicitly that the lock shrink removes
  the old allocation-through-forward ordering guarantee and why
  current sparse-bitmap duplicate discard accepts that; correct
  the seqnr_lock history to its actual branch shape.
- Patch 1 message and the failure description: the outcome of a
  GRO aggregate is driver-dependent (rejected by a constrained
  lower device, or forwarded without valid per-frame processing),
  not a universal MTU drop. Also spell out the enforcement
  contract: the enslavement-time GRO disable is a setup-time
  default, not an immutable feature policy, and patch 3 is the
  fail-safe for traffic that still arrives aggregated.
- Stable floor: patches 2 and 3 are marked for 7.0 and newer
  (sparse-bitmap duplicate discard); patch 1's eligibility is
  unchanged; older branches need adapted backports.
- Rebase onto current net; patches 1-3 code payloads are unchanged
  (stable patch-ids).
- Cover clarifications: the concrete RX failure site, the patch 1
  vs patch 3 layering, and why disabling GRO is preferred over
  re-segmenting later.

Note on the v2 contest report: the v2 series conflicts in net-next
with our own PRP RedBox series now merged there
(https://lore.kernel.org/netdev/20260717201457.54-1-xiexinet@gmail.com/).
On current net it applies cleanly (re-verified by a full-series
git am). A tested net-next merge resolution is available on
request.

Previous postings (newest first):
v2: https://lore.kernel.org/netdev/20260724161253.79-1-xiexinet@gmail.com/
v1: https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: fix packet drops caused by GRO superpackets
  net: hsr: shrink seqnr_lock to sequence counter updates
  net: hsr: unfold GSO super-packets at the forward entry
  selftests: net: hsr: add GRO super-packet forwarding test

 include/linux/netdevice.h                     |   2 +
 net/core/dev.c                                |  18 +
 net/core/dev_api.c                            |  16 +
 net/hsr/hsr_device.c                          |  17 +-
 net/hsr/hsr_forward.c                         |  53 +-
 net/hsr/hsr_slave.c                           |  12 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 462 ++++++++++++++++++
 8 files changed, 557 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.43.0

