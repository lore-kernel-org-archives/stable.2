Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF77395ACC
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811586; cv=none; b=ONWLUkQOG3isyFkxwWl+lEMiZFnDrhPY2iUy5TnigvczlTLXq7ES9HuF+I0nhT+Q7q8RXvDX2DRb9blBUUaaWmjkyXE+fuuQiT2i5W2DUeYoZOPwo9LSylTXE3gcEcax2D4ZSMnExppIQJB9z9TkR5eR9iLluHTmhFGGmffKknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811586; c=relaxed/simple;
	bh=lv5kc3CsoA941fsLXFE+OoZHJ9oFkOqqi3jzgubLuKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEI8swjsUwCYV2992RWkIczctDIysyeyzdZGzXWg+EjFFrkPNAAaAVYcxzpla9VlyYMdzXMFUcyzEfasIS0FZzcNpDCj7H1Rdkt4tT1zckZi+uChNODVkrpB4Ef1pHJwphi5MOaO/E3Eri8I2azEiw5acBrSxKTyXzouyJlGKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSq1e/1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSq1e/1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F531F00A3D;
	Mon,  7 Sep 2026 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811584;
	bh=zF0PlLT5/mKCkqi/tniFpZRG5K5bqfYwlqLhBNIHbnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSq1e/1eCMVVq8WTdLBy34zZXO7YsStdVaDZ0dc9tWh40Pp8NmgEh+YnR5zxUSGkZ
	 wofwE5Ck4nsLi73Iwpmeo6oD/wnIDxObbkNNBsaSHIz20IC/lNAqfYYJydoo6RtfKM
	 gauceVfKQbWkQa96rjl8Klo6L+SoEOqPJ/tEO/wbiVgp3xjLR/4jdN6i2n7skBV9Jl
	 qFV62PAng9z69EqdFnFl8qJi+peE+DPEe2k0sOIHAfP+8IwwJPQwa2q56IXqP/Wy/4
	 5dTX9yWFwJXJoUDS8KenRuP2WN2dbwu8Jelk18Rd6RO80cgPii4Y9h5370chgqTKg3
	 S5G0Bngpy/TAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] HID: universal-pidff: stop the device when force-feedback init fails
Date: Mon,  7 Sep 2026 16:06:22 -0400
Message-ID: <20260907200622.359066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-math-destiny-2cbf@gregkh>
References: <2026090357-math-destiny-2cbf@gregkh>
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
index 7ef5ab9146b1c..6806e3fe842a6 100644
--- a/drivers/hid/hid-universal-pidff.c
+++ b/drivers/hid/hid-universal-pidff.c
@@ -100,12 +100,14 @@ static int universal_pidff_probe(struct hid_device *hdev,
 	error = init_function(hdev, id->driver_data);
 	if (error) {
 		hid_warn(hdev, "Error initialising force feedback\n");
-		goto err;
+		goto err_stop;
 	}
 
 	hid_info(hdev, "Universal pidff driver loaded sucesfully!");
 
 	return 0;
+err_stop:
+	hid_hw_stop(hdev);
 err:
 	return error;
 }
-- 
2.53.0

