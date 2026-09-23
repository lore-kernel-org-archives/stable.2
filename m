Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675A413D69
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139669; cv=none; b=Xvih0Py4GjS+tT5CIvYC4DdGQcBrD7OQfg5k2vFaPtF6AFZ4jecAQCOKXZayivkZzREFWvvKyUQIMjleD/9tSwkylqYzMsTKNB3fvspYAeHU+7SAlCcBfv4T5AmrbZPlPmM9oqCHpHrKuoeseWjJ7PMKZH81m20/PxeMQthijdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139669; c=relaxed/simple;
	bh=3Wt4vaXgpJ07BzG3GRaYPsiQ1wSvJQGkF4Kt5Eb0wZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIjcqCQLOJzZJfv5YFMLuc7yBMfpGfMi4c8gSv6qQh407m2mPKBjPn6oKGHhK5uGmRFeIuqIVVORsDjpkyGNdkUDC4RT/wV0DmQfz6KCWDkhPRDrR44YA0GB8dW58oYuNdkJxvb7Uy25efkNdbXu9hmvZkQYMaA7i5kQ7vuUisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYCLwUpQ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCLwUpQ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so402315a91.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139666; x=1790744466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=48k6v6NifxtRfKJd71IZC0IPKrpSgd0Jky0oMiBW2kw=;
        b=UYCLwUpQx6iLZytjKf9/7qvUxk3+qdM3y+QUfTIGMa/SQRg2Pow2xQHF3plxm11tsG
         c66+VHI6I7JF8HuZMQ/mXzOWOFsO432GeIHC0K8SQEYiksCSdcOr/kc+nm1GAco9j8UE
         /SmAjewC3kKeFr1y8o4IMyESPF30VADCU/4Szr8mM09AqR1il4m6ekeO/lErFqMwyonj
         9qlrbUafANqvpBIZKNA++/6r/N2FOskjO/6sWEz+djM/sgiNqcpSYaO9j0F61ph5oCUH
         0Erj95p3fhQUgKHf/+toWKGfF/EiCQo5yVUQbS7+9LxeNFSS6SKjSai9+vAokCBN4slD
         nBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139666; x=1790744466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48k6v6NifxtRfKJd71IZC0IPKrpSgd0Jky0oMiBW2kw=;
        b=KqIOtV7mROjR/82qlAv0956HlzO+KD4qxyQzVDjWs20vIudaYbRNnODBdl2w2wxYn6
         ad1jzKXTKz6mYfmszwHwqm5cBu52tUanSg0gpLNUUOW1LOwkurOfdcitbAjGvua/ohuB
         RYkuzqI5YyjQSkx4E0BW+mplsDAz6NXStExKfCXki5JRnw8iKLJLM7tQV7BDwoSncjwj
         1eSYJHLTpgQ+FgOXq5xbEb1HDcYy8Wpgx1GfmQ2YAjkVWX61XWnzNOw8nqursHaGWDkC
         aXldIu7WWvxmidQk5lvhrVCLliP8/4+0Elm9y3EXVb1QK5bdBUhhp/AXYgWJ/gZUfG2o
         mhzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHylRD/7wUvHtLRcJPkMZ10O+O/n/lSh8bfD28VQQWFxoiwkZS1obEHMGM5BUhNLyHAlulRXs=@vger.kernel.org
X-Gm-Message-State: AFuF++lM93chnKVre8yD4nFgp20cnnZNit1WsRFF/SI6nnhBxOf6bc4B
	6h1O4cWa4qLcmJ0051ZXkeYa/pMiDPeWMZ9aXZVaqoahsHZyh47CujAy
X-Gm-Gg: AYBFou1PRDEzuzubQW+/m3PN0lhMrakBINJYP7bgcJqmNvod6ytNc7EGhbNzjg6q9Ih
	MIpw916Ev5f/05vo5/faPuPAqMqNVDEd0WA8nhaZgv0O/krKZaxrU+lN9JPmCCAiWuZKL5UVsVU
	qVtV3U/8JxHiw79dAVGvJwLJW5jeZnVhMQiUd6u87ZxayR6gYoP2rWbKr3FhCv6miKRe1QFHmtc
	ZydCOmdtJ28wYxGhGPsjMlBuDeXq1J4BECIwZ5NGlY7FIUV14phx+sdPjO9FO1UobR1A6WXhWS7
	aCJt/VViXZYJXBbw0Xhk3gwhs1A64sp8U8fVekkhQAriPVEYMpPNBcaZNCKsWDvY/dBCFjvLfQG
	2URWn/XzLJbP+/ahcIv0kR6ZDDGiDSqAuHHj0xrlHyKVbAgbQQ0nqKUMKZcybfMxcPnlZYU4MAR
	56nKJ3DfXmh6DhziI2BatIdzxrrOaWr2mop0w8f50LJ8T8FhAIequFAbZSnHW0utLzE/5RMig=
