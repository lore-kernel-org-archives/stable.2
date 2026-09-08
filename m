Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0D327C13
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884716; cv=none; b=hsSRlfQ+1JGgDKfKKw2Yn7bdmbPUyF8GEJWTpiIHqydCzsQI9iNBJp5UVlE7zEKlLon+H2Zq1UrOZb/smyx5UveJLYjRXLGATqwGiS1T6ChBScEs2vbbfCtHg4fvPpXFjIUTi1O0sNRsI10XXbcEa4RMi/8ftbMHcpF8+hVgWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884716; c=relaxed/simple;
	bh=8EZYMePfyjqft7wjRc08xFKmlPH0LG7J/lvz8f03FWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNvYpO+QFWnIMk9dCV/6UpLOJPI291F4+sUmvZEftYzzfcGZtyS58bDMWA5RmCa9EBzcbkSutUDVYp57GjvVPkuiUTRktlAf+1WyTmqZZSH1x8qB0bZqSDpeyStypohinfACmJDo4kk8UZ5WzSUfDFMILN1UxNhEU19wh37AEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHh0R45q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHh0R45q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89571F00A3D;
	Tue,  8 Sep 2026 16:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884714;
	bh=oUSp3tRCb1uDhmypz9HdS0U58u+bhPEgn7I+O0qGwZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHh0R45q+H77GV+RkLrOogkAPY0CrnYz4vJGYURjGfIhBsMm2qHCi2NOgiHD+k6Fl
	 ESLksQj8+JoKdazuSHu6GzAwOgMU044ccUa9lXbFT2idxQecGZgWBGYsr9idURpL44
	 IsHviqySE5/huN4o5xgLhSz0qK82mvAbcPBsXBAHBEx3yzfA6qm2KexILCVoVjHO/d
	 r2tr22YBXRo/6hfPkJNA5B2hfVbDVp8miNP3UvacuJDic+8d5ziRnuyzXgqmhSl8Tw
	 1/jE8K8W+PeTIt4c4DSkbwqsnEPdCWQ7+dPZXr1cI6mhC/PPnZMZu8nELNZslCN3PR
	 et5cGsDcWJS0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ipv6: annotate data-races around devconf->rpl_seg_enabled
Date: Tue,  8 Sep 2026 12:25:11 -0400
Message-ID: <20260908162512.2643067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-vaseline-matchbook-9e16@gregkh>
References: <2026090350-vaseline-matchbook-9e16@gregkh>
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
index e024d8da431c4..7f2d7cf976a93 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -503,10 +503,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
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

