Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045963;
	b=ALqaekcIKXN7yHr60OrUg6LRpDwPiaLqgP43W1EgJohCsjK5vyKZDhT2t/py4OliJKYw
	 rSX6+ood7ukXIlFm370S+ftk/Mo3+YM6ulTV/x4rgocTKAM27k2OBR8zpugPVQXGLzL2c
	 IP2DZOtSWKvjOtO+v1tp/E/dmAwydyaeFHJrusPxuw8aq5lcwjZPVHp0rENs5vOjE333B
	 kAHOfxF0Hg0xf50Cm8OQFmx0n0ghexVhSwjDMAlgQixtkSbqpUzicNJf2DkyIPqiVvB88
	 Wd9ccYMBIasxa9tvvGKCawNKvyBDs+dY0UKe6dHHJfehm8E/eoX5cQe+8GpOcJZZXrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045963;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vAzM7539j0Bacrj8JuNSofhJQ1E80CBL+Iw0ZG1Yy3M=;
	b=CZgGABlqOYoOJowG9Gk5pqJwO+sGUZLj0SnwilYu7Uidkew39J5QFKP5/N2XfgqV15Ms
	 /i95XuLBW2smmnr/YFp7kVpIxUDEsLR3cfvzOc6u9SjENKYlNtlFqNef3ejwSWXWnMS5s
	 YxQCvbW0g8COW2EGLRsxNmkQxXY3gkslSp9m0EnBTM04UtjL0ExnHrjvHl/mBgraWnPOt
	 k1Cczh9TN/Z7aiaFBMXJC2MFLnnvCz//bzLIUo/bKbAUzlCDBID3h/l4B2dme4DlibXS+
	 QlL/rwISdPt26NPd/qZMDjv4BvuAjeRYjkk72gpTdCRfMX21nTtX1Xu2l1lW9pD3e+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0uPrphF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0uPrphF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CB51F0089F;
	Sat,  7 Nov 2026 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045963;
	bh=vAzM7539j0Bacrj8JuNSofhJQ1E80CBL+Iw0ZG1Yy3M=;
	h=From:To:Cc:Subject:Date;
	b=J0uPrphFqntp0nDguAMP7Ac0WIPcKG3bdrJaDaudVD2tQHWct7dKF+xEkplUnVpow
	 01hL6VfSzTuCSWW0rENpWa8RdVb7TB81KIpiZQtXofl4gZWghe/qJVumpcUqA0Kaqq
	 2pRT1tSz0Qn5CkzkyMN15XVmPxQ58BJ2ddsQef1wOi1z5RXSAXV8rkAQrcRaUC9Clm
	 7v/k+3MjYausZJpJ2bbYJUnUPVS0M9gn5YW7Yw1y6qdCF8JyXAiCYhhn7LT/6rIAgD
	 jAnAy12M4VQ6N6Rte0q0W3OkT2leeVrvRqgbF3I582mh0gTtEgtmJTMPTHgtLA1z/z
	 Iph1EtTTdkQeA==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:01 -0500
Message-ID: <20261107050601-failed-6.18-8a9bcd587d7d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050601-failed-6.18-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a9bcd587d7d768e6c8e9fff88bb89645e412731 Mon Sep 17 00:00:00 2001
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:53 +0200
Subject: [PATCH] iio: light: ltr501: Power down chip if request irq fails

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index fa0d16890c8bf..b36bd10a02624 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1538,7 +1538,7 @@ static int ltr501_probe(struct i2c_client *client)
 						"ltr501_thresh_event",
 						indio_dev);
 		if (ret)
-			return ret;
+			goto powerdown_on_error;
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
-- 
2.53.0




