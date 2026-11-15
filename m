Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760313;
	b=bHEfHMwUH2+VppjGWYhjDJ6T2IGXlCRctsuc7SxwCMSDObMM80Pti2YSujOUHrODJ18E
	 NKrTtATJHBCSiOM7IXrciD2y5RioWeA4TDpZ0wYB26cSaSbkV8WWDYBIlKqXmJcQTDGuK
	 5IEv/W7C6V9CuyrENZXGIlctxsDDo3baNij3mbXTFjlxapx4j3Z+LLHoxw2IMVae0KvcC
	 sF2qCcclISZcmnn1bWR3CrpVAloqCsrtXVMCavDq2jLvzec5ALaPWhktjMU/I1v0tv45L
	 iXi/kt8asLvFFJcK9ACr9pF/i3xJ2V1qfoqOgO0uGTnDQZAhyedPd/TKqZ45Q7XPW4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p6TAb0F0vn/WzsshVNtwsj45DAKxRfE65biJ29WXSm4=;
	b=RnAs5DfTZxMqOC+eNbgcxpUOELxX/snxLq1WxRsrQx2KwuwA/1Mc6gtBlDTUIQw6HXu0
	 xvBeGkvPCkj3cCt62WRKdTYIQUZ3W04UvLMGsA4G86oBirlrXrjOHZjUmroVfeAHiY6ir
	 3fR7qY5CliP1Evamf6kSMh/tjt1+grzKFX3VAz8sttlcLu3L8reyz8hv7jakjVxu3jeRv
	 8dCeO9sQhiAdmUmgF8MpWObVtaVU6c5IYTx8sPkft+YqhRYmuLUWj0MZyHISkJ/Qcn8G4
	 LQYfQ3i1FDiyZRmrxOMZCDV6Lgri3p3N00gFcj+ybNyPtdPSEZ58d2DmjQ8ofw8uCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eaZQZ4Sn;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1C606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D1C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eaZQZ4Sn
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so3479088eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760313; x=1795365113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6TAb0F0vn/WzsshVNtwsj45DAKxRfE65biJ29WXSm4=;
        b=eaZQZ4Sn0u2ZpfeLDzAqKQ/3DlukzLFeyU7dE9Yc9hUIVGQHbxAfkviowDNCa46IVS
         JcRWBTj/Nq2vcyhdx4GHLg3P0xVC48JDN7ejGCYG0YFsFaD3nhX5lq5YRP/cJ3FTO7Ta
         1RIbCFW/klz/pau3OPvsVhvMPc58Ukl2csFgRS0gKz+poRQWf6ZtFb2ax+I0RYo795qe
         gHioij7tJ3kO3bqeGX1dOQQgTTrGlPu5yCW6FeVvNNZhrSGWRMzgdLw/r44DmLxURDN8
         +y8yHYAYBaBL5ppFo04YfpZxWpsM19q67AalAXC3MCB5/DZPhZO5HnP3WQsK/lJ6QtW/
         StQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760313; x=1795365113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6TAb0F0vn/WzsshVNtwsj45DAKxRfE65biJ29WXSm4=;
        b=C9RYTeHJPDP0xbxdT+CaMTOlCGu/o+bU4afIOIZlmAQehm/ZlZD0YvoDzRgl73luGU
         ViJgL5Xl8/jM2Dq9zYOH2adgEve5d3ViSL0dHsVq9+pfeGrqkffUBzoCcK32G7zjHO4B
         2zer/TXgd28BmHbe5yC/1YS229uNDvjRC2OMpjWRRjZhw9u6bOK+niHxjKmEh0jaOvHN
         prk1CJmlcpAzym9JRPK7NPSmjBCGRMSwLi6NDuuO+7xArKL6oY4ZV5NAN0OzBTwzd6rT
         ExkC2pM48vBWftAjkAfhvZyQcWFygkp5oa/D+vB8VfcabFSUYoL/i6vRlnlvdkahdtGw
         hlUQ==
X-Forwarded-Encrypted: i=1; AL+hErEr6X7Y1fITMtPMjB8JTvP/V7QNw3RZIyfaQVg0suWZ7NTLYvMe3Jca1zBdXuY+ZqQ98OLjBVo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Z3Ck4kHkfyUfyPEQU8KzjGN8q03YEXTD91Q+yNhZfv6G+R0cP
	50/o0NL2aYfHjfiinZkHls0SV1NpP0lM85rZhB+wayOxzwsumpIumaQK
