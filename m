Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048047;
	b=TvST6y6XMFISq0IFmw0kRQFDrugTld93RxQKBpOxZ54MP6MU4uLSyAlP4g5QAUUGi0kd
	 xFOgo20gzcjMIg8/466L2yD6Ku4aTMmcB8cNxlAgNbvQ0zbTsBo13gp21P1VICY21tdbm
	 t1Fl3vl87w4D3TGxHLyTSQmGagQmGf4ecx9fi5jVcqdpfZUT2dzRsq0dMuMrz4wtpCN5W
	 N57WAzeiuZ7a62HNCqg0JyLuPctg+DhY9qPCjMH8EyO+P/6Tcf0j+eCjQxqG3L85SbkwK
	 WAiPcoCBCAQnXUKrrwSSyME6xeSyrduV23hkUMLr44AbpuxH4qbgTPsvHiReL8a4iMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h68p9WKN0OPMDhPEOux2CwMMZ2BX//hVACzDRKBIr9A=;
	b=XAEJaOQOnkly2B5obAqT28RiKaTi0mmphoRfPf2wg5MLTIMuo12twOMeMww5spsDRFcb
	 DeEf36DUiUfrgaNrkoX/Ujm6ztaQ9/hEA25JEk2LW/VJqRf6AxfnKIXG+mAsCSBWPXTdd
	 11+Ss0tWdpEpwGetfBsfW0uBhbICIWzpCcqkLRhqF6EpXt66Xqt9d0Hy8KuMGYUPRVJGR
	 BsAGOwlDoL4mJCuef1iUNRZ53SVm8eK9zaONNIJNsRYszueYxr/2FAfRWEk7n1rkI3JYR
	 I8i8P1IBE9EAtoWFTeeAGR7yLyBzQvSupGmLQ9QAJ7ZJhrNVFSKTT2HDKvCoeRlV3qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfhTGHSm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55E606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfhTGHSm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775261F0089F;
	Sat,  7 Nov 2026 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048047;
	bh=h68p9WKN0OPMDhPEOux2CwMMZ2BX//hVACzDRKBIr9A=;
	h=From:To:Cc:Subject:Date;
	b=CfhTGHSm6wVhzl5X9qrWz27TINEzB5uICmzXX+/0+PVUiu2onhD3AXfWC883xI121
	 uIa9wlD1kE8sQnnMlXE8R7/8zfmB/1jQjvEtcpd8Qcu1tyaTwNG/S/XeEJvv8HAAgC
	 d1sMfppjHb/LUCRXO3TqJTI3uVQruWh3vljeY1ulE5kx4g1GfdmcOWXILIwQSdG3CK
	 bVkLkrmPVdZDr+MkCvOM5y1/MY7+YWKupKOZtRdLEhvMn7JQKXK0Em4zTHQ36JAqqV
	 Aw80UiKvAJhqdwES6QqlkL+S56tqd1w1QXBTFkeLxXfhmWO5rceuDSR+dD5nqbgVdT
	 NwO6kyfVgeYEA==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:40:45 -0500
Message-ID: <20261107054045-failed-6.1-8a9bcd587d7d@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054045-failed-6.1-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




