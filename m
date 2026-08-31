Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7D27E1DC;
	Mon, 31 Aug 2026 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163040; cv=none; b=aBHQLtccpzdb97tRvVNZ3pGp72t4WcKyXf42owAWwOWJFS2AKKNoSS5TG0s+GEVToEcjFIFLfsf6MxStCqgAU/jpofhoW3oRAIZ6Vzf/5j0SxfLP/VHcnCXcZP13Pa2/9+hMaq2FkIeNxAUI8uVmulRWuoah8xdk8vpO+FUjuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163040; c=relaxed/simple;
	bh=kbOF8Xis1+b3XyY1U0EPpoTHxr+rl9dG1JOmrg5VWT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUJxWz2eh7f8D9FpPdbtPxIe9XTVaCy3O/f6tCPkw/aMODhpONZHlLYl+p/w19Ww9ezGnyWzD72o/TPgid2dgbNykGb5eg1ek/ObxXytzv/AGbP9SLfMGFKQjLgPhADu3rB0fzW2fmiCQfzD4r8vpJJGhmaCwOtxv6tQzhtJ0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=JI1zsoy9; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="JI1zsoy9"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788163034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xcfx++QT4NbKdTFPwcuiqKtrJuKRl9bSwmn5aqpMsu4=;
	b=JI1zsoy94682tqy5LLnIsCiRyKhBnAEVE0MOBBzgAu9EgvA8U+ZwZcL9mx7cDLLVJLa2Oy
	51IRllwWyg/u+eVe8Gp57qef/0vyoYXvFKjTeNPmGAc0vA6462a/mnHw/aREQ9op5/beK8
	PWRJcDlrOk+6QLLaT72w2mEFHv05yVQ=
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
Subject: [PATCH 6.1] ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
Date: Mon, 31 Aug 2026 10:57:12 +0300
Message-ID: <20260831075714.23091-1-arefev@swemel.ru>
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
[Denis Arefev: adapted for 6.1: keep prandom_u32_max(),
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
index ddb27fc0ee8c..c846c5e4be00 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -282,6 +282,11 @@ static inline void in_dev_put(struct in_device *idev)
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
index fd12b256e05d..ede991885b1f 100644
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
-	int tv = prandom_u32_max(delay);
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = prandom_u32_max(delay);
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
-- 
2.43.0

