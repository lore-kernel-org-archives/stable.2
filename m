Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3A36EA84
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154792; cv=none; b=ixofbE2zfNtfIfqfXzwNxNyFm9MVc7nUmT1lD60m+U4zluOggeA8ZZFe8IWhYHgS7yM3n+aypw+XjH27nTnw5tTrpnkcUZWlubwxD30vW+JoHo1fADbFaUuec+FvKO9Rg5vzuZPpTtQW7iv3RIg76tfJDj22wqQCsF5r7fA4E24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154792; c=relaxed/simple;
	bh=2E+v7gU1HYdJS1RSW8A5uW380nna2K0cxdtOSeTAAMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AACHu1rx7Y/H6oNJCAGG72AZYLL5jKwI7brUL6XrWm+7dx9/ncEza//nnG5PZ+L68/z+X133GAj3C49YAxl9VfOAN1uZVhhcW85rZJxWtiK8Tkq56rGWYn65JtWRcfiY7Kl501F0gkJ4jaKs0XjEtZ/G4giFf07AO9R2VZBy3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpCjNDEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpCjNDEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D561F000E9;
	Mon, 27 Jul 2026 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154790;
	bh=0N77NBd9I0CJZnn6Kf4DEJpKDe/DLYD+xRyviz8u2e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpCjNDErXC4PuJVqwMtzNM5fRDP45Kv2NSrmgvHtMa4KlLPHb5iFXB9KaYM2G32Kd
	 2VbjUwdXxOKTS2Ukuf2ALigV18+RpR5Oag4Qzm77RtnoVQ/wQWyJ7k/Nlv5unZlnva
	 UJUHEOWbFU8XO4hMKtPcKP3FZaeSXDdUS9hJ/MVmIbAzFfMcGqF4TOgidmKvdElHYC
	 8plQ4WNS3+ZvrqNnKV+9YQOdktdwpzZqjZPHHdQlGUkRa1qZHsEdZlPPeQbUH2DRLR
	 UFZlIKWXRS/Xc9qXGm2c9vyX3uMiOQ7UKaoWqRnDk3z4eX7RuQ0Xq9By1v8JQXHc48
	 VMRt8z+9a6bSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
Date: Mon, 27 Jul 2026 08:19:48 -0400
Message-ID: <20260727121948.3777971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072001-pedometer-stifling-5aab@gregkh>
References: <2026072001-pedometer-stifling-5aab@gregkh>
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
 drivers/thunderbolt/xdomain.c | 40 ++++++++++++++++++++++++++---------
 include/linux/thunderbolt.h   |  3 +++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 8cfd7f0639e735..371911e2ae4281 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -784,9 +784,13 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		 * the xdomain related to this connection as well in
 		 * case there is a change in services it offers.
 		 */
-		if (xd && device_is_registered(&xd->dev))
-			queue_delayed_work(tb->wq, &xd->state_work,
-					   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+		if (xd) {
+			mutex_lock(&xd->lock);
+			if (!xd->removing && device_is_registered(&xd->dev))
+				queue_delayed_work(tb->wq, &xd->state_work,
+						   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+			mutex_unlock(&xd->lock);
+		}
 		break;
 
 	case UUID_REQUEST_OLD:
@@ -799,8 +803,12 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		 * received UUID request from the remote host.
 		 */
 		if (!ret && xd && xd->state == XDOMAIN_STATE_ERROR) {
-			dev_dbg(&xd->dev, "restarting handshake\n");
-			start_handshake(xd);
+			mutex_lock(&xd->lock);
+			if (!xd->removing) {
+				dev_dbg(&xd->dev, "restarting handshake\n");
+				start_handshake(xd);
+			}
+			mutex_unlock(&xd->lock);
 		}
 		break;
 
@@ -828,9 +836,13 @@ static void tb_xdp_handle_request(struct work_struct *work)
 
 			ret = tb_xdp_link_state_change_response(ctl, route,
 								sequence, 0);
-			xd->target_link_width = lsc->tlw;
-			queue_delayed_work(tb->wq, &xd->state_work,
-					   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+			mutex_lock(&xd->lock);
+			if (!xd->removing) {
+				xd->target_link_width = lsc->tlw;
+				queue_delayed_work(tb->wq, &xd->state_work,
+						   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+			}
+			mutex_unlock(&xd->lock);
 		} else {
 			tb_xdp_error_response(ctl, route, sequence,
 					      ERROR_NOT_READY);
@@ -1978,6 +1990,10 @@ void tb_xdomain_remove(struct tb_xdomain *xd)
 {
 	tb_xdomain_debugfs_remove(xd);
 
+	mutex_lock(&xd->lock);
+	xd->removing = true;
+	mutex_unlock(&xd->lock);
+
 	stop_handshake(xd);
 
 	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
@@ -2364,8 +2380,12 @@ static int update_xdomain(struct device *dev, void *data)
 
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
index 90cd08ab2f5d20..98af9ad04cac1a 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -189,6 +189,8 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @link_width: Width of the link (1 or 2)
  * @link_usb4: Downstream link is USB4
  * @is_unplugged: The XDomain is unplugged
+ * @removing: Set by tb_xdomain_remove() under @lock to prevent
+ *	      concurrent delayed work queueing
  * @needs_uuid: If the XDomain does not have @remote_uuid it will be
  *		queried first
  * @service_ids: Used to generate IDs for the services
@@ -237,6 +239,7 @@ struct tb_xdomain {
 	unsigned int link_width;
 	bool link_usb4;
 	bool is_unplugged;
+	bool removing;
 	bool needs_uuid;
 	struct ida service_ids;
 	struct ida in_hopids;
-- 
2.53.0

