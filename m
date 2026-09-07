Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1059525A8B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811233; cv=none; b=Y+AIlVUdKDBdGLntges/JNoWeeL2GG15FC/WvOu52YfO69qHZoJkoEnkYo930ZlRil09N4U+0Y+jz8KWC6mvcT8yeMz8vKeigo5kMEnpqpjVlEDDyNFHTUqUVnhPRhJRLvOm3ci6RxXZsokMfqSPwb7XKxQegloxG/noTBYKovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811233; c=relaxed/simple;
	bh=Y5k6B+vT81t3hejFL5h5jGxAKtf/27X3HIZKCeWcU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m99wABjTqtzmsOLL6EM7eoV9tWv18sZ7SofVJPk+NrfDe/9VZSCutq+3R502SEmEC4+Vgf9o038VOA8wnbNA3q+iFcaBzoDPFBnQcRS/WuzUNZEgIuDoJVx1zGVnb5jreZ4ciP3RzB4Sxf1qT0y1DQVhLamVnkqUn429k01Z6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxV3pjCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxV3pjCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B6D1F00A3A;
	Mon,  7 Sep 2026 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811232;
	bh=Kirg9w9vTQJ3WBUcxiHpQ3qf2pHN/hYO1yNqv3J0wFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cxV3pjCTBZyM1i1671bTOdku3x86D6KIcHaxb4QwJNrtO3l4eOI/mZZm9utqI+NHt
	 XlqltL8pMqj1PlOXeMzD9xHnk0t36vMWrxGpdZs8OZbMljPLZkuxFsdcDaMbuqARTZ
	 oqKaoYu+S7AtxUCb82PYwbR4BcZIMpUth1ETsmvwacdEd+cNb+D4nfNUwedcnaEqNT
	 p19Ty4Symzz/mxaIoAzfqAordsjyI4ccQb6ons3wQGS6Aryhnx8sttY8yqOsUvt+wn
	 trg1V8b7Ri51ARGiYiNPk14bIT3iSvPieToCRDiQxK/hP7pCAFJB1DMrHTbJdcZ5Mi
	 g77ci7THo63TQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] HID: universal-pidff: stop the device when force-feedback init fails
Date: Mon,  7 Sep 2026 16:00:28 -0400
Message-ID: <20260907200028.327195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-slit-cash-4d51@gregkh>
References: <2026090356-slit-cash-4d51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baul Lee <baul.lee@xbow.com>

[ Upstream commit ce08c5555cabcd444d8b77fa69a7cb68bb05f611 ]

universal_pidff_probe() starts the device with hid_hw_start() and then, if
force-feedback initialisation fails, returns the error through a label that
only does "return error".  The device is left started.

The HID core does not unwind on the driver's behalf.  __hid_device_probe()
releases the devres group, closes the report and clears hdev->driver:

	if (ret) {
		devres_release_group(&hdev->dev, hdev->devres_group_id);
		hid_close_report(hdev);
		hdev->driver = NULL;
	}

The hidraw character device that hid_hw_start() registered through
hid_connect() is allocated with kzalloc() and added with cdev_device_add(),
so it is not devres-managed and survives that.  With hdev->driver NULL,
hid_device_remove() skips hid_hw_stop() as well, because it only unwinds
while a driver is still attached.  The registration therefore outlives the
device on both paths.

Opening the surviving /dev/hidrawX writes into freed memory.  KASAN reports
a use-after-free write from hidraw_open() -> hid_hw_open() -> the
transport's open callback, which takes a spinlock inside the freed object.
A descriptor that carries a PID usage page and no input reports is enough:
hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
stays empty so force-feedback init fails.  The other failure returns in
hid_pidff_init_with_quirks() - no output reports, an allocation failure,
pidff_init_fields(), pidff_check_autocenter(), an unusable effect count,
input_ff_create() - all reach the same label.

Stop the device on that path.  hid-dr.c and hid-emsff.c, which start the
device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, already do
this.  The two earlier gotos must keep returning without hid_hw_stop(),
since neither has a started device, so give the path that fails after the
start its own label.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ adjusted context for preexisting formatting and spelling differences while preserving the 6.12 code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-universal-pidff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
index dc1b262f28331..be41e6056c5ea 100644
--- a/drivers/hid/hid-universal-pidff.c
+++ b/drivers/hid/hid-universal-pidff.c
@@ -101,12 +101,14 @@ static int universal_pidff_probe(struct hid_device *hdev,
 	error = init_function(hdev, id->driver_data);
 	if (error) {
 		hid_warn(hdev, "Error initialising force feedback\n");
-		goto err;
+		goto err_stop;
 	}
 
 	hid_info(hdev, "Universal pidff driver loaded sucessfully!");
 
 	return 0;
+err_stop:
+	hid_hw_stop(hdev);
 err:
 	return error;
 }
-- 
2.53.0

