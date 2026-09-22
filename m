Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0F3FB7E5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059066; cv=none; b=Ot3Jc49V+eiZ08A5fyYTTZfQMynHl8nxhyWpcA2MQDFRU8CWEbUr5mPe5UWnCTP5wEOph60CllJAdKHrat8uM6e/ReuwYVj4lM5MMQ4xRMs8mATpsktT+zeSdf+86F3Z910483D0dZ9uaSL56JwruYJfQkol1g2s2VWPXo8XE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059066; c=relaxed/simple;
	bh=HbUu1acQFrw/8C7NvD7f55oDz5nuOcbTrQ5WFskxkVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMDHTXx/c2xOnzfGbIhnPeJjvpBtJgPS+r7UA9q08PN4hz4o/LLQznu541zqEOVGmWEvhmYjv+7JHucwnRh30b8Lb3dQNIc8oEBUW1ljwsjvLRuepuneyxRz01XrMxmSj6NJbYWsuKTtFA/c7MdTKE1Z5gqAkOW/b/O13CV+aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAkpSUFD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAkpSUFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059065; x=1821595065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbUu1acQFrw/8C7NvD7f55oDz5nuOcbTrQ5WFskxkVk=;
  b=GAkpSUFDZnIi3/NDFCEmdzvuX+nZB8v549Gi+yZS3xSDGa/NEnNq5GyG
   0ROSOGIsxwHFdmllnfaqe1LNRhOLAzxqndka6EULQMuqh1Yy7ynxhvfsh
   fXQzAmcSuDYRW3BtXPP7muq8dPzxn2o8ITw2wKhNtAsDeCetKdcWPSA3C
   v+HAAlUYa25va6TZyDNPpVhyrBdpE6DSsrxb+XXMQPIoXrVRu7KrnsqCz
   1jChswi76OLQPvreiWvBnBjhcQ0QUmxQuwYdVq0izn6lgA2T1kpiqPWbE
   ug8o/sFawbKh9ENC9Hu16wIxLeGsN2JtSYuzsnXOnIdUsfuff2OTxceU9
   Q==;
X-CSE-ConnectionGUID: fipuFh3sSaSMjMKJiG8sMw==
X-CSE-MsgGUID: mhAWuFHrQM26ScNguMbujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93135662"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="93135662"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:37:45 -0700
X-CSE-ConnectionGUID: gz/N/Qy8R2OeO8PW1uFC3A==
X-CSE-MsgGUID: VHxyOOKlQjyM+kwGquDJ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271541883"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2026 23:37:43 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: chandrashekar.devegowda@intel.com
Cc: kiran.k@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()
Date: Tue, 22 Sep 2026 12:06:49 +0530
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

