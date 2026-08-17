Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345F3C3F70
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957443; cv=none; b=D3WqvwSBdc3hfEn5NtdwpYn3kF55z90MGa3viNrFA8ADRjPGy7rkgs/ENMxftk7gzFCcKSAU9rTZtGIRa3Za8uLGmXklw4dU5NPAIqTud5l8Qoltviu6tIrIWueHYX9lAiEQ8/i2wRT9O4BNQzMOgiAgqYon6eZqmRjjT6mr20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957443; c=relaxed/simple;
	bh=W2PxdTIuJ5LHF/IMnebkVsvR7qjLz3RJEHJoN800q1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqDEld+A8gw8YuhoFDy47QzBeogx3R1+cf80GRLpgGYTrcdJCkE+Z3ITgaX4PiEBCk0rgityYwytQc7nBXkZK77j3YNh79bDo2leHUkKo5RqKYjT0z+dDEd/HwZfwvflUbXWFxTU8E+XO8bSSBQy6AJIHfqJKDZVOeevgshHQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWA4Kfhx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWA4Kfhx"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848643382fcso3196558b3a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786957442; x=1787562242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2uhz0qtH2rdwkxROqvYm518UOZqAraZAM2LKzgDTDA=;
        b=rWA4KfhxcYLwociHWmNI+oXPgGb1Yx/O06GJVX3ZGrwrLFGES2xfm2JsPnPbKuMpDy
         jo3vmsuXAJXKN7WGqV+x3IZc3TD1xx9+dmme1qVdYYuP7Kpqe4mrwDzUHLlkQyzUVjNc
         YjwtRleMlicyUNDAK7Abm+tgSYOLgm/48tkjrlKlsRpy4oj0PGxFaHU/ST1fXzZivj0v
         4eOrjEmGXf6lCMM/gNkuIw8+SErmpEo6CLLd37Th0ewuhnepzxpsjanYTVdHunC81rRz
         PrL4TOhcHpuWwm3Ned2NIwqxusDZWFxgs/JdlXFEfculdzEgvMtc65yMSPlv7l02BPlJ
         Iijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957442; x=1787562242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2uhz0qtH2rdwkxROqvYm518UOZqAraZAM2LKzgDTDA=;
        b=UL9aJlOwi/JkIKqY5nLhZF+IOJWIRu+0KbNzFy3rxU7VgfP7HyeV/4dowUMOdO9PM8
         pNsd/R04mhTBRFfv8MJwlRlxa1shMpkvXwsa7zWa75V7d+gyd0enZ5tcouwpeFgnii2m
         OqNLhmkCRPeXSspqUt/Sx2voEapo88Xeidx7SjqxpQQ/kJUTxCnR9o93ofuwpsV3IIoD
         A+xCMtxhRX+/AB28fWXIBjquEKobAt0OMywAG1hJOTED75poqgDJbGHFmefAlPbaOgbB
         Uj3b+SeWZ9uNCcpir3iD6iEpuX0MUxix13L1H9pxXZc4vPDxfAkzwrSIv9s2Sx4lHDo7
         oA4g==
X-Forwarded-Encrypted: i=1; AHgh+RrTCwdn6QD0N/OhnCmdckBncmgDC4CJo7v/YBPMWKTzfZZSUmE3MP6JKpd/oI9wEQv6ti6MZqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTO/fI1dxic0T/NXJhbbyRP2JafxV1U/dybH+9XkbOnGLxAg1B
	fCdKLnX6xLxOazesSNVgfTz7gyNelCRaK/rlyQCRl6GAUjKO+21+BVYz
X-Gm-Gg: AR+sD126wqcSRTH4Blm3K8mI8zo9kBj4CKjBVws/Fd/Z1vl2/aq9+nZzwGuztrRSjOf
	EZfwpZN86pMjLvLY60RNo20FH+eBF59Kn37Vl/+B6iHC1+/lSk67rGKaacVMoLYKby5RnQFrz92
	/81kyLDSiEgIy34usdCIfYGe3PvDSMA5vkHJOh3optvfyQ77IWBizh39U9rAaAvmWKoZ0XEDnKa
	KPPZfbZOEr6p34qrdVNYizF6Ump1tkN4Uh53hOGutwBAPqSeRnJauv90NFVwwB6fpet8WDVBBP0
	gk/eaTCUhtTbsvMr/4VIDE2voBrRghIlFNXkzjFBKeVIllpXnkhNuq5CTw/PtdlYzfO8P9aRoJG
	krGJUG11glujA1QlDlAt5IzcmqgsSJQPbE7O6h3ifW1A5eI7r1t+cfbRkHdye+BrAEmrr/WQKKR
	Ij+BT8FsWbRSsmVVw6YBuVaqmvtL6i4o2bTLFA75OgZYHXWHEDFQeA+A3lpvmT82WFcs5t88kH8
	ooTGyAIVpOhjxXEuozW/Ik=
X-Received: by 2002:a05:6a00:b4f:b0:845:c7f1:29fa with SMTP id d2e1a72fcca58-84fde330ca8mr23049775b3a.30.1786957441665;
        Mon, 17 Aug 2026 02:04:01 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2476easm2342517b3a.42.2026.08.17.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:04:01 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] tcp: do not inherit out_of_order_queue from parent
Date: Mon, 17 Aug 2026 18:03:17 +0900
Message-ID: <20260817090319.3897799-4-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817090319.3897799-1-imv4bel@gmail.com>
References: <20260817090319.3897799-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child gets a copy of the parent's out_of_order_queue, which can be non
empty when/if parent morphs from listener to active session. Parent and
child then point at the same rbtree.

The parent is no longer a listener, so inet_csk_reqsk_queue_add() forgets
the child immediately, and tcp_disconnect() frees the skbs the parent
still owns. The parent's own root and ooo_last_skb are left alone, so it
keeps using those skbs. That is a use-after-free, and the parent frees
them a second time when it closes.

We need to make sure this can not happen, by initializing the queue after
socket cloning.

Very similar to commit 8b485ce69876 ("tcp: do not inherit fastopen_req
from parent")

Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b43173..d13813d50947dd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -591,6 +591,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
+	newtp->out_of_order_queue = RB_ROOT;
 	WRITE_ONCE(newtp->write_seq, newtp->pushed_seq = treq->snt_isn + 1);
 
 	if (sock_flag(newsk, SOCK_KEEPOPEN))
-- 
2.43.0

