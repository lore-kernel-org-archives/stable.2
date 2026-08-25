Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C53DB64B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645663; cv=none; b=pDvMPEL3xhV/JHbKc3WuSEy4prBvVeym593iiBOxLwjwd4BTSUx4kyOfemJBpAm0UmgonaFEnTQR1qowfGICQZ8rDeLH69RegmPVIqkYC1D2xyfc2IH6sqD4lfxVWlqT1l0bgfcBrlYZ0hXhra2kunQeR2FtXxq8FYfl8mRlKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645663; c=relaxed/simple;
	bh=7I3oqNx3l1a0EQoUpbTQHwQBA40Y4bL8moO3e9riplo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5GyYtCQqhJsDV08Yo82Gaho+fTwwxXkAgY7Vn53A4BAuFSlAgGd0U7ZIqNeScyD9qM75GWaUZVMAWPSXzJsIIDMAQek0Kw3xzqdgaMZf/zOWqjjYRkKqHNJVklwglhUb/s9agB/+CfzvdwSUzW7ttwwwF1oIPCgkksNSN7RmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KoCJ+4Jy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="KoCJ+4Jy"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0006ea8eso31330381cf.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645660; x=1788250460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwfxD6bJBOWO+LowhgDnFJHm0TT2/hBcMgOzrlGwEbc=;
        b=KoCJ+4JyW+ZPgfN0h2PBclbCRT5kc4YO2qHXNrEmfGxxWqwTBlJjJXvgZi3usdmNZX
         ds5mG1YEF0q3WLD5LckUukKRwW/oxPDkj0Q33WIn6F0TbjqXgX5VSJf2raeo7qKzPZ3c
         x1/NYwQHid2ZAJ0dADZS9Tt6i1JIrfDN3I/Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645660; x=1788250460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwfxD6bJBOWO+LowhgDnFJHm0TT2/hBcMgOzrlGwEbc=;
        b=ezR0ImCDFAaIQo8oMcC0sCsSSqjZ0kJi49goF8+ZC/SOUO2ZFWku3rPIIC0PPtiok4
         qQIZxpivu9bDfyiufbzKUo4ZYTbJQadXa0pXXTiJO4VkaGayFmAIP1BNNKtPFQtCClxc
         uQ5+p5BaUYznmDwLNTAdxA6g+DsiW9JBANrAE334tDsEo7QpeOgkATayX78b/K0nKSbA
         BtDj7YRfWhLpXvPeE7GqncMx3ki+r8oXUO4YOEFokynZyzg4EpO+GJwjTEnlHtB/lj3o
         q/mDGa0ryXwSbR1cxDo28w9Oq2ucX1L/X8V4uBSqyzfJAe/49CeFhmPfRUi+poPSWgw0
         jBCA==
X-Forwarded-Encrypted: i=1; AHgh+RpPr163/QtQokYE6g68QuVezOjVrcI9gc34ff3SvkbCexw94VBOXL0lDG+uIqR81tZTS5bNDIA=@vger.kernel.org
X-Gm-Message-State: AFuF++m2K10qFOv8x1FqXqm18zubyj7app2KK/teYYr6HE4aTDnogs57
	0c1TrwyDfEvS3uSZ2Tvn3OIFs5slRXbMRYyJ6Tc2ATgYts3sTJ5ZihXxMzHRlz32PQ==
X-Gm-Gg: AR+sD13xSPBaJPLZcdw870mUqR1UirHv6noOtRXKMoNBDnO0B4GVxPlg5A2roARi+Bb
	To1ib3tdfNZeQmMzaT/RoupohRbKwUj5q17eEzBDdAx0XpG1GffdG32q6iY0lnB9lwDN5YBtAUI
	SfsSa52F8Yl0/RRiKuDQcwhqHzZtDybMkJCzYCfbxmHdnmLC/7nS6tpOaDqeRG4H168W9pGc46x
	k3Jh0CrffL7etK4nAXWUEx3SwN44ohm+K7LeIRegmHP6mEJCAoJMDtc+NHpMTt+Zyeztw1itlGg
	bpFV8qPeX8DXlsToqTW4zHr1C1OvLT7Wuh6+QrLnAERqBTuMba4TT8OFpGcOgcqvwUiWwDV/o8V
	sUm+lX673jeE2DW6ZLPaBNUP+nBRRy1x6VRbJFzaGgMXfLb9kiEvDPNc13S+llqthsc7SUN/LhL
	pTVw9s3DDBPFrkY0FIekkYWr48IpC7yWfGU2y4MmvalBGdzawqHPS7
