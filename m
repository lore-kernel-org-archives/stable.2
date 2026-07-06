Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990029D268
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344850; cv=none; b=f1anacHzBBjWXohYB02Tsawi1suiWtXCmlmpSWAJCGUSMEj0Zs46VoU1gNyzcZkJTb+eQFS0kzrRXhpDCUkFANd6xmUPswTQFIsAKI5GUvTFs1RzkayyLLmZTeHOtWp4yZivy9H6T1dfIP8jx9Nas4JSaXyQXHjUW2u5SVpJW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344850; c=relaxed/simple;
	bh=G6F7J8gmpgK6KEC2oVwHQE8kdfXvIeMMN3hdNFlP7NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZW3VeONVGULOg1TwaAOQSw3fAPY+CliAUXLvvDtKausZ6Tn9NncIlhwcD0+Ab+WhRlfXOJsHazzew1Ni+KZBwBO73OHfKSs+lxU9wfyNeq0CdwbOGN2H13DQFSPb6MPr4EvuhG+NfO7O3ve1PkRvy2XrnlB72c7CDo2kH1ESC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJB5p27d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJB5p27d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50941F000E9;
	Mon,  6 Jul 2026 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344849;
	bh=y6c/NHkjbM2PWPiw1dt6sCq+Fd18gY+nhoyhIx/Tfjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJB5p27dIrePqUqEdjB9ZC3Tcnzsc92AretKwVPELOLcyfhvgs6OUwn431zcbvo5+
	 kJqgye+Y/lVO6Eo2NlDD4PV59r9DjHw4rB0v+w0oUs6QPBIHAmCM8aeC5cWvg/XBnr
	 e0it/efLABMBdYcmng3gEx3jzkLii8B0VZMwWFTBdamDSWq5T/vUqBWexUnfKV7+MP
	 gaLBAGxJ/ao2YJhkYIOpW60L1qVb9j5WeMWYJBHmeFMmpBaI+JXpAK5ZD7NF7X0vr4
	 MXE8Hz77tHdnUStmv2z7epUII+dWDBvteUcBw/xoC/b83gu3MxtbfVfQfHuy1m7f0h
	 65UvJ8uEGEe1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] apparmor: advertise the tcp fast open fix is applied
Date: Mon,  6 Jul 2026 09:34:07 -0400
Message-ID: <20260706133407.2334924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070217-plentiful-create-ce90@gregkh>
References: <2026070217-plentiful-create-ce90@gregkh>
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
index 3e632700d06fb3..bcba4d2a7aa4d1 100644
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

