Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635941;
	b=QyOpdl8J9kqVV1roVqPEoTW91XU3yl/8niQds2sv7aX/q90aV5rc3BFo8vikzbP1pex1
	 S578WmuevSEH5yikG2/yvtNcN2cGBgB8XjbvqXIUcF2KvrqgtqWl/lq7K5KYEOT4nVmfR
	 rRiJwzRL6bfvWXNciVIu5pp0V+qN+XOx0bK4uM1242tsrYF95C386YCGe6lZbj62gAofS
	 KbLhH04W/33AQorhrpjXoquFOps41oP0VEg6BOKgIoXIwn7Ji8PZ+MHlEPVdjbxKVRoFM
	 YEEB4Q+Jcj3QQp7S7LWsHlYkfS3pQWZvJdkRYEpfDVQvVZVUGQuEHES2XrEEjDbpdvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JuKztkIpsryL9CIxNkD9yrvhsnQIweUopipeldiEH+8=;
	b=cmnSvHMxy5DTU+cVODtAZxuXyn87KS3caQ8aR4ABX/4IndCNdgvTVgUfXNnWw2IXi0EC
	 ykLTM8yPqr+gISQYjonYKoYlPXNueXRulzfLD4nHXuRPSLVS9skG5f00cU8301nYOCVhp
	 0imEGGI0NRs6+HmrhHcvKaC05FsqomimIipvM5LqnYU3l8VcdJrn03S/zJniU2l6uaskV
	 9Vov6CaTluFE0T1Ccp3aw1dZwucnmIe5/t+2hhA4ehB2it1qA46DbQFQjf0yFPGcNk5j1
	 T+0JpNiAzljJocM5fh5V0agMthfdudzMSa4Q+NRrciflueK+ZWZ1BgSP0WhuI4RyJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=ehGeOO7p;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21EE9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=ehGeOO7p
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-386ab9ab619so7808564eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795635939; x=1796240739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JuKztkIpsryL9CIxNkD9yrvhsnQIweUopipeldiEH+8=;
        b=ehGeOO7p1Neb6qdmTm2sZYg8WWizSZ3b18kAjOCErAddsEhHfYoy3lLMK7V44lP71W
         pFjcdBE6HxFSx7559psJ0RaoNXTrVhZErvTAu1Nva1CH+xMQNYRc7dtDneqrrHVjEexv
         kwV9W02Lpm4qITT0DsfLr7obn2ZyPhboK9b0dnhgG3Ph+3NO+Cx9mx7c2PPy/IxPymn6
         g9kFT6DaG3bE6BR8ppklSd6E9I0vNpLMY7BMthg3nkf0MJsIXaqfw/8gdo2woRYavVRK
         RctWCEqZa+QeGbUnREHfabxIX2Q+0Vqhb+SexZqJ4EJyaynKzEEwVzg3Sd3/WQqe0e9T
         308g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635939; x=1796240739;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JuKztkIpsryL9CIxNkD9yrvhsnQIweUopipeldiEH+8=;
        b=IBT7mRgnrv8vYdUxvL5rhwS22jRJf4RyRGcILr0Yjcs3UVp/t4xrkOj/FOhNH2tvQI
         QsBuBOxllr/FbINk4oQwpU5EEg9qjMNxdCG8lztyx+7TKkUAEiw7dglaVTlrgW4TPLCs
         45QEXX/r5xNdso3aImP5JXkGN8+LI21IJb5/2rFVpAEyEiT/25FWlM4j5tpdA0n3SusP
         PyXrhfORKPyCj51Esq1+OyI0iLnvYWUtWpIza1JF2vC0mqwbD7Sq58c6rib3BRFxIVpQ
         SEaMF2iacVA6wB0ycLeWQlAB9k5B0jzRoSxUdwQSxzGSXaSNLscBFlquMzgYtEjHaBqC
         WrMw==
X-Gm-Message-State: APuU4Z+tUX+CBIJS9a8eRBJKJIhHNOA7VqbHiCJhJ1IIC4XX/nKLquVP
	hKxjLGvGkYeLnQAvub7ERg4ww4iH2opcs22gLgylNfjHCYz290ZRnk5QTIGuG6sBGATpS5yJBeR
	UcsWKgdw=
