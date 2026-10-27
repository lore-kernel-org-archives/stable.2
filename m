Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098050;
	b=UiDh5bt+okSeUkReTcFDS/pgPt1eWGR5wV3xxRt8tICY+9ib/jfM2UB64MmxvRRxzsel
	 9t6GJrSuKDcet/HZCnc3mZ/xdlfl1zW9wuoK5ymb+XvLY5cQPZx1sjlFp2LsQqjwyFOHO
	 uFB5D6YJZ2EF7O5AZQly/wbD8+DAN8z3Ks5PiKJpKvb3W/l5mzRMDKeQdtvhZrnF9HKzh
	 nWduJj2qwsUtVYogq/xSGUaIFgN3ocNUkDOu5ig8II22yGmZ6OGiZc5yxOXFD31kUTQnn
	 CjpfqB2DgKlco1gU0pBuyaZbt2+T/sFsG5OoXuxy2A9emNJ/0XxM27EAfYCFwTOd5hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
	b=p+Si9dyOUyBMDd0fG72GktusmstzMdzpnMGZaRk+FvhYzcnLa17kK+uQM5FgvOADjpMN
	 gObqWA7K0gHyH81pQtAT87OK6Y96BuhINezUf8tj7DCWxjPuyvCcXifFlwknmlPz1M+Nn
	 PYNx6ynjO+ohlGCuTfmBtpWE+A90kQa2LRtF9uA6e61+aWPrDmwcLRSmaL79SqTEKkTBA
	 L9x/36VaMY06fc5yQncnb2NnYj8yP6aXmhAttUoN42BXDG8+tSBX4Nkl1NX6q9nFirvSy
	 Vix4FUZYKPistnavq+yfm1yWq5CIVz8S4kjKYlB3FAKfBufJDuvKQ+R2bX4RnY28SlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQKmLPZJ;
	arc=none smtp.remote-ip=74.125.231.64
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781FF606A323
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 781FF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQKmLPZJ
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so826889fac.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098048; x=1793702848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
        b=MQKmLPZJuqcgyjnXyDxD/97XlTCvnNhUq2zFaKUbbWiYi5z8O2IpZhAHn1GVymp1kQ
         j7DW2bgalslQl2+/IGXCfHhSmtQVVPaA6O70ssIj7KARyNJBZbsgHbCx4Shs4gu3brlc
         t67KQMtNaVjBi1eL7CetaAX/3mubCTVDxvLcqwpKpczazzxFIBYEMWlCPoQAhTBbIKC8
         DbqYiw8tnf+mQQxH1FH4ktcyxqC5N72wt8W+RfCxikmlQIOW4pq1QhGK3kZg2FueRDbY
         /GM7m1trkNTyAzWVJAHYIzdstugpuQx7HBV5fuBZCkIVzQGbdIV/rpykyrYbNK5QmXkK
         NZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098048; x=1793702848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
        b=JtJtAw8BosHj7f94F2Q+6GHr/h2h6hEyfyufQsZ+Jp3X5YS/2ZytHo4Hd8bbfWSqUE
         slFZOVoPi4RawK9a+qL+z1A9StK/zQ6VdJzsk+QqmKuMY/RwKfFWSn7pg5JiKz3VttxC
         cCPxRRkv4GYkFWRIZiBm2DoUW/XQliVhie4U+aN5FihBNTPeohg89ARik51k2o32QnyN
         mOtj9DejJo4y0Cl9fuRkNHm1wDvm6jYt73BlMdg9v/9yhfdId8XV6StvoWk94GDN80Cf
         i7KmbqVIiLWNmy9qs80ijuITLj47fSYU8WOGm6QbMGOpHnvRlTowpxGXuyigplucUYF/
         yL4g==
X-Forwarded-Encrypted: i=1; AKwUvByhyJ/r2alNQH6yoZS9FNVzvAjcT0Tad15veFkJaNyTP/Al3jFWgWlQFpaOPwvIFhpsk2uNzhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0N6mbtqBnFlX7+rPAFP6pXsbaKws0skiYfVtrdEjN5JTCSp75
	rlpwp9y505Tb7mKqN0LXV16c0kUOtViGCEu9XSq/vIH6jdZyvZjP+9VM
X-Gm-Gg: AYBFou0x41+8F1uNcqK/bi1qG5ve9sElcgcKj9vNSFJri7K/etaEFwawa10ZDDvqG1H
	UOd5+2ZRMe8VYkal5ovZ4ei7tdoDg0G6TeS+O9eFR1dRuKW3Pqd4Z5va+BH6nup4OB9cDhOw7Wk
	XeS1KM0e0e4oAUbTy2FADkIRWcw1eU0CVQ6Wgv7o7A9Rmn0NTpPLf0z+YQdpLxcy1UZ9o3QwEGp
	UZ+2DmeJ/nTw6wiiU+J1CQBJzWI+ipXXHjVDgmDZmC1Px4qSQf3tvheNQ5deIdwayVoSk3cFNru
	v256wkGWjHx1SkapWKEY9NFGJ5utGsjTFRvliYXAYsKXteKs0uFK/X8JI4DiycGq8qcOqQvJGgH
	FyDfnnflUJoofPvwO+Ej3Uoj9svMYV61Pwfnax5FDFYm3aRei8YSnBIDH2QTF8WLzfOB8HO7Za8
	q6SfE0sgup0KgRWecVGTkH3ww5rBXGseUlmacdxbnaWSBwHAgnzrZ9bcEIwzG2MLGw7xr2E+Rku
	Vrc+K5ckdrnI8qX8u+j8LVhBI0NBGolHHivi/lxeYGlOhnpTMwJLOHBRatDNsYrytTTcEwZWeCB
	5V31VGlfj5G3S8qoQBhpHkExdwNNBBFJNY1DeseDxAK3lQgCCnuXUqTQUE2vMd+JE93TyQ==
X-Received: by 2002:a05:6870:658a:b0:4a7:df5e:d6ee with SMTP id 586e51a60fabf-4a83f53b9aemr5207325fac.45.1793098048302;
        Tue, 27 Oct 2026 03:47:28 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89b77sm6597299fac.2.2026.10.27.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:47:26 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Tue, 27 Oct 2026 18:47:12 +0800
Message-ID: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
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
