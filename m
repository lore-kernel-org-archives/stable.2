Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531857;
	b=ebmjgIBOQXUEnaiA1xLjm5hAM+1QPT0Mpf0iAM25dlHA/TDg3aW87fcRB190DfiKnAvi
	 hBkO7GTJAbg8l0bruuAIz6Kw18HgSVaU4venSLAOPOm0iiCybdr1Uczdi7fCL0mB/HEGn
	 jE0xRFAQWkReN0yMrtdopyK8JGGmY4XBQoZhwaQVq8ai1udHUbr8VMdj5wgeW7LbZbEdq
	 IVpULksUbx9N0J483Ab6McDSn1Lg/pqleyMdnJN4sKUn8GP9Wa73nYQY4CXFt6kcc2ikG
	 VAplO8xiTIYyexqttRfu2GsG1jqI52uxHRC1OUItZOTzZraUoL+gs8/fh3K9uWVY3hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=32E1LQVPzCtxgeWaBRWybLiD6+nn5ZyZuch8w3fVQgE=;
	b=j4PFuIq38EFSXEu9AScydM9vK2nbJplEE1ODlGlbSIww6tiEC3cMeq0gfR1zwr4qVINJ
	 QMn1XeO30AsXKNS2pjxIjeOG1gj/zngqvc1vvFQTK30Hvpc/TOM/knBrLYc3Ic6yeuk6X
	 cbkpa/rDH29PolmXOL6XklfjGieX1QftQE0bf1oGMg+3sVVouXO5THIiQCta4DpLMerR6
	 WBwn8Vnme9ulyn7/lp+U2snVrAnGYvuoP9Zv2ZS3ocqvpDu7ZtR1dkZG0RWk9ZXt4ksRm
	 1YrmVKlaPp2ZkEPTKU4IK45CP6U/j5mqS2PQ1QUTT9Gqc+y4FcYcCgfOz1DMW+oX4sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ilP7DjkP;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01494606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01494606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ilP7DjkP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3866a784546so6037584eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795531855; x=1796136655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32E1LQVPzCtxgeWaBRWybLiD6+nn5ZyZuch8w3fVQgE=;
        b=ilP7DjkPe0IOVW8VKXgRtMFBZXs38bEJEn8Ax8EGlBxxTgV5N9DHHh31TSrfKIQf2t
         /RSIz2zQUEPeIlasoSclDGSKRLyUlIHP12eYdzQRodPqqsVknzs/iPu7UG7I+mEMNRLH
         eS/zU1YBNQ+rNZGoM5J5VZTTTSYl3kZiH+MGYWggDp90HTPj+lqS0kSG90CwGqsnWYWb
         S921kDjcujdgYRi8vV25gDs09juB7DBEEtP6KG7mYNE7ya9yDBslmcu9dyqHZbvQD+8p
         lXKpveKAY7xFnuKXMzMrUHItyCQIVJt+YLrr0Dn9hfOongevGj+cTY28fB6PQfiH5yNU
         9MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531855; x=1796136655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=32E1LQVPzCtxgeWaBRWybLiD6+nn5ZyZuch8w3fVQgE=;
        b=BroT3rTQ/GEBHcALctfcont0h1czZtP6DiEH8SVcctber9LfKfQrUEa+rTuRiCcldE
         bhd6ZOCwByUaEGKP1u3qdTSAI4q6htARF7r8/KKw4QTypL1JB07KBcSIzqXBX6WKO+92
         aM0ZfYZsn/fkEhkWuDIl+yuj0b+3DrNeQj2XwCgqkZjx7tbNEbufJMFHpzClFPsq9sJH
         WOiGjt8JucWrrDllY1lDuymq9EeGqLqzS0ZB3neN10NC7sjFT4BNBzmwkTUThcwui96C
         EWRZ5UOCNFk5HnUyY+wZfnJVWM3R/9HioL/Yhd0pbxqTPNuE7E6gExD65v9iCojiPhIj
         nuSg==
X-Forwarded-Encrypted: i=1; AL+hErH1g7yJVFP5mOMD/a26VLUkxMb27KaNF6ZABriz3zOHd+2Li0BtA97M+UAwYtEHrb9dFUztugw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z9nvctPafEUh92ATfFw8DHbotX7jw5VWEKNckvjo3qtOLYrF2
	QDCljEnTLKFjnR0vvkgAKx/LuQfVGgpn02p+1aYWvtzmIDXCqcm1ve2B
