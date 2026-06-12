Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9339901C;
	Fri, 12 Jun 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286038; cv=none; b=tgZNM77qsF8767Tu1QF+E5YsJivByOlRMphaIz5GBWaDerqcfMMug197ULUtIgPuhutdeOBb2UCRmVVLcti8eFflQD6DrneHILJqP1dk4iIsj4xsh8JfrJS/e2R3l1M3DBUdLU4/gGudk815iiZbZpmFN37UDqFCYFcA78MQ/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286038; c=relaxed/simple;
	bh=rxYD3iGHnqWVu5XQl3U9EwVXyhVxQt9pX+gvx+rskU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtxTv9gQMdnQHaCIH1gPR7Y4bEae1rICS4QpM3F8do58ZmfN0QAo8sxdelQ3fO0vXdLMTXaUg3zv/3SbM9M7QCnpJ0mgFYQ6RkPCcaTpq3iJQJf9QRvAJuNhTd042Gk92jX/tW8idpp0EF8KUU33C+0yOj84zZFNLaLAx5Nk6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LtOvuQx7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LtOvuQx7"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 68AA620B716A; Fri, 12 Jun 2026 10:40:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68AA620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781286018;
	bh=vr0Gms8K+x62jEtAJpSeA2K2xp0MKc2fsrScko8ouYA=;
	h=From:To:Cc:Subject:Date:From;
	b=LtOvuQx7ZoFBUtZsD+GWZ9prPtIJOd55WTQuIbsqZi5iKhZPp7/GG1l6Fd2p0xlE6
	 RFr7xvrQDfxWzEKh3c3lNk9gYdis5v1p17BW1AM39MPAJm4+acDI13t+UI5wD8/1B7
	 IInEUH8CWIZaWhxwUeVpc02YV974N5cU62XNb4ZQ=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Date: Fri, 12 Jun 2026 13:40:10 -0400
Message-ID: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible that we never receive a rescind event, in which case we
will wait indefinitely for a device that will never show up. So, assume
a device is gone if have been polling for more than 5 seconds.

Cc: stable@vger.kernel.org
Fixes: c3635da2a336 ("PCI: hv: Do not wait forever on a device that has disappeared")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..bd63efc4a210 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -52,6 +52,7 @@
 #include <linux/acpi.h>
 #include <linux/sizes.h>
 #include <linux/of_irq.h>
+#include <linux/jiffies.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -1038,6 +1039,8 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
 		kfree(hpdev);
 }
 
+#define TIMEOUT_MS 5000
+
 /*
  * There is no good way to get notified from vmbus_onoffer_rescind(),
  * so let's use polling here, since this is not a hot path.
@@ -1045,8 +1048,13 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
 static int wait_for_response(struct hv_device *hdev,
 			     struct completion *comp)
 {
+	unsigned long timeout = get_jiffies_64() + msecs_to_jiffies(TIMEOUT_MS);
+	unsigned long now;
+
 	while (true) {
-		if (hdev->channel->rescind) {
+		now = get_jiffies_64();
+		if (hdev->channel->rescind ||
+		    time_after(now, timeout)) {
 			dev_warn_once(&hdev->device, "The device is gone.\n");
 			return -ENODEV;
 		}
-- 
2.54.0