X-Gm-Gg: AYBFou1ssaDJdWaltqrka4fH8lE3cJA/wA6sIZwAUMiQ3zrmQC3m1pO2KMkCJ5a2GBP
	zcwvEOVSDvtKT5jzvSx/mNlpW+3St0slMbguCX5H3FVu3VQsBB3PLd+6ZdoaG5BiQJ0CJ1KgsAW
	zrMUR6L1dbcJXK5Bi9ngnD/jtpTmTmfGmo1SqpP3JbvKUmtVBAL4KjQ2TP+A+O7lM3fs4GXYZDC
	en4V9hI1U6bZbvk+B8NqzBh8EW/3XByMiLfmSY2cWllGS85VFoK1NQJsF/gjySc/mAnHRZIUPWi
	v00XynLrLOqx3ztxy9qTlzrEmYshC6fvTbl2mmUk0/VBotSJ34LkQlhxK6Z3zheQd4rjJIWsIkl
	cATrK3JIGzyo9r1rihRouZJE0KIBvfocLA0vfDPfATJJf+lP4TLw+lObojcizfuSkFe++aNTAXo
	Nxz/gsHkjsyID7kYJ/irPpGFw+4Yu0e7IlahPTZacMZEzptTw32KYxBt6RAI2wGt8o2GvtiYXIv
	rX1v5+hSBMszPYd4m0chJ55/IdHdZ+8YlMfiKg5Yc+UaVDSjWCRcfIvE4umu/Yw5b2HBECCaQah
	JWRwpp1jjXZYJVrG3mScKaN2
X-Received: by 2002:a05:7300:fd05:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-37968b848d9mr11594881eec.33.1794760312488;
        Sun, 15 Nov 2026 08:31:52 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm27775320eec.28.2026.11.15.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:31:51 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] net: openvswitch: do not record user features when the change fails
Date: Sun, 15 Nov 2026 11:31:33 -0500
Message-ID: <20261115163134.3202677-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115163134.3202677-1-houminxi@gmail.com>
References: <20261115163134.3202677-1-houminxi@gmail.com>
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
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 34 +++++++++++++++++++++-------------
 net/openvswitch/datapath.h |  5 ++++-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..8fcb9f2c8ece 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1704,6 +1704,20 @@ static struct datapath *lookup_datapath(struct net *net,
 	return dp ? dp : ERR_PTR(-ENODEV);
 }
 
+/* Called with ovs_mutex. */
+static void ovs_dp_set_user_features(struct datapath *dp, u32 features)
+{
+	bool was = dp->user_features & OVS_DP_F_TC_RECIRC_SHARING;
+	bool now = features & OVS_DP_F_TC_RECIRC_SHARING;
+
+	if (now && !was)
+		tc_skb_ext_tc_enable();
+	else if (!now && was)
+		tc_skb_ext_tc_disable();
+
+	dp->user_features = features;
+}
+
 static void ovs_dp_reset_user_features(struct sk_buff *skb,
 				       struct genl_info *info)
 {
@@ -1716,7 +1730,7 @@ static void ovs_dp_reset_user_features(struct sk_buff *skb,
 
 	pr_warn("%s: Dropping previously announced user features\n",
 		ovs_dp_name(dp));
-	dp->user_features = 0;
+	ovs_dp_set_user_features(dp, 0);
 }
 
 static int ovs_dp_set_upcall_portids(struct datapath *dp,
@@ -1773,7 +1787,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
-	u32 user_features = 0, old_features = dp->user_features;
+	u32 user_features = 0;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1801,9 +1815,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,12 +1824,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
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
@@ -1939,6 +1946,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_portids:
 	kfree(rcu_dereference_raw(dp->upcall_portids));
 err_unlock_and_destroy_meters:
+	/* The datapath is freed here and never reaches __dp_destroy(). */
+	ovs_dp_set_user_features(dp, 0);
 	ovs_unlock();
 	ovs_meters_exit(dp);
 err_destroy_ports:
@@ -1961,8 +1970,7 @@ static void __dp_destroy(struct datapath *dp)
 	struct flow_table *table = &dp->table;
 	int i;
 
-	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
-		tc_skb_ext_tc_disable();
+	ovs_dp_set_user_features(dp, 0);
 
 	for (i = 0; i < DP_VPORT_HASH_BUCKETS; i++) {
 		struct vport *vport;
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 7a7afaeceee5..e94b77261b95 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -76,7 +76,10 @@ struct dp_nlsk_pids {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.  A datapath
+ * that has %OVS_DP_F_TC_RECIRC_SHARING set holds one reference to the tc
+ * skb extension, so this field is written last, through
+ * ovs_dp_set_user_features(), with ovs_mutex held.
  * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
  * @meter_tbl: Meter table.
-- 
2.56.1

