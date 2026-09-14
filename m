Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179E466B77
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393129; cv=none; b=KJVpA0pDFgXW9rQfGRrh+/6QlF1W16ZJ8gMYY2b1MdOlYpkoSlaYZ8DBOq6n9oaxTA/5/eQ4HoIo0k+eXoK0+8IHVVQ1a8F5PmxN1KbNRrFBtKn5W2xqywkGpHEkdpKHqPeVw2Ug+L6LWOy7f0jO5tDtHA7WbU3mIG1VTMxH0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393129; c=relaxed/simple;
	bh=G5Q4YusG7EhC2+49TlZOe2QDcwWJ1o9+e8sn8lUHz8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW6x1KFcJ7VXXu0Codd4H3WCppBvXGI5TZXqms7X6DX1Ue4SUlZ04a9xiFgtL9yR+mZnk1CElBan72337vy+ePZbNIYkmRPTXzoWpAsqlGJID1nFKhwObMwTjP4onV8J8sIHCwRBajEQpj+5OQXE1JggDOA1foT5ttLX+MEhcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwA3Lq0U; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwA3Lq0U"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc1ab16a9b0so167337a12.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789393127; x=1789997927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OM4WJQT7eiPiAF6TZgW9/Yhz6QCgt3cljrFGTLgDTGs=;
        b=nwA3Lq0U4Mgd8/xczWKN4pbtIz1N3ZbjIo4FdXFoMquzJLSGSB4bKOeFe/DAFiCp66
         ZhJswuo5U9oBy58VYzqA8FOTYRI1qJ4pct5aUNSt0w7NxYwPRBpBAJDx0mMwezbpp661
         iON2PuMCfagaY/AkOmO4e9l5XKQsy+LfwOyWkIDxoc/ekm4a5phfF7/+MTO2VV3RW/Q1
         4/pY19ZzXPXHbq8mOGe0JAYliP3VHrCA6tocg3EZIEHC8qGuDHQrDqgbbDXqKmEStpS/
         URxGpq/MVYKOsL2245r/cK03r4dWqJH4/a2G1QKzUUFATK2q/DKbLbEidV1d0Vwhji3H
         rVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393127; x=1789997927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OM4WJQT7eiPiAF6TZgW9/Yhz6QCgt3cljrFGTLgDTGs=;
        b=ipQAsMDdQrUQmlxslIsJqcHvmbhCWgnQIZ3amev4LASNx4A5e7OGH5RF4QSdiXhWk+
         b1gk2Zw+71RBHXNvD/3s5OXY7rZ8Fz0TZK5/lsjSJk/QL4tpXrLuxPt/bGfLCL80D1SO
         EOIhPm1jP54sgGHBGoeaOVH39gpTkcpZk427VLUYunIxBRd95cv6ymFoZ7a5/Vy2v6Us
         HXwhWByGHCYvwZmVSyOHkuPMDg5qghY2ozwg61W551Gpnz4n9vqoYDH02VCE0spgT7v3
         3C0RdiiqSU6mTS5oC+B1dS9erR82fyRwNaFFhcscFp6b2iXGAV0KhvyT4H+SXl46Rv7P
         tYmw==
X-Forwarded-Encrypted: i=1; AKwUvBxVQxxErBvOo/nCae68+vXI1R60/6j2zA29seckG21C5zKYav8lII3BEeAVHM/42e8siP9Ft3w=@vger.kernel.org
X-Gm-Message-State: AFuF++kkOswsHlRrDFK81SnE7fMra8ZIEEoD4KQe8xsMqhIOLv+Uo1wa
	PWLoyzctuF8+SPBkB6hB1M6rA9h+/k+kY1prBHpdX/Vkm83Kgr2yp9lf
X-Gm-Gg: AYBFou2UEKhAxX9yN9VV4SRDJ+636KW844aJdLxCsJsg3nod+HAuSvzDk1NVtSKs4E7
	q+rX3NSjcxFbo0FwrgUhYgqrRgoFyEuMs3NmJ6FuXMZRqoRSgZN1t6+TUe64Mejou3vw/FPNuZr
	4rOKWR03R8NoZb24+pzHZhsQxTA80mSk31dKQWN4J+ihOrJjy2u6RvmTzwcYc37byh/tlnBfQmx
	plgovhImRD5ejCd1JUG4sDn4QRmt3ajUQCVu3UT/aMrLRTgerEqviamgyCgnWknuVVxybc0LpSg
	AuQh+IQjC0/vS4crafqleAypsjTOpNZxC9eYPAHU2BoRmuqtx/BCGQ6wx7DBjDEjgAp1AKSSb3w
	BlZ8iIuO2dkvkNPBaF0XLqGb6uVgimZPFEqbAxDVtAT3qHgMiM4uQB6BdEjNEE1m+04UNaJfhBp
	2hXwFN/u6wLoK4SZj35kWA6fNXdSCfHT1HO+xcIUeBVGRxg/KM+Cl9tH5w+yIM89Ci1berw3LcU
	sOakfDzF3y0lUf+oc52Pr/PyKpK+I/ZErQ2kMEXFq27j4naPlXCvl5cs5KdDkGKXA==
