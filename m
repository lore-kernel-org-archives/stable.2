Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795351591;
	b=HS8Fy9qkWW2AzIrFOPjlccI/OYwpF9NCoR1lYUGaNXk4FEyYFulrGgia1MvwV8rlFBdr
	 GKvuj+Xbn2snSjFgy/0bPEv8fxOAw1VOJOHLBrsyJShzdHLyWJuw4BKLNFjiq2RDP76Su
	 q47fT4///zJR7xlBwfyXUifvdqGUw59yY/qc5/+i5o9GQ19EywkEWh0aYlNEIxA0+l+3u
	 jB2hPTnPXswtyGqb3Ez4zLC9o1QkR+35WXprGpnMV5cGVjCsQ62zE04JCQ+KT7nVevhZn
	 l6M+4G05RYVTmtNH+UCWPTJ+sfy4EsVyXB16F370sR4VOMTGoT5A2IQnwFytlKMCn3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351591;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uSIK8rb1SJ96UD11IGgozJgI4nPj/hEkxLsPjnR2aF4=;
	b=H9OfyHGRzxAfP7b2Ko4Mvcutvo3uPZ0H5pdupx7fEklTZN2M4yhKeaG2GinPHGTMizjk
	 LM+01aWa1T3LZIJo9yC+dlRzT8RbzUMafrI895VxKB1W4pyMkT9s/69Q7qPV7vfizqAd+
	 pIa4z/r+4VP02+Fvlv4O2uDANw3VhMZL0iziyaN9ReB0i6IUSNyglCDbd0nciVj12OWjj
	 90VXb/L/barwaj+Js7dDuwIc/qRGOi0MQR41lAtvAmwM7U3pNXjg3EExNLk4UW7hGE2VD
	 8mV+xQhLFEiws2ysf8I9kII+7kO1VSZ1GwT6SmLn43TPZDQVvR1fyNrGBsDN2CbYTgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sz/Qnfd6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2B606A320;
	Sun, 22 Nov 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sz/Qnfd6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795351590;
	b=0lR3hLRlpuIoduR2hAP143HDxVHETspc56dZ4xKFENHcPH7PKzpRlhHTZauIinmaTJXA
	 WMCMXj6dhv/2z0LruhIEMz87wxMt96n0Imm37VOpeD22D35Qhazt0TNIHyPw78eSJW0/A
	 tu/B1HTC4/IB2p2GZ8TG8DxCaV0j9Vq7+5yQcNpe4WBx8ctQewfGbmimsJSR1VABXeeqJ
	 /yXWTkVptEH/SkAOZi3Lr5uyntqnXdRs5FOEJQvwqlOom/n+OKH8M0sPr0P31LPS2XuBQ
	 LgIEGd2sWFrVmFQ+BIxJr6axNG8pvx9VveC30h+TMtymbLtfP70thoB3/ZKRkYiI3Ug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uSIK8rb1SJ96UD11IGgozJgI4nPj/hEkxLsPjnR2aF4=;
	b=E/Nx6ctj/891RikXH/mpNe2KG8EpEqSc5RXI/A24JT5gq/+9Ve3YQq45m9k4PQEjwepP
	 ggjxgZPNKX/dTsqNQnNqgefnkEel7A413wRpDO+GrzOVwxJ/Iq8S5H6aIh7Vuz80mcT/O
	 XzIDbLM5CRRkHK9d2mv/E9ivQNZ1mYGf/dz9HaAhtRYQKrtgCetj31+hIb3B9Mrj/b2VA
	 qChg62B1P9s0XpYA40Mt3Oumht9ZhvIPR+2x6ZFKdX7diRP+ukzM6+/gL4bvZT93gmZ9R
	 q6kw0ifdc3gyO9m4uwNuam53YmZjH28HM6hDFJnhZXWiPbcUZ4zx047oj2gOnNCMK6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 07DB61F000C0;
	Sun, 22 Nov 2026 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351590;
	bh=uSIK8rb1SJ96UD11IGgozJgI4nPj/hEkxLsPjnR2aF4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Sz/Qnfd6AzEU42DfkWtF+PGxiPqC8J+K8HSvZsm3UhmkX4KKfljIu5mF19QXvki1u
	 VVxuJRtSaWmfKHm4cnm8DyMlOvu+QYlOzIBXsiuYDrLiGlACnUaaouzCzqDV1pBYF2
	 SP+VOEQpLbgvSiRPU/sKyPN46Ng7UXUvxKZ4kPK6dAqACBDvKN0M5hX7SIW2kxYV/U
	 SdXA5NYA1WyLtmhn2V2b8p5mkSiko6yUNHCDzIGedYLgaCZ8ReDXYU8U0qGVsSc58+
	 GTRQEVNekm99O4FdvyCbFgCLdMAAYbo4w3+tjMYqdoOaTS02HQGZDdPCdrCj+1ERVu
	 JDTdcN5WrqyYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 60A204C041;
	Sun, 22 Nov 2026 12:46:26 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 20:45:52 +0800
