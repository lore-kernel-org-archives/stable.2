Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A43BCD1E
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829944; cv=none; b=XqPjh+szfSU62AOXhMrfuqHv4+64I/32iV2JiZ9qcGs5Jiy+mlXpK5M7XT1uHSizgyqrH5+ahdgwYkdh6c+i8lo2lgjU7GpUa8xvTX+imnF9/6xOIv2FV75mJvo+CBo1fKUKCyjdM3m18VNQx/ixOSGLXIQvhaDc5vAjpNMPpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829944; c=relaxed/simple;
	bh=cSXL+FyasWHX9BJAX8tqgjRouttLDk5Tcanh9t3zTLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHgcvWd3or+Xo+EmpS9XiZGamgKa54G8PrRaa26AK2Tx3nTwky1zt0zkQR3DwB0rNZ26icp+xi+Ifqak7JvJ34EdyCUbI2z0KdBX5SAfmPmarDmGlU2mgWidHvcqMSStQhybkG6am5p5bh6CWWtNgoaosFRwO8HJAxadzs64ZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBOjV/Zg; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBOjV/Zg"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b4f2d90c4so2229213eec.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829941; x=1791434741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qcb3FfIrBxLpO2EHSQg6zxkLxfR+fnWXXmdDoehAGw8=;
        b=lBOjV/ZgmBEHvu+ZaWFAzABCXR7w4B2SyTLy3fJI6Hn7ZfZSSjp9efIkFWzIeC2Ip/
         8z5tL+89wo8S75I+N6RxjtSHAPcx+pqAdhL3gxMyWYEG9sJCwunvWUb8AkwgBf7FXSC5
         Oao8BGiAU2us2u00/HfyNqkG4YhBwH29W2VCCWAMUXIBxpPoAzrj6nMaly6UON2+e2G5
         Ib/gS8CLFw1xrLNH008TR0+Mt2SQxYk0bE39P7n8NRoYOzWt0kS2hcCJlV43OwFb+/04
         NVmnRzwM2HLQORaHAd2BAQ83O/4x9V9M+CAVIat25RWUVTNmR33s5nt8XnFUjUxUXbAm
         Outg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829941; x=1791434741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qcb3FfIrBxLpO2EHSQg6zxkLxfR+fnWXXmdDoehAGw8=;
        b=COcj+Ut3abDmgU6vR71Zoae9mLxaiYat9KdA2zjAc8LA5sANti4h3ueUJ/Ylqhj36/
         utEqXSsnxkvy90xipj//Li8FbctSiuS+xHxIDXACwf74YxFfHElnLGnQd03wJef1EjPd
         iNVpE6BQphMjMBGg82m++pkC0sM3xLN7tjXMG8p1IgHwB7a/NQc+H/RGveZvOlw7teZL
         ZoZ6vfPYVK6LYtitTChwp1zE19jvCgXjOEISsrBbiFRqDxFH6xoU115ii4mfT50Nrd+Q
         85cGMa6KMYmmZyAdNeVkiPfttgu8XT9rVCWKpStFFMmNbuqVAI2wJcQgrins/yFS4MmY
         59sA==
X-Forwarded-Encrypted: i=1; AKwUvBxaiPf5OSYcE1JfuQHhuZNb7o09fOENaIg24RUORoj/zuW7JKTIZBXdytes8QIf+o7LCYKW74o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcWbhYCAdwFq+LAoy28+4ETUWt+yeNf2JP+nS3Fi9rWDK1UTQO
	0nLTr9XQuFreAL9sZ4q5J+mblfEMt4IqMepeNDfEdjRsOmpwP3vYvC2f
