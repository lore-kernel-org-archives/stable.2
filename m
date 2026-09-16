Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967A4E66CE
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602141; cv=none; b=mGVYZvRgY/D8ddQ9M0pmvmhAF5ZoP8GSEEtmxCGjexexY3xDTSBrjb1g/aeyV5yyQShJMvbPo32O6bkoIcPJOjGD0Xnp66zEpJYcS0EBwRBPph6YMaA49NaWJfruh7y797Vu1GnKINm9pqx/+YRh23hMpC6iX6giUtp6Qebu/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602141; c=relaxed/simple;
	bh=PT1L1r4Ij4RYTf0s44lRTEuG8azTmzAER5kPfI/Z22E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT6zsUqA6hDf/Raho3O9oecLFdybzAH+vLgu/VZvxg5SlBLvzhSbUr6qcAmxKSf7KN/OOlj/7u7zCjfjJPW+jRUNOM5JnCFZK06L9PjWT1EkrdoiIbowbZ7JXuyoTPCsoUybZpw0Zg2sjrYZOoOGRDjELWJIHO24NUvKyMweJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKJWwYFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKJWwYFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7621F00893;
	Wed, 16 Sep 2026 23:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602138;
	bh=rkhswP0gplLmYZTHMffooCA2bJmmaHbSAJXe8DkTPYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKJWwYFn5PBtC+UDv+GRtQfq3U6qj/V74w8Rs/phCIdlKOduP7vbypiEI22zVjJrQ
	 IiU61qs/B6DVf4KmCTbMUSC7YdxZdV6n7vIw7zQOFG4gUUx8bSk0Zjw2QGD+MgYqrb
	 /RHyADU3No1/U6xGmnH4AQjg2ATQLUgJ9WhhbtmHvQgmNHK722o5H52MzTwvihdr/d
	 DryJqYUDs36bQfUitoGV98XKegDP2w4PHsjHf7xQGSwvYshjEeAhlUzjCAUvb4wo5c
	 z1a7VGMEZu1I8A6FkGwT0ZqGh+ODJIMaszr/lgivZEd34EuVQ8+kOvIEMTE1UkFrxg
	 23mJpl0UHDC4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] netfilter: cttimeout: prevent UAF during module unload
Date: Wed, 16 Sep 2026 19:42:15 -0400
Message-ID: <20260916234215.3296425-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916234215.3296425-1-sashal@kernel.org>
References: <2026091639-unmade-pouch-5365@gregkh>
 <20260916234215.3296425-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit fec9b1de0d02de8dafa3cc344bcb91cf28660643 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_cttimeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index c87335d78dfa0..564e4642467dc 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -654,9 +654,9 @@ static void __exit cttimeout_exit(void)
 {
 	nfnetlink_subsys_unregister(&cttimeout_subsys);
 
-	unregister_pernet_subsys(&cttimeout_ops);
 	RCU_INIT_POINTER(nf_ct_timeout_hook, NULL);
 	synchronize_net();
+	unregister_pernet_subsys(&cttimeout_ops);
 }
 
 module_init(cttimeout_init);
-- 
2.53.0

