Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B62446C15
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627461; cv=none; b=PNj3+keSzxfXAkvqPVSX4saLs7uFVC0nJHi/WkzsMHEPYj6JoSU0Lvmzl7XghobS8EQ2rHzlHU/4GGvpPbHCueaPtJ4W38lYIHKhHgH77FgGona0DAgrL2qQ3Vxiz0qd3i0fM6HF9Lwz42Faavgx1uxIdNH31HFsERD5b7fSRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627461; c=relaxed/simple;
	bh=XPDmhcMCAHq0WKJRnnBzDPwdIzr0zk/lyONdHSeLz74=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LS/gyUwulWZ7EPNpo0Q6Tm8FdiAP9DUlSaVmgZoiKfoN+hLjtgrNGVVwrhPhakSlI39eNu+ID+/oSWEjsIGp6NQDGzxYLxWbMjlM/rEBQ4jYL9qe269IpnUjCGmqOJSPSTLUidOxEtZ1Gmj9D25hgG30R5srFkC7CG5P1cCA4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POzv/Gsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POzv/Gsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5C1F000E9;
	Tue, 21 Jul 2026 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784627460;
	bh=DeMiaLvbj7bYBCFAosnVDDrvaTDz68ZcUx3mvvk4/HA=;
	h=Subject:To:Cc:From:Date;
	b=POzv/GsppCQps8pRBlI1gg3NfiCzX65oaK1HeWZysPaC4NVlCuZxZgPAnaMsO2tLx
	 TffSFySmfjw4Rn4Y0jocNobStF/yD5iXCFVvQElOHZQTqZggiNWDHyjGcRZGTMlmkZ
	 K72V0GjT24EzHpaxmbXIYrBCMdfnYDZDjo56vAvc=
Subject: FAILED: patch "[PATCH] mtd: mchp23k256: use SPI match data for chip caps" failed to apply to 5.10-stable tree
To: pengpeng@iscas.ac.cn,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:49:12 +0200
Message-ID: <2026072112-petite-humorist-7144@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d322e40f4edf92bf0ca329e5aa4ae1c0316feb38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072112-petite-humorist-7144@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d322e40f4edf92bf0ca329e5aa4ae1c0316feb38 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 3 Jul 2026 15:40:52 +0800
Subject: [PATCH] mtd: mchp23k256: use SPI match data for chip caps

The driver stores chip capacity information in both the OF match table
and the SPI id table. Probe currently uses of_device_get_match_data(),
so a non-OF SPI modalias match falls back to mchp23k256_caps even when
the SPI id table selected a different part.

Use spi_get_device_match_data() so SPI id-table driver_data is consumed
when OF match data is absent. This keeps the existing default fallback
while avoiding the wrong MTD geometry for id-table-only matches.

Fixes: 4379075a870b ("mtd: mchp23k256: Add support for mchp23lcv1024")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index cef5f9677d39..66e058df4c32 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -188,7 +188,7 @@ static int mchp23k256_probe(struct spi_device *spi)
 
 	data = dev_get_platdata(&spi->dev);
 
-	flash->caps = of_device_get_match_data(&spi->dev);
+	flash->caps = spi_get_device_match_data(spi);
 	if (!flash->caps)
 		flash->caps = &mchp23k256_caps;
 

