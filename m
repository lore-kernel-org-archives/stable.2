Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074950;
	b=n5vo9mq+SUrHmx7cX2n5hONUGe234mRfWblZE3HxRAp0R+2fG0TWkDS12GB9Jm+k3rUd
	 YG/2LK6LosE1YrVRG/4I+mELwoR/Np0p0flnAjEI17EPWwaQ2Co7myNoECE+XlmJpDNVb
	 Ui0yiSDNFCmi0nap7QR0p0KntM+C6dGi1C+6L3BLEBK7YfsStliFFfJEamjUvYHqZAxod
	 y5BRnfv9etSzFxuCtcra8jbm5rQkcOSYOdiYpWTRFVKPWv3hl+Fqo73Ip9ZFhTlzxBuvA
	 Tm3E3NpQLsZTnCB4vdrKcuXPq1OsFKrrWGIJ9hzRlau+K51a1DpW8W1vDZre7KZoAgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+qp0OXlPFpX5xiEJlY0VrKPIDA5cshKQIUi1chin/AM=;
	b=AryR59OLqURM20DkV4/4ojl67HWGFHrJ60SGGaurjGoUKjvwl4AzSqsT19iWPui4HIMD
	 JIbyF6wMaXRgx59fc2uKNhSDFW7P4/+AaAprTh9T+5w9oT9Npw6cc1auyBrvTKbbKwrLu
	 f58/H2Sg4yxp18NAl7DEfB1rC/R/nN0h8Nv97fbUD87h3NLu4zwxUDzta6rNpfeWnVNHL
	 QXqAr0WtwiNXztq2ZtuCC8khw0Cdza3NCYVuKUua9hb2RBwZlll4Vfa4qEZkwbfdcFklt
	 sP8vzxRXwkhzM6EsGM7+qtwDzuXtVG1uDZJjlIjJt3NCpjJzKlx4u/b5GkVnpM8uziw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LqDJFQLD;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703A60A2618
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1703A60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LqDJFQLD
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-535179e995bso38199601cf.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074949; x=1793679749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qp0OXlPFpX5xiEJlY0VrKPIDA5cshKQIUi1chin/AM=;
        b=LqDJFQLDUaHIWGiWTCLkU2MVm9Lw96mlSopCwjiAvG5R3zeWpWiif3wxZ/jvpZU2XB
         Ds9A79c83QW7XHkAByvlg+p808i5CyquUbLlsLTdQynrhW37t7Fu9LYnL3PZZKN8GUMF
         fUhuTItx3x7SikAnl78R1jLlKSlTGlS0DSJyOwlTru6UrpEzprc/KXjoOShqN0G7d64k
         pr9R3gcL6YKefPFULIOrceLvG6f6UBz2i/COa8BYcr3cGGYyn9J9+L8EcN8otLWjqOT5
         p9v5JQywJbfi2ZrfhGtsUsn+CNZiC/x4Obt9KCNdqSHvkT9+RQVZrRc7EiRbaWxuwTOH
         v9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074949; x=1793679749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qp0OXlPFpX5xiEJlY0VrKPIDA5cshKQIUi1chin/AM=;
        b=gQRBB7AErU+LVMH7qbSjUYEsdKLbQTSP0BkNoKrgl/uiZ7CKArV+AEvxtJcVkQ4+yw
         7DYwDwz8iEQEooN2FqNuraZEuNTUIKyMwh74/VmPxe02L58yvQ0Y41XbTd9PZeZuICA8
         t0ySBr5vwd3hYlVQ9idTPK7OK9bXIJrRJ8q9qkVth4EEJ884v+PkzDiAszoBObS/6Gbh
         bZhsoAOTsEnvtYnw11q+53ZJ4zQGf0nv4qnL8SfaNRiNr1pQi8KDGoEG2OGZXzwIy64E
         wTBt2wjAM/Mzdf3WOPApVCDXKg/bRwVs6YNwUPB3ot6eDvFmzteeLoYyF6GTp+NVTaWn
         jtyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgYJ46JzbtRMuf9nPso9TINFyxM/+jkxMCZ3N0ek0LPs4pNBCj8cTlAH5/0ogKdW5e/HhomHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYInxF3bkOYPvcjcklx6pFJXOSon3No+uqEVliWj9nl88jlUR+Xy
	t1DIYrsxaxRxQmClT7vFWZVwxpnZk4gDyZM5LxR0m5jJMXwOYPMiAGb5SztdwdLa/Pc=
X-Gm-Gg: AYBFou3gubEQFip8SeHVJ8g1uVMeEIMw4YWNOM60BuELrmWz/bbUHKLSqNpBRLMK3bl
	2Q0afhRcmH7j2iCCyZZsqtPOKxsefdGNV9cVECLtir8pn+/wjyg5LiOrU0tEmGyuQ9YMeel6AEL
	dTGSzN4lNFKOqngyYE1ny4R+BijOqnCZEYA3G1w7C5xXeBYYsIQK4IsS1KOxtxLKLI8IsXvVIi4
	5q0YMAtU65nzlTFWoD7tzFGFXzVL5kE4WRQtYDhpzBKhskSA/HqgTRccmQZ7Cuklb5sU4Uy6p9k
	mQb+fs4EqsZnrCjmejBy83q6ZmNUSDVlnKgNGxgcvd8ibAUvatHofy85Az/YPQ337qF/CPYOyzx
	KeOVA1gR4M1SRS/U7qhT3+zuRgMy1Qh6KazOSkM7V1YAm9DYm4WE3CsxW35sZm9nxDdz/CrTCMp
	h5t+xX/LXDXE5IKTquZQ9rZxDjR0NUoDU3UsItoyKyM+3euoOa5nRhtr3VYzifkZgztm/PecUbD
	jtXzn2T1wtTO9a0+uzTONqBrhbgw2UuuOTQJruhJZVX7l/wgIXX6s3MGLDeIytowd/FOm4waKkW
	F8IXxWfYi6UMGGxcy+lIyAsuloiZnTmpwCVSa90Qlg==
