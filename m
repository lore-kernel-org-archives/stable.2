Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41743BB675
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764468; cv=none; b=vEX7pejfw8jqUQe0jLTLRbneG7STbIFnWUhQ4UScPlRZDRExwtHDpOyMAskVRqyYjWtGLdoyfNsEYYYTatxf/mnmtxEpDxhsrfN2bIl7E+MpaFhpMHo/qQ+bhvBt/grb/ocsya57GRoAAgUJAHS8PAdHPdH4xky+L3tXJkVCqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764468; c=relaxed/simple;
	bh=pd3AwtHHtCMtDjHZtiiQ53iIQxPSGCKSyU7zQwbk8XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1wUgXwZ0cLB+wF1wbDnlXSFqRUD/nGxbwTKCaIbJp6fy8DK2vyFY0yvAacalSY7E5NsUzh3TFCtfjfqdXevJ/hXWV+d0HVmGkGqsp78DII17sqF4DnA/ahKM+mgFVZQyGnxe4EQVN5SWA9m4jjb2UnsnvT/YpEwdril/OSOdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzrxJ3nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzrxJ3nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA161F00ADE;
	Wed, 26 Aug 2026 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764450;
	bh=PE35f6QYYq+HAuG6J4k67w79hNSHLXdLuapWALLzWdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MzrxJ3nuJ3cZdJ5BRn6mAjKUdCQnNkfqfBZDww56Tu1FDyVuK4psTFMCCnxGCj5nR
	 mb4F9ZUsd4bxEtSUMtReQYov8c4gwBA4WL5D+b+yMtM70/v7/jTZnjyaAIDQm1GAPy
	 DNwP+xbB2W9dAtbfVWk5U4iwaZU45XcQKjBLaho3gF6MTN/lERoAbnAWrivQSXQ8xu
	 otmC6xwF7y9EPsYO/fVZT26Mvv0efGNiWsWND7CaW1m1oKQOXFjJKnS05q6IPZgaW9
	 47j6R2vtLcLlu4koJNGBlX+yr8BhdXcnhaM/QA4w8LQrOZPXLKTP/SfI3WZzEZMS6H
	 cJTEMhvjsfIdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] HID: pidff: Support device error response from PID_BLOCK_LOAD
Date: Wed, 26 Aug 2026 13:14:06 -0400
Message-ID: <20260826171408.2245886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082518-countless-imply-6af9@gregkh>
References: <2026082518-countless-imply-6af9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 9d4174dc4a234408d91fd83725e1899766cd1731 ]

If an error happens on the device, the driver will no longer fall
into the trap of reading this status 60 times before it decides that
this reply won't change to success/memory full.

Greatly reduces communication overhead during device error situation.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 67bb1074e3d2 ("HID: pidff: fix OOB write when hid->inputs is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 25dbed076f530..46a10bb8b7431 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -131,7 +131,8 @@ static const u8 pidff_effect_types[] = {
 
 #define PID_BLOCK_LOAD_SUCCESS	0
 #define PID_BLOCK_LOAD_FULL	1
-static const u8 pidff_block_load_status[] = { 0x8c, 0x8d };
+#define PID_BLOCK_LOAD_ERROR	2
+static const u8 pidff_block_load_status[] = { 0x8c, 0x8d, 0x8e};
 
 #define PID_EFFECT_START	0
 #define PID_EFFECT_STOP		1
@@ -515,6 +516,11 @@ static int pidff_request_effect_upload(struct pidff_device *pidff, int efnum)
 				pidff->block_load[PID_RAM_POOL_AVAILABLE].value[0] : -1);
 			return -ENOSPC;
 		}
+		if (pidff->block_load_status->value[0] ==
+		    pidff->status_id[PID_BLOCK_LOAD_ERROR]) {
+			hid_dbg(pidff->hid, "device error during effect creation\n");
+			return -EREMOTEIO;
+		}
 	}
 	hid_err(pidff->hid, "pid_block_load failed 60 times\n");
 	return -EIO;
-- 
2.53.0

