Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598701;
	b=YISuTZVq0B15wcm8ndMwVVPTk/R4xAKeO8ODp5RKgdyKx4nULx7JrEn3VTmkSk4vIsBt
	 JPDqiRlZEa8mwdjK4/mEROEMegQ8ierWwBSVOzd2KgXdw8mS8tmB34vuU0GU4y+CirfuY
	 +QBPZmbv/dON/16BxQeLa1KdUjcvFb3qkmU5X5h4lNSeV2tsQv4cvq3Hoz3F861YLZ8Ix
	 7tWHfx51wp3+OnLQErwfRrwKjwxByYRbxSy4ibMGZxqClYAyaSboSmQ8KsRTX4hDdP8Lu
	 SqYIx7f+C8XG2PV1Cc2aOSdUbvj5ejVa3byzXkL9bsgeS+s/GAOfgbDCcxW6jEhyrng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lprKMd/Cznsmc5fuL6v7XxVzYtKcce6V0NZVQATR6sk=;
	b=3wg56MOb3N4mkLxjxe1QLmg1NbTmCZiUEGkyhKLHhZPh80zXvnL4Z/h1N7fiZVADb6yv
	 Rmc+sYKxTGIcZPqEc4vk5M6aKcBqi7kNmJPo38kgavYu2imwDjIbipuGA8RzUOBnlnLkX
	 VBHwzCoihJ6Z0L/kitLW0xci4qy8LB4w60sIP0KYbOtnqakwujUWOC2/TMpyNea33ZBeb
	 5RAg2cJ8eZmohNKsK3kr9Jo6d2zsD26XYCNAyU3vrO1Zx4dRMjWLqyNoiScmaRx6IcYrl
	 CIY6xaLmkmpY+qOfTGzBTzFFIw8n3XqzCAnn6BoHXL/q0f2aVaEo3sjocQ/kgAaRFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FE1/vj5q";
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C03606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C03606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FE1/vj5q
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c58f18765so1126063d50.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794598699; x=1795203499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lprKMd/Cznsmc5fuL6v7XxVzYtKcce6V0NZVQATR6sk=;
        b=FE1/vj5q4B3ICRaes1Lt07YO6ka8qURJ+8xHVawCb2fVuFPpsYEOGtZ8rJjVZpXCel
         klZ0aP/EwsFcwEV1H7Lwnp5MduJ42S7GEIkBPlz5ze42KCcj9FCE4m/0HUxB9YMEnUkv
         F4SGSb75vCl+6bS9pwv8hg02zawioTTLC5LjDiG43RE0Fwd4v9IBn0dNGhqEK63SGaSR
         67KCesYGzkRiTwNvKz8vK7ZGdmXBuqnDo8pRTP81A7mRYOQGCsdYMrmSNRb3P1hj0NMo
         xKANvFjCntol7in4g1Qea7UkylRdi8gMFffeiyaf0r8HGP+cWZDDOo/xjaZgUUsiX5RW
         kqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598699; x=1795203499;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lprKMd/Cznsmc5fuL6v7XxVzYtKcce6V0NZVQATR6sk=;
        b=kK5wSM2Va3qmM4dekqK4SFYMyoCJCprvETSCF3/3su1+7Ue3J446VMDaxr1qHX9rEy
         KgoEXDSVW5mnC8/VEFd7h0TzSvy7ARJeFMr/VuenKMrTyAHu42+JbGnWFoUtzwbOvM+K
         orZX8kZPGwtKBoZyOrUdhvTk+I5y/9jP1P+AophdzjMEeddyg8tkuhoWymbVYD2qFHTl
         cNW26xsQDwEc5OVpHdTr4QKJb6t8NyvllS/qGIhx/U9gpIEXKDb68gUrM7Yqe9ZIvICN
         /RyunTC5tEYDuBwYHSvZhCcwnj49ADrX52QP57fH2c/mBpNoAgWFROJBhm4TYdVmmAGX
         41FQ==
