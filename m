Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77D36EAB0;
	Mon, 27 Jul 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166806; cv=none; b=jhXvkRJmAHF6sowDEaK/kVA9Y/dTp5jjC/9HpwTyDMfOzU5+693Mdpgk3eEBQ4SEkw9UmChKeVHCbaJW2PY0xB7wAGBrAt0AF6/GndAtgrX1eXCHyyvAfAkpa/NXvPKT/AnxvKv8NA13sRatuauoUk6G/PeaZqQwDHUytNlKuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166806; c=relaxed/simple;
	bh=KoT7ajjqQkXpZLIy0VM8V5uz0aZlQpONCtN4QvAA3Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCUWlfXK05PcW1emNjRel5fTWCRLrRF7BwQTMGG4rqEipLITPhN1+0iOsItoKBF7/e7UBaYBgPR6qt7+fAwh4PMEJgSRetFXDPHopPOhxlRS7sB67kdao+RkJNlMowJe2hOM84uNwJTlf777HSUY5RDFMX18oYNexRK1Zlly6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=qmvU5vf2; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="qmvU5vf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=XcVwp
	ENAv7+Zg+J4I6zEF5HvgZR1PRElQHKD0xb8tVY=; b=qmvU5vf2Y8tPAzTG7vk7x
	ZwUEQs1tlbY06JjK9ein8+EvWI61vZbKCtHTZ2Z0axUYZFCTR8R3tVP15+BmIJju
	CtQ55E9dqwW2yveRm/mDn/OpIWerS2tmaab2u4QNFCjQgZC0S12jAj79InkKVnFq
	VePEVnYkHtZwSZlYnMKVMs=
Received: from localhost.localdomain (unknown [121.225.135.236])
	by web3 (Coremail) with SMTP id ygQGZQA3BhXDe2dqDg1CAA--.29835S2;
	Mon, 27 Jul 2026 23:39:48 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] inet_diag: make bytecode audit O(n) to prevent CPU DoS
Date: Mon, 27 Jul 2026 23:39:35 +0800
Message-ID: <20260727153936.28944-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQA3BhXDe2dqDg1CAA--.29835S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kJr45XF1UKr13WrW5GFg_yoWxCrWDpF
	W5u3yjyrZ5tr9a9r10kFZruFW2k34qgFZFkrW3tw1fAwsrtr98tFn7KwnIq3Z3AFs3Kryx
	KayYvF43ur1UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUOq2MUUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgEBAWpnVKQqjwAAsb

inet_diag: make bytecode audit O(n) to prevent CPU DoS

inet_diag_bc_audit() validates the user-supplied INET_DIAG_REQ_BYTECODE
filter of a SOCK_DIAG dump request.  It runs synchronously in the sender's
sendmsg() at dump start, before any socket is iterated.

The audit's outer loop walks one opcode per iteration following the
yes-chain, and for every non-NOP opcode whose 'no' branch stays inside the
buffer it calls valid_cc(bytecode, bytecode_len, len - op->no).  valid_cc()
re-walks the bytecode from offset 0 following yes-jumps until it reaches
the target offset.  This is O(n) per opcode, nested inside the O(n) outer
loop, making the whole audit O(n^2) in the bytecode length.

NETLINK_SOCK_DIAG is reachable by unprivileged users (diag_nlsk is created
with NL_CFG_F_NONROOT_RECV, the SOCK_DIAG_BY_FAMILY dump path has no
capability gate, and netlink_sendmsg skips the NL_CFG_F_NONROOT_SEND check
when dst_portid == 0 && dst_group == 0).  The bytecode length is bounded
only by the u16 nla_len cap (~64 KB), so a local unprivileged attacker can
submit a ~64 KB bytecode of JMP ops {yes=4, no=4} that passes every
validation check, is accepted, and forces ~n^2/2 (~1.3e8) inner iterations
per request, pinning a CPU for hundreds of milliseconds; concurrent
requests pin all CPUs.  The burn happens at dump start, so it occurs even
when zero sockets match.

Replace the repeated from-start re-walk with a single-pass bitmap
reachability check that preserves the exact semantics of valid_cc().
Allocate one bit per 4-byte slot: when an opcode's 'no' branch targets an
offset strictly inside the buffer (op->no < len), set the bit for that
target; when the yes-chain later arrives at an offset, clear its bit
(proving it is a reachable opcode boundary).  After the walk, any bit still
set marks a 'no' target the yes-chain never lands on -- i.e. it points
mid-opcode or at an unreachable op -- which is exactly the condition
valid_cc() rejected, so the audit returns -EINVAL.  Each opcode now does
O(1) bitmap work, making the audit O(n).

The bitmap is freed through a single 'out' label, and the now unused
valid_cc() is removed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: Claude-Code:GLM-5.2
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa..304f031 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -11,6 +11,7 @@
 #include <linux/fcntl.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/time.h>
