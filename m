Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104A249E5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496584; cv=none; b=lKq1cHHRWWg0/oVGJJuc+xk2MG/GRg8EIPTMb0ATdQQbAzL8uD4moBqBRoZMSWXXlR7TpSbuoXun6gIXnOxapHqLdvWFm+MgvRjJ/1p958J+TMXj6z4Jg2TxvUU2UdykN5dx+UMucTpwaDVUjrEaBEXePy/X4ue9XG0bXDM+AZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496584; c=relaxed/simple;
	bh=9/dvKj98T0lcLcrBlAslV7wU6ah0xr1RwMaxq1y0X0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iA6Bds5zyAkVjwxWvCqSw/YS8T9bBxpNlS1H9v1LpHDio2bJGBwhP2IVMqLhds/GZAHLRadis32LD24lXYkXR1vh2/LetrBWI42qNmQPCvWS12ohnMD7v3qkIJMz3+ELkPP2f3FT5DsTqx2KNBSWSPzdlLhNQyJ8ZUuu91Tobfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fv179Xei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fv179Xei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB7C1F000E9;
	Mon, 15 Jun 2026 04:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781496583;
	bh=3RxN57THkSxygaXUCUs4S3CTeLs+I0o774h277vmd8g=;
	h=Subject:To:Cc:From:Date;
	b=fv179Xeiq9lDsk6J6ulyXDXtS16RJs7Bv9CDBqN9lWAf7KntxI0eJ5ZhLvDLkDA/F
	 gMYxMbt184I0XKnzyW7RABBtmmrGFd+ubsI8jsdEYeBffT98iTxGDbVC889ID7FcEd
	 smV/b1EpvJPteiaI0nZDztvYfYCk5bu4BtE8g+5I=
Subject: FAILED: patch "[PATCH] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf" failed to apply to 5.10-stable tree
To: leontyevantony@gmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 06:08:25 +0200
Message-ID: <2026061525-bullpen-capsize-33af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 004e9ecfe6c5384f9e0b2f6f6389d42ec22789af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061525-bullpen-capsize-33af@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 004e9ecfe6c5384f9e0b2f6f6389d42ec22789af Mon Sep 17 00:00:00 2001
From: Anton Leontev <leontyevantony@gmail.com>
Date: Thu, 4 Jun 2026 19:59:38 +0300
Subject: [PATCH] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

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
Link: https://patch.msgid.link/20260604165938.32033-1-leontyevantony@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

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