X-Received: by 2002:a17:90b:3e4f:b0:396:a47f:d38f with SMTP id 98e67ed59e1d1-39dec0bbc54mr3706908a91.3.1789393127161;
        Mon, 14 Sep 2026 06:38:47 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365bb6ba0sm24565602c88.15.2026.09.14.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:38:46 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH ipsec v2] xfrm: fix races in device state cleanup
Date: Mon, 14 Sep 2026 21:35:40 +0800
Message-ID: <20260914133540.3666907-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deferred-device pass in xfrm_dev_state_flush() finds states under
xfrm_state_dev_gc_lock, but drops the lock before calling
xfrm_dev_state_free() because the driver callback may sleep. The device
GC list does not hold an xfrm_state reference, so the state GC worker can
destroy the same state concurrently.

The race can proceed as follows:

  CPU 0                               CPU 1
  find x on the device GC list
  drop xfrm_state_dev_gc_lock
                                      xfrm_state_gc_destroy(x)
                                        xfrm_dev_state_free(x)
                                        xfrm_state_free(x)
  xfrm_dev_state_free(x)

Both paths can invoke the driver callback and drop the device reference.
CPU 0 can also access the xfrm_state after CPU 1 has freed it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in xfrm_dev_state_free+0x24c/0x2a0
  Read of size 8 at addr ffff88810bbaa960 by task poc/102

  Call Trace:
   xfrm_dev_state_free+0x24c/0x2a0
   xfrm_dev_state_flush+0x353/0x400
   xfrm_dev_event+0x26d/0x3a0
   notifier_call_chain+0xc0/0x280
   __dev_notify_flags+0x169/0x250
   netif_change_flags+0xe7/0x160
   dev_change_flags+0x96/0x220
   devinet_ioctl+0x7f4/0x1880

  Freed by task 57:
   kmem_cache_free+0xcb/0x3d0
   xfrm_state_gc_task+0x4a8/0x650
   process_one_work+0x63a/0x1070

A third xfrm_dev_state_free() caller in xfrm_state_find() can also race
with the deferred pass. Both callers can sample the same device before
either clears xso->dev, then invoke the callback and netdev_put() twice.
Since hlist_del() leaves the node poisoned rather than unhashed, they can
also unlink the device GC node twice.

Acquire a state reference while the deferred pass still holds
xfrm_state_dev_gc_lock. If the reference count is already zero, leave
destruction to the state GC worker. Also claim device cleanup under the
same lock by clearing xso->dev and unlinking the node with
hlist_del_init(). Only the caller that claims the device invokes the
callback and drops the device reference. The deferred pass releases its
temporary state reference after cleanup.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v2:
- Replace the global mutex with a temporary state reference acquired
  while walking the device GC list.
- Claim device cleanup under xfrm_state_dev_gc_lock so concurrent
  callers cannot run the callback or netdev_put() twice.
- Use hlist_del_init() to leave the device GC node unhashed.
- Cover the xfrm_state_find() cleanup path identified during review.

v1: https://lore.kernel.org/netdev/20260730103543.2077749-1-nicoyip.dev@gmail.com/

 net/xfrm/xfrm_state.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..282d09d0c247 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -780,17 +780,20 @@ EXPORT_SYMBOL_GPL(xfrm_dev_state_delete);
 void xfrm_dev_state_free(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xso = &x->xso;
-	struct net_device *dev = READ_ONCE(xso->dev);
+	struct net_device *dev;
 
+	spin_lock_bh(&xfrm_state_dev_gc_lock);
+	dev = READ_ONCE(xso->dev);
 	if (dev && dev->xfrmdev_ops) {
-		spin_lock_bh(&xfrm_state_dev_gc_lock);
+		WRITE_ONCE(xso->dev, NULL);
 		if (!hlist_unhashed(&x->dev_gclist))
-			hlist_del(&x->dev_gclist);
-		spin_unlock_bh(&xfrm_state_dev_gc_lock);
+			hlist_del_init(&x->dev_gclist);
+	}
+	spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
+	if (dev && dev->xfrmdev_ops) {
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
 			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
-		WRITE_ONCE(xso->dev, NULL);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		netdev_put(dev, &xso->dev_tracker);
 	}
@@ -1005,9 +1008,10 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
 		xso = &x->xso;
 
-		if (xso->dev == dev) {
+		if (xso->dev == dev && xfrm_state_hold_rcu(x)) {
 			spin_unlock_bh(&xfrm_state_dev_gc_lock);
 			xfrm_dev_state_free(x);
+			xfrm_state_put(x);
 			spin_lock_bh(&xfrm_state_dev_gc_lock);
 			goto restart_gc;
 		}

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.43.0

