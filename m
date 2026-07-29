Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A017A30A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294798; cv=none; b=cC1SRuG62oAZNvu7WsWHXqhL+OTIJQJF0pjKHCcvjVqdNi+/svLuqpOdmMkX8NhRSofpj7varEJ7//zMoLp6g2mRIcvHQAhlitcaLdvcQYSVR/kcvgEbktcj3ht9Sjc6mzDiZpQTJyvjaGtRLDbxcq/BjXrEhlD85fugTSc+WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294798; c=relaxed/simple;
	bh=+nXoE1JWimzLvKI33iYfZhwEL7/w5aGwIMdK9C1RKfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDvLDHYuMvgpZ1yUQvDhvQNdghdPc4INazCKihl9xEUJdV4KzNGHNuFz3B8CIYzaJcTS9J5XAcjboQNbQMore4JcpH7SUszMnzDT5VF6M+wJpCopciQ1RrAAGUTBy7bNmoHt8LUnvwO54BnY36D7MW9kXSg+vf7m3gGmJj+XQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxeAV1MQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxeAV1MQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848743155bcso195207b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294797; x=1785899597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=cxeAV1MQOkuN73Qvm5DgsYuRuLpc5hymuqmBL+I/UJV/g2z3aUueZuyY3qT9kUj0Ug
         T61uZl2xrTuBl5rGqVounYcaLNNdZRgmMRcspG/HiZvku5yU5jJw4ZgDUNhr8ERnzCiJ
         Yw2xuGtjoAzA7XDQc2Kqp1ekZywFKVALAblH0ZOvxiOP6jHreBNCb55IlGdTT1SkB0ey
         Jlv7FgkJ85NNRnPO0Xf5J76H+roopau5s9CZDXRCWuLRURaPO9/Ri8tgkp8sSwuXvDjw
         vs9itxlLYJNZ2svZYo3k+GdN2N7Zc9jrx+r+RQQfbVAiR9C2J6y+rTYdGzRdlfLmfQRu
         MqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294797; x=1785899597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=I1LWIo7TKGwKyiHZZFyoqIvG4nNn6I7lIcpeq9/QLKPzqu6ilkgjo69LoPAwbj+aDn
         0Ox8WtuUTg08jJffUng8OaKWr7yvCruxLG/c1csus7STXLZVT8HvViQcqfWd4ewSXLuD
         U4btKM/Zbg1iSAV1ONzD6nDxUkxCTwDRygck3EqYnihO5bpoWkDYeL18VJiHOsTaboIj
         rfsq09T7jckGIWCNQ2vV2fk3al8wT8J38U15aQnXRe2o0oGQWFyLDCYbXeAL5JJdEQhj
         Si5rVdT7c+p8UGsnq5QZRpPSE8lZzSaQ7R3SkcqpGgvxfn4+Lodwupgf7JZoW8LtiW+c
         Wyjw==
X-Forwarded-Encrypted: i=1; AHgh+RpWOg3qD9yeWf+OMIokzdok0fFPsMGr+gc1m4yktIH83NCa+iE1oV7ffYLdBTUKcejOBQ+0M3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhriGKhB3VcSgRsmoxCWNKzaNXNEj9C70jATJFyfzNbCsRi9OC
	cqPFgWJX/u2I1JJJCVBXbAh63iHwrc/0qMVQrYJSb2BUCyTyhM8QTXMT
X-Gm-Gg: AR+sD12qkp0Cse4gezdOR4+i+Ek0uEqVSbd0VlSGn96ZlCF1GogK7ER/sPlUeW0o8e1
	yF41KESEgc3tht07bHXQYD5u2p0eu4TZuFA3jsyNaCvXePbHcIOD+9rX3meDo17aIdF1jt2j3CZ
	ZFqDsSFzhqByIKhbtod/Ywhq7MyCktAfXu2PymGr4AoPO4VyVsd6YUAoB96TSnK/52J+XwI5V8A
	v1hStEN8XkoyHtFE0QD1dgchGN43YkugOD7TqPkTEBYDjIvz+yXgILKxmCbBc+Yf10hqvYvCd12
	hRZZKsfgkMwVYdeeEhw2vQsMm7Yr9aboXyOv83Dt7pAE1NebmmGfXjh+KCLc3Xy4chSw3BuZXgE
	td41pRk/5MUBjAA4URHs+GOqXeFQmwM7FeULmhvhWwU3RwZTREUc58bLIO+oe3xze+hvTtDN4zv
	h1ATWr9yp7jq9sL1Gra7zqcr1gLaeT+E9cIKXnAFFamI+I/3w+4OmLOug3rJxc4WKC+v2NMBhuS
	JyM1IhVZw==
