Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078C3368AE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764033; cv=none; b=XkgUDHulLhoFDfcoRb/evWSDecFgEB2HBwdOgGyu9ug8Qy5bykBLkUz2Ic9OWl8YgourtjbSZ5LiZnXKj/EQUYHjc4aECu7YAAA20pa0teFZyz08VlidqI4sOrHk1/jrg9b5yV7siv8R7CF8Tib35e4p3ANWMINEPgyEW0SlYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764033; c=relaxed/simple;
	bh=QTCIRnmPIPf7SVxEXYRDg2eREqBn4NVqSEtX3uUYF/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHdb5TMAv0tUigKfKtxb+nGJ41IWL7jy+9n3SGRXIMBH4aCv83oJkzBDHbmPQLi5aA2pH3c6jNaFiUB3CeLFoxZgtl34hm1S0MOlInFRuXafRiRwducIk86ZMVHmfX9R9AZHfmseakWvZ66eqdoy7XQhB3U4IZpSqUKxFU4d53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZxGFmeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZxGFmeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C231F00A3A;
	Wed, 22 Jul 2026 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764032;
	bh=CNlDf/EkMCjaCwlK5BgGYyr++mQYcilext6hII4iBAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZxGFmehmEeVPZ1tAMwlhLebxnl3VLoIoWK3PdEIjaOscdMEKX1RG89nFnoZoG1Q0
	 Gb1b4CzL7V7IqUekJV08vpG5rr9N1z+m2mBl9qxo29c8FN9ZZsA0RSsXY3FDP2AJre
	 IUwQea3fjkRmPVe9HJ/kKWOGwnrRgHedow9LOu+YLjLapH/xXsMVbLRHv6IKIVpRDv
	 G3KwXNkegr+oHizWUoFr9T/QHRLQSQ9rn4FbI4WF0Mz6dl6r54i/ZjXYpwVKGec+4A
	 2cyVYcvT27w5NWavS4zhndGIfUhVCn5gaDtKX9qBZWBPsz0UJkPZ6ROeKRc1RfcfdJ
	 UNEFSfOMLKyTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] fbdev: efifb: fix memory leak in efifb_probe()
Date: Wed, 22 Jul 2026 19:47:09 -0400
Message-ID: <20260722234709.2613278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722234709.2613278-1-sashal@kernel.org>
References: <2026072028-upstairs-wilder-f34d@gregkh>
 <20260722234709.2613278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 9b6eaf101656958397a6012bf43f6e2e42c9e5cb ]

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller, but the string is not freed in
efifb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/efifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index d6a05ef0cc9027..945af6db125537 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -375,6 +375,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;
 	efifb_setup(si, option);
+	kfree(option);
 
 	/* We don't get linelength from UGA Draw Protocol, only from
 	 * EFI Graphics Protocol.  So if it's not in DMI, and it's not
-- 
2.53.0