X-Gm-Gg: AZFdTZfr5IEDzlVPPA/Ij97mq4hPwn++XF+ttSpy194YiJ6KCtV2IvnyIO/VqikX1f3
	07z4CzHvuiNUloF0liYss9PtJ44jcV6RZjYVYynAH95MkZFBr98OKzbdafbdhLAD8CnvEOpsf+c
	XugjSV2cZUylHuh1sgXLsnbupbtlhkaPMwbZTfz79TNje2KMRoBGeInErrYZKj6jgNzpNIFURKP
	pyfpu3rX8ageR+oI6Ns51DDA63wwCQY33akIRM1wsMA7+t0avXBxZZ5tGsnumjjI2Ggzs/qK4Eg
	a4ZQ/YSAUrhBEJjE9q2PBMm7+2LDUtoKfEmoR/qLaPfBGlZWwOuq3r12kEcsUD1Yeeaa18+/dtb
	EB2IduPdVEHdszERbj8m7ioMWh8138hSpXI87bEwMBW10h0zRk7P1Ofi6Y4hGeYyyaO5L5KyRw/
	oVliDGfhmKUFzEhZt+d64KP0q5d7Ha2RfepUsj2dFH+V+FcSLLPROuk3plwiwBxiNyot4IlPWsA
	8qkTvJVc4ciFSiB+1FP9Q9/FeqEuHHcEw2RW+8y+fPr0rRV8U98DiH7Joobn4A/XpQI7OaNxaFZ
	NPWem7Sgc6vLGBeNyPZhDmHLBjTJDSpkKqwisbDcExBS/E4SkVD+1ta+QUMdC79um9PNpOh4seB
	+cM6TYZ6WfwLJTxLE9FH6ogJN49fblVvPmtfvKN2JGtHox78=
X-Received: by 2002:a05:7301:787:b0:386:c6f9:b56d with SMTP id 5a478bee46e88-386c6f9b68cmr4853582eec.16.1795635939146;
        Wed, 25 Nov 2026 11:45:39 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386d605c894sm3737730eec.2.2026.11.25.11.45.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:45:38 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	n05ec@lzu.edu.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ylong030@ucr.edu,
	yuantan098@gmail.com
Subject: [PATCH 6.18.y 1/2] 8021q: use RCU for egress QoS mappings
Date: Wed, 25 Nov 2026 14:45:33 -0500
Message-ID: <20261125194534.52951-2-artem@trailofbits.com>
In-Reply-To: <20261125194534.52951-1-artem@trailofbits.com>
References: <2026050408-ideology-liftoff-aa01@gregkh>
 <20261125194534.52951-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Longxuan Yu <ylong030@ucr.edu>
Date: Mon, 20 Apr 2026 11:18:45 +0800

[ Upstream commit fc69decc811b155a0ed8eef17ee940f28c4f6dbc ]

The TX fast path and reporting paths walk egress QoS mappings without
RTNL. Convert the mapping lists to RCU-protected pointers, use RCU
reader annotations in readers, and defer freeing mapping nodes with an
embedded rcu_head.

