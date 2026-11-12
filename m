Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450169;
	b=TRqHGbl7PMjga1vdVj0h3SeMD12quVAECtmPPLUyawd1cSQV0cMuBfMDde9mZ89+SbK/
	 tYIcau7QmHiVU1inTvl5RF3pK10tqPNUBOpFZ1pHVdCIeMFSDbfNK8lN+tv+2KgiHOh+C
	 Mem5cIHkYCQNpqdbOsq/5BZ/QnPNyobpo3olWiUmRVO3GTDCNaz26G8Y2fnzJQBuipI17
	 Jso6qdSGOvjvmlNzqk3MCl2utVEjmqjCGNQDcKzmTSMo+qowyJ8dnnELKk6i6y6BZL7Qq
	 vzbactRtmKlMD4Y7snjd9Zrp2SQm7iISZT592Z5Y7dYvzWQa4k8eaw6f2aftb4+0qvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OhNMOBVZCvg42TJLQyCBLhN8QRePnhsmiXjg5Ap7tXw=;
	b=F3fJlqnOePW98MbYC0VAvX6CJy4lG01PS5PQ6OJsGtkZRWCDH6oWHJOHYwOlyCwjvSuh
	 YvLLQrtHacHDmapQ/6if46rjMW0I79/d/JsTmA6cAQ42h+qNQI9rmPgR5Qw1vQZyaagzK
	 f5s9b9NB3JklGbWsjdJGEC4KMj/EYvDXDbGwbd2AFMGZ6RqUk/o0/sqrulow3GUhSf1jH
	 59fMC++Lfe1wsHTfJf0ZkZrPmc6r7+c1ajM0h2XPXerKgFuqhr+4k+7GWf0GIuNH803Nt
	 Y2svriu+ichZbuVlimA5P5XNRYuGO6xSVB+WIAS8v/WzZ1XmQctjZWW61/uh7k5HZdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOiph96A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A61606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOiph96A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455281F00A05;
	Thu, 12 Nov 2026 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450168;
	bh=OhNMOBVZCvg42TJLQyCBLhN8QRePnhsmiXjg5Ap7tXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOiph96Aua084KwnLcp0nYjCbB8PQgzT8PrA8gm3G4WoBcdalQMsg8QMQr2y3adK8
	 MQ7or4qbDT6RwIernIlVXlSB2l1Nrkhw90r/R8IlmrZpC5ECAerFH8hE2u35Jf/jGo
	 C+C0EO6zbKTE0g6PfntIH8qosr/DpERA7y7dDdiXpY4PUfule+qZ/u7lN9Tn1KZk27
	 3Q63rN00iBabs8nBUM+NhBuSWX2W1RX7KeW9lBAxE4fQBV7W25qZDLVbPKYc7icYEd
	 DGrbCE6/UenQEqL6r32INJL6Rg10wLFlBdeRPVG3gX4A2a53mG6W6t93vkPGUfafZT
	 fkPQhOtixvpzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] platform/x86: hp-wmi: Order DMI board name arrays
Date: Wed, 11 Nov 2026 21:22:44 -0500
Message-ID: <20261112022111.1333490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051047-failed-6.18-d35a1ea827a2@kernel.org>
References: <20261107051047-failed-6.18-d35a1ea827a2@kernel.org>
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
index f92bb3dca2e30..9a9ff35c3b954 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -123,12 +123,16 @@ static struct thermal_profile_params *active_thermal_profile_params;
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
@@ -136,7 +140,8 @@ static const char * const omen_thermal_profile_boards[] = {
  * the get system design information WMI call returns
  */
 static const char * const omen_thermal_profile_force_v0_boards[] = {
-	"8607", "8746", "8747", "8749", "874A", "8748"
+	"8607",
+	"8746", "8747", "8748", "8749", "874A",
 };
 
 /* DMI board names of Omen laptops that have a thermal profile timer which will
@@ -144,12 +149,13 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8BAD", "8A42", "8A15"
+	"8A15", "8A42",
+	"8BAD",
 };
 
 /* DMI Board names of Victus 16-d1xxx laptops */
 static const char * const victus_thermal_profile_boards[] = {
-	"8A25"
+	"8A25",
 };
 
 /* DMI Board names of Victus 16-r and Victus 16-s laptops */
-- 
2.53.0

