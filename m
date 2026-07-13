Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B6426EC1
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949340; cv=none; b=sQ/EoyoUyiW4bu2abVtaW8MqYjpwAnzgs+Dr1ECjksyltLzDakRtiJMYpQzMP+oifP4yBOoehAsB+cfp7VcapwcXKvdqoEuY7QEZdVogFHUafCAuW8m9OjIdHqlbo4r+LuOgP3URbHhdJU1UJqvD2YCOl4pjvpwhCl+xAmG1WFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949340; c=relaxed/simple;
	bh=GTn8+Hjn0xUbx56UH0I8lAjM4VzEdj6f7WHAOsl/tuE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s1Wg6vgpWLz+sO5JR0FPbKPHGY3C4iA8X131FlO9XY0iUSwDilfPMwNanxduxVV1uqOeyylrsJTsDA7qZ2HhtOiyuHFRlW/hNr/PRSzaioqIZxvhKfoHDpIHc45nQvwGL0D7hN+OI5CNY2WhlwM6nCNQuFdTmpzRWlWYGwBbhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TcISEaCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TcISEaCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB41F00A3A;
	Mon, 13 Jul 2026 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949339;
	bh=WtUZF9IOF0+uCApo3TOYABni264QY6azIlzojFKXiiA=;
	h=Subject:To:Cc:From:Date;
	b=TcISEaCM1Hvbh6G3Vr1YNBcOQhHtFyIRU7zfulndUGBaJuASA0elW8VUsnDOxOjwo
	 Vi2N1Oez/HaP5FGhJEZ/GR2fNBtArHhWCIkiTDBnsJNcdsgJxpkjk7fVYHS/+Js5A2
	 38WL8/yrwBgT2D7A/hFM8RbvCOsnvBaDsIN9eKB8=
Subject: FAILED: patch "[PATCH] PCI: loongson: Override PCIe bridge supported speeds for" failed to apply to 6.1-stable tree
To: liziyao@uniontech.com,aydenmeng@yeah.net,bhelgaas@google.com,chenhuacai@loongson.cn,fsf@live.com,jeffbai@aosc.io,mani@kernel.org,xry111@xry111.site
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:27:18 +0200
Message-ID: <2026071318-tweet-shaking-65d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e373c789bac0ad73b472d8b44714df3bd18a4edf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071318-tweet-shaking-65d3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e373c789bac0ad73b472d8b44714df3bd18a4edf Mon Sep 17 00:00:00 2001
From: Ziyao Li <liziyao@uniontech.com>
Date: Sun, 12 Apr 2026 18:17:31 +0800
Subject: [PATCH] PCI: loongson: Override PCIe bridge supported speeds for
 Loongson-3C6000 series

Older steppings of the Loongson-3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
as only 2.5 GT/s, despite the upstream bus supporting speeds from
2.5 GT/s up to 16 GT/s.

As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
than one speed is supported"), bwctrl will be disabled if there's only
one 2.5 GT/s value in vector 'supported_speeds'.

Manually override the 'supported_speeds' field for affected PCIe bridges
with those found on the upstream bus to correctly reflect the supported
link speeds.  Updating the speeds to reflect what the hardware actually
supports avoids quirks in drivers consuming the speed information.

This commit was originally found from AOSC OS[1].

Fixes: cd89edda4002 ("PCI: loongson: Add ACPI init support")
Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
[Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
Signed-off-by: Ziyao Li <liziyao@uniontech.com>
[Xi Ruoyao: Fixed falling through logic, added debug log, Fixes tag and rebased to 7.0-rc7]
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: commit log, https://lore.kernel.org/all/9d815df3b33a63223112b97440c01247935363c1.camel@xry111.site]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Lain Fearyncess Yang <fsf@live.com>
Tested-by: Ayden Meng <aydenmeng@yeah.net>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org
Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
Link: https://patch.msgid.link/20260412101731.107059-1-xry111@xry111.site

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index de5e809a537d..d0c643996476 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -177,6 +177,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
 
+/*
+ * Older steppings of the Loongson-3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 0x3c19,
+ * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
+ * from 2.5 GT/s up to 16 GT/s.
+ */
+static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
+{
+	u8 old_supported_speeds = pdev->supported_speeds;
+
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+		fallthrough;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+		fallthrough;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+		fallthrough;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+		break;
+	default:
+		pci_warn(pdev, "unexpected max bus speed");
+
+		return;
+	}
+
+	if (pdev->supported_speeds != old_supported_speeds)
+		pci_info(pdev, "fixed up supported link speeds: 0x%x => 0x%x",
+			 old_supported_speeds, pdev->supported_speeds);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;

