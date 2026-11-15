Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716789;
	b=hgj2NJyM9wGBAgLjkkzLQtzfqWh25jRZXbLasWvtEpOYEeeB2yvG2wW5D+fIDbqxNaO8
	 9KpLEoNbD3R3wq86AP3rarQ5h0Zx8QlU7rFarlTAW7HSCKjm2U7wjVz/5iww0oF9UUx6d
	 4r4X1c0qoqhvbf8sMTRWVoQkIPy0ouXTpQbxE3dMhts1k/V17ZSrEqnzUvHnMwpgh7WVB
	 vhjd/1nbEnCtwaUYc24/MGL4lnec1ZVu+KRjOqMdei9t903EZ49aeoruLQZiBaczh8bPv
	 +glJd3N9Cs47FHxoOi+FAoBkzOgVktvhLaIA0cWwX9//nCkqghirrG1YuXA1kBpgHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716789;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PE1T7Z5KhZcynu05MtgfaEQGAVsUUdvQevTG2LkwgU0=;
	b=mCQUbcdYoc5+PlwkqsnUk6MOUrPVxsknybIIeDnR9a4UEmEypDl1q85109KeOQdcJDHJ
	 1vQRvDgy/Q/guS9cw5vkpEMPrbq63Z4gIyiOQ6Ji5HTTUqP9L9/Plggq8nIQhbxG9vxG6
	 fZx2g9ZcAIPVte7F14zx9fCd+RooyRLtkG64wgQ43HKzkis8Q1M1/BD339O2L8c0/YSXE
	 9cTer6qT2CZpepRtAhIZO+wcgsLoABqRhdDexdeCz89WyvEoMM55CRydVBH4mJITodulF
	 20JtDCIuCjQDwbT3iiBf+faiIAaIVMNKd/P7CasWzGdjWWdjjttFZNmBfm30RUZPr3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHTzTboY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A22606A329;
	Sun, 15 Nov 2026 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHTzTboY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E6A1F000C4;
	Sun, 15 Nov 2026 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794716788;
	bh=PE1T7Z5KhZcynu05MtgfaEQGAVsUUdvQevTG2LkwgU0=;
	h=From:Date:Subject:To:Cc;
	b=UHTzTboYfT+0FUVWPaFs3CBRV+60pYByu+ICQjNjd+D7cj8oqYHlFSDzCIYxt0JNq
	 /sKSyzVY2GG6qn8sx0VsjDExZopjVM0aJdTTttw3HtdPbrBDDPeDPJpwfpLWn504DA
	 YBxKFuK6PHNN47p36qcuqX8YRIW0iqlSeSdw+rcqB+BF35WzdbkpmzJAhY5HUnG9kh
	 XnuLdDyCFuqsLqB5h/r/XGVI5Wp4jHWCaGq8Qutac9MQuvU+3HqGYTCVJI5hd8j4a+
	 EvRCfCG6RFo18kXmgMt9DqAhSIwdZxa3If7ZvaGIGnvxW1NR0nGRNCkIDHkXo8eQDa
	 N4EKxB47qLcPg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:26:10 -0700
Subject: [PATCH] rcu/nocb: Avoid unsequenced accesses to jiffies in
 show_rcu_nocb_state()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-rcu-tree_nocb-wunsequenced-v1-1-057996a86f0e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCQAwF0KuUrA00Q6niVUTEZn51XKSa6ahQe
 ndHXb7NWyjDEzLtm4Ucz5TTZBWyaUivZ7uAU6ym0IZeRDp2LTw7cLJJB34Vy3gUmCJyG6JIv93
 p2AWqwd0xpvcvPxz/zmW4QefvSOv6AZK2dnp+AAAA
X-Change-ID: 20261114-rcu-tree_nocb-wunsequenced-02d11678cf42
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <jfern@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=nathan@kernel.org;
 h=from:subject:message-id; bh=7OmRRHFXh1lWL/xG22s5IPrApVcaF15LGgvPQEIuTBU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/TfJa94gduDl1nayy18pNik8mzyt6rRV6UOhs33zx/
 N5//7K9O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEZk9m+B+TEWwlbPRcWjV7
 /Zy++fGLzR+K/Hh7NXLJx3vnTfcz1Kxh+O9Zsbzs2rywDrEyd7NJTzZleiql6KUyH3594q1/+3H
 jZj4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in show_rcu_nocb_state(),
which can break the build with CONFIG_WERROR=y / W=e:

  In file included from kernel/rcu/tree.c:5123:
  kernel/rcu/tree_nocb.h:1651:3: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
   1650 |                 jiffies - rdp->nocb_bypass_first,
        |                 ~~~~~~~
   1651 |                 jiffies - rdp->nocb_nobypass_last,
        |                 ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

Add a local variable to hold the value of jiffies before the function
call so that there are no unsequenced side effects, clearing up the
warning.

Cc: stable@vger.kernel.org
Fixes: f7a81b12d6af ("rcu/nocb: Print no-CBs diagnostics when rcutorture writer unduly delayed")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2192
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/rcu/tree_nocb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b6cfee4e5039..8448a7c578e8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1618,6 +1618,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
 	bool wassleep;
+	unsigned long j;
 
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
@@ -1639,6 +1640,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		rsclp->gp_seq[RCU_NEXT_READY_TAIL].exp);
 	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
 	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	j = jiffies;
 	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
@@ -1647,8 +1649,8 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
 		"sS"[!!rdp->nocb_cb_sleep],
 		".W"[swait_active(&rdp->nocb_cb_wq)],
-		jiffies - rdp->nocb_bypass_first,
-		jiffies - rdp->nocb_nobypass_last,
+		j - rdp->nocb_bypass_first,
+		j - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
 		rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ? "" : bufd,

---
base-commit: 18b332441bbf59fa537929fe390238e137a6caff
change-id: 20261114-rcu-tree_nocb-wunsequenced-02d11678cf42

Best regards,
--  
Cheers,
Nathan

