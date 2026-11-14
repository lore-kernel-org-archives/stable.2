Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635257;
	b=aj8MckVsL8sgxguAtj1VACSWvwKUN2kwMFYkTpPZh1t+h6H2nI7jIUfb7iimA6EOyBiq
	 FWsfCXCQKL5Lx7yJMunhd1lMJmk3h8U5CD8AdDja2i+UsczBmoRiOTXb37QC+PGjlaRX7
	 SpeA+HzzuLcvWXQ1ijJw1q8+ya+OdADqmPeRyq9Sz/pf0a0jt7dabADOUGEpgmUdKy7sW
	 kwYiIryWvC939IR98tI6CKBbxF4voD+la1FqpIHcPHSqtpjp7HznzzCtYbTwQ1lWsgRG4
	 AZ1vtUtNsKcXqlHjQzFGa3VLy0bs1XKESAVPl3LjbLTzRoK1Uy6/EFtkuT34qIAs8oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=07AAezUwL4m6C5l2a/llFCGxkX5eZpNMYah8yhiTu8E=;
	b=5sjP4yKu7aJj6NgqcUuUQONl+6r9lSxSpOjTdEoJO+xI94dFB7iGuUgiKBVOM+T8e93B
	 QC6Tp2wV80hFa5emIMglFqEu1FghqfTbEDT8fGwEBqaITSS8DMIgNaSIfaJy/zbtHE6SM
	 IaLkm9pN8dwM8zmDla+e8b8Cnq4/fqDe5GydKtq/IyrYjnCjeq9QavXb3X9/TyB8gysie
	 KsbE5wdGa1ZIrzJiSd7m4tarXtQs7/B4CBiqZ+gy4BE9GNA1gf2lXtr9gblmRyR2daygv
	 6ZFFoLlFJv++UXZ8yh3Dq+3bpCuJjjFYFTr08E38ojHYXRu/64JH7V1Y4VKVCLUc8Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNAWYbl8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EC606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNAWYbl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9EB1F000C4;
	Sat, 14 Nov 2026 05:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635256;
	bh=07AAezUwL4m6C5l2a/llFCGxkX5eZpNMYah8yhiTu8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNAWYbl8KaE35Hy7f1vSnzRsExXhh4BfsbFBBjFdPWUJtCbChYVqVTEFiKfxMIHuY
	 vg4PmDQNOG4P6b34zFLkvsAN8+KKf8eXs8L6W+MwRTIL9kKHRa1xA4I9Q3R/dSUV/1
	 VG/uwq9PB1MIO2acAt1DapbXXGxm8ez+Teg/9RdBWJ49uA+M9U/Go6wQVN6PuUpac/
	 Fol/s+g4MNYMK53dfhtWK5UXPMXOgQgmZJwWH3d5UFTuXanbrrAvGpctvnGV6++RUC
	 rtiqX7llX+QhSgHyunR9ZGwMO0qNdakbaCGJkbv2ALuRZWNlUohVZVJgDi5HOBtUzS
	 c0x9fPPALkWbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
Date: Sat, 14 Nov 2026 00:47:35 -0500
Message-ID: <20261114054723.3173254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202142-failed-5.15-0f9c7ed3b500@kernel.org>
References: <20261109202142-failed-5.15-0f9c7ed3b500@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 0f9c7ed3b5009a037e5533eac03a0d4d45ecf1f0 ]

coretemp_get_pdev() returns NULL when topology_logical_die_id(cpu) is
negative (such as -ENODEV or -ERANGE from topology_get_logical_id() on a
firmware/hardware APIC ID mismatch) or exceeds max_zones (for example,
under asymmetric or anomalous ACPI die topologies where
topology_max_packages() * topology_max_dies_per_package() is smaller
than the logical die count).

Commit 6d03bbff456b ("hwmon: (coretemp) Simplify platform device
handling") pre-allocated zone_devices[0 .. max_zones - 1] during module
init and dropped the NULL checks on pdev in coretemp_cpu_online() and
coretemp_cpu_offline(), passing pdev unconditionally to
platform_get_drvdata(). When coretemp_get_pdev() returns NULL,
platform_get_drvdata(pdev) dereferences &pdev->dev and triggers a kernel
NULL pointer dereference.

Check for a NULL pdev and return 0 in both coretemp_cpu_online() and
coretemp_cpu_offline() before calling platform_get_drvdata(). Returning
0 in coretemp_cpu_online() ignores the unmapped CPU without blocking CPU
bringup or tearing down valid thermal zones on other dies.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 6d03bbff456b ("hwmon: (coretemp) Simplify platform device handling")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: adjusted insertion context from the housekeeping check to the existing DTHERM feature check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cbe2f874b5e2f..73aa7e9679755 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -618,6 +618,9 @@ static int coretemp_cpu_online(unsigned int cpu)
 	if (!cpu_has(c, X86_FEATURE_DTHERM))
 		return -ENODEV;
 
+	if (!pdev)
+		return 0;
+
 	pdata = platform_get_drvdata(pdev);
 	if (!pdata->hwmon_dev) {
 		struct device *hwmon;
@@ -669,6 +672,9 @@ static int coretemp_cpu_offline(unsigned int cpu)
 		return 0;
 
 	/* If the physical CPU device does not exist, just return */
+	if (!pdev)
+		return 0;
+
 	pd = platform_get_drvdata(pdev);
 	if (!pd->hwmon_dev)
 		return 0;
-- 
2.53.0

