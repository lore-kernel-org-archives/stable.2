Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C54BA1CB;
	Wed, 16 Sep 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578747; cv=none; b=htSH381RjTT9oaRYNi5N0Rp6j6+H5+0PBFiK+vii09QC4NxbyTUdDI/uYZKvBFLnFmyypXikxGOqLCZKM1RBI7NHJlElESYgWh8d3bIWjg5zlHr54W7VpBQHxR5Sp67rNG8dAAO8RWVGrojk5JiqZ9IL3dyPVLC5d5QgKL0hUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578747; c=relaxed/simple;
	bh=GPfojv92vhGazvyjywr+nW1dfggvUCWkzV2zzDADthE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeuIduU4mgbXpmH4UWsF9gvjqCmLKZsvZTuCMMv3kgMGVqieVgk95hUkYdIIcadxPBiV+ouyCKLYSGDF2UxLrREY3BvkY39mUtzzssLw2iBJje1IovP+lonk8rPQCc28jmexbNAqV5mVaArsZnVMCQC2X+C2IDVdl9VsIR5YNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDrpzapqV1xuCA--.22441S2;
	Thu, 17 Sep 2026 01:12:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jiqian.Chen@amd.com
Cc: jgross@suse.com,
	linux-kernel@vger.kernel.org,
	oleksandr_tyshchenko@epam.com,
	ray.huang@amd.com,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] xen-pciback: Fix pcistub_device ref leak in pcistub_get_gsi_from_sbdf()
Date: Wed, 16 Sep 2026 17:11:41 +0000
Message-Id: <20260916171141.2086627-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDrpzapqV1xuCA--.22441S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW8WFWUuF17JF1xKrW7Jwb_yoWkKwcEgr
	WIvr97urs8tFWxtrW7uwn0vrZav3Z0q395XF1xta4rGw4j9r4UXr1rXF98Wr4Igr45JF13
	Xr1DCr93Kr4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqok9l6QAAsp

pcistub_get_gsi_from_sbdf() obtains the stub device with
pcistub_device_find(), which returns it with its kref incremented, and
returns psdev->gsi without dropping that reference again.  The caller
cannot release it either, so every lookup leaks one reference to the
stub device.

Release the reference after reading gsi.

Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/xen/xen-pciback/pci_stub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 79a2b5dfd694..d1a335233aab 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -234,13 +234,16 @@ static int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
 	int bus = PCI_BUS_NUM(sbdf);
 	int slot = PCI_SLOT(sbdf);
 	int func = PCI_FUNC(sbdf);
+	int gsi;
 
 	psdev = pcistub_device_find(domain, bus, slot, func);
-
 	if (!psdev)
 		return -ENODEV;
 
-	return psdev->gsi;
+	gsi = psdev->gsi;
+	pcistub_device_put(psdev);
+
+	return gsi;
 }
 #endif
 
-- 
2.34.1

