Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753E4334AC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390277; cv=none; b=YO09VdhT5fyPvNR3Y1hK8cSggTcX3zl+rDUtJ1W+d5G2kQMw0woswYNRYyUsUxyWW76L56pRid6y646Nsf79xtoUiXXwwlwIHlKzFOnZ4zpU8CQWU7WcG4i7RQEai54eQh5iPzc1qetVJ9JPILGO++nceoswB/szQu4rUcXiYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390277; c=relaxed/simple;
	bh=HYvMhIHogsEmsh3zuOs4+nenCywngBzCFU9HdpqBDvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Tez6Q3ZFKmFsqnpzusK5e0mDiqNitKn+Pf7hQqIPATjCXqgbfApbrbf1EASvnZnq3BZmRtd9kPQOT0/vWlGbtDe2dE4sXuMg3kS5GiFP1Xa8apQaMVfqx1aKHS3yb33UDTwZrsMSQp8yWfDX1FxHL4aISzatKYcS3pvN2ynZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7GqM8Q1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7GqM8Q1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2807370a12.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390273; x=1786995073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5i+hFEyj9xNww6KQk9eCZA+gjMFJ8e7FKLAkoQOfyOE=;
        b=B7GqM8Q1r5QmOqcmTgF5H9nd8UwMIfO7nXX8ka+2iE9bGfftaj7AGzT882xfgWXcTB
         f89QFUZvgEX+YwlzrpHkym3OBSXfxRRtvGCWeVbWqJ+iknHsFzflspbzTz08CFFfIo1L
         MExRVh8ucPhTGyyqCYERjGNL/4UNEPL8sznpoNS0g8g15tx0obL1kjM+RpIe9QL5mA27
         lqVJ3yQo/6UiiVsHZYM2EYXNdKfNHXlZKTL5rd7lxMQpTX/BcGO/1RxpsXmB2hraA6ql
         omnsZ9zZhNeOtK4vIBaurfB5mIaSM+rd+gCDmo6AbzhIHyLC+co4VmIr5OO1SPGTYxlG
         N1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390273; x=1786995073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5i+hFEyj9xNww6KQk9eCZA+gjMFJ8e7FKLAkoQOfyOE=;
        b=PcHMk80Y0WhlNYUpeGB23cjR7Dvlg3VFovGZuOOugm07n5LWZuIp98w8vvAoeJp4Pk
         XVOfoWNanZqMkrrWDu17rdToKwc9cIpS6ymhUy4H6pjHASacN2jCZrpsdeqpQfv53RKk
         1oaqxHT/9sgoGssqUzNJuVvALrekzMYucex7RGmDwoDkkPO4CxKc3MY//d0JSoe/VLtd
         4iQ5NnjgoCCdFme5U6ObTiB8DqbPjKJ897/+6Dg57pJ4cB5DeF3eg7/SJ6L7j8X6bP6J
         MNxLiEZbCW6kc1Ze9JjduBtKJb3FAeaCmUZ9IK95pqxf+5p3Lyulc284KEoWK/RUmGGL
         Nimg==
X-Gm-Message-State: AOJu0YzYoyPqI/aND8ksXORz1BkMd4RMGn6CnteZxDaWau2wwj6uWiDk
	kIMTqv/k8vWlNeM9SA4h9gfktJJSe/5nCOhbf+a61cQSG/eXv3+gvDjF
X-Gm-Gg: AR+sD13QDEeR+RGK2NpCXpr7Br3HbUIzck6SIVw65xpWGdSCbeLzq2XAkkcUD5f1jXM
	73R/8i+rXn3n37wM8jgRqEU1ETRFq3xpJDTl0VuxbHJawtQeSH+Oayi/10K7FjH1wKPg9XCurzZ
	61qAoRSu2sT3IR/ahRYmYOWasj1+p35t5YofgKNDUFcvoOo4b/ui/4YYpn7j4hkz+rbcfmau0Wg
	Nr27nlE7cCP/kooLVDZaVOCXTISJxq618srRuxNmwjE1XJsOXXMvYkshpAY+FbudXEsQZ1xXUQX
	zc5F5mznSlt6S/cUWZwK22p0f7ODRC0gne3qMtNffbRN9Pefpa33rvPaF/qrL6FPB72M4X8tnVG
	1HCpj9gNBzIwgjwLT9GpIyhSfpKAYBRMhnzpAe1Ji92Ho3VL30yo7KnppsNpC8dC2k61XWFL0XH
	Juq4uRCRrzYab/j6cZg19ABJcwYh8t4haSg072jywpWe6qKq2Y/+xXMgrTc4PijzaZF9ShfT13V
	JLi/Dc/MYPWW3lY4iSiu3KDw2Z5gkoAGNV0TZ98LZaxuh64Uayp3A==
X-Received: by 2002:a05:6402:3243:b0:698:5f89:9a51 with SMTP id 4fb4d7f45d1cf-6a355d6e942mr2088705a12.5.1786390273393;
        Mon, 10 Aug 2026 12:31:13 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:12 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5/7] alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Date: Mon, 10 Aug 2026 21:24:49 +0200
Message-ID: <20260810193055.3286239-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uniprocessor flush_tlb_page() in asm/tlbflush.h has the same wrong
test as the SMP one: a targeted tbi() reaches an mm's translations only
when a thread of that mm is current, but the gate is
current->active_mm.

Test current->mm instead. arch/alpha/kernel/smp.c is not built with
CONFIG_SMP=n, so this is how the same defect reaches a uniprocessor,
where the flusher kworker necessarily shares the only CPU with the
writer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 0c8529997f54..9ae1902faf8e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -87,7 +87,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (mm == current->active_mm)
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm)
 		flush_tlb_current_page(mm, vma, addr);
 	else
 		flush_tlb_other(mm);
-- 
2.53.0

