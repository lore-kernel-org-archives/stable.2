Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4B378D64
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316247; cv=none; b=GD6JsgrGhCKjAkAnhpJ6cdk+hxbi9CIfQEJ1SYivHEY4Xs/WvM+vx216qZpGCsa2HZSe+wCKTCw3XlCEoi9EOGP2wURVZ2U9Q0OotbNbgc7gfAu+yO+qOSopVgw3vvOYVIQtpujDXkOSkAoOg0pme4mjipT6PckmP68kbuNGQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316247; c=relaxed/simple;
	bh=GjaE3MsAbjPJQ1dggwys39cfoeiLLhm0a0kTiHOTNFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGgCEeSM0+qdCBZa1BAD1CAiBvAmvZEdMqvd6cnDb1LceDpPMJkZFwZEbquXvw7i34G3nYCSC7MooE8JeEF9JtQynntT12n15qj1cQE7lEYSGr7N8Xfdah+PszKacacADfDk5j6CB05TQIJIApQR8Wp0nsU9ri73E2gSi9Qvt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnvmjoLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnvmjoLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC161F00A3D;
	Fri, 17 Jul 2026 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316246;
	bh=fu4I3hcl1ZvBbs5WAiEcRvsNhXxkK2Vjo/miDi+Xd4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XnvmjoLehAEUE13xMz43NawGUO11b/OBsdcnMQ+OIHwVFIAJLHs/W3VnFCGJcNPQn
	 H6N092ODAIF2a24kygmC06tWmSJMlu6UeFeHdmblYyw1SUKA9pAvp5nBHGLMNrS7bh
	 ad7ao0u0CEGozoh7+3eyX2Ldg0s0tE1fHqD++945CldRGNgL+W/0XHq1ceJ3vC8Zw8
	 zv21iv/rE5ZkYjjm9v/Xw9q4+tRB7GsCGAVmL/tqnz2DIpxNDlRitnWhgSLdJcSYtx
	 RcPiu3HYeDgc5uORq0Y1gKJlT2TRX48Q3WnOkSPgs9FsQ7o+DgkCReg6iAZyEYSM1k
	 zYOlGmqB1kOFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] HID: pidff: Add missing spaces
Date: Fri, 17 Jul 2026 15:24:01 -0400
Message-ID: <20260717192403.2131944-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717192403.2131944-1-sashal@kernel.org>
References: <2026071445-promoter-disburse-fa77@gregkh>
 <20260717192403.2131944-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 61ea33ded9327a07d9ef85a6933cb6316e2f185f ]

Fixes checkpatch.pl errors

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: b251598b8bf3 ("HID: pidff: Use correct effect type in effect update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index f6c294a0a318ca..79ff9f4f67d1b3 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -251,9 +251,9 @@ static u32 pidff_rescale_time(u16 time, struct hid_field *field)
 	int exponent = field->unit_exponent;
 
 	pr_debug("time field exponent: %d\n", exponent);
-	for (;exponent < FF_TIME_EXPONENT; exponent++)
+	for (; exponent < FF_TIME_EXPONENT; exponent++)
 		scaled_time *= 10;
-	for (;exponent > FF_TIME_EXPONENT; exponent--)
+	for (; exponent > FF_TIME_EXPONENT; exponent--)
 		scaled_time /= 10;
 
 	pr_debug("time calculated from %d to %d\n", time, scaled_time);
@@ -587,7 +587,7 @@ static void pidff_set_device_control(struct pidff_device *pidff, int field)
 		hid_dbg(pidff->hid, "DEVICE_CONTROL is a bitmask\n");
 
 		/* Clear current bitmask */
-		for(i = 0; i < sizeof(pidff_device_control); i++) {
+		for (i = 0; i < sizeof(pidff_device_control); i++) {
 			index = pidff->control_id[i];
 			if (index < 1)
 				continue;
@@ -638,7 +638,7 @@ static void pidff_fetch_pool(struct pidff_device *pidff)
 	struct hid_device *hid = pidff->hid;
 
 	/* Repeat if PID_SIMULTANEOUS_MAX < 2 to make sure it's correct */
-	for(i = 0; i < 20; i++) {
+	for (i = 0; i < 20; i++) {
 		hid_hw_request(hid, pidff->reports[PID_POOL], HID_REQ_GET_REPORT);
 		hid_hw_wait(hid);
 
@@ -869,7 +869,7 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 	case FF_INERTIA:
 	case FF_FRICTION:
 		if (!old) {
-			switch(effect->type) {
+			switch (effect->type) {
 			case FF_SPRING:
 				type_id = PID_SPRING;
 				break;
-- 
2.53.0

