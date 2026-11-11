Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410257;
	b=PFnkL2Xm+h4QdGotkMrDGmgv97oXoPbkA8EjUjAp59j/iFDu5AZg0te34biirjQAqDUz
	 trjEF5Mv/DGS6JK1d5WU+FZmaFFEengZd9wa2lo+CKNJ3ONtC8bYlqgok2ctt5Bb5FdOm
	 bywlR+ZW3RWhmwaRXqSi/DuPG9C9FW/kYEHs2kEOEu46KLu6Dn72vof6Vdm97pefNGe9G
	 IxG1neOW1+QijMP08QnSAOM6ETXJdxK10cd6Fv73R0E9A088ShihOVlKwc+m12Z5fYNvd
	 ITA1l1L1HdJMvHahwPgE31mnUBp0s9A7PmNCppoXZttws9eyHKY2gT961MsrDfcg1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
	b=zBiGM5mLGEyuOByVs5eJ3mgacPQau9O87hRc5EHCtDaq8Z479fcicJigHaKGreL6GhYI
	 74v7p46gGKAyKpaCWp/E24mwGaLMWwl7z/r8F9T32dpRsw00aNiZTuujZCQYvRqNIvxb4
	 NxjwDC5R6tZleX+gUhreFycjTFaommzmlXUkLD4rbXyD8is3MedHhgZ1X4gBnqSfJZgiT
	 QFWCOUrYBoaroN99SUzDW20TDqorSYAnmQ9MHqOsPDNXlBzqnX29G9Oo0N5BZw7IjGzVR
	 3xP6z+BAROYxGUdc2X1mh+6Bo6nKFy49zFGxJNm2u6/yAaXxSSdsAarGdN1YYvRKYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21355606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21355606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b349d21fd1so24719097b3.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410255; x=1795015055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=xHafV8QvPAPS0wmqNcRvcX4vJ2/brD72r6SyMudAQpf6u8hDjeTktS2nrreEE/jbal
         NcnWc1ZNJKWf1PaG+jvqJalk+nZcKfSFO7GhSyWm5pv+I90fwTb/zJiCa654A7x6SIhd
         GfvppRqTWeQoRyIj4mp2JG3M5BbtamXSG+jkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410255; x=1795015055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=pEX2HtG0PCaFKfCu0+JHARctNPMkoT4eonl2IXqZFaasOhokw9C8zJd86TWZPjp2ZD
         2lEZPI7xFAwTCTNYxrD93UGftQTC6soje74fXiDdQDO+esQk3mGUh1k+gZLy4RyLacxg
         5I03SGzO+hgL//7ewcp5q7mYQ69052joH/dyXH9o0IhGs5gxAwyaHEhhIaIDIMC4mkgO
         di/yjcd/03EzM4CpywWAuHIpBs5MjE8xWtnU5+vfHHrrR1Ke3z5RUm0qzMMiRFC5ub+Z
         r3Um0E49Rlu/Af68XYgRMV6BBB9oQ/jW/HfLFUlURvJI+ZpXcGg53g2DCDNxgq4aAwT5
         F8DA==
X-Forwarded-Encrypted: i=1; AL+hErE8CYFIKoxUHHMoMIidU8TbtkPhbPY16djWMLtrPqir+N4JltgOy4C/gmuzDO7YQUf3w3abqoE=@vger.kernel.org
X-Gm-Message-State: APuU4Z99BCDuqFe/A75SZJl5HcwoSOfl3bvqfkcQ3r1oAvfg8fkmp1kc
	ACf3jAoumRh5Y7J9oOk/81iqDxYYxjvnxg/OmFW2nOX8Fo1TcBSb+Fvn1YwxwwUg7Q==
