Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834F27E1DC;
	Mon, 31 Aug 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162916; cv=none; b=mVG6LNEBeuAe3WnGGColk4Haxpi/hqUvCdsvMgCXjkfjTLWHiTzSrXnwRI8pBpmhz1udKf/QP+nh2Iqf1vmPC8cfCCj46d7WSdrAh3mVR+KnVfGFG8Ew0hlkU3mw89Ae8KeTLqn+XT1GnN3rL0Bfgeedai7d+eJW8KyeIIeBBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162916; c=relaxed/simple;
	bh=3BWAK6Evoz16e0emRVdrO0Y1UlyWZz0rq4ElYHd/Bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A06mm1sdwRr6S7I8CyJbtt7UCGoDdC3bX9lRTIJq0zvHni4jR2mvdguO4vW6orgt8m7+E8zc709QskXl3iKibVsJiK7p5umwNg0fKsRXQrE+YAHMr1h6UgXcFMXSbPtdSMvwqNrEZMSZgnXS46CNaagEKovQVJWoJ6UWNuqrJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=q6rJEfgB; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="q6rJEfgB"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788162901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DjjLFNmX/3fOBgo42kROds31DvH6tjSBbxlxYWmoLIE=;
	b=q6rJEfgBeeA6xeLCF/qVZgA5U12XkuvnhtnztSSKW7oik9esBxQL5eODGlRr/AbXMhNFCT
	HUBMUsUXugJSGgv/b849kFq/NU0+kuZC1AoT1inHP8OVNQH8DIg96226thoaKfFiHP0Rg8
	aN3r32ulJU/kMzK6Ist7GAuRwwoejEU=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH 5.10/5.15] ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
Date: Mon, 31 Aug 2026 10:55:00 +0300
Message-ID: <20260831075501.23006-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

commit 7b19c0f81ed1fdaec6bc522569be367199a9edf3 upstream.

A race condition exists between device teardown (inetdev_destroy) and
incoming IGMP query processing (igmp_rcv), leading to a Use-After-Free
in the IGMP timer callback.

During device destruction, inetdev_destroy() drops the primary reference
to in_device, which can drop its refcount to 0. The actual freeing of
in_device memory is deferred via RCU (using call_rcu()).

Concurrently, igmp_rcv() runs under RCU read lock and obtains the
in_device pointer. Because the memory is RCU-protected, CPU-0 can safely
dereference in_device even if its refcount has hit 0.

However, if CPU-0 calls igmp_gq_start_timer() and re-arms the timer, it
attempts to acquire a reference using in_dev_hold(). This increments the
refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
Since the in_device memory is still scheduled to be freed after the RCU
grace period (as the free callback does not check the refcount again),
the device is freed while the timer is still armed. When the timer
expires, it accesses the freed memory, causing a kernel panic.

Fix this by using refcount_inc_not_zero() (via a new helper
in_dev_hold_safe()) to prevent acquiring a reference if the device is
already being destroyed. If the refcount is 0, we do not arm the timer.

A similar issue in IPv6 MLD is fixed in a subsequent patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260705181756.963063-2-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Denis Arefev: adapted for 5.10/5.15: keep prandom_u32(),
get_random_u32_below() not used here]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2026-72323 
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-72323 
---
 include/linux/inetdevice.h |  5 +++++
 net/ipv4/igmp.c            | 14 +++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 3088d94684c1..6174930ae654 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -277,6 +277,11 @@ static inline void in_dev_put(struct in_device *idev)
 #define __in_dev_put(idev)  refcount_dec(&(idev)->refcnt)
 #define in_dev_hold(idev)   refcount_inc(&(idev)->refcnt)
 
+static inline bool in_dev_hold_safe(struct in_device *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 #endif /* __KERNEL__ */
 
 static __inline__ __be32 inet_make_mask(int logmask)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d2ea0d8e7a2f..5d87e912e1f2 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -232,16 +232,20 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 		return;
 
 	in_dev->mr_gq_running = 1;
-	if (!mod_timer(&in_dev->mr_gq_timer, exp))
-		in_dev_hold(in_dev);
+	if (in_dev_hold_safe(in_dev)) {
+		if (mod_timer(&in_dev->mr_gq_timer, exp))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = prandom_u32() % delay;
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = prandom_u32() % delay;
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
-- 
2.43.0

