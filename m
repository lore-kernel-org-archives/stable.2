Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984898;
	b=IwHb416Q+t17O0DbzDjMFvE1qo8urEdMxe5xl4SgMS/lCa3ohxcMessAO5nXrRBFiPgF
	 HQ/wcrSquoLFfkHtGA0xv784vxnBbpfd1jcy3w3MuHvCKOSPuEo1jk7bQNaHRYLhTFYIU
	 2d0sqH8pfreMoRz/Ym1Q3cBN5PW01T2hCM6WGAq04ByiV8MDq/pjyUiYWM1V8ZkG0Dvie
	 CWeiAWUqFrfHCP8WBd1Rwff4yjVMhhql/qRjTCOMUsMOWFvI1HeFGfraSxwv7oSpZIwqV
	 WPO8BZwQc9Iqw0z5OxZCVqm+oDsE7OFhdpm8rAAmIL2KuPLhigI41RK8r/vT0N5V8lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZdIaRMcoS2mf1WBkYX2H9hUMU/sj07+KEju7hb3fz4I=;
	b=r3CmmqfoyI5xlm4s/3Zpi3cSbpdb0RbS1zKDjL8USTODUeUtwz/pwyfN4Fem7NCkXD7v
	 10qdDBor1aXHFzsC9AWis8iSfiYy8UJWmk/Tv2JhIORAAwG2cV80ui3Uo5VSZwKFsitDJ
	 upuIM/nYXNKuY7OiZWds8/MylKsjYRwdW62pjquyy5NaiRckjKtDiTHtmNRVjCAWlDOpD
	 GiGArpv4DHtU949Ro+/hOJ8w9tQu9vFt0khE7oNBypIRpcGOXHaPZ5w3g3k4FYEhtK3vT
	 qFCuNYKNk9hHhXblQvFCK5FJ2dh3aWjHYDdHA0PMgdA6m80YT4DiAW1gSoiV1IUJb/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8LszQDi;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4A606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A4A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8LszQDi
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so1264226eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794984897; x=1795589697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdIaRMcoS2mf1WBkYX2H9hUMU/sj07+KEju7hb3fz4I=;
        b=r8LszQDiomVCfFCiIf31L/2qRSZXRu3TwRDMj22Uq/Oc5WJj2cGPShwZXxq09yAsng
         IVdtN3zA0mYJuU0RGI+5H2YGjj4pfaa0/Gks6JPaI6Jzgko0rsNs3yWuSj4FMkj7PdUl
         sO7kbaxQVpmy3M4KmhAsDe4VLhKk7ACDKRTzY99k4mikfqxAHXC18PSRmpH1Adqt4j8f
         74tRsCYTry0GHS0s+9Ww9ZS7d/7T9nvJFJcamGsoPEIQTtxz1uMhVdknbbmcpxfzFLKx
         whZwCJGg3iGQAiPV860MFf7hEo9fDxw1AHoQvGGq1NpXJtwHHdyBFBGlBPf3/NkswcvT
         7BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984897; x=1795589697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdIaRMcoS2mf1WBkYX2H9hUMU/sj07+KEju7hb3fz4I=;
        b=Peub0+k0wu2MbocsVXFqtLAonQ4W5u5Zo9c+XOm5YDYeBI1vY9dvS0GRg2nr2qpt13
         J6C07aG0kBPLMaL6TqA6FK163yiFW8mJAsju4Z6Nrx2dFnr6OQlDmoIEEpTArmfVZPmB
         j0n3qra3Xk8OafxunxtrivlH9xasvWUAaYQX7nvntuGVVuzPg7bMIJPWfNWmg1Z4hE2G
         dgXPSoUiwnfF7k+b7pLfPSDky+pGoYD297KRUcmeipnVF5RPI+6NL07UY0+xYt7ka+wQ
         kb1le+c9Xso1BZ8wd5oqleUp7b2ohZMImqs4uGCclPBtXerhpYyBK8UGFcdOvXRWRKha
         H0Rg==
X-Forwarded-Encrypted: i=1; AL+hErEJd89O8AEiZR9WBnQfbr/0TDDTNWuWFzN9R7RzEUB8CzMnZx8iNWgtiRoZwx6fsqrZpjXPD4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6no/ybEvL4TGWHSRyrJHf4si7Vj0nYrqXHaJJZjlZttrvxcxZ
	jNr7BmV+auDn7lVTKv8N81P65FtGO2Bglnt8V8anUl3OcQnJAyvVEQbV
X-Gm-Gg: AYBFou21R8MfH7ou+cPJpgAyiO+QDxSqFYNti0L69c0EqSm7BqwNMZKUl+KmnrDbGwY
	rXbZ9l++79GRSmHnJVI8QrZivjBMuSul6nnIHa01PIPCW3RBjHasMxDqxvfmwA5jWWfpvaHmW1L
	US0kYur7JZPbaoN7qSNu4Lb/TC2Sm971/7++yh8x6jr4pmjOTVDeNeIYJuDbe/toPn3JPOKa8xc
	8dLPbyd91f1EdaohsFo8TtX8DefXRGvhEoD+ofGxFAHjHiztdY2mvqfRMXH3A5bBHYePSCWRN7R
	oTCbJVZnudSXpgd26FO1Dr2kpKWXdqauz3MC/1nt3TZgvKecQ+lNByE0HnzvG7EAkve9Io07BKK
	MFLXNqFI4zPUeKBpoleUaqeMjpU8l+mEWcNM+2vHLK2AJVSa/njiAX6cXrPSB0t6Y32GFM8yfmo
	TadwFSXRktx2zCylyW75y+5uHer3U+ekPCGvOwHFCv079uCGIloyGOXx3ZYxWG/tO4+k0Ba0bCy
	+QGp3FkdPqNvK1fWMwp7XvNFYbyhqsS30PulTEyq3eGVe2FqDwOumYaVXJoJnTgFDuemPF4/XnD
	bVLKoWNZF4R8TXVGOPdMt+rl
