Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177360;
	b=pxXRTVJ9wWY2nyiE//TbeCdt3InpbrK9kZT9Wc+hhSt5TwobYiKo54rR95KxdDK4x7v5
	 I63tdyFlzn+7NbvoouQX/uUxD/qXHkVR7T0GT3K6saev2sWBVJ2spgBbb4vLnz4yZL15x
	 xQxUfO8NQx21ZNifsu7raQ5ZNfZbX+MMC+kWQJ0sKuFrNU/pmsv1+2ecEDM1l/W4ECrzg
	 ngKppcHh4u7J/Ian+vjTyqa2WIUdviNsXsS2gWaXfzMMayGLKH3ghl/XtHcBwyNgIPLVs
	 JrIICOjtWYxxkYeHWnfQiN1+4YPL9TW155L8sCzI8jaV/Wu/1JzmUazj+SzQFyWqbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
	b=i0OYDIwteuqsnY7WT5CC2BA5EGDILMXJ5PQ3vgj4l7f/nc0Rw3XvznV1sF/jdJj3ysyK
	 Syw1X5pSowTCKZTQxFgPOi06hVm6YcpYneqBO5cvWz0MHjw5qZTG6lSsXJwHE5hl09lsJ
	 bjsIZvyI3zipMdtt1zRMpoW+XTupaiexNUBX7cv3plNXKzZAzl+KbvCyF0GKvhIwrhe6h
	 U5r1cmvcODdy6QVSlTa8yzIf9TDyUnB6NOSyZ6AcJLETtpjagkGHXsvaWBuIRTuSpfzjZ
	 gmnUKzIUlcOVwULrn7ZLOoQuMz4R+Y/4XqD/Ojbo2PfmlyUBehMisvWExDc1AO13D1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1K7rhsu;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8A606A336
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E8A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1K7rhsu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso490015a12.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177359; x=1794782159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
        b=W1K7rhsuQi9t32f+bQcHhZGOQsL0RGDjqQOM+hwJgGqoozREYqfc0E6omTcmSvZAGO
         hpg+3t+YpKMGd3S03fzWkLqC6NgEsCbCY2aFasjJFINDTvfzckxUQ3ZJRCK4tyDkoT1T
         EZzcAmTN9jTnKQWoPpKzXPV2hxG70Yb4bRcGu9xgj6aQpKzWlxEBjH3+gSONSAND1jKQ
         q4R+tVSf7d0Q4EtKepDOVrAoOVfVvl/Uus+MxXKZr0bdXQ6+vAhzdC81d04XnoXXIwWR
         388tIorh0ozBQ9TFuIf/wddtWkenYopRM62PzNxC+92E37gDQxavAR0sGGxm4s4L7l6r
         +TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177359; x=1794782159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
        b=ZbwRmCr7laMZXgFm2C1zLd5Y0ByocdfxWiFGCCYrlVBpUg4uNkxUq0kw9kxv5oAfNw
         xSRgN1dRFPsEy/Na9iyNBMgY05IpuGy7J6K6f5ZZoK8XsErtYIxgFf+4jIxiTOdrru5h
         eCCQS4oC924ChH0oiZAwVwtXVgL9Vz5e+hJGYzWyIGBzMAWdOsbP4nu4zUyIunjDTxG3
         3xlkLJO8F2aGlUc9iIldCk4/KtG7e7WsOd5Nl8Zexkfzbv5e8uw5mB9s1cmvV39QXof/
         yU1SeuRrmxXDTeh5orjf0pE7gLIWkN74DrM+8Hnc0Wj7rT/3nMjVN+ZGZvNQUKgp0cgI
         UwpQ==
X-Forwarded-Encrypted: i=1; AL+hErFLKCo8n2Q7RauAAOeGFXNt4pAWMdyLApvtP28gWG2GDkEkP1DCuya4Bin+U/lJCRNQpOwaGoY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2MSohOsTKzSKijwjNNxSHhIKIp8Abd5Vrhy7EeqlanFFckes4
	Ot1pPKjtjXDoPmi7ETzit6tMg9/kNd6u3i6RN3d+98aeOd+lfPCWHxEe
