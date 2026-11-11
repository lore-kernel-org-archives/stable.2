Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390530;
	b=g1xMBc1I+kiuzsLZkdp1hg3rk8GR361e+8VgRq/Gw4SC/eSxmEEole6Ji3XEFbWIE//Q
	 TxLVKRgFZZAcTdaZTBT2jkvO9CpBXDl58bWMwkmXzJ9v4eYGG7LExxR3dFUeN8XM6N85j
	 NjT9uNcZQqxbqieyTQibdQswfOt1pe6vvoPGGYpCZTxBk38qtfWEeb4i9y0+4GozVvy2u
	 67YNPhvmfB5I4Gqk0jYZ6ksONUvhAIM0DG/Y6iTfOEb4OdH2P2svBZfVqfEVrSpjDE6At
	 azt4arnG5uzYrJZ6np53HojpH43SRIJe2UaoY7i/UN8cnOS/OOWvNRwKC/PWQwgKxag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390530;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NanRy0LXxd+8RK8JAn1EDTvBj46D5+CmlAgWl4/90DE=;
	b=EVXPDX+NHSe8B6fzP2nCiqEOi6Ks26xg73F8qPIiSebJzXwZRg596Ehkh/De4uR7yunH
	 UCzuwfbhonLRzydv0A5NcTxv8McPzwLyss/YzxkvvcAdEP4mHeJpwTeTpiKWqGPkMiOjT
	 3XdRXvS8Qf9/WkJukMFitmsV2W80MYRByEhqiS1p2oSjGfb6+IbFaFv11Iu2nzJllXvY6
	 TkzEyzPkrFHWZzeRvMo85Wr/X4XJedGjti83TFz3IFpMzWE6rMVwLshVFnj+DRNvJsVwx
	 8251u9/sVzEUdemx2JPcAuLYPupz9TNEIU/eTjFg+83JicKmjTxa1jaAcRcx4A7G1Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10D606A31C;
	Wed, 11 Nov 2026 09:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D10D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from pc.omp.ru (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 11 Nov
 2026 12:48:37 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 5.10.y] of/fdt: Ignore disabled memory nodes
Date: Wed, 11 Nov 2026 12:48:17 +0300
Message-ID: <20261111094817.600994-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

From: Andre Przywara <andre.przywara@arm.com>

commit df5cd369876114f91f9ae60658fea80acfb15890 upstream.

When we boot a machine using a devicetree, the generic DT code goes
through all nodes with a 'device_type = "memory"' property, and collects
all memory banks mentioned there. However it does not check for the
status property, so any nodes which are explicitly "disabled" will still
be added as a memblock.
This ends up badly for QEMU, when booting with secure firmware on
arm/arm64 machines, because QEMU adds a node describing secure-only
memory:
===================
	secram@e000000 {
		secure-status = "okay";
		status = "disabled";
		reg = <0x00 0xe000000 0x00 0x1000000>;
		device_type = "memory";
	};
===================

The kernel will eventually use that memory block (which is located below
the main DRAM bank), but accesses to that will be answered with an
SError:
===================
[    0.000000] Internal error: synchronous external abort: 96000050 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc6-00014-g10c8acb8b679 #524
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : new_slab+0x190/0x340
[    0.000000] lr : new_slab+0x184/0x340
[    0.000000] sp : ffff80000a4b3d10
....
==================
The actual crash location and call stack will be somewhat random, and
depend on the specific allocation of that physical memory range.

As the DT spec[1] explicitly mentions standard properties, add a simple
check to skip over disabled memory nodes, so that we only use memory
that is meant for non-secure code to use.

That fixes booting a QEMU arm64 VM with EL3 enabled ("secure=on"), when
not using UEFI. In this case the QEMU generated DT will be handed on
to the kernel, which will see the secram node.
This issue is reproducible when using TF-A together with U-Boot as
firmware, then booting with the "booti" command.

When using U-Boot as an UEFI provider, the code there [2] explicitly
filters for disabled nodes when generating the UEFI memory map, so we
are safe.
EDK/2 only reads the first bank of the first DT memory node [3] to learn
about memory, so we got lucky there.

[1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst#memory-node (after the table)
[2] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/fdtdec.c#L1061-1063
[3] https://github.com/tianocore/edk2/blob/master/ArmVirtPkg/PrePi/FdtParser.c

Reported-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220517101410.3493781-1-andre.przywara@arm.com
[ Georgiy: 5.10 lacks commit 1f012283e936 ("of/fdt: Rework
  early_init_dt_scan_memory() to call directly"), so the function still
  handles one node per of_scan_flat_dt() call: return 0 instead of
  continue and use initial_boot_params instead of the local fdt. ]
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/of/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 384510d0200c..753a2344cfaf 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1000,6 +1000,9 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	if (type == NULL || strcmp(type, "memory") != 0)
 		return 0;
 
+	if (!of_fdt_device_is_available(initial_boot_params, node))
+		return 0;
+
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
 	if (reg == NULL)
 		reg = of_get_flat_dt_prop(node, "reg", &l);
-- 
2.54.0