Subject: [PATCH net v2] net/sched: act_ife: return -EAGAIN after dropping
 rtnl_lock in load_metaops_and_vet()
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
Message-Id: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me>
X-B4-Tracking: v=1; b=H4sIAP/jAmsC/yWNQQ4CIQxFr2K6thE6DYNexbgoUBRj0MBoNMa7O
 6PL9/Lz3xu6tqIddqs3NH2UXq51BlqvIJ6kHhVLmhnIkLOWCAOjIZQ4YcmKbaoXvEvGB6E1pEH
 Yebf1mLzd5lHiaIyD+ezWNJfnL7SHqhMc/rLfw1njtCSWWZCuGJrUeFpU04u8cJGbyGwN58ExJ
 RnJWMeGydGg7AfygxPNKXmFz+cL4NbH7NUAAAA=
X-Change-ID: 20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-d819f7ac7006
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795351585; l=3836;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=R6AZ0+3b44AwA7zPArm0D81n4+9WlR/R512inY1q7qw=;
 b=qsqZxqZfyp9Bt3IIxnnG4mcG2BZmBRa1SWt4lQo37rzuuRbhjD91d8zY5CWAGl8ou5LjCgfjV
 0EKLwwLidTZC/RL7clsgPR6PzyWU6WG6fyi2f0uUrytz4i0ZxVU42Qg
X-Developer-Key: i=fadouse@pm.me; a=ed25519;
 pk=b4DyzHJDRd8853IHUSKPA5wwzChj8eF4MTnZuyPz1PQ=
X-Endpoint-Received: by B4 Relay for fadouse@pm.me/b4-relay-20261122 with
 auth_id=1597
X-Original-From: YanXin Li <fadouse@pm.me>
Reply-To: fadouse@pm.me
Content-Transfer-Encoding: 7bit

From: YanXin Li <fadouse@pm.me>

load_metaops_and_vet() unlocks rtnl_lock() to invoke request_module()
when an IFE metadata provider module (such as act_meta_mark) is not
yet loaded, re-acquires rtnl_lock(), validates the metadata attribute,
and returns 0.

Returning 0 after dropping rtnl_lock() violates the serialization
contract of RTNL-locked classifiers (cls_basic, cls_flow, cls_fw,
cls_route, and cls_u32), which hold an unrefcounted filter pointer
(fold) across tcf_exts_validate() -> tcf_ife_init().  A concurrent
RTM_DELTFILTER can delete and RCU-free fold during the unlocked
request_module() window, after which basic_change() executes
list_replace_rcu(&fold->link, &fnew->link) and queues a second
deletion on the freed filter.  Generic KASAN reports:

  BUG: KASAN: slab-use-after-free in basic_change+0xf4c/0x1220
  Read of size 8 at addr ffff88800e043c58 by task test_act_ife_rt/101
  ...
  Allocated by task 101:
   basic_change+0x1e0/0x1220
  Freed by task 57:
   ...
  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]

Every other TC module autoloader that drops rtnl_lock() during filter
updates (tc_action_load_ops(), tcf_em_validate(), and em_text_change())
returns -EAGAIN so tc_new_tfilter() and tcf_action_add() unwind and
replay under a fresh RTNL critical section.

Manipulating TC filters requires CAP_NET_ADMIN in the target network
namespace, which is reachable by an unprivileged local user inside a
user and network namespace when CONFIG_USER_NS=y, CONFIG_MODULES=y,
CONFIG_NET_ACT_IFE is enabled, and an IFE metadata module is not yet
loaded.

When load_metaops_and_vet() drops rtnl_lock() and loads the requested
metadata module, drop the module reference and return -EAGAIN so the
caller replays the request with fresh lookups.  With this change, the
same concurrent RTM_NEWTFILTER and RTM_DELTFILTER sequence cleanly
loads act_meta_mark, replays without touching the deleted filter, and
completes with rc=0 and no KASAN or lockdep reports.  A finite
two-thread state-space interleaving model found the old use-after-free
and no use-after-free, double-free, or deadlock in its reachable states
after the change.

The vulnerable code is present in upstream mainline v7.4-rc3.
Runtime verification and fix validation were performed in an x86-64
QEMU/KVM guest running mainline after v7.4-rc3 with Generic KASAN,
UBSAN, and lockdep.

This issue was discovered through LLM-assisted code audit and manual
code inspection of net/sched/act_ife.c.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
Changes in v2:
- Resend via b4 because the archived v1 email has a corrupted diff and
  cannot be applied.
- State how the issue was discovered and clarify the finite model scope.
- Link to v1: https://lore.kernel.org/r/20261122030728.9368-1-fadouse@pm.me
---
 net/sched/act_ife.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 5a527da0056..5d6ca124e00 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -275,6 +275,14 @@ static int load_metaops_and_vet(u32 metaid, void *val, int len, bool rtnl_held)
 		if (rtnl_held)
 			rtnl_lock();
 		ops = find_ife_oplist(metaid);
+		if (ops && rtnl_held) {
+			/* We dropped the RTNL mutex in order to perform the
+			 * module load. Tell the caller to replay the request
+			 * under a fresh RTNL critical section.
+			 */
+			module_put(ops->owner);
+			return -EAGAIN;
+		}
 #endif
 	}
 

---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-d819f7ac7006

Best regards,
--  
YanXin Li <fadouse@pm.me>


