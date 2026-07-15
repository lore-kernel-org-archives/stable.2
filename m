Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419313BB66C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150810; cv=none; b=SawQQmVgHInmLrsYa1nofpdbu26gA/OWAsrbqd6i9PHklmDDscIeOU1w1wRibpDTwQqGcrlU3qsA0giVXG1ob8gym8JKBezidSP/vnzXA9TJ1D0tdhC0Y3r3h+N/Fqw/zzoqK9aCEPD5iQzYQWsayPltMyA8/W8+Pn2nckOukI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150810; c=relaxed/simple;
	bh=K2u0u1wVTEqKEnAmMXS41xe4Eh8dEolh/wNqznzmLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW71/+eEDA8yADIoDal3BMppGnp737eNZHzz+HF5qaQLjFOYMG/rCwbfX5cE8sHEM/N5P4kH0TDiZo6X32CKucdiwaLwDT7XmnRX0BMV0GQDuxtbf9Fv3MTL4s0TijfC2TvJY1WVx2CoJPXD7yX2OtUQJA4DOoLZGzGDKcUZ18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSngqdtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSngqdtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B171F1F00A3A;
	Wed, 15 Jul 2026 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150809;
	bh=Rzvq5PSCrdqRZuGx8w5CQHLESGNg5r+ur2ZlhAjAQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSngqdtVHTguEa1Ofo8uD5SH/3a941odk5Z7hhYr4G1zRXABrv+nyf09fukTRmuqR
	 LzQh4CC77+weopLeCYdYDlOqAwe9BxBWPp+wfnRtFlPhgI+JFW5WXQUw1rmdLjrNLf
	 HYsMdJCpy+9Jxs5NpaFPBQFGx8JsT+P41beCxOVmmXoJQLBzCBQYSYFkq6/Tz/54I+
	 rK6+lrq56JJtfWcI4AKb6BV4ed/ifTFMesq6YMhAPTVjF3/TBa+WjwGutxfief4EeN
	 DBPxALayvYYxNYqzdZj5G8onTgF1L344Rqh5cq50FLLoadqw31zUV5Y6Q6W4HO+HDp
	 dwm2buZ6Ehlww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] netfilter: ebtables: zero chainstack array
Date: Wed, 15 Jul 2026 17:26:46 -0400
Message-ID: <20260715212646.278719-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715212646.278719-1-sashal@kernel.org>
References: <2026071335-donator-saucy-140c@gregkh>
 <20260715212646.278719-1-sashal@kernel.org>
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
index 9d23eee5736789..b7e3ae8ae38c3f 100644
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

