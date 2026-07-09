Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FB34BA42
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575929; cv=none; b=bpgPxpJShu5nZh3dbea4tVFMjm9TYMBAkEsSeRjnFgS1Z2SK2Hi31PDh9PvegprHX6DFKV/6TrSA+QOYu0x8xmyWYMqH/qtXdGOaD3enp6iHDYgkqca14XONIhUdgVZsxgOONdNsbh0DOtx2ubXSsm+6aziMclxNMYDEu1OtPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575929; c=relaxed/simple;
	bh=C0PyFjWu2UKO/6mbVosbR/83jMhSxWQN7Lx9WuDHgmI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=l+jJuqKr2RhJ6GYS1ZVOva79SahOE+XIVcOFF9cH40U6iqm2le7Pip0EEdD7D2kvMcPC/jgbp9EVa0PDmlIT5K96JmSBEMeK6Cnv+RmBcdg+o0FWWmy7uKJoqtD3NxbSasbB7H5vCW5wB6RK2ZiAaTORqy3pOPj6kMELFDXb7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ffto+uRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ffto+uRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9E41F00A3A;
	Thu,  9 Jul 2026 05:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575926;
	bh=jtFi65l+XI1816Kqfq+LtVfO8Dno/qQfuQBsHuyehzs=;
	h=Subject:To:From:Date;
	b=Ffto+uRS0f3//SL8z7WaKuMaEkkcJqPjYTxz5xPaShyuBnhmq4zfkH1MkA3VFZfEx
	 Xo0tQu5ytPJM26MERcIgXKfYRyGb+3AohqRsZCDs4f7wDk0BjBTgk8IaVULOy3kMp7
	 x1bxNx96IMdGUbUgeum0Rs27nUPfi8lKlYa0UXhA=
Subject: patch "iio: light: al3010: add missing REGMAP_I2C to Kconfig" added to char-misc-linus
To: joshua.crofts1@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,david@ixit.cz,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:50 +0200
Message-ID: <2026070950-steadier-oxygen-3d12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: al3010: add missing REGMAP_I2C to Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 84486e3bbda18a2df1ed74ca78e1e14bde9a941b Mon Sep 17 00:00:00 2001
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:09 +0200
Subject: iio: light: al3010: add missing REGMAP_I2C to Kconfig

The KConfig entry for the AL3010 is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a33920568904..4ba3151ebea7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -56,6 +56,7 @@ config AL3000A
 
 config AL3010
 	tristate "AL3010 ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3010
-- 
2.55.0


