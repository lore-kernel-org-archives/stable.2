Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6D3BCD39
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562708; cv=none; b=a5/edcoDAHFtLfAFzbRZ/Y2M28ujghrbIfkcINS0eB+x+7Z2yMfpRR1tba0PG9RgftLoFf/OnQT7tcQbas3bkpgqo6jzVcB9w1tkGqFokXuvraVkuUzz8/JaYmzFeGEDfZQh57rGswxpokYpmFEDYRQhoBnJg/bL8STEv6TbeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562708; c=relaxed/simple;
	bh=J7PKiYi6pn44SV7bHeQ9xlc3FDO5MCgy0EpwUBH0lUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jfhgsCJ8HfJk6V1NH/FDriBpA8aKJPIUi7p0m2fwuJzpTNgiWNObOVHU3JY1ui/V+uAIL4PsWTMOEks1X7yoKMjfhNnh9VoBa1P8ceR+yK+MMsVWxVb8lwQ+QgCgZSxBZlUCxcS10vIy9oveNPKX0wBbgjfoPiv4fXl6Dj5FTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Brfv+kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Brfv+kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8391F00893;
	Thu,  4 Jun 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562707;
	bh=hDy8U6ZEzU6y8vqJXWEi+yx50+iJuycfwIcoAzshZoE=;
	h=Subject:To:Cc:From:Date;
	b=0Brfv+kIMJD16G+l30J3DFg7F91ZSt1Fwf87AyPkFaNVtOnKZKN7z9StfQ0Clvglx
	 X09ZltBFD1bIN2zUsyLE6SKKiDzJOlyZVQn+9TDiKVj8tmavyYnmjmJLmur2ttICLw
	 VrJeXdw8BklClVgQuCETmKkhEx3sfISBEzKVO2ak=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: fix ref bit initialization for" failed to apply to 6.6-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:44:02 +0200
Message-ID: <2026060402-peroxide-remold-68a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ecae2ae606d493cf11457946436335bd0e726663
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060402-peroxide-remold-68a1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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

