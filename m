Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220834AB3B4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573290; cv=none; b=kogKT0E+Kp/6xAlIhbrOuzAN4fLIXMYNy4eaRQeWzyenuowrkpWtQw5BaKkU1JjB+3TezZeekvRxU11hRTlXCV/epy3TY7kPEFx0jm1FQkTxMcLeQta9q8NZyrXnBU6bPSIUc7LR8JdjFSHa5JazbhtDxtKzUpHuAdtvBE2ieTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573290; c=relaxed/simple;
	bh=9QfqPfeEYMoHmaD1Tha/FPvZd5k5+dhkVUYxSCm7eUk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kLrEe3wTO40fJ3jJaPwJwr8mm4tdPgUDtmgRIogAfFQjj7rrHfNNRz0cJcX+zTQxl+T8zkic3HZwrbS/sY8tMfkmxxhCly1AhEFGi0EffGeXzIJi4X+JkqtmG4Z9wyXPu94D9NWc1FpC3DSB5fzlNoldhXLBhtlZB3YY3O5BaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m060ZFqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m060ZFqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8011F000FF;
	Wed, 16 Sep 2026 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573288;
	bh=Etflt438Mk8x8MiGZc1uk40Wfc/sYS/k4k7GH2LZzRE=;
	h=Subject:To:Cc:From:Date;
	b=m060ZFqqwa2zkZZmsaXy86r1V4jsp7VFdZZadxJ5EbbkWIscWzgiSCFCBSkxdUQRZ
	 dHhp3is7eDwlwNLAkzQzXRiI7FMbsDcWl+rFu1aGFUI3PmsZbmJBvxIVpuK7ejqlF6
	 qDP55A8TUy8lMy2L/a5k4ONFT4MLuoa3dSO+yFRw=
Subject: FAILED: patch "[PATCH] netfilter: cttimeout: prevent UAF during module unload" failed to apply to 6.6-stable tree
To: nicoyip.dev@gmail.com,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:32:43 +0100
Message-ID: <2026091643-moodiness-multiple-38a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fec9b1de0d02de8dafa3cc344bcb91cf28660643
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091643-moodiness-multiple-38a7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fec9b1de0d02de8dafa3cc344bcb91cf28660643 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 20:12:38 +0800
Subject: [PATCH] netfilter: cttimeout: prevent UAF during module unload

nf_ct_set_timeout() protects the timeout hook dereference and policy lookup
with rcu_read_lock(). cttimeout_exit(), however, unregisters the per-net
operations before it clears the hook.

This allows the following interleaving:

  CPU 0                              CPU 1
  cttimeout_exit()                   nf_ct_set_timeout()
    unregister_pernet_subsys()         rcu_read_lock()
      kfree(pernet)                     h = nf_ct_timeout_hook
                                        h->timeout_find_get()
                                          nfct_timeout_pernet()

The hook still points to ctnl_timeout_find_get() when CPU 1 looks up the
already freed per-net timeout list. KASAN reported:

  BUG: KASAN: slab-use-after-free in ctnl_timeout_find_get
  Read of size 8 by task poc/90
  Call Trace:
   ctnl_timeout_find_get+0x271/0x2a0 [nfnetlink_cttimeout]
   nf_ct_set_timeout+0x7b/0x3c0
   xt_ct_tg_check+0x724/0xb20
   xt_check_target+0x234/0xa90
   do_ipt_set_ctl+0x570/0x1270
  Allocated by task 89:
   __kmalloc_noprof+0x16e/0x460
   ops_init+0x6d/0x420
   register_pernet_operations+0x2f6/0x670
  Freed by task 91:
   kfree+0x131/0x390
   ops_undo_list+0x3d4/0x730
   unregister_pernet_operations+0x232/0x490
   unregister_pernet_subsys+0x1c/0x30
   cttimeout_exit+0x52/0x970 [nfnetlink_cttimeout]

Clear the hook and wait for existing readers before unregistering the
per-net operations. This blocks new policy lookups and ensures readers that
observed the hook finish before the per-net storage is freed.

Fixes: ebfbe67568a7 ("netfilter: cttimeout: use net_generic infra")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 66c2016f6049..132c02ac7c4e 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -652,9 +652,9 @@ static void __exit cttimeout_exit(void)
 {
 	nfnetlink_subsys_unregister(&cttimeout_subsys);
 
-	unregister_pernet_subsys(&cttimeout_ops);
 	RCU_INIT_POINTER(nf_ct_timeout_hook, NULL);
 	synchronize_net();
+	unregister_pernet_subsys(&cttimeout_ops);
 }
 
 module_init(cttimeout_init);

