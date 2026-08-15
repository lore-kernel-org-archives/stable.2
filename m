Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5523AE62
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755565; cv=none; b=ffjdJHH+r0bZicqhWGR8gsP7firLZisAotJ6qIWcNYiornzsgGm75URVjmr5BxlCLpxCEVT36k0cjaf7gY0mE4+5BZm9y8SdTtWYCSIt5c7cZhwM4RJgeVVgdHA03mxC5aFHymUS++YA+HG4gRRXYfLyjoSwkUHLl7kMl1t+FZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755565; c=relaxed/simple;
	bh=0Z4P/jp0fu6vykOGEa30QqlDY/ioWFuKUDyZe5Zm+uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R75vGgsosZEPt3vtYg6ovM3PAY3tv8XqPcMpbI0sK7y/Y2VbbTcys+Ro1caxTh4xEz7TkBCGQkTIMS9GUBeVeM6gx/wJWXGbNR73TVoyIBrcHISTMaM0oKaDO6TWdXMhpSfBggc2Ou9q4nKRGPW3O70KgEJ5R9sdMbiOlbQixuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498074920dcso6176255e9.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 17:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786755562; x=1787360362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMe+JVngFFXsUJ2EY92OUmaJ2oOmTOXC99ljO0kx/ac=;
        b=MwYyoBfsgtnYTmVpZkgEbTdupw+8RW5wpMEP4BTRL3MFrF6CW04d3hbibrtCOzd97Z
         0y7o0kmusRbUo1JeOVzO2jPYE6yhDla4oOoQKu7TEpQDCdxPZ0gzRGICKPOri/GNp5rm
         dJFZCPeS/vUyZMichZ7wjZyVWRNZPmbid2cXlwkPKXjmqhO84u4HVgDEKBAGYcSLchY2
         /kcxtGAviUal8FdZZ1tFqyKmJu9M4QJmPZFTIAX9lSjauXAh3KdFtEeOJl/c0bdeulZS
         Bo7H0v6WPZ6XFX4USs4lSyYwZE/vj6z0u4gKXKZm3aY4Y8GSb19kV2GQSQwM+5VfhIHx
         PvXw==
X-Forwarded-Encrypted: i=1; AHgh+Rq13R5LS/733tPI15p0jcYbHimzq+W7onSXg5bHi82W1Ajnzfxp+VrXNegeFnf2amM+/XBnvxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJjnJpB1yv/qm1b8MHFXuTGz5NKs5UlZIDs8tXtH0QTfka1kG
	nhBUp8kC08zG8Wet8ksbdP5w2MMW1wrKtC9Ix03+gYTKbUEWflf4zY0K
X-Gm-Gg: AR+sD123ymt3ZpBjw+TNCw1YdddpVzJA7YxhKQYztBfotRjRTyCH32SbstF+qFAgjqX
	pqhptF0Cv49gocIJInpsLudZYQ9obC21wF0cyjErj7SlE3K4CtcS3SGx43UAIDQ0gQVTVqIhoDh
	XCuafLn1latyBhEA48YlLtdU4laty/h+iqkWm857+qBSWlVu1gb/IO8Fpp8u6rp3yTC9k/o/jeZ
	vf/NpO3F/d/AM07ptzloAaqR63XEDY4QTYuLMdjJs2gOMOvUJx1OSIqDRKG3SjXN8QisjK9dpEq
	gv4pKQSImYfOVAlBnMTtNr0yO2edSdj3zxCS+uQpR9VNWwxi7VEKUil6MEMtw91S+9dCpGE/C7l
	cek52aAqIF/ur7RmM/RLt6uL5Lvch3nua8ci48vJWVIUsBgLZktb/aUpf6S/WTZWQG+ndndo9gZ
	4rnzvWaBwkwmVazkM8pR0CZTwDwfOYE/TNcvLDSbVkfb4cBFNaC6iiXvcqbWbT+BJvwGHEbOKuS
	y9MBh7O4X/y+dBFjVs+
X-Received: by 2002:a05:600c:1c07:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49987950d78mr129085315e9.7.1786755561664;
        Fri, 14 Aug 2026 17:59:21 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm12532061f8f.24.2026.08.14.17.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:59:21 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net: openvswitch: fix flow mask use-after-free on flow deletion
Date: Sat, 15 Aug 2026 02:58:56 +0200
Message-ID: <20260815005915.1097270-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in the Fixes tag below made so flow->mask free is scheduled
via RCU right after it is removed from the flow table.  The pointer
stays in the flow structure and it can be accessible while in the same
RCU critical section.  This is done to avoid requiring ovs_mutex for
the ovs_flow_free().

