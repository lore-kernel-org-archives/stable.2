Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78B48035F;
	Thu,  6 Aug 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031687; cv=none; b=cx84Gcy7o0TbozAQHtMhdJdxuAQiT7H6LQbQMjLZCDjrCJnS3y8dbsCXosASLuTnDTgNX3Mw/tlU1RNXTpvjAnilQbz01FBAdifMLF2e/ohLskHUXZlS341QAVmgukqFqM5oFuA57tCtORbcbppItbkp5AV2mF3kIpwkYO3867c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031687; c=relaxed/simple;
	bh=DVzmihv/iZvgSv2xI4pYd8cIUmwkRoWs8cAK8KYjTw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzjHO2d7t9TN0ETmlwvRlK6dE+wlKDXKpp+5dV0jznhFR1E/Ps6T/ydMecjg/w9xo0slr83UT2zHP82ucmu/5n43OFzK3JW1LmdmHeSBc4FaGWjGvq4d/l4IYA64W4jbnvPEeL4uL4uKtR/aXa7VfEpnMOjZVM5gszvDLQKgA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZNpA46e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZNpA46e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17BA1F00A3D;
	Thu,  6 Aug 2026 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031679;
	bh=zu01nEYAjOItW35TYcUwmAsfZ0ZwoRmKBmJPUhqbpOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZNpA46eY8mKAsz5zfFiWVGLs0h96TdFyy89Qqi4g1A4X/5MXcqcxOxXib1VOJkNl
	 oX5HXQwgtcpu7IGsXsD2eFYI36Jb5YdIUdGJBR8R1WGP2Arh+VvrmDkZQnpdYDRfzj
	 w4ZDYnokz3+TwHFW9vkEev0oCRwHWU5grCT7YJ3db6c7cnmEwvz4aYSGLzYhBhB3Sk
	 pTUkMV/uvJ7AgRmcxe11o5uIGzHqoHs/jiQHpgY5g5OvRr6GcyHyhwRqvjxXBDjNV3
	 +/t7H6U09OtAhd7F3y5Z/umEpB7eiaLPRZz2Cdqiir/n9ifutTvo1n6CJvMRtt+vGI
	 oi0SnYjwEsrTA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2 4/4] EDAC/altera: Fix use-after-free in error paths
Date: Thu,  6 Aug 2026 10:54:12 -0500
Message-ID: <20260806155412.1518582-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260806155412.1518582-1-dinguyen@kernel.org>
References: <20260806155412.1518582-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In both altr_edac_a10_device_add() and altr_portb_setup(), the error path
freed the dci structure before releasing the devres group. Since the managed
single and double bit IRQ handlers use altdev(dci->pvt_info) as their data, an
IRQ firing between freeing dci and unregistering the IRQs could dereference
the freed memory.

Release the devres group first so the managed IRQs are unregistered
before the dci structure is freed.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ccdfb35178b69..4c20fb9261608 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1593,8 +1593,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	return 0;
 
 err_release_group_1:
-	edac_device_free_ctl_info(dci);
+	/*
+	 * Release the devres group first so the managed IRQs are
+	 * unregistered before dci (which contains the IRQ handler's
+	 * data via dci->pvt_info) is freed, avoiding a use-after-free.
+	 */
 	devres_release_group(device->edac->dev, altr_portb_setup);
+	edac_device_free_ctl_info(dci);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;
@@ -1997,9 +2002,17 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	return 0;
 
 err_release_group1:
+	/*
+	 * Release the devres group first so the managed IRQs are
+	 * unregistered before dci (which contains the IRQ handler's
+	 * data via dci->pvt_info) is freed, avoiding a use-after-free.
+	 */
+	devres_release_group(edac->dev, NULL);
 	edac_device_free_ctl_info(dci);
+	goto err_print;
 err_release_group:
 	devres_release_group(edac->dev, NULL);
+err_print:
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 
-- 
2.42.0.411.g813d9a9188

