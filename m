Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308598;
	b=Bx2RMcm5sRJmEuGKQr2mguaxaoztx8l05RAVyBgTh5I9nidDa/dQk/W0NX05fsx3CJMf
	 QWi0csaJ2QO033SlbrWGrMpFR78Th0Pm4hbF+670AFqDN//e9mqu+rJoGV35qyW/iJXam
	 AFop/6jpFSb96dfIaKKD9eCH3sPORHSyCJ73PEs7rbIKJ8jvfr+EyqC+fRi4uuiF3eV59
	 KsTowkmCeCAzbR9OLbRiker7IsQaAQpADGoVtlZyTZ9W3WdC1BDYoE3+irjxKnJ/WqBC+
	 HdLXuiLeDhhbzjyALKlKG+R7yTxVqB8gN3jF7kyQmiHFUqkZTsS/g5vYgZ5XKZXxccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
	b=UQDT6N2GoZkLyLhvsU+VEJYL3VT3uZHgG3c56KoVaIDuODZpwt4p3cHO0X63L3e+L/+x
	 9mkPBVSk/HJUEQySJ13V/WarSabl1E+Qkgso4wBaHW3eHJyHI+fD1s4p6KCKG3aeguaFV
	 5bhle4RZdrJVxo8HX1GHxT2pTPvuY2eRnBEqBbpnoevZN5Wk8dG0A8jDk3eXsPoDxan+P
	 xN/R1t3DFxNz8Cg1D3cC8UTZNRf3or/PQ3qAHmGI89gxluKSSlQo9fGEI4WomJsOAaMCk
	 cXjunwwno0qr/+sHQnheOFJXwnGtqLwHvfzFH1HeGU9E3bdQzJIKpKSPCfhZATKLzag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="atZNhZ/U";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9991606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9991606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=atZNhZ/U
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd8b299b05fso15452a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308597; x=1793913397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
        b=atZNhZ/UYenKl9MgfO5lr4mCFScIBwntXXKKbhvgKGtqlXwccK1D9P/lDkCrP+QSFT
         Z9tJwyAKoSDWte1iCLZehkckSRknrdUTGW2HZWMO3JeiDPZeHEtwQKhr1A1xItiolSWb
         GXAaXRwgOTAZz3w+5rrBqqlCfG9/8JpzYo2dHSdKZHnDpkZeXTunNviYQ8egscW+HomG
         6J1VXxWr5XDX2+dtUz/6tHKcDyYcPBHaPdJcvUUqe6o2lCEVCp7pF7/mp9uU9ra+yb50
         KjruQdYv7mrOzYXzcX0kQQM6UadQVyp4/9T/1k1qHPTSUaMdQz49khQWt9Yv2fZTqG8R
         9OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308597; x=1793913397;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
        b=ihIM6JDSgbf8311ve6Vo7I6M3e180jeA2uNCpCpLIuDzuuUiPVjxkUxxVNIxke+eW0
         4b6Hu2NdCjUxfaDZZin1IhtO1Hk+9POlSH2/gWidCN3wACZV5NrAWq7rmNR2bsv64NUM
         8xzySyWP4zzwqIMI99H5YRj/uqsHtpfakgk3/SerT9VnM3Y77HOJb9yLKiknZdmHzqH4
         PXH9saMcZx/YdWos2MO7OWNo2Ef6S8bzdoUsrPU5Z7LvtA1uKdvk01K8hHVI8qw5tcH5
         cRlO/6nPyfvYKTlYivmBuh9juEYPjvc3jqrZ1qvB9tFc8qf/KXKEzc2Memw5SVgorNeJ
         mEDw==
X-Forwarded-Encrypted: i=1; AKwUvByEaf55gm05BSa7lGr7Ndv4IRo0hPbp29JbmEv1h/JfXewHthAJqz0P5SisPu7Nw3W6jS2QtbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZzZBmextrocWGW9Mh00OEM/I1KoJBW8Do2Qv7wLRtR88T7ZjI
	tCSeiN/0NYfqnY7LIT3bq2PV4lWh8xLYLnTZ6V/Q5jJpcAtSl6ALMP9JmMjriNE9OnSewBHDc9i
	oUlmE0dMNh8VNIMn4IZiT1ISgew==
X-Received: from pfaq14.prod.google.com ([2002:a05:6a00:a88e:b0:89b:34dc:b094])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3b44:b0:3e2:8f5b:8ba6 with SMTP id adf61e73a8af0-3e9286461e6mr403587637.2.1793308596954;
 Thu, 29 Oct 2026 14:16:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:30 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029211634.2232784-1-hramamurthy@google.com>
Subject: [PATCH net v4 0/4] gve: Fixes for issues discovered via net selftests
 and Sashiko
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of
these fixes were either uncovered by running the net selftests or
suggested by Sashiko in the previous version.

The series includes the following changes:

- Patch 1 introduces a spinlock (stats_lock) to robustly synchronize stats
  queries (including ndo_get_stats64 and queue stats) against queue
  teardown and restart, preventing UAF and out-of-bounds reads. This was
  discovered by the drivers/net/stats.py selftest.
- Patch 2 fixes an issue where interface stats would go backwards when the
  interface was brought down or its configuration was adjusted. This was
  also discovered by the drivers/net/stats.py selftest.
- Patch 3 ensures the driver falls back to the default minimum ring size if
  the corresponding device option values are exposed as 0. This prevents
  userspace from configuring unexpectedly small ring sizes. This was
  discovered by the drivers/net/ring_reconfig.py selftest.
- Patch 4 makes sure ethtool configuration modifications are done
  synchronously before returning to the userspace. This was discovered by
  the drivers/net/ping.py selftest.

Changes in v4:
- Link to v3: https://lore.kernel.org/netdev/20261023204706.3112215-1-hramamurthy@google.com/
- Patch 1: Clarify the commit message and change the Fixes tag (Sashiko)
- Patch 2: Report the live XDP TX ring counters in the base stats and
  take stats_lock around the priv->rx[idx] writes in
  gve_rx_queue_start() (Sashiko)
- Patch 4: Take netdev_lock() around the link status update in
  gve_service_task() (Sashiko)

Changes in v3:
- Link to v2: https://lore.kernel.org/netdev/20260425002450.163421-1-hramamurthy@google.com/
- Protect all stats queries and queue lifecycle updates with a spinlock
  (Sashiko)
- Drop u64_stats_sync for the base stats and use the spinlock instead
- Save base stats in gve_queues_mem_remove() and gve_rx_queue_stop()
- Drop unused rx_dropped and tx_dropped accumulation in
  gve_add_base_stats()
- Fix the Fixes tag of patch 4
- Refined the commit messages
- Rebased to the latest net tree

Changes in v2:
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

Debarghya Kundu (1):
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (3):
  gve: Fix race between stats query and queue reconfig
  gve: Block invalid ring sizes when device options are 0
  gve: Fix link flap after ethtool ops

 drivers/net/ethernet/google/gve/gve.h        |   8 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 236 ++++++++++++++-----
 3 files changed, 191 insertions(+), 57 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.307.g5fe7bd680c-goog

