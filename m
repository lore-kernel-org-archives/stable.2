Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4729B76C;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501415; cv=none; b=CePUJaeEM5MTTDqbDvN+XmlmNKICoh4YJhnQT9ix7EsdDfYG0e9wA/N91L1i5qSbh3hu5bKhKIxbl1PKEcLzCpdg07UeJLpEQOzNWPU+IsxrIYdA9eRujk3EzEcVg1NqzZbLhbBsO/FRhL37dpmYI15xMtVHpevyFEBuQtylM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501415; c=relaxed/simple;
	bh=Otks1eFhl3B/2yj7KleJv87pPAk0iPsCyon/LUQIjrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHilJ5aTOS01z9m8/vAGlWJK3wC3Gyi0r+KAoi2Bu1qsHrkySuCNJ6luPBwIoLGIGWWWoi+8arQghWWaJ7PQ6LsJMcYJ4kIMxkZiEUqwps6k9ZyWafa08ccAcTeV15Ruz7P+vt86OOhTufuSP3tQN2TMUENz7bPsDfUypdeGppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+I06Upt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+I06Upt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B9F0C2BCFB;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787501415;
	bh=Otks1eFhl3B/2yj7KleJv87pPAk0iPsCyon/LUQIjrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l+I06UptdVLqn9QVoqbuWWIdWendtlR+yaswkg5dpe0s3d0B3Q80jLTwQr2uNVeYp
	 zxqtKOWHW30rz4+51+vKCygQpTcwVPZrR4/+bbxTHzdwa4m7Wd5wSXrcao/RM6V4P3
	 ji813Ru6ZAOtnOofRoN7YcYoBK1/1PN4s4o8GCpzXbQPT8mrwd5GlRllDm34P8d0q1
	 ld/e8BdWde9nQ2R0ifhOVOFkO2l/kxC0XGgNZilLiyGBkogezU0w6vu0wB4wlsCHSF
	 gjn/LpfhLfIxWVgL6+SvXS2lOcyFx6jtUgwhQYWVb38BZ6EXS2MWoGDrT+uuM+LqZA
	 eNJ7eSReAvt+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17567C5DF9A;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 23 Aug 2026 18:09:15 +0200
Subject: [PATCH v2 2/7] thunderbolt: Make the DP tunnel activation callback
 mandatory
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-b4-tbt-fixes-v2-2-26a18a426c9f@kernel.org>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
In-Reply-To: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13359; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Otks1eFhl3B/2yj7KleJv87pPAk0iPsCyon/LUQIjrQ=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1a3dJwq83y1bYaV/Lv8+LNY/1zmK29Mvsf+69qfrjS9D
 iknvfSOUhYGMS4GWTFFlu377U2fPHwjuHTTpfcwc1iZQIYwcHEKwET+T2L4n1HOw9YePG0DY7dR
 bpnr2VPCe+QV3+g/va58NCh7efDttQz/VA9Fv/mwbMmNRzmr1N5OVi98GXE6avPd/mQLxnjJC/r
 LmQE=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

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
---
 drivers/thunderbolt/tb.c     |  4 +++-
 drivers/thunderbolt/test.c   | 37 +++++++++++++++++++++++-----------
 drivers/thunderbolt/tunnel.c | 47 ++++++++++++++++++++++++--------------------
 drivers/thunderbolt/tunnel.h |  8 +++++---
 4 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index f43f2d952372..29b9879c40d8 100644
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
index 034c56845380..fc3f647bf664 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -1398,6 +1398,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	tb_tunnel_put(tunnel1);
 }
 
+static void tb_test_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
+{
+}
+
 static void tb_test_tunnel_dp(struct kunit *test)
 {
 	struct tb_switch *host, *dev;
@@ -1418,7 +1422,8 @@ static void tb_test_tunnel_dp(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1464,7 +1469,8 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev4->ports[14];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1514,7 +1520,8 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 	in = &dev2->ports[13];
 	out = &dev5->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1579,7 +1586,8 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 	in = &dev6->ports[13];
 	out = &dev12->ports[13];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
@@ -1649,7 +1657,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	out2 = &dev5->ports[13];
 	out3 = &dev4->ports[14];
 
-	tunnel1 = tb_tunnel_alloc_dp(NULL, in1, out1, 1, 0, 0, NULL, NULL);
+	tunnel1 = tb_tunnel_alloc_dp(NULL, in1, out1, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, in1);
@@ -1657,7 +1666,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 3);
 
-	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0, NULL, NULL);
+	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, in2);
@@ -1665,7 +1675,8 @@ static void tb_test_tunnel_3dp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 4);
 
-	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0, NULL, NULL);
+	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0,
+				     tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
 	KUNIT_EXPECT_EQ(test, tunnel3->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel3->src_port, in3);
@@ -1763,7 +1774,8 @@ static void tb_test_tunnel_port_on_path(struct kunit *test)
 	in = &dev2->ports[13];
 	out = &dev5->ports[13];
 
-	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				       tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
 
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
@@ -2195,7 +2207,8 @@ static void tb_test_credit_alloc_dp(struct kunit *test)
 	in = &host->ports[5];
 	out = &dev->ports[14];
 
-	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+				    tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
 
@@ -2431,7 +2444,8 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL1(struct kunit *test,
 
 	in = &host->ports[5];
 	out = &dev->ports[13];
-	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+					tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
 	KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
 
@@ -2468,7 +2482,8 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL2(struct kunit *test,
 
 	in = &host->ports[6];
 	out = &dev->ports[14];
-	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0, NULL, NULL);
+	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0,
+					tb_test_dp_tunnel_active, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
 	KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index b7f32305f14a..1f978fddaeed 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1106,8 +1106,7 @@ static void tb_dp_dprx_work(struct work_struct *work)
 		mutex_unlock(&tb->lock);
 	}
 
-	if (tunnel->callback)
-		tunnel->callback(tunnel, tunnel->callback_data);
+	tunnel->callback(tunnel, tunnel->callback_data);
 	tb_tunnel_put(tunnel);
 }
 
@@ -1120,15 +1119,10 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
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
@@ -1579,20 +1573,28 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
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
 
@@ -1608,6 +1610,9 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 	tunnel->alloc_bandwidth = tb_dp_alloc_bandwidth;
 	tunnel->consumed_bandwidth = tb_dp_consumed_bandwidth;
 	tunnel->src_port = in;
+	tunnel->callback = callback;
+	tunnel->callback_data = callback_data;
+	INIT_DELAYED_WORK(&tunnel->dprx_work, tb_dp_dprx_work);
 
 	path = tb_path_discover(in, TB_DP_VIDEO_HOPID, NULL, -1,
 				&tunnel->dst_port, "Video", alloc_hopid);
@@ -1674,16 +1679,16 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
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
@@ -1698,7 +1703,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
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

-- 
2.55.0


