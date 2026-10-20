Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523911;
	b=cEWHFR6O8X7ufDFOe/Jux7TXA9FFWQJcEXSpfVN88Gg0gieQbHAtBMKbvF2oLEFbwcmV
	 x6KU6Q5Tg255LfUIXsQ/92w0uFBRKELDUtv6tZKbABfZD51vil9qb+7j0ABCIUEdgFAAU
	 DkZhD63jUAPh3rULxaZFdi0mT7etYVBTCF0zsEOpzRFAISkVVlz57c4FjFGbxOHFjLBCJ
	 LkQ/pIh257/0JGgBuP1TsRjZqnPDuJJoQ/ILg+BMQ8BPcrtpY6ay6jxFVGg2w66sA0mBm
	 u1ebOUyG2kKoiKq0aTd/P/3k2NGdTkhuLkCWtlRMBgezp2iNrcB2K2QOwfiLX7XQuAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523911;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uP+Xmd9fBdjVfeg0RV451Ru7HMLulpVu6IyYqGTomKw=;
	b=3nDsOPhk7qL5QqL04DDMnCz1DMEgp3g3prEw85h1vvLJV678lkv3nZv6zLLUNXuzaSvn
	 ACvnmHtw/UbOezC59v1P8kIpsJ3153dpew1H3ZNt9d94SeKNYAsJW8EBYgFS0+AVccnvs
	 viEQc+F8PcJRaNUo7vyYVI1K8UwxVfDdKsL+PX0LpjK69mMbhbwEwLoxZwvxj6k61aLzS
	 1lEKtDYpvTuGaCUpA2L4uWabt+PWZEZALcYMzmFps7UWZvYYJZpgX+Bjus2UTkzEi1NVK
	 BokvhR9Z3W/x3W6mheaJM8UxvKIAhkdASpPiee0jRQ6MZSWCuWMKRqpYgb3r4VOn97g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bL08k4dd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25F606A319;
	Tue, 20 Oct 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bL08k4dd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792523910;
	b=EgeByC5CddRqJV4LV8r6nqCkcT2ArK2BBtTM4ngFOTdrL30HkO1dngEPJWe9RFIc1l7d
	 owIe4cZ5afzKWk2NntwBdRachyyT9MtS9eMIBH3QAzyeH3NxmzRKxNGqp7aN7QZj88JwE
	 TCfoReJLffNggBxXACA6IlleuYoPDUhnOxhJOAZOcQwB/AJ5WqZyFeNUxuXv62/P8/EjC
	 7KfAAkd63BgZq3/8eTd7+3SnSO5Os7B1Q1rOQTqyVlZnfrfs3sZKVAocm4j2qgdVYWJF1
	 vGXeAAXu1Fvj3nEOK4R7DvE33fVqDvBGQm8GjvjDPmvh6rt0e7Pc0CweV0uRol8Rpmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792523910;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uP+Xmd9fBdjVfeg0RV451Ru7HMLulpVu6IyYqGTomKw=;
	b=GXLAu4dPvadE/lXh4ljBRAP/fdL1etpfSWjGk/VbwDsjNRlTUOSPGp5xpL3DHE6/jzk8
	 9vJ0oMOE/RkqAkthvKECjVQPrYvPPHz2c0QfjP9xRURZVGdSX7ESAwSuMyNGUFWt9YXQ2
	 OCw7o1F1cZDw69nFWZijjFYQe0iWcTW7z/SDWE39kbLuBKOL7BptvV+sucLgynOplvylL
	 Ah/2GDyD72WTze8huZnwz2nRScGme8XA3PUvpcCOyv2JALeipK4TvZCagLwYBYr19PM8m
	 Kz7/YZsp7Ys3Szj+sm382IOGbXOocgMtTqnoHzJ+wZfBroU2m0uu/tosdpUZGXR6goQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AD891F000C9;
	Tue, 20 Oct 2026 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792523910;
	bh=uP+Xmd9fBdjVfeg0RV451Ru7HMLulpVu6IyYqGTomKw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=bL08k4ddy2AN02eB1oQTTxVwhOIal2GdrS/X6YMhy/hW71jxausI7fEPivSFw9j+X
	 rO+tKTrzUSHGAi9Vptu+XempFIKfG3v+iYxHfsNczmLpBZ1UiBMD6VTTbIabXwDQbY
	 ja6xMbm8IeyMcn/9xnokU/EAgZsTYqXjZX4CABCGAV7YlDxz9kH8TNzvqidO7KGMka
	 p5ze77436xtHE4GT24+lC1yHtgVDVD+Uv4yQpF2tHXNLiPvAodPOFd5VTd93hOHIRM
	 SwCeAtEQqGc6P1NWtmuz3n3PqAN8gAleJC+lMlt/+BmM2yoobJQwDnIaOn9ziI3Ff4
	 4sSZqrMGafepQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 90E384322E;
	Tue, 20 Oct 2026 19:18:29 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Tue, 20 Oct 2026 21:18:26 +0200
Subject: [PATCH] thermal/drivers/tegra/soctherm: Program throttrip with hot
 trip temperature
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAwA0F8ZORvoCnbMXxEPXRdthK0lyUQY+
 3erHt/l7aAkTAqXbgehFyuXtaE/dZByXB+EPDeDdz70zjvcqppQXFBLskyyoGUpZsIV4xzGcB6
 HYQoJ2lCF7vz+7dfb37pNT0r2LeE4PrY5N+l/AAAA
X-Change-ID: 20261020-upstream-soctherm-throttrip-ad6965977b6c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792523909; l=2148;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=RYgQxo1Q07jpqk6tE6wjPPC841A4mk8ZdJMQnRXuUBo=;
 b=m+kV5YsJ2VgwipWiC2LRknxKcOCe0vnTOfvlAi1qcANkDyhbRNLWXXlz744RW9VoCNU36PzzD
 ZHRsW+KATFUCWJrcFeXl20/r2ZpMQFT8NFRZNIe0bow92jA3+f4MJNT
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra_soctherm_set_hwtrips() is supposed to program the hardware
throttle trip (throttrip) with the temperature of the thermal zone's
hot trip point. Since commit 735a968d2fea ("thermal/drivers/tegra: Use
generic thermal_zone_get_trip() function"), get_hot_temp() only looks
up the hot trip and no longer stores its temperature, and the later
conversion to get_hot_trip() kept that behaviour. throttrip_program()
is therefore called with the value still left in 'temperature', which
is the thermtrip or critical temperature that was just used for
thermtrip_program().

As a result, hardware throttling only starts at the shutdown
temperature instead of at the hot trip. On the NVIDIA Tegra Note 7
(P1640, Tegra114), where tegra114.dtsi defines the hot trips at 100 C
and the critical trips at 102 C, soctherm reports:

  throttrip: will throttle when cpu reaches 102000 mC

instead of 100000 mC. Svyatoslav Ryhel observed the same on the ASUS
Transformer Pad TF701T (Tegra114) and the Xiaomi Mi Pad (Tegra124).
All boards using soctherm with a hot trip bound to a throttle cooling
device are affected.

Use the temperature of the hot trip for throttrip_program() again.

Fixes: 735a968d2fea ("thermal/drivers/tegra: Use generic thermal_zone_get_trip() function")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/thermal/tegra/soctherm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index f74acf13b24d..903215502606 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -765,6 +765,8 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		return 0;
 	}
 
+	temperature = hot_trip->temperature;
+
 	for (i = 0; i < THROTTLE_OC1; i++) {
 		struct thermal_cooling_device *cdev;
 

---
base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
change-id: 20261020-upstream-soctherm-throttrip-ad6965977b6c

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


