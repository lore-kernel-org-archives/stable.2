Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116608;
	b=NBMZo6RU81UWhm5viZqe1FDCo2SJfP+gtshFD/elxxo2cDE3jZTWL1Kjc5Kf8iXwBT+a
	 mrOy2BzONkxgSKQY/x3+r4FJexssbPMIzhdlGcqVtCwfTpFFj8U5OICcVybcKiTpzGwk3
	 cDHc4uQywiCVvELKTkdxqIreHBi/Qa7Ut7qXnO5B06iXY6L5d77256D0bcft2jK85XN8P
	 opHmVIpIZMFIuVUnxC5V6LeXobhqgy52dvq9Di4wZ/4WB7gklZ4MKYuiEtgOaOFoa3FgT
	 fSUlQMpIz8r/+EENvd7emkiUfRFx6icDkHVsfpzjQKpNhoHxbV8uiZZ9edj5xZ20tcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116608;
	h=DMARC-Filter:Received:DKIM-Filter:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PYGYhnvixEwD9HA/xY5pAkRnMJJMyKyOF0VnSklvfPg=;
	b=vzAVzfYBN+pWE0NUANGSZC1uyHGyieLJW+qyAQ2Xksks0E8DNi8WankrBLw59WW2wX5V
	 8nSMeWRhddas+oEEt+Oj/cf1/dfrDNVyttgyMgJ3OCgaSjNshxUY5mM2Pban860TZKt/f
	 fYDpeM+3LgPGDiwMXq9JbsWBBfQd1bdP+d+Gi/fN2Ap5iKV+XctS4He4mGZS1BpCMfXgH
	 IiRJD3ZIQLhm9To8Ek5kRMp4FTk/yhG9tV7bEoa1KBC1wj8r1qWuXWrC1KDC3vcL7uCED
	 1yMrvNMzDjN23L3zZSDL4/d1QNpV+EjQvULHCRU8tFqYjMNNY/dbgMhnPW8wn6N0IwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051E606A334;
	Thu, 19 Nov 2026 19:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D051E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 026AD20B7166; Thu, 19 Nov 2026 11:30:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 026AD20B7166
From: Dexuan Cui <decui@microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	davem@davemloft.net,
	jakeo@microsoft.com,
	saeedm@mellanox.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhamidipati@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH] PCI: hv: Don't use container_of() on non-vPCI buses in config block ops
Date: Thu, 19 Nov 2026 11:29:37 -0800
Message-ID: <20261119192937.570043-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Bhamidipati <abhamidipati@microsoft.com>

hv_read_config_block(), hv_write_config_block() and
hv_register_block_invalidate() are exported through hvpci_block_ops for
mlx5_core, which calls them for its PCI function whenever it runs in a
Hyper-V guest. They assume that pdev->bus->sysdata is embedded in a
struct hv_pcibus_device and use container_of() on it.

That only holds for buses created by pci-hyperv. A Hyper-V guest can also
have PCI devices behind other host bridges, for example the ACPI-enumerated
ECAM root ports used for ePCIe (emulated PCIe) device assignment on Azure.
For such a device, container_of() yields a bogus hv_pcibus_device, and
mlx5_core crashes on a ConnectX VF. On a 7.0-based kernel it crashes in
get_pcichild_wslot(), called from hv_register_block_invalidate() while
the VF probes. On a 7.3-based kernel the VHCA invalidate work sends a
packet on a bogus channel; UBSAN flags the spinlock, and a paging fault
follows:

  UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
  index 2129 is out of range for type 'long unsigned int [512]'
  Workqueue: mlx5_hv_vhca mlx5_hv_vhca_invalidate_work [mlx5_core]
  Call trace:
   queued_spin_lock_slowpath+0x644/0x6e0
   _raw_spin_lock_irqsave+0x98/0xf0
   hv_ringbuffer_write+0x98/0x340
   vmbus_sendpacket+0x9c/0x100
   hv_read_config_block+0xf4/0x1b0
   hyperv_read_cfg_blk+0x28/0x80
   mlx5_hv_read_config+0x6c/0x130 [mlx5_core]
   mlx5_hv_vhca_control_agent_invalidate+0x8c/0x280 [mlx5_core]
   mlx5_hv_vhca_invalidate_work+0x88/0x120 [mlx5_core]
   process_one_work+0x1dc/0x5b8

