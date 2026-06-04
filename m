Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D239D3F1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592379; cv=none; b=W0I33K1PVfp/rbGrD6qUOD5oA9SivQjH6jl5o1fL9uwN+rMf0Zp9CBiuw41DIXx/ONYVC0tK1b5UOfAOgas88ZFN+mKRb54Gz2PLx+hfGv8hM68yiYCMWEYl+k+QoV8vnE1QMCXhTRds8GXqLFAYo5+jTR0J3wAEX1TbolzL3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592379; c=relaxed/simple;
	bh=yUtTpJHdzEWbgTjsiuCj893qdVCNtyL0l8/2vu8sS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVddIjXXkMrYjOpuiIcDwO8T1gcmxze9DPM/htJPhAxDICb5SiKNsNSqG8SlOgkhb6wjTvPtwJ9D8PcvsVF1Q/lMtdBPUE+MGj28zDI0BhIF85ISO4FI+1Qai6pcHhyS9ozRnCqlIPPZTWXTA75V7aBXu1eSegZO9xiQB4qxIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3azZzTf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3azZzTf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so681948f8f.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592376; x=1781197176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=l3azZzTf4EZCVX985MITEzwnHVrxpYoDZ+7GeOT75J6Yl7pzlRp9z8FUksGklfxSfO
         FbyEgSyOH78cyvMnipX1G3pn16hEUjqzmp4K6lQ6+zxb4N3jp23zpFsE1dencmxyCm/V
         jlLMQ/efXxRDXqhKS3khhnx02Oe4IqWSOFe9Oh5sWnQ0lnY0oOUFaX7qShd4hd9Ua/8/
         /nACZ9JrUUSq5exUxtua1rkY09rzwdoVhnEyoKR46+KxmEM3CsSPfsH+U4oA8mttTjnf
         4eh8J+T6uf3wTdxC8XE5fCV/PjNLBrTuM1dobmKR8diC3jADYl0Ihh2aLSkYC4k9tt6r
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592376; x=1781197176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=hvMSOeqCwa4L7+QcJLOVz5o/CPFpeWHyD2m4zshZgZCZ7m6tjACkqXtwEc70qM6cUm
         II+PBWEWiiOH634IEZluzxo4bAfFIEgvZJ84yBgCFKrWzvrbcsENOoe+YItgrXBJhqBA
         qfxljRSHdnoEXNzcrRt5oBa85LnZ3AUIvUuylNGIeTnJJ67/7/7BkBoApYiJh02oB3YR
         kEuk4Hc9DPFePH64mFh0kh2ouzbTawdUsTeaBX7fKw/20jXH5fWjwDOg3tMcRvy+IMuY
         QcVu+c7OmxyeJvW27Eo76w8eauL2FiiILhehzjefN8mQJf03e4dqlA0xkZyljcJbdyeG
         C7xA==
X-Forwarded-Encrypted: i=1; AFNElJ8nc7gG1WntT3Tx4ucqjNP1a/UXa237Fdxs0jqhqZ0gdkdPrf9f/ev/HVyh8Ag0ZAoK1NRU3uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBZtgo260FOj/iXGI46i1rZT0nBMhh6o8jbVJntb1kpimXUOn
	gxSeyYq+v/Xsg2ASlMYqJjv3f1K/Dd5ZayuGktL42OSrui0h16nk0S0X
X-Gm-Gg: Acq92OEFQIIRfTwTtWStexbl3HzESh2JLumut8JdIWHmRWBqpkjn4S1p/9p2KSYJei5
	lMym1GlSI3/AhC4RCNuTwnqBiFZ7I/pBZ8MrxX9+b923a9Q2FoeyMOfyIWv7reuIXTngaeRgLyX
	Ihk8VOOU4Jj9FL89/mTRPYF6Ak5UZE1SP7qWQMrtKMeLTzh2MJ4pNR3FFcVL//eQ4dByte3jeDp
	+J+IwY4Xbm3eD2mTzwiNxAedZbKiRWYwEzulgBIWSi9AYFKPNFXMNetA4eLn/bG4zF3lKnQR7IR
	7io7saMoYQ17xK5Z7N+eGXde8RNGHjCpUmTdVD3pRL/N0QjC5RaolBx9WW/GIVHdtqGiatzYZW4
	jwT8DOEBDl1F0YTrjyA8f18nF/t0wpYKmAogD+sdM0aeJqS7k6geJSgmRNboePyqbzvh4RKm5wS
	Wflgj1zhqdak+rBQD5dU7SZyUGCt1F5SstNRXuIn2kizTGqiF9+c9K621vbdWHAEUXu3Y=
X-Received: by 2002:adf:ef0a:0:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-4602183267cmr11729522f8f.21.1780592375658;
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm17376308f8f.21.2026.06.04.09.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
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
Subject: [PATCH net v3] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Thu,  4 Jun 2026 19:59:38 +0300
Message-ID: <20260604165938.32033-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
send buffer using phys_to_virt() on the entry PFN. Entries for the
RNDIS header and the skb linear data come from kmalloc'd memory and
are always in the kernel direct map, but entries for skb fragments
reference page cache or user pages, which on 32-bit x86 with
CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
phys_to_virt() returns an address outside the direct map and the
subsequent memcpy() faults on the transmit softirq path, which is
fatal.

Map the pages with kmap_local_page() instead, handling two properties
of the page buffer entries:

 - pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity,
   not a native PFN. Reconstruct the physical address first and derive
   the native page from it, so the mapping stays correct where
   PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g. arm64 with 64K pages).

 - Since commit 41a6328b2c55 ("hv_netvsc: Preserve contiguous PFN
   grouping in the page buffer array"), an entry describes a full
   physically contiguous fragment and pb[i].len can exceed PAGE_SIZE,
   while kmap_local_page() maps a single page. Copy page by page,
   splitting at native page boundaries.

The copy path only handles packets smaller than the send section size
(6144 bytes by default); larger packets take the cp_partial path where
only the RNDIS header is copied. So entries here are bounded by the
section size and a copy is split at most once on 4K-page systems. On
!CONFIG_HIGHMEM configs kmap_local_page() folds to page_address() and
no mapping work is added.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v3:
 - Copy page by page: since 41a6328b2c55 a pb entry describes a full
   contiguous fragment and pb[i].len can exceed PAGE_SIZE, while
   kmap_local_page() maps a single page. Split copies at native page
   boundaries.
v2:
 - Derive the native page and in-page offset from the physical
   address instead of passing the Hyper-V 4K PFN to pfn_to_page(),
   correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).

I do not have a 32-bit HIGHMEM Hyper-V setup to exercise this path;
testing help from the Hyper-V folks would be much appreciated.
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..4d319c50955e 100644
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
@@ -965,12 +966,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = phys_to_page(paddr);
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
-- 
2.43.0

