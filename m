Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328171;
	b=4BzGM5kraoZ096FLXjQQJQa3IP38/BVowNt9baepwO6jyMwzKExWNMkrZj85f2N3xtBG
	 96viuDNCin5c6DkpTTe+ASmhfcsKLqvrLuVtJTuLinKu3iS9IdBpXiJY/s/hHF7XqQB1f
	 AjnZ0eBuSC7giHVR2R1MrlQenuhnfvjyshIfVVluR57+6PNVF/Q+7LgYbaSJyRB5EfKsE
	 L2/M2w7XfSzQdTC3TRtPMHrZzAPXUOceWl1ZhtEhczFWGjoQJ7Wrd/p1PQXsbR/Zv5FF7
	 TqjwmigX7PgpoMjSrvXA3TyllVuZTMZl7MOQbUNlky9Mpu0jT7VNf0UPR80PPoH6KEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fB0KB3Q1ErExdTyBgaBt/5dGhg69AYQyv5i3z55GbhA=;
	b=JuKwtTwN7i7EDWUW6Roq2yG7w7gI9y0R1kmVap0OZrs4oKb5b7q/VMaO4+05NV5UaAQK
	 TG6c1eya646E0Og6IsnMgqcPHIg0v6qw3AYxfHDwP6psRDT7fNJ7Fwm2k0615DW4cOKdR
	 BZ4hbHilVh6M0Bemjr6PFFDHuEuMxIp2BbuskazSHNcea4SR2RevvnUfQLj4EFUmhW6py
	 YRPh4WjaYQ5scl5Cflz4LuMUvqbL7oXsposHCnfFvoHmrDOpKi3s5FR9p2RtYzQZUaD7D
	 /198T7WBwzXcEf36VLqitlIguKA3Jmke+948G5FqwOQov6p7YZEyA54jCLPOL6ZD4EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgx8Y+PS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5B60A2619
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgx8Y+PS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C238E1F0092A;
	Tue, 10 Nov 2026 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328170;
	bh=fB0KB3Q1ErExdTyBgaBt/5dGhg69AYQyv5i3z55GbhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lgx8Y+PSfmPzsQkGClsOorDf41nNCsrQoOWLc+X9MgcRpTPqccihqdbzXNDMBbpCW
	 yIHxikM+IwYCvaRsohlDnGI/fLrEF3D1UcS0YkkHmvmxeg8YlOrm8tFKM8Iyl+eeY8
	 UdQRqnDVnrNSnQUTxh6km13LsHW/AcH9naJSa7si+gv29hksJM6IUNi8MAkfas6RgN
	 M0OCPQFI03WqLKWjyTL9sREwU3gpe5IILJ9ZM59Wjua8zeuPZONiPdPz8mqAw2mKdk
	 szspApKzPqTPfh45eZm0SFSKXVKgqKdvyiwCETHjgtXdzr8IHYvorksJW39risHJmK
	 lAtsOCdJ/v8Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cxl/acpi: Check ACPI companion before use
Date: Tue, 10 Nov 2026 11:29:28 -0500
Message-ID: <20261110162851.2487363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060040-failed-5.15-371c2ad16242@kernel.org>
References: <20261107060040-failed-5.15-371c2ad16242@kernel.org>
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

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 371c2ad1624283b6c7a62a28199f5161d388a738 ]

Platform drivers can be forced to match devices outside their ID tables
through driver_override.  cxl_acpi_probe() assumes that every bound device
has an ACPI companion and dereferences adev->dev.bus without checking the
result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
without a companion therefore causes a NULL pointer dereference.

This was reproduced by setting the driver override for the pcspkr platform
device to cxl_acpi and binding it through sysfs:

  BUG: kernel NULL pointer dereference, address: 0000000000000280
  #PF: supervisor read access in kernel mode
  RIP: cxl_acpi_probe+0xf4/0x220
  Call Trace:
   platform_probe+0x4d/0x80
   really_probe+0x106/0x370
   device_driver_attach+0x4c/0xa0
   bind_store+0xd0/0x100

Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
companion before use") fixed the same force-binding issue in another
platform driver.  Check the companion before setting up the CXL root and
return -ENODEV when it is absent.

Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Link: https://patch.msgid.link/20260926071605.3013893-1-yaojiale02@163.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[ sashal: Adjusted cxl_acpi_probe() declaration context to preserve the required acpi_status status variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 54e9d4d2cf5f5..f2203f14af2cd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -377,11 +377,15 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
-	int rc;
 	acpi_status status;
+	struct acpi_device *adev;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(host);
+	int rc;
+
+	adev = ACPI_COMPANION(host);
+	if (!adev)
+		return -ENODEV;
 
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
-- 
2.53.0

