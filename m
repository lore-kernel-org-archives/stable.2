Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF803BBFC4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150033; cv=none; b=ENUWoli0oTkZ5nfR6oCnVl0tKHZAK9W24nj2Nr85v+fjFUM6QUe683m2qVP7XYJSdVcZwLQYeZeUzd7fT99ZeugUFE9nFE8RamjyjUe9CoGOc23XGbk0vPQUMjlKggJKqPusuKajSoe8SrIY0ROeNXCwzs6ZiLifKZHvEHA0R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150033; c=relaxed/simple;
	bh=uN8V5pXZ20qXOE0ehY851CwRFqNQ5g3fj+ptYHLyCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/pBNVzhHrV9RSuAO7fHGDPSoN5qNbQc1RjGYK8CFa7j4VTNJMkwMZza/1Z6054gifEBNMzdCJkiomxCErB1tiPLp9Gm68sh39JZgUKWShRRDVjVru0sdBOqXwOJTXYWtHr0Z3+7/YSgd8QpLC+i8oF8dvcGLCSZDWeb1/OI6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXBF97ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXBF97ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6001F00A3E;
	Wed, 15 Jul 2026 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150032;
	bh=1C82H61FSQ7/wmErFW9nKWvzxNfqUv1kWLaWBOC4AXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXBF97llFxRdfKlEpAT5ZPx1xHbjkCImkYwgSFKr28bFSlFOeRAq5waP6Brc9y0bc
	 9kbJ4/5JObHyhfvcSbUQkfdOfBR+h0hCGPzxgq71/asZaIfUTFIyB/kvkawQsNDhqV
	 YRxpJqIotVGQkKzEvyyZWdmAALghX//9b3wWTiHZqSthtKn/iEwDdmFDGKN8LSXOwm
	 O+wAwHUe9CwNPerzNam2wP2T+qqKruUBao12FcXcEWE5mTxeiotNRXR7MX8XrE3COW
	 8EM3kQSlYY0THoXzx+YayxNzqpX66anAmpNF2Awug8o6rI14s9+hjvM4KY4ZXy4c2c
	 m2k6/Nv9bNK2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] netfilter: ebtables: zero chainstack array
Date: Wed, 15 Jul 2026 17:13:49 -0400
Message-ID: <20260715211349.253327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715211349.253327-1-sashal@kernel.org>
References: <2026071335-stench-wolverine-f95c@gregkh>
 <20260715211349.253327-1-sashal@kernel.org>
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

