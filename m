Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD32F6920
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428528; cv=none; b=jgTPQ1cmV65tSBUVcDy/HI5a8njUWAKf0lgjD9aV+uxWKhrXVkMcVWl9a7F8P+r0ENXLKu4TqnhclrPsTnN2JmZuJu5GW0DQmg0FmxyR+BCytF6Aep6fPPA5EpRwcBH5j85oBWccNe7S8P8sYnJ8xQr6G/tp6YoSq7BXZGLd4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428528; c=relaxed/simple;
	bh=OuinkhGiY9Wlt0SjaWtdAlRrZ8kDjoV+1Q94FTYUtWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQOfn+wCTJm08pPi0F2edaXrTbV649kL3IgmEveJXJjdSEceUSBChXgzQ6EYyxiuOqaegDCZIlBXqEEvSMAYsSHPvBNVGb9ENFrKMM4v0tFdxZHWmAWSgD1FVqA6Ke6uWwnuz6HTwtLG/nB0A8KVzg2J+CJDZcll0flA6aXjRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=AfMso72E; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="AfMso72E"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-934944f2d22so120250785a.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428525; x=1788033325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pks3+xNByEla+xxq2SjPUPd0B0r/fsFaUQdyItrSd30=;
        b=AfMso72EMoGMPLge0ZJSJ/n+PK6PelfXJHZ+PkBpfJE0X3gshHFQzNpoOO4OsTt58+
         lsR2UDq+taAEGESMzJrhJZ8rGsaoxXU/A0ALQe5DwqyYdAC9+PsddOEkDNhXz3TVesvM
         aJ7qTUvpi/ANNt9ZmH8HuxphcLiCJn+1fRr20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428525; x=1788033325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pks3+xNByEla+xxq2SjPUPd0B0r/fsFaUQdyItrSd30=;
        b=fKMlaqTRC144Q3mB/x1QA2Hsaz8RDduhqJ69nxDi9Sh/pLVoBNMXiF3L5VwImcs76P
         VmifgOaY4oeT9SbQ8XJj5fTn5d9Vf1vRyTJq+cKaaoHEPAQVi9PmQo6sAzk9Rw8E0p/6
         4OQTXy96E1m4AAjC0r0Hahi4yZIbxd37IU+0zW29p0gre9POnt4UTGui7jmYI0aHjzdV
         cdQXzU7ITP20blM3dZKVmzO+F2HRhbUS6IYctRMmtylmwUvdQZaLw71Y2zSF5dqSUeog
         PFr811Dr+95bTxc2/cBD/UY8tK/pMzOz3BQ/ZwdMdoremdhrJKMw215T6wKQLlxwqIIP
         o8AQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEZe7RRJ2loJy+Pali2oLLUhIqEZyPLXbmOV0oB3cDlJS+H+Nf7qp+x+eXk0CCtbkzr1m3X60=@vger.kernel.org
X-Gm-Message-State: AFuF++naQFDDXDlLSXAYshCyp9ZT08YgijzcWnoNdztFzRrMLEwX7XzO
	R9cwDcK/XxfJgW6ZbT7GCze/CE0ThuT2cokOHv3gsheBRElQYoXbI0H9NGAkDZBS5w==
X-Gm-Gg: AR+sD11/2kl+y1sSgxI561IIqmg/T4NzDkVJ1mqmpd5/Up7ieIg4RE0PndV7OZMEYLj
	f+R3uKZYlyJJMgNsMWzS/i7kh9bYsafB9En1qA7RdKK96yoMXyPJFFpYGKhnavWAFSgwJfMxu67
	aIxGZWlsi9HLiyXWDHhS/dLLWmySZoM2OE4rS/xKjFNEmPEsh2TSh73i/PNpAVQqY8JccUCTnHc
	hN0y3gEQgavTroTKepuskU+qAMLvNislj/3PwB7UsnDvzaP/ceSnr7uQ8yZmttteFrnnIV4yJ61
	3/GxtJJcltnJ6bK7t/jwckWLQVfaszT/nZ0sNgW3ILX34JMyzwOUhLEBSh4nO/zgMqde7r43eyr
	2aMde0IyyXqshbm7y9k004NJpuhz0hiTF3FsNs9/zM5wsspLIsICj3+Xq7BVA06eYXla531uTlb
	WySi06IkWA9X/Y2XQ3qQ3uAQ/kGPdURAk4aN4+Z4s5AcXAH8SfdKCK
X-Received: by 2002:a05:620a:942:b0:936:ae3c:bc99 with SMTP id af79cd13be357-9373939a61cmr1035660585a.0.1787428525510;
        Sat, 22 Aug 2026 12:55:25 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:24 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	"Sachin D . Patil" <sdp.sachin@gmail.com>,
	"V. Saicharan" <vsaicharan1998@gmail.com>,
	Mohit Bhasi <mohitbhasi1998@gmail.com>,
	Leslie Monis <lesliemonis@gmail.com>,
	Gautam Ramakrishnan <gautamramk@gmail.com>,
	Terry Lam <vtlam@google.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 0/6] net: sched: fix quantum/mtu overflow in fq, fq_codel, sch_codel, fq_pie, hhf, sfq
