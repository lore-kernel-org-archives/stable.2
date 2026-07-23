Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AA474269
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825868; cv=none; b=NDeLZ1KvnNMzbbvovII37gdSOtkTdcH1r4xfCbbPFw3L6QOhccxUNdL/z71LZh3Mw2Y4zkhSz+gyjSjyz9m5ooDxfwX71lveZPowyRo89tTHqV0o3+Z4I/E9/rmYMYKLxrckVek++UEMvAYMkgdMVWh3bmde+d0HBmYHUhIyKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825868; c=relaxed/simple;
	bh=j4nsl7WsayKg60RfMkaiMOiYgEkPvZjP+CwOAaA5BEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMffZJuWWFVuWr6tlUgzF5hitaUL4vxrpM5C9CMG6s1C3kPsbIyw0FotUYHTnsbnG66DAIS1HZeUrx9zuLVdfk4N/pPlJN1eAGpKg31XQOavtpU+PR07u1WUrh/JwkKop5wLBsFEnWTV0Mzce/+oIVOSp93XYMNGl+USaRUxqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI8YYoiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI8YYoiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DC21F000E9;
	Thu, 23 Jul 2026 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825867;
	bh=0oPjhgG57DKd1xucu3SeO+pwj7RJY2cA8vAZmuxVjoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oI8YYoiqzfJO1lonvashtgY7l+VmfrMoGYUVHt7XLWlrcQ+16Km7dU+Z9Afoa+60A
	 8VmEJAXSETs5CauRsKlz1Vn7bH2R4LWfmvtC7EFKchjdyzRCryUvCfPa3TW9qS7tZ/
	 eYRRdHsT3nrrzPS2P9PejnUy8xNyoKvkGfULyJ3yI1BNy+YhXQb4c42Z24bOlM8ob5
	 izn36sILKFB1yR2wscT47pEzYBy3K041RT1OdvDXpxX2FEANUepst4qjnflGKyNkAc
	 32Xl0RtUmiuSk1iYVaiNZELuJiuoRUtNvT+IqLGSwqY/jQz2i4dQzzVDE/DgQgv1Eb
	 Dwb69XyAlM22g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 12:57:44 -0400
Message-ID: <20260723165745.3396221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072004-prelaunch-refinance-a01f@gregkh>
References: <2026072004-prelaunch-refinance-a01f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7970d6aaf710db166de98c5356a260089896fae5 ]

net is already set, derived from nf_conn.
I don't see how the device could be living in a different netns
than the conntrack entry.

Remove the extra variable and re-use existing one.

Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: e5e24a365a5e ("netfilter: nf_conntrack_sip: validate skb_dst() before accessing it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 4326d5ea0400d2..d2373733e98179 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -948,9 +948,8 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
 		struct net_device *dev = skb_dst(skb)->dev;
-		struct net *net = dev_net(dev);
-		struct flowi fl;
 		struct dst_entry *dst = NULL;
+		struct flowi fl;
 
 		memset(&fl, 0, sizeof(fl));
 
-- 
2.53.0