X-Gm-Gg: AZFdTZe24NZP+NRKo873vIz2+oZDMlChJcsWeUo5R8QN3PPdbzGanpGPiunnUM3B94Y
	CeA2ghygfabhrcCkjKpqt8v/DEyzL9RDYDqzvR/H8Fe9qJAWddKaDd18OV9HtDvKahmbQBhpDO5
	ZmB65fwX0+6p7gpLsmjw/QwKYGtfczZdnrIPJB7ROGlCwCUi5WTPJcKCaRDE83qfLFXuyz4+3yS
	t52kNvwGmfXi2wKkozMY9t0letq2Sk/ep6xfM9mSj4xpFPkCiV1slVTTmuQgjILMQe3bRGGVU+3
	AMKHcN/b77PHW3v+CJZZVttH11d7aUEwcNuJL1o7ib7x4vBeJmF9ZFr/dKp0LdrfeRiKwkJBctB
	0NpqMgksz1hQzX04z0RZt4N05SgZVAW0V9G6kjgveEYBs3pGVDPRoT5zAF0pbPBuyDl+icvbOpQ
	stT9aBay+J8j5p2OxT+f9kmbaPbjNSWL8iYlPbsn2AlX4coyf1zeboiIobPeS5RAqGzyBizRAEW
	heXFv4toPf15BSeF6X9SklVejkEJK5wjjy2l4npUWfp+5+4i3Nsujj2/NPQF7m5+skXUjj1sih8
	aJ0nrLLdkwJvy8oKfhsFB9UecdAXZ0OoN1ddbTmh1K5UEKoqZsZHgU/e2f3H
X-Received: by 2002:a05:7301:6e9a:b0:37b:e01b:9f15 with SMTP id 5a478bee46e88-3857025f802mr16355693eec.24.1795531854977;
        Tue, 24 Nov 2026 06:50:54 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm20684238eec.18.2026.11.24.06.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:50:54 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	matttbe@kernel.org,
	shuah@kernel.org,
	netdev-bot+sashiko@kernel.org,
	Minxi Hou <houminxi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6 2/3] net: openvswitch: do not record user features when the change fails
Date: Tue, 24 Nov 2026 09:50:32 -0500
Message-ID: <20261124145033.627044-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124145033.627044-1-houminxi@gmail.com>
References: <20261124145033.627044-1-houminxi@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_dp_change() stores the new features in dp->user_features before it
updates the per-cpu upcall port IDs, and that update fails when the
per-cpu-pids attribute is empty or its length is not a multiple of four.
The update runs only when the same request also sets
OVS_DP_F_DISPATCH_UPCALL_PER_CPU, which is what user space that wants
per-cpu upcalls sends.
The request returns -EINVAL with the new features already recorded, while
the code that enables or disables the tc skb extension key never ran.

The datapath then claims TC_RECIRC_SHARING without holding the reference
the bit stands for. A later request that clears the bit drops a
reference that was never taken, and a datapath destroyed with the bit
clear never drops the one it did take. The key is shared with the other
users of recirc sharing, so the count can reach zero while one of them
still reads it, and a disable on a count of zero warns from
static_key_dec_not_one(), which panics a host that runs with
panic_on_warn.

The request only needs CAP_NET_ADMIN, which a user namespace that owns a
network namespace provides. datapath_policy has no entry for
OVS_DP_ATTR_PER_CPU_PIDS and the operation skips strict validation, so an
empty attribute reaches the check that fails.

Record the features last, in one setter that also takes and drops the
reference, and use it from every place that changes or clears the bit.
Two of those places leaked a reference: a datapath that fails after
ovs_dp_change() enabled the key was freed without a disable, and
ovs_dp_reset_user_features() cleared the bit without one. The reset runs
when an outdated user space instance sends OVS_DP_CMD_NEW for a name that
already exists, and after it the datapath's packets no longer share the tc
skb extension.

