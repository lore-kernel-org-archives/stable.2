Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186201;
	b=d37fSlPZDrNSWCghHSBgdG32Ant5oLV1fARIbhP1D7cEbwwqB5wPfs41iX1ZXUh/mmwH
	 S7H+MKwj8oeyHbgDQnuiwZ/mpO1DCxdaPxxQjgRnq1gFmtekRdCv76OB60xZmQpWD5EUt
	 oIgHOm8kguTwlL3x0hGIO01PpoVIXpYSsdjnkbF2WYv924bfh2ijP79pS3XJs9EkAjyEW
	 aZ3Emlm90BTVuOw+J2yposp3KWcpkCaQaCwC7RxKCXd4ty/QoA1niRB3DxvstRZ4oLdvn
	 bTZasnR8mtnmyJwEuXAxBpPTx/k1fnO2iq/Gh3iCUg2l5qIxCMdMczQI3fo1QbMMYWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6CsZbajnX+G6EuNM0dqIWI4/9BGRckaGe/eL9AlMfp8=;
	b=xoDYpN/ioez7xmUmiIpMzyklLhI9sYA5iYsrJkfmiqjgYMKFmaWa7c5XNFTjmVcLj2RC
	 EFTZJAUl26rwicKiI8W8dVt/2/iqhMtBIFwraJW0ICzF2YWmAADEnVPJPHR5/jAozX+3p
	 3Hzo1JDRKZQdbX1YcsDEXAxWIso8nNweyJJ9mjtuc4powTUtS2Fu7+Ue+gy3uHXTx5UhC
	 /3NdWy57SV0b0+8+N6NUlxsOsACBcMbyR8y4wI0RgMglkYd5DvyrT6bY2Yw4WZ5izbOnt
	 Z/2CIahB/ORrXBlNCxt9VO0aEygtysC1OB6wEhKdF4mMnfdnQNG17x6mj5MeKPaUsSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2jREAOS;
	arc=none smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD2606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFD2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2jREAOS
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-462dec1c4c5so352129fac.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186200; x=1793791000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CsZbajnX+G6EuNM0dqIWI4/9BGRckaGe/eL9AlMfp8=;
        b=h2jREAOSuuQ72nqFvBTUYdWom2DGLw0p6qr5n8hSBNKHH+Tdm4XDi31OoSdAQFsHFD
         1NQiDxeYXTeq3GqMlYTesswoboxDtEtPhX9APEKg1ivRVGFHLYiCAfjtendZ9clfDiFK
         tC5Wxqh+hOP77QNih6iRcADM3ZK5rKrvknqPnU6+LvIVj2wvmSkknMiodIofXTAHrMZ2
         oNGAl9NuGErpdhDN1qW2n3oVl78df1GgeStnjta+lzG4kC2eafJCBuwuHMBy8I4lRLtA
         ++5ml9dntmHPYjL2bkcrLs3wLpv6MK2s0VJUJhKVyZ+cqGjMNeffsQ3OPtnZX+oNXdMB
         C8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186200; x=1793791000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CsZbajnX+G6EuNM0dqIWI4/9BGRckaGe/eL9AlMfp8=;
        b=l9G6ploA+RPZyU4c1F67/BG4m7jgGZN+C6ZkHqyPi8K5fHdIwd/10m5dMwSKLeuEqE
         ++c/V/JzbnUIh5XFSh42Ajs2XuKGhz/KFgYvEfPs1D8Mp8JHrirhGDnoqGaJLa0lxmoS
         d6PVkZvN2NCZ9FmDZKo/idE89v8KYq07yI+CdQekN43fL2y84faJF+HKukl6OTvrLI1o
         091BrMLdN/haYqwAG3uOETV9IDUL0xHz8rmQ3N2XqUxaeFFh0rwZVxlOk9nLkO50mfO/
         ZVikw6FFBMvyApugpQ292M6/3B1GHINMv+UaagnqMlihP7qf4vM9QDBATQ4Dh4rTU9SF
         aNXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzusncVZoySPCv2cAeOzEN5/ivZPiRHlNyM6slPXirJWgFZzmBkukFdQUiFAUXXmuZcA3cSX9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJulV9wOigAC3mUuvx9aU1XUWj4iUxzn29HYf5CqMpAfdImvzuJ
	N/C/X6hH/U9FzCAqf1iRURQh5oCpRnFvW5kq1SCZRUuIfPYI9hO2kXWq
