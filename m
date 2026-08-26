Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1933F5B3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730016; cv=none; b=WnzNBHD44xFpyU5GSNrAaM1X/Bv5kj1UdbV/JXlJiybLsdkpRbDlSQJzYbAfixckr/aV4hlfNglOResVXiWJuefQyRszDD3YnOMvirWwKdQsdGGdVSuXz24ftkJAvSRBk1GDVHWwkvZo2yuV9BeKX/72P00ulArjHb0rmmrYE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730016; c=relaxed/simple;
	bh=88cwRlOGDn0vpOQmUYNZUGYEdRzAeKkeMTlTyzUNsZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X4A85+/RWSAlIZLP218ykHH7zMXo/Y0UVlcDDR8TrZpWkll9nTRApvK6eGCwdCH2KiqERIStWdpw+083se3H2YN7Gsofco+7p2JHyyxWyyY96C1b3Mpx63e5zHR9JhbJqp8zrj4cYrBUZQRdg8nc+EZA7db9b5UhToIme0UmeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR3GfUMH; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR3GfUMH"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so799361e87.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787730012; x=1788334812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ltu0ibAXLu3xOE6Vns9ZIohMj7npj3m+gIbL5j+64fw=;
        b=lR3GfUMHUmaUlA024lzXfq9TKi2qmcxBQVnxshr6ucju3nbRwo7EGg689Fkxrw1zGJ
         cCMyOQvjOWRVhOAhb2IlPMVm9VkeGeOd6BBbGZ0IY5gaXq4IVBZYAN4VO23BEexNee9p
         9u8cfW9BPySrlMXpxcyZbjUQfjDyEpc7a9z/gpZdsD8mQgepoinH8yq3KCzxuDmnnbZT
         /qnvPY+3iMwvWGlR2U6KQzcBRTdESJ3lUHwt/BS6PIpkD4zvZBxqu8ja5TQguaKkGMPl
         KfERXEoORel/q57PJ9Vy+sbLqqpuB3h3BllYLsejEbLOfghqUUIx1fmdh61BR/uGeoiY
         QPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730012; x=1788334812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ltu0ibAXLu3xOE6Vns9ZIohMj7npj3m+gIbL5j+64fw=;
        b=BMn2QWduX2EEBsmoyKg7eNWkX6+n3gspMwA3uncG21D4mf4EuzH6o/al6TmhZsJhZX
         w8DOAtWNSMCTXkSoTy3yqBNlnUB75uyNaWP/DLyQmlLIpbxwEJ3uQS0YtBGrLJKJgkPo
         EAUlja1Vvyk3s0LJFQWQKKUvo8NeOMQuOuoWdVdgZbjBpDjEerzBsMev2e8SjtUg1ftz
         q+PJntfg+M2DD+phq67w+jWxSHkB7HgZ5tlvDb3GJkcgB7PgUA8c5FJ55QHuUJj4dupO
         X2kwwxRypAnuMSNW+ob7Vo729PfrGESnpUkMNRK+hF6qE4is5d7qfN3q31G5+/MMjp4y
         06qg==
X-Gm-Message-State: AFuF++mwt1fZsFdmyaOLRLgwAF6ivMPGojmTrFLLz3VmRlFn/AOydvCp
	esvshGVS5si28tY1eCiYvjz8HTJwt7BZhYOGKf4jlF8RkBvc6HbnPUYNx5FFWMhQ
X-Gm-Gg: AR+sD12ag+HAJGhdiz2vkWmuPzQXHnFMES8nyMjrX6Hy7lD3JqznPydfwpB4/2YJSne
	r0knhBYNRL3zZhjuk2rOM3Ynn7tUPv2F4gotFCqCowTtm+94kqoFhZaN76veCHO3RZG1LMCmLdN
	/KVT2wM9vgD+N2IaSAOgSciBybhbCYll6KXoj/PhKDTUujoDbxOZffTg5V8310yY7GT2zj1Sp8U
	CmSZeD9AdAOq46UnDYNGqiG7/1TWQZL3p3rV7w6ZFKth3pLhrWy0j0YKI3dGUiw33p2TbbQesOo
	/igyAvkXeXVX8pb5dm6qivyo65TUzYk+/VyIYS67EW5bB4mi/eeNQr8AbEsB9QxcG7O0ttRZt2A
	z6VBN4EbONksxQuZBgc6hKu0H/wJ0z0jf1YjVbPDq4QOC6JwlIKEsaAOTc3BtnHZJjDPt8c+53n
	1N2+EHfAVY20/9KU+GLZe+yqY6Ad+2So12O1JmPv+F+WBr+kNwciDJhG859pyonBEUVLoxR0MT+
	Is1qg==
X-Received: by 2002:a05:6512:3b8a:b0:5b1:4c14:9b3d with SMTP id 2adb3069b0e04-5b49c79e872mr2903961e87.11.1787730012058;
        Wed, 26 Aug 2026 00:40:12 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4a41c240asm401260e87.83.2026.08.26.00.40.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:40:11 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10] ipv6: mcast: Fix use-after-free when processing MLD queries
Date: Wed, 26 Aug 2026 10:40:07 +0300
Message-ID: <20260826074010.9256-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40 upstream.

When processing an MLD query, a pointer to the multicast group address
is retrieved when initially parsing the packet. This pointer is later
dereferenced without being reloaded despite the fact that the skb header
might have been reallocated following the pskb_may_pull() calls, leading
to a use-after-free [1].

Fix by copying the multicast group address when the packet is initially
parsed.

[1]
BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118

Workqueue: mld mld_query_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_address_description.constprop.0 (mm/kasan/report.c:378)
print_report (mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__mld_query_work (net/ipv6/mcast.c:1512)
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

[...]

Freed by task 118:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
pskb_expand_head (net/core/skbuff.c:2335)
__pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
__mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
Reported-by: Leo Lin <leo@depthfirst.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260603101811.612594-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53275

 net/ipv6/mcast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index e15c3e2318d7..c4a9866ea45b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1414,9 +1414,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1448,8 +1448,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1501,7 +1501,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
-- 
2.53.0

