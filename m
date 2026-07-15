Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A53644A4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148591; cv=none; b=Mc4gretqpbZ6MX+LI3G6BhJRIdzHzJakpMN+dUGjrpVXdDLEwt2uZiDDOLYtYIqEs1DiR1YpL/AMEzo0vw2UQnndGo38oaxa5kwLP9OCXpjGcMkLOf2NOThjqjYgH4vNX/G08xUA+ZmfOwN9jH+h1sv4hBZtYwMObhcYFpNIJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148591; c=relaxed/simple;
	bh=uN8V5pXZ20qXOE0ehY851CwRFqNQ5g3fj+ptYHLyCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk6JcbETfkT/edTRaH9P068zx3uGrXJghy8Ac/zWwTa3G139poiJospwMDBYb9cmgz8t88c5E0W2bshz3dzCKhY7KGJk0uEqN+K1Gzog2nB6Vt0BXFuEoKgjwQzgYYqnPqNiNHU+kG3b2gcOnnrvWY3ATBiWoXpcDhPqy+8dIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJTwrX5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJTwrX5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD82D1F00A3A;
	Wed, 15 Jul 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148590;
	bh=1C82H61FSQ7/wmErFW9nKWvzxNfqUv1kWLaWBOC4AXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FJTwrX5C10osiBRTi3MZ74qgy/dfZkdXAlNShz9m+cM3O6GnWw6A9ALM/Hv0XnEWL
	 yxYU8zA5C3zfWUTsQWJQTOGIdgaoSPPsGMYpEcwJ6u7EKu0411cWPrSUt9iAxzR0yA
	 Ksf1OaRaM5j02s8JhMLPlIaP4JrW9444bc0KRpP/+oQivtMMvfNUUUtnr9/RJ8fOjg
	 45lKFoQ+QtOK1le6ZMN50Pedk9HfGGWGevzuNCiZlPZQoZtP7cBvL/ZZPA5aoQYKbf
	 9eaBnLYPrH1NnSD2OOamAwm6sMpXwxK6MXGUSJJSpeMM9WsWv4aYrpZ4PPt5aT+y0w
	 NZQ8vkMmuJgBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] netfilter: ebtables: zero chainstack array
Date: Wed, 15 Jul 2026 16:49:47 -0400
Message-ID: <20260715204947.205286-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715204947.205286-1-sashal@kernel.org>
References: <2026071335-exemplify-sheet-ddd5@gregkh>
 <20260715204947.205286-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit cbfe53599eebffd188938ab6774cc41794f6f9d5 ]

sashiko reports:
 looking at ebtables table
 translation, could a sparse cpu_possible_mask lead to an uninitialized pointer
 free?

 If cpu_possible_mask is sparse (for example, CPU 0 and CPU 2 are possible,
 but CPU 1 is not), the allocation loop skips CPU 1. If vmalloc_node() fails at
 CPU 2, the cleanup loop will blindly decrement and call vfree() on
 newinfo->chainstack[1].

Not a real-world bug, such allocation isn't expected to fail
in the first place.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 4d0fcee59fdd57..6758f757dffb15 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -920,8 +920,7 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc_array(nr_cpu_ids,
-				      sizeof(*(newinfo->chainstack)));
+			vcalloc(nr_cpu_ids, sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {
-- 
2.53.0