X-Gm-Gg: AYBFou0QDDaivNP6aWlPCqRMvpmp33w5ugvYHmh7dtY9AtcXnZiAa4frZEV76AlRPYo
	qGbzmRebsQT2V9Ppd/j4sVXZa0WQCr0cl0pqVzOZxQDMljIzlcGcekaoukXShDuaz1OHaRiVh58
	bzcLnyTY28YbDo7KyRYegX9D8cioI7iASKeKBO97AQfDLr2CGsc08mYL4VvsZ6whMnoHBzovxJB
	BZnkNn+hTK0YTqrMrib9f4ZeLzY1kmk5ziiCKkKdLAjy9wUMOiTZ/zUG66kRx9V161oJSjBFWCD
	koEXHzzPnmOTFJxh8CEnEg0wQO7g7euVKBrcB8zUKqZf4iX82z78xQhwZXWpTy+Adyw8IVqY6ec
	gtFem4oNTXjbrcGWc/IApPKROAHwFds2v4bXBVOxa/Ns1vcuUkL39SfFb9v7KvDO0WfhO9Z8V+W
	ojWq8Dh/A96NqaVBWAdwZE6YD7GhAPl6i+wPfrgAIKeGXN+52ZgziQLRBFY8vcZKGI1t/GtkkYl
	UywEB73VBE8aiIhIVZato1E/1/slBQvADzFEhe8esdC+rtcdeXfuCKotj27tWheo8NyA+LEFUDG
	AeigBWXDjl6trkmzOYc/K8eFL/MeYQtIW1snwE6+gc5qaUET7hff8dHd8BZbFYiKjTFD
X-Received: by 2002:a05:6870:1415:b0:49e:f:1e42 with SMTP id 586e51a60fabf-4a8bb76a453mr1550624fac.60.1793186199604;
        Wed, 28 Oct 2026 04:16:39 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac4e4sm2003351fac.3.2026.10.28.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:16:38 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Wed, 28 Oct 2026 19:16:25 +0800
Message-ID: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

FDB entries backed by a nexthop group must not carry a remote
destination list.  vxlan_fdb_update_existing() currently appends a
remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
multicast or zero MAC even when the entry is backed by a nexthop,
breaking that invariant through three different callers:

- "bridge fdb append" with a dst on a nexthop entry;
- "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
- "bridge vni add" on a vnifilter device
  (vxlan_update_default_fdb_entry()); this includes a plain
  "bridge vni add vni N" without a group, which falls back to the
  device's default remote, and a unicast group.
All three reach the append block with nhid == 0 and a PERMANENT
state, so they pass the earlier nexthop checks.

There is no crash and no leak: the appended remote is freed with the
entry, and the transmit path ignores it (vxlan_xmit() follows the
nexthop whenever f->nh is set).  But the stray remote changes
deletion semantics: __vxlan_fdb_delete() destroys the whole fdb entry
when the matched remote is the only one on the list, so removing it
via "bridge fdb del ... dst <remote>" or "ip link set ... remote
0.0.0.0" tears down the nexthop entry, not just the stray remote.
The entry state is also misreported: vxlan_fdb_notify(), RTM_GETNEIGH
dumps and the switchdev FDB programming all prefer the remote list
over the nexthop, so user space sees the dead remote while the
datapath follows the nexthop group.

Reject the combination at the top of vxlan_fdb_update_existing(),
next to the existing nexthop guards, so a refused request has no side
effects.

