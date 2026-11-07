Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049242;
	b=Qwh/tVhLWFExkFWhEYOOFMLTy/YUIYdLQceCTQKPuAqDijLs2FAOQYF/SrMOSHkxjIyf
	 M7mMEMgHAoVbpb9LRssBT1zT7NGtth+YAk/dKqUD80snR+FC1ITOytrClhY5U0WI3nOhj
	 VtNMxn/XdplH5DQxeX6Uylb1/M/3bqXk9Ha1y4MrbA8ySgcIksjMYUIWC4wBMfJmPVqHi
	 jyeVDZGPGfkTTdJS5fPZmJP7nDqlObG9YzqdKM80Q6s5OanQ4vRsjWJ3/wJg/UpsPj12r
	 f9YkgTHTi0PNadHGkvmzEXTt8ItTyMqUt8uCd/va1A9k6aQDNXCXw8wgIUXFAuvDHJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=55oIIr/yjFYbYMJghGsHSZnTyPXm0qB89O2QqRiGqBo=;
	b=LHCLhHwHvXWhiDlNrjHSb6FwAItuIyHUoiedXLbyMKhU6q23HjKlzrplPg3FzQmLm++g
	 dkvXz12/7cHPWtKF+QUU7f2Xc0w5LtMs5ZvT0QzLL/d9MjRqn0wrCI5y/Q/3CEdBXVRPz
	 bCDnOwSjDPS8rU0+FQXqtzMjVkp3twnLeDn8BB2mWDtCx6IcDqgalAkG9DRVEzsrpgS9a
	 pkMun90vsCLbaDlFYU1i3r4Y8vUm72EGw3jWuccocFJIt7gvBlO+bscpQi3fWlM8NlLYM
	 DH+l7GdjEiPwnRT5WI7Aiujpo2Wr+mx9Bl7CtpLJ3VfbUY7DoXQnSd9epXwYHEsTwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PsDV/RS9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsDV/RS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81D11F0089F;
	Sat,  7 Nov 2026 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049242;
	bh=55oIIr/yjFYbYMJghGsHSZnTyPXm0qB89O2QqRiGqBo=;
	h=From:To:Cc:Subject:Date;
	b=PsDV/RS9lBgoP6xqC6eG+0Fj64IWxUnYNZ8Syc+eLJZzpDC12RmZs7tU8z5ubiQm1
	 K+NZ72xe3QcRipMAAfzV8p5aryz4ADJLKrVQqrQUEQm5R0NNSDu5gfYZvwkMTC3bGX
	 5t4EpO4H9k78N7+EAFWQ9N8W2hxKvFEQ94jHBdbCisjladiJ8w4NQtt2sm9rTVFvY4
	 +d88aUB8CDwxnZkXbgLXlYG3Yhzg8XuGXTIHWW09RA/8CWLSo7jPa6sweIkJFIVLQ7
	 lbwtIOoZnSt68SV1tNlC0VnaB6IvxxuFrd1HgvvA5fXs+V2LkxZs14C4Jps9rWgNS4
	 I2spDIvF2HVCQ==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com,
	dave.jiang@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cxl/acpi: Check ACPI companion before use" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:40 -0500
Message-ID: <20261107060040-failed-5.15-371c2ad16242@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 371c2ad1624283b6c7a62a28199f5161d388a738
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060040-failed-5.15-371c2ad16242@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 371c2ad1624283b6c7a62a28199f5161d388a738 Mon Sep 17 00:00:00 2001
From: Jiale Yao <yaojiale02@163.com>
Date: Sat, 26 Sep 2026 15:16:05 +0800
Subject: [PATCH] cxl/acpi: Check ACPI companion before use

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
---
 drivers/cxl/acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b5..fb09a5ff48c16 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -885,13 +885,17 @@ static int pair_cxl_resource(struct device *dev, void *data)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
-	int rc;
+	struct cxl_cfmws_context ctx;
+	struct acpi_device *adev;
 	struct resource *cxl_res;
 	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(host);
-	struct cxl_cfmws_context ctx;
+	int rc;
+
+	adev = ACPI_COMPANION(host);
+	if (!adev)
+		return -ENODEV;
 
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
-- 
2.53.0




