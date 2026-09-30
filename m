Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1150129F;
	Wed, 30 Sep 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779608; cv=none; b=caxDaI0YdyWFgOIF2UWjyKvfGJZ0RGDalNZ+BfE0AY6AIN0On5hFLTQgWRvRYicVANEfFPF8kN4wfnKGMXwxPEr1ev1iFiZv2jhlOKI+FQ3QC70gXyzc5lIcCtzKFA6DTJTqFT6hO60w0zRfZZFcrHBKR3OaffTHPStUvrk82kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779608; c=relaxed/simple;
	bh=FDgM7Dxi7gSAkWXa+H3oOhI6dJR/gHP4kyJsqmyOs+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4L0glNaepBnBakhYn6VIiFZX769/2Ay/giGe2oQjUg9T+Ll7Q8cHHF5pMiwnkNv44hvg052keDJvANd5Ew+ZtuXqCYZySxyB6ToD/45zA1g7Ik3SlaljR1jqai0XOWJhqZYhdZ1VVGikJQGp7q3qOPaQOOMi2VRhHv2HM4txiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=cST+C6ZG; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="cST+C6ZG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ChLmrLBujeNUTqt0qI7MPDUXAjIlECRrqpUYlCGDb84=; b=cST+C6ZGQhk6uiFI0jLVMozFK1
	d7MIyOjkjhFH9ze+S0S+0M6UZX2BC+7QdFR21NBC6INA5MvWlqe8g3l3eoTHJkpAjW5hXFNgLFQaL
	e6fVE4hn5Xsqig/nrING7MV0AUwfjFvKdnpsHF5XOvNicoz5ra/cM9wJnaoCdZJgVlnL7B/E5jAyH
	Cprm0P29b1E7S5+YJ9h0tmF1tyPoG/Vo85dffZFpCAmid5BWcTFMYgMVmECOSMcKQINV5kjDdoD9m
	L9budtDF/WsBviKpbHZOqLd9iFRodqnr6lipfpBqcq7tuZCkFTu+njsSCqz73Z5VbzRaFlrkC4sYg
	Q2csWimQ==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZs-00000005QLT-1olB;
	Wed, 30 Sep 2026 16:46:34 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early GSO
Date: Wed, 30 Sep 2026 14:45:21 +0000
Message-ID: <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

In the software ESP offload path, xfrm_output_gso() leaves its segments
sharing a secpath extension. Each segment gets its own ESP sequence
number, but stores it in the same xo->seq field for IV generation.

If encryption is delayed, later segments overwrite the value needed by
earlier ones: esp*_xmit() can then encrypt several packets with the same
AES-GCM nonce, despite their distinct ESP sequence numbers.

Give each segment a private secpath before allocating its sequence
number.

Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is set in xfrm_output")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_output.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e305ba32e356..f6644daa68ba 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -672,6 +672,13 @@ static int xfrm_output_gso(struct net *net, struct sock *sk, struct sk_buff *skb
 	skb_list_walk_safe(segs, segs, nskb) {
 		int err;
 
+		/* Each segment reserves its own sequence number below. */
+		if (xfrm_offload(segs) && !secpath_set(segs)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb_list(segs);
+			return -ENOMEM;
+		}
+
 		skb_mark_not_on_list(segs);
 		err = xfrm_output2(net, sk, segs);
 
-- 
2.47.3

