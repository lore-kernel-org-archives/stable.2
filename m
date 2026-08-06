Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639C48097C;
	Thu,  6 Aug 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031687; cv=none; b=c+UjKV3YZHKihHjWbegEYV3y2Qt82NdRGVgIu+tFIz7wHBI//oKW+CUOMEA7QtOX46fm0NIaWdNlsdW/WuGAkmF1AnObZbF9w8K7E0+sXyYRzkiKVsmi1RIbnPHaGqLWnP+zyfr3WjLmVNH4V5iUsFXVKamhgZ3dWcOhhaaBK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031687; c=relaxed/simple;
	bh=jzGL1qmq9aUI5fjdj/L8juoMvh3eVaHhnKk6Ix2U4qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev0TK/FzMnXxxItcXOTasHkqffzWMmicR8gF+V9ndxcMAYR9W/OlBEKN9n2FAINxHhFjxJR+ygD3/jzwDAIraRo4Oo2YkK8UKk5o61O3JN2PKNeYUk1jgQcERDI0BEdXDvBZub0dO70tz6LHJe92jruRx7bl8VAQIr2FixaI/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYVyW5Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYVyW5Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73AA1F00A3F;
	Thu,  6 Aug 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031678;
	bh=IP4yAv7j7CcaHhlgDbcviVT5BzvHlHrIsRkF092L1HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYVyW5NmQq7WAmaWdWy3kiaOucRqKOw3v+qXMWVmY4goe1YfoTCfEphQujDDEg5Yw
	 1G+HTQakfee9Anb/Ch5r65jPWXRIxEK//b4c/Ww9sFrnqhtCVKHjjP5d4KuAZPV8Tc
	 B8t5yPE4TkAcyyFMncJlI+ggQ0DQ8dBPEPjEE3pMm5/LlxiatnL3ZYbb0BLuTZ+Izx
	 vi06jSsu8EXmEFPE+uB7AM0zEC6QbK+jz0eb5sMYQa53eF2OYEWPQzaqu1xaDRu+2L
	 Q4S1RrHeP42HngtekwsWZqpfEefJsZYP0OwoyZhavJ+DSKcvfCV7nNsL2RhTkS0+vS
	 PuZLObyHZssfw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2 3/4] EDAC/altera: Fix code leak on dci allocation failure
Date: Thu,  6 Aug 2026 10:54:11 -0500
Message-ID: <20260806155412.1518582-4-dinguyen@kernel.org>
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

sashiko reports: If devres_open_group() fails, the function returns -ENOMEM
without freeing the dci structure allocated earlier with edac_device_alloc_ctl_info().

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f44..ccdfb35178b69 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1516,8 +1516,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
-- 
2.42.0.411.g813d9a9188

