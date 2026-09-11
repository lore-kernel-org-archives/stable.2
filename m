Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45C25A2C6;
	Fri, 11 Sep 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168285; cv=none; b=qsNdtjJ/6sXgAhpxlwlSLTEfi8ILcR6Ov6uNtRZYInasRFG+3zQRhwZtJqusYOfTIw/klrIfhpxiPsJtJR983FGip5oYQekvjCdUbqAwWMD1IJhyGDeChiS1VBNS/AFO7jXrTXyS5kOTtFzu+hCD3b9SoUXlC6aPAIJ6jcWtvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168285; c=relaxed/simple;
	bh=b3vyyhklKLv+50zUy5B6CP/zPXTOiUAdwPNtMd+BKCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7R+rxQfLHLNgjUp4cZg6IzA9FK5Lvnz1teYydzQ8w7gq3VwTqLQuCqT6V3ovNBTkwLAp3d1FHL6M48ZuJpwRTSWidOHCqrrg7dx1aYSX17Egmj2AL01J+5k6G4Q3Fwp0a1rWvgpXduaatMnCtQolRqYxgG/BefwSQU5mUxSQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsJ3KGgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsJ3KGgk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 770C6C2BCF6;
	Fri, 11 Sep 2026 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789168285;
	bh=b3vyyhklKLv+50zUy5B6CP/zPXTOiUAdwPNtMd+BKCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rsJ3KGgkTA5m5Qrka0D3n037PewS20HhrBkAFZIe6qaYzXnTRMzXS2Guo7PUcnxIb
	 Xly90k/Ll+i6XrkoLEIk0yoQ3mGSG2V/2nYhKaRmb6rsLr+k7fn5t4yxgEtrO8QvA4
	 qG1shImuV+X2lGv1Y7sW8woRGjiCb3L5K83h293nzmT53drbUk67aaj5TSqL6p4FIB
	 kw2rJ3w5b9pc64Y5CWCDUAVR31WUhvskA1KrUXPxNqDjK3C8Y5I3nZfhPIacNtQssj
	 xNfiSy1MAc+rsFibVLl0BFZtVMl3WHMT3F9sHDIilBsBTFJd565W1hYQaigTwYC04a
	 tJs+EKLcF3JWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC5C88E4D;
	Fri, 11 Sep 2026 23:11:25 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 16:11:21 -0700
Subject: [PATCH net 1/2] ipv6: rpl: fix loop detection for separated local
 addresses
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-sympwn-rpl-send-v1-1-1753993bb584@gmail.com>
References: <20260911-sympwn-rpl-send-v1-0-1753993bb584@gmail.com>
In-Reply-To: <20260911-sympwn-rpl-send-v1-0-1753993bb584@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Amirkan <markdamirkan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789168285; l=1258;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=aPw9jW477MDGfTEdsqsF4etE2NWXHDQy5grI9KKty9c=;
 b=YqX2bnYQxH+iSnWmqhIOEi2GFKE5BpfSFR++uw5ePva+ZTbl5B0eukprht9tL0hIT8lF3kUaK
 XzcKL/7ThQQA5eXF4SrBhU8YoF71Y4ts3Oq938fD/L2peeOmj97d+ez
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

RFC 6554 requires an RPL router to drop a packet when two or more
addresses assigned to the router are separated in the SRH by an address
not assigned to it.

ipv6_chk_rpl_srh_loop() checks found > 1 before counting the current
local address. For the shortest invalid sequence -- local, non-local,
local -- found is 1 at the second local address and the SRH is accepted.

Check whether a local address was seen before the separation instead.
The receive path calls this helper before forwarding an RPL SRH, and
RFC 6554 requires the check to mitigate bandwidth-exhaustion attacks.

Fixes: f37c60593634 ("addrconf: add functionality to check on rpl requirements")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
Assisted-by: Symbolic
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9d89be7e0544..f678fb7fa574 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4621,7 +4621,7 @@ int ipv6_chk_rpl_srh_loop(struct net *net, const struct in6_addr *segs,
 		}
 
 		if (hash_found) {
-			if (found > 1 && separated) {
+			if (found && separated) {
 				ret = 1;
 				break;
 			}

-- 
2.43.0