X-Received: by 2002:a17:90b:50ce:b0:39d:ecb6:8d40 with SMTP id 98e67ed59e1d1-3a07e4e41e3mr1192709a91.4.1790139666021;
        Tue, 22 Sep 2026 22:01:06 -0700 (PDT)
Received: from localhost ([180.184.92.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc74977sm2767429a91.17.2026.09.22.22.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:01:05 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: netdev@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org
Subject: [PATCH net v2] af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
Date: Wed, 23 Sep 2026 13:01:01 +0800
Message-ID: <20260923050101.1510064-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prb_calc_retire_blk_tmo() computes in 32-bit int arithmetic:

        mbits = (blk_size_in_bytes * 8) / (1024 * 1024);

If I'm reading the validation right, tp_block_size is user
controlled and packet_set_ring() only rejects values that are <= 0
as int or not page aligned, so a 256MiB block goes right through
(and alloc_one_pg_vec_page() even has a vzalloc fallback for it).
0x10000000 * 8 wraps to INT_MIN, and on a NIC reporting 1 Gbps
(div == 1) the function ends up returning -2047.

The condition is actually (8 * size) mod 2^32 >= 2^31 && div == 1,
so the trigger set is [256,512), [768,1024), [1280,1536) and
[1792,2048) MiB. Other sizes wrap to non-negative values and faster
links divide the unsigned value back below 2^31, which is why this
doesn't blow up for everyone.

What makes it fatal is what happens next in init_prb_bdqc():

        p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(...));
        hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
                      HRTIMER_MODE_REL_SOFT);

A negative relative timeout expires immediately. The callback
unconditionally returns HRTIMER_RESTART, and hrtimer_forward() turns
the negative interval into hrtimer_resolution:

        if (interval < hrtimer_resolution)
                interval = hrtimer_resolution;

So the SOFT timer re-fires at the maximum rate forever, holding
sk_receive_queue.lock each pass. One CPU spins in softirq until the
socket is closed. Repeat with more rings and the machine is gone.

The overflow itself is ancient - it was introduced together with
TPACKET_V3 in f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer
implementation."). Its effect prior to f7460d2989fa ("net:
af_packet: Use hrtimer to do the retire operation", v6.18) was not
as clear-cut, though: the return value was stored into an unsigned
short retire_blk_tov, so a negative result was truncated, and a
0-jiffy delay loop could be programmed as well. Neither is nearly
as detrimental as the immediate maximum-rate spin the hrtimer
conversion turned it into.

(Unrelated to CVE-2019-20812 - that one was the ethtool failure path
returning 0, which now returns DEFAULT_PRB_RETIRE_TOV.)

Reproducer, needs CAP_NET_RAW (a --network host container has it by
default) and a 1 Gbps NIC (QEMU e1000 works):

        int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
        bind(fd, ...);
        int v = TPACKET_V3;
        setsockopt(fd, SOL_PACKET, PACKET_VERSION, &v, sizeof(v));
        struct tpacket_req3 req = {
                .tp_block_size = 0x10000000,
                .tp_block_nr = 1,
                .tp_frame_size = 2048,
                .tp_frame_nr = 0x10000000 / 2048,
                .tp_retire_blk_tov = 0,
        };
        setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));

Compute in 64 bits instead. The operands are already bounded by the
existing validation, so nothing else changes. If you'd prefer a
different fix, just say so and I'll respin.

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
v1 -> v2:
- Fixes: now points to f6fb8f100b80, the original TPACKET_V3
  commit, per Willem's review;
- pre-hrtimer effect description corrected (unsigned short
  truncation / 0-jiffy loop, not "timer effectively never fired").
- v1: https://lore.kernel.org/netdev/20260921192608.1420047-1-zhangdairui@gmail.com/

First patch to netdev, and compile-tested only - I don't have a
1 Gbps setup to trigger it live. If I've misread the code, got the
Fixes: tag wrong, or picked the wrong fix, please say so and I'll
respin.

 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b22cda3..24cf2d2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -617,7 +617,7 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 		return DEFAULT_PRB_RETIRE_TOV;
 
 	div = ecmd.base.speed / 1000;
-	mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
+	mbits = (u64)blk_size_in_bytes * 8 / (1024 * 1024);
 
 	if (div)
 		mbits /= div;
