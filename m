Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610730;
	b=SF/926FdQQ3Fe+c6cjbcuOdo5/vyxg+VDtZp8HZ1Mi5Pb5cRsYJ8Xipy8OlNiHsdXAX+
	 tddgAH0NA7NQL3aad57WhUwaldBBBNwtGyyB5Z93WhVts953mkvyAUvZ85AMBlEuTwM9T
	 U2YdwT7RnXdiF3zOYezvak4R5cEVgD6cAOxRy5ocFeasGTeXl5ymhHXKKq/bXwDLRSrXc
	 juS5+sjBiAQEo89W7ceeF8fPH6E/Qy28rtpI/LHD96xCcbL0dBhTs+b55dlnIvK5yCoZ6
	 +V+EsD1DIDSTSa1fhs43Xex0n0HxRP46FAFcL2BpuiTTx22h/oliodQnw3Pk6AqZSQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=13JlhaqYxJCjN+cuAkptPbINZKXTwtVz6e6fXPFNqyI=;
	b=E6JghHewkzWPvdN/uvSXqX9DQtrOZM6xS+KGGriush5ghGjsv3phLftctH9kxspFYC2l
	 /44Jjl9ZkujE74J1+zZzWbGadRGcncy2tNIfTzl4rCCm3FGTDDYd3XK4tHDKC3kw/yPi+
	 TeP+DVIADZNXJuVI3bA5WaDV8HeZzPKlOITFrCUsY4tmFc1S4DAeSxpNST16XpCfp5JTo
	 AhhEBKyc10f9bLfSNRInT6ieYbOrEoWXIF62SaHA9eh6uGA8GFabmRVOE9yO7YPq34nHt
	 Y+4kZgeUF0IEWdvDV+YBJbxHAeSh2PWQqKdu+8yjj71WLY7GSk9wwab5EYvXuUbFtzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzbCfRH0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE7606A319;
	Wed, 21 Oct 2026 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzbCfRH0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F91F000C1;
	Wed, 21 Oct 2026 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610730;
	bh=13JlhaqYxJCjN+cuAkptPbINZKXTwtVz6e6fXPFNqyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzbCfRH0hlUx0GjnxzU4sorkeniJ/AdLZH7PWFrznz8T94unYOEaxgvaVUUSRdVoa
	 m7bK5nUYxljavBdtdaab0fFrpmgOj++quO6G43kpIn89HDCO5tQLWf5/PdP9iKgRWE
	 kVyTMD+U5DYe8yxY6tZ5RMxYUHBjemY6eJ1dNeBoLui6GqhL1TsdbcFeRaKBPRam65
	 06SJGApyFyKjDSlQWBEBLLGoMmPyD8BIAhla8Y51mKT0+AdHTDNaDewo6JZfGA+q/c
	 r0CBAD8WZJuf5LH9buE4gix2Cc20v73GGcyDhtVCdFdXe3lXeaPdgiENpQEKTPsdT2
	 rlLZ1/hZOdhEA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses
Date: Wed, 21 Oct 2026 21:24:16 +0200
Message-ID: <20261021192418.7246-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021192418.7246-1-kaloz@kernel.org>
References: <20261021192418.7246-1-kaloz@kernel.org>
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

mace_pci_read_config() clears the master abort interrupt enable in the
MACE PCI control register around each config read. A register read
followed by two register writes can hang CRIME 1.1 under DMA load.

Ack master aborts in the error register instead, and follow every
write with a read so back-to-back accesses cannot form that sequence.

Fixes: c990081bf87b ("[MIPS] Fix IP32 breakage")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/ops-mace.c | 26 +++++++++++++++++++-------
 arch/mips/pci/pci-ip32.c |  2 ++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 951d8070fb48..8827e5f2ea46 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -35,15 +35,27 @@ static inline int mkaddr(struct pci_bus *bus, unsigned int devfn,
 		(reg & 0xfc);
 }
 
+/*
+ * On CRIME 1.1, a MACE PCI register read followed by two register writes
+ * can hang the machine under DMA load, so every register write in this
+ * file is followed by a read.  Config cycles to empty slots end in a
+ * master abort; ack it with interrupts still off so the bridge error
+ * interrupt does not report it.
+ */
+static void mace_pci_ack_abort(void)
+{
+	u32 error = mace->pci.error;
+
+	if (error & MACEPCI_ERROR_MASTER_ABORT) {
+		mace->pci.error = error & ~MACEPCI_ERROR_MASTER_ABORT;
+		mace->pci.error;
+	}
+}
 
 static int
 mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		     int reg, int size, u32 *val)
 {
-	u32 control = mace->pci.control;
-
-	/* disable master aborts interrupts during config read */
-	mace->pci.control = control & ~MACEPCI_CONTROL_MAR_INT;
 	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
@@ -56,9 +68,7 @@ mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = mace->pci.config_data.l;
 		break;
 	}
-	/* ack possible master abort */
-	mace->pci.error &= ~MACEPCI_ERROR_MASTER_ABORT;
-	mace->pci.control = control;
+	mace_pci_ack_abort();
 	/*
 	 * someone forgot to set the ultra bit for the onboard
 	 * scsi chips; we fake it here
@@ -77,6 +87,7 @@ mace_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		      int reg, int size, u32 val)
 {
 	mace->pci.config_addr = mkaddr(bus, devfn, reg);
+	mace->pci.error;
 	switch (size) {
 	case 1:
 		mace->pci.config_data.b[(reg & 3) ^ 3] = val;
@@ -88,6 +99,7 @@ mace_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		mace->pci.config_data.l = val;
 		break;
 	}
+	mace_pci_ack_abort();
 
 	DPRINTK("write%d: reg=%08x,val=%02x\n", size * 8, reg, val);
 
diff --git a/arch/mips/pci/pci-ip32.c b/arch/mips/pci/pci-ip32.c
index 30aca6f76563..41ec8453c865 100644
--- a/arch/mips/pci/pci-ip32.c
+++ b/arch/mips/pci/pci-ip32.c
@@ -77,6 +77,8 @@ static irqreturn_t macepci_error(int irq, void *dev)
 	}
 
 	mace->pci.error = flags;
+	/* follow the write with a read, see mace_pci_ack_abort() */
+	mace->pci.error;
 
 	return IRQ_HANDLED;
 }
-- 
2.47.3

