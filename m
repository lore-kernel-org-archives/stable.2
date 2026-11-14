Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635120;
	b=O8dErP4dgkRZRNDRWZeGuDnOVqaLnW5neaonPHo+lp1Hq9Xtb1nlG/AciiCi8RCLQagB
	 yLRI/Ol+fm1tJkVV81LBefH7d2WdYLYZdFNVT2NGyfDhaQuDV+NRt+BkK7R0PdFmR/Ml3
	 jL8kr4r2jmVNIspeLJQV0+/CJzH1cNNyJas6YHsBLowksaSDPVhI+ZmO7T+onmWkB7QIP
	 z6JSqDAqlgs1eNq89pAQ4izInh0vC3cTqY2Q5wUlznPy/R2Mq65Ho4VuO60184cDnVgWp
	 Y8ysHIkNHLnLDuBRkrUIc1z7u9G8lqu9zJLpgJ5ZriPMg8zad3GbleNxyVdUHJK82bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lA+eN+CFT+rVNKSmAQYOghySrSYytfUb5z7K1Gp4krs=;
	b=mJnq1o391qLWJzfk6vumQgxUpbXhLkIiZSde8siC+aVKr+M520CrvLdr9z5VOnXE5ain
	 VGFU2iltPmMCH6TZKabK5PSyXzqeONGYGdi/mIpaf7YyfXx4C966F2o7NSGxsw7k/bqyD
	 iHqYpLHPuOO4JxHrC93fUZZjvGWQGxaDZcClarzjOxWKEo3sUDi7IHK8C08NHK7vHzzAz
	 pnvywTsXuD7k1wfCxTrjhwemNZzfTJ0Ms1m9jREpn73GvqVKPX3bJq9GAeWeCITX2HnMJ
	 4W/0qb9hrEcqy4WgsPySFJpn9NVte3Nf4NNI5xOgPKMTmrpi1jsU3N8rK7kPuh3unQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiEAr2Er;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E879606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiEAr2Er
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592E1F000C4;
	Sat, 14 Nov 2026 05:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635120;
	bh=lA+eN+CFT+rVNKSmAQYOghySrSYytfUb5z7K1Gp4krs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiEAr2Era8Tr1HcFwD2qRco4+nm5cvFC/UYnbZtD91nhCzZdMnpNspDIH9WFJFmFF
	 puSxcJDqaU11qd01TOdG6zbU0VB/2pJGNblTuUSWzYKeLVvr8flx/0pwJ3sq2aLoWP
	 iG6pXB7GKnnu6tvFx1gaiLBgKLbLEAb51ksAhkR+afFOJ/d+WjiCYFVuKc4WFShazi
	 XfgnYqdqOAY+WpCQ/XV2A8pO8YmiehK9k+copdJLXZkyoxTPLPIpNzfB5Ede3I59Vm
	 3/cbEM/4+hP8tE5+uWUcpTQbPP6kvxPf2VLxVlYSKoFVTC24Cn7HLLZcoA+mriRiy+
	 Ha5fDlJrRiuSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
Date: Sat, 14 Nov 2026 00:45:18 -0500
Message-ID: <20261114054507.3138666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201632-failed-6.1-0f9c7ed3b500@kernel.org>
References: <20261109201632-failed-6.1-0f9c7ed3b500@kernel.org>
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
[ sashal: Placed the NULL check after the thermal-feature check because coretemp_cpu_online() lacks the upstream housekeeping check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c0aa6bfa66b24..b0dce8a0d95d6 100644
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

