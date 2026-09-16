Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786403C4551
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561611; cv=none; b=nTCAGCO1p7SRoE3d9+K5DYwHpb2oKzjYofe0Fy4qW1F1zZ6HoYSPXOadKT3XEJUWMPQUeNrK2jf2CAvJFap82ADmS2ABrFok8IH1grG3W1iPHvOvsVflE05iJMJDYsa1135MtX+Dug0gZoc38j/JoegUfYNXDZaaRYkV3P7DNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561611; c=relaxed/simple;
	bh=5pFoNqcbjHiHc2g9ztOxqiTjXkw1WGUK0+WgybKUQrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjxT5gq4XHec9pIgIcmXtdHb2ujDj41EEVsYICwvhGDjBCxH/2nxtbNwkuwbgLp5w9AyHmtaccyPnR3j0EfIYMx8FDlUzuNKQbfe2Uo2UwqQvgPsC0eOLedl6THp7joE9svRwH0K1sRngGUglHv6I9RrD3fxXuh56J7Q7mDPmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEqbI7P7; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEqbI7P7"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso645731a91.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561607; x=1790166407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjGYXQhmnbmRBMf+vpJkuRpcnZIrEdYmJ/9OznNkh5Y=;
        b=EEqbI7P7DczewGRdsZAmIqt1VXdYF3nRx/qWHMbMfDX3ZGspsTvxijY7wSCGTGmrxY
         +t2mKxsgLmR2JC6uLuyUPDrRQePbpnaJ7ZIOW3O6N/P9EMKxupTlzWuxZzmOfk4aGPxW
         psbHQ7VnG8lVfGeTWYu2gkMcMBcVRo+3nht8UwKUTYz9fExCM/p95QGAkWduR9IJAeaK
         T/3nFu2Qg2xPg93RVUl4h/EynIsYYbZy6j0EreCbr2DOaoMZy15Sz5OaP56NudWRfxhe
         NH4hTn9AKzUYuKdO/NdhRIs2hkyiAXq39eL+Hw1YrjLbE63nCydSjnwie4LF0zM3ACkz
         Ks/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561607; x=1790166407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjGYXQhmnbmRBMf+vpJkuRpcnZIrEdYmJ/9OznNkh5Y=;
        b=uN9bAm67GdafivT5SqPoasorWf88wjLg6VEIlVTe7IOmRqgVrBHFNANM89UoxfxhyO
         KGt+fWRNbIRjFOuJa3fdreaP0aQP98pRPFNBB9ZX1gAbK973uSNlFCpdyL4wDNmZWqjw
         J+7pCvPqB7c2g2Edx/JgdxIi6aa1e4CVTa/wSkbm0At07VP8oUFtPydc36Ji4ENds6r5
         +O40aUrFvHykkjBfY6TnBeIx5q55omN0WmRCJOMdQABkjTa5lzUSpUnckWnC4OoXydmA
         IcKFcFoj3jJFw+NSWGm70H17sUIV1tieA9yMFCgeRoZBniQ/gr3dMOJUsCue/Ii5nHIE
         AQNw==
X-Gm-Message-State: AFuF++mAJuViHgDkOEdz1stHwW7owPU9Un638U9Bg5EDDUfv0fldl1xZ
	aIS47KccPpCyV8sL/CoFny1RXUmMjVbKA3Udf7JkkvEZv0rDsuULHesHRMrczA==
X-Gm-Gg: AYBFou2E/OF34kR8cp2tnExmI9kZXEmcZ54XnE/QxcZ8aSxCBlFtC+jdwlcInbV77pG
	BKHk0u80Bv0qqFekV4ucmkjkrOgolgKGrQQ98YQBNH7HT1Cm1ChzND3tDByTbstdV5qCXC3R4DS
	AG5jTu2VZMzoJidrjnYQhZsUdxSC2J0lHA2f8HaNI8E0dbvD+izLrv7/bRKAh4AQnnO+RVfynpx
	VDmKieRVXAcUXbxURayF8utNbn6I38/zrbWtsKGloYCmf0R0ZZ3hYKoB+HTSvpnH4DMM0axCqko
	g4fAyW8spAVH/1VijQPuZK8wy5GXsxWhT0r0tM9XXIvTeoqtyTDS/U11o1B4x4Boae4F4S2i0gp
	U6aSqhYxGz+j23qNdb87uiYcO80WSKiEr7B6BvXC/hKwGNtP6dJOWDEgTI9NY+vx4JOceMYRXj0
	rhsBx1nql2GaJJ0yXLgQaOXfeOXt9/RDKP6JrdqIlRPT3RMLVS80XMBE3kZA2AjAVcQzEOBnK0g
	sKHF9qRHKpmoL0ZFNQ=
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr5441233a91.16.1789561606766;
        Wed, 16 Sep 2026 05:26:46 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b69976asm4915208a91.5.2026.09.16.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:26:46 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 21:26:36 +0900
Message-ID: <20260916122636.3440471-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091619-kinswoman-zipfile-ef2c@gregkh>
References: <2026091619-kinswoman-zipfile-ef2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hwdep mmap callback rejects read-buffer mappings that are initially
writable, but leaves VM_MAYWRITE set on mappings created with PROT_READ.
A process that can open the hwdep node O_RDWR can later use mprotect() to
make the mapping writable.

The read allocation begins with struct usb_stream. Its read_size member is
used by the fault handler to decide which pages belong to the read buffer.
The read VMA intentionally remains expandable because pcm_usb_stream uses
mremap() after reading that size. Changing read_size first can therefore
map and access pages beyond the allocation. The same member is also
consumed by usb_stream_free(), where changing it can make
free_pages_exact() release pages outside the allocation.

Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
writable VMA. This keeps the separate output-buffer mapping writable while
preventing later permission upgrades.

Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Link: https://patch.msgid.link/20260908110053.2950767-1-hnkz.64@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit 71c610aeb1770302ac9c9e0b9a4ecd37f1311928)
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 sound/usb/usx2y/us122l.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index bccb47d38c6d..af92ebaf6e99 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -209,9 +209,12 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	mutex_lock(&us122l->mutex);
 	s = us122l->sk.s;
 	read = offset < s->read_size;
-	if (read && area->vm_flags & VM_WRITE) {
-		err = -EPERM;
-		goto out;
+	if (read) {
+		if (area->vm_flags & VM_WRITE) {
+			err = -EPERM;
+			goto out;
+		}
+		area->vm_flags &= ~VM_MAYWRITE;
 	}
 	snd_printdd(KERN_DEBUG "%lu %u\n", size,
 		    read ? s->read_size : s->write_size);
-- 
2.53.0

