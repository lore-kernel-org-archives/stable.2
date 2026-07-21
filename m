Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E4445AE4;
	Tue, 21 Jul 2026 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672120; cv=none; b=QZxqn+gZByCikME9ikseI8xYPbXtTIMJaPIDqRHkCDKlOSkKnKepO5wB2Tj5KqT0UWvAZorfEKOvf/zTIkiIKBJy6FqTeGfY89epDvGJlagXGUjSz28tl58O22gkKGqr471dXkURsOg0CQnvSDWKb1GA43UmyRN0wPZwcUR5HxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672120; c=relaxed/simple;
	bh=tSKdsuqUcnutK73kjhNzdNGzUK+YT2RybfzYqFoiXRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nE5ICDOPugV8OdEjPNuqD2CN/MTDvXPnsrg/PjszOc49zGy6KUBJbtvrin0SOYzcgO07hqWD4zEBk3VD2Q9WqdAxuSC68ZLXeYKGwTmIpnOcdjdtpxnlbCjgnLi27f4znkWJCHmza/ow+LsOO1pAzLk5j6FkEWdei4SoVYzCLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu3RwrtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu3RwrtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C582B1F00A3D;
	Tue, 21 Jul 2026 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672119;
	bh=eDNl95CZQ/T901YSIPfRI4wV+4KqYKa1GvmpSJZDq10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fu3RwrtDdBp7DxmxD3qqiqk3jcIcnK6yNdKYxLVVrPMUIF2eMb/4kZpQvjOKugO2m
	 BqQjrOTa3bfRLFj/kQFHFkGc7D5d1wwzZzd6QJk42aZyLBsXiCXhrshFRVD5Xq5Rg7
	 pgNBDRvVr1ZWVRC9WxqpiS8Z7RrAbjxITjRqIvKaAbcKvkKTlVkBko5JTCROa/desn
	 XiGWEvtel96JpZQeXsM0lw35DD3Qg5vm8Hw6XPrT1HCTXNTUpxwvgIqrB5xnwoYBGz
	 /dRH6qOwNOo+q936hjSl2jnfTnuMdWWkEQPUBUSpptyDi2FJOr0dXm8W2HYhr/bBeo
	 NccHvd8eas9bw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:14:42 +0200
Subject: [PATCH net 5/5] mptcp: fix BUILD_BUG_ON on legacy ARM config
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-5-6fb595bc86ef@kernel.org>
References: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Frank Ranner <frank.ranner@intel.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tSKdsuqUcnutK73kjhNzdNGzUK+YT2RybfzYqFoiXRE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi36dV2+zMla1sWiTPtfNaWMOE+ijGS75RczsetVTdK
 a1OZbDrKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEhwAcP/DKYniqrsF6r8pps2
 LV2+/2f/tfU3uYVc8uITtrRma5S8YGR4ONdz06y1hzae3/ezxsrW3OY6851XT5cy3doU/a+Ci0W
 aGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 0-day bot managed to find kernel configs that cause build failures,
e.g. when using the StrongARM SA1100 target (ARMv4).

On such legacy ARM architecture, all structures are apparently aligned
to 32 bits, causing build issue here. Indeed, on such architecture,
'flags' size is not equivalent to sizeof(u16) as expected, but to
sizeof(u32).

Instead, use memset(). It was not used before to ensure a simple clear
operation was used by the compiler. But at the end, it shouldn't matter,
and the compiler should optimise this to the same operation with or
without memset() when -O above 0 is used. So let's switch to memset() to
fix this issue, and reduce this complexity.

Fixes: 5e939544f9d2 ("mptcp: fix uninit-value in mptcp_established_options")
Cc: stable@vger.kernel.org
Suggested-by: Frank Ranner <frank.ranner@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607031100.upQfRZTM-lkp@intel.com/
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1b74ca5b6a59..c664023d37ba 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -571,10 +571,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 
 	/* Zero `use_ack` and `use_map` flags with one shot. */
-	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
-	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
-				 sizeof(u16)));
-	*(u16 *)&opts->ext_copy.flags = 0;
+	memset(&opts->ext_copy.flags, 0, sizeof(opts->ext_copy.flags));
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 

-- 
2.53.0