X-Gm-Gg: AYBFou3SbPF5roVezCd8q1Q5TzcaK2hXqGtq0RvZLLdO8fG/t7T6/ch16QSjZuqk2if
	Ml4xLFCNlZ+YZWggYlE9v5jBFRDIjozlttTF6hf5XkBCzVqORPgFr3JEsVQ+1VhV0W/4BuvAfY1
	ySMz4A69PbMDkyDEB8kkQZb+XbeBbCfXwIo8g8YCTI+F+OY1rIfkj+jfk1YuWh7NOfOQCzLGffL
	PCLnXUFXwY7wi9gh7uWmCIIoBCQm70fMy2Ni9OFu+rZzM3RfAgXfOOu5qJ7/vEJ5Pe2/DHLFyBg
	pQ1gkhPXZWQPWAXueD9PdovxmYz9muP4+sLr4gMfMNjTzaiPYpLXgdQcPqXyq6wQ8jGXeXulJgs
	O/lc3cG5GN3jWkjX200f2/vqxAy6C9u4TE7nUlqKgYfLF2rDrkvccshRshkc3zEV+W5m/fB77ys
	5+pRqgXtxa3qXKDJ/tAONTnPah7+N/7ayUCobQQR8YuBORm9gHb36gzzzmLAsXosUsOfEfAwJpa
	WLecGkbAAr2CrPTPyQUhMNW5N+um4FZgTx4Zq3Off/XFv1YuMyWlfyxkMVzVP5vqnQPG0Q07KJE
	IkoN73oG9yTibQDQV1g5Sl7RQIslxHewmZhF43WB9bT5T8/t2bU+Z7PuWxcnu+E7Io9kkQk=
X-Received: by 2002:a05:6402:4501:b0:6b1:a86c:7b with SMTP id 4fb4d7f45d1cf-6b72247ff69mr1628940a12.36.1794177358857;
        Sun, 08 Nov 2026 14:35:58 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:58 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/9] sparc32: flush the source user alias in copy_user_highpage()
Date: Sun,  8 Nov 2026 23:34:12 +0100
Message-ID: <20261108223516.1125534-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

copy_user_highpage() also handles lowmem pages. A source user alias can be
dirtied after the fork cache flush but before write protection and its TLB
shootdown complete on another CPU. This explains why flushing at fork
alone is insufficient; the historical tests below did not isolate that
particular interleaving.

The hyperSPARC external cache is virtually indexed, so index bits lie
above the page offset and one physical page can occupy 64, 128 or 256
distinct cache locations depending on cache size. Two mappings of a page
do not see each other's dirty lines.

copy_user_highpage() reads the source through a kmap_local alias, so lines
dirtied through the user mapping sit in a different set and the copy reads
stale memory. copy_user_page() then flushes page_address(page), NULL for a
highmem page, with no NULL check.

Flush the source page's user alias with flush_cache_page() before reading
it, and flush the destination through the address actually written.

Only observable on HyperSPARC: SuperSPARC's caches are physically indexed
and MBus snooped, so viking_flush_cache_all() is a window flush and a
return.

Fork/COW torture on a two-cpu SPARCstation 20: 7 of 20 runs lost writes
before, 0 of 20 after.

The source-alias omission predates Git history; the later folio conversion
also removed sparc_flush_page_to_ram()'s NULL guard. This change uses the
mapped destination address and covers both cases.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/page_32.h |  6 ++++++
 arch/sparc/mm/init_32.c          | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 7429291fb118..c968ec33ee98 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -28,6 +28,12 @@
 		(void)(vaddr);			\
 	} while (0)
 
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
+struct page;
+struct vm_area_struct;
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma);
+
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 2f693b70dbd8..7b53ee9f061f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -103,6 +103,29 @@ void sparc_flush_page_to_ram(struct page *page)
 }
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
 
+/*
+ * The kernel reads the source page through a kmap alias, which on a
+ * virtually indexed cache lands in a different set than the user mapping
+ * userspace has been dirtying.  Flush that alias first, and flush the
+ * destination through the address actually written rather than
+ * page_address(), which is NULL for a highmem page.
+ */
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	char *vfrom, *vto;
+
+	if (vma)
+		flush_cache_page(vma, vaddr, page_to_pfn(from));
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	copy_page(vto, vfrom);
+	__flush_page_to_ram((unsigned long)vto);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+}
+
 void sparc_flush_folio_to_ram(struct folio *folio)
 {
 	unsigned long vaddr = (unsigned long)folio_address(folio);
-- 
2.43.0

