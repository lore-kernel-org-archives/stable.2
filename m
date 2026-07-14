Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142342BEC23
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035614; cv=none; b=CLKO03sqS0rKqjwVL+yu76de12dLm1KgQJ/wt2qZ4eP3SfkJCpik1vXgeWS3K/nkjPnCY3pHtYOFN/W91K7dQU63XM4efevNSFh8P098la+SlDUasNQFBSUcQb7yf+Zxaum/17Bu6Pv5bUgyTqcmCPQ9yOcDbWpdgu2z1s9tp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035614; c=relaxed/simple;
	bh=UmcvbKMXZBKtr/70K2aFTPQQ4an2RvyDVGPcypOzLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1PN1y+S/5EKvirFxXAt3FLAWdbLkE5EcrL7Y0pcQb/FDGLxjFN3P1OzBqwjjpGHPaNs53GAPOoRQyBYpChrVn12CCctYD75SGsKLBlHqciR7koy6zi2/YAN5TTSlZCkuOkLlLYd30UFsmpqTv0zGgDCt35fedkbIybnu4OjI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcLsElDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcLsElDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4980B1F000E9;
	Tue, 14 Jul 2026 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035612;
	bh=0FolU50PUQYoKq2eoRAz6snyE5uNhUgpusbIJoC8Opg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcLsElDUwXzUeZtGXc+yOvpvyobwpYZsrFtiOUKyIb7+71HiHweF02BfKWc9aLZRC
	 WyjG6vpdA0oAV9D0unFx3SHC4CWQGK+CFhS7xrrOulY1M3FFjS5gXlS7pza3+dhC9+
	 4Dxo7tpBklZbIXP1MhgHIBlGgMWXkxOYQr2+RpjN+24W2lPuwRhAOOK1Ax7b2jMDcl
	 HxkZdMipanqMu3LJ01ZIyP2owktqShSvFF0SWae7DrILDo94X9gW9+srOGPKKhXvuB
	 UV8H0rRZbvr1pbPXjJ0rm2IkCg59RvzYtAIUJVXvmps/SOLQjxaRcQgpm9Y8BV7c5t
	 Ud4yZdB9uj3Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] Bluetooth: btintel: Fix offset calculation boot address parameter
Date: Tue, 14 Jul 2026 09:26:47 -0400
Message-ID: <20260714132650.2663656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071309-contempt-purposely-3c5c@gregkh>
References: <2026071309-contempt-purposely-3c5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran K <kiran.k@intel.com>

[ Upstream commit d00745da644d42c2f97293eb3fe19cfd5c0b073c ]

Boot address parameter was not getting updated properly
due to wrong offset

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: c5b600a3c05b ("Bluetooth: btusb: fix use-after-free on marvell probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2538bdee31d8ab..a7efbadc3d146e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -863,7 +863,8 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 			/* The boot parameter is the first 32-bit value
 			 * and rest of 3 octets are reserved.
 			 */
-			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
+			*boot_param = get_unaligned_le32(fw_ptr + frag_len +
+							 sizeof(*cmd));
 
 			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
 		}
-- 
2.53.0

