Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934941835E;
	Wed,  7 Oct 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404014; cv=none; b=EoTGcUQNmdHNvqQhAaUlcrH8XGmXYxQj4Z8sm5bWoaSeWkF7cpv9YNGp4kC61gJUbk+x+P4hd3NCcIuaucUnP5GMcKkZeCYC5K6q6VZap6ZRbyPKmA6FYEbj4KtueB6cbmIG3YkUy9te9f4o+itFM9ILYkIB1U0Hdl3jTexER6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404014; c=relaxed/simple;
	bh=MoRtXwbri/P/3kAqWKsbaW8ChXgK31gjKvSMDnMvVHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1Ac/Mn6iMZ5GLLL6UofJopBDmkUcko/ySQoSeo/oFoymLR2jBh0/DJKKc0xBwIJR5KZ65W5toe9GbELcSnS5uhcayTSKMtRdcIQnvxsKyq2RhWqHV3yvHbGq863bh3Yu7XflPqHmL3+pSZTRlw5b4ZswC5CAHiKQmfX7AM/hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=V1M89s1a; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="V1M89s1a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=FoiOz8VHkvrdgUjKnshb5SbCQF0eAf8lvHBIs172X4I=; b=V1M89s1aZmI1HmY3Io7NFr7klm
	jt2JjYMK9JESdJrHUcdqlWuD7Ag38MqwRl3y21rY3exeIkFzrSs3+lkfDJZ5vQ+v34PrZnUN7UGqr
	PtWnv8mlINOdCsAJoX4340rsvrcpDq6NFpjlPjSuJtmJyjc5bt36QhD7l62+VjyVLXw6CnjNIu2UP
	P3uoouAd52nc1Tn4ldKxgrBYjKtHl+1BFl99ik68Xh5s0RupWF/ndYJyr9e/ZIeLfytj/M1/820nN
	79JRBmS8OhNdnh/DBomeECnV/suCxLzREYzY2f17Q9IwTqm1EcPQW2sG1DqEZf21RvSCdhC/FtcWw
	tD3O7b3A==;
Received: from [151.115.150.205] (port=33532 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xEY17-0000000HNc0-0ViY;
	Wed, 07 Oct 2026 22:13:30 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] mpls: unregister sysctls before network device teardown
Date: Wed,  7 Oct 2026 20:12:37 +0000
Message-ID: <20261007201237.171863-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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

On network namespace exit, loopback is freed before MPLS unregisters its
sysctls. A task can keep platform_labels open and write to it during exit.
The handler can then use the freed loopback device.

Unregister the sysctls in pre_exit.

Fixes: 7720c01f3f59 ("mpls: Add a sysctl to control the size of the mpls label table")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/mpls/af_mpls.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 17b78dc..ad4ad6f 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2776,16 +2776,20 @@ static __net_init int mpls_net_init(struct net *net)
 	return 0;
 }
 
-static __net_exit void mpls_net_exit(struct net *net)
+static __net_exit void mpls_net_pre_exit(struct net *net)
 {
-	struct mpls_route __rcu **platform_label;
-	size_t platform_labels;
 	const struct ctl_table *table;
-	unsigned int index;
 
 	table = net->mpls.ctl->ctl_table_arg;
 	unregister_net_sysctl_table(net->mpls.ctl);
 	kfree(table);
+}
+
+static __net_exit void mpls_net_exit(struct net *net)
+{
+	struct mpls_route __rcu **platform_label;
+	size_t platform_labels;
+	unsigned int index;
 
 	/* An rcu grace period has passed since there was a device in
 	 * the network namespace (and thus the last in flight packet)
@@ -2816,6 +2820,7 @@ static __net_exit void mpls_net_exit(struct net *net)
 
 static struct pernet_operations mpls_net_ops = {
 	.init = mpls_net_init,
+	.pre_exit = mpls_net_pre_exit,
 	.exit = mpls_net_exit,
 };
 
-- 
2.47.3

