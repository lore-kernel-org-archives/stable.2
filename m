Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18570433BA2
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786180; cv=none; b=CAP0T2tIeepp2RJ/272SX6g90FSKVdDQE9mTqbXcuS5CIdJYopZCrMPdUwNEVlLeWBV/YU4Is0eXKRPg4aznG8euMSd8RvxcyiUIBZnFRHON5OBXg8nKr9tMGjSzDu/LJvLOMH4KHuhgvmQRavzpNAw7zCQzAgKZAA6IhX9Lyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786180; c=relaxed/simple;
	bh=8P4WPxOTYGImqUUcIeBUdKh02DVYLKu8M/s85ThEmAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDof2c7ha7dQgQQ9zh2yF+BzdmIZfoqOg5cM8C+BSmgcFl1QNzqaqVH0D6+Nfpazd3uLU3ex7Ku46oS4ZsDjRgIty9URntj2ClMXF5F5Ywzxif8KAIgn+acutcpiVzgqyW8ViOx0s18FJHHznMZX7B3eqYsCdb9k5aiG2o9FCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVvV2uZo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVvV2uZo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e533aacf2so182067285a.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785786178; x=1786390978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwuoYLIZuv5ApTNScLZwtjL2AQGWD4RWVJHiBkDbMFE=;
        b=hVvV2uZoBCVAh0kOoRixmWEWq0grvG0fuG1G5J06pOgrA8C1BiLP4limNhkJEWYNun
         5wqmdKhP87NMFsW1W34r1G0s5F/QMB1EaTQWNEzyDzz0qN8ra7K1BDFOKDj4GaFznplq
         TN8Zurpcf9a7C6CKlE1ooMLeJo9pWjRGm61U1TMVL/4wWcqyfQYhJJ3vZvdMnhLBHkwO
         +lTeKGFLD212wXIyHfJBCcuLNe7zK/iGdFYXtDtaLJbyTP0yMDYFl69bnGLBo0ayiQKl
         7qnBZnskeuj1bVIVlhcZylJIPsIZ0C/8IcjrTelqbwK+NP81HT3dns/C+R8HHW8wtm+v
         TpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786178; x=1786390978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwuoYLIZuv5ApTNScLZwtjL2AQGWD4RWVJHiBkDbMFE=;
        b=dKiU2yeo3LjsfxV4EuTbnKzjF8gRaYVDuuM6f1T7QTDthuQzZLVt5WVhOjFAWQNQi9
         IGknUU0wkmMlWUQW/wbuhog8Zn8VoFicXqjLo9hgQhH5iWIgTJADi81YgOkS2tvjX0Dt
         8728SernyJklDJ8a5ei0x/93vwygf37H+URRXRtrAyZBkl3RjJPSp6h5LqErxnn0rAjU
         1l+TqAf5qUpDTmNizHOrejDv8nHpSf+Nf/ZpxW2EtfL4kZl6lFVQSwN9Ze5m9Zmuoo6r
         CfiKDLxnRq/b9N+JeCUoFsZxHLRH2cAqHdBety661kvEXtOLND7pB8+sQXlVcBAYb7AR
         wH/w==
X-Forwarded-Encrypted: i=1; AHgh+RojfixR44v7StsuacVsL9hORJEjbnyIV8KKwISr3jNcJOAigM55MjSgQQyFMA+jderkWT6l1vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5N6eN4meRv3MN8nBHYMaIkSTMnJcjGJs0OG0hwdLWmW9eeu+c
	2IRmaKSv+0c4SHOxNS3xHhiJxdQprw0B4zOCiksphBjH8Lm4lcQOnhIO
X-Gm-Gg: AR+sD13gUhDCLP+2vKV2CLtBEf0zpIJRCf7Mh2UNjQERFoICSGowpFmFBv8wXJt6Fle
	UHXCt4WSTxXimMxZi3hXEG48px85NzceNRNqkYp9sqMnzYLJBkVQBOvffZ/tRZUU2ZCVvn9iY8e
	+luKAB7SWkoTka/HSRy0Xy9ryIXU9qKXQHHXsHRExbmtmE6cRdCZxXKsQGGw9AGuPrCUqNRNxP3
	Fhm7HJzYx7MmtzDHAaROqXG1/m7SDVOZnjx0q9c9TMDBWpDlBNKRXcOIcABnxPKg94E/d4ni1/l
	P6PUlf38NJdG2WqE6+BZdyIPUs4SdqI3outdWxp6SUoNsnb+OaXvccUSORdym81q7w0XqSWPlG5
	fhg6RgbU8dzVPqtL5xqQQKV3w9i7xjty0KTswDARktxTbWFv3GNrWQ7f1OEestsXRlCYqLaNigd
	/R4W3wawdXGXWuAWC4RW0Ws52pSn71Hg4BtM6qMNUDFtkpmmDcyua88A6KBPXnWdz3bVF14gB8p
	yocZeMbqoK2C+ZvaR+doiQIoW8SOSIcXA3PutuhAf/bahf8WjSdvmkrOg4xunaMMQacZrnm
X-Received: by 2002:a05:620a:284e:b0:92e:db1f:185c with SMTP id af79cd13be357-934a0aaee08mr2254503585a.43.1785786177782;
        Mon, 03 Aug 2026 12:42:57 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L (pool-173-68-111-115.nycmny.fios.verizon.net. [173.68.111.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc25410sm729451885a.7.2026.08.03.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:42:57 -0700 (PDT)
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
Subject: [PATCH] kho: do not reserve scratch memory in the kdump kernel
Date: Mon,  3 Aug 2026 15:39:38 -0400
Message-ID: <20260803193938.8778-1-maxi.saparov@gmail.com>
X-Mailer: git-send-email 2.55.0
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
kho_reserve_scratch(). The function computes the sizes from the early
memblock reservations of the kernel. The default scratch_scale is
200%. The lowmem and global scratch areas each get twice the size of
the early reservations. Each NUMA node gets one more scratch area at
the same scale.

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
memory of the old kernel and reboot. Disable KHO in the kdump kernel
so that it does not reserve scratch memory.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
---
 kernel/liveupdate/kexec_handover.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6fad9152387a..53b59edb5b36 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
@@ -1636,6 +1637,9 @@ void __init kho_memory_init(void)
 
 		if (kho_mem_retrieve(kho_get_fdt()))
 			kho_in.fdt_phys = 0;
+	} else if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
 	} else {
 		kho_reserve_scratch();
 	}

base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.55.0

