Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4642901B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175533; cv=none; b=tqklK7kLXHXveLCVIlcr8lhrII3y2mkYyXY0F7IUzmH/l7nI0Fy48/vwACWnnk7B+o0QdmP7r7XzFWT4696DkU5EXmwJVPwKC5CSFVxNkf8PxOJxMLNA7l2dEr7kuyWC/r0LWaK0jw50wkSe+klApvQuI/YeZryOz2EnBu1daqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175533; c=relaxed/simple;
	bh=UYzUp73Xyxj47+8pad5idVVSoUvmoEdbx7CTa3TIK3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd35l10USsMH8aw1z8CCOPgFLPkjmBcx3n5kUTKAU7OxUpy8Kt531R3qtcj4TjZaTqF0Oa9ytgCZjCZLoDiKodMM2iXFI/zCXUZhn6y5AcNIZG6rH4557UDGvCWKVGxqFk7q6UDaz0k2DIj4D/ylj9eEo3HRfrL9eSa1bxuaNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0+3Mvgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0+3Mvgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306FC1F000E9;
	Mon, 27 Jul 2026 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175531;
	bh=Yp0STGkFuR0Kx54Tboq3L2nG9Tc1chFxhsKYI5JLuLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0+3Mvgdk2HHhL9FQMBj88x/IBn+xDyAQEsnXDajEnbR+QTRy/6/KHDDrrodKI9Fj
	 53+ezJN/nmkIM43CfLdYDjabQNROpv3NYiNUhfLBnaG32SDN6teO1Mm+sRa3vCHgUp
	 FDMezBUkFFQlrGwLE5+lcTwN09hSHnDWrbTlqi54mukT6fMW/MDd5GE5hfEzSKKa8O
	 bBMT8q9T6FkG9LOrJ6vx72TEmTsJNjT7gyURH+IeozWgpTilh7VpN3yrShIgbnQ0tO
	 +SmqJaSfXJZJTRZBOZI2XDKUgD9neAroU60BgyUaBjl5F1PgC1+9ykF3c790jI1JSQ
	 ry/xS0xIV3FHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
Date: Mon, 27 Jul 2026 14:05:28 -0400
Message-ID: <20260727180528.1410603-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727180528.1410603-1-sashal@kernel.org>
References: <2026072002-actress-oxidant-7a4d@gregkh>
 <20260727180528.1410603-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2c5d2d3c3f70cde2565d7b279b544893a2035842 ]

tb_xdp_handle_request() runs on system_wq and queues
xd->state_work via queue_delayed_work() in three request handlers:
PROPERTIES_CHANGED_REQUEST, UUID_REQUEST (via start_handshake),
and LINK_STATE_CHANGE_REQUEST.  Similarly, update_xdomain() queues
xd->properties_changed_work when local properties change.

Concurrently, tb_xdomain_remove() calls stop_handshake() which does
cancel_delayed_work_sync() on both delayed works.  Later,
tb_xdomain_unregister() calls device_unregister() which eventually
frees the xdomain.  Since commit 559c1e1e0134 ("thunderbolt: Run
tb_xdp_handle_request() in system workqueue") moved the request
handler off tb->wq, the handler and the remove path are no longer
serialized.  If queue_delayed_work() executes after
cancel_delayed_work_sync() but before the xdomain is freed, the
delayed work fires on a freed object.

Add xd->removing that tb_xdomain_remove() sets under xd->lock
before calling stop_handshake().  Each external queue site holds
the same lock and checks removing before calling
queue_delayed_work().  This provides the mutual exclusion needed:
either the queue site acquires the lock first and queues work that
the subsequent cancel will see, or the remove path acquires the
lock first and the queue site observes removing == true and skips
the queue.

Fixes: 559c1e1e0134 ("thunderbolt: Run tb_xdp_handle_request() in system workqueue")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 20 ++++++++++++++++----
 include/linux/thunderbolt.h   |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 62338381e9dd38..47ccebf42c5a57 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -604,8 +604,12 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		 */
 		xd = tb_xdomain_find_by_uuid_locked(tb, &xchg->src_uuid);
 		if (xd) {
-			queue_delayed_work(tb->wq, &xd->get_properties_work,
-					   msecs_to_jiffies(50));
+			mutex_lock(&xd->lock);
+			if (!xd->removing)
+				queue_delayed_work(tb->wq,
+						   &xd->get_properties_work,
+						   msecs_to_jiffies(50));
+			mutex_unlock(&xd->lock);
 			tb_xdomain_put(xd);
 		}
 
@@ -1369,6 +1373,10 @@ static int unregister_service(struct device *dev, void *data)
  */
 void tb_xdomain_remove(struct tb_xdomain *xd)
 {
+	mutex_lock(&xd->lock);
+	xd->removing = true;
+	mutex_unlock(&xd->lock);
+
 	stop_handshake(xd);
 
 	if (!device_is_registered(&xd->dev)) {
@@ -1646,8 +1654,12 @@ static int update_xdomain(struct device *dev, void *data)
 
 	xd = tb_to_xdomain(dev);
 	if (xd) {
-		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-				   msecs_to_jiffies(50));
+		mutex_lock(&xd->lock);
+		if (!xd->removing)
+			queue_delayed_work(xd->tb->wq,
+					   &xd->properties_changed_work,
+					   msecs_to_jiffies(50));
+		mutex_unlock(&xd->lock);
 	}
 
 	return 0;
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 5db2b11ab0855c..e6f60d411e2a50 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -181,6 +181,8 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @device_name: Name of the device (or %NULL if not known)
  * @is_unplugged: The XDomain is unplugged
  * @resume: The XDomain is being resumed
+ * @removing: Set by tb_xdomain_remove() under @lock to prevent
+ *	      concurrent delayed work queueing
  * @needs_uuid: If the XDomain does not have @remote_uuid it will be
  *		queried first
  * @transmit_path: HopID which the remote end expects us to transmit
@@ -225,6 +227,7 @@ struct tb_xdomain {
 	const char *device_name;
 	bool is_unplugged;
 	bool resume;
+	bool removing;
 	bool needs_uuid;
 	u16 transmit_path;
 	u16 transmit_ring;
-- 
2.53.0

