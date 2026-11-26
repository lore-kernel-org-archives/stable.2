Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714194;
	b=DRM0ST0tnxeXXaPN9BmGKJBXRfcw0yiYJjdv38wEf9fsmF/PSwoPhm5TybbAKjM56Oya
	 wX8fqNMbOwFrAqOqP9dU+rFylfL8uFHcUk4yj4gXdJ1ZtfO1LyMAHT0BagkkuUAPJ9FNO
	 aFv5xDsuUGk7yH0/RmRlDRMuK0fjoHxCS22pJx3gm2c7hUty/Ij433HyRdf7Z45FvP09j
	 kSLz+b9hbDA2j4G9IMPvDvQ7DrZBfZRPWfRkobARek4HAsuTe22mz03zMfuLuHdEFd/JO
	 W1xpaZFMNWbPzzU3/Ct7mcC5KN56WkTZTkCHIpdZfOXUnUlIWORCc0V2Y3kwoGKP0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gn5cVyChJgKQb7V1LTTPvHXalylht6EjUj0JLXa2rCo=;
	b=034OcT/xNmksBYBty8Qr9cpJu9F4u+wvtqIL3bRUGiLCdnkvDxMMb40lnNXEL5x75Smk
	 mf90WFXUcAZJWjAu6ZXAhWWnaQCFGF4a0GedNOvfSAjuQMlM3Xc0wnezwEAOBgYBC/HpK
	 yROgNBXJXbv3DcAm47mspL+ZPq8peWxAz1L5UCen5XV8AnZo8nNW6o5MfxmV3yjs4Jidn
	 P5KP5maFiyz4uHK2H6QE7EKaWus0VmM1wTLXzwUL0LIjDcZ4ySovGnpGj58S4cdnBUlPH
	 FV0E9xe0I8LjuZB0QZxrHnMoue3+OvaXYuG5/iDOKPPnqcS+7bjEQnFTkev3M1rykxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZFSMxJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD37606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZFSMxJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459A61F000CA;
	Thu, 26 Nov 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714194;
	bh=gn5cVyChJgKQb7V1LTTPvHXalylht6EjUj0JLXa2rCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZFSMxJ0TTAhhG1iSJ1P7Ab7dpOqFoUDCe12evazjbm2yqaIWLg0DQnE8TRt4KWEZ
	 oJSKHNL/TuKYt7zax+af8h3rLxDs+Aqngz2gRng8hRNbn82o/4d66sfgQN0QPMdLno
	 h0wQDldPC0nogMALhB8TPUdk8WTIIIPaP1JLipaFKo5Jeaunc595huHOpbmVA1yx7d
	 ZK86Go8e0oxS13VuULzTgD61vAEUQQlLs/APnEMMo2R/DvkknM/Rz+uaLfwBjEzqZj
	 L6XDdmPxjcXwfSKhHUgBOO3ewbd/GJL+Ct0C8ukPgfviPHXwYOwk8k65um5tMSITY5
	 K3wjOPHg6syDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] iio: invensense: Prevent possible integer overflow while multiplication
Date: Thu, 26 Nov 2026 12:29:48 -0500
Message-ID: <20261126172925.2769957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-smugly-stole-0816@gregkh>
References: <2026112539-smugly-stole-0816@gregkh>
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

