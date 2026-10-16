Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38A4AA00F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154782; cv=none; b=dsZaVFof+08cjziWdMCWrFGK4Grx4mlv4X0NFORf0PIlw/7M4RmkHBs1mf5u84fjtzFO0Kn6GMp20eshiXREuvTUdpPxOrTHI6/RjkUiFXJRIm92sEbQ2AO8Pis3fR7Mi9ZnCC8PTuc/bEuzIUBMHEOwZ4lq4Gb/tFV+t5p+YsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154782; c=relaxed/simple;
	bh=V8vvEiOuQbTCyNnx2s4Py2QN+SBBIhE4P0oLXRNMnjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ0OvlA1hIWgrWo0XFD7V+IG/J+cdmPk4JDvK4Rhe3Yn5PZeMTWDLfW9ScOImisDIUbSB2Er+U92pghijJt1dFbYeRRIzpOkh2iU/XzBltMb3G3PX2Ns868KxvQYCe2H5SG8vC++nB56FM7SeRRm8mZ2As1GqOmK/eKAjD77AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt3rmuA9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt3rmuA9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so3766400a91.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154779; x=1792759579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vp2w6ovy70f2VqzeJRvoANmmDfJOujsOCwhZHkqjIQ=;
        b=bt3rmuA9/zx2E/FmZ6B9nX/YYYzM7HMSqNQjk6ow2GYSlo+8beKJfwmIL2KMHx2vF6
         /hUxYqpwsG4ffdmRayuqeJ9sT9CrNwJVOlXqv8v4g9ohLpHE3lWSuPrV4iUVSxzt/e+A
         INwJivS9wIQeTu2D+3SROrJKo902Z7Z7wQOdKG5WxGLW9zk0SLZcgOZjH1enB5w+0mJe
         JBSVrT31qn+EHOVrCFnpnJUPu37bmNua96o45fa37i2DWrZ12A2NwYupwgyh3baHpzsz
         c4TCq0PtnkSk5GutfK/K3EpbIPM1EKxz+ANtrfjCbOK8TxvBhBy648CPnmx3BEAB1oy7
         6Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154779; x=1792759579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vp2w6ovy70f2VqzeJRvoANmmDfJOujsOCwhZHkqjIQ=;
        b=PY18LT5LsQ8otOhHSNJnhtsVF4g0STCt9TACznqTnkbVvy0DZHLAY3TeqjWOnHJhEw
         ZwdIvSNtYmQhyXf8vSjk10VLBc74NOCv3vFG/eQhzWX2tiE/FEf7PbXR+5OwY/tkq6ej
         kFJ3vMq0Yo33MwSukzDxpKnk0u6UZ6C5dvXCaSPPnmCWmtr+q+OeArVvnlotWZO7v4Wo
         kxg5074HLV3hp1XU/JmyYeGwXOgeIEa2AZU4thC6GAiqicm5nbdWv5qtW9MPgzFNinrK
         Nr5tRuBxMqisLvWURL/7gGi9AKJFYLBXvDyFJ7AREihcvhSqKkiw6cWDb7pWG+AC526+
         Ijgg==
X-Forwarded-Encrypted: i=1; AKwUvBzilFJMyO3rBTNsg6vvLL0IeUGdvN3Ae5iqu08niYCU5kRzkVRH3QsHcsBCZUxJN+L/8ymG6M4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIc+nt68koUHV9SxAuIQ6cOaw1HlPhNybLpca0t17MFsPkSlRNi
	2Ng2WzyTQMqKsfwGI06+WkTBCNlr0+jDpOaexcjKB8qnbUv6rDHvsxgo
X-Gm-Gg: AYBFou3z1aFpiocw+bte1F0BoC9NS4qhBVFH2PJDXIlBnwSNefUmv10ucMckDcdVFAf
	in+PAWK2YP2tGwmsydN/jC0wSCE62bq7iblMpqu8J5EgsnHQNuP+N/deL3vw5AAQIXYTgIoFzaA
	+qg78FBjo5tGa3BtfsfvKcTq3S3VpNd4jDQ46uAfgvRvkLV2AWR1ToVtJOCa8zSsoE1Auy2PFFH
	hBIzz2kuTZ4IPc30eWgFVqpmBoXdu+u4fKYJGyIGi5Ts4ui2wPOT4y2mTaNRdo0pD6aZd4njrvS
	a7Z9OgQH8Gn+VPR1Iq1/gMZNspxJPyNFIIl9F79VTD1KmG3Xdbs0YsV84fEAKwrLxN5yILB5hyQ
	5S45QRtIwl1O8sK6a84BafQEpW5TMkTLm6N/Kuz3x+kEWRo+J4xS6PGXcQ1TRYKEjMlIxv0A8KG
	gV0N9A2GwqRQNd6b1mGUpEK0TdRhDq+iQYCA6i4atA16n3cTtlLHHrLxjIKPFyWjj5cJoKRwUnQ
	/i3cUdk4PXFsg==
X-Received: by 2002:a17:90b:4b09:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ab3ac58076mr18715633a91.14.1792154779157;
        Fri, 16 Oct 2026 05:46:19 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm9089769a91.8.2026.10.16.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:46:18 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: brgl@kernel.org,
	johan@kernel.org,
	loic.poulain@oss.qualcomm.com,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: check the device address on every setup
Date: Fri, 16 Oct 2026 21:46:15 +0900
Message-ID: <20261016124615.61-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca_check_bdaddr() sets HCI_QUIRK_USE_BDADDR_PROPERTY when the
controller reports the default address from its NVM file, so that the
core programs the configured address again on every setup. The check
is skipped once hdev->public_addr is set.

If the first setup runs on the ROM firmware because the rampatch and NVM
files could not be loaded (driver built in, firmware not in the
initramfs), the check is not reached. Once user space sets the address
with MGMT_OP_SET_PUBLIC_ADDRESS, every later setup skips it, so the
controller falls back to the default address on the next power on and
bonded devices no longer connect. Seen with a WCN7850 on a Lenovo Legion
Tab Y700 Gen 5.

Check the address on every setup. Setting the quirk while
hdev->public_addr is set does not make the controller unconfigured, as
is_configured() only looks at it while no address is set.

Fixes: 32868e126c78 ("Bluetooth: qca: fix invalid device address check")
Cc: stable@vger.kernel.org
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Tested with the WCN7850 over UART: the configured address survives
three power cycles, a bluetoothd restart and an rfkill block/unblock;
without this patch the first power cycle reverts it. The NVMEM BD
address series [1] changes the same branch; the two apply in either
order.

[1] https://lore.kernel.org/all/20261015-block-as-nvmem-v11-6-f890ac74f87d@oss.qualcomm.com/

 drivers/bluetooth/btqca.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 22b08ab05b82..756a4a8d5631 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -686,9 +686,6 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	struct sk_buff *skb;
 	int err;
 
-	if (bacmp(&hdev->public_addr, BDADDR_ANY))
-		return 0;
-
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-- 
2.43.0

