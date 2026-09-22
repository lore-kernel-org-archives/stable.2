Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C03C1F4F;
	Tue, 22 Sep 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059275; cv=none; b=qDJen8/4ZmaUjf6iSrjjLvttYZu5r980GAWOdS0Rydd/RLahBD62KIvWpLEhZupcFBD+v8Sowkaxi7iTvbJ/QB35BDqJjDDG0vjVoQqtP1SQV83xO3NQrwTvuaKVv/53DiHM8duHSHpo85RbuSzsPtxZIhFsdw/WKZYoymmw/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059275; c=relaxed/simple;
	bh=HbUu1acQFrw/8C7NvD7f55oDz5nuOcbTrQ5WFskxkVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK3cya3IUk4oF0Jq3rHoi3rrrjrXJXwKSu44WbdKx/TEccCvyO8XiHlsJ9jCdD8DlMrgV6Ba1ODFg7Z4j4VQh3IxD10hoX5YHUxmPzYWzUgnXGT270ToWQZX6leq3r34Q3JN7mbsyn4C1ycG6yV4DOS4LJnTY5FUcGIGNXiLjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXBrYXTV; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXBrYXTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059274; x=1821595274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbUu1acQFrw/8C7NvD7f55oDz5nuOcbTrQ5WFskxkVk=;
  b=DXBrYXTVESh0+n8NALJHQELeYLfXJPrnKC04cnVdF5jTGWmGKB7ief5r
   byc63WomdRcyOSmfJBEY0VqnQCkoxAsbN4U5iuRT8dAKu0QXsVVGvLXfd
   p/7ah8BHoC02ZcF3gb+jhFz5KRchAPIqgfKi8LOSYJo19aY2ur1kYhuZH
   6Kwf4tokqttLUmhDMMepa9/UigCWO8XaRXiIHB+513AnvjRXEZrA/dmku
   McNPFGHpdE7jZ9ydIGnz6zEIMvWvXN1MGxlv/m/p4i/2iFoBsYugtMR8P
   CXSSKnrKFh3t2q3RX3fQhJ3BS/xQn7ifwI1u48jczZJycSf4Kf+sNIngm
   A==;
X-CSE-ConnectionGUID: B07B5MNOSjG8OlpiLJqOMg==
X-CSE-MsgGUID: qQauujduQYmwaEkBHK3E2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1139882"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1139882"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:41:14 -0700
X-CSE-ConnectionGUID: agN4JpZaRrCWGnD4l0kvlQ==
X-CSE-MsgGUID: CKsd4OxPRkm/wyhAXA3Chg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="3987150"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 21 Sep 2026 23:41:12 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()
Date: Tue, 22 Sep 2026 12:10:22 +0530
Message-ID: <59c756701f5cd0e0ee144b2f8a092fa24015f560.1790053452.git.chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
References: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260922064022.qAgZxB3R7qilMWdFGDspSyHGzVgbtfgcKZqT2yWQ9vA@z>

btintel_pcie_send_frame() eventually copies skb->data into a fixed
BTINTEL_PCIE_BUFFER_SIZE (4096) DMA buffer via memcpy() in
btintel_pcie_prepare_tx(), with a 4-byte PCIe type header prepended.
A user-space process with HCI_CHANNEL_USER access can inject an
oversized packet and overflow the buffer.

Reject packets larger than
BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN on entry.

Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 734ff8f6363f..01278ff62ffd 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -3235,6 +3235,16 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
 		return -ENODEV;
 
+	/* Account for the 4-byte PCIe type header prepended before the
+	 * DMA copy.  Written as a subtraction to avoid wrap-around on
+	 * attacker-controlled skb->len.
+	 */
+	if (skb->len > BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN) {
+		bt_dev_err(hdev, "Packet too large: %u > %u", skb->len,
+			   BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN);
+		return -EMSGSIZE;
+	}
+
 	/* Due to the fw limitation, the type header of the packet should be
 	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
 	 * the first byte to get the packet type and redirect the rest of data
-- 
2.43.0

