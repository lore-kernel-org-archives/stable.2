Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97DE390618
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241011; cv=none; b=XEbt+7yx+ORcdpDVztYfra+2NcQYfP173KWqYrpEVOnLInnEi7jfv9GN8iPqSVzbH23xK13JjbWcOaZMubfQFXLn66NHtZGxcOMFJbgetgUiD+x5SZd0FqTxu0JVLJKFG/2cAJmpGkCehAcOnUjJvuX2AY5F7NeUwKLRaWfcvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241011; c=relaxed/simple;
	bh=cmsxV9Nkw8lAxqZyX2y07ShOo3KvWudtBuC7QVgai/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBnM4NkaLneRtzMlFiErIqWi7ONvo+O/Vp18+PVtRze78pGN1rOymKY23fBBPuHob/9o9rCSkcEChsrzkI8mIYJxX3rB/HjMFigw/qUh/TRIB+HXaMMBqKM/iSHLZsjGr2bZ9Z6BGR4KS4QiU9jz/4t4gbJLFHTy3rJPA/afUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjrS5eT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjrS5eT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8781F00A3D;
	Tue, 28 Jul 2026 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241009;
	bh=Au+rF1K5DjS+MsK1DJ8d7j4V4EYyPzyLKO1jkGTH3BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjrS5eT9wRPMaYAnWEjFGkWHDF5YEWA1wSGG0XQMQsOfyUJUtLb8VoqX8nROGlRoG
	 ckCuw54Y7povHqHZifSwR2y88xPj1fLUuanSZkk+JYuZClJTRqYUpH/37hGN9tpAvQ
	 HDmfl+mxRePJ36G3q0xlBZKr2hkmmUL0YtPpiyJs5biC7+RAz43+AXHQAIXgtCjUJJ
	 fM6XZzynzllZ5B5DiuPYr/D4vSw9hDFgU22lqGlvUAnIwboBUlArhQKYgfVcTBhi2W
	 Wvz1UeSCLu+UEjfhd4VxYR4fSz/cHmnHcteKvF1xKnlgBzy+o19vXFOhgDZHwB94Fh
	 RbgseBUsKDPAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 08:16:46 -0400
Message-ID: <20260728121646.3713785-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728121646.3713785-1-sashal@kernel.org>
References: <2026072006-purely-upload-afbd@gregkh>
 <20260728121646.3713785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 8211a26324667980a463c069469a818e71207e02 ]

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 6c742e714d8c ("ipip: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-3-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 358aaedd27b2ab..714de14f0d889d 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -476,6 +476,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.53.0

