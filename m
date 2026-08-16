Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E62F8E87
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870844; cv=none; b=qtclNvx+JsppVqWRXAVVriDSInHONkmR4WMvL5ZtMoA90n/aug14CMIraTpSsOq7meGqLJ3LCobnqvDPGqBnZNOP21P0Vd5Aaa4/ToYREQ5wbag9UJ+rEnHtfjOSAAEkAXsluLVrKBYWG9Y6myqRabAm7wGmQ7o/3K63EvY0OFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870844; c=relaxed/simple;
	bh=6T7GMCkGLOuSfaHhVTsEusliObvxag9Q/Qbw1CjZNeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKE2kJo/gWAkRSZ92N+vTByQl6yurcrUXRuPC4EWGPVg2e4bRJQu4MV/GYrwPI5gAzLGYKnm2DnobJI8ipJV1zt+jeiWAKL4EesmL/C/VKTv5FvG0BMKO/sQi8zsNcdz/4rEbkIFV4WrbOkmzVqZiBB6sAb02+B5SC3ABFSmAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esCZ2Fxk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esCZ2Fxk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2432738f8f.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786870841; x=1787475641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TB5hLITgaLSvnkEZ2ABO7VyYwwjhkPuh1sGrI3sQjr4=;
        b=esCZ2FxkxMAdRy+o8iOCfI4AswWnHWutK5R2q7oAZxQ3ixw4OMsCSVKlaa59n4ogJs
         lgKdcdDAMOFhPmpwTGAdXH0nhtQIOdAfZzwsypuYL+OuG1CFdGwaUbwnwLURodh5YPN3
         UozwjNkb/YVhNeT8YsH8o1S+vHI2+R3fRifNWdccZBAbIqObt9m/sKtLuxvkzAXX6zWM
         ztLysI23yNgsS7g1Put4ityWpEuvNxfh32joEdJYAAEDC8rilm4IWgwziT7lEd9RKogQ
         xfESjQKjc9fT00mcaK7OnDmOG0EKFsI5WdL2uysBrpLZGX3n9xZbNFGeVktUZmyP87ND
         VKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786870841; x=1787475641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TB5hLITgaLSvnkEZ2ABO7VyYwwjhkPuh1sGrI3sQjr4=;
        b=Egz3xsYAHA3Qm8s3hXc2eePdaNZFM9Dw2sd9T65lVnnU5t9QxyzJ50uaaNdC9L+3NZ
         9QGHtv50AA8m/C53hxSMFr4FcAaScBj+Ou0yONtmdZu96OLL3Rez07Lvj4X3ovK6IcYj
         5UvFTOylRfNiqiIA6hkxtJ2n03M5TorTJYjX0bKTcHEJdlhbzSOSQmMoioRipDZCjGHu
         BJxgeSeHUl3VpgK/HXFE4HmWBwhsly4u8TwrB77+NHjiJeQvG3kMFThjP+Ym7QCQzoAX
         Iz6W7TSaQ6jaFmw0FQpdDJ7HIh5dXca/4/itLMCpc2tPLjvE4aNi6eP1Tsu/MIqGOEQZ
         joWw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7f92b6W0p+nrJcLwcy7HB2s9MUM4p6MjJugjOYyNNFFBUffasVrMujulgGJ7GJCWyJxzERNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9Rq+7ZsMz6OcPNf1HqlDN1ciuca1bLhBAymDe6waWjdNfHYD
	v3R7ZPHcNbnwKetw25IpfAIdTW6TxgDIVK30HO4pCEooU6khIG17o1dg
X-Gm-Gg: AR+sD11qHK4aK/u785P8MFq15Ne8LnReraCDFbRvra0AHaVzOPltDXZEpyyEuItdRTU
	Hpva879vsgpaU5vnGcyopq2ZSPKVn2+lO9BltyFbqrpnm5mPxD6FGAzldOYzNWB2jLh7IqApRZu
	T+jYPp9b1j3b8Ayn5mAAEKqyB6mTNFNat54sJldWEdMzhnrZ4XQ3Jv/eCiKWNmGD8Jg/pSzizqr
	p4eiqBkffYIiYWbst6qdxjZbEJLOnW9y295aU45zxkz5deb7zlajgLZ96R+YE9bUqlFkcGSYv2+
	jyouYIL/TK7yNbTcl9eYb4Viy7PlB0q+uyJDkW2bf2rfE6BanCKVtLBtBNxLLGVWHKNHfu3QpoN
	UuThP+KnC+ES6dfemRsbw9rvmL95XGIr28KIEoS/7WSjPsO+goSx+Lu57WYQH1RAdqlqJcZODfh
	aejdhBSygKnyq+uDLvGojc2IgU54NhTkoXa0j2tPrIzTJc+TUTuzN3Z4z+
X-Received: by 2002:adf:f392:0:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-4816078c790mr19677263f8f.29.1786870840761;
        Sun, 16 Aug 2026 02:00:40 -0700 (PDT)
Received: from zen ([37.203.152.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b13c3sm18665907f8f.19.2026.08.16.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 02:00:39 -0700 (PDT)
From: Kiarash Azarnia <kiarash.azarnia@gmail.com>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: graf@amazon.com,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix signed shift UB in kho_preserved_memory_reserve()
Date: Sun, 16 Aug 2026 12:30:37 +0330
Message-ID: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kho_preserved_memory_reserve() computes the size of a preserved
reservation as:

	sz = 1 << (order + PAGE_SHIFT);

`1` is a signed int, so the shift is signed-int arithmetic. For order
19 (a 2 GiB region) it produces 1 << 31, which is unrepresentable in
int and is undefined behavior; in practice it yields 0x80000000,
sign-extended on the assignment to the u64 sz. For order >= 20 the
shift count exceeds the width of int, which is also undefined. The
return value of memblock_reserve() is ignored and memblock_cap_size()
clamps the bogus size, so the kernel silently reserves the wrong
amount of memory for the preserved region.

kho_alloc_preserve() caps order at MAX_PAGE_ORDER and cannot reach
order 19, but a boot-time reserve_mem= region of at least 2 GiB drives
kho_preserve_pages() to compute order 19, and kho_preserve_pages() is
EXPORT_SYMBOL_GPL(), so the path is reachable.

Cast the shift operand to u64 so the arithmetic is done in 64 bits:

	sz = (u64)1 << (order + PAGE_SHIFT);

Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Kiarash Azarnia <kiarash.azarnia@gmail.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..c79f48bd64ac 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	struct page *page;
 	u64 sz;
 
-	sz = 1 << (order + PAGE_SHIFT);
+	sz = (u64)1 << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
-- 
2.53.0

