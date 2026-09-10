Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BF2F9D85
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003052; cv=none; b=E7wZdVhtgILfkUUeIheJcEX19OulGWPPWfQtyXPa6ZRmHZX0arrk0tOdEmBHCohGfQpseXuh7pW6Ro7mGdIH9GznKKP4QfLPYj6xN+VgLvte/p1g3dadLJYj4A3De9nxFiX3ErP0oGVqpmJNyKrKdaHc1ZEsmLJXNlMOHMs2GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003052; c=relaxed/simple;
	bh=RPkBllq1Q6Id5ixKn85swPPvG82qTp0WNBxdlZxYtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKDnnTHtx5i3ZN91kvSAXTn+EuI1TMA2Hsj6HGNRnV0lJsNXBKPx5GWaDmbO44oH6JakNE5M2+r95xvt94wx/gLGzptiYzieKjeEuygg72LbBXbb9W/BtLrEzq2Km0kricjzOWAOHjb+tXkwC+FnDEqACRvbZuYgDnhfUaUSiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5RB+BVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5RB+BVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6591F000FF;
	Thu, 10 Sep 2026 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003045;
	bh=bU7wlpuJTeJQqAgBJha31jSKrSdh7yOhHl5bB4tj2Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5RB+BVu6f1oxNMmNOtbTLwbPjgR1QHHdl/He2MzstXlWg61X1YHKfJrQNUUUJ87B
	 xY4zabLjQZlcpDrPu2viqabC/1Og0QPsIvb2zaWaQlQBSGnL9wixlReqYWp6LJ+MAp
	 cvMI3/ZOwkVHyQMUO1/AIOOtFHSSwptznP+50Dqo6bFUbVUuy9kOlKj8Un/L4kstLX
	 399z8r8BMY2S4ajjWzIO0Z4yf+2YesryHaTWrf4YBhVcGznxdulBzC7+NmiJmgVfSv
	 B9HSjei5HVOxdYYnxIxmJ9lTkMZM3PPvglHlrTJoPlSBP5xdLyVfIaFzYbaWxqWNC/
	 W482Bp4DBVUNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bradley Morgan <include@grrlz.net>,
	Oleg Deomi <oleg.deomi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] taskstats: fix cpumask parsing cutting off the last character
Date: Wed,  9 Sep 2026 21:17:20 -0400
Message-ID: <20260910011720.3832737-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910011720.3832737-1-sashal@kernel.org>
References: <2026090426-survival-bush-ee14@gregkh>
 <20260910011720.3832737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <include@grrlz.net>

[ Upstream commit 1f58a5335cdd14b3fb5f2a5d3763dee1f5cba1d3 ]

parse() hands nla_strscpy() len as dstsize, and nla_strscpy() copies at
most dstsize - 1 bytes.  When the attr payload comes in without a trailing
NUL, srclen == len >= dstsize and the last character of the cpumask string
gets cut off.  Register "0-15" and you are silently listening on "0-1",
exit data for the rest never shows up.

The bug only bites when the sender doesn't NUL terminate the payload;
senders that include the NUL were always fine (srclen gets decremented for
the trailing NUL, so srclen < dstsize).  Thats probably why this survived
20 years.  And the policy is NLA_STRING, not NLA_NUL_STRING, so a payload
without the trailing NUL is legit input here.

Skip the kmalloc/nla_strscpy dance entirely and use nla_strdup(), which
already allocates srclen + 1 and terminates.  The nla_len() bounds checks
stay as they were.

Link: https://lore.kernel.org/EC49FE41-7F5F-41E0-A07A-ABEB8ECA514D@grrlz.net
Fixes: f9fd8914c1ac ("[PATCH] per-task delay accounting taskstats interface: control exit data through cpumasks")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Reported-by: Oleg Deomi <oleg.deomi@gmail.com>
Closes: https://lore.kernel.org/CAByWkfZ6b1=3H9pwkz-dDQOs9cZaF-HYQ6b9Yb0=Hq2r1Vv_Pw@mail.gmail.com
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adapted the removal of nla_strscpy() to the older nla_strlcpy() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/taskstats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2d24fb7cf407..ef2c4fea49c86 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -346,10 +346,9 @@ static int parse(struct nlattr *na, struct cpumask *mask)
 		return -E2BIG;
 	if (len < 1)
 		return -EINVAL;
-	data = kmalloc(len, GFP_KERNEL);
+	data = nla_strdup(na, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	nla_strlcpy(data, na, len);
 	ret = cpulist_parse(data, mask);
 	kfree(data);
 	return ret;
-- 
2.53.0

