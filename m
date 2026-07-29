Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF022517A5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294717; cv=none; b=kGPQB6h3882LA9d7Hw2l6G0wQZHBZUgp6kSMhY8FJa3r92iJ5aG9WY9Eii3OYDN9PuL4vTeMxZLnANhlw5JQ4aMvCPAQ5NDDvXxSCiQLhUn8M22AsTf98KYEiO1YS06rOj1R9oyOkZUqVEQflU6ydjZ7KCGdinrGGoS7d/w0iqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294717; c=relaxed/simple;
	bh=+nXoE1JWimzLvKI33iYfZhwEL7/w5aGwIMdK9C1RKfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DasyKGkqA7TZV8w+X0pTMNWpBPCTzTQvLvwJUAGGHbEgN17ms92mhdM0UZDZKg3eYzh/JUaHdVjF6oP1sHqHnAXgdHaAqy05ACOICcgqJ4huSub5UAfIot4Xnkk05JGUXqyd07Qm9DzFgw6Km1Mi/YhBGVr2Uz+lodqUCTpcNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwVw3nXN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwVw3nXN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso521979b3a.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294715; x=1785899515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=AwVw3nXN7OzS3uRncKMg4Wnezb4Cp1+ykOYYlu0IMomn2lS+aOmo+LAv8lvD9jC0oV
         WhVvORpXjLWLFOmKAEpYZzDdJ58XfKkSPXVD2Pwv590wdnnLWDW2M0DAYZrk151TS2xL
         z3JL+g0zuerdedyFmJxEVGvSBaO7pRpNbdC8Wp53SHNi+h8nK2GRmCUrqDD1P1yv8QT2
         qhFPqY9V/cKsYPb/KZeEhXnT8N7vbIWn0Pttywg0c/3J2vh/u0xUz45hv/OGC5Hh9oQc
         fTxDFA9CZMZEqllvvvX1/5hvOdRozvF0fZQ90oUO+sR9QnFTxqct+z3U/wqmvCcqk88u
         4qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294715; x=1785899515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67fzthwbCndyMuuC4hWnqiqs2nS3TAADY1dtDD/lCeQ=;
        b=nSXZG+W5xiRC9a3gQHVRzpYIaQd0A1qg+yOWJCORPMbC5ww3FT4DKnZVGLI3D8CoKf
         zTfPg5BF8rq3fyjpzP4B0kCaS3CWnFHhswtvIGCo8NEKIu4XsRGxZjqJkvYwrh+R2/pr
         oaz5ZqZ9XI+BPEtUw1Ll5ZPIEww2nhyOjtxJegRrLHM1OLLsDeMfFlq3gTbYVDSMQ1Ww
         /+Ij+MndoSQQeUYKa94w7d0wdDHbkGLDIVbuhZlna8Ufp0SWe0KE4LtWB1uo4uakVKDq
         afjwKpHoyFSp4+oW2rg9LDecfEa2y8Dse/nQyvNyMIwHSC6Fm4fOljpTcXzDrKCqYWP9
         itIw==
X-Gm-Message-State: AOJu0YwywxUqTnu3i72kAe5gnhplqbIWMXal/vpNMDEcwbew0qiqypuK
	EJoPwpvSOrYPCHOaql7I4JiEhGe0Ws8xIL53yEnxA+64YFceoPBx+wncyQH4Yg==
X-Gm-Gg: AR+sD10gGvDvPW9WmJH2ilmQxKsrkmgCZWWtjyvOdAuxb3aZ7H7ilKFSkEvcQMjJjGm
	UhgFxeMvXh+9CvJKKGYpcPoRAUMOXwzc9RCER5WwgYVUnL6ZIb8DxqS+/37Roh/UBLa29Isu/VU
	SvTu6BFWR5n8fa5YMI9tEEJbNfBI9m25WvyRFDaWh7j6djmPZMublj6fkbIlLv9CPcx9AKWJ+Wr
	to7X2oE3kBke9DdD3e3s0RbimDDL4aMLBM6B0II4BlF9FI8yTjpX1rM+5+jCALn+NiFtAXHgWrM
	VO8ETnT7hJcmD0zypzQUmv4/YbiKb831bAxMeJPp0EsI9beZiPLOytw/oXojVVhgBjbqyy+eW3q
	EJlokBkUwioTO/LDWk69VKVdFcAnq28KT9MURU9fg0VNhiqTbT54ESknM225fVHUCFtK/NXwgM5
	H3pXQMrkpVdpGAaC2/9gsijU6upikM0W3+w2Ag4QYt60SnhxkDd7Zi8vUkorI34MXOnkLLwh08H
	JQ3wFSzZw==
X-Received: by 2002:a05:6a00:4197:b0:847:88eb:1e08 with SMTP id d2e1a72fcca58-84e9335ff4fmr5513299b3a.53.1785294715398;
        Tue, 28 Jul 2026 20:11:55 -0700 (PDT)
Received: from localhost.localdomain ([116.105.227.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03767bbsm642456b3a.47.2026.07.28.20.11.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:11:54 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: syjcnss@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH net] net: pktgen: fix out-of-bounds write in pktgen_finalize_skb()
Date: Wed, 29 Jul 2026 11:10:28 +0800
Message-ID: <20260729031150.54414-1-syjcnss@gmail.com>
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
