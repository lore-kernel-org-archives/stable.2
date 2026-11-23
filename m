Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440723;
	b=QRRemA5aEaJWoe2QIrcnHBsgzx8PfV0E4BCEy2d304K5VuOFfFAXPFUHPsQ7WpKE4YPT
	 +Kb0a2T+v3u1Rs21Jh2LH/ln4lV8DqG0UiVLEnUGGB4V373LR6IKhj2s5hy5MXTz811MA
	 24o7uR6KLBKtSxiIQ/JIqPPy7F66U6/ddPNYfLPocqrtvqBW1kKz85K8Je1kT5s5mGSpk
	 Wv9oYycFlG3hCsiJtc8f0HBC5VcsIJoBvrWux5ajEAbFdwpyIGADLcHO4WyB2zxXIuUIh
	 NSn/SdTwcgd5SAzpDQWPbe/AJRef8j/b7wHPAXjhsJ61k3x7wIlwymkIK8ooiEtTP3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440723;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g1CW7c3pTtOr8mmmjYe30pIrbe4DRRxUC8YCS/6YhX8=;
	b=fTYO1keQs5xFAexItTgdh2SyU8zMAAzQs3tdB/XZvXBR4AheS7hUb3o4pzsPbzlooWn7
	 /TAfNCjzqpNk+D+EfrPPthsEC8ugdlYGFJL+xWWEqfGKVdj+wCZHhjU0qf6RiiDBUo4SM
	 /8XpsJzzhjPNWjrWK77TE5ezZtR+8Px1vcJcR1/UBgkjAqFIvAVhO4waQZlSnzaUcVgNT
	 Hk2PIPZjWRRAVBa0E309La5qFZgh44Ike8La3QnbXSu5mYX18Ye6wLwIfOayW9zZN4Xcd
	 GszOCgd14B3UrU1EI6Z6QRNSkEzgP1ORQfJmOb8TQv45l9lhDBdfjekoo6tppvN6DNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEdirOts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA6606A31A;
	Mon, 23 Nov 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEdirOts
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440721;
	b=cIbLgxa87NkmEWFtvh1RYYIkV8zCaDO3tf35up4bhRwowsDtv/mhnjDL1qKmfEovFIcD
	 sN5v24Ka0ZyQsstw+w4bCrXeaaGzBP0sFywD0vZl+Cd1wh12CDJgJ6RyQuoHRwiw5G8Y9
	 dGCscMx3DH5IZ6wYwnb4rfM8wvf08uN6YEnNxOinPcYNCTuNtpC6x3QTsqOqAY6S/wFmT
	 cgCgxDY4+d4XWyZrZSuG97zqVJ0gIXUods5wyczjB5GAXI9ZWb1ZeDCo5kPaIYmFKnw89
	 3znnBTH76ATt5CvAqQHrt5EmO8qlQHGCVtU7AnokMpH49uOH2lTVyX8BjFcuyokskmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440721;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g1CW7c3pTtOr8mmmjYe30pIrbe4DRRxUC8YCS/6YhX8=;
	b=adT1xPcSo4ASx3Rt28rtTyiMgplvkuB37+IwHQ3Sq1ix+i8/u3x+MVtrRx2b+PrYE4aL
	 Kv8zCGSj+GA0gwRHMeU+VPnqpX//GfP1BYu0Zc0BGqLb6BnJK8gbaAuY10+k8uubi1hr/
	 mkD6IP/xDU6lMdraRZsIL9LRx9o7bPht5W5HUzje7ZMUUXj8taKv4gc0jjbAmel9kCioo
	 zUOQh2ZfmSJpk0hQZMTOd5HSKtz071RA2KCnSb6ZDiGU4ruxMd6KH8fz+Bg/4LRK3ht6z
	 KPCRP7vJP4MBbwuozPc0mUnguwoAPTZaxmJB3JlkNoB88a03uOIQyO+DkQpbI451jjA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4A32F1F000F0;
	Mon, 23 Nov 2026 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440721;
	bh=g1CW7c3pTtOr8mmmjYe30pIrbe4DRRxUC8YCS/6YhX8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lEdirOtsvCvnMJPG2B5gMKMUuROpavmQ5irWgY3/20XIAAlu/Ix+gKGFHTx+HFem9
	 wgVNaYGqt9ggglTcNUDjEzbamzEGwrT7pGv9uBDefL0U1dTlU/zmeLmZ3F2GnqPeSY
	 ci9byydjfN3n21AUBI2jBUSVbUZOucjpoFoyCoHRfaEOFBfOPjsCsJUnVVVq8l47FY
	 yaxn3b9OZBfp+UkptXYUrcRA86/A4xkwk76hFVcZSNCkaRNgdZH7fcMm0vxTvYbpLT
	 A/PGP8h7XK59W4rXgdEBm63GOtXW2+ULvNQc6kJZJMcYh9tJxxiCurIyDhg29o/qb0
	 kAhjElLqwF/bQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A3A9F4C490;
	Mon, 23 Nov 2026 13:31:46 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Mon, 23 Nov 2026 21:31:27 +0800