X-Received: by 2002:a05:622a:a6cb:b0:536:66ec:1b06 with SMTP id d75a77b69052e-53ae5466c89mr89523631cf.50.1793074949087;
        Mon, 26 Oct 2026 21:22:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:27 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 6/6] mm/hwpoison-inject: keep the page online while filtering it
Date: Tue, 27 Oct 2026 00:22:04 -0400
Message-ID: <20261027042204.3741307-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
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

Injecting a memory error with the filter enabled while the memory is
hot-removed can crash.  hwpoison_inject() checks the pfn with
pfn_valid(), then runs shake_folio() and the filter on its page, which
can sleep in lru_add_drain_all():

  CPU 1 (hwpoison_inject)             CPU 2 (ACPI eject)
  pfn_valid()
  folio = page_folio(pfn_to_page())
                                      offline_pages()
                                      arch_remove_memory()
                                        vmemmap freed
  shake_folio(folio)
    reads folio->flags

  BUG: unable to handle page fault for address: ffd4000006040033
  #PF: error_code(0x0000) - not-present page
  RIP: 0010:shake_folio+0x2a/0x50
   hwpoison_inject+0x232/0x4b0 [hwpoison_inject]
   simple_attr_write_xsigned.constprop.0.isra.0+0x179/0x220
   debugfs_attr_write+0x63/0x90

Until the filter stopped pinning the page, that reference held off
offline.

Hold get_online_mems() around the filter, check the pfn with
pfn_to_online_page() under it, and drop the hold before
memory_failure(), which takes it again.  Offline and ZONE_DEVICE pages
never passed the filter anyway.  Export get/put_online_mems() to the
module.

With the injector held at shake_folio() on a free DIMM page across an
eject, base faults in 3 of 3 runs.  With this patch the eject waits, and
the injection then fails with -ENXIO, in 3 of 3.

Fixes: fd476720c9ba ("mm,hwpoison-inject: don't pin for hwpoison_filter")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hwpoison-inject.c | 55 +++++++++++++++++++++++++++++---------------
 mm/memory_hotplug.c  |  2 ++
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index a11222572f978..f6cc967b3a468 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -9,6 +9,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page-flags.h>
 #include <linux/memcontrol.h>
+#include <linux/memory_hotplug.h>
 #include "internal.h"
 
 static u32 hwpoison_filter_enable;
@@ -99,43 +100,61 @@ static int hwpoison_filter(struct page *p)
 
 static struct dentry *hwpoison_dir;
 
-static int hwpoison_inject(void *data, u64 val)
+/* Returns true if the filter rejects the page at @pfn */
+static bool hwpoison_inject_filtered(unsigned long pfn)
 {
-	unsigned long pfn = val;
 	struct page *p;
 	struct folio *folio;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (!pfn_valid(pfn))
-		return -ENXIO;
 
-	p = pfn_to_page(pfn);
+	/*
+	 * Offline and ZONE_DEVICE pages are not LRU, hugetlb or free buddy
+	 * pages, so the checks below never let them through.
+	 */
+	p = pfn_to_online_page(pfn);
+	if (!p)
+		return true;
 	folio = page_folio(p);
 
-	if (!hwpoison_filter_enable)
-		goto inject;
-
 	shake_folio(folio);
 	/*
 	 * This implies unable to support non-LRU pages except free page.
 	 */
 	if (!folio_test_lru(folio) && !folio_test_hugetlb(folio) &&
 	    !is_free_buddy_page(p))
-		return 0;
+		return true;
 
 	/*
 	 * do a racy check to make sure PG_hwpoison will only be set for
 	 * the targeted owner (or on a free page).
 	 * memory_failure() will redo the check reliably inside page lock.
 	 */
-	err = hwpoison_filter(&folio->page);
-	if (err)
-		return 0;
+	return hwpoison_filter(&folio->page);
+}
+
+static int hwpoison_inject(void *data, u64 val)
+{
+	unsigned long pfn = val;
+	bool filtered;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!pfn_valid(pfn))
+		return -ENXIO;
+
+	if (hwpoison_filter_enable) {
+		/*
+		 * Keep the page online while the filter looks at it.
+		 * memory_failure() takes this again, so drop it first.
+		 */
+		get_online_mems();
+		filtered = hwpoison_inject_filtered(pfn);
+		put_online_mems();
+		if (filtered)
+			return 0;
+	}
 
-inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
 	err = memory_failure(pfn, MF_SW_SIMULATED);
 	return (err == -EOPNOTSUPP) ? 0 : err;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b5d9e367b893d..fe2ed0894d49d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -215,11 +215,13 @@ void get_online_mems(void)
 {
 	percpu_down_read(&mem_hotplug_lock);
 }
+EXPORT_SYMBOL_FOR_MODULES(get_online_mems, "hwpoison-inject");
 
 void put_online_mems(void)
 {
 	percpu_up_read(&mem_hotplug_lock);
 }
+EXPORT_SYMBOL_FOR_MODULES(put_online_mems, "hwpoison-inject");
 
 bool movable_node_enabled = false;
 
-- 
2.53.0-Meta

