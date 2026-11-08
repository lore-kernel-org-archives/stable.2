Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177367;
	b=rAdNDIinucAF/ZM0oD5P5l2rQQWeGR1SHICNyCvLmYqkPamg//pyQClQFWp2jvBs5uB/
	 ZXBjGSrVKixpdh31nI35g+N/wuJlWXHkEMaJivJ0Y1oEVWmYOXvN+ZRXzGxs3LFu96EBK
	 8TBTRGWcQJ0IOoQU2KmdTTs7RfC0DB/3s4pFQxkBZj05N0kWGdjShjjvFIalIPybTFMkB
	 il+Vp1HY19WucCQr6LKW4/qT+s69pZh+aHvt2PtON3tXZVE2GajQ4+SbG5pQ0/+XzC9LK
	 Wo93VXB6qfNmoxakoxckkd2tHLej9xCs2wuU9w2XuDl9X2OOHa4asyD38hZI3StbCpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
	b=C+bj2i9m/XX/RYzFxofCXdq2/ekv8IT8rGA3bd5pa1v7rfpdKucf4ZfKcHO+6q/ITg9m
	 +toFEEAfpxEcHpZlAXrEkksjOnHUJLaAlQwt4DkuEG9OYlJ7ZJ/g4DnGmE2dJZwoCqkwU
	 Fwr/i0ArItRjekCsCcUbjtZWtm+WUKrsTGjL1qPxwR8mu3m8CK91VzXvGMnlV69h6iWkj
	 p0a4FDsmO2X1E6e6pTK/NHJDAz4eRQvDpZKV9Pk/F29uDYavt5JqKhCG7dE7pnA2ZHCtN
	 61S1MP8xFJcoPgQilaDVn1rD8Q5eYlGPv/SPB7J3Wm0ZcIkC+hgk/EHV3jzXRWWnd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iBo/fKGM";
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AD606D805
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981AD606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iBo/fKGM
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso799054a12.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177365; x=1794782165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
        b=iBo/fKGMS3ppUZ99HujRWX8cvvgsVD6yvyy+8UhlVRxMNGH/33aJGFgFPr4WXAaY4S
         Y6o2NVXXa8dRqpi9RiI8t/sj/0x5uXb3V7crE27GYU4LW3HxsZepXB3Lm9ou4hkiHAwR
         /xI8Sq1yalmKn/Qfg2HOLVdakOzKRUXnbtoiN2ILAFE7Sed5CtUYUEgmkvhc2ewo7Mgq
         MxwdNv2vw87q1hzcz1JIk67Xo/B3O2m/988420fBhhuotmz4nlYuY8VdQ96raI9f3fMq
         se6ITY0Li8M/Ek/WnYiA8dasnz8z5S8jsCjF19RZIyEuZHdhxk0VZgV88IITevl4rSpV
         whAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177365; x=1794782165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
        b=jSyseerIWIDIV+0IajbDbgdGeof+r+egqfQGPf/TiUcO1dvZXFwxjbNbxbqIkq6owm
         chqW0CODI5rt6CNJRaxKdBpNQNAfzOWV24C45jXjxVDkx8bi9PrmAhPv1DHyY83hTXGe
         X/8iNFDCe9Tg4sR/XxIcq37UyPNixmc1LtaT5yv6raFN62uwUQTadxcJ3/SS/a2nTzCW
         tGfgXX8/Lp+a5D3cnpEW1JFBD36ZUpF7bH3ArAUBYF7zijT8lv8J26WOHER+9D+6NOmT
         5gpqpjkpTye5zf4hlAz3IPuDnjLU7nG/dBlm/2vCd+AhLY3bhFJ9nLiHA9b2GXQQ4jw2
         1iZg==
X-Forwarded-Encrypted: i=1; AL+hErG0Aqq4ZZ+b1mSwKxSCF97+ZX9daEBNyETvRVoTcrfX94zaacXfZ1LGi8ygRDXRmIYJ5+pX0so=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bW5Ya9rFdTT7FtGQIEbcWSVGzU5Aqw+9rSCDBXmM0JBSxkoOi
	59v0fv1Y1NKfOol1zm0l2Qn5oWPM+QsUijdaIUaPRnR0/EoPQ6qJw8UF