__dp_destroy() clears the bit before the ports are detached and before the
datapath leaves the list, so an upcall can still be reading the other bits
from the receive path, and the clear goes through the same setter.

Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/netdev/998d522f-e61d-420f-9834-6bdcbaab1361@kernel.org/
Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---

  v6: ovs_dp_set_user_features() reads the field with READ_ONCE() rather
    than a plain load, now that every write to it is a single
    WRITE_ONCE(), and the two paths that clear only the recirc bit call
    one helper instead of repeating the mask expression.  The tag block
    also moved to the end of the message, with no prose after it.

 net/openvswitch/datapath.c | 54 +++++++++++++++++++++++++++++---------
 net/openvswitch/datapath.h |  7 ++++-
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 96baa2488c26..74e78a954b70 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1712,6 +1712,36 @@ static struct datapath *lookup_datapath(struct net *net,
 	return dp ? dp : ERR_PTR(-ENODEV);
 }
 
+/* Called with ovs_mutex, which every writer holds. The field is a single
+ * WRITE_ONCE() so a reader on the receive path, which takes no lock, never
+ * sees a value stitched together from two stores; this helper reads it with
+ * READ_ONCE() for the same reason. The store happens before the reference is
+ * taken or dropped, the order ovs_dp_change() used.
+ */
+static void ovs_dp_set_user_features(struct datapath *dp, u32 features)
+{
+	u32 previous = READ_ONCE(dp->user_features);
+	bool was = previous & OVS_DP_F_TC_RECIRC_SHARING;
+	bool now = features & OVS_DP_F_TC_RECIRC_SHARING;
+
+	WRITE_ONCE(dp->user_features, features);
+
+	if (now && !was)
+		tc_skb_ext_tc_enable();
+	else if (!now && was)
+		tc_skb_ext_tc_disable();
+}
+
+/* Give up the reference for the recirc bit without touching the other bits, so
+ * an upcall that is reading them keeps seeing what it saw.
+ */
+static void ovs_dp_clear_recirc_sharing(struct datapath *dp)
+{
+	u32 features = READ_ONCE(dp->user_features);
+
+	ovs_dp_set_user_features(dp, features & ~OVS_DP_F_TC_RECIRC_SHARING);
+}
+
 static void ovs_dp_reset_user_features(struct sk_buff *skb,
 				       struct genl_info *info)
 {
@@ -1724,7 +1754,7 @@ static void ovs_dp_reset_user_features(struct sk_buff *skb,
 
 	pr_warn("%s: Dropping previously announced user features\n",
 		ovs_dp_name(dp));
-	dp->user_features = 0;
+	ovs_dp_set_user_features(dp, 0);
 }
 
 static int ovs_dp_set_upcall_portids(struct datapath *dp,
@@ -1781,7 +1811,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
-	u32 user_features = 0, old_features = dp->user_features;
+	u32 user_features = 0;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1809,9 +1839,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1820,12 +1848,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	if ((dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
-	    !(old_features & OVS_DP_F_TC_RECIRC_SHARING))
-		tc_skb_ext_tc_enable();
-	else if (!(dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
-		 (old_features & OVS_DP_F_TC_RECIRC_SHARING))
-		tc_skb_ext_tc_disable();
+	ovs_dp_set_user_features(dp, user_features);
 
 	return 0;
 }
@@ -1947,6 +1970,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_portids:
 	kfree(rcu_dereference_raw(dp->upcall_portids));
 err_unlock_and_destroy_meters:
+	/* The datapath is freed here and never reaches __dp_destroy(). */
+	ovs_dp_clear_recirc_sharing(dp);
 	ovs_unlock();
 	ovs_meters_exit(dp);
 err_destroy_ports:
@@ -1969,8 +1994,11 @@ static void __dp_destroy(struct datapath *dp)
 	struct flow_table *table = &dp->table;
 	int i;
 
-	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
-		tc_skb_ext_tc_disable();
+	/* Only the recirc bit goes here. The datapath is still on the list and
+	 * its ports are still attached, so an upcall can be reading the other
+	 * bits from the receive path while this runs.
+	 */
+	ovs_dp_clear_recirc_sharing(dp);
 
 	for (i = 0; i < DP_VPORT_HASH_BUCKETS; i++) {
 		struct vport *vport;
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 7a7afaeceee5..55db1e635c74 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -76,7 +76,12 @@ struct dp_nlsk_pids {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.  A datapath
+ * that has %OVS_DP_F_TC_RECIRC_SHARING set holds one reference to the tc
+ * skb extension.  ovs_dp_set_user_features() keeps the bit and the
+ * reference in step, and every change goes through it with ovs_mutex
+ * held.  ovs_dp_change() calls it after the per-cpu pid update, which can
+ * fail, so a request that fails leaves the features alone.
  * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
  * @meter_tbl: Meter table.
-- 
2.56.1

