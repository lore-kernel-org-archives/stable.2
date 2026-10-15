Received: from out198-29.us.a.mail.aliyun.com (out198-29.us.a.mail.aliyun.com [47.90.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8394525A96;
	Thu, 15 Oct 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068009; cv=none; b=dLbYuR/Ps6+gaKSdncGqayOYutIBNza7Ngu7pXw5hurJ8DZ/4noEEmyWc+O4M1jnP1IT3rBHbafmSLmhr7eFuBPWTwPfuxScOwbcaiSf1l0EHnh+LG8AEETMjbiYPg7ZFKPxgr2rWcjSJh0MauJqF/4nT6uZzI2GcWAmQbBZcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068009; c=relaxed/simple;
	bh=pZVExG4snKz3MfMYM2U0ZTXdnWpWL4PIR72QLsJfSZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=nRGRRoVcWp6mCcoI5T3Fs+qq0A91lWC1UimJ8uClwJ3ZGAEdy8cAb+cnieBnsIV86GfC5h+8ExhyzUlHWN+Ud6C4icFJEZVWziSrMhIGoqQwH3ZRcXuGxqDonI9xMajn78rLiKnwBC4BybQRgsDC9jfCaEvsILIDJSpz+5mNul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=WjlelCqW; arc=none smtp.client-ip=47.90.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="WjlelCqW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792067984; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	bh=p7d52w5knl6aTU8FnTsiPgKYATWg6M9jCczahrtsNRA=;
	b=WjlelCqWF23dZrf8YVfACyIM3PNIyJza/m7shayWDJ3bFzepkWm7bOAZa+FH90A1sN7wzLccvLFfBuhPFxZ447Gmd3Y+8yLqKLtQzDKv8zSCJp+8LRYcSV51bZNcJFAPRCk0gn4U+w/cIMnWfUktAbj8GNWP3wUIZz5OoJmFn1A=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07668576|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00357302-0.000210201-0.996217;FP=1006695008241323194|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jem-UDp_1792067983;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jem-UDp_1792067983 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 20:39:44 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Subject: [PATCH v2 0/2] mfd/spi: sprd: fix ADI transfer length handling
Date: Thu, 15 Oct 2026 20:33:11 +0800
Message-Id: <20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjI0GoC/x2MywqAIBAAfyX23IIaCfUr0cHHVgthohGC9O9Jh
 znMYaZCpsSUYe4qJHo48xWaqL4Dd5iwE7JvDkooLYUcMUduJI/GM1Ix7j4p4KStHISzWjoDrY2
 JNi7/d1nf9wPDD/+WZwAAAA==
X-Change-ID: 20261015-spi-sprd-adi-exactlen-96b130cb61ca
In-Reply-To: <5e662ac5-efea-46dc-bd09-88a5a4841851@sirena.org.uk>
References: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
 <5e662ac5-efea-46dc-bd09-88a5a4841851@sirena.org.uk>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>, mfd@lists.linux.dev,
 Guanglei Zhu <zhugl3@xiaopeng.com>
X-Mailer: b4 0.14.3

Thanks for the review.

Both points are right. sprd_pmic_spi_read() passes a word count to
spi_read(), not a byte length, so the v1 check would have broken the
only in-tree user of this controller. The 4-byte minimum was also the
wrong check: the driver only ever performs a 4-byte register read or
an 8-byte register write, so any other length is a caller bug. Short
transfers overrun the buffer, long ones are silently truncated.

v2 splits the fix in two:

- patch 1: sprd_pmic_spi_read() passes sizeof(u32) instead of 1.
  Nothing changes at runtime -- the buffer is 8 bytes on the stack
  and the controller only touches the first u32.

- patch 2: the minimum-length check becomes an exact per-direction
  check: reads must be sizeof(u32), writes 2 * sizeof(u32). This
  also closes the 4..7 byte window v1 left open on the write path.

On severity: this is hardening, not a live security bug. Nothing in
a stock kernel reaches the out-of-bounds access, since spidev is not
normally bound to the ADI controller. Both patches still carry
Cc: stable.

v1: https://lore.kernel.org/r/20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com

Changes in v2:
- new patch passing a byte length to spi_read()
- exact per-direction length checks instead of the 4-byte minimum

Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Weibin Liu (2):
      mfd: sprd-sc27xx: pass byte length to spi_read()
      spi: sprd-adi: enforce the exact transfer length

 drivers/mfd/sprd-sc27xx-spi.c |  2 +-
 drivers/spi/spi-sprd-adi.c    | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261015-spi-sprd-adi-exactlen-96b130cb61ca

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

