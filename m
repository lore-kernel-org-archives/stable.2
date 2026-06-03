Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E0480977;
	Wed,  3 Jun 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491904; cv=none; b=WZWgMR49uYey1xmTP+qGa8ucVpUc2sC3WGu14tSNOVwofiRfrKqjZEkq6fskQlmvPgUV2kQ3YBPHxnEy8kse8Stu9bjsmvo9q23baQoDXWL4bEhhPip5ee2PEC0R+k3CuMtR565BoRWzOljIb6P3t4tgL8y1oPnaO9NNMOkk0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491904; c=relaxed/simple;
	bh=LBErQI6nA7dzL7B8ktri5f3krdyfYiDJTLqjkqR04bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzAbzMVWNSVLfFDiTbsVSVmUzFB+CmyAqK9Qv0e1T10/Z6y0wfWt95ipthCni33s2aOMnAbB/U5mqV7gE2Xs/XmXU+obP74Bz4qx2SZTmbEPQLbikvB+gEO1U92Fo0BmUjpI2VODURGt+oYuwfZZWIUiFCuNYlsL1i4foMn/wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h5z94MxS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h5z94MxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OR
	mKfkx1an3GTIAvXWkc41xaU079Fl80NRrhqmonOHg=; b=h5z94MxS2/xnJ6CJwL
	AdhgJShigkFyt3+PEU178oFvo/2QCTGaeVp5OmYzPOi7E6pvcP++uOjla3VQxo+W
	N7uxeVuPCj/NOgzZyuratxB6AIiBh/q4eCz2t6BJWlYqOvcxnTjWuJt5lp2SAJQl
	goI/KaFt5bmVe2XpaoWSxqhpM=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnoqAAJiBqWd71BA--.49866S2;
	Wed, 03 Jun 2026 21:03:04 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 1/3] ima: verify the previous kernel's IMA buffer lies in addressable RAM
Date: Wed,  3 Jun 2026 21:02:37 +0800
Message-ID: <20260603130239.81400-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnoqAAJiBqWd71BA--.49866S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fGw13WF13Ar4fCFy3urg_yoWruFy5pa
	9agr4rGrn7Jr1xCws7u3WakF98Xw4kWFy5Wa9xurn7CFy3Jr1DXrsYvrnaqF17tFW3KFyf
	trsIg3WSg34UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5ku7UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7Aou9mogJgpqPwAA3N

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 10d1c75ed4382a8e79874379caa2ead8952734f9 ]

Patch series "Address page fault in ima_restore_measurement_list()", v3.

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>" we observe a pafe fault that happens.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000)  not-present page

This happens on x86_64 only, as this is already fixed in aarch64 in
commit: cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds")


This patch (of 3):

When the second-stage kernel is booted with a limiting command line (e.g.
"mem=<size>"), the IMA measurement buffer handed over from the previous
kernel may fall outside the addressable RAM of the new kernel.  Accessing
such a buffer can fault during early restore.

Introduce a small generic helper, ima_validate_range(), which verifies
that a physical [start, end] range for the previous-kernel IMA buffer lies
within addressable memory:
	- On x86, use pfn_range_is_mapped().
	- On OF based architectures, use page_is_ram().

Link: https://lkml.kernel.org/r/20251231061609.907170-1-harshit.m.mogalapalli@oracle.com
Link: https://lkml.kernel.org/r/20251231061609.907170-2-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Webb <paul.x.webb@oracle.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..1ae8647576ff 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -145,6 +145,7 @@ static inline int ima_measure_critical_data(const char *event_label,
 #ifdef CONFIG_HAVE_IMA_KEXEC
 int __init ima_free_kexec_buffer(void);
 int __init ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_validate_range(phys_addr_t phys, size_t size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index ad133fe120db..d7c18d8a3103 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -164,3 +166,36 @@ void __init ima_load_kexec_buffer(void)
 		pr_debug("Error restoring the measurement list: %d\n", rc);
 	}
 }
+
+/*
+ * ima_validate_range - verify a physical buffer lies in addressable RAM
+ * @phys: physical start address of the buffer from previous kernel
+ * @size: size of the buffer
+ *
+ * On success return 0. On failure returns -EINVAL so callers can skip
+ * restoring.
+ */
+int ima_validate_range(phys_addr_t phys, size_t size)
+{
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t end_phys;
+
+	if (check_add_overflow(phys, (phys_addr_t)size - 1, &end_phys))
+		return -EINVAL;
+
+	start_pfn = PHYS_PFN(phys);
+	end_pfn = PHYS_PFN(end_phys);
+
+#ifdef CONFIG_X86
+	if (!pfn_range_is_mapped(start_pfn, end_pfn))
+#else
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn))
+#endif
+	{
+		pr_warn("IMA: previous kernel measurement buffer %pa (size 0x%zx) lies outside available memory\n",
+			&phys, size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.43.0