Date: Sat, 22 Aug 2026 15:55:03 -0400
Message-Id: <20260822195509.112717-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several qdiscs derive their per-flow quantum or CoDel mtu from
psched_mtu() without an overflow or zero clamp, which can drive the
dequeue/credit-refill loop into a soft lockup or silently disable the
AQM. vega@nebusec.ai provided reports and PoCs for the following qdiscs:
sch_fq, sch_fq_codel, sch_fq_pie, sch_hhf, and sch_sfq.

sch_codel was found by inspection for the same pattern. It's TheLinuxWay
(i.e cutnpaste code from somewhere for your new feature) and the AIs
are having a lot of fun finding patterns. We must overcome!

Clamp the quantum (and, for the codel family, the cparams/params mtu)
to a sane range at init/change time so the dequeue loops terminate and
the AQM stays armed. The clamps live in the init/change paths, not the
per-packet fast path, so no hot-path cost is added for a configuration
issue.

This series depends on "net/sched: bound qdisc_pkt_len to prevent qdisc
soft lockup", which caps qdisc_pkt_len() at GSO_MAX_SIZE in
__qdisc_calculate_pkt_len(). That cap closes the fq_codel TCA_STAB
backlog-wrap vector (qdisc_pkt_len inflated to ~1 GiB wrapping the u32
per-flow backlog to 0 and NULL-derefing in fq_codel_drop()); with it
upstream this series no longer needs the fq_codel_drop() hardening hunk
that the earlier respin carried. The five quantum/mtu fixes here are
psched_mtu()-driven and orthogonal to the qdisc_pkt_len() cap.

Q: Why not bound the MTU at the source instead? dummy's max_mtu == 0 is
intentional (dev_validate_mtu() treats 0 as unbounded), other drivers
can legitimately advertise large MTUs, and qdiscs must not trust
psched_mtu() regardless.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps 2 * psched_mtu() or psched_mtu() into the sign
bit (e.g. a dummy device with max_mtu == 0 accepting a huge MTU).
Requires CAP_NET_ADMIN in a user namespace.

---
v2 to v3
General: Feeback from Eric and Sashiko and one addtional qdisc from
inspection.
1. Split into one patch per file (Eric Dumazet).
2. Clamp to a range [256, FQ_CODEL_QUANTUM_MAX], not just a lower
   bound, in fq_codel/fq_pie init (Sashiko).
3. Clamp psched_mtu() before multiplying in fq_init() (Sashiko).
4. Move hhf clamp before hhf_change() (Sashiko).
5. Fold fq_codel cparams.mtu clamp: same unclamped psched_mtu() six
   lines below q->quantum disables codel; hoist one clamped mtu.
6. New patch 3: add sch_codel -- same params.mtu issue.
7. Drop the fq_codel_drop() hardening hunk: the qdisc_pkt_len() cap
   in the posted "bound qdisc_pkt_len" dependency closes the TCA_STAB
   backlog wrap at the source, making the empty-flow fallback unreachable.
8. Switch sfq to clamp_t(..., 256, 1 << 20) - all patches now 
   have same pattern.
9. Drop the stale TCA_FQ_INITIAL_QUANTUM narrowing: .max = INT_MAX was
   set deliberately by 7041101ff6c3 and already guarantees f->credit
   stays non-negative; lowering it would reject working configs.

v1 to v2
Changes based on feedback from Eric and Sashikos on V1.

1. Drop the fast-path changes in fq_dequeue() (Eric).
2. Clamp to a range, not just a lower bound (Eric); upper bound 1M
   matches fq_change()'s TCA_FQ_QUANTUM cap, not Eric's 16M.
3. Dropped the TCA_FQ_INITIAL_QUANTUM policy narrowing (see v2 to v3
   note 9 for why).
4. Fold fq_codel_init() quantum clamp (Sashiko).
5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko).
6. Reword the hhf/sfq comments (Sashiko).

Sashiko links:
  https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
  https://sashiko.dev/#/patchset/20260819143136.57350-1-jhs@mojatatu.com
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143136.57350-1-jhs@mojatatu.com

---
Jamal Hadi Salim (6):
  net/sched: fq: add overflow bounds to quantum and initial quantum
  net/sched: fq_codel: clamp default quantum and mtu
  net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
  net/sched: fq_pie: clamp default quantum to avoid signed overflow
  net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
  net/sched: sfq: clamp quantum to avoid signed overflow soft lockup

 net/sched/sch_codel.c    |  2 +-
 net/sched/sch_fq.c       |  6 ++++--
 net/sched/sch_fq_codel.c |  6 ++++--
 net/sched/sch_fq_pie.c   |  3 ++-
 net/sched/sch_hhf.c      |  4 ++++
 net/sched/sch_sfq.c      |  3 ++-
 6 files changed, 17 insertions(+), 7 deletions(-)

--
2.43.0
