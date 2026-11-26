Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713625;
	b=AyXmEYddwUkegOMAW+jUmzyaenrXalS4eklzHCM1uuIKgjH6uSaYfTRRu0fAKWO5jh5J
	 TgwfTRRt+P+ggLoxTzxQZ6BxFOX2AaGPGyAvVkM10GXiu2lGP8lYs3QvuYreyaVOpvotk
	 nYzJEdIvjp74BR5fwMxYBQVkuS3Xrm0J+Q7xxuJ5dp1Xz7lxaeqdxeLF6XE17jkbHW8rJ
	 pUmSQ6TitMu43muz/s3hOb6TvR1kva736vdFX45ksWlhYOxmqUUIvt2jyanlFwtC2d568
	 4CcvRUK6rQEJslqWop12Bwm7YjFOtXkaW3OSXQwMP8vbcHl9Jqrn3q1wxE7hz1rxlWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gn5cVyChJgKQb7V1LTTPvHXalylht6EjUj0JLXa2rCo=;
	b=CswDXu01Tt1SpVoG13CcZKZ7BpG8mgY6/DOoblWxFjLodQOnLQVtaeJcBn3hzhIgIg3O
	 /FGfuPRl97i3LEAImLDNwMdczwvm3eUSeWjJDjIAnq7OEFj7ksEpePhDeGhLeLF11W+eb
	 1UKXMX+N+09C4P67/mH1yLt8bWK6TwpXpAd4FZtwHVRMBDt2TSfjYhvcLo/F6fhrGcuEs
	 WiVFOhx9nR4zWLfx5G93qvK7XoSCZAalzGYXSWYx6EgGi0USKnTD+h1/zcBOgNOGXbVcI
	 YVn08rkU9ZW/NufHe6iiMFVzMnUPUlTY4blWyZbwgXXbjPtRTLEHFwF9gfDiKV4w8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PZLkSM/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E60606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZLkSM/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660C01F000CA;
	Thu, 26 Nov 2026 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713624;
	bh=gn5cVyChJgKQb7V1LTTPvHXalylht6EjUj0JLXa2rCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZLkSM/39utAlnofTo9nweI/5OOP/QwcdYLK9AR3pwbwTziAR5Kxen5udqRqRlURr
	 R5wMCloxKr8jw3bS+jopwBjhaQI7YucG0JRlrK0o86cQjCrorGwiIoIX4QUbBL1i/0
	 pcHKrsye4cTs581RjpUwSrbzj8LytREizChs4273MulAIEUvNjDO6fNFzqzC94xvQN
	 M7DmmOZb/fVAiNc52BZ5i4wrlstf9qY0hC7n334Ds0Fa5fuXmLMMurOCyXOQoDhDUI
	 4E9yZRyqDTUFinmKPMwx23lLYpSvLY5gXD/u3rNwlfc+WVIuJv2nT6po5FwKb4CJiO
	 UKFrSZ3iYD30g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] iio: invensense: Prevent possible integer overflow while multiplication
Date: Thu, 26 Nov 2026 12:20:18 -0500
Message-ID: <20261126171945.2727003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-supper-bakeshop-1212@gregkh>
References: <2026112538-supper-bakeshop-1212@gregkh>
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

From: Karan Sanghavi <karansanghvi98@gmail.com>

[ Upstream commit 6dfc256151e842fa894a2b579f9a4551c6961e2c ]

Typecast a variable to int64_t for 64-bit arithmetic multiplication.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
Link: https://scan7.scan.coverity.com/#/project-view/51946/11354?selectedIssue=1586045
Link: https://patch.msgid.link/20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 3785dffc7c68 ("iio: inv_sensors: prevent timestamps going back in time in transitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 37d0bdaa8d824..327f456b53c5c 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -109,8 +109,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 
 static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
-	const int64_t period_min = ts->min_period * ts->mult;
-	const int64_t period_max = ts->max_period * ts->mult;
+	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
+	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
 	int64_t add_max, sub_max;
 	int64_t delta, jitter;
 	int64_t adjust;
-- 
2.53.0

