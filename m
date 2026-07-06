Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F4378833
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347060; cv=none; b=qC2Dgdi0IeDkWQd3FT8ckhDXMha3sXOxA2hRXqPkM5bwSNOwn4+IkG8QjtZg42cFgioMZv+8s5J3tRU5Ij2zjrBqSDkjvkmLh64udCuX45zO705lCT1BlcafUH/nUHm0P65wWpt7R9Gnq5ioHwBoOpbbIQh53UQCN1L7NHUUqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347060; c=relaxed/simple;
	bh=yjXj8BpWn7yDz5jFHEhSbFmp79/Nd6kYIqXR21eJ408=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q31A2HOgwOqkzRyYLdvT051CjiYlzZ12FMxHUDzc3uML6APbX3XL5i3w1P+OiRUEF1E0J9eW/m/fICS6++L4Xq8OSDLmUL+sQ3A6b6uCNtbyCImAcEhs8e5UVKIVkOyzDz0NRbmHIBkqxNB5v38bXdqTfGmb7iQH6sYtr7e3r5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiKByEBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiKByEBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042331F000E9;
	Mon,  6 Jul 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347059;
	bh=PfScW7IQB1rr+CZXbEdhNTssCGC7wUw3H9GVCqGbxIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiKByEBgQ3EUTqXgerpwYzkdmXxGPDVCG5r2icfSjfZb/9E73SRTDRuC1snEl8I+3
	 Jb9nVOYxMCUBNjCIZPHafphGiAiqNYPYDwxd0d4Gm8iuVH6ECzhobzqHMWTpcxs2NI
	 SZO6rpBqOR1zfS/TTSGqSVETdT2yk7kXmsnZUFzARsJMvszzAaQmCVQs5B+lMpk+vK
	 M1TH1iET6DeXj4hi7ZBOvNTT9DdPpguS50Diw77m+YO6lo03yNw0wJE9vn1StWppE8
	 +ZrYuDxPim9hS5HMYjg26eCYK4oBNX74FyPPbpMMwAJRmnRbPKqa9mY7Nyj+8sqI6O
	 nTeT1oWh2muYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] apparmor: advertise the tcp fast open fix is applied
Date: Mon,  6 Jul 2026 10:10:57 -0400
Message-ID: <20260706141057.2348305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070218-chihuahua-spectator-c61e@gregkh>
References: <2026070218-chihuahua-spectator-c61e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8 ]

The fix for tcp-fast-open ensures that the connect permission is being
mediated correctly but it didn't add an artifact to the feature set to
advertise the fix is available. Add an artifact so that the test suite
can identify if the fix has not been properly applied or a new
unexpected regression has occurred.

Fixes: 4d587cd8a7215 ("apparmor: mediate the implicit connect of TCP fast open sendmsg")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 0c980e62dbe7a2..a7fe1167e0cd29 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -21,6 +21,7 @@
 
 struct aa_sfs_entry aa_sfs_entry_network[] = {
 	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
 	{ }
 };
 
-- 
2.53.0

