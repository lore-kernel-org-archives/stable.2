Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050057;
	b=AlZe2qlnK+fesN4KfzGE0A80ch2dot3d1y1UMCYUMtMiVmHoyLk5mumUEi7C0n93e83o
	 u/lksPbQ92O7ni1ZDIQx72byxy7g0EeGNe9cL34PoKs9f0rvrXW858+4GmOHTbDFXZ5xT
	 Qg/wipPFXKBjQn7ShAUgq4dU66u7rOXRQJs/ilm3QdLpNaaXBxT0sQxHA+CaLlDo2F+uN
	 jhJ0ZKGX3gJCjMd3RhgKcL552xMQB0Rk5sF5eMUOo7s2f7duAxsAP1F66qqWkuBI6MQox
	 b48Lf+jyvdVVwCzfjZU22Ct23VDvSyMjh7ieZYob113Xr9+6sNKOxWDXIDTBKgOuYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hb6fU4IwSlWnj+ofxNMji13CgNzIz7K9bjPJFCjJ2MY=;
	b=CksegrFLd0LTSWFxDXFPdf2a6h1/6+DrV/BoywVtLPpsCRb9jcfX/GRnsLv2polEs9B0
	 R63B/MPau/D+JlRKyqus2pUw/ZTvJS81ipPVrn0yg37wkETyPWYFvvV0oIO8Yiw46IUAu
	 aU35YdfhYPc96U9p7bMlYVstYahw+rClXr4eUd2XdNAyK/hhawWRsmM2GRfu3mVLUEXtW
	 3kps306TWbHEaebz4c8lUNwhcCxQsZ4dzamSQamEaoXHXPxRgebRlFzhodY9ezBNT+F8E
	 uTipobD8AcE3XaQKysREYpeEoEUf1uZ4gtPax1ZR/HYS4DwdmU0Dl7bCrNXfD+/9gqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dV5McC7U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA35606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dV5McC7U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E09D1F0089F;
	Sat,  7 Nov 2026 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050057;
	bh=hb6fU4IwSlWnj+ofxNMji13CgNzIz7K9bjPJFCjJ2MY=;
	h=From:To:Cc:Subject:Date;
	b=dV5McC7UZIKr8W5iKooId1mRAAewe+4ZqX3M8oIElkb3CTK6a7JzLHmhzFNYP8+RE
	 Ru0QSlVjULTKvDT/pNv7JYr3awE479MVlYYse1gSdQjXq5SI4isHqjgqJwebmK8eq3
	 HO42XZ5hha8hmPVqcRnyGC67P21OvLRnEpJHLsKRcXUaHYC5GvYZY81aQL2pgJ/JWH
	 TNnjddBFRzgO630cSaFJCGMe0WNYfZweqvYIyzdfp2uLZGwKbMYkh3A7a4Uec0/AK/
	 pEgj64C/a5eq+OHsn5bHOst5YcygioUSPdiBnmso4usrGfovzU4saYLDfzRfcB2H/0
	 GnwZq+ctvbwng==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:15 -0500
Message-ID: <20261107061415-failed-5.10-8a9bcd587d7d@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061415-failed-5.10-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




