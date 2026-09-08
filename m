Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424C560AC2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884463; cv=none; b=W2kkDKHuPxZmrLCntBfVwfEAtk3v+xYjOI8WGSZgFP3lDL2xsmh6qRwIXi1JwlV8FTFS46Q0+4eadCcXsr424y9MdPWETNQXIjpJ9CYhE9xHVOPquFUFA1l9hYx0FEbtsznR7Pbkw1su5mU1+vFcpqU6bmot8fQXmW0khreFOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884463; c=relaxed/simple;
	bh=v4hhMnVLcFZeBPcSLNn7XM2v/il/STVD/bok+kbRENY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V030dIy2TM297eLCUoTsdXdeLS1FqP6DeJwFzU+l9Ngp/Dk1wWbrlj82Wr9N6OiXaGjmL3nfoIG7kbYPKW1C3VUJxVQHPCam//2I7uX6CczAwTpKsdGdJSHNtEsxGMFQbV3vyfaHWav73J1Mqec5v8YI6wc+axD2JH8x74Saiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLtm+9Hg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLtm+9Hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5838B1F00A3D;
	Tue,  8 Sep 2026 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884461;
	bh=IOFK4LKTW2lmNj32xGmNZoLTnlkFRY5iJpIzaUiE7zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLtm+9HgkI1XFSYZvVCtOJwVTJ9BIWjPPeexUD/1AbRvh8F/C622svxctmnqObgdq
	 khkxBW5YVZvj0JxR/HYWtGrrWeelHZgVP2KWxsQRScZcHlObcVGebUvMF4bw+29W6P
	 jdB/KY+hSWfXbX93055sD2KVmk41fPHhxqBCwcvwz74vfIqjQb6ky0wsse7qrKrbgp
	 RDIRUgLGkV37E2WRYsrKlMQTCHL+UJgDZkikvNCytvzXAE15ipl931Nb33fx593Ojc
	 0+IHXzEz7c79dO3NhB35ZgmgeLdJa5516OyLoxa6Nc1RLI1uyoeu9apnHXKFEVmYQw
	 zsbJeRS4Js87Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ipv6: annotate data-races around devconf->rpl_seg_enabled
Date: Tue,  8 Sep 2026 12:20:58 -0400
Message-ID: <20260908162059.2629725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-gone-tricky-59ac@gregkh>
References: <2026090349-gone-tricky-59ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 3a5f55500f3e93cf4d62351c753452279b088b4b ]

devconf->rpl_seg_enabled can be changed concurrently from
/proc/sys/net/ipv6/conf, annotate lockless reads on it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Link: https://patch.msgid.link/20250901123726.1972881-2-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index e91afe5ec0b5d..e1e64e5507d22 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -504,10 +504,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
-	if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
-		accept_rpl_seg = idev->cnf.rpl_seg_enabled;
-
+	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
+			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
 		return -1;
-- 
2.53.0

