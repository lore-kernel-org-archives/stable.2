Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A8459ADC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515403; cv=none; b=gf1+y9VgGb2iU5RSfBt9v3fMELPfgbm5gsUBT0LvgA+YN0IG2bw6BVtVBjegJCyX3WeMQbQJGQOZlpTtMg4Xp5k2Pw17fgzf234V7LrrFx+6nVSn2dQrJtGFSA6AmSfPKaP+3aFtyKPkn6L/G867cZS2qvIEsdIetSeVQStlwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515403; c=relaxed/simple;
	bh=jGDarGoCosi22LNoT8W76BEldiYKRotoaVhCB39/8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2bnyXPtl5gMMENFK+8/12l7anM6KuHiu6LETXo/E5LzH3JArvBD1FZWYknO9tUXiVNbKnqlPUK4RyoO/4BYVTG6fJbCfb/sdCDiDFdrh5aYt88mv4gJJlGME9wwahT/++dH5yHJtmGkngLVolqzVproUuZS8T5sJYWdJZX6YsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9ZfZfP5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9ZfZfP5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f0f3c8da5so141581a91.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515401; x=1786120201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZ9QZ52VgaJYmqEYMkc9RIQ8PoagjOPOXOHcuoYV6SE=;
        b=q9ZfZfP53xqOnBRVO3sopnk6fiHMlFNNHbXnBHBPjxxc8BekzRzh7W9rzwlvl5cL+X
         bm3z1SALV3dX5gRCWZZv6NCfi4qDFiT0IjJQlX6aNMUv8gUAEalxaXZHDZQR3fCq25Wn
         S8M6a+l0cKi1GSrcHJylw/MYeSmPf+PJppPE6J7LKj9o5HqQ1i7lz1WqmvhTDi/Fbv8N
         rl7gnLXR8NW7xv6RgKiYAi9bNUvXdef34HLcGaUNwPvuvWZH2LUBh5S+rVIHuoeSNTuw
         EQuphtB9hJlFg7Uhv00TtR2TmfOkTLRMGB+wRRbX2yTkMxX2wC81R9OcGHg1ameLNHFG
         7LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515401; x=1786120201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZ9QZ52VgaJYmqEYMkc9RIQ8PoagjOPOXOHcuoYV6SE=;
        b=eSo34YIOisp0/4GhfeDZGPjQcBBnmjxpL/33pCkk3paa1QmEe5mwttjMbxDxGbQRBC
         As+PrIszcrOm+xeI4mmLr51RYlYWs/RjHl+LFDv6bLJ90jpYLfsKpdPM0xQYdW37Giw9
         5Zm3garau66W+NzwGg0jzgtp+/klK/sjHzd8h5yBEYLFxHwyA0qtLqOCdcMr0aIBYiGm
         mejTFcmNzETgk3QT+mopwFCprB8v62mTW1WyzClEAU9F76S3za9aVHv7xglKOciQ/BZ9
         K7CWCYtmxcl4uSydbkU1A3vQDmCMNuG2HpykfRFwWWeRACKdguKa2Ockoyei360zeeTC
         2eTw==
X-Forwarded-Encrypted: i=1; AHgh+RpTmtjnjdUDVJD7uv/0F5ufE1ALlgmFU8tPLsZGww1+EroNvmZWdpMBkEd+RkETCNcxoci2+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3J0sjd7VSx0GS81BpD7ZcHYWhHCJQ86OAybIJE8DgsL97aOSV
	G6ZCndYCp9A0YCoMpdQRyXLMgFQ6TRorSER4j1VvWRg2MUrXclmiCxn7
X-Gm-Gg: AR+sD10nO6OquyOkPg2UwVDGmMi4S8q3TsxEVmZFFMYEJfKUA/GVPlwD9ZjAdY6h9/q
	OHJEMz7j9UM1mHg3YNn+1rfoOt0w9/MlDZvATxMrFedA8srPJgVzkxPNNf1/mTiI+uQ1IyqGzs8
	VkGBUvIqbFiwQNuQ5upY51kq4t5NCNG2pwgYR9SCn8CH3P0fBzYAV+Iii3qBvTul7q87gNy/p+k
	ZjGkYtR1gI2L/vBl/akklwV80XA1+1G8Dby+Z4inmsA9Nxa54NYZYZ4eB4zOTpAPNfK7NqqL9sx
	S3QD55gblopmgvUvi5AhbogtQ4VwYjL48xqzy8t1qWIQ7be0ODZBE/Vc06ckXSGzjGOpyg+MX0q
	O4Wm+NQPmzXOFnpsiyXdzhuGe4Qy+1ktmhyoIMy+KsJRHpviFtIEB2HbB3YjpdmzmikWYtQT9XF
	G6be1OXmJ+XRBX0WX7OKMnLetMRQ/IrpexISecpBKPH4ZCbYd7QnBOgWW1e8Hc/JnUqczcWRj20
	f0xtYkHwrK6VLxn+V1EDelJXpQu0THDaLxSlmcCxMGBwT8dvBqrRJYMQ9vOD3sFq4ygTPJrYJrC
	1Q==
X-Received: by 2002:a17:90b:58c3:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-38fbc4c673dmr657748a91.2.1785515400659;
        Fri, 31 Jul 2026 09:30:00 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm4279637c88.15.2026.07.31.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:29:59 -0700 (PDT)
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
Subject: [PATCH net] ipv4: fix use-after-free in fib_nhc_update_mtu()
Date: Sat,  1 Aug 2026 00:29:38 +0800
Message-ID: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
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
holding either fnhe_lock or an RCU read-side critical section.

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

Protect the full walk with rcu_read_lock() and use rcu_dereference()
for the RCU-published pointers. This prevents reclaim from completing
until all references held by the walk have been dropped, without
serializing PMTU updates against the entire hash-table traversal.

Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/ipv4/fib_semantics.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..6ecc6654427c 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1879,16 +1879,17 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	rcu_read_lock();
+	bucket = rcu_dereference(nhc->nhc_exceptions);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
 
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		for (fnhe = rcu_dereference(bucket[i].chain);
 		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
+		     fnhe = rcu_dereference(fnhe->fnhe_next)) {
 			if (fnhe->fnhe_mtu_locked) {
 				if (new <= fnhe->fnhe_pmtu) {
 					fnhe->fnhe_pmtu = new;
@@ -1900,6 +1901,8 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 			}
 		}
 	}
+out:
+	rcu_read_unlock();
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
-- 
2.43.0

