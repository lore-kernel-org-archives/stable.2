Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26513F4DD6
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562715; cv=none; b=NbS78wEL/syWizkbuB0M7Tj2Gu1YED4IWWvGwkwSFfBIaV+JmOTI3L08qzDKBze+G9Hdu1gU+zcwwiH+bS4vlyHb4y4g5Zx1uYj2BSlSwuhKDGAuEFRDbXnnmX9C6/2F14pJ0zBfu3i5z8i6lYJ+TXQMw0zskmk06eS9/qze5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562715; c=relaxed/simple;
	bh=MpqKOlMDwgK0QbfkYLX7UrhGFw6nCS529h4u12RE/ck=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JzVeaDDyk3Ki/OH0cP50ju3DkJWD15BZiVhyZS3lFn/fLqXyKbe8Sta0z/9KcB15EIZTnR/kK7IRU24g/DNNCuQpSJJ76FWUXR+38vQwdzuqQ93RYtCMaQBSYv6dUBWQ4sbuwGOXsmk3vdtMg3cZ9BYkaBNZSOv1B64FeMxuqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fwz5eFNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fwz5eFNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896DA1F00893;
	Thu,  4 Jun 2026 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562714;
	bh=AQGgfGri6yyLN+m2S36T+zTHGS+2Z2FLx9KeRz2xuMU=;
	h=Subject:To:Cc:From:Date;
	b=Fwz5eFNC0FrhYVCW0L4okVk67PSt6+/k1bTmLFVSm2opnVF5lZ/VxBskiB2FZzrbz
	 M91aNdR4zaN4jtJHt3IKw3GVF5Qo1KQKUPb7yqq1EdbfX5R8At8SKgMZcly/HV7V/8
	 ZePmhWqSnvq2jxS0Ieh1+cYGJnwpHr/WHZhNrRBM=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: fix ref bit initialization for" failed to apply to 5.10-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:44:04 +0200
Message-ID: <2026060404-armory-omega-643e@gregkh>
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
git cherry-pick -x ecae2ae606d493cf11457946436335bd0e726663
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060404-armory-omega-643e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ecae2ae606d493cf11457946436335bd0e726663 Mon Sep 17 00:00:00 2001
From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 1 May 2026 10:14:54 +0100
Subject: [PATCH] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts

The reference bit position was ignored when writing the register at the
probe() function (!!val was used). When such bit is 1, internal voltage
reference is disabled so that an external one can be used. For
multi-channel devices, bit 0 of the Internal Reference Setup command
behaves the same way, so AD5686_REF_BIT_MSK is created. The issue exists
since support for single-channel devices were first introduced.

Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4b18498aa074..b85d5c5a864b 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -509,7 +509,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -520,9 +520,9 @@ int ad5686_probe(struct device *dev,
 		return -EINVAL;
 	}
 
-	val = (has_external_vref | ref_bit_msk);
+	val = has_external_vref ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e7d36bae3e59..36e16c5c4581 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -46,6 +46,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**

