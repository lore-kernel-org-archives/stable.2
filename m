Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E123AA9CA
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575930; cv=none; b=nG2fVFTj2T2Fl5hdznF+Mq7jaZL0Byi1PIHMRcYdd4jTdwuf6/ylw2ydclVUZuWYXgyM3Xli0n7VMz0CxNz2DGaJyJxwZklRfncWW7W8QMP+zBHhHb0coDnBTzXKljumSVFRTHa08Zgll0sfkh7EYyb0mJIzpyLi0zuP0ql14mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575930; c=relaxed/simple;
	bh=3EFBZBk5WoCzwyemq6c5RgtxwguDDhrMMWn7FICgoR8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Bjeh6y3ncFv+yvKfd3GiYGNQcPgEhzmwxj/vZqleWbl6YMV009B8DzVYdG80UW7IVkDFKKv6wl3hpe3H8L1TOkKCAg1C1mZYLX5UB3I4pILNKo/Kc2uXO87WQ5F2tQHyvQK1lo30k0SyWRNt3zi/UZq8xmLhF0Bw5kf1dS1qpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UtW7t2cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UtW7t2cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC01F00A3F;
	Thu,  9 Jul 2026 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575929;
	bh=HUDERsjh8Sw/pApF13BmAqbyh0bnv+n98kt35pxkmxY=;
	h=Subject:To:From:Date;
	b=UtW7t2cQtd7z6uG+SjbcTgwkFBc/j+iFjzYfXNgV0Z1igrdSsTaGJGoSxt5maK4t0
	 U3sZriLVveNuZ2bKumqFcx01dDuBrNmMe06zmC5T/ocyuvwlqtqEUB80JHxf/DEAi7
	 sSvcfzlgWI6c814BEZ5MrjTtPbZ9umdH71jeVvXw=
Subject: patch "iio: light: al3320a: add missing REGMAP_I2C to Kconfig" added to char-misc-linus
To: joshua.crofts1@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,david@ixit.cz,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:50 +0200
Message-ID: <2026070950-kindred-commode-10eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: al3320a: add missing REGMAP_I2C to Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 9efcc9ba9b2e940cc01e63d132ae741e4c5d09c7 Mon Sep 17 00:00:00 2001
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:10 +0200
Subject: iio: light: al3320a: add missing REGMAP_I2C to Kconfig

The Kconfig entry for the al3320a is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4ba3151ebea7..f23bbce12c72 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -67,6 +67,7 @@ config AL3010
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3320A
-- 
2.55.0


