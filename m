Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9940B6DC
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507543; cv=none; b=Hm1e0UKAigs8Zl0IH8a5fO7vnNnrF+lPgoyfNnZOTjpKXm7BQ1YqFG640d54JY9eXCxp2O41IGOzCtOHlXoH8UTs6ucwBRlsm2jnHIOkSBw6JyTPIfhhmlXWqrdZR0/3JbkuTt/H0Er4PzSjipCIl06AAf4VGtHQSYWOvp06His=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507543; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+vJpnvfptuaC6Iy+NuiUnfDRoq4x4POrOoIKH4TciFyVhBgOmVSgZfl9NLNSwJGPb9psueUW+lkE8J+jtS1bYM0RtbDK6nh+8lg+uUQ/7wY9Bcqa44XsYISqqWr/9xOw2pEFbDy5ok5Aq8AyW4Gognqh9zwlaXlg5Nge9findM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asVgDDIE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asVgDDIE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso4749348f8f.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780507540; x=1781112340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=asVgDDIEl/hUus8pyxQZJv54iYTduyujs1d8MjDzV4ySec94yjEROB7Xu2yukq+iYG
         FhsyScXHft/XuY4mw/OxxYdhFcO02RJojJi6wi8dpRn5bAx7wFSCbm0zOGsvMBh+RPlG
         nVpPcCdmMw7Au1hnRXiux6fquozCE/+MxxHGL5c94zmLvq3Ja22mNOn7n4Lpo7AGUZzB
         g7OB1vcibCoVqS97d+TO58mcsujD46ExP5pyq1M9ZqRHxW1PP0c8FU5nTZfGWkOvICh1
         CzjqAPQMMrD+aLLCmyyVlI08xp4ofePza/iiDlw3z3fPKjBZrAf9LAJDJz713a/DOCKC
         5cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507540; x=1781112340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=K1rs6tLzsjP4g4rSNcELY+BEBW5B1uvCf/xOnnLHmwCuqwu/ONNHGOQ21kCTTXnIw6
         iFyr/0AHLZrxu/Gq/kAGxqmFnVM5V88PRp3Uf2adgt7mi4Oz3txKqvjvaIIAERz6x9fp
         SRr6zHNdpRYERtvDAqAxbvhTnGDRhW7hz0L51JZy6JEH/m21tIMM2q/vdDkqGfUjjnw2
         FZR1LfkiITWs960oCd8zyoQk52Y3XScolPh6Iy3RyFK0yuqtfcATWsTEGeX+prBLaFzX
         RYKf73F7jktFEkSBrvVqX0PHzzaABKlcV3KkqSVDu27xgaOfGwNTaVbmKIjJdttiDYT7
         GzDg==
X-Forwarded-Encrypted: i=1; AFNElJ+i1D+R5TMkF4eW3r0n/yCZl/qo6hY+j5PXUzYcx7oSnE/bx1Fl0PKQV6oQ8Ac95eyzRGFmBA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWf713oZdz4YzZlh7Ml0za8Oo2/XvTaXsgKf+2Wd+bEjP5YaG
	DO+mT7WZp1EbYjoK+vAJtNrvDr5oLvXCPPw/ppUa4rK2rdEBMoIs9Jiy
X-Gm-Gg: Acq92OEhE9XHyhZyMB5y6QXbrfyRtSZxQhe/rdune+eTdBGJcxCCdEncZYoggtWa92t
	71v+1ZYbEQuFQBcnvmxrBHnAUGGA8DHsDMVQDlWG61D7FWFVduopJDFlruFXXPADAIKvDkZmQhq
	EukDIqutPwpCKT652XNRy0hbsaQfj8qcEtTw2cPX706gBKjyoPi9MKX+JK8VvIJNyN6LfiJyNsk
	hZhS5uH2PqTLMhO215mrm6M8o9bAz/vuiSRNlJPLjGKg3KHsM03bT/XsXQY+yhI936P8BtmBQdE
	nYzDyNIkXbuiEofQ4EYpX8yaUy90SvfXnDVyWsnm/RniLQ/3r9hsgGE+Xn+lZmJ1Hxxfh43yStT
	/yMZwfmQKo5qrvPzrnAG0MBPyDb/ZTAoohkgZdSqHqX2gCFk1aAWFc7ZMmj+r+Kg3vaXZyKkdz+
	hzUeHFSQYVDkGduIR9wDNDTc3JwnaD6jdU6nAzUJnm9xyBFXAFxDD5XEYdX11eHw==
X-Received: by 2002:adf:f8ca:0:b0:45e:ea46:ce13 with SMTP id ffacd0b85a97d-460217a5a76mr4654078f8f.10.1780507540027;
        Wed, 03 Jun 2026 10:25:40 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm9071573f8f.26.2026.06.03.10.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 10:25:39 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Wed,  3 Jun 2026 20:25:43 +0300
Message-ID: <20260603172543.19230-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity. The
physical address is reconstructed first and phys_to_page() is used to
obtain the native struct page, with offset_in_page() added so the
in-page offset stays correct where PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g.
arm64 with 64K pages). The page is then mapped on demand with
kmap_local_page()/kunmap_local(). On !CONFIG_HIGHMEM configs
kmap_local_page() reduces to page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v2:
 - Reconstruct the physical address from the Hyper-V PFN and use
   phys_to_page() + offset_in_page() instead of pfn_to_page() on the
   raw PFN, correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).
   Reported by Haiyang Zhang.
 - Built for i386 (CONFIG_HIGHMEM) and arm64 (64K pages).
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..2038d9f5c9f9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = pb[i].pfn << HV_HYP_PAGE_SHIFT;
+		struct page *page = phys_to_page(paddr);
+		u32 offset = offset_in_page(paddr) + pb[i].offset;
 		u32 len = pb[i].len;
+		char *src = kmap_local_page(page);
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0