However, while removing the flow during processing of CMD_DEL, we do
not take RCU read lock before the removal, and ovs_flow_cmd_fill_info()
uses the flow->mask pointer afterwards.  The RCU read lock is taken,
but it's already late at that point.  The comment on that line
acknowledges that the lock is cosmetic and doesn't serve a real purpose.

This leads to use-after-free if the RCU grace period passes between
removal and the filling.  It is a short race window, but it is there
and can lead to a real crash in case memory allocation for the info
takes a bit longer:

 BUG: KASAN: slab-use-after-free in __ovs_nla_put_key
             net/openvswitch/flow_netlink.c:1996
 BUG: KASAN: slab-use-after-free in ovs_nla_put_key+0x2463/0x2e30
             net/openvswitch/flow_netlink.c:2250
 Read of size 4 at addr ffff88801ee89970 by task ovs_flow_del_ec/9487

 Call Trace:
  <TASK>
  __ovs_nla_put_key net/openvswitch/flow_netlink.c:1996
  ovs_nla_put_key+0x2463/0x2e30 net/openvswitch/flow_netlink.c:2250
  ovs_flow_cmd_fill_info+0x420/0x9c0 net/openvswitch/datapath.c:930
  ovs_flow_cmd_del+0x53a/0x970 net/openvswitch/datapath.c:1467
  ...
  netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556
  </TASK>

 Allocated by task 9487:
  mask_alloc net/openvswitch/flow_table.c:967
  flow_mask_insert net/openvswitch/flow_table.c:1012
  ovs_flow_tbl_insert+0xea2/0x1a90 net/openvswitch/flow_table.c:1084
  ovs_flow_cmd_new+0x7e3/0xd90 net/openvswitch/datapath.c:1086
  ...
  netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556

 Freed by task 9485:
  rcu_free_sheaf+0x1e/0x100 mm/slub.c:5978
  rcu_do_batch kernel/rcu/tree.c:2645
  rcu_core+0x59c/0x10c0 kernel/rcu/tree.c:2897
  handle_softirqs+0x1e4/0x9a0 kernel/softirq.c:622
  ...
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062

ovs_flow_tbl_remove() must be called after the ovs_flow_cmd_fill_info()
to avoid this race.  This also helps with cleaning up the forced cast
and the cosmetic RCU read lock.  Before the commit in the Fixes tag the
order did not matter as long as the flow object itself was not freed.

A wider RCU critical section could be another option, but we have a
GFP_KERNEL allocation in the way.

Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-32042.

Fixes: 56c19868e115 ("openvswitch: Make flow mask removal symmetric.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.c | 45 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index ae69b2cabab9..ded46d993a4e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1473,33 +1473,34 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
-	ovs_flow_tbl_remove(&dp->table, flow);
-	ovs_unlock();
-
-	reply = ovs_flow_cmd_alloc_info((const struct sw_flow_actions __force *) flow->sf_acts,
+	reply = ovs_flow_cmd_alloc_info(ovsl_dereference(flow->sf_acts),
 					&flow->id, info, false, ufid_flags);
-	if (likely(reply)) {
-		if (!IS_ERR(reply)) {
-			rcu_read_lock();	/*To keep RCU checker happy. */
-			err = ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex,
-						     reply, info->snd_portid,
-						     info->snd_seq, 0,
-						     OVS_FLOW_CMD_DEL,
-						     ufid_flags);
-			rcu_read_unlock();
-			if (WARN_ON_ONCE(err < 0)) {
-				kfree_skb(reply);
-				goto out_free;
-			}
+	if (IS_ERR(reply)) {
+		netlink_set_err(sock_net(skb->sk)->genl_sock, 0, 0,
+				PTR_ERR(reply));
+		reply = NULL;
+	}
 
-			ovs_notify(&dp_flow_genl_family, reply, info);
-		} else {
-			netlink_set_err(sock_net(skb->sk)->genl_sock, 0, 0,
-					PTR_ERR(reply));
+	if (likely(reply)) {
+		err = ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex,
+					     reply, info->snd_portid,
+					     info->snd_seq, 0,
+					     OVS_FLOW_CMD_DEL, ufid_flags);
+		if (WARN_ON_ONCE(err < 0)) {
+			kfree_skb(reply);
+			reply = NULL;
 		}
 	}
+	/* Removal has to happen after ovs_flow_cmd_fill_info(), as it uses
+	 * the flow->mask that can be scheduled to be freed by the
+	 * ovs_flow_tbl_remove() and we're not holding the RCU read lock.
+	 */
+	ovs_flow_tbl_remove(&dp->table, flow);
+	ovs_unlock();
+
+	if (likely(reply))
+		ovs_notify(&dp_flow_genl_family, reply, info);
 
-out_free:
 	ovs_flow_free(flow, true);
 	return 0;
 unlock:
-- 
2.55.0

