Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097433;
	b=XjpnrQUxTW4FamS1+4Giv2ciWvOKNGRPnyR+LDEcsA1SOPJO5bnx31dChomwCstm3c1k
	 zlt6CQaGSPFh+XZJawZa+ahjEf0+D4Ji/xfQ89Hf0/JwW5L4NIJJh35SFt1H5bjC+Y4KA
	 eZf309TqPTprhTB2FaFA4XFB85WZGN8q5WsKa5hil6Aw16X5edKESFBA+/NRg6CQF1Ku0
	 f02hkUepgim/Vn9+HeGWc6Cxm8zBP/FaNBet/u6os5SU3wh9+h+JApP0zVzCkFxUo7/jZ
	 VZetXUXRulknepoOi60HGQ7wYPQgLN4XxTOB2GEE5hcPS3uecbg8N2GlH1iz48POE/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hqInm/ZHOjc3yMqIETdIoGeBEnEoCj8Hf4GrPe3PS04=;
	b=UmsFgZfQpMRRWtKCqaGf8ZSSSDxcGh1Iui0rT50dce1nNgUGLqLln3M8MlRFNY9q+7KW
	 3wNh69zU7TXrzGCzTIsgvSsd7I/efFpp2H/GURQitj/m5LVxEdRRApOPaDdmkYUNgVJdW
	 P/MwxKjNr79TMMZ2pPZ46XYZCLid6Q8vqOyd7RsUvWSCPa1kxLvtV2eKmWwjVx0rY9lPW
	 ArPK6CTluoz8Wg06jd5czqfFMNjgs2OYk+B4NJo+UXhsCytMlgV51iOZdHVap2BkXn8IP
	 0Em4qj6a31PyEyBhGH3kkcMLLEU0YfJMeCGtLqPRncnDKhjvu4lLuCDGH5as4M7Dnwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc8EVZ5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D72606A325;
	Tue, 27 Oct 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc8EVZ5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D7E1F01828;
	Tue, 27 Oct 2026 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097432;
	bh=hqInm/ZHOjc3yMqIETdIoGeBEnEoCj8Hf4GrPe3PS04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tc8EVZ5DSg30b0yoOSuwJ/QHofJeOSxEEu0NWBaZdIOyGvmVotJIONs+xprUMJvZL
	 3Yg/oG0C1ScbcEXkRcc21Vks1XsKBoP4GaocLUgQua1f/U2cr1H5vlxl1gMrqV1/CT
	 W2wLgxt8+1tAmVJfQc6m0iyVEJRzAWz7aLsSEOOtgyWyhRAOwEaDtC7K5/+WnYx1XO
	 As8VbkjBR/ModDScP20kuoDmwhJRWDC8leJMKiSqlQBEcGFHZbWACfSW5qX5QTJp3q
	 zVe2D0UG67K2H9Daa+EITXLUmcVFKxd/nXxqh+EVBeexdb9StiYsJbx6EaFrdJOgXi
	 lHetdiVK/mwYQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 10/27] mfd: intel-lpss: Remove registered MFD child devices on probe failure
Date: Tue, 27 Oct 2026 09:30:39 +0000
Message-ID: <20261027093306.2812695-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

When intel_lpss_has_idma() is true, intel_lpss_probe() registers the
iDMA64 child device via mfd_add_devices() before registering the host
controller cell.  If the second mfd_add_devices() call fails, the
err_remove_ltr error path returns without calling mfd_remove_devices(),
leaving the iDMA64 child device registered after the parent's
device-managed resources are freed.

Call mfd_remove_devices() on the probe error path to clean up any
previously registered MFD child devices, matching intel_lpss_remove().

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Closes: https://sashiko.dev/#/bug/linux-b0ba1dea-0272-491a-a1aa-2fd27c5eb9b0
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/intel-lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 63d6694f7145..657b1e3fb896 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -455,6 +455,7 @@ int intel_lpss_probe(struct device *dev,
 	return 0;
 
 err_remove_ltr:
+	mfd_remove_devices(dev);
 	intel_lpss_debugfs_remove(lpss);
 	intel_lpss_ltr_hide(lpss);
 	intel_lpss_unregister_clock(lpss);
-- 
2.56.0.307.g5fe7bd680c-goog