X-Received: by 2002:a05:622a:1352:b0:52d:8679:ba94 with SMTP id d75a77b69052e-52e09aa1528mr236192961cf.0.1787645660427;
        Tue, 25 Aug 2026 01:14:20 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e0996b4a2sm64777831cf.3.2026.08.25.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:14:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
Date: Tue, 25 Aug 2026 04:14:03 -0400
Message-Id: <20260825081403.133992-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qdisc_get_stab() accepts a user-supplied size table, and
__qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
overhead, the size-table data (u16), and size_log (up to
STAB_SIZE_LOG_MAX). A crafted stab can therefore set qdisc_pkt_len()
to ~1 GiB for an ordinary skb. Per-flow deficit schedulers such as
DRR and ETS replenish one quantum per loop iteration; with a tiny
quantum (1) they spin billions of times under the qdisc lock,
producing a soft lockup / RCU stall as illustrated by vega@nebusec.ai.

Cap the final qdisc_pkt_len() to QDISC_PKT_LEN_MAX so the size-table
amplification cannot drive deficit schedulers into an unbounded loop.
A legitimate size table (e.g. qfq's overhead 999999999, which is
handled by dropping) is still accepted.

Introduce cap QDISC_PKT_LEN_MAX (1 << 20) = 1 MiB which is well above
any legitimate single-skb wire length: the largest current skb->len
is GSO_MAX_SIZE (524280), and an ATM-style size table (53/48 cell tax)
amplifies that to ~578 KB, both comfortably below 1 MiB. At the same
time, 1 MiB bounds the deficit refill loop to ~1M iterations per
packet with quantum=1, which completes in a few milliseconds well
under the demonstrated softlockup threshold (~10^9 iterations).

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_NET_SCH_DRR=y (or CONFIG_NET_SCH_ETS=y).
- Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
  amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=15, data=[32768]).
- Add a class with a tiny quantum of 1 and send one small packet; the
  deficit loop spins billions of times under the qdisc lock and trips
  the softlockup detector (panic with kernel.softlockup_panic=1).
- Reachable as root or from an unprivileged user in a fresh user+net
  namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Use a dedicated QDISC_PKT_LEN_MAX define in include/net/pkt_sched.h
  instead of GSO_MAX_SIZE (Jakub Kicinski, Eric Dumazet).
  __qdisc_calculate_pkt_len() deals with single-skb wire-length
  accounting, not GSO segments; GSO_MAX_SIZE is semantically wrong.
  QDISC_PKT_LEN_MAX = (1 << 20) = 1 MiB avoids truncating legitimate
  stab accounting (BIG TCP + ATM-style 53/48 table ~ 578 KB) while
  still bounding the deficit loop to ~1M iterations at quantum=1
  (completes in a few ms, well under the softlockup threshold of
  ~10^9 iterations).
---
 include/net/pkt_sched.h | 1 +
 net/sched/sch_api.c     | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 18a419cd9d94..90d3e7943b19 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -12,6 +12,7 @@
 
 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
+#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
 
 struct qdisc_walker {
 	int	stop;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..90503e59e6e3 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
 
 	pkt_len <<= stab->szopts.size_log;
 out:
-	if (unlikely(pkt_len < 1))
-		pkt_len = 1;
+	/* A size table can inflate qdisc_pkt_len() beyond any real packet
+	 * (via overhead, the data table, or size_log); cap it so deficit
+	 * schedulers such as DRR/ETS terminate their refill loops.
+	 */
+	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
 	qdisc_skb_cb(skb)->pkt_len = pkt_len;
 }
 
-- 
2.43.0

