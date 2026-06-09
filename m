Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3723EDAC7
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042350; cv=none; b=L2TU7c5mi2gRr3KdmAL/4O2AfgGpdKl5bpYEGGLLXB8D6wNEuFzg/2Rz92SPgdq7AzpazoUSiXrj1/39tXzFH+l9pKYGiSS7GT0SNVA9AUka3Bw4CBMVUO1380VofJUyibGltj7eVEIesxXOL9cbZrhyGJ0++b0ATUR1MygVtIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042350; c=relaxed/simple;
	bh=QWfEeg/nxrq42jg80M8CZMQAti/TXrI6rkErWp3Soe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDMI2D+ATPTzT8uxw8JIqM2x7sWaKe8XxoPRDJEcNzAQUYjmMtU1mqTAF4wX4GNDs0Y0SIonvBDRLqgxjGed+kHm4isqQtpwCs6SBkVB2+FR1dmOEVJuewIXGbOSKEsbEZ9AzGm8jfNdcSZ1YaiR6OLPR1Ij8bTIPA/2LWQ7xXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bnAeZKMl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bnAeZKMl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659KBcSg081711;
	Tue, 9 Jun 2026 21:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=BvVJy
	Rx5ri+3hz+wZu12OO11YwnbFLcQ87JIU+PuY3Y=; b=bnAeZKMlvMRJ9R7ls8X8b
	lSLHl3nDzimZg372iDUYj3LE3fAazHKHQkBhNi22kiP+Y4XmOfwa7Xo+mizpmlHf
	1QjUgibxynAO2haFIzef69a+zB9XL36JnCeDhqn3FuUoTypdyXdRvIQjNBOHwiS8
	pUERgk7TjuOju5Lv/IQi2FVpIck2eAB+AP2t6H3+WjiQEMy/lPfVfEgct8ZJqtPj
	T69aw/jDydDMID6nxagzV7G0dBSm45rwbs9yl1ZZ42x0KHxnyLuY21Mck22AS+O9
	gYrhwWRFbBfLJIC4Cw5ZZ5QwWXbA/zTVBd+tlIOF3gEuVzBUIXGfAfyYvKSzPDeK
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5swdhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 659Lrgfb027587;
	Tue, 9 Jun 2026 21:58:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0qqgm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:49 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659LrtLK029331;
	Tue, 9 Jun 2026 21:58:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ema0qqghu-3;
	Tue, 09 Jun 2026 21:58:49 +0000 (GMT)
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, chenste@linux.microsoft.com, sherry.yang@oracle.com,
        ebiederm@xmission.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com
Subject: [PATCH 6.12.y 2/2] ima: kexec: move IMA log copy from kexec load to execute
Date: Tue,  9 Jun 2026 14:58:44 -0700
Message-ID: <20260609215844.1835378-3-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609215844.1835378-1-sherry.yang@oracle.com>
References: <20260609215844.1835378-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNiBTYWx0ZWRfX97QJGYv/G4W2
 mSv9g0KrFKWYU6+7hbbzNV3/cLqbsQdyInmXU4U/mRU4rcKauCUthXlxDKcdVYITXH85XzeMRtQ
 QInvXNVcPHrbgAOq+NUNl3f+jYilTWc06JkQRjxPnwVfFvGHcNC7eETw6SxcXwpygf4F1CAVT0Y
 B7V6DBV2Ir2Kt58cd0riue6+hfDX9Q8c9P5UKXrzEvwtL78qq79LFyrXNA0r30Oe7KrO5isSBwb
 Hd0qPIyyp2/zkzKb56/jYUrwOk5YHNTpRk1LzQH/UyB5CFvqGV/qqyATogjtvu3c26DF9Na9iDJ
 geuk4dCmp29mjOJYs6bk0oT51rPXOTMNmQoX2nI9NAgpUNloz3gUjz8NEykDvXaN0iiwFyuiiv5
 QfVvgR2pj2XRXAtxpwpAIaVhG7rlS2y9TfGPTYt9X2aISGgPxST00TM8hmigSrbi71WoUmo9JZw
 xxNAX/oR2CnK3JWLJ0xsZBowDa8DfeJfgARwX9Rs=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a288c9a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=hCMEcdXgF_AESzQGG2kA:9
 a=BpimnaHY1jUKGyF_4-AF:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: z6Mql-FgEWpnzI7WcNX5Mmy7uxM226Oz
X-Proofpoint-GUID: z6Mql-FgEWpnzI7WcNX5Mmy7uxM226Oz

From: Steven Chen <chenste@linux.microsoft.com>

[ Upstream commit 9f0ec4b16f2b41d663f688a8012e9e52b2657eba ]

The IMA log is currently copied to the new kernel during kexec 'load' using
ima_dump_measurement_list(). However, the IMA measurement list copied at
kexec 'load' may result in loss of IMA measurements records that only
occurred after the kexec 'load'. Move the IMA measurement list log copy
from kexec 'load' to 'execute'

Make the kexec_segment_size variable a local static variable within the
file, so it can be accessed during both kexec 'load' and 'execute'.

Define kexec_post_load() as a wrapper for calling ima_kexec_post_load() and
machine_kexec_post_load().  Replace the existing direct call to
machine_kexec_post_load() with kexec_post_load().

When there is insufficient memory to copy all the measurement logs, copy as
much of the measurement list as possible.

Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
(cherry picked from commit 9f0ec4b16f2b41d663f688a8012e9e52b2657eba)
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 kernel/kexec_file.c                | 11 +++++++-
 security/integrity/ima/ima_kexec.c | 43 ++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a20ceb4d27ccc..909432e804be1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -201,6 +201,15 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static int kexec_post_load(struct kimage *image, unsigned long flags)
+{
+#ifdef CONFIG_IMA_KEXEC
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		ima_kexec_post_load(image);
+#endif
+	return machine_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -428,7 +437,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
-	ret = machine_kexec_post_load(image);
+	ret = kexec_post_load(image, flags);
 	if (ret)
 		goto out;
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 4de9834c3e133..48fe9a7e1f456 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
+static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
@@ -84,9 +85,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
@@ -106,7 +104,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
-out:
+
 	return ret;
 }
 
@@ -124,9 +122,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
+	size_t kexec_buffer_size = 0;
 	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	if (image->type == KEXEC_TYPE_CRASH)
@@ -154,13 +151,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -188,7 +178,32 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	size_t buf_size = 0;
+	int ret = NOTIFY_OK;
+	void *buf = NULL;
+
+	if (!kexec_in_progress) {
+		pr_info("No kexec in progress.\n");
+		return ret;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("Kexec buffer not set.\n");
+		return ret;
+	}
+
+	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
+
+	if (ret)
+		pr_err("Dump measurements failed. Error:%d\n", ret);
+
+	if (buf_size != 0)
+		memcpy(ima_kexec_buffer, buf, buf_size);
+
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	return ret;
 }
 
 static struct notifier_block update_buffer_nb = {
-- 
2.50.1

