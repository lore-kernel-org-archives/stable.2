Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788430;
	b=aMtgSUy5dmtduYwvv6peRzh8oXUXmrTICaQnHkJFydh2orzVfdB7EVWVaRsvLGjOriNG
	 BJ6iD5cit57ONobOS7yB1HbordqV734E98ZKk9xNxbfkyM1EhdIk2Gf+RAYiM/S0tHOFO
	 LfHJf0rbmQIrAVLxP965zBFLbkBoogXgBROJOuSD3KGdBuByW4g93o57iJ3QtEl2GXMd5
	 YOyjNxrp8OiuwPia9n39ugilunIj+vUDZiycCCCZQK7BXApSNo5pBa4QDoZm5pbvd8D7a
	 6p02q+gZlfbjtotXXQXKu/8RMmhbRJzW0hoeY+y68q8LBFiKMqMKF5WmW9mYiDNwlkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
	b=0kHgIBg11YyC/vnLxtk+K72nvqrVx5zM9lpGclEsUqGvOMC0nCmo6d7SAbnkATtM6StU
	 0Irb0tcnppYDWujZQLl3D89rkaXATjzemX8UIsFUAP39BexBG8Tn/I4d7D3nKgOhgI7hL
	 utc7EX/VN9AsxIPtcSMoponZA4emojuTQaezlQdHGl4rPzGfqj3FJD4p5JsnHdtkZK5YX
	 UelWYLd3n1FzomBjFJcLui7Lh2/zPL2+nmvvIPZQR375QtZ2xqFnqyGt/RVdS0HlgCFBA
	 YET1lBKlygWqAW0v3eSwMXeyosD8qWtouVXt5dYrrcJj0UprNegBSCofrWos5gEp6vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="V8c5K/e+";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D8606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9D8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V8c5K/e+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a064f294cbso1035851b3a.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788429; x=1793393229; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
        b=V8c5K/e+wW0CaDapSsM1QWQpymmKnF2LTar/d5t91pBrzlY5j4HFDrApsLX0aNwNik
         yKgazbyKwgnMV7P6EBb7yPPqzgq4TVV1P1iyDkGuPYoGFxHD7rumtJOwcbAY8AaVTTjo
         EUCri0Iw2Ka8YitLlEopvJWuDf4MU71+79rmqIk7p59sMQLtttTViPXmEdX+oAuQXse8
         R7yFjcdQnRIgv7iA1qE/zUOl08ys5xyPfAsYihPCdeNJpqt4VNoyICVAYKki798pa0rh
         +zOCIE4kYf110o6APAkqA7NAD7UaX6jf+PkshSCA5ea9ziUGJh1HzX1FFe2IAzZm91TB
         vbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788429; x=1793393229;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
        b=GLrcUg9rjtqNftJs36R2PDHoJqW1/vB4kKKBOoCzGTAl9aPdgJJPxApnU/n3vYlqrk
         PaFkeJo5JZIeq/URp1+FVsZIGsk1hsf9YKfpVEqnLm1bb5unlHTLbJkZVEopLTcp35D6
         vefyZAgYT7C0fhSNfr47aPXLzGXJU6w4k+R48uG+7lYg0ub84oEDu6UVNdjvolYckHfL
         bnAYBnkGyIYLmi1ec2WBVq57xSsUd5bYy4PiCBCh62o7wpxWk1/29ybC7vovsz1lIaTe
         nu0aIB6vKk2Nfga94D2Po9jJh7zVuBwdI4gvkGSxUYGhl02ULd1qSN2Vz6DGhCG61kR7
         4wMw==
X-Forwarded-Encrypted: i=1; AKwUvBw77Z/2bDkT1TSjMM2TvD8IOWo+76iEPIkr9s9YBCXwiq2ma4TlMlzNKoiI2unKU+Xumf7hBuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrP+Mb2PzptbavxCvDSQz4YV5xNt8hFfOrzFQtDRPinWIyDK1F
	yNrk26/4EH/3bJVfewt5jU0eqZGMBqU02/Y44A/EchrdId0M+2XXOhZBIWnjmUxy5EHfGlVtwY/
	p6GV35Qpg05kPkFYY8KFAWipTyw==
X-Received: from pfww6-n2.prod.google.com ([2002:a05:6a00:8886:20b0:890:ac21:250c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3f95:b0:3e2:aa08:8040 with SMTP id adf61e73a8af0-3e7cd4f4b9dmr123609637.46.1792788428424;
 Fri, 23 Oct 2026 13:47:08 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:02 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-1-hramamurthy@google.com>
Subject: [PATCH net v3 0/4] gve: Fixes for issues discovered via net selftests
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
 drivers/net/ethernet/google/gve/gve_main.c   | 179 ++++++++++++++-----
 3 files changed, 148 insertions(+), 43 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.257.gf7497c7d27-goog

