Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8951DAED;
	Tue, 13 Oct 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897514; cv=none; b=CE8B1+XRVQ+0tNKnUekpxGVao49sQXCVg8xWsGLWrilbSOr3GB4PdACH1SvtXID7fbpO0OiuQq2Hi0Jjb0KGb6SIYrBHgrRnealV+ODv2lNMaW6Q2qr0QrJm1U6aZN6voYpQuv5zhmzb6n6j98fuR5AlTsVANoFsOSb/+73rcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897514; c=relaxed/simple;
	bh=lD/YM5+m9+//J4cmi5Y2vvc2Cwgf8dFKNc3eqPU8FPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6lmVldkVrPXrw7284cgFz/t0WlEp7ZCvgUOfsKJA/4fSzgWCh+NazLKuBDuay/FkFBMnJ084fton0guaVpV0zxpsdc1XmLiIkQo3dwbY1+am63sjjiX7v4yBPGgM1Jcw8qoAfNtvkn38PBTJRTrhDe9M60FCX1eGh2jXp82r0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrdD73Nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrdD73Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CD91F00893;
	Tue, 13 Oct 2026 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897512;
	bh=eNwlMcIN6RDfAUguyWL/lGNST8kVj4qrOgrHU6lN4e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrdD73NhCplelqb1JA7bhOw8ScnOgr3cAsp9HigfsK8ugSU6RVjL97x3gIxWe5pVM
	 XFA80g0kc9Vrak8wBLFrx4SrGd+ZDlyXVXJFWXWJ56aqncBEMrbOqMj7tBvX0WV8dx
	 83FB3CJfwp2U+BdLlVFiFhFJY0fNguq8LbVgooVqzlTG3r51OBd4a/0YwEy4UMYCiH
	 KgMhYf6lTxg6FEzrwTu92IHNw6Op7WiV65b4n0ddEJmckT81wSHwfOqSgTbhBfBfst
	 KkkTNQoAC5UZSCjVO4VvPOl63aEkWyqtAPhgU+moebwzOSKKhTXxIstKW2gpuez97d
	 Q5AnxJI9THq/Q==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 01/53] MIPS: PCI: xtalk-bridge: refuse device numbers past the last slot
Date: Tue, 13 Oct 2026 15:16:21 +0200
Message-ID: <ab272dadb6186ab7aa3e9c6aad87fe3f08c235da.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Config slots 8 and up alias the type 1 window, so a root bus scan finds
phantom copies of whatever device b_pci_cfg selects.  Refuse root bus
accesses past the ASIC's last slot.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-xtalk-bridge.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index cf115abb54e0..9451b7546068 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -92,6 +92,11 @@ static int ioc3_cfg_wr(void *addr, int where, int size, u32 value)
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int bridge_nslots(struct bridge_controller *bc)
+{
+	return BRIDGE_DEV_CNT;
+}
+
 static void bridge_disable_swapping(struct pci_dev *dev)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
@@ -127,6 +132,13 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf;
 	int res;
 
+	/*
+	 * Only bridge_nslots() slots exist.  Config slots 8 and up alias the
+	 * type 1 window and would answer for whatever b_pci_cfg selects.
+	 */
+	if (slot >= bridge_nslots(bc))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *)addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -212,6 +224,9 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf;
 	int res;
 
+	if (slot >= bridge_nslots(bc))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *)addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -695,7 +710,7 @@ static int bridge_probe(struct platform_device *pdev)
 	bridge_write(bc, b_dir_map, (bd->masterwid << 20));	/* DMA */
 	bridge_write(bc, b_int_enable, 0);
 
-	for (slot = 0; slot < 8; slot++) {
+	for (slot = 0; slot < bridge_nslots(bc); slot++) {
 		bridge_set(bc, b_device[slot].reg, BRIDGE_DEV_SWAP_DIR);
 		bc->pci_int[slot][0] = -1;
 		bc->pci_int[slot][1] = -1;
-- 
2.47.3