This prepares the egress QoS mapping code for safe removal of mapping
nodes in a follow-up change while preserving the current behavior.

Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[ Backport to 6.18.y: context adjusted in vlan_dev_set_egress_priority();
  6.18.y predates the kmalloc_obj() conversion. No functional change
  from upstream. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 include/linux/if_vlan.h  | 25 ++++++++++++++++---------
 net/8021q/vlan_dev.c     | 31 ++++++++++++++++---------------
 net/8021q/vlan_netlink.c | 10 ++++++----
 net/8021q/vlanproc.c     | 12 ++++++++----
 4 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 89472ba4425f..2c30c5b62fb5 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -147,11 +147,13 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
  *	@priority: skb priority
  *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
  *	@next: pointer to next struct
+ *	@rcu: used for deferred freeing of mapping nodes
  */
 struct vlan_priority_tci_mapping {
 	u32					priority;
 	u16					vlan_qos;
-	struct vlan_priority_tci_mapping	*next;
+	struct vlan_priority_tci_mapping __rcu	*next;
+	struct rcu_head			rcu;
 };
 
 struct proc_dir_entry;
@@ -177,7 +179,7 @@ struct vlan_dev_priv {
 	unsigned int				nr_ingress_mappings;
 	u32					ingress_priority_map[8];
 	unsigned int				nr_egress_mappings;
-	struct vlan_priority_tci_mapping	*egress_priority_map[16];
+	struct vlan_priority_tci_mapping __rcu	*egress_priority_map[16];
 
 	__be16					vlan_proto;
 	u16					vlan_id;
@@ -209,19 +211,24 @@ static inline u16
 vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 {
 	struct vlan_priority_tci_mapping *mp;
+	u16 vlan_qos = 0;
 
-	smp_rmb(); /* coupled with smp_wmb() in vlan_dev_set_egress_priority() */
+	rcu_read_lock();
 
-	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
+	mp = rcu_dereference(vlan_dev_priv(dev)->egress_priority_map[skprio & 0xF]);
 	while (mp) {
 		if (mp->priority == skprio) {
-			return mp->vlan_qos; /* This should already be shifted
-					      * to mask correctly with the
-					      * VLAN's TCI */
+			vlan_qos = READ_ONCE(mp->vlan_qos);
+			break;
 		}
-		mp = mp->next;
+		mp = rcu_dereference(mp->next);
 	}
-	return 0;
+	rcu_read_unlock();
+
+	/* This should already be shifted to mask correctly with
+	 * the VLAN's TCI.
+	 */
+	return vlan_qos;
 }
 
 extern bool vlan_do_receive(struct sk_buff **skb);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 27b84c412008..f86f6b770609 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -208,39 +208,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_priority_tci_mapping *mp = NULL;
+	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
+	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
 	while (mp) {
 		if (mp->priority == skb_prio) {
 			if (mp->vlan_qos && !vlan_qos)
 				vlan->nr_egress_mappings--;
 			else if (!mp->vlan_qos && vlan_qos)
 				vlan->nr_egress_mappings++;
-			mp->vlan_qos = vlan_qos;
+			WRITE_ONCE(mp->vlan_qos, vlan_qos);
 			return 0;
 		}
-		mp = mp->next;
+		mp = rtnl_dereference(mp->next);
 	}
 
 	/* Create a new mapping then. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
 	np = kmalloc(sizeof(struct vlan_priority_tci_mapping), GFP_KERNEL);
 	if (!np)
 		return -ENOBUFS;
 
-	np->next = mp;
 	np->priority = skb_prio;
 	np->vlan_qos = vlan_qos;
-	/* Before inserting this element in hash table, make sure all its fields
-	 * are committed to memory.
-	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
-	 */
-	smp_wmb();
-	vlan->egress_priority_map[skb_prio & 0xF] = np;
+	RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
+	rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
 	if (vlan_qos)
 		vlan->nr_egress_mappings++;
 	return 0;
@@ -616,11 +611,17 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-		while ((pm = vlan->egress_priority_map[i]) != NULL) {
-			vlan->egress_priority_map[i] = pm->next;
-			kfree(pm);
+		pm = rtnl_dereference(vlan->egress_priority_map[i]);
+		RCU_INIT_POINTER(vlan->egress_priority_map[i], NULL);
+		while (pm) {
+			struct vlan_priority_tci_mapping *next;
+
+			next = rtnl_dereference(pm->next);
+			kfree_rcu(pm, rcu);
+			pm = next;
 		}
 	}
+	vlan->nr_egress_mappings = 0;
 }
 
 static void vlan_dev_uninit(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a000b1ef0520..a5b16833e2ce 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -260,13 +260,15 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-			for (pm = vlan->egress_priority_map[i]; pm;
-			     pm = pm->next) {
-				if (!pm->vlan_qos)
+			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
+			     pm = rcu_dereference_rtnl(pm->next)) {
+				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
+
+				if (!vlan_qos)
 					continue;
 
 				m.from = pm->priority;
-				m.to   = (pm->vlan_qos >> 13) & 0x7;
+				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
 					goto nla_put_failure;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda49..0e424e0895b7 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -262,15 +262,19 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 		   vlan->ingress_priority_map[7]);
 
 	seq_printf(seq, " EGRESS priority mappings: ");
+	rcu_read_lock();
 	for (i = 0; i < 16; i++) {
-		const struct vlan_priority_tci_mapping *mp
-			= vlan->egress_priority_map[i];
+		const struct vlan_priority_tci_mapping *mp =
+			rcu_dereference(vlan->egress_priority_map[i]);
 		while (mp) {
+			u16 vlan_qos = READ_ONCE(mp->vlan_qos);
+
 			seq_printf(seq, "%u:%d ",
-				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
-			mp = mp->next;
+				   mp->priority, ((vlan_qos >> 13) & 0x7));
+			mp = rcu_dereference(mp->next);
 		}
 	}
+	rcu_read_unlock();
 	seq_puts(seq, "\n");
 
 	return 0;