Subject: [PATCH net v3] net/sched: act_ife: return -EAGAIN after dropping
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
Message-Id: <20261123-b4-02-act-ife-rtnl-uaf-v3-3e43796c4fc1-v3-1-93fa0f782cf4@pm.me>
X-B4-Tracking: v=1; b=H4sIAC5ABGsC/yWNQQ4CIRAEv2Lm7EQYRkS/YjywMCjGoIHVaDb7d
 1k9dqW7a4ImNUuDw2qCKq/c8r30YNYrCBdfzoI59gykyGpNBgdGRejDiDkJ1rHc8OkTvgwaYbP
 b28ApaHTbPhBxcU8R+tmjSsrvn+gIRUY4/WF7DlcJ46JYaoNvgkP1JVwWVOXmP7jATWDWipOxT
 NHvSGnLislStzpDzlgvKUYnMM9fUwmc+dUAAAA=
X-Change-ID: 20261123-b4-02-act-ife-rtnl-uaf-v3-3e43796c4fc1-85026ee8d92d
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440705; l=4563;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=7DHuyrQLhOeh9C5+PXyUekYvXmy1gMXBow6B9d9EIpY=;
 b=1ARe0+Az5wJGRagyMXgOjGKai5/2m6h4b0FcYuzsb5AL2bAT0wVmNFWD69XnvNlEasGTz2Q9R
 WtpyrwXlWr2AbLDbshhL8ae16cOQ5oZEzijJhcxv7WbtP2mqpFp+3vy
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

Returning 0 after dropping rtnl_lock() breaks the RTNL serialization
relied on by filter-replacement paths in classifiers such as cls_basic,
cls_flow, cls_fw, cls_route, and cls_u32 (the existing-filter branch
in u32_change()), which hold an unrefcounted filter pointer across
tcf_exts_validate() -> tcf_ife_init().  In cls_basic, a concurrent
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

Other TC module autoloaders that drop rtnl_lock() during filter
updates (tc_action_load_ops(), tcf_em_validate(), and em_text_change())
return -EAGAIN so tc_new_tfilter() and tcf_action_add() unwind and
replay under a fresh RTNL critical section.  (In cls_u32's new-key
path, the error unwind in u32_change() still accesses an unpinned
non-root hash table in idr_remove(&ht->handle_idr, handle); that is a
separate pre-existing cls_u32 issue also reachable via
tc_action_load_ops() and is not fixed here.)

Manipulating TC filters requires CAP_NET_ADMIN in the target network
namespace, which is reachable by an unprivileged local user inside a
user and network namespace when CONFIG_USER_NS=y, CONFIG_MODULES=y,
CONFIG_NET_ACT_IFE is enabled, and an IFE metadata module is not yet
loaded.

When load_metaops_and_vet() drops rtnl_lock() and loads the requested
metadata module, drop the module reference and return -EAGAIN so the
caller unwinds instead of continuing on the success path with stale
pointers.  With this change, the same concurrent RTM_NEWTFILTER and
RTM_DELTFILTER sequence on cls_basic cleanly loads act_meta_mark,
replays without touching the deleted filter, and completes with rc=0
and no KASAN or lockdep reports.  A finite two-thread state-space
interleaving model of the cls_basic filter-replacement scenario found
the old use-after-free and no use-after-free, double-free, or deadlock
in its reachable states after the change.

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
Changes in v3:
- Remove the comment from the module-load retry path (Stephen Hemminger).
- Clarify the scope in the commit message: note that cls_u32's new-key
  error-unwind access to an unpinned non-root hash table in u32_change()
  is a separate pre-existing cls_u32 issue also reachable via
  tc_action_load_ops() and not fixed by this act_ife change.
- Link to v2: https://lore.kernel.org/r/20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me

Changes in v2:
- Resend via b4 because the archived v1 email has a corrupted diff and
  cannot be applied.
- State how the issue was discovered and clarify the finite model scope.
- Link to v1: https://lore.kernel.org/r/20261122030728.9368-1-fadouse@pm.me
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 5a527da0056..68a111c7f86 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -275,6 +275,10 @@ static int load_metaops_and_vet(u32 metaid, void *val, int len, bool rtnl_held)
 		if (rtnl_held)
 			rtnl_lock();
 		ops = find_ife_oplist(metaid);
+		if (ops && rtnl_held) {
+			module_put(ops->owner);
+			return -EAGAIN;
+		}
 #endif
 	}
 

---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261123-b4-02-act-ife-rtnl-uaf-v3-3e43796c4fc1-85026ee8d92d

Best regards,
--  
YanXin Li <fadouse@pm.me>