X-Gm-Gg: AYBFou1KiZQGgqlpK+5k84cEko0nmFEUnRyY5h+yOG7sJxUDp90aGysiSiNl2rUPZPL
	a/xKXV1CqVKgOTnjD+oPQp5cH0D3kpCK82ba5+n3hZ7ldhDwhVBC21lXtbSP+qt0nOr5vm4sYfv
	YjZH+Jos3BO8mamRlb3vP1jmkxnTzKOEuMZk8nXBDA9vso0/LJKsa4fZYF6r73ycnv3ylafyMiZ
	6LtD5W14PV4AUXh0FI+DPhAUdrRnQTG4SuaUCQNK4caOA6sTs4TJYcvcd5ilA1BkMBp2ahWlLOY
	tAAk7i/rkd4rHCJh/gbpEm+26xsmbEDYWqVLLA/YJdMzA9+JW0k8xwKTU6bXtZxmW1eObK4CEAb
	WhtHpi/zzqEIns3dEChAseVuTKbqwcFx+4IAMcFR6L+bZwIESq64x02atp6AMn3/Si98KF637T0
	9Z/a1h0cG2WaQ9g/+MqEyO+dvkBRuEv6JSxpP4+Bl8i3O+Lu2Z3/fNCW75X7twBMZm4ftYulqil
	VzZgFBZtFr0aY/02zRfHTnZOpH7I66avSb856y+FRjjr18g5eS1oegg+QaTOjM=
X-Received: by 2002:a05:7301:6192:10b0:34b:2362:90a8 with SMTP id 5a478bee46e88-34cdc4c0558mr3779399eec.19.1790829941087;
        Wed, 30 Sep 2026 21:45:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:9835:e0ad:476f:74a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db3e3414asm3891332eec.19.2026.09.30.21.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:45:40 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 30 Sep 2026 21:45:30 -0700
Subject: [PATCH 1/2] wifi: carl9170: Revert "carl9170: devres-ing
 input_allocate_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-carl9170-reverts-v1-1-7033b5716c14@gmail.com>
References: <20260930-carl9170-reverts-v1-0-7033b5716c14@gmail.com>
In-Reply-To: <20260930-carl9170-reverts-v1-0-7033b5716c14@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6c14f

This reverts commit 87ddb2fc29f10cf689ff0dfb88a19b7d3687006b.

carl9170_register() is invoked asynchronously from the
request_firmware_nowait() callback after carl9170_usb_probe() has
already returned, and carl9170_usb_disconnect() calls
carl9170_unregister() followed immediately by carl9170_free(), which
frees struct ar9170 (including ar->wps.name and ar->wps.phys).

Allocating the WPS button input device via
devm_input_allocate_device(&ar->udev->dev) ties its unregistration to
the parent struct usb_device rather than the driver lifecycle. Even if
it were tied to &ar->intf->dev, devres_release_all() runs after
carl9170_usb_disconnect() has already freed struct ar9170 and
unregistered the parent wiphy device. Consequently, the input device
remains registered on input_dev_list with input->name and input->phys
pointing into freed memory, causing a use-after-free when reading
/proc/bus/input/devices or when generating the KOBJ_REMOVE uevent on
unregistration.

Fixes: 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 61c7a1288743..702b6d113b18 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1500,7 +1500,7 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	if (!(ar->features & CARL9170_WPS_BUTTON))
 		return 0;
 
-	input = devm_input_allocate_device(&ar->udev->dev);
+	input = input_allocate_device();
 	if (!input)
 		return -ENOMEM;
 
@@ -1518,8 +1518,10 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	input_set_capability(input, EV_KEY, KEY_WPS_BUTTON);
 
 	err = input_register_device(input);
-	if (err)
+	if (err) {
+		input_free_device(input);
 		return err;
+	}
 
 	ar->wps.pbc = input;
 	return 0;
@@ -2044,6 +2046,13 @@ void carl9170_unregister(struct ar9170 *ar)
 	carl9170_debugfs_unregister(ar);
 #endif /* CONFIG_CARL9170_DEBUGFS */
 
+#ifdef CONFIG_CARL9170_WPC
+	if (ar->wps.pbc) {
+		input_unregister_device(ar->wps.pbc);
+		ar->wps.pbc = NULL;
+	}
+#endif /* CONFIG_CARL9170_WPC */
+
 	carl9170_cancel_worker(ar);
 	cancel_work_sync(&ar->restart_work);
 

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

