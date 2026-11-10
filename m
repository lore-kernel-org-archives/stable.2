Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272489;
	b=Ki0AWS0g14UFXV3x9b49/Vtp+T6lF+JFdo0KE5Homm+086F4lXzmxaD0R10CbeXcUR/H
	 vRtAm8F+chTwaYkEoigH4iLUnC/Sx9tsyIE5QGa7b/qXbQDwsCN2D3f+18noKyyddOtMp
	 eoPywbkGnnVyhW8Zf9g9XoEqp141BLRNTvvaIH7dE7pfgSkLqboCrGZAs06LlbrmjYadC
	 3QzAOKMTpTmyEoePHPHYlQSjENEAlsvfNQDwbRhfJ/RwY//48Fg/MTI73/H2Fandd/Cf/
	 Urzpp6h60NqGDQv3h1bCvnHj2GVUHOUuitZB84+5Sdw86zMBgdzln56P5thTlV7AWhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e3Fffb9jKYpbVFU7VEPtn3ir9n/iN4tgqg//F91oDbk=;
	b=veP0B+rzWHdD85pSaAO/UvZNGTP1LbbcqlwjVHp8HCxKrLQBOyBQ3D7n+x2qHRANEOu9
	 EfcO9fexkvUlW4wKuvCI3EfINWtHT7sPxlgFldg8VeAoDPrqoZqRr8Qa5vKkbJp4bX9Gx
	 Q+g/JPknZgULfOtLnkhQT0RJdWIQTbh30noYtrSV7gmVRN4kBND5+h5om5zj4yWemyh1j
	 wOkESUzwKxXqMe+idH7jwuUs6al50FDoTnXH4X13kCO1AUKjfcBgF4b2aIVFh999u8IPR
	 U7ErAbp/uLv4B0qUNoCcBAyjdhJbC8hWkffj1jSt80LgrmClujfNnvZDSslO1jTTPhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OB40yIM7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF19606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OB40yIM7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFD21F0089F;
	Tue, 10 Nov 2026 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272489;
	bh=e3Fffb9jKYpbVFU7VEPtn3ir9n/iN4tgqg//F91oDbk=;
	h=From:To:Cc:Subject:Date;
	b=OB40yIM7R5L652JUomK6ijGZZWisrGc4ymkRd9GK+z28yMsXxBWuuQdOrxIqWc0gk
	 +kKpCHrCLPSHzom5JxoP/uGJEyRcFCERgacGMLzCFvRjB9+0TCZ0NavSBMIfOwLxED
	 uf7Tx6MrF4Nu3j0FD7nZii1SuOAQgqu4gMrxA1wsIqeMAb6Wvvu3FWyKRPKBitzoDs
	 WaDVOmRdt65Qtb6gFzpiIkiX6XOtcpsZMS8ChN5+wPwyLwiBLmzftzIjvB7dyGjITV
	 flse+avDj2UrHvHe6Ap7yFaFMeH2kseR0GDNGelIp0fHm+KOBYF6JERbUXAs4gDQPL
	 vV0aCuBE7MP1Q==
From: Sasha Levin <sashal@kernel.org>
To: idosch@nvidia.com,
	sf@techfak.net,
	razor@blackwall.org,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:27 -0500
Message-ID: <20261109200127-failed-7.3-7308ef8b4a67@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 7308ef8b4a6779a39f68d053c19b53a5c584a663
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200127-failed-7.3-7308ef8b4a67@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7308ef8b4a6779a39f68d053c19b53a5c584a663 Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Fri, 30 Oct 2026 15:37:50 +0200
Subject: [PATCH] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID

Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
nexthop id") started rejecting FDB entries that point to FDB nexthops
unless they are configured as "permanent" or "static". The intent was to
prevent such entries from being aged out by vxlan_cleanup(), which runs
without RTNL and can therefore race with other VXLAN devices that modify
the same per-nexthop FDB list.

However, FRR installs remote MACs that are behind a multihomed Ethernet
Segment (EVPN-MH) as dynamic FDB entries that point to an FDB nexthop
group. Since the above commit, these entries are rejected and traffic
towards the corresponding MACs is flooded to all the remote VTEPs.

These entries are also marked as externally learned ("extern_learn")
and are therefore skipped by vxlan_cleanup(), but exempting externally
learned entries from the checks is not enough: vxlan_cleanup() reads
the state and flags of an entry without the hash lock, so an entry that
is concurrently changed from dynamic and externally learned to static
can still be aged out.

Instead, remove the checks added by the above commit and make
vxlan_cleanup() skip FDB entries that point to FDB nexthops. Such
entries can only be configured from user space, cannot be learned and
cannot roam, so there is no reason to age them out. The nexthop pointer
of an FDB entry is set before the entry is linked and is only cleared
after it was unlinked and an RCU grace period has passed, so it can be
checked without the hash lock.

Adjust the test cases added by the above commit and add a test case
that checks that dynamic FDB entries that point to FDB nexthops are not
aged out. Without the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 Tests passed:  44
 Tests failed:   6
 Tests skipped:  0

With the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 Tests passed:  50
 Tests failed:   0
 Tests skipped:  0

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Fixes: 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a nexthop id")
Cc: stable@vger.kernel.org
Reported-by: Sascha Frey <sf@techfak.net>
Closes: https://lore.kernel.org/netdev/20261028142928.GA8406@techfak.de/
Tested-by: Sascha Frey <sf@techfak.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20261030133750.28668-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++------
 tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2235390997786..d11028b374721 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1005,12 +1005,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
-	if (rcu_access_pointer(f->nh) &&
-	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
-		return -EOPNOTSUPP;
-	}
-
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1274,11 +1268,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	cfg = rtnl_dereference(vxlan->cfg);
 	if (cfg->remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
@@ -2947,6 +2936,9 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
+		if (rcu_access_pointer(f->nh))
+			continue;
+
 		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 431d7bed76224..adbec51917eb8 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -425,6 +425,14 @@ stop_ip_monitor()
 	return $rc
 }
 
+fdb_entry_aged()
+{
+	local mac=$1
+	local dev=$2
+
+	! $BRIDGE fdb get to $mac dev $dev self &> /dev/null
+}
+
 check_nexthop_fdb_support()
 {
 	$IP nexthop help 2>&1 | grep -q fdb
@@ -538,14 +546,18 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 2001:db8:91::11 self dynamic"
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
@@ -688,14 +700,18 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 10.0.0.3 self dynamic"
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
-- 
2.53.0




