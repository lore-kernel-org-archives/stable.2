Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170B37B3F9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609186; cv=none; b=ounNKIifyCuYRRtuTzl3EwoTXc32cYs13MNNYnt/f+dATcRfct1+3pTYyJuMLYVsbNsHjyYAvpYfwMw638r3XDlsh1z/Qv5GA0MpK1odESxsieWtJe9EJBnL6/WVHXC0wMqUARhCMitXErRSHSdVHwNZL9a+PMTwJEfytgFpmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609186; c=relaxed/simple;
	bh=L+G9s5y6og+RlEHUsyhsw5ExpPc6akjWNy8XuSLhD6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbFDzd01HGiRf2uzZplhMMQhXZXElmNmes+ijavAeg6sKuO2Prakm/9xm3OzNz9AZbGC1QslhpNukhqj1RKVTYosFt2NylE7vsU+kTSB0W1uGflnXB0maNj9C3Ezs7Wiapq9y3bvv7JQGOxrieUOnba9CqER99e3bQBLuLc8H9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjSUbMGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjSUbMGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D4E1F000FF;
	Thu, 17 Sep 2026 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609184;
	bh=ySKvqzWCZTLW9EzDJN1JZ3GNQh7RovyTlHlxbFGW4+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjSUbMGfPo4CPbw1BUCf5n+jnxEd44FtVysxsWh5TyRSGq1gXkXvgc3b+lwfjgYah
	 Zip7xcmdBVs4qYxpodSm5IVN0Tnn5S8Ehqgb6X0Cptc1AEbGEsaHUQJED61Cx71JFd
	 WkMHF7zZCIyUKRxn6Cvn0gOC+yE2EdiilWeAYu595oVggat3IwGbCLCJ3YLm+rmyWu
	 DJBZd3uYvJTDK5uxWn+m9f5i/eXTCx6DwYTdjEZpnmuRb8lBWJko0GgL2FAGyRe5hN
	 6Y0oZe7uhq2XK4Xqi5nfh5JYYlc3Zy7VJtmqFPeQWUGwJvxIspQ1iN3/gsAJ4WB1SF
	 7nRv/WBCtqxFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] landlock: Use mem_is_zero() in is_layer_masks_allowed()
Date: Wed, 16 Sep 2026 21:39:39 -0400
Message-ID: <20260917013940.3651217-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013940.3651217-1-sashal@kernel.org>
References: <2026091639-trophy-refract-3155@gregkh>
 <20260917013940.3651217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Günther Noack <gnoack3000@gmail.com>

[ Upstream commit 1c4fe87364782d1b058cc9d15fc8acef44bce033 ]

This is equivalent, but expresses the intent a bit clearer.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260327164838.38231-3-gnoack3000@gmail.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: 2c6dc7925382 ("landlock: Fix use-after-free of the source's parent directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3fa30715531c6..a9a5fc5ba1bb8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -559,7 +559,7 @@ static void test_no_more_access(struct kunit *const test)
 
 static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
 {
-	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
+	return mem_is_zero(&masks->access, sizeof(masks->access));
 }
 
 /*
-- 
2.53.0

