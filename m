Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC542CB12
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442320; cv=none; b=GXuAD2bIjnO/pDIPn34RozZ/NgpTjcI3OJimeq+OljX/jyBv0gvuQ8zKF8scsvxuSZBqCnE1gnhNAEOc/kH3bBtxCXEC39XP+nP5/EG9Z0BjksSd5O0s0m9/j76vOK+uGIKY0mVZwnb5sQ6QoGW1NJqEA6QImZDL1veKWPP2wA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442320; c=relaxed/simple;
	bh=SHJKKXa6Qxl1b1vatYjKpZOHn+aOrWkwm9LDa9rhBCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgS6tvfhe7+pmMHNn3udp/xX8liEiptTQuMIBuyD7fh4LwiA2v7MKc11scHXukbuH6N59dAAndjKomJsMkkMIyASPKFtWTxlV0JB6BzXRKH9OgDgBpGzM4hjNuQOvplfanZKzGs5d3Y/SBI86/jq30k6LEO36577Wrgo7BEdxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-84a2c90e383so617047b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442318; x=1787047118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9G16LNyyTi82BYCiJ00/MXPiMBCTYGTmoQ2/cxSgig=;
        b=DtsqR5aZP92idspg+pFFm/p9LuZz7Tq79yB9Eg0eo4YQpZYj1SfmoyeK+Hv4AhRJ8+
         6a4xIEhoDyTdyHkhOk81XU5sqpdxcXBE6Zu0Vx4WRG55qsRExrUpLwBkno6xRYP+5ELZ
         6CVFyi9knD+5YgPmfnh5ZuKpTtzy8PyNAgD5v7Pu4VlyI/auscMEZJW1Gzd4gv9d8+ae
         DOp4EN1hXg5g75PQR6flkj/zuhckjczjqa+n0pEfrN9okT891W1PwbIiFjZkopfYn2q8
         lUIZYqOjaRGBqby0jIsu5SQNjGsEXMuyL4cWzKLd1ZNQhFgdLeKm5VoGFiUwgDAViJy9
         bc6g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5HVNT3KTvU7jdv2FYAiISsCyd2VY4iNeQfrYaNgqpPWuQyZS+PAHRSUO6Q/LR8LLxV9aaboI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/HV7aGBcXel6mwhTWEAviXx9qkzm52nEZkaI5xiDrDICzOHT
	E+FJnW1XuMi2EtvLEK6BzNk1CEX3i2MIXxIcb0l2gh1UEL7O+8GEuLqn
X-Gm-Gg: AR+sD13AX3QgReFQEFyB5TTQOfiT9o3vx5nEGKoRpgDUpvQ9mu5QrxY5lhE4pdL0O+L
	UMhkM8U/44lY25KNmPusgAHnHksENyTDiuihOZlfKAGQBdyStYJ/uLPAFZdIwHKEyt7aaRD3G8K
	NCA5bwfoMOrTQJMmsmJoZyIE0+fdgMJtQwAL5s366XOESE1XorTIosYvvQHuWauhNxPVplU6tJ8
	nNbyRSa22e8GNzS1UHm2oCysXvTdQqq1Kps0ilvIp2mlkioHs6evIcCdH0bGopdLAUvf2fRIBH3
	mIUYMktfOQOnVJh1dsd85sUEamFcnhwSozzb3LdQEBayudF10Alycl4mOsQ6uMwy1D2uT2iWYfr
	5leiaIznzz0mZwS2URXIfjYZPb2iTkS9AIJv1pL13WNRBMpBXmZBdR0RA4XOBp+UvE/h2tdYu+0
	9ggeXENqY60vRh4HIV9Amdkj3WNuS1R1rwWzrg8aa1kIT2VFnuRgvQIhCRNPIRuuBtpbA3USWr4
	G8Hyl3Bcw==
X-Received: by 2002:a05:6a00:228a:b0:84a:2b96:5986 with SMTP id d2e1a72fcca58-84fa889d2b7mr1889004b3a.8.1786442317744;
        Tue, 11 Aug 2026 02:58:37 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed970200fsm661840a12.7.2026.08.11.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:58:37 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: pooja.katiyar@intel.com,
	johan@kernel.org,
	pmenzel@molgen.mpg.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Add ACPI_COMPANION() NULL check in ucsi_acpi_probe
Date: Tue, 11 Aug 2026 17:58:27 +0800
Message-ID: <20260811095827.1001654-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for ACPI_COMPANION() in ucsi_acpi_probe() to prevent
NULL pointer dereference when driver_override matches a device without
ACPI companion.

Since every platform driver can be forced to match a device that doesn't
match its list of device IDs because of device_match_driver_override(),
the ACPI_COMPANION() may return NULL, leading to a NULL pointer
dereference at adev->dep_unmet.

Test steps:

  $ sudo modprobe ucsi_acpi
  $ echo ucsi_acpi | sudo tee /sys/bus/platform/devices/alarmtimer.0.auto/driver_override
  $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/alarmtimer/unbind
  $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/ucsi_acpi/bind

which triggered the following crash:

  [ 6599.180948] calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 24208
  [ 6599.181198] initcall ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] returned 0 after 207 usecs
  [ 6729.051074] BUG: kernel NULL pointer dereference, address: 00000000000005f4
  [ 6729.051102] #PF: supervisor read access in kernel mode
  [ 6729.051113] #PF: error_code(0x0000) - not-present page
  [ 6729.051122] PGD 0 P4D 0
  [ 6729.051136] Oops: 0000 [#1] PREEMPT SMP NOPTI
  ....
  [ 6729.051300] PKRU: 55555554
  [ 6729.051306] Call Trace:
  [ 6729.051314]  <TASK>
  [ 6729.051327]  platform_probe+0x41/0xa0
  [ 6729.051348]  really_probe+0x1a9/0x410
  [ 6729.051364]  __driver_probe_device+0xc9/0x170
  [ 6729.051377]  device_driver_attach+0x46/0xb0
  [ 6729.051390]  bind_store+0x77/0xd0

Fixes: 1f3546ff3f0a ("usb: typec: ucsi: acpi: Check the _DEP dependencies")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: stable@vger.kernel.org
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 18286d3e9cc5..b4a783217dc6 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -188,7 +188,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 
 static int ucsi_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
 	const struct ucsi_operations *ops = &ucsi_acpi_ops;
 	const struct dmi_system_id *id;
 	struct ucsi_acpi *ua;
@@ -196,6 +196,10 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	acpi_status status;
 	int ret;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	if (adev->dep_unmet)
 		return -EPROBE_DEFER;
 
-- 
2.43.0

