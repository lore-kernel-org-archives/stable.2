Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA83AA504
	for <Stable@vger.kernel.org>; Thu,  1 Oct 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859451; cv=none; b=H9s5xJLoyF8nkyiDELh6Atl7w9FNCmVzoBq9BU4NKGp/Yr3/ZQDRRx6F/HVuMadanFytAuoaveCP5mcIEWqshHS8BS3osOsj+/1JDJlCxfW/+AchQxgrnNg/M2I5l6yh1zojow1b3CRmvHz9AhmPifjVYsY+x+cl+8EtkoOZ4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859451; c=relaxed/simple;
	bh=D9PCs5nmXQmYWteBwakFtmdqSIZutRQGJbRYW7q1hpI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=L5fU+w2g+uCgBZUbR0rDFJ3/LURMLutzIeLiTrUYBHKJ2IyFI1GRyTBZBR8Dl6wD+TFzSJB9BfJVC/eicOBExkigW+TnUftfWgXnbBcwh1dY6aDe4+sNwR9HHQMiaMAXcSIQOfbobZqEhTtJ9bcSsdFCisvAvYvXYahCfjpZ6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZBHYBgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZBHYBgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560931F000FF;
	Thu,  1 Oct 2026 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790859449;
	bh=Ca3+HFn5kbkCU+W4NNH39t11UlVs2oJHla1XxPFLLjs=;
	h=Subject:To:From:Date;
	b=UZBHYBgXjKd5QZmALJphz7rO+ejCWkYKqe3jpcQNOmdewKfVu6GjDN68ZEqsZswQY
	 C+117T2ycKu9y7r4abLiODHKCTsrp74sc3dv3lc09I7QEbsvocmdAGK6FhnY0XuLjy
	 m3/OHtRmOEgGuZYEnLLVCkxnkieANTNsj44PtQec=
Subject: patch "iio: adc: pac1934: check ACPI label duplication" added to char-misc-linus
To: bolin.liu@seu.edu.cn,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 Oct 2026 14:57:23 +0200
Message-ID: <2026100123-stout-dilation-e513@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: pac1934: check ACPI label duplication

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 64c82e7bd9c82b0c9276297df34a3579e8658f55 Mon Sep 17 00:00:00 2001
From: Slavin Liu <bolin.liu@seu.edu.cn>
Date: Sun, 13 Sep 2026 20:51:07 +0800
Subject: iio: adc: pac1934: check ACPI label duplication

A label duplication failure currently reaches the terminating-byte
write. Release the ACPI result and abort before accessing the missing
label; earlier labels are managed by devres.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/pac1934.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 23055405a6e0..de59dc27c440 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1108,6 +1108,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
 				     (size_t)rez->package.elements[i].string.length + 1,
 				     GFP_KERNEL);
+		if (!info->labels[idx]) {
+			ACPI_FREE(rez);
+			return -ENOMEM;
+		}
 		info->labels[idx][rez->package.elements[i].string.length] = '\0';
 		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
-- 
2.56.0