Also move the non-unicast NLM_F_REPLACE rejection to the same place;
it previously returned -EOPNOTSUPP only after the entry state and
flags had been rewritten, skipping both the notification pass and
the err_notify rollback.

Note the resulting behavior change for the rtnetlink callers:
operations that previously succeeded while silently attaching a
remote to a nexthop entry now fail with extack
"Cannot add a remote to a nexthop fdb entry".

Add test cases to fib_nexthops.sh in the same fashion as the sibling
fix, commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that
reference a nexthop id").

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v5: no changes to this patch.

v4: Also move the non-unicast REPLACE rejection before the entry is
    modified (the same half-update class, pre-existing), describe the
    stray remote's effect on __vxlan_fdb_delete() instead of calling
    it "unused", and note that a plain "bridge vni add" or a unicast
    group hits the check too (sashiko review of v2).

v3: Describe the actual consequence and add fib_nexthops.sh test
    cases as requested by Ilya Maximets.

v2: Move the check before the entry state/flags update, next to the
    other nexthop guards (reported by sashiko, confirmed by Jakub).

 drivers/net/vxlan/vxlan_core.c              | 26 +++++++++++++--------------
 tools/testing/selftests/net/fib_nexthops.sh | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..13143085065f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1002,6 +1016,22 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    (flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot add a remote to a nexthop fdb entry");
+		return -EOPNOTSUPP;
+	}
+
+	if ((flags & NLM_F_REPLACE) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1018,22 +1048,18 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if ((flags & NLM_F_REPLACE)) {
-		/* Only change unicasts */
-		if (!(is_multicast_ether_addr(f->key.eth_addr) ||
-		      is_zero_ether_addr(f->key.eth_addr))) {
-			if (nhid) {
-				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-				if (rc < 0)
-					return rc;
-			} else {
-				rc = vxlan_fdb_replace(f, ip, port, vni,
-						       ifindex, &oldrd);
-			}
-			notify |= rc;
+		/* Only change unicasts; non-unicast replace is rejected
+		 * before any state is modified.
+		 */
+		if (nhid) {
+			rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+			if (rc < 0)
+				return rc;
 		} else {
-			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
-			return -EOPNOTSUPP;
+			rc = vxlan_fdb_replace(f, ip, port, vni,
+					       ifindex, &oldrd);
 		}
+		notify |= rc;
 	}
 	if ((flags & NLM_F_APPEND) &&
 	    (is_multicast_ether_addr(f->key.eth_addr) ||

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 431d7bed76224..bdc23205bde4c 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -547,6 +547,15 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
 	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
 
+	# fdb entries with a nexthop group cannot take a remote append
+	run_cmd "$BRIDGE fdb add 00:00:00:00:00:00 dev vx10 nhid 102 self static"
+	run_cmd "$BRIDGE fdb append 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self"
+	log_test $? 255 "Fdb append with nexthop group"
+
+	# fdb entries with a nexthop group cannot be replaced with a non-unicast MAC
+	run_cmd "$BRIDGE fdb replace 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self permanent"
+	log_test $? 255 "Fdb replace with nexthop group"
+
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
 
@@ -697,6 +706,15 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
 	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
 
+	# fdb entries with a nexthop group cannot take a remote append
+	run_cmd "$BRIDGE fdb add 00:00:00:00:00:00 dev vx10 nhid 102 self static"
+	run_cmd "$BRIDGE fdb append 00:00:00:00:00:00 dev vx10 dst 10.0.0.3 self"
+	log_test $? 255 "Fdb append with nexthop group"
+
+	# fdb entries with a nexthop group cannot be replaced with a non-unicast MAC
+	run_cmd "$BRIDGE fdb replace 00:00:00:00:00:00 dev vx10 dst 10.0.0.3 self permanent"
+	log_test $? 255 "Fdb replace with nexthop group"
+
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
-- 
2.43.7
