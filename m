Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487989;
	b=IQH3YtrHROPACqpH/UQM9UY2HJ9iqy1WGj+OggxfTABmkyo9+B/Iq5y/UxLAn1qtUbJ9
	 7e+0jl4FCN8XUVx9IOKcGge45KJ/el9ezWBIWOQPrZqT2DMhW0s/YrX9SVgmbCctiBPWG
	 AePEWpS2QRahUpiBSr9eQnQe1ZC4NM2YillSfVXJ/Wx2mtaos5FkP4o8cpX+7HuNhoWl3
	 OEwxSk2Kcdq1VLHY/PAwH5SJPU2pgRKRcwGOFjhpxe0EKr+7YSUEr8nUEZ6GhPjaD3HaB
	 8CJ1NItbCtq6ZagCjcF9dsi4EICi7TA/xKGLtselrpvdneEI+5pZWGa+LYf/84w2Y9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487989;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=Ho9lfVmh032DRkxc1lN+upULBMkzPGfKHmpBixAPo84=;
	b=CM6ZYFQbUvLLuTSq9Eg24z+9wAkQVKnHIIJdHMqzPCU4xxGMDYwn1aeMsjmPGFmZys3+
	 /MjQVW5VBufklhItZ4WW5WZKdRRIaNY4WnENH+w+ama49nLLY00+R7JoIAGcho+Qn644h
	 qgqREXIKXv84mnDxhYA0/+jTMAcy23ulcYKcN5ILF+y3KMZirTxf2wffUylRzUDU34KOf
	 1fpaFrZpsaTt+Cgcz0rHy/NZ7NRrYoi7wBaWkdD2pJBekiaj6ho4OFow4V4TRhcssY1WY
	 oVVUrQdmAYNcObviku/IlZxRhfdJ03F020BuRnFYSiQaWZt29lReEVO94kS/msX3JqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=FHXMsZjK;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F7606A333;
	Thu, 12 Nov 2026 12:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429F7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=FHXMsZjK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ho9lfVmh032DRkxc1lN+upULBMkzPGfKHmpBixAPo84=; b=FHXMsZjK+wefAnn50JdCcok8mn
	TRuHEMnf5i23qBfyHGbHtXnvmXH2Q/9cdqKnFoQ1Jlz+A2ZArjg68bTapmRe5mzC1tuFwSISJSZv2
	a3mSrAcXMEySMoYz372FwbRIS5WWhTDUmRhdIjEprKJAcDqeQ+5CSSJLV9j5Oln5n71+E6Q7Zzr1z
	AlNb1wIakd49DInoZAZIyLJmRm2zmluiqo7pivBxiiDJkFU8Pc9p2Pm1HqjjKW2eJ7PJB8XWIaWKU
	UmX1h04az5ovUpqAY69EBE8cSzzrk0F5a0rW2p1kotj7Dv1YEkGT6hEoO3Amf4gkRw/yUn+RZbfuu
	XDK3+haA==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIa-00000003H1G-2QwN;
	Thu, 12 Nov 2026 13:53:02 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] ima: clear kexec state when replacing file image
Date: Thu, 12 Nov 2026 12:52:47 +0000
Message-ID: <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

ima_kexec_buffer remains mapped to the IMA segment of the installed
kexec_file_load image. KEXEC_FILE_UNLOAD and a successful normal
kexec_load can replace and free that image without clearing the mapping.
Executing a later kexec_load image can then write the measurement list
into the freed pages. The new image has an IMA segment size of zero, but
size does not establish ownership of the mapping.

Record the image whose segment is mapped and verify it before the
execute-time update. Clear the mapping and scratch state under kexec_lock
when a normal image is removed without another file image taking its
place.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/linux/ima.h                |  1 +
 kernel/kexec.c                     | 11 +++++++++++
 kernel/kexec_file.c                |  7 ++++++-
 security/integrity/ima/ima_kexec.c | 24 ++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e08baf16c2f..d61b7b7756b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -34,6 +34,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 extern void ima_kexec_post_load(struct kimage *image);
+void ima_kexec_cleanup(void);
 #else
 static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 90756dc6339b..297f4657869b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/ima.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/syscalls.h>
@@ -114,6 +115,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	if (nr_segments == 0) {
 		/* Uninstall image */
+#ifdef CONFIG_IMA_KEXEC
+		if (!(flags & KEXEC_ON_CRASH))
+			ima_kexec_cleanup();
+#endif
 		kimage_free(xchg(dest_image, NULL));
 		ret = 0;
 		goto out_unlock;
@@ -163,6 +168,12 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	/* A kexec_load image has no IMA measurement segment. */
+#ifdef CONFIG_IMA_KEXEC
+	if (!(flags & KEXEC_ON_CRASH))
+		ima_kexec_cleanup();
+#endif
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59f9ba1b0cd7..95b3a9ab1e3b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -401,8 +401,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 #endif
 		dest_image = &kexec_image;
 
-	if (flags & KEXEC_FILE_UNLOAD)
+	if (flags & KEXEC_FILE_UNLOAD) {
+#ifdef CONFIG_IMA_KEXEC
+		if (image_type == KEXEC_TYPE_DEFAULT)
+			ima_kexec_cleanup();
+#endif
 		goto exchange;
+	}
 
 	/*
 	 * In case of crash, new kernel gets loaded in reserved region. It is
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 3aa8b1096f81..cc15aed8df48 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -25,6 +25,7 @@ static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
 static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
+static struct kimage *ima_kexec_image;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -229,6 +230,11 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	if (ima_kexec_image != kexec_image) {
+		pr_err("Kexec buffer does not match current image.\n");
+		return ret;
+	}
+
 	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
 
 	if (ret)
@@ -239,6 +245,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 
 	kimage_unmap_segment(ima_kexec_buffer);
 	ima_kexec_buffer = NULL;
+	ima_kexec_image = NULL;
 
 	return ret;
 }
@@ -258,6 +265,7 @@ void ima_kexec_post_load(struct kimage *image)
 		kimage_unmap_segment(ima_kexec_buffer);
 		ima_kexec_buffer = NULL;
 	}
+	ima_kexec_image = image;
 
 	if (!image->ima_buffer_addr) {
 		kexec_segment_size = 0;
@@ -288,6 +296,22 @@ void ima_kexec_post_load(struct kimage *image)
 	}
 }
 
+/*
+ * Drop the dump state before its kexec image is replaced.
+ *
+ * This function assumes that kexec_lock is held.
+ */
+void ima_kexec_cleanup(void)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+	ima_kexec_image = NULL;
+	kexec_segment_size = 0;
+	ima_free_kexec_file_buf(&ima_kexec_file);
+}
+
 #endif /* IMA_KEXEC */
 
 /*
