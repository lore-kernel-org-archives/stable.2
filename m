Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B137A842
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023212; cv=none; b=K720SRvc6bnCaJNa4HuCzGQWcmRB2JrwDCLelSsIuRFAdGB8RHgDNMGrW2KLE4nJLsrilPAP/tsNw22sLQ3yChk3CNA8E0OwCFt/32RzlLSdygdm/xLo0dv1Yd8OUkE6rP+s5KMZMv3FNdM5SFg1CxL4W3Ai/JB+4yQFt8hFotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023212; c=relaxed/simple;
	bh=FiE9goseqBEInxX3ZwbQrGjfnxhEGzCQBmB91NImWGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QisW3CJBtTFAKcvvEnUmyf4vIPe/NM3hLvXIYf0tKGceoA9WsuJxbLerghPBGvP28hvP84CRCg2ULPlp6mKGoUq6ohPMlQH2q5e4pquK8iZWfXziBhzr4fCucvdi6DD8tdfVrLz0XwSYivfS+4o5h22u5ENLLD/14V3dv+jDQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7i3uXIj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7i3uXIj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cffd93cdedso2575065ad.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023206; x=1786628006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rjqd+RasarluT2YAOKoX5aoiEfjAWOYYOn8+V1cfNyw=;
        b=b7i3uXIjJU9Oue8cnJ0M4fj0R0apP5Ek0AzfSv3UlFhEDLgAD6ZqWrwRKb1KIVDwJt
         o/e1ZZMmK4cmrhBI9zuLnOvYWrn98AOrOApTRcthRJXZbhMUt6Vtc8slEIUxsSTD3obw
         gzJB0uvPl4vDLsFaVyl7ANSe3y67xcrhER95MOhH34v+94ZtqLJHWruyPsoFFI+0fhH7
         2TVrq2r+zysKRbD4TTN1pCTURvcka03ZLI7jiP90WuXIzBn7T7yi/m5HlN/MwROYfEwa
         GQR0ft7wX9Y9RS1SXD/xOas6W3P+HZRYiTW2III61UpNXvAa3nnOaHV7x6ADBR3T6RJD
         /vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023206; x=1786628006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rjqd+RasarluT2YAOKoX5aoiEfjAWOYYOn8+V1cfNyw=;
        b=RRFGzwvD3lY8SKRiULwkS3qXFoZnuFLdDRp7sqt4+8hPwsIWoCCWdAYPdqj5hc2bzq
         vp0plK7Hu20NdLfk/3s9Z9DttdTjX2zNlY1CS1ytsxO7UIPvIVmoj8GTUe8qmhz0h8f/
         CUPj0B7k2Fwi7nX1Z1rRVStZmP+1QRjsZkFTzmPn03eJQvlh6Y7tvYlidFASpBmKiDQh
         hl9CwdHxb0K1Z91qRFaI2vqIequmWZGF9WVazZ2rx8zTQA3LZrYaKgMHx/PcLZ90px7H
         Ywi+wz5UZYUvFNTPbR8Lwm1vbN6s01o2Zjev0JPgJi9wLT4xF4bCg93gQT62/Jq7kmfl
         PKUw==
X-Forwarded-Encrypted: i=1; AHgh+RqZ80/gLdMarhrSexrX/dakcjOg589excVNBnGJoz5n50Sk79DhyZlHoUzDRMMINcBMEeEpbsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeC7ukmSYIl2W1t7Xf5ZuxEIw9U40PGhnxJFzPA0z+s6uxsNl5
	E5sCfYHb0/uKy16leivGbvDlVFOqz63F44wjIFgRrW9TwAwzJb1KXWh/
X-Gm-Gg: AR+sD11wdWmEu2e0g9PsjS8zzkwr3NSI7wG97P+r2/r18ZTyRLxquDwKtZhx9KDKsSO
	0aQ/BTaD5dyKWTqGhzv/d6IdHrxcz8YlMIODIErFeTKrXfJ4zmPimsLtQhFh+KrdsDzwKCq6b0N
	dTUMPE69ufPKakdcxXxV256PnRKBH7r9nbUe6pdgAb/BXXOIkiawe2p4FpswVPgOd5L9JDv22zh
	KCOgZmPDs+pBCBo54+PZh9HC2T4/Lws8E/ggH1RCZwUPYyPyXnRJk8BYzZqpmLv8k44uB649K5k
	rHe8Q0efqYlRbD+6i3o/8YV5YcYdDNPJdlnPxT4FFa6T1Ex+7t9pn/ZiKUzBtj2S8D3nFOmCrz8
	5ccTnfOkldyJ9PJrKXYcZJ8nEKzPz9ZhfiuvcZooxevuRKUOm7HTaHQtTIQomTSbSK9a3UEY50U
	q0WCXk91pQc4jWH0po7+HLKMJWIG8d4y/48lOa8qjQi3c+9YvoYjm6Y5WxdFziMqdNqBRpnU+U0
	Gkob1dfXchiHkJuGB45L3lcae4w2cq84JfhLVWX4B8KTaF9KLgBVI8=