X-Gm-Gg: AYBFou1jMX+gZB2d8hhHtTZ16DlPdxk8XFNEfqka5EuPmFflQ/MdYtNKeEa9ebl82+k
	oUcfsvjlgEDca66vFasLM1GJeocADv1NbIPNG/qPoq3/zey7KOmegS1Ihw11dQGUcDo00YlKaHM
	D2gXGErLvwTcHXqGUEvC/Vbw0pCULi8yCP4ye35I8+0Pg5ISpRvEsls8n4ymMM1dlGIOyeNPnSw
	7w8OjeJRPlZD4LDr/lM19rdbKnSeaPy5R3myU8BxBOM6HaD1JBsgTwGyYyWDpmCaZCHVgoRiVUa
	nGM0xyiOR8BVQKGQCpxB75XluDMJDiqH2TRk+xuFvLkq0hCRV5u9r3dzM427hk/QZkycY98icH1
	Avn/msPJRHTmwKF0Zx+iikAf4N4T/gpPVEv06ZR9OuQBBYd5l0cEWuDqif+jwtquNbqZVYKsQAz
	MoL2mk7z297ZLgFru4dkjxD2cB2iQh193KX55LsPAC41OM300UXfU2bCiWNTY+XpU9LoMWNC7K6
	atwDErCJ92NLZlRsAUnDWvjRZ4/a7w4VavEWFse9jzRc9Mo/WPSDj7OT6qw6TTbU19c0n42vsmh
	QWQ+Cfo6+0nss/T8KLu8ZO9GVnMq31yyNp1EfsCmQ9TNjDrIkTNyPJp4v28AoDI2FVedXzU=
X-Received: by 2002:a05:6402:c894:10b0:6b6:f5b0:889a with SMTP id 4fb4d7f45d1cf-6b7224abff5mr1066267a12.35.1794177365106;
        Sun, 08 Nov 2026 14:36:05 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:04 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 7/9] sparc32: implement flush_anon_page
Date: Sun,  8 Nov 2026 23:34:17 +0100
Message-ID: <20261108223516.1125534-8-linmag7@gmail.com>
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

Generic GUP calls flush_anon_page() after pinning a page it is about to
reach through a kernel mapping. sparc32 never implemented it, so the user
alias can still hold dirty lines the kernel mapping cannot see.

The SMP wrapper checks whether the mm mask contains another CPU and then
uses the existing cross-call mechanism; it does not target exactly that
mask. HyperSPARC's unconditional all-CPU coverage is a separate fix.

The anonymous-page hook was introduced with a generic no-op fallback, and
SPARC32 has used that fallback since then. Supply the missing architecture
operation for the GUP coherency contract.

Fixes: 03beb07664d7 ("[PATCH] Add API for flushing Anon pages")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cacheflush_32.h |  6 ++++++
 arch/sparc/mm/init_32.c                | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 9fee0ccfccb8..a65ee310e860 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -35,6 +35,12 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
+struct vm_area_struct;
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+void flush_anon_page(struct vm_area_struct *vma, struct page *page,
+		     unsigned long vaddr);
+
 void sparc_flush_page_to_ram(struct page *page);
 void sparc_flush_folio_to_ram(struct folio *folio);
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 9cf0065fc2d4..d0ce9d23561e 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -95,6 +95,17 @@ void __init arch_mm_preinit(void)
 	}
 }
 
+/*
+ * Called after generic code pins an anon page it will reach through a kernel
+ * mapping; the user alias may hold dirty lines that mapping cannot see.
+ */
+void flush_anon_page(struct vm_area_struct *vma, struct page *page,
+		     unsigned long vaddr)
+{
+	if (PageAnon(page))
+		flush_cache_page(vma, vaddr, page_to_pfn(page));
+}
+
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
-- 
2.43.0

