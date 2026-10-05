Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F04ADD9E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211378; cv=none; b=Cyt7Q4RLsni16fMtwBwUnbVKb4B7gZNx/wuDqSga/V3XBLH4xbQee0Q8bUCy20YQRMjL04QRF9Gr32ThYcKy+McdxhqI4uMWF+rg3R09QZPgTyiiRuE/I821J+/vC66x9ioJg5hi5715MJ6ocNtAmZxcSaU8vWbFHz22g5ATVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211378; c=relaxed/simple;
	bh=3aeP1IhcmO+GRymhj6Nhpy8g9MP5U5lUmZNnzMlnKzY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkVwqUGpZW2MMfB2qLcUrBFfWnIJ8f/u98l+8UwyCtoN8Q4OG7deZ0Isqh7b3GRPt3KrlTgjGC0RQ8a8Yy9I9gQmHQm0iODfJzLoL4vB5/Ao8GSRxwTlquo8D/RlKTEh1Vc3JJH8Ex5NSSsZyXysYXxAh8bl4X7GA1QI4n7ePSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LfgSDI3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LfgSDI3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297971F000FF;
	Mon,  5 Oct 2026 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211370;
	bh=YBIw6Q6GsC165NBFywKVByddFcIUmPAqPoXzFPTgUxM=;
	h=Subject:To:Cc:From:Date;
	b=LfgSDI3Qn3MUqc9Vdn8YPKwva7OnGMqtsdbPXNsQmpT1WawJlE+F2/GcEBu87lKju
	 0lYf48VaYMaRY3CCXfJfAvHozTPw1Jp2YSpIc484dubkhnj1VicR1vGqy42cu20DoP
	 MrgPr6VhCwM8eBpV9kmgRs+EkEFCD9vFDngqz828=
Subject: FAILED: patch "[PATCH] thunderbolt: Make the DP tunnel activation callback mandatory" failed to apply to 6.18-stable tree
To: sven@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:42:48 +0200
Message-ID: <2026100547-plywood-foothold-2f02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 12f5d8b85a66a0ac08d082517d92ce136f8c0d42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100547-plywood-foothold-2f02@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12f5d8b85a66a0ac08d082517d92ce136f8c0d42 Mon Sep 17 00:00:00 2001
From: Sven Peter <sven@kernel.org>
Date: Sat, 29 Aug 2026 10:08:34 +0200
Subject: [PATCH] thunderbolt: Make the DP tunnel activation callback mandatory

tb_tunnel_alloc_dp() takes an optional callback which is run from
dprx_work once the DPRX capabilities read has completed. Without that
callback tb_dp_dprx_start() reads the capabilities synchronously and
never queues the work. It however always takes a tunnel reference which
is only dropped by dprx_work itself or by tb_dp_dprx_stop() when
cancel_delayed_work() actually canceled that work. That reference is
thus leaked for every tunnel without a callback.

The only tunnels without one are those from tb_tunnel_discover_dp(),
which are activated again when restoring from hibernation.
Pass the callback to tb_tunnel_discover_dp() as well and drop the
synchronous path such that the DPRX capabilities are always read from
dprx_work. Hibernation restore then also no longer blocks for up to 12
seconds while waiting for that read to complete.

Also fix up the KUnit tests.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 47753a5c0f2e..20f0f8f4bdf7 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -89,6 +89,7 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
 				       const char *reason);
 static void tb_queue_dp_bandwidth_request(struct tb *tb, u64 route, u8 port,
 					  int retry, unsigned long delay);
+static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data);
 
 static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
 {
@@ -385,7 +386,8 @@ static void tb_switch_discover_tunnels(struct tb_switch *sw,
 
 		switch (port->config.type) {
 		case TB_TYPE_DP_HDMI_IN:
-			tunnel = tb_tunnel_discover_dp(tb, port, alloc_hopids);
+			tunnel = tb_tunnel_discover_dp(tb, port, alloc_hopids,
+						       tb_dp_tunnel_active, tb);
 			tb_increase_tmu_accuracy(tunnel);
 			break;
 
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 799ada97cbc9..c8c648f31107 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -1407,6 +1407,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	tb_tunnel_put(tunnel1);
 }
 
+static void tb_test_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
+{
+}
+
 static void tb_test_tunnel_dp(struct kunit *test)
 {
 	struct tb_switch *host, *dev;
@@ -1427,7 +1431,8 @@ static void tb_test_tunnel_dp(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1473,7 +1478,8 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev4->ports[14];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1523,7 +1529,8 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 	in = &dev2->ports[13];
 	out = &dev5->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1588,7 +1595,8 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 	in = &dev6->ports[13];
 	out = &dev12->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1658,7 +1666,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	out2 = &dev5->ports[13];
 	out3 = &dev4->ports[14];
 
-	tunnel1 = tb_tunnel_alloc_dp(NULL, in1, out1, 1, 0, 0, NULL, NULL);
+	tunnel1 = tb_tunnel_alloc_dp(NULL, in1, out1, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, in1);
@@ -1666,7 +1675,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 3);
 
-	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0, NULL, NULL);
+	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, in2);
@@ -1674,7 +1684,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 4);
 
-	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0, NULL, NULL);
+	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel3->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel3->src_port, in3);
@@ -1772,7 +1783,8 @@ static void tb_test_tunnel_port_on_path(struct kunit *test)
 	in = &dev2->ports[13];
 	out = &dev5->ports[13];
 