X-Received: by 2002:a05:6a00:3992:b0:848:7f8a:8d0e with SMTP id d2e1a72fcca58-84e932c5f3emr4770346b3a.55.1785294796609;
        Tue, 28 Jul 2026 20:13:16 -0700 (PDT)
Received: from localhost.localdomain ([116.105.227.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm667639b3a.8.2026.07.28.20.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:13:15 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuejie Shi <syjcnss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pktgen: fix out-of-bounds write in pktgen_finalize_skb()
Date: Wed, 29 Jul 2026 11:12:52 +0800
Message-ID: <20260729031252.54476-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_finalize_skb() spreads `datalen` bytes over `frags` page
fragments, but the loop that fills skb_shinfo(skb)->frags[] is bounded
only by `datalen > 0` -- there is no `i < frags` check.  The
per-fragment length is computed once with a truncating division:

	frag_len = min_t(int, datalen / frags, PAGE_SIZE);

The code just above has already capped datalen at frags * PAGE_SIZE, so
a valid partition does exist, but the truncation means the first
frags - 1 fragments can leave more than PAGE_SIZE behind, and the
last-fragment branch only consumes min(datalen, PAGE_SIZE).  Writing
datalen as q * frags + r with q = datalen / frags, the loop overruns
whenever

	q + r > PAGE_SIZE

because q + r bytes are still outstanding after frags - 1 iterations and
the final fragment can take only PAGE_SIZE of them.  The loop then runs
once more, with i == frags, and writes one element past the array.

frags is clamped to MAX_SKB_FRAGS (17) and frags[] is the last member of
struct skb_shared_info, which sits at the very end of the skb head
allocation, so writing frags[17] writes 16 bytes past that allocation.
With PAGE_SIZE == 4096 every pkt_size in [69675, 69689] hits it
(datalen = pkt_size - 58, giving q = 4095 and r >= 2):

  modprobe pktgen
  echo "add_device dummy0" > /proc/net/pktgen/kpktgend_0
  echo "frags 17"          > /proc/net/pktgen/dummy0
  echo "pkt_size 69675"    > /proc/net/pktgen/dummy0
  echo start               > /proc/net/pktgen/pgctrl

  BUG: KASAN: use-after-free in pktgen_finalize_skb+0x1e8/0x4a4 [pktgen]
  Write of size 8 at addr ffff0000c6b40000 by task kpktgend_0/97
   __asan_store8+0xe0/0xe4
   pktgen_finalize_skb+0x1e8/0x4a4 [pktgen]
   pktgen_thread_worker+0x1f3c/0x2d50 [pktgen]
   kthread+0x1c4/0x1e0
  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 pfn:0x106b40

nr_frags ends up at 18 as well, so skb_release_data() later walks one
entry past the array too.

Compute the fragment length with DIV_ROUND_UP() instead.  datalen is
still <= frags * PAGE_SIZE so the result cannot exceed PAGE_SIZE, but
the fragments now cover datalen exactly and the loop always terminates
on the last one.  As a side effect pktgen stops emitting zero-length
fragments when datalen < frags.  Bound the loop with `i < frags` as
well, so that a future arithmetic mistake cannot walk off the array
again.

Reaching this needs real root: pktgen creates its /proc/net/pktgen
entries with proc_mkdir()/proc_create_data() at mode 0600 owned by
global root, so unlike /proc/net itself they are not remapped to the
owner of a user namespace, and the module has to be loaded first.  It is
still a plain heap overflow behind a documented interface.

Fixes: 7d36a991e8d3 ("pktgen: create num frags requested")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 net/core/pktgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..2dbb7caacd0d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2843,8 +2843,8 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 		}
 
 		i = 0;
-		frag_len = min_t(int, datalen / frags, PAGE_SIZE);
-		while (datalen > 0) {
+		frag_len = min_t(int, DIV_ROUND_UP(datalen, frags), PAGE_SIZE);
+		while (datalen > 0 && i < frags) {
 			if (unlikely(!pkt_dev->page)) {
 				int node = numa_node_id();
 
--
2.51.0