X-Gm-Gg: AYBFou2YRwGbg+VPcZ6NCMV7kJXyeViD6jyaQtOYuXq1YkDR7a9kI0ncBrqwwQT1kqH
	uwedHYaCtFIii3nPo+SHV5ZsoC0KMe+v2dbW8BVgrLyf9BTezsHaKlIZz6b046rihY19pZc+ENq
	VUx5GrTKcCm2XKh0fX8pqlIZ/2iYbn5bQJFjsud04CZVthBh48fJrHnjy5wxeYrpap9FArg33xQ
	KjxTITnM3eC5hVQhEKGQSPimcjhsMfh3roJS1tjuaCaeZ1fkZc6FMKx/c022Uc1xLN//NetK2Ke
	I7ifXS3dztCNQCzybwqI470dOsRzw+3/PJvQtM0v0NFdIu1vn2IVR2HJ07mT4RCgW4RB+RB9XTo
	tbu5kbeVTEP6rGPAJr8RiH94vxseHAVrZ8OvjnfNyapOO5o8J0B/Pnx7pxRh+nxEuH0a+E8YLgG
	pupSgSSYHYc9SgVbOJH82Nq2cwt4UZc7zPl+IFY5jf8CttXpoGfGVt+G0coNon0KCiTtSjXosKz
	jwlctTJfnTFTWirNFkoRq0LGIAxJQdbW0z8kXzpchjF71S4eqSGEp37jMj0pA5bTZMv8jE8dWUX
	jju6nsWyP/S6fW5SMpdYXMP+PF+a0/tmrHSn4xYaPCcwhT/zhSZ1GMvUNmVOenhN6/mS8FrDjKC
	liBd/OREIXkBSXA==
X-Received: by 2002:a05:690c:4484:b0:8b1:3606:65f6 with SMTP id 00721157ae682-8b3a81469bfmr17915477b3.64.1794410254970;
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/3] net/sched: sch_teql: keep the transmit path's skb geometry and device lifetime intact
Date: Wed, 11 Nov 2026 10:17:27 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

Three pre-existing defects on the teql transmit path, all around
teql_master_xmit() -> teql_resolve(), plus the core helper they depend on
all derived from sashiko reports.

Patch 1 makes the headroom private before the slave's header write and
pulls back only the header that slave added, so a header-cloned skb is not
corrupted and a userspace-supplied link header survives a retry.

Patch 2 restores skb->dev at the arp-queue reinjection point when the
neighbour's device builds no link header. It is the neighbour half of the
version 3 patch 2, split out on review so it gets its own commit
log and its own Cc set; requested by Jakub.

Patch 3 moves skb->dev = slave ahead of teql_resolve() so a skb parked on a
slave's neighbour arp_queue names the device whose neighbour took it, and
so cannot outlive the master it came from.  With patch 2 in place it is
reinjected through the master and leaves with a link header.  Its commit
log carries the KASAN report the unfixed kernel prints when that queue is
drained.

Patch 3 is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path") by Victor. Patch 1 is the
same commit's sibling on the successful-transmit path.

To prempt the sashikos:
- The pre-existing teql issues reported alongside this series are fixed
separately. For "the lower-qdisc drop use-after-free" see:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

- For the pre-existing consumer nft/bpf complaint see:
https://lore.kernel.org/netdev/CORE-9NOG.v1.r0.20261111073528@mojatatu.com/
Note: nft/bpf combination _has never worked_: it is a producer-side
mismatch on two separate entry points, not a regression of anything here -
hence the net-next target.

Hope the sashikos read these and dont complain again about those issues.

Note also: part of the testing of patch 2 runs for packets that reach
neigh_xmit() from nft's `fwd ... neigh` statement, or from
bpf_redirect_neigh() with explicit nexthop parameters. Both keep the
route's dst attached while replacing skb->dev, so the neighbour that
queues the packet is not the one the dst names.

Changes v3 -> v4:
- patch 1, no code changes. Reviewed-by from Simon Horman stays, and a
  Link to the review of the v3 posting is added.
- patch 2 is new: the net/core/neighbour.c hunk of the v3 patch 2 is split
  out into its own fix, with the neighbour maintainers Cc'd.  Asked for on
  the v3 posting by Jakub.
- patch 3 is the v3 patch 2 with that hunk removed; the sch_teql change is
  unchanged in approach. Reviewed-by from Simon Horman stays.

Changes v2 -> v3:
- patch 1, no code changes.
- patch 2 corrects the conditions to recreate the bug: reaching a freed
  master needs sch_teql built as a module, the slave qdisc removed and the
  module unloaded while the skb still waits.  The message now says which
  part of it reproduces without the unload, and names the neighbour failure
  path that drains the same parked skb.  Considered comments from
  Sashiko (nipa).

Changes v1 -> v2:
- patch 1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour whose
  device has no header_ops, the shaper/eql/sch_teql class.  Commit message
  also describes how a master is freed.  Considered comments from
  Sashiko (nipa) and Sashiko (gemini).

Jamal Hadi Salim (3):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net: neighbour: reinject a parked skb through a headerless output
    device
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
-- 
2.43.0
