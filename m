Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816548;
	b=NhFUDRB4Z9+Fn9l/3SoQwKFcFB7+MVnDCw7AW0SM6I4mBaj9FzY3KemuTMRL2shck5xx
	 uycRIA82iT5MgrDUNf4vd6z16Wuwd+kIfvEs9E1yoZLu25NrCRppNwcuRMNQN1ONycKDd
	 CfdWVtrp9+tsm86JcxGso4p1z1c/5X84ryDA8gdEWEjRtoO5WUPgi6snS87Jn2V3HnU3d
	 MzAtoDjJBWCngmrSOhXvv7a9zJB6xOCHuPumGfjraeY3MEv25ALygpMJ1MM07DgkezFOr
	 yMiqjOgA7MpdfY5IsC0uWdaKV2N7kPsmTYtulQAQo3X6Ji8HHeEi2arNtv1OBatqfDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vaB6oLPbLkGRXSMYRZDzlcQ0AUYB6IuU3IAgYH5nTEU=;
	b=p//sl6hMWjOcxS4f97n5hwZ20NBZUWCuLpKEB7xg5vJ4zcDWQnzYzIyTYJB75QLPwkiW
	 2UZUiVn4H8fEhZUZSqIjHeD13zwvbmu4REuEY0XQNDBX0XMIGeTscW8Mt6AXwYFKl25Ab
	 U1iHy//MVX9BOR93K3fZLcO4L43CQrP66CfwkIve/MDWi6CEvHgu3qQJ4dnW7mi8rj7c3
	 gyL6PgMDNtq3Nd80aYOgqLMUF5gSyALM81Ln68rG30uGAHXuvg6Tf58ZpJg49svZDJiAu
	 oHQ1guusR+sR1GSz5mB3swnKO09sUoJ0Z9Hbk2vbfL5P02VKvKEzLD1+MGLIq077eJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W0hLQp/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57C606ECE9;
	Wed,  4 Nov 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0hLQp/p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1D1F0093A;
	Wed,  4 Nov 2026 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816547;
	bh=vaB6oLPbLkGRXSMYRZDzlcQ0AUYB6IuU3IAgYH5nTEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0hLQp/pfHAIAPAEXaF0k4r/yhqrjHEnM+vAGr/TrMRiNxayTcV8VkQ6m4kJczGfo
	 mq6YyWakjebYL7CYN9/fRnTjz3mlleN/fAlSkPver1IQEvNAlFEuTgNP98yXG9H6vG
	 CLXweK6+J6/8qNhOYJ1b9fI9G7mTnmaXWfpLfgm2L+N5eoaKKMwgbvwMZqqXVKdJ9v
	 +wFtOiRgU3IX/mB5dIwqP3/7QTO8SYzOTWif3ENpudhc4ofLDQv9ssfU7JPJYka4SJ
	 BizFXNVs6aYD2P1ZTHbvG4GT7sWc6LP3/Xr+RlhR+q6I+NW4L1gvQORjp6SwN5opvu
	 N5q9bQIVbockg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] regulator: core: Hold supply device reference until constraints are resolved in regulator_resolve_supply()
Date: Wed,  4 Nov 2026 18:20:55 +0000
Message-ID: <20261104182148.1176116-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regulator_resolve_supply(), set_supply() previously consumed the
caller's lookup reference on &r->dev without taking its own reference
for rdev->supply, while the concurrent path (when rdev->supply was
already set) dropped put_device(&r->dev) immediately after unlocking
and before retrying set_machine_constraints().  In both paths, if
set_machine_constraints() fails (which may drop rdev->supply inside
set_machine_constraints() or race with a concurrent task in
unset_supply), the error path subsequently passes r to
regulator_lock_two(rdev, r, &ww_ctx) without holding a guaranteed local
reference on &r->dev.

Take a dedicated device reference for rdev->supply in set_supply() to
match _regulator_put(), and retain the local lookup reference on &r->dev
throughout regulator_resolve_supply() until returning.

Fixes: 8d38423d9dea ("regulator: core: don't fail regulator_register() with missing required supply")
Closes: https://sashiko.dev/#/bug/linux-3a22ff58-1a66-4a6a-9e19-83135ef603e0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 935fee27f126..6d522731e4d9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1842,6 +1842,7 @@ static int set_supply(struct regulator_dev *rdev,
 		err = -ENOMEM;
 		return err;
 	}
+	get_device(&supply_rdev->dev);
 	supply_rdev->open_count++;
 
 	return 0;
@@ -2290,22 +2291,20 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		supply = rdev->supply;
 
 		regulator_unlock_two(rdev, r, &ww_ctx);
-		put_device(&r->dev);
 
 		/*
 		 * Supply resolved by concurrent task, and constraints set as
 		 * well (or not required): fast path.
 		 */
 		if (done)
-			goto out;
+			goto out_put;
 
 		do_final_setup = false;
 	} else {
 		ret = set_supply(rdev, r);
 		if (ret < 0) {
 			regulator_unlock_two(rdev, r, &ww_ctx);
-			put_device(&r->dev);
-			goto out;
+			goto out_put;
 		}
 
 		supply = rdev->supply;
@@ -2342,7 +2341,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			 */
 			regulator_unlock_dependent(rdev, &ww_ctx);
 			ret = -EPROBE_DEFER;
-			goto out;
+			goto out_put;
 		}
 
 		ret = set_machine_constraints(rdev, true);
@@ -2364,7 +2363,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 				 * that again via unset_supply.
 				 */
 				regulator_unlock_two(rdev, r, &ww_ctx);
-				goto out;
+				goto out_put;
 			}
 
 			unregister_regulator_event_forwarding(rdev);
@@ -2376,11 +2375,13 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (!do_final_setup)
-		goto out;
+		goto out_put;
 
 	/* rdev->supply was created in set_supply() */
 	link_and_create_debugfs(rdev->supply, rdev->supply->rdev, &rdev->dev);
 
+out_put:
+	put_device(&r->dev);
 out:
 	return ret;
 
@@ -2391,6 +2392,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	regulator_unlock_two(rdev, supply->rdev, &ww_ctx);
 
 	regulator_put(supply);
+	put_device(&r->dev);
 
 	return ret;
 }
-- 
2.56.0.385.gac671c819a-goog

