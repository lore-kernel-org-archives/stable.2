Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE746AED1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271202; cv=none; b=jcSLScnOgQTWCnsrsXkpPId/rqBmSJA+vyEuAu8HVQ1cmJoPasl9Ey1AxY/i4eBHJMD6doS4JJRak+SoPBgJ9LoRxB6RX1SLnATozB5Z7ndztrpN+EwojHJP/v2m9qBSQgHCLFto32e+mFqoLjO6eYmhmuI0InNUnVSN1lUNYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271202; c=relaxed/simple;
	bh=ASZGUpiJMVkvMttdqEm5jfbM3f66Xwz6p0aUu3bPRYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzQG0VcfQarxrby57mlEaCQhD9dEf3jCTxYYUsWeUZFySHRg5UPit9ntqp7vAgPwrsvY/pTgiBiAeX3MRNulBAs42T8BWRoK9r1fb3jpD+GvFjOgyGm8kip2gum0I68Rqk21s0T1kwjf2vKEptlyDtOuzJgHFQ9W9ZtQwF5vi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QHWqx5Ww; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QHWqx5Ww"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef3so21368a12.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790271200; x=1790876000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TEYtUOQOXH98BowHh4021SUx4WWxmZ7LAdMLKV6U6Lw=;
        b=QHWqx5WwTZjCWUMBk5z9DUTrZKJMmv4N/N7KL49RSc76FXCW2fxu3e+LV5oNzFFOSL
         genwZsLygurVFmYXE4kWHa6N9wojrmym8f8v1IYuL8Dqx03Pdl1+jnHWb4Nfd4AQVFcY
         yHoi43PW80lU4QYXAtKH02C2vzNThtfjccYxcWw+mYQVoYhRCqhmp3kl2EtbNurKSuxV
         RuxLss31Er1sFI+S4eMnOTo3RKlRUeQRzcXwG8F1MmNqFgT+j9uTmwSPx+8Pyh6j5kJ4
         43I/I+9KWVrc5PVCRzGnK8wuMcVW2arAJe6Bp3u5qF3a4VDVAmemwySO6ULNLDt4AYK4
         8ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271200; x=1790876000;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TEYtUOQOXH98BowHh4021SUx4WWxmZ7LAdMLKV6U6Lw=;
        b=NOIEW1YqtysIjFSc5vIPuWcf7Hs4PyEe+PLjFpyFvsNKXkLijpL8yw4Em3bMToyvvv
         BE4dcl1P4oPCwdJgNTbnbrbt1SUekqqsaK1LMXvOEZpnD1rwt1sKdHMhnWHqgZsG2CyV
         Ne4qZqyhHc421VQ50bQvWfIsLpgAHv2oo4V7J8jvXpMW+AEOqc1//6Yuf0fKkvajtnYj
         2NFhfp7WpnZ1yM62VL2/54fhKCkBsWeA4JOa4vvqdhAMDfYA0foDkOUT6hgVZ+E5ZTFS
         wNaDvq+TenVVrJmWNZoWDEmWSMIHMbu9l5I3d+836oAfkjUbp9OCTTd6bNNAUeufqV58
         DCAw==
X-Gm-Message-State: AFuF++n9xhuSYAudS7GxzUkDSMy8+reGNpEXTciKRQzli3BBo/576gya
	752y/ABsNb8SnPrrlvPUcwEfauWFz388KTXzFfGceK6gcjNrP/r8plpE3L3MBrh6FsGV1LA6szp
	ZiKLFw+g=
X-Gm-Gg: AYBFou2CYufmTUBKyJcdbcvdMvgBW4VL7UgGZZY+4p0QogHMwYIcCDjIzU3XIPhEPsk
	KxU6luAFsFqEXlyB9uQ1BXuwnAqQrPbOA08Aw0PymZHrwoonQrX5UogtLtLKQ0AzFrHz6wkUIkZ
	0QSQzomdUv/WVIZgYR/V80I3jLN7cT2eVgDIm9rQetuxBtUS87oFcJ8E+3V0zvfAxTId+DrxuRP
	fRNqC9yy7dDUHuZlppJLCcc0GykHDRLsYvtCx7LblVpjFSbFVTUEyRvuQW+aLHa0J8GRo9qig3y
	TgW/R3f12XC8BvauU4waYJKoUcmfNCj09XX1zpleVzTGjl4a1jZLNdLH3w1mdMpAAlPkKjfSO3q
	KymTfSQcyuaZcv7E66s51Rfwu6c1SiHM6PdWdhlN8NLBoCl3ZzOVltO9ouq8h59B04uMdRvjI3L
	BxSmp9EYvVHuHyi9LbkwwP5opuIFnCZXDqj9mdpqkpiPEj8ZedX2RXx6W04b2GdAsj9ZwYvpLeR
	/j2uEXj22BTvzNW9WIAReobUVEpZUnnBkI3z0xOVgo0e+pafZ7K8rFXNlntQV9T6GbM8sI=
X-Received: by 2002:a17:90b:180d:b0:39e:58fc:1d73 with SMTP id 98e67ed59e1d1-3a098d962eamr3209318a91.23.1790271199889;
        Thu, 24 Sep 2026 10:33:19 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:f875:3165:4649:e818])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f2cc3sm6097171a91.6.2026.09.24.10.33.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 10:33:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Yong Zhi <yong.zhi@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?utf-8?q?Fabian_W=C3=BCthrich?= <me@fabwu.ch>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH 6.1.y] media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
Date: Thu, 24 Sep 2026 13:33:12 -0400
Message-ID: <20260924173315.87556-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 284be5693163343e1cf17c03917eecd1d6681bcf ]

When ipu_bridge_parse_rotation() and ipu_bridge_parse_orientation() run
sensor->adev is not set yet.

So if either of the dev_warn() calls about unknown values are hit this
will lead to a NULL pointer deref.

Set sensor->adev earlier, with a borrowed ref to avoid making unrolling
on errors harder, to fix this.

Fixes: 485aa3df0dff ("media: ipu3-cio2: Parse sensor orientation and rotation")
Cc: Fabian Wüthrich <me@fabwu.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

[ Backport to 6.1.y: apply the sensor adev assignment in this tree's
  older ipu3/cio2-bridge.c and cio2_bridge_connect_sensor(). ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and IPU bridge maintainers,

I am continuing with CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53336

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 drivers/media/pci/intel/ipu3/cio2-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index df6c94da2f6ad8..e68b735a150a9d 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -280,6 +280,11 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
+		/*
+		 * Borrow our adev ref to the sensor for now, on success
+		 * acpi_dev_get(adev) is done further below.
+		 */
+		sensor->adev = adev;
 		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
-- 
2.39.5

