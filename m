Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E49442FD6;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996450; cv=none; b=TUR38EbitMvpvj1EIjViYRWOSSq8lupjy3NBV1+rko40sU6hCoaVt66KtlBqGDNS3w5qvcAGryQ83CWvpZpAqi2pvHyKoF7nfVdXr8mwW1SBHnJAoQLL/CQhJHi8zoPsV+gIF8VOrat3NDTb+jU+j3SBbKU+ZLz67gAM9vGiv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996450; c=relaxed/simple;
	bh=uuxuwqQ2kuaFD3by4pKZjHi6sqSY36ifjKngOd509eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eecx0rqJ6/vh+gExmjceVJWea++TU5B3zeot9NeU4ClgFnSyRFOQtJTkiJb/U4mrPaCeTNDG5+OZOJqZMzMlXHGKOysZjsvo3DsRyeGSTpg7jYmj3MBIW2AJ/vwrWmpTH5F1jyh4IqiyvOUbLkKR9ZqT96t756gGBxDRinCjA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7LjNLaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7LjNLaS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48577C2BCFA;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786996450;
	bh=uuxuwqQ2kuaFD3by4pKZjHi6sqSY36ifjKngOd509eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j7LjNLaSRVCKTuwziC5/jPsrG/h298FwIAztSkVD2ehjbESPt+Zg+/Jn/7CVmstBA
	 8xIN9WRoR4LFx8WryB4Tll7WL1ci54qSbLGR8GxSQLCoX1WN0ZkDTTucyQUlcltWL6
	 nAswlGEOdLsJElMd0F6llDFHhl2ZDE4w7K7I6749LeKMK0rgoMM6g8ZcjdstCD/AB0
	 DnqY7A4tDLBhsAEL4fpmsre7LEF4aLw0S5wpiW1xNsYcPJi3bu0wlGEBjWes0VsYt1
	 gkW2mSmCiaAyOPYCZQ/c2njvz4I8ldrqFl9X2XmacO4UL0VhqZ0nWvnM4YY3sQF6sO
	 1wm7+YfZDi9MA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE5C5DF7A;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 17 Aug 2026 21:53:59 +0200
Subject: [PATCH 2/5] thunderbolt: Hold a switch reference for each path hop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-tbt-fixes-v1-2-eded2461f5fc@kernel.org>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
In-Reply-To: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: asahi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Sven Peter <sven@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=uuxuwqQ2kuaFD3by4pKZjHi6sqSY36ifjKngOd509eo=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Zz2p0t7mUen/f9Klz3eIbtHdGL4XP9vCS1n+wpX60ny
 dBf9HtfRykLgxgXg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAib/oY/mcK31WfeVle4ZVj
 8vqmc2Xb6mIunXnePVHxg8F65gLjO78Y/tfYxBxaGx14iu1ueY5YqL/3z6jamdfa4wSt95pdn7H
 0MCcA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

tb_stop drops the reference to all DP tunnels but does not deactivate
them, thus nothing cancels a dprx_work still in flight (which holds its
own tunnel reference) and the tunnel can outlive tb_switch_remove. The
HopID releases in tb_path_free then operate on freed IDAs and trigger
warnings like

  ida_free called for id=8 which is not allocated.

Take or release a reference for both ports of each hop whenever the
HopIDs are allocated or released to ensure they have the same lifetime.

The KUnit tests allocate their switches without ever registering them so
initialize the embedded struct device there as well to make these
references work.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/thunderbolt/path.c | 21 +++++++++++++++++++++
 drivers/thunderbolt/test.c | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index b2c322e76b8a..02c5e7a2101e 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -196,6 +196,12 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 		path->hops[i].out_port = out_port;
 		path->hops[i].next_hop_index = next_hop;
 
+		/* Keep the ports alive, see tb_path_free() */
+		if (alloc_hopid) {
+			tb_switch_get(path->hops[i].in_port->sw);
+			tb_switch_get(path->hops[i].out_port->sw);
+		}
+
 		tb_dump_hop(&path->hops[i], &hop);
 
 		h = next_hop;
@@ -323,6 +329,10 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 		path->hops[i].out_port = out_port;
 		path->hops[i].next_hop_index = out_hopid;
 
+		/* Keep the ports alive, see tb_path_free() */
+		tb_switch_get(path->hops[i].in_port->sw);
+		tb_switch_get(path->hops[i].out_port->sw);
+
 		in_hopid = out_hopid;
 	}
 
@@ -356,6 +366,17 @@ void tb_path_free(struct tb_path *path)
 			if (hop->out_port)
 				tb_port_release_out_hopid(hop->out_port,
 							  hop->next_hop_index);
+			/*
+			 * Only drop the switch references after both HopIDs
+			 * have been released: the path may be freed after the
+			 * switch was already removed (e.g. asynchronous DP
+			 * tunnel teardown) and these references are what
+			 * keeps the ports and their HopID IDAs alive.
+			 */
+			if (hop->in_port)
+				tb_switch_put(hop->in_port->sw);
+			if (hop->out_port)
+				tb_switch_put(hop->out_port->sw);
 		}
 	}
 
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 05652ee82fbf..034c56845380 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -33,6 +33,11 @@ static void kunit_ida_init(struct kunit *test, struct ida *ida)
 	kunit_alloc_resource(test, __ida_init, __ida_destroy, GFP_KERNEL, ida);
 }
 
+static void tb_test_switch_release(struct device *dev)
+{
+	/* The memory is owned by KUnit, nothing to do here */
+}
+
 static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
 				      u8 upstream_port, u8 max_port_number)
 {
@@ -44,6 +49,13 @@ static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
 	if (!sw)
 		return NULL;
 
+	/*
+	 * The paths take a reference to their switches and those devices
+	 * have to be initialized for that to work.
+	 */
+	sw->dev.release = tb_test_switch_release;
+	device_initialize(&sw->dev);
+
 	sw->config.upstream_port_number = upstream_port;
 	sw->config.depth = tb_route_length(route);
 	sw->config.route_hi = upper_32_bits(route);

-- 
2.55.0


