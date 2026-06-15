Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2250277C9D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495384; cv=none; b=GJwTuVXqIulUGFBaszEMG92hgu4xQ3xr0kKm1VXIdrtu8AMJ11NT8TlEyYASvZ0BB7XRdOspNLd5gwYpX9/36cyDpoeYF+hcCjj78tyKm4QpYWcZH+/jCc2m8jlDEtUDCCYkIwtv+unCjZQ34ASr9Ke2kReNF28MDGIv9Y+xFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495384; c=relaxed/simple;
	bh=11hkXIyRRMMprH9fmgza8wrpiMU6A4BMS8/sVPKzxr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bzp9ENiTn+fKJhCx1xcg5063XE4djh5xNI9+2VXnDQhCmFwkOWJ8C86hRqL3p3Hp34kxGAloFLBtaGpOVPb5YOqCq/Cs/kMJaTBitWM/Ir3dCbhCIeVKZ6nboO2tWtd/IYpGVWYH8CHjwH4LvtQLz+PRlTdTHMTaFe144F4yYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QnkU6fN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QnkU6fN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D411F00A3D;
	Mon, 15 Jun 2026 03:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495382;
	bh=K/g74MzK/iYHi05IFWPT7f3BTbfj23X7o9GVDzemcF0=;
	h=Subject:To:Cc:From:Date;
	b=QnkU6fN35wOEFGx66VzgpIU+2Hc70NwkUIFdqDdYsWiZNpS3gzYhWvnMPUoXWnOat
	 r9uGS7Qw1XCXSj5lAHql67DJuILavLh/uEGiSNBVd3FbnkSYXfitm4fFOtQYLYPTdk
	 aKCODsoi8JoC64iBGrdJci2hGrpNaBbpykbVxC2o=
Subject: FAILED: patch "[PATCH] netfilter: nft_fib: fix stale stack leak via the OIFNAME" failed to apply to 7.0-stable tree
To: d.ornaghi97@gmail.com,fw@strlen.de,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:48:40 +0200
Message-ID: <2026061540-whomever-shading-96d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x ab185e0c4fb82dfba6fb86f8271e06f931d9c64c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061540-whomever-shading-96d4@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab185e0c4fb82dfba6fb86f8271e06f931d9c64c Mon Sep 17 00:00:00 2001
From: Davide Ornaghi <d.ornaghi97@gmail.com>
Date: Wed, 10 Jun 2026 12:39:12 +0200
Subject: [PATCH] netfilter: nft_fib: fix stale stack leak via the OIFNAME
 register

For NFT_FIB_RESULT_OIFNAME the destination register is declared with
len = IFNAMSIZ (four 32-bit registers), but on the lookup-fail,
RTN_LOCAL and oif-mismatch paths nft_fib{4,6}_eval() only writes one
register via "*dest = 0". The remaining three registers are left as
whatever was on the stack in nft_do_chain()'s struct nft_regs, and a
downstream expression that loads the register span can leak that
uninitialised kernel stack to userspace.

The NFTA_FIB_F_PRESENT existence check has the same shape: it is only
meaningful for NFT_FIB_RESULT_OIF, yet it was accepted for any result type
while the eval stores a single byte via nft_reg_store8(), leaving the rest
of the declared span stale.

Fix both:

 - replace the bare "*dest = 0" in the eval with nft_fib_store_result(),
   which strscpy_pad()s the whole IFNAMSIZ for OIFNAME (and is already
   used on the other early-return path), and

 - restrict NFTA_FIB_F_PRESENT to NFT_FIB_RESULT_OIF and declare its
   destination as a single u8, so the marked span matches the one byte
   the eval writes.

Fixes: f6d0cbcf09c5 ("netfilter: nf_tables: add fib expression")
Suggested-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 9d0c6d75109b..177d738825b4 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -128,7 +128,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 2dbe44715df3..b9ad7cac1417 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -239,7 +239,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	ret = nft_fib6_lookup(nft_net(pkt), &fl6, &res, lookup_flags);
 	if (ret || res.fib6_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		return;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 327a5f33659c..a1632e308f18 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -107,6 +107,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
+	if (priv->flags & NFTA_FIB_F_PRESENT) {
+		if (priv->result != NFT_FIB_RESULT_OIF)
+			return -EINVAL;
+		len = sizeof(u8);
+	}
+
 	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
 				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)

