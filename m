Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047296;
	b=zQt543NLz3/QEvZGYpBr+1k24vtKfzVoYv8+l8MHCW6FD0ObBf9btMn+Zj1Vdez8kwsm
	 JRpjf4tUcOGk+titv08UOZWj0evkgvIkFVnK/rf3rk74/+9/OURHWYcISK5gRhaGyvL/2
	 xA1gDA1CGwEBGGcKNtwgGK8iaA0QwcX390C2Rf9NyZhPTWWE5l5AvtZ/+pm3b112yBm21
	 Tb0KPMUvN1Ra03LorL1uD8GmUWuyloUYvycTv7Lhs6uiUwbsjLqvDZVCwmZwX/+AnReMr
	 yBZJp6O1lFZVdnVEezKd+xZlh8yTkTJiT2anaN6O71QeEk6MAhjvDNsRrY4Gy6dRiuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9r3xp6kRhLktNDSGPeHY0od+LUuthNnWpyZ0fmIKZ/U=;
	b=uy1vvkFjvtLZqlUJG/ysqXsP378cWEBbOPjvGRqzUM1tTCbD9ljl9fHx+3K+t45RAgl/
	 6mtLh+NsGqdLYZS9Mf2IgrDeiuG7GGcHqRRBfi6/yDtcRzoUp7oBOll0R+VipoXQsSKIE
	 2kWXsOD91eE6lD3Tx2ec4uMTxcrboshIIfzznW4itLpHtmYoPsE62g5sZafqUEY80KGEu
	 x845EoZCepqg7z0ppc8ut5R4tWdxcZFHlApMYH/jWo95n5YN4JwqTdKs2FtLlAlFpnx6r
	 uI3RwtkfeNslpntLGJStKd4oR/Ow8JD/A89S4T8X7xA32B5arhHN+lqMxtdGJrQqVxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTFuPzdv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTFuPzdv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AE61F0089F;
	Sat,  7 Nov 2026 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047295;
	bh=9r3xp6kRhLktNDSGPeHY0od+LUuthNnWpyZ0fmIKZ/U=;
	h=From:To:Cc:Subject:Date;
	b=bTFuPzdvYfj104tvhf3rJK3w5xA8NDGx+VuAaGK0bQCnf/xpiHu0Nkr2nGmH8Qya1
	 ZHtmn8GIchjuJSWFUs9x/Le8M3ilA+gyBORFZqqIDedXCCzlmvAc4JmdpJwwDeoSEl
	 gD/ypa9aHpwBWG+9OEftdWCxYk6q9lmLy7e60DqA8NL+hcoRmC/BmDe5T0Sq1Tm+6X
	 3vn+oJqbeiL/sffm4VXDcKSf4qSrfsKuwkXdUi6XzEIS6jd3HShVU8tL9AYAISYquA
	 NLYbSry0AlY9b0x5XaSVC2xp5YTkfpf7LO0ReMhln6XGO2AndNTM2GHWs7aZJAmWiy
	 eqCy/Yci+00rQ==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:14 -0500
Message-ID: <20261107052814-failed-6.6-8a9bcd587d7d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052814-failed-6.6-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




