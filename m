Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450705;
	b=VekLPRBAVLidmSYo1CFxW3f8k5u8dOhCpR6RMwdS5jKOAKt3bL9dHkFTnTFfu/OPgZJP
	 S7WwKKKpVJ1tuiADOPKIPDjcByft3NYzXpg2DiTziuFfiUw3LaOIsbaRbIgqnKRa1K2Pk
	 k6tRBlKyoIDBP95RUs49UetBH03zoodziyAQn8cpCgfhFvixQgw//PWZi1y+wKDYwdOVj
	 VWGJOh1iZdmvVnXbSjONNQv71i8EFHg7VdKJOYAcI8Kh7ZJG9ScEKgABjCsLQhV0Pkl7L
	 UguIY5lbeslzRJVcXeV2JDJhzqkN+XrEIb7IfPt8aH64IVyjeRwbLml5hfGOH8kWAww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8BJJcdf49d/UCDzxiZkFi8jhlCreJ70euECsL1HJvl4=;
	b=5UYsSirzShCOG83eU1sFpeKaW7NNAvPp852Bg5tJHFFvkNTdl6HuQAAyTcu1u7whFrNM
	 OZHOl1AJ5PW3LIW7gDgl+fbtcBU/vk89POj8kgRO46TB6sf1b+aqS7YYFkUsRXHB5MAGh
	 BfbuLRfGcR2E+h5vGB5pg0/+Ra415v2QC2954PnikOukWqB5OeT3vmTWYFMYRKIPgRybW
	 dlQn9OFmh2NivYxYR+9RdHgGh0h1BxZIJZHVxEQzZyHG2LJK2TgfYj4ZoucULr1L1MDbM
	 FuuHqlNB/OuhunplDJbitgvZ6UqESd6x0l5dJgOOh9FqRx+U9kxRnpowrgfKGAoYAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPTjOr9l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA5606A33F
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPTjOr9l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11CC1F00A09;
	Thu, 12 Nov 2026 02:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450705;
	bh=8BJJcdf49d/UCDzxiZkFi8jhlCreJ70euECsL1HJvl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZPTjOr9lk3OT+1pBN9E7/oNiNsrHFg4yyxXzCmg7auS1XODeFo3ESViQ4oOXDtTMR
	 GYT6YfhmVJJCuMiQg6Nwv8DbfrPXGMqCNWRv0f//xEHHDi8bTxyrdxhLjThSpa/UWA
	 Z1cPZPi3RpTyBCQd2DowaPVzKNHvBoFfP4jLiM1m7K/h7UE9pAJMKKQimur2TMBQFJ
	 uJrYbSt8KN967iYs1rcvjUznCdgpQ+hlRr593ZIK5mVB6GkL9vNsjGt4g5JuutqD1O
	 bR8KG+oLBJ1yi/BmjpwKyFE8sAgiKAxbQzpwuKVkgrwj9/fRKnN1p4HY0SrG2x5yo9
	 CZ+a48Q1iczzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] platform/x86: hp-wmi: Order DMI board name arrays
Date: Wed, 11 Nov 2026 21:31:42 -0500
Message-ID: <20261112023128.1376145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052143-failed-6.12-d35a1ea827a2@kernel.org>
References: <20261107052143-failed-6.12-d35a1ea827a2@kernel.org>
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 68779adbabdbb1891ba4d9b8c7d3be99ed5e0b3d ]

The hp-wmi driver has a number of arrays that are getting new entries
and all/most entries have been added to the end of the array. As a
result, the numerical order is mixed up in a few entries.

Reorder the array entries. Split lines for each two leading chars to
make the arrays easier to read.

Add also trailing commas.

Link: https://patch.msgid.link/20251128120215.4450-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: d35a1ea827a2 ("platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 02227a4392907..d189da2205609 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -59,12 +59,16 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
  * contains "PerformanceControl".
  */
 static const char * const omen_thermal_profile_boards[] = {
-	"84DA", "84DB", "84DC", "8574", "8575", "860A", "87B5", "8572", "8573",
-	"8600", "8601", "8602", "8605", "8606", "8607", "8746", "8747", "8749",
-	"874A", "8603", "8604", "8748", "886B", "886C", "878A", "878B", "878C",
-	"88C8", "88CB", "8786", "8787", "8788", "88D1", "88D2", "88F4", "88FD",
-	"88F5", "88F6", "88F7", "88FE", "88FF", "8900", "8901", "8902", "8912",
-	"8917", "8918", "8949", "894A", "89EB", "8BAD", "8A42", "8A15"
+	"84DA", "84DB", "84DC",
+	"8572", "8573", "8574", "8575",
+	"8600", "8601", "8602", "8603", "8604", "8605", "8606", "8607", "860A",
+	"8746", "8747", "8748", "8749", "874A", "8786", "8787", "8788", "878A",
+	"878B", "878C", "87B5",
+	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
+	"88F7", "88FD", "88FE", "88FF",
+	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
+	"8A15", "8A42",
+	"8BAD",
 };
 
 /* DMI Board names of Omen laptops that are specifically set to be thermal
@@ -72,7 +76,8 @@ static const char * const omen_thermal_profile_boards[] = {
  * the get system design information WMI call returns
  */
 static const char * const omen_thermal_profile_force_v0_boards[] = {
-	"8607", "8746", "8747", "8749", "874A", "8748"
+	"8607",
+	"8746", "8747", "8748", "8749", "874A",
 };
 
 /* DMI board names of Omen laptops that have a thermal profile timer which will
@@ -80,12 +85,13 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8BAD", "8A42", "8A15"
+	"8A15", "8A42",
+	"8BAD",
 };
 
 /* DMI Board names of Victus laptops */
 static const char * const victus_thermal_profile_boards[] = {
-	"8A25"
+	"8A25",
 };
 
 enum hp_wmi_radio {
-- 
2.53.0