Commit 0d5acba6331c ("Drivers: hv: vmbus: Export hv_vmbus_exists() and
use it in pci-hyperv") fixed the same crash for guests without VMBus, by
not installing the ops at all. These guests do have VMBus, and their NIC
and OS disk are on vPCI buses, so the ops are installed and a per-device
check is still needed.

Treat the bus as a vPCI bus only if its ops are hv_pcifront_ops, and
return -EOPNOTSUPP otherwise. mlx5_core ignores a failure to register the
Hyper-V VHCA invalidate callback, so the VF probes normally.

Tested on an Azure ARM64 VM with 8 ConnectX VFs behind ACPI ePCIe host
bridges, with a 7.0- and a 7.3-based kernel: all 8 VFs probe and their IB
ports go Active, and a test module confirms that all three ops
return -EOPNOTSUPP for a device that is not on a vPCI bus.

Fixes: e5d2f910cfec ("PCI: hv: Add a paravirtual backchannel in software")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Bhamidipati <abhamidipati@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

It's based on the PCI tree's for-linus branch, and can also apply cleanly
to v7.4-rc3, pci/next, hyperv-next and linux-next.

 drivers/pci/controller/pci-hyperv.c | 36 +++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 824cf27e85e67..029d66a171216 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1451,6 +1451,21 @@ struct hv_read_config_compl {
 	unsigned int bytes_returned;
 };
 
+/*
+ * The config block ops are exported through hvpci_block_ops and can be called
+ * for any PCI device, including devices behind a non-Hyper-V host bridge
+ * (for example, ACPI-enumerated ePCIe roots). Only devices on a bus created by
+ * this driver are backed by a struct hv_pcibus_device.
+ */
+static struct hv_pcibus_device *hv_pci_dev_to_hbus(struct pci_dev *pdev)
+{
+	if (pdev->bus->ops != &hv_pcifront_ops)
+		return NULL;
+
+	return container_of(pdev->bus->sysdata, struct hv_pcibus_device,
+			    sysdata);
+}
+
 /**
  * hv_pci_read_config_compl() - Invoked when a response packet
  * for a read config block operation arrives.
@@ -1500,9 +1515,7 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 				unsigned int len, unsigned int block_id,
 				unsigned int *bytes_returned)
 {
-	struct hv_pcibus_device *hbus =
-		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
-			     sysdata);
+	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
 	struct {
 		struct pci_packet pkt;
 		char buf[sizeof(struct pci_read_block)];
@@ -1511,6 +1524,9 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	struct pci_read_block *read_blk;
 	int ret;
 
+	if (!hbus)
+		return -EOPNOTSUPP;
+
 	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
 		return -EINVAL;
 
@@ -1581,9 +1597,7 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
 static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 				unsigned int len, unsigned int block_id)
 {
-	struct hv_pcibus_device *hbus =
-		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
-			     sysdata);
+	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
 	struct {
 		struct pci_packet pkt;
 		char buf[sizeof(struct pci_write_block)];
@@ -1594,6 +1608,9 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	u32 pkt_size;
 	int ret;
 
+	if (!hbus)
+		return -EOPNOTSUPP;
+
 	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
 		return -EINVAL;
 
@@ -1652,11 +1669,12 @@ static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
 					void (*block_invalidate)(void *context,
 								 u64 block_mask))
 {
-	struct hv_pcibus_device *hbus =
-		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
-			     sysdata);
+	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
 	struct hv_pci_dev *hpdev;
 
+	if (!hbus)
+		return -EOPNOTSUPP;
+
 	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
 	if (!hpdev)
 		return -ENODEV;

base-commit: e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff
-- 
2.55.0