-	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				       tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
 
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
@@ -2204,7 +2216,8 @@ static void tb_test_credit_alloc_dp(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev->ports[14];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
 
@@ -2440,7 +2453,8 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL1(struct kunit *test,
 
 	in = &host->ports[5];
 	out = &dev->ports[13];
-	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+					tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
 	KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
 
@@ -2477,7 +2491,8 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL2(struct kunit *test,
 
 	in = &host->ports[6];
 	out = &dev->ports[14];
-	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+					tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
 	KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7e8284575dff..6ac44b371266 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1109,8 +1109,7 @@ static void tb_dp_dprx_work(struct work_struct *work)
 		mutex_unlock(&tb->lock);
 	}
 
-	if (tunnel->callback)
-		tunnel->callback(tunnel, tunnel->callback_data);
+	tunnel->callback(tunnel, tunnel->callback_data);
 	tb_tunnel_put(tunnel);
 }
 
@@ -1123,15 +1122,10 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 	tb_tunnel_get(tunnel);
 
 	tunnel->dprx_started = true;
+	tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
+	queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
 
-	if (tunnel->callback) {
-		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
-		queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
-		return -EINPROGRESS;
-	}
-
-	return tb_dp_is_usb4(tunnel->src_port->sw) ?
-		tb_dp_wait_dprx(tunnel, dprx_timeout) : 0;
+	return -EINPROGRESS;
 }
 
 static void tb_dp_dprx_stop(struct tb_tunnel *tunnel)
@@ -1582,20 +1576,28 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
  * @tb: Pointer to the domain structure
  * @in: DP in adapter
  * @alloc_hopid: Allocate HopIDs from visited ports
+ * @callback: Callback that is called when the DP tunnel is fully
+ *	      activated (or there is an error)
+ * @callback_data: Data for @callback
  *
  * If @in adapter is active, follows the tunnel to the DP out adapter
  * and back. Returns the discovered tunnel or %NULL if there was no
- * tunnel.
+ * tunnel. See tb_tunnel_alloc_dp() for @callback.
  *
  * Return: Pointer to &struct tb_tunnel or %NULL if no tunnel found.
  */
 struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
-					bool alloc_hopid)
+					bool alloc_hopid,
+					void (*callback)(struct tb_tunnel *, void *),
+					void *callback_data)
 {
 	struct tb_tunnel *tunnel;
 	struct tb_port *port;
 	struct tb_path *path;
 
+	if (WARN_ON(!callback))
+		return NULL;
+
 	if (!tb_dp_port_is_enabled(in))
 		return NULL;
 
@@ -1611,6 +1613,9 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 	tunnel->alloc_bandwidth = tb_dp_alloc_bandwidth;
 	tunnel->consumed_bandwidth = tb_dp_consumed_bandwidth;
 	tunnel->src_port = in;
+	tunnel->callback = callback;
+	tunnel->callback_data = callback_data;
+	INIT_DELAYED_WORK(&tunnel->dprx_work, tb_dp_dprx_work);
 
 	path = tb_path_discover(in, TB_DP_VIDEO_HOPID, NULL, -1,
 				&tunnel->dst_port, "Video", alloc_hopid);
@@ -1677,16 +1682,16 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
  *	    %0 if no available bandwidth.
  * @max_down: Maximum available downstream bandwidth for the DP tunnel.
  *	      %0 if no available bandwidth.
- * @callback: Optional callback that is called when the DP tunnel is
- *	      fully activated (or there is an error)
- * @callback_data: Optional data for @callback
+ * @callback: Callback that is called when the DP tunnel is fully
+ *	      activated (or there is an error)
+ * @callback_data: Data for @callback
  *
  * Allocates a tunnel between @in and @out that is capable of tunneling
- * Display Port traffic. If @callback is not %NULL it will be called
- * after tb_tunnel_activate() once the tunnel has been fully activated.
- * It can call tb_tunnel_is_active() to check if activation was
- * successful (or if it returns %false there was some sort of issue).
- * The @callback is called without @tb->lock held.
+ * Display Port traffic. The @callback is called after tb_tunnel_activate()
+ * once the tunnel has been fully activated. It can call
+ * tb_tunnel_is_active() to check if activation was successful (or if it
+ * returns %false there was some sort of issue). The @callback is called
+ * without @tb->lock held.
  *
  * Return: Pointer to @struct tb_tunnel or %NULL in case of failure.
  */
@@ -1701,7 +1706,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 	struct tb_path *path;
 	bool pm_support;
 
-	if (WARN_ON(!in->cap_adap || !out->cap_adap))
+	if (WARN_ON(!in->cap_adap || !out->cap_adap || !callback))
 		return NULL;
 
 	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 4878763a82b3..7d1d255ab5a7 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -66,8 +66,8 @@ enum tb_tunnel_state {
  * @dprx_canceled: Was DPRX capabilities read poll canceled
  * @dprx_timeout: If set DPRX capabilities read poll work will timeout after this passes
  * @dprx_work: Worker that is scheduled to poll completion of DPRX capabilities read
- * @callback: Optional callback called when DP tunnel is fully activated
- * @callback_data: Optional data for @callback
+ * @callback: Callback called when DP tunnel is fully activated
+ * @callback_data: Data for @callback
  * @paths: All paths required by the tunnel
  */
 struct tb_tunnel {
@@ -117,7 +117,9 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 bool tb_tunnel_reserved_pci(struct tb_port *port, int *reserved_up,
 			    int *reserved_down);
 struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
-					bool alloc_hopid);
+					bool alloc_hopid,
+					void (*callback)(struct tb_tunnel *, void *),
+					void *callback_data);
 struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 				     struct tb_port *out, int link_nr,
 				     int max_up, int max_down,

