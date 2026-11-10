Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314375;
	b=UG4zA3MYFXfyG+KtPegeUG21KTu0oGuSvrxsrw+bjx3IEC+QEWfipzlSzNH4+X91BZ81
	 H1eM6o4KlHvmMav1r0F2/euqgDCMdudMRQ3tQugXWtkYt3W62Bn7zWNBSxQJ1Cps1gEOf
	 UElL2QKhG+lEKRlVvRv6+DUmZ93DljNeLRp5J0k5Cfvn/aQFvgWLc+KNg6TJVsNl6WhFN
	 1N8Vgh+KY3I975KedE7I8f6v5YacD5tlgNwmnzC183l4EpK3XUFWkxzjqPkEiF7dZdRI5
	 Zd4thF8dOwLzUtZ4gAZPqJ7l3lyuQBVGJ2fGWWCn6LTQHEadCvQUk3Q3+yxykRoKOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GNIyCWiNlDkmYHTv0ugkdYDB1QMy0CTFvKBVgonEH1c=;
	b=Z66syP7SNrKQr+SItaXPdDZw8V1PO/srwWmae4ZIgtOO7y55FkIIdUrx7hfIFzvZu+OU
	 QDgdKh9ugDwml2AyBP8sOofyaZIsyup2VI0rhyrpv7GzGVUo0OhtmsZ9YEfsEmha+Ks8m
	 Kanl1mfLI046CmQ8b1X/A1+kcsSem0BdP+OYsMgc6mOuv4lIEpnCq0kQiLiyIRAF5TGKC
	 M8XNutu/zn0AgCCVXFHZrLVioVvISR9vEDDq2KQb0jNb75D6XQaxuc6iVIT2QwiclCY5d
	 +Tx2wJGlSjgvGAQrGVkFGC4L7DAFpbhaVq0vHX0ZEcR5bskwUA9LSsdT95vC6t9hu4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTE1XWnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F1606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTE1XWnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640981F008A1;
	Tue, 10 Nov 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314375;
	bh=GNIyCWiNlDkmYHTv0ugkdYDB1QMy0CTFvKBVgonEH1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTE1XWnS8Q8FlUYmfeOvtfdK2xu6GX8FfD9f8vh63hiIPozPB5rFjwJl2o+SJFgfz
	 xr8xN5ikiCYSpB3hUHUZSRFGKxlGBEvhxCLZ8jaKR7jYzdzMLWk9nqkQotzqpJA3S8
	 +JfWb/FQkDusd61vc5E6cDeetw+VKL3FzPNhg9Z/+PKoFE6AM+6ynEk/9yqP7F9N+C
	 IEbyImaEp5OanXVb9gfxLYLeL5HH20rr4XJnt+YkIogEriV1m9mQmQFMPXMVVWonhy
	 hCE+yShaSspI6vzYWk9LA3oTpZb44u2KA39jXrb9bLKn+JIcWc7VufTrGUAV3KlxsG
	 8bBqAAMqHi3hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: hantro_drv: Convert to platform remove callback returning void
Date: Tue, 10 Nov 2026 07:39:32 -0500
Message-ID: <20261110123927.1392922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054409-failed-6.1-8e26d4c20ed2@kernel.org>
References: <20261107054409-failed-6.1-8e26d4c20ed2@kernel.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit b9294ba9285e555e0e6daafac95704be4a9125c2 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 8e26d4c20ed2 ("media: hantro: disable runtime PM before hardware teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 29baefc93628c..df81ca3903ca5 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1183,7 +1183,7 @@ static int hantro_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hantro_remove(struct platform_device *pdev)
+static void hantro_remove(struct platform_device *pdev)
 {
 	struct hantro_dev *vpu = platform_get_drvdata(pdev);
 
@@ -1199,7 +1199,6 @@ static int hantro_remove(struct platform_device *pdev)
 	reset_control_assert(vpu->resets);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1222,7 +1221,7 @@ static const struct dev_pm_ops hantro_pm_ops = {
 
 static struct platform_driver hantro_driver = {
 	.probe = hantro_probe,
-	.remove = hantro_remove,
+	.remove_new = hantro_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = of_match_ptr(of_hantro_match),
-- 
2.53.0

