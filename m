Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AE40DB4A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573574; cv=none; b=uFtmwAQHjAWVQOQG/l9GYRXS0ZQbHHIsxDhP+RmOTp6uu+tB6u/mcem4BK+haAER8PQ96etUfVUcOUTAKoSMOY3ttzQ7qSDxs0MVdr0ZlGLNYtw3JU+9dClIcCx0wEEHAel6z6pMfUKclhi+Iug99YUVMHYLgWJPMamYQ7f4S2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573574; c=relaxed/simple;
	bh=qTuo0XGpd3/TJoBr7VlydNUS5gAgjPvXjtLTX//eAj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1CCQMaF9ksWdl3iFyXff433eN5eGVHCzLJBkZOMRv+zbhG7bLVXGfJ738V27GoofYUT8a5PvzvzbwqVvzLBNwrRkj1mxePa1Mvmk3qdJUMubGU5CkYEo9dKuW7iwa4Zj/jMDrBtQWQ716jHks+zYE8Klh95SHCFMCGd+APB8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNKg45UB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNKg45UB"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe4592c193so287389a12.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787573572; x=1788178372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0ppQhbiQcCeg1OqwKrv6XM0T1yzd97yREoqT41AZzU=;
        b=dNKg45UBwquvACLINh3/RMXrzf4oSej41PPI3JJj5vaZgrYeloEC/zX6biqvwbfN4V
         /35WCX8AuyFZGh4Dj0Qd7Zzx5ljA5HrUAzSax5pQMj4Zo9FGaiQcPAAZgQWhYl7iuoGZ
         /YLcSLe+VuZ82vJGSI3aMV0OGGYXAMMigDmoTlTLVBD7Ej1TIuPLPy5YXELoxte4YqjC
         m1tJjYcoIb1PHwr17zYtqPiQGA2fGCE1pJrO2ks9WZ4lrX9IWD+GbDKM/J2GpuRy94bY
         p5smS55RvvU647vD3qoOQqLl7nCTbhtoZyHs4MQVq1pcNiimRYUPytvt2ztg9m6tsz0g
         OUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787573572; x=1788178372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0ppQhbiQcCeg1OqwKrv6XM0T1yzd97yREoqT41AZzU=;
        b=Wf747gc5n21Gw2HuuT6p+szTHS6GnwbWVH4b/GlYPlLc7QWNmdtc85cV57ug8I1Rkh
         ScoQsurqomNzKT+lk4JbcCkA37nVplUFxsV63mGgZPLnYzNSqMONsS4JDPW/XPUXg0Y+
         2Us8kndC5xQpQjKkOLZ9dqZeHslzlEXav/X4/qfIEJHB9MniWUfXYUFgDbdtM3q4R2bK
         XzFYZwHDt4dXBxH7d9oDpvAMqxqz+zXQdBdiab0WcRuSB5CZsClX3yzmXcrpb1EJVmkg
         cG3kiwsl41GA5wnqW+JG11nVzfUQ66qlnyIw65mryrfHt1THDEBwspJu/zOMoT72uFj/
         33Yg==
X-Forwarded-Encrypted: i=1; AHgh+Rpx4MsuOhbN/BbzdDiRg/WGxTGlev535Yweh6FXi1NiGPURCkB/UG+XsdL+xgZxsZBoBgQU9Ig=@vger.kernel.org
X-Gm-Message-State: AFuF++knbDGOzbTeepg8AVD3lf0g/fRh8ao59Y6qDyItXwaqwxOIQ0BQ
	EnEP83HNXrxPk1HJ48E1jwyGYak6jq7PsIA6Bc8Ykep0hC/HeFvZmLsh
X-Gm-Gg: AR+sD10DkmADu1eEi1pDMR4s1zbiBzOYrge+W5E+JEXxkwfYpjiwGm69ba/l/qV5mbM
	WCKXL4zQam9D6Xba+Tq7oGtZvqvy9WMbMLMXJrP4Ezgynv3NuMSLgDrXZcd+trlNSXakJCOoGy4
	FCOdDRKFOj8JW100FvDfOZywJYdi1/FUQ25m0EXYX+SUIJuNt6AiE+qw9bX2ub8LJGbu7ttjANs
	Zqu1B2GvgrRpYI3HYhGNLfHP7emh0lE7Aevit30Rx3HiLkIAHxK51J3uN2waxABbE9tGNppxDXx
	eTSOsYFwiE37bCt3lU9bzrPeNWATGvH2K6jmnJbGt2Nu5eR6gsA4uJ64RfUFJElRN1+3U7w389P
	29CmGTQ446NqluEltFrX2fBGF8dM6GVwMt9p0akubNwXteue0x9r4OeIkYRDBEL5OYcwY8UjyAU
	78WafPcHIAUbgJAYGtdhuQ4lQK4YYSiJqAV0oYHlHj/7XS8hKJFVr6HcY4UlXG77dkrzuta7WMo
	bz9YH31fo+gkUVcjtvu7V3jH09gi9tCBJzEEKDCgiDQA5Oob1Nfp2A=
X-Received: by 2002:a17:903:3b84:b0:2cc:f4d4:29a0 with SMTP id d9443c01a7336-2d64b0a908emr230320855ad.3.1787573571971;
        Mon, 24 Aug 2026 05:12:51 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280d116cb1sm16516298eec.10.2026.08.24.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:12:51 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netfilter: cttimeout: prevent UAF during module unload
Date: Mon, 24 Aug 2026 20:12:38 +0800
Message-ID: <20260824121238.205812-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/netfilter/nfnetlink_cttimeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0

