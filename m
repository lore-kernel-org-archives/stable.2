Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C83A5E87
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465150; cv=none; b=l5MDor7YFn3r6L23znLPD2be8Spzz1HbqDQ73wTrhFwhpoQCIrptQF4n7iC5izPNtiuvB/5AEQV5zFm0bR7FkPc825ci+Fr3hiwPiRsKDp/9mROFhgPSzsURznnlcnl0CBMr5Fliwp0PatH41b/VyloicDfnBndcptclDcYLt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465150; c=relaxed/simple;
	bh=Y4qG5HxjZHzWrdJQmg28DxVUuPj3jUZ5so1obewClHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpPj1/S0ZMQqN1KCFqLbe5cCUlozsiGcMC8R5ed4xXkNciLTT6T9JyAfH1PqCq250kZbn5kjvqFks7O4GYLFlTqemjXp70sJ8tXDXd0va0iObUCibcImCqT2IIcx5P1vYxMY5DKVglPemk+ZOYdChU3xq3LsVLx5EUuIOW/gQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNH0nHeC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNH0nHeC"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f0e5e36912so6070836d6.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465147; x=1787069947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrrHTlApXY4U6JlaL8nMvnN7qO+xyOd6Xm+nS8KTJxI=;
        b=JNH0nHeCBQ05pBZj3arOAeFQGQAYPoOO08OkdXruwby65NKoixSfSSm4gggzlstPOe
         68YV/Hr8XCJh+chTcu5CenWCJMhOSJnPPOrY28LCRXcGAPCDFKQpCQ60IP2nRbTQHyZI
         JHX5nlTBBJG/m/UBHekyZ2xGdBCaLS3cGLBwBg3f1TNfREiJN9CHqLxfTLu6GVqfcNIQ
         hYIRzO81QIGGiYieoku6AB6izBCpTfqgcItjH7OymBo7IeOVgcknRumk5JaIhmFkL0VE
         i+w5vo2DxJXCrzzRJwWNYpLKDc3sMYjj+bwJwYXyQyqoKTCRDfkLK38yem8nEhUMsozD
         tmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465147; x=1787069947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrrHTlApXY4U6JlaL8nMvnN7qO+xyOd6Xm+nS8KTJxI=;
        b=HtAs2oWaucK1Rp2Pf9PSE5e09gvTnr6N7ZAL7GF176zys4xedhTd9m6mP7zDCLa9J2
         h6FURxtn4EzbJH3hUr1UV7c5wcby7JwPDfss+pm2VKJQeeSOujSXy7nzyEPdDxOBtFkF
         teBT+qENYXUJnaG04TQ8gqZwoCAb5bqID5NAYsJ0e0TkrlLqciETs56Su8+IG3p8g1Cq
         0dzPnbu9sPvy/BU5MP0lul4avwhx3RtI1878Dm2ib5Ha2ITgSt2xCxv+H5FhrAAn0G9M
         Uehtyb/arMDBs4+g+cdzJSELPcTFN0ND2K5dNFltcopJxYaOy4OzP7rYsaUk1qCRDgpe
         hGiw==
X-Forwarded-Encrypted: i=1; AHgh+RpR9d3nPLzuVmIZNJKm23Y9fztxOPacnK+k0ltOIV4xi6ZZg8pOat7+If1KN0vN2owRIoPj+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DbITF18fYIWMLzRmyFhUv9DhmrnTMcYQUU42R1YB3FSRmgR1
	FROcv0iToIJmPpG3YVZkfhtstXkiiH56YsKFzRmdFOLA6DUfFGX+VkXV
X-Gm-Gg: AR+sD11QN9Rq6TIicRsYMrLvqIK5TpnsyxcKyGpQoxAaOcyl41VDH4E8h5sYmnl8Y6m
	vm5Nc2MF+zUmdMORkqGsvxuuaJ/cMRrCUl1AKSPZ2uv6/CkzyV8hU8+vu/eMquB1c0SE+x7ze6t
	wUIJo8usacWZ3hRJwIegVCsS7K0bFtjqLMXXB/Y3BuqoyRHWYBZXNr6Gui3ZG5/x8hLAqWxhEKd
	9OplKCgxwUAP3mk7xwNc8DFTParPny5ir67xDvmzi+RCv9WAQlvTpVdi+Eq+oD/II/ZE3dba2VR
	VViM+SZPgVX1lyf0LyNMNKqTYLqCtdsiBLpJJ7u+8hcjQeu8vRe2Iy+KpteCydz9PV1uzG/Gy4S
	XhPY8Bxmz88A3yihjKH7NJGoZKKYCBP7aSPrpqjVEBiRSVzQU4+EvR4nXrF7udOfiWe9c4sfuQY
	gQLJ/nnOObB5drGp3xWYBfvcW+vdWu/WgurhBSTYOyZLRZ2enOIjniekJFGpT9kVZNozEwtl9fR
	llrF0LsIb9uwspoT9rTKbnzin6StiVbHJnRrfIHZNCRyhka037c
X-Received: by 2002:a05:622a:4185:b0:527:9603:8123 with SMTP id d75a77b69052e-52d600ad28emr17978671cf.2.1786465147363;
        Tue, 11 Aug 2026 09:19:07 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L.mynetworksettings.com ([2600:4041:5d54:8900:9c8d:ddb9:b1a2:735f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3bf12fsm2323716d6.38.2026.08.11.09.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:19:07 -0700 (PDT)
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Date: Tue, 11 Aug 2026 12:18:57 -0400
Message-ID: <20260811161857.3096-1-maxi.saparov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803193938.8778-1-maxi.saparov@gmail.com>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxi Saparov <masaparov@coreweave.com>

If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
does not receive a handover FDT, it reserves KHO scratch memory in
kho_reserve_scratch().

The kdump kernel always takes this path. Since commit a6715d7ec472
("kho: skip KHO for crash kernel"), the kernel does not add KHO
metadata to the crash kimage. As a result, the kdump kernel never
receives a handover FDT and always reserves scratch memory.

The kdump kernel boots in the small crashkernel= memory reservation.
On our x86 hosts, the kernel and initramfs make approximately 176 MB
of early reservations. The scratch areas then use approximately
650 MB more of the crashkernel memory. When a large early allocation
fails, the kdump kernel panics:

  bio: can't create integrity buf pool

A kdump kernel has nothing to hand over: its only task is to dump the
memory of the old kernel and reboot. Fix is to disable KHO at the top of
kho_memory_init() so that the kdump kernel does not reserve scratch
memory.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
---
v2: Move the kdump check to the top of kho_memory_init() as an early return.
v1: https://lore.kernel.org/all/20260803193938.8778-1-maxi.saparov@gmail.com/

 kernel/liveupdate/kexec_handover.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6fad9152387a..97729dec6359 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
@@ -1631,6 +1632,12 @@ fs_initcall(kho_init);
 
 void __init kho_memory_init(void)
 {
+	if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
+		return;
+	}
+
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 

base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.55.0

