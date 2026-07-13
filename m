Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E340C5C5
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946767; cv=none; b=nPkULRaLOjXFv4CeMznUxfsZ0I2Je1SMC04U03mly3GqYn+1ivk9qnXe+OaNgBMJuZ4JyGHrcYrxVmQoLxjYciZ5+qBqgvUWsN3YNbGexULytGlrA2A6ktS3uH3Xzef0eN5gcW/XDgBrXAOEjf5InOBKX4oX7gyqmvwu9dtH6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946767; c=relaxed/simple;
	bh=zSuLuB8YtnExfLzHz7M/afVpgUkHrbd77m53thGvkcU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xp2fHkdcTGniaIeG/XqnnAemqkXjB4AOUlQhq+3XGVxDwn1Po15MrJ4YApzr2Dns09uPSawvf0OTkBTwL8Y9N6V/9gkUBOHcIH1uypkJSHoLDp89EtokFpZrZ5fuhYCbdz5iS+8j0MOvrn7lxuRHj9HgeqPkC+spIGeq1Pv5FtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDaU712e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDaU712e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B451F000E9;
	Mon, 13 Jul 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783946762;
	bh=K4SQB9MdFJ0UJ/yoNxNIKzBNERCN8x4bxLFw91S3m64=;
	h=Subject:To:Cc:From:Date;
	b=EDaU712e008XQabb0RRKH7xYIF9NetVVcqUDwRk03MmArO4x8VVVc74wC+/pefoM6
	 A76uOe5nKc/5nCpxdJMddZgo3WkOWO53vycc6Q4qibLbatMlIzPxX1AX6lfETPdYMd
	 B/FW/3hMGFPU2aaWSas2vzLowAsI3HtEWgjTgBis=
Subject: FAILED: patch "[PATCH] iio: adc: ad7380: select REGMAP" failed to apply to 6.12-stable tree
To: samuel.moelius@trailofbits.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:45:54 +0200
Message-ID: <2026071354-cannabis-broadness-e866@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6697091b386a4e2830bdd38512c87a4befff2b32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071354-cannabis-broadness-e866@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6697091b386a4e2830bdd38512c87a4befff2b32 Mon Sep 17 00:00:00 2001
From: Samuel Moelius <samuel.moelius@trailofbits.com>
Date: Tue, 2 Jun 2026 16:45:39 +0000
Subject: [PATCH] iio: adc: ad7380: select REGMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7380 driver uses generic regmap types and APIs. However, its
Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config
with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
to build.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1c663c98c6c9..6fb0766ca27a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -328,6 +328,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE

