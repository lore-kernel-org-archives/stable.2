Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503969;
	b=2gQEla4MYT+mIZgAvt0RNOsurcVy89di/nkJOf36FHJ5hnKRczaLY4o8m2ppz80OdtG9
	 NDAJO/OdDWfb0q05H31LuxFN7OrI//h/9aRovfwIIMpH6sn2EEzOuWFCbkraIajTONNPm
	 GiEf6NXW5N+RMSo1LYcrmDqkHSjP3dCh4wBDVCz1PrEd7XvtZ/BVOHTvY3cMyMcNa10r8
	 oLmGWkmjra7SqfIY1hhZrrr/dOYA1xeJgg0HzS7D6wxpAX9tbm/i456c938iv1P3TtQTb
	 5XzGheSO2bCd8NvPuJ8+0ISRP6i9oR4N4ylMW4e8oyd+jMvVpOy/jj8aQ9lzczZ6uWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503969;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9FXUwzu1RunUGnZn+1IN4sy30G2Duzud58N8Zunx5es=;
	b=t5b2y7jHu0XVZdxWFMHxpevoDi+yAUFi9fd12VyItxwLfsb9FsJlzhBbYWyVSH70HZa/
	 xci6s+kewVV2+W98z1plwi0Xsv2V65kYJd6STAva9XqBFFxCH3OL/h1Hy6ELzsy2unjZw
	 J283afUa09DvfgZM5waOw92fGLfLdHg/z7u98kucZ8Hr5zKXoxx1cZuy0rgFrYN0sR13l
	 hKxnGWi8ELEuAEe0shjnsBj7eBtu7t325ftl6h8y8T+4QLTqBtViyZflewHQ6tcuVmJh+
	 G5e/9Ns36J2XMMqk53IjICpGxOlTV1nGsdG7uL3GOYAzyXuUvQ+ZV93JmqIUk2+Ohig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0eNz5PC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28B606A333;
	Thu, 12 Nov 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0eNz5PC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794503968;
	b=v19iPJ6dl4jyjgrdANmfKlR2xlbiTBnV9fNuGh4QC/ja2qhPHFXRx8uL5m6bHsU66tsY
	 K0/wRjbCTOT3M6wP9jj+LHBhc0mLrMbtgbtiZe09TPgBIyannL9I+EZ8gbZy1+sXuw3jk
	 pqLda0asdub8UGqIscXxAWUfO+9s3jsCBNnhlTlFEaJBMnr/qCLNOgyUTehRf3WK3dyN6
	 K7pE4NtyX6UzxF+j/7cFg7qIzplzodDp4oz5740Hhr+faEMrvurumGQAIC4gWGAuNm8Oj
	 KDwt4Fx4dTPZLcIMI299436hTE0Ddyaa9mKpEt6aqpmZxu6r/kbKlrBcJlZIhwaNgCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794503968;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9FXUwzu1RunUGnZn+1IN4sy30G2Duzud58N8Zunx5es=;
	b=RfMimFtOOTisvPpnk61tCw4v50SSEHyn4ZxfueSLV3Ojb8fvAUZfoQ+SKGcv/NZ7qUHI
	 xUbKJvxaeqyKwLeBB0PT9/TYTojgFCBTDEr3N4MMoT8tSyjR2ZIzLRT5wZOr246iC+Ly7
	 0K+59hr/SoFuwy32Bns+PeSeDfiltGWeWtQ1HZNNsA1l4pYwXqYZIFiiVS7wsC9/kvg3x
	 vxM6EBm1aOjwR64gCJN6K/EtmcitwaBz+ZaFENmC3DziC/trWz4P/2LsKMBTdT4ttzw9c
	 oNpbQtDMY8Eqn6whGklbzugFwMKAZLiKXbDZHhOduBKq5I1WO+weL05VB1lzmemxGHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C3FD1F000C6;
	Thu, 12 Nov 2026 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503968;
	bh=9FXUwzu1RunUGnZn+1IN4sy30G2Duzud58N8Zunx5es=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=G0eNz5PC9I+Bvd+olNDMRLjbsImU86+O4PeD6phHyv9zpUkLOo2Dt/33Y2m+sYlfU
	 FjqvJUc9A/2jTclR8jfyLERSVN8ljvdQcdqnN7RCsrKXY9M6tJpPOn/8EkWrZIw1sG
	 26FLXvzIBaU2hF2RsZrissgiOB0PbWgH3jUQ71bxjl0VYYiBIJJ009JUPvLgkAXTCd
	 2cMlsJ4TV9o1FnnAV3tZhDV++1UWLVDaPPZvvF7svnW0TjG9pMf5MY0bYtET6+c0Rn
	 CteaLSnKI8I/QyKSjjkz+P/rnwAgHr8V7YmxRXbjKoKTqtTIHdwN5QKJYyFCRepzyt
	 iXESjKuYuTZ5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 93FBC45A64;
	Thu, 12 Nov 2026 17:19:27 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 17:19:27 +0000
Subject: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDuQZGFKr1JcmPjbTkEjExVBv
 LvRLr/FeztlqCDTq9pJsUqWNBbYR0Xx244fsHTF5IyrrbWOJQ3DwpOmANY2gjsTzRPee+MDlWx
 S9LLdy3fzd17CD3G+PnQcJxrsoAh0AAAA
X-Change-ID: 20261112-iommu-probe-race-d0c08e77707b
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794503967; l=7366;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=8JR6AmMLM7PRkZrhVhsNPrKtTe/yhLbk9BSVJV4P3Rc=;
 b=ZOTtA6myjmY2zdQeuWVsG1/cwKTDmjPPlM2OallkitwgFsANImTg+0ke9LvyITo/CNjKL7gDM
 tXKyJTFih/ACOOM+7LFhzicYP9Zpe75Fw/qj6o9XIFxfDQQm8kLxGvY
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

When an IOMMU driver is a module, udev can load it while the driver of
one of its client devices is loading too. On an Orange Pi 5 (RK3588)
with CONFIG_VSI_IOMMU=m and CONFIG_VIDEO_HANTRO=m, 1 of 30 boots gives:

  hantro-vpu fdc70000.video-codec: late IOMMU probe at driver bind, something fishy here!
  WARNING: drivers/iommu/iommu.c:654 at __iommu_probe_device+0x234/0x5e0
  Call trace:
   __iommu_probe_device+0x234/0x5e0 (P)
   probe_iommu_group+0x40/0x80
   bus_for_each_dev+0x88/0x110
   iommu_device_register+0x10c/0x2d8
   vsi_iommu_probe+0x244/0x280 [vsi_iommu]

"iommus" is an optional fw_devlink supplier, so nothing orders the
client's bind after the IOMMU's probe; that is left to the readiness
check in iommu_fwspec_init(). That check is skipped when dev->iommu is
already set, which is meant to identify the bus_iommu_probe() replay of
dma_configure. But iommu_init_device() allocates dev->iommu and then
drops iommu_probe_device_lock for the replay, so a driver binding the
same device in another context sees it too:

  iommu_device_register()            really_probe(client)
    bus_iommu_probe()
      iommu_init_device()
        dev_iommu_get()
        dev->driver == NULL: replay,
        unlock                         device_set_driver()
        dma_configure()                dma_configure()
                                         of_iommu_configure()
                                           dev->iommu set, or fwspec
                                           set by the replay: return 0
        lock                             iommu_device_use_default_domain()
      dev->driver set: WARN                no group yet: return 0
      group, default domain,           call_driver_probe()
      DMA ops set up under the
      running driver

So the warning is right that something is fishy: the client driver
probes before its device is in a group, with no default domain and with
dma-direct ops that bus_iommu_probe() replaces later. If the client gets
dev->driver set before the replay check instead, bus_iommu_probe() skips
the device, the client defers on the readiness check and its retry does
the probe from the bind path, which warns as well.

Close the window in the pre-probe hook that every bus dma_configure
already calls: in iommu_device_use_default_domain(), a device that has a
fwspec but no group is still being probed (a failed probe frees the
fwspec), so defer the driver as is already done for a group without a
default domain. The driver core retries it once the IOMMU driver has
bound. With that, a driver that is binding but not bound can no longer
run against a half-probed device, so let bus_iommu_probe() replay
dma_configure for it and warn there only for a device that is already
bound. The bind path (iommu_probe_device() from of_iommu_configure())
keeps warning whenever dev->driver is set.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
The warning was seen once in 30 boots of an Orange Pi 5 (RK3588) with
the Verisilicon IOMMU and the Hantro decoder built as modules, with
udev loading both at the same time. The trace in the commit message is
from that boot.

Testing: this change on a v7.3 based kernel (drivers/iommu/iommu.c
there is the same as in iommu/next apart from an unrelated
iommu_dma_prepare_msi() hunk) booted 60 times on the same board with
the same modules: no "late IOMMU probe" warning and no other
WARNING/BUG, and in every boot the AV1 and VPU121 decoders were bound
to hantro-vpu and in an IOMMU group, the AV1 decoder's IOMMU was bound
to vsi_iommu, nothing was left in devices_deferred, and the log had no
IOMMU or decoder errors. As the race hit only 1 boot in 30 before, 60
clean boots are weak evidence that it is closed; they mainly show that
IOMMU and client binding still work. The logs do not show whether the
new -EPROBE_DEFER path ran in any boot. No decoding was run in those
boots.

This patch was developed with Claude (Anthropic) as a coding assistant:
it analysed the race and wrote the code and the commit message, and I
reviewed it and tested it as described above.
---
 drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..ec68fb7dbe04 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -481,8 +481,12 @@ static int iommu_init_device(struct device *dev)
 	 * still a big job, so for now just invoke the whole thing. The device
 	 * already having a driver bound means dma_configure has already run and
 	 * found no IOMMU to wait for, so there's no point calling it again.
+	 * A driver that is still binding in another context (dev->driver set,
+	 * but not bound yet) has not got that far: its own dma_configure will
+	 * defer in iommu_device_use_default_domain() until we are done here.
 	 */
-	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
+	if (!dev->iommu->fwspec && !device_is_bound(dev) &&
+	    dev->bus->dma_configure) {
 		mutex_unlock(&iommu_probe_device_lock);
 		dev->bus->dma_configure(dev);
 		mutex_lock(&iommu_probe_device_lock);
@@ -648,9 +652,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		return ret;
 	/*
 	 * And if we do now see any replay calls, they would indicate someone
-	 * misusing the dma_configure path outside bus code.
+	 * misusing the dma_configure path outside bus code. For bus_iommu_probe()
+	 * (@group_list set) dev->driver may also be set by a driver which is
+	 * binding concurrently in another context; that driver will defer in
+	 * iommu_device_use_default_domain(), so only a driver that is already
+	 * bound is a late probe there.
 	 */
-	if (dev->driver)
+	if (group_list ? device_is_bound(dev) : !!dev->driver)
 		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
 
 	group = dev->iommu_group;
@@ -3316,9 +3324,26 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 int iommu_device_use_default_domain(struct device *dev)
 {
 	/* Caller is the driver core during the pre-probe path */
-	struct iommu_group *group = dev->iommu_group;
+	struct iommu_group *group;
+	bool probing;
 	int ret = 0;
 
+	/*
+	 * bus_iommu_probe() in another context may be probing the device right
+	 * now, with iommu_probe_device_lock dropped while it replays
+	 * dma_configure. Our own dma_configure can then see its dev->iommu or
+	 * fwspec and return early, although the device is not in a group yet
+	 * and has no default domain or DMA ops. A fwspec without a group means
+	 * exactly that (a failed probe frees the fwspec), so make the driver
+	 * wait until the probe has finished.
+	 */
+	mutex_lock(&iommu_probe_device_lock);
+	group = dev->iommu_group;
+	probing = !group && dev->iommu && dev->iommu->fwspec;
+	mutex_unlock(&iommu_probe_device_lock);
+
+	if (probing)
+		return -EPROBE_DEFER;
 	if (!group)
 		return 0;
 

---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261112-iommu-probe-race-d0c08e77707b

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


