Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635394;
	b=Vs8QnLnVAGSK0fDjKlMJjuVTDZBbq/CoPhKjOme4l97LaAqpQegGvR9tn0bRIYLsUOOC
	 pzUz85J58s3NXcSAKHm5muIGUUgkYWq6YnEwnuwwhSy0t+ql16cSTrnEr9XX3CH4QZ8VG
	 M73fjkBFgVSu/a+rI+cNXfqnr2mk/WPi1uJbaSujGTbWByAXpA2haVaRPHCJ4va5pFeVX
	 JH2pudnrw23Dtrq6Yr8BuD43Q4p2onXipu++4mp4IwTUomXULVaLpN/KLUikHgJ6HPvsX
	 6VBNPXghiMefb0li3EF/UU3y4XXgIZPDkg01/o3z1OWNfWloyzq7QKclU5EWK0A2Udw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m3ElQ2ttuOlxP5wC6SRZrwyVtuv0UAwaUwmgApN7iVE=;
	b=rPGHubcLXJNu+7zo3q2ITXXnHOZrINM0o9DPbkgTptD4cWxzEy/dxn+0XIER7vRtq3LW
	 Z6cl4emubHL5jyGv4IMX0uS8hGd25W2wCGt7RPIdvAE+sWGR+4DschwWfXg6xAHxlTiIB
	 7oH/6hRuzrnpEbX8B7nOlixoooqrJMBT5W7FJqMYA6cTEDuSMFM8Nz5mUvGtNiApwEJXL
	 MmA3E2EGYE7ErvAnBOiRxgLGxYyszprr7i+ude+S16xvgJjxca6m2ZnbMxt7RNVeLgVeZ
	 /tAomNZcHj6DEYUx/yWtnwElMi0hK5UxqlAT98XIrIj94JxV0kw7s/cHsUwjvmqGWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jW0u/SPf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A8606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jW0u/SPf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097871F000C4;
	Sat, 14 Nov 2026 05:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635393;
	bh=m3ElQ2ttuOlxP5wC6SRZrwyVtuv0UAwaUwmgApN7iVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jW0u/SPfgg28hucV+Gcv0wOU938ASq8rpVMEZrGu+d5dL9kt4Jtn7XmgjSxosSjJ9
	 mWJXeRMbqBBAyvXbk6k/Y8FRENsBL109kYANW9ajFHn48Yz1iiAh8yYVMpNrEfSd8r
	 H/ivR5MuhQDpXrEMUdJ2K/I7JtPFcZTKxwQrMgW5CB6EVJUzt6kYBqDrOnRz/NLFhG
	 bRJl5xkRnfE8X5LeTz9P0UbAOe7W3tEM9S2lH39wCGEZq0zg6cPYuykAIabWDZN5sr
	 NNTj9X6muGIowdZ3V73MA+tCZJJQCU6QpKtnI1+MR8UMfEdliIQHmXpIRv2e2Pd2O1
	 2bw0/Tmmudx5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
Date: Sat, 14 Nov 2026 00:49:51 -0500
Message-ID: <20261114054940.3177143-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202636-failed-5.10-0f9c7ed3b500@kernel.org>
References: <20261109202636-failed-5.10-0f9c7ed3b500@kernel.org>
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
[ sashal: adjusted context to use the DTHERM feature check instead of the housekeeping check ]
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