X-Received: by 2002:a05:7300:d210:b0:374:c5cd:42cf with SMTP id 5a478bee46e88-3828180f712mr1932273eec.35.1794984896244;
        Tue, 17 Nov 2026 22:54:56 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm4612640eec.28.2026.11.17.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:54:55 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net v5 1/2] net: openvswitch: do not record user features when the change fails
Date: Wed, 18 Nov 2026 01:54:34 -0500
Message-ID: <20261118065435.2367014-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118065435.2367014-1-houminxi@gmail.com>
References: <20261118065435.2367014-1-houminxi@gmail.com>
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

Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
__dp_destroy() clears the bit before the ports are detached and before the
datapath leaves the list, so an upcall can still be reading the other bits
from the receive path. queue_userspace_packet() decides from
OVS_DP_F_UNALIGNED whether to build a nonlinear skb, and pad_packet() reads
the same field again, so a store that clears every bit can change that
decision between the two reads. Clear only the recirc bit, which is the one
this path dropped before.

The store goes through WRITE_ONCE() because the receive path reads the
field without ovs_mutex.

The receive path read the field twice as well, once to size the head room
and once to decide whether to pad, so a set that changed the bit in
between could make it pad a nonlinear skb. It reads the field once now and
uses that value for both.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 58 +++++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h |  7 ++++-
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..7c1af21f74df 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -439,9 +439,9 @@ static size_t upcall_msg_size(const struct dp_upcall_info *upcall_info,
 	return size;
 }
 
-static void pad_packet(struct datapath *dp, struct sk_buff *skb)
+static void pad_packet(struct sk_buff *skb, u32 features)
 {
-	if (!(dp->user_features & OVS_DP_F_UNALIGNED)) {
+	if (!(features & OVS_DP_F_UNALIGNED)) {
 		size_t plen = NLA_ALIGN(skb->len) - skb->len;
 
 		if (plen > 0)
@@ -461,6 +461,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	size_t msg_size;
 	size_t skb_len;
 	unsigned int hlen;
+	u32 features;
 	int err, dp_ifindex;
 	u64 hash;
 
@@ -494,11 +495,16 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	    (err = skb_csum_hwoffload_help(skb, 0)))
 		goto out;
 
+	/* The features can be changed while this runs, so read them once and
+	 * use that value for both the head room and the padding.
+	 */
+	features = READ_ONCE(dp->user_features);
+
 	/* Older versions of OVS user space enforce alignment of the last
 	 * Netlink attribute to NLA_ALIGNTO which would require extensive
 	 * padding logic. Only perform zerocopy if padding is not required.
 	 */
-	if (dp->user_features & OVS_DP_F_UNALIGNED)
+	if (features & OVS_DP_F_UNALIGNED)
 		hlen = min(skb_zerocopy_headlen(skb), cutlen);
 	else
 		hlen = skb_len;
@@ -598,7 +604,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		goto out;
 
 	/* Pad OVS_PACKET_ATTR_PACKET if linear copy was performed */
-	pad_packet(dp, user_skb);
+	pad_packet(user_skb, features);
 
 	((struct nlmsghdr *) user_skb->data)->nlmsg_len = user_skb->len;
 
@@ -1704,6 +1710,24 @@ static struct datapath *lookup_datapath(struct net *net,
 	return dp ? dp : ERR_PTR(-ENODEV);
 }
 
+/* Called with ovs_mutex. The receive path reads the field without it, so
+ * the store is single and goes through WRITE_ONCE(). The store happens
+ * before the reference is taken or dropped, the order ovs_dp_change() used
+ * before this helper existed.
+ */
+static void ovs_dp_set_user_features(struct datapath *dp, u32 features)
+{
+	bool was = dp->user_features & OVS_DP_F_TC_RECIRC_SHARING;
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
 static void ovs_dp_reset_user_features(struct sk_buff *skb,
 				       struct genl_info *info)
 {
@@ -1716,7 +1740,7 @@ static void ovs_dp_reset_user_features(struct sk_buff *skb,
 
 	pr_warn("%s: Dropping previously announced user features\n",
 		ovs_dp_name(dp));
-	dp->user_features = 0;
+	ovs_dp_set_user_features(dp, 0);
 }
 
 static int ovs_dp_set_upcall_portids(struct datapath *dp,
@@ -1773,7 +1797,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
-	u32 user_features = 0, old_features = dp->user_features;
+	u32 user_features = 0;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1801,9 +1825,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,12 +1834,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
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
@@ -1939,6 +1956,9 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_portids:
 	kfree(rcu_dereference_raw(dp->upcall_portids));
 err_unlock_and_destroy_meters:
+	/* The datapath is freed here and never reaches __dp_destroy(). */
+	ovs_dp_set_user_features(dp, dp->user_features &
+				     ~OVS_DP_F_TC_RECIRC_SHARING);
 	ovs_unlock();
 	ovs_meters_exit(dp);
 err_destroy_ports:
@@ -1961,8 +1981,12 @@ static void __dp_destroy(struct datapath *dp)
 	struct flow_table *table = &dp->table;
 	int i;
 
-	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
-		tc_skb_ext_tc_disable();
+	/* Only the recirc bit goes here. The datapath is still on the list and
+	 * its ports are still attached, so an upcall can be reading the other
+	 * bits from the receive path while this runs.
+	 */
+	ovs_dp_set_user_features(dp, dp->user_features &
+				     ~OVS_DP_F_TC_RECIRC_SHARING);
 
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