X-Received: by 2002:a17:903:4590:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d0ca150a78mr116460885ad.0.1786023206402;
        Thu, 06 Aug 2026 06:33:26 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm29476791eec.30.2026.08.06.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:33:25 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv4: fix use-after-free in fib_nhc_update_mtu()
Date: Thu,  6 Aug 2026 21:33:09 +0800
Message-ID: <20260806133309.731709-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
RTNL does not serialize this walk with PMTU exception updates. The walk
uses rcu_dereference_protected() with a constant true condition without
holding fnhe_lock.

The following interleaving can therefore occur:

  CPU 0                              CPU 1
  fib_nhc_update_mtu()               update_or_create_fnhe()
    load fnhe                          spin_lock_bh(&fnhe_lock)
                                       fnhe_remove_oldest()
                                         unlink fnhe
                                         kfree_rcu(fnhe, rcu)
    <quiescent state>
    access fnhe after grace period

KASAN reported:

  BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x3df/0x410
  Read of size 8 at addr ffff888107d49000 by task poc/90
  Call Trace:
   fib_nhc_update_mtu+0x3df/0x410
   fib_sync_mtu+0x7a/0xd0
   fib_netdev_event+0x229/0x3f0
   netif_set_mtu_ext+0x33a/0x570
   dev_set_mtu+0x88/0x120
  Allocated by task 89:
   update_or_create_fnhe+0xa80/0x1110
   __ip_rt_update_pmtu+0x8f2/0xcd0
   ipv4_sk_update_pmtu+0x49e/0x690
   udp_err+0xd92/0x1080
  Freed by task 0:
   __kasan_slab_free+0x43/0x70
   kvfree_rcu_cb+0x12f/0x420
   rcu_core+0x509/0x18e0

The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form a
pair and other writers serialize them with fnhe_lock. RCU alone would
prevent reclamation, but would still allow concurrent writers to leave a
mixed pair.

Expose fnhe_lock to fib_semantics.c and hold it across the exception-table
walk. This prevents entries from being unlinked while they are visited and
serializes the paired PMTU state updates with all other writers.

Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Protect the walk with fnhe_lock rather than RCU alone, covering both
  exception lifetime and the paired PMTU state updates.
- Keep fib_nhc_update_mtu() in fib_semantics.c and expose fnhe_lock for a
  smaller diff.

Link: https://lore.kernel.org/netdev/20260731162938.3388534-1-nicoyip.dev@gmail.com/ [v1]

 include/net/ip_fib.h     | 4 ++++
 net/ipv4/fib_semantics.c | 5 ++++-
 net/ipv4/route.c         | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index c63a3c4967ae..634a669ba46b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -12,6 +12,7 @@
 #ifndef _NET_IP_FIB_H
 #define _NET_IP_FIB_H
 
+#include <linux/spinlock.h>
 #include <net/flow.h>
 #include <linux/seq_file.h>
 #include <linux/rcupdate.h>
@@ -495,6 +496,9 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags);
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu);
 void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig);
 
+/* Protects nexthop exception table updates. */
+extern spinlock_t fnhe_lock;
+
 /* Fields used for sysctl_fib_multipath_hash_fields.
  * Common to IPv4 and IPv6.
  *
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..f091a8ac1974 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1879,9 +1879,10 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
+	spin_lock_bh(&fnhe_lock);
 	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
@@ -1900,6 +1901,8 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 			}
 		}
 	}
+out:
+	spin_unlock_bh(&fnhe_lock);
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 152d8cb28f65..fc9a51ebd922 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -571,7 +571,7 @@ static void ip_rt_build_flow_key(struct flowi4 *fl4, const struct sock *sk,
 		build_sk_flow_key(fl4, sk);
 }
 
-static DEFINE_SPINLOCK(fnhe_lock);
+DEFINE_SPINLOCK(fnhe_lock);
 
 static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
 {
-- 
2.43.0