@@ -632,23 +633,6 @@ int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_diag_bc_sk);
 
-static int valid_cc(const void *bc, int len, int cc)
-{
-	while (len >= 0) {
-		const struct inet_diag_bc_op *op = bc;
-
-		if (cc > len)
-			return 0;
-		if (cc == len)
-			return 1;
-		if (op->yes < 4 || op->yes & 3)
-			return 0;
-		len -= op->yes;
-		bc  += op->yes;
-	}
-	return 0;
-}
-
 /* data is u32 ifindex */
 static bool valid_devcond(const struct inet_diag_bc_op *op, int len,
 			  int *min_len)
@@ -729,8 +713,9 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 			      const struct sk_buff *skb)
 {
 	const struct nlattr *attr = cb_data->inet_diag_nla_bc;
-	const void *bytecode, *bc;
-	int bytecode_len, len;
+	int bytecode_len, len, nbits, err = -EINVAL;
+	unsigned long *target;
+	const void *bc;
 	bool net_admin;
 
 	if (!attr)
@@ -739,23 +724,38 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 	if (nla_len(attr) < sizeof(struct inet_diag_bc_op))
 		return -EINVAL;
 
+	/* One bit per 4-byte slot tracks 'no'-branch targets that must be
+	 * reached along the yes-chain.
+	 */
+	nbits = DIV_ROUND_UP(nla_len(attr), 4);
+	target = bitmap_zalloc(nbits, GFP_KERNEL);
+	if (!target)
+		return -ENOMEM;
+
 	net_admin = netlink_net_capable(skb, CAP_NET_ADMIN);
-	bytecode = bc = nla_data(attr);
+	bc = nla_data(attr);
 	len = bytecode_len = nla_len(attr);
 
 	while (len > 0) {
 		int min_len = sizeof(struct inet_diag_bc_op);
 		const struct inet_diag_bc_op *op = bc;
+		int off = bytecode_len - len;
+
+		/* Reaching 'off' along the yes-chain proves it is a valid
+		 * opcode boundary, satisfying any earlier 'no' branch that
+		 * targeted it.
+		 */
+		__clear_bit(off / 4, target);
 
 		switch (op->code) {
 		case INET_DIAG_BC_S_COND:
 		case INET_DIAG_BC_D_COND:
 			if (!valid_hostcond(bc, len, &min_len))
-				return -EINVAL;
+				goto out;
 			break;
 		case INET_DIAG_BC_DEV_COND:
 			if (!valid_devcond(bc, len, &min_len))
-				return -EINVAL;
+				goto out;
 			break;
 		case INET_DIAG_BC_S_EQ:
 		case INET_DIAG_BC_S_GE:
@@ -764,19 +765,21 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 		case INET_DIAG_BC_D_GE:
 		case INET_DIAG_BC_D_LE:
 			if (!valid_port_comparison(bc, len, &min_len))
-				return -EINVAL;
+				goto out;
 			break;
 		case INET_DIAG_BC_MARK_COND:
-			if (!net_admin)
-				return -EPERM;
+			if (!net_admin) {
+				err = -EPERM;
+				goto out;
+			}
 			if (!valid_markcond(bc, len, &min_len))
-				return -EINVAL;
+				goto out;
 			cb_data->mark_needed = true;
 			break;
 #ifdef CONFIG_SOCK_CGROUP_DATA
 		case INET_DIAG_BC_CGROUP_COND:
 			if (!valid_cgroupcond(bc, len, &min_len))
-				return -EINVAL;
+				goto out;
 			cb_data->cgroup_needed = true;
 			break;
 #endif
@@ -787,23 +790,31 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 		case INET_DIAG_BC_NOP:
 			break;
 		default:
-			return -EINVAL;
+			goto out;
 		}
 
 		if (op->code != INET_DIAG_BC_NOP) {
 			if (op->no < min_len || op->no > len + 4 || op->no & 3)
-				return -EINVAL;
-			if (op->no < len &&
-			    !valid_cc(bytecode, bytecode_len, len - op->no))
-				return -EINVAL;
+				goto out;
+			/* Record the 'no'-branch target; it must be cleared
+			 * later when the yes-chain lands on it, otherwise the
+			 * target is not a reachable opcode boundary.
+			 */
+			if (op->no < len)
+				__set_bit((off + op->no) / 4, target);
 		}
 
 		if (op->yes < min_len || op->yes > len + 4 || op->yes & 3)
-			return -EINVAL;
+			goto out;
 		bc  += op->yes;
 		len -= op->yes;
 	}
-	return len == 0 ? 0 : -EINVAL;
+
+	if (len == 0 && bitmap_empty(target, nbits))
+		err = 0;
+out:
+	bitmap_free(target);
+	return err;
 }
 
 static int __inet_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,

--
2.47.3

