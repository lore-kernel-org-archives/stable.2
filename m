Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71073A255F
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473372; cv=none; b=eNxoiRpbOq8d/pqGLGJdjfI7xvs8TvL1jBdQZBkOM2zPWzdohlQGg+pehZnO+pU4UoNZzL5AJGLjCIxnwII9SPQg0aFFK/yie7FiPfQbzuzldlMIuzki5QbhwHtbSMNA7W80NOaTAm7Da+miEdqttW2vV5qNaSehbyof5wJEbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473372; c=relaxed/simple;
	bh=eSbibO+xhCniUvMt1FIWRWvPjNpLGZrzkTdVYCwi9r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtQDTMocKGJjFSi5cx9T/SNMZaLWfZTHsCqmNsdY0honH+qiwAjtz6k4FsNMGPUjIEM5PUnAhZydzxXK2EWPHEyQj2OxvzWjPmLilKljUpiuRy5/3bikhDuDJFDpBvBIwo/44hhbwuwbrUvSjh6dClo2V82fe5OUNyygeny/HzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPeb39/v; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPeb39/v"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceeee8c46bso15475235ad.2
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784473370; x=1785078170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Min+DEzQsYXU48SJanwQaH6Js4T7CtgnWZ/eBINWIyc=;
        b=oPeb39/vmuPz8ATR95oqeqhHqYa1efqgj0nqND11IBU3Eqj528lhyFAl2josHR/GFJ
         1nYLhq8wo2VAFgnbKVPdA4wK7Cvo6/rhi+CFR3b4wEfiFwZk1ylJTNktjDsKX08Mo7fx
         Z5CT7XcMF1aaCc4XBOjUCeoNukSqjUskkuJW8H5WVaylpHazwKrITG6tjwkrHW3YJ6Py
         QuYmB+5egu7V3jdIxrPWKR+slyLDYWyiKwX5HBLfI5+uQOikVsjOPrcEdp2urtfXF4RT
         PdCQKKfD4yrxzzFWbX1YgpaZKkoz3sAyMM0UDqbtWPgAoANvG3a7ovsCU8wqxQ2HNUWA
         ZzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784473370; x=1785078170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Min+DEzQsYXU48SJanwQaH6Js4T7CtgnWZ/eBINWIyc=;
        b=jTZQ3c4gi7ynUKd8Dkw38qB7Aau3kmJeLsKbv7e6OIB5zAR8+e+/y2z2Z9qIggesBa
         GiFT5R829SeOpdAL1QAyfJy2x4YOkuuVNohNcZ4n7mbQPJb3mW1g/HzImKpqHRSwQbMT
         yr9SS/iOmH20WDh0CHBpDntY9zL8ty6cLI2G3B9SOX9fVtascJQrCGzUpxu9Y+jvYani
         smVxnMUtH7BYpw6Klu7HIk9nk3tBnAyb2yqb2ZDYxv83lTg2xbKVtFDJAx54/+WDulOK
         1DdlsZqWUehGloYhGKIXhv31p0/kbktpeJ9BAxeL/PxlmHcFPlX7w5+NZmPkotMW8tHh
         t0dw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ZB3Ybg4haCQ/XZuDPMJB9oXq+24eZ3kBPiwxRxBEVyTllAlROZb0UdejwZqXe2nIiG3Jvuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn33Lr3KUSG/zSdadeN/BamdsI6KTNRMddOwaH6rGfU0BxV4VK
	7EY4pCFp8KVoAPrDO+Y6n/PP71ar5zA6QyLfsPXU9jfnmEua3s79MDE0apZo2stJtN0=
X-Gm-Gg: AfdE7cnRBWmn/rgNIhfHYXVwOwjJNzDT+wHUPcFx1CP86w01ACSmn5wyTCQw1ST5qTs
	e9P9nrub5DlD0UfFGR8po8LquGAqEHHiCxtCkngpQpihn2h0bqynmhFik2dvHDIsY2+cfQ1QSbl
	afpr8z0wY6TTQZCqjsR54keLOCtomzgtC2auBJiftlz7cbal1ILirX8KYZgV04l1r2q4/3SfRz/
	3GuMKc6D2unbLexkqvWpFQn3Rzya0i56bpEVnGmS47m0jkl6Q0mo/EFf9hiwjwvLMRaDK76J6hV
	+EnmnkSKN89zPJ0TzRVGoXE1nQqqme3Y/GHb+w1EoTKuYymtkC/pCJMblFQIX8wygKUbsMwk380
	Cpf+fFoX9fNEXqlgstGEN7Rk72sI4Hfn/+1BCBswiSDvkgbP1L/M6cDyBN6TuUZDFUVY+aVb8f7
	NQ2HCrIMOV4ggsM5/0SlRa6RRSxLhZmJKjiaVr3tHOhdPcNPsWAjk03izfT3g=
X-Received: by 2002:a17:902:ccd1:b0:2ca:d344:7743 with SMTP id d9443c01a7336-2cf34a05d6cmr90369635ad.7.1784473369952;
        Sun, 19 Jul 2026 08:02:49 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9b00sm42198945ad.53.2026.07.19.08.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:02:49 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Robert Olsson <robert.olsson@its.uu.se>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: pktgen: fix proc entry use-after-free
Date: Sun, 19 Jul 2026 22:57:40 +0800
Message-ID: <20260719145740.2888967-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
pktgen_remove_device() removes the same entry before
_rem_dev_from_if_list() takes that lock.

This allows the following interleaving:

  CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
  if_lock(t)
  proc_remove(pkt_dev->entry)
                                  proc_remove(pkt_dev->entry)
  pkt_dev->entry = proc_create_data(...)
  if_unlock(t)

The kthread can pass the stale proc_dir_entry to proc_remove() after the
rename path has freed it. A reproducer with a widened race window reports:

  BUG: KASAN: slab-use-after-free in proc_remove+0x78/0x80
  Read of size 8 at addr ffff8881478fea70 by task kpktgend_0/67
  Call Trace:
   proc_remove+0x78/0x80
   pktgen_remove_device.isra.0+0x11c/0x4c0
   pktgen_thread_worker+0x1214/0x6bc0
   kthread+0x2c6/0x3b0
  Allocated by task 95:
   __proc_create+0x204/0x790
   proc_create_data+0x72/0xe0
   pktgen_thread_write+0xd61/0x1510
  Freed by task 28:
   kmem_cache_free+0xcb/0x3d0
   proc_free_inode+0x5b/0x80
   rcu_core+0x50a/0x1850
  The buggy address belongs to the object at ffff8881478fea00
   which belongs to the cache proc_dir_entry of size 192

Move proc_remove() into the if_lock-protected list removal helper. Keep it
before list_del_rcu() to preserve the ordering required by add_device().
The rename path must then finish replacing the entry before removal, or
it observes that the device is no longer on the list.

Fixes: 39df232f1a9b ("[PKTGEN]: fix device name handling")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/pktgen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..ee64f3012321 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3972,6 +3972,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -4001,9 +4002,6 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 	 * list to determine if interface already exist, avoid race
 	 * with proc_create_data()
 	 */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
-- 
2.43.0