X-Forwarded-Encrypted: i=1; AL+hErGvT3DBKZKjo5OrtxrScY/6bLiMTUiXkzwMUEyXACziVq1OGmj0268t30ArOzNL0xLaITASJcY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W2kOyUluBD+jOyv8H5MDBN66zyRRXksuPQd+Kxd2tuZsgtaal
	vSSCXefS894A7d75t8aTtmdwNeI/8mSlAKLMLMnmTF/gFWWgLSbFpAI1
X-Gm-Gg: AYBFou0mykbX7/Bzdt0rfxvWzkhQwL2BuNQxMbLYFT4wtkPRNIyOBaI/YBzkiICyY5e
	kAFjeDUZhCAeXKedONHCaY4m0bJJQMmHU5lTshCG8DM1A3v12fCnvekdWfMU0eSZ9zgFJK5b9t0
	N4hcaCi9me5CcXAcHrYS8l0G8rfApgSUglJnlApCc1G8sNUEF3YgzcTPVkHbgSxnio/6BVdz1FT
	cTRf22EYokBcUtPWVf188vd0NbdayZ8nRQLCuvMqX7kdOtxoQMKCRukCVUTUsmbZ1tkdjFo64c9
	ZiActcOI6VtHAhtZJYFIDT5rdyS86dNr3SAvtZgrXmP/cSYu2mZ0AhWlwrkbRt3igwblpZkrS43
	X0/cCCKUIx6ofqPP7b6j1M9bISklT4wMlzfuS/NEcwrEqk2/gHAUmStduRiOGfIdg17PjMcizhs
	CSzJU7HjrVwot7X5CiJsP1+Qt4QBYJRSWNav1ETQlAsvLwfGcksvbO8DhtWSX5taMzJn6ZwGsLq
	G11wPX9b/I0zErJyw93BzmFHr28ddRjaESEvHVbyJrkYjqCRJ0UWG1/8w9nkR3fiBTrA0bH+ZgR
	6rz6uKl84gXV8xbQX/N91mbi
X-Received: by 2002:a05:690e:1501:b0:675:3507:46f5 with SMTP id 956f58d0204a3-67d89758c74mr1463866d50.89.1794598699469;
        Fri, 13 Nov 2026 11:38:19 -0800 (PST)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a4339c3sm2844892d50.3.2026.11.13.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:38:18 -0800 (PST)
From: Ivan Ezequiel Rodriguez <ivanrwcm25@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: use PFN_PHYS() in phys_mem_access_prot()
Date: Fri, 13 Nov 2026 16:38:12 -0300
Message-ID: <20261113193812.1239880-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

phys_mem_access_prot() stores "pfn << PAGE_SHIFT" in a phys_addr_t.
The shift is evaluated as unsigned long, so on a 32-bit kernel with
CONFIG_PHYS_ADDR_T_64BIT an address above 4 GiB is truncated before
uncached_access() compares it with __pa(high_memory).

mmap_mem_prepare() already shifts in phys_addr_t, so the mapping is
accepted and then left cacheable. PFN_PHYS() casts before the shift.

On a MIPS32 XPA Malta guest, mmap of /dev/mem at 0xf00000000 without
O_DSYNC used the boot CCA. The same mapping with O_DSYNC was uncached.
With PFN_PHYS() both are uncached.

Fixes: 7e6735c3578e ("/dev/mem: use phys_addr_t for physical addresses")
Cc: stable@vger.kernel.org
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 mm/char-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/char-mem.c b/mm/char-mem.c
index c5761ddedbd7..53ce0034a4c1 100644
--- a/mm/char-mem.c
+++ b/mm/char-mem.c
@@ -272,7 +272,7 @@ static pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot)
 {
 #ifdef pgprot_noncached
-	phys_addr_t offset = pfn << PAGE_SHIFT;
+	phys_addr_t offset = PFN_PHYS(pfn);
 
 	if (uncached_access(file, offset))
 		return pgprot_noncached(vma_prot);
-- 
2.43.0

