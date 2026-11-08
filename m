Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178096;
	b=TgmMmVYGr77ObiI8cg30YykiNLi8e42UgwxywPWUSmm+QnKrflbltnwt9uwJMrrk/tU9
	 shofmDYZVaEAFARyxGr2Bb13q1OUUauMHwV00DUKdtXrgBrU63hgmwlSs+gL/TlEemn15
	 KwhyItfnaXAwLSSP4LAVviHU3wHEMVcUJliT3hfXJwtOlc6NYY/qLkkwHbPDF4+go8sJQ
	 DAoDZ4sgeZvJMMUhXLZd69d7jEDUVEWZUqmjtUpkBZ+fVUBnfwvr53RwLtGjuKDXXiAwM
	 kU+84N217N4Y5EQhi0by+uyM5BvOt2i56ju1x3mNu/OOEgqrDflWuSt0upUDbdpGFRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178096;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=OgFzMOxOJYlDV66gy+GUQNxeaNexOAvMXbDrezA8dmc=;
	b=mYynFAjTP99PAiYdbXnk9iZZVfzXWS+3R2oKMn6FslwQqEjsd6XAUy7vWi0MFshpElS8
	 0ICf1bxw2685RFb31wOFB83jn9NfVYmqpfN9sDzyDJ81imH6AR35gC18KDOERp4U8rG4n
	 IpLkfZNvKqbqgjsHJuGLMxN2OuWO9JEFOsoN1CDnQts3aVN6leoZpw3bB8Uy+u1Zmr/Do
	 E4SJz7B3hI6/lEfrRI44TTc6Mnl5rbrORsKLJSMYbjZB684Gkuti9L6Fg7aHAOHSlISBt
	 /TAdmODt6w0m1UhwRMDenHiHRRBWM9TkoHBbcoH4LW2UvGsrjsGySNYfRsdsU9gbWag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ATMgU2F2;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306D606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A306D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ATMgU2F2
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jN7Nk6kR3zKmct;
	Sun, 08 Nov 2026 23:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794178087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgFzMOxOJYlDV66gy+GUQNxeaNexOAvMXbDrezA8dmc=;
	b=ATMgU2F23QH/7Gyxzc6xcDZ2IepkX6LkqgaO/JbnnEUUhbx5AvczKL7d8kubBQc1wGf2k9
	JxvScteL/0TSYh7cnjpdVlDk9BRma57usE5EBofYMcmgKzv1iTxL/V32a+d9coxGJ1Zg2U
	UkosjHv5eGFSmtESoXR7gHLV7gfc6cAFzrcVMhiL3yA21O5bbp9z/OYHgPHHOU0WBaVI/p
	2FRMCVSnwThaVG3wzTnQ3zHVuLU5sL7wVjc9fg20Arx7pcvBeaz+HSQO4jMhj08GaDH55y
	/LpBR9i91laU3akuWgy4EsuO0jR9Rc0Ny/FO2atrx0bLOVoQQqyI/sN1anNn+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.12.y 1/2] PCI: Add enable_device() and disable_device() callbacks for bridges
Date: Sun,  8 Nov 2026 23:47:47 +0100
Message-ID: <20261108224801.2533200-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051635-failed-6.12-f0a5c6bd797c@kernel.org>
References: <20261107051635-failed-6.12-f0a5c6bd797c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4rdbrrqzbg74gdpgphc8jesb789f4a9j
X-MBO-RS-ID: e16bb3ced06d2b93884

From: Frank Li <Frank.Li@nxp.com>

Some PCI host bridges require special handling when enabling or
disabling PCI devices. For example, the i.MX95 platform has a lookup
table to map Requester IDs to StreamIDs, which the SMMU and MSI
controller use to identify the source of DMA accesses.

Without this mapping, DMA accesses may target unintended memory, which
would corrupt memory or read the wrong data.

Add a host bridge enable_device() hook the imx6 driver can use to
configure the Requester ID to StreamID mapping. The hardware table isn't
big enough to map all possible Requester IDs, so this hook may fail if
no table space is available. In that case, return failure from
pci_enable_device().

It might make more sense to make pci_set_master() decline to enable bus
mastering and return failure, but it currently doesn't have a way to return
failure.

Link: https://lore.kernel.org/r/20250114-imx95_lut-v9-1-39f58dbed03a@nxp.com
Tested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
(cherry picked from commit a3751212a8eeece59d2018c455000f30ed7e5bb7)
---
 drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f96801d1c833f..df66a1148237e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2068,6 +2068,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 	return pci_enable_resources(dev, bars);
 }
 
+static int pci_host_bridge_enable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+	int err;
+
+	if (host_bridge && host_bridge->enable_device) {
+		err = host_bridge->enable_device(host_bridge, dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void pci_host_bridge_disable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+}
+
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
@@ -2083,9 +2105,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	err = pci_host_bridge_enable_device(dev);
+	if (err)
+		return err;
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
-		return err;
+		goto err_enable;
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
@@ -2100,6 +2126,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	}
 
 	return 0;
+
+err_enable:
+	pci_host_bridge_disable_device(dev);
+
+	return err;
+
 }
 
 /**
@@ -2283,6 +2315,8 @@ void pci_disable_device(struct pci_dev *dev)
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	pci_host_bridge_disable_device(dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3051fb5a5e84..aabf7eef138a9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -602,6 +602,8 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
-- 
2.53.0

