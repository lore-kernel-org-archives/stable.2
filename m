Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3E43079F
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449308; cv=none; b=SNz40d8WJSir4qOpsnX9PHZYzA1E84hdhvjKpMxLuz1dMaFNW/w4Hf/o8PRiRRcFdoH8i0hjvKiOqGl2eSTPKvRR1yB6kh9V8T4QvJKvdP4MEImS8fPZNLRf4Fr8IyibZS/rlZd09AU0b8OYNh+HzfB4ad9pZxnDeKDdYhNRJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449308; c=relaxed/simple;
	bh=gYFfdjiMhlYQPHnKaM0c818WpskuLo0ZZ0w95JsPt60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXuIi+j6q1P+xjJqcNM5k2EaWKBUFz3U6d26dRcS0TDm1KR7DNzRvonzspnGdLthXK4E8W5XINo5JoIzvQAyEk8hVRxbhgclomnSnqfvqgkrluwww5Z2xjwk1G0+hu1i9/Rx8esrehMvvrIvMhakLQhJB0Tka5EXa1Sw15JohSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kItTa7UV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kItTa7UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3341F00A3E;
	Tue, 11 Aug 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786449307;
	bh=2zL5Da/Kzs3a1l5+yUMDjRcNvCB8GiuryZy9b/+7Ehs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kItTa7UVnhZv6l9ZLC8li90LYwNGUHm4OfrBLjht+wOhkuW5dgaNbFDXYmzSaVATT
	 3psnaW5cgoiyt6Q2fjRLkppwYOc659DXchbPwwVEyYr3jUZltUHsGcXycIOg3fPVlF
	 n9Qd7fNA/Ube3pj77xKzShSFv3Ax/j5xQOtAZyWgNk10M4+mzPlOgWCZckO6s1vCbM
	 VBXCxxcjJVWVXlfxeunk04JdqXnYmQY8Ivi8A1JALAleozYp/OyhAEVHebzAyT3E4x
	 9DMgbyFgvjr64adNDaEUCKFmoKjMzFtayUL9sgcQ5Ou0jS/NlVInDykRho/6ACuqdg
	 kJPgQixHrZMeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net: pktgen: fix proc entry use-after-free
Date: Tue, 11 Aug 2026 07:55:04 -0400
Message-ID: <20260811115504.2333010-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811115504.2333010-1-sashal@kernel.org>
References: <2026080501-backup-vest-eab3@gregkh>
 <20260811115504.2333010-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 817ff6efdb7f484ea547218e11e17d8e43daa3b4 ]

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260719145740.2888967-1-nicoyip.dev@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 6c576d11af29f..118036dc16fa5 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3934,6 +3934,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -3963,9 +3964,6 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 	 * list to determine if interface already exist, avoid race
 	 * with proc_create_data()
 	 */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
-- 
2.53.0

