Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E3EB107
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042349; cv=none; b=BSkuq2FOckdw+H6ej+rhNQkHqksxOtueT6HfXzNWpyOvgq2KRaibINN2uDXLixjMIU3/tKbCFAcfJoMeL/3Z9Fsz/9evvbj/2fNkbe8ZIbHjPbhN7XC9uauaK/3VRLaYyNjtWMuiFmw05ri0AQkxFWiYuRkV7C+UPP4sxppwusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042349; c=relaxed/simple;
	bh=fo3UAZkJZ3/PfXqbvb3VXXye+ALhRQzwN5PGPAAJKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF8zbA/KWpHba4u8BgVRKWCYyu6swymiR+jQOk+8+IeqJjao71exaAAeoDZC73uH6bVFsdP8J+LDlgZltI65wNOd+46htt29B/jJnKfWrkYN3RMxeSB8QyElQRo5mv+I9UVQQEDig5nKFtyiu6UKWORtwPMg258JKLUonN5hddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZS0SI18E; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZS0SI18E"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659KBcSf081711;
	Tue, 9 Jun 2026 21:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4CHTC
	enMD+iK/KZW5aa1+1ADVhPPZGrGy+szG1tIQWU=; b=ZS0SI18ENJfT8PRCOyqQ+
	6cFTkKq0RxvRzbq2vA4E/XGyjjShvhOTfuRm7sjZHP7RY6OsAQ9N6ltPTyJcaM2r
	Ngzq/E/Ny88+k/Our+qq994mkiZV13AtslFBv9qwRqX16cn2hrMG+Xdv+Rq0bESy
	ek6+g8CKszQACIh5+x5k1zkKz7dU4QsH5hyZO5oZ95iTfHY4fcuPz73jDivHqwJx
	xxqhL1dYsE63v8VAmnzErhI93DEhxIxVK3zOKoW4DpG3qeuvsjOZQSgOoTOd+sQm
	VxwE6544ea4Hx5h4cRYN8UyALMkplKEnxy2F4qW/XtljmvEYyhSsg4LYo15A3ZzT
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5swdhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 659LrltV028028;
	Tue, 9 Jun 2026 21:58:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0qqgkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:48 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659LrtLI029331;
	Tue, 9 Jun 2026 21:58:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ema0qqghu-2;
	Tue, 09 Jun 2026 21:58:47 +0000 (GMT)
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, chenste@linux.microsoft.com, sherry.yang@oracle.com,
        ebiederm@xmission.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com
Subject: [PATCH 6.12.y 1/2] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Tue,  9 Jun 2026 14:58:43 -0700
Message-ID: <20260609215844.1835378-2-sherry.yang@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNiBTYWx0ZWRfX1HoKWcoY09/Z
 E8HfS7POIiDDIQoVsrcZiUq/cAZKPid42pIWxe2+bK91nuiba9jFHGVu3nD/BVv3NSDLZ2Z6THf
 QIFLP0GnoFu/cPzDVGPOY1d03iSkro4YQ3fkrSseqSQXN6JG8fCZmNuldjL+cMGJlEoT9lhFtqA
 2/ZpIx+G6MGMQZkGP3EodVa65/qRHFx023mO7MB7FMKcSU8BA+YoheClUZpaJmYTlwSpI5UE0wR
 1JdR4GDMoAUHiiSBAymFVM8mao7u1dNjFhcRgIgtfTk7LG589HvHNNMkJea+g7dwU436l189S1q
 bZASbjKstDEm5g0cMVzwYI8GH7DoT83q0qJgNUruTjNxYyoXCF+DwQnUbbe9dx3al1yRrLUfC42
 uATaVBWWStRgOQ54h5JF1VyY4g7OvopWIjTPzwuz8mZHV3vP8VTqtQBxQE6mRlP1IvD+g2DHFjP
 t+CRET/4a89UlccLXNGqcwqDTkQtzXxgUvKzNOp8=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a288c98 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=y-ZpXBwYG-4gK4g_9IwA:9
 a=BpimnaHY1jUKGyF_4-AF:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: gpfXesHix2SOhKstln4GMGB9dpa41sTv
X-Proofpoint-GUID: gpfXesHix2SOhKstln4GMGB9dpa41sTv

From: Steven Chen <chenste@linux.microsoft.com>

[ Upstream commit 9ee8888a80fe2bd20ce929ffbc1dedd57607a778 ]

Currently, the function kexec_calculate_store_digests() calculates and
stores the digest of the segment during the kexec_file_load syscall,
where the  IMA segment is also allocated.

Later, the IMA segment will be updated with the measurement log at the
kexec execute stage when a kexec reboot is initiated. Therefore, the
digests should be updated for the IMA segment in the  normal case. The
problem is that the content of memory segments carried over to the new
kernel during the kexec systemcall can be changed at kexec 'execute'
stage, but the size and the location of the memory segments cannot be
changed at kexec 'execute' stage.

To address this, skip the calculation and storage of the digest for the
IMA segment in kexec_calculate_store_digests() so that it is not added
to the purgatory_sha_regions.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm
[zohar@linux.ibm.com: Fixed Signed-off-by tag to match author's email ]
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
(cherry picked from commit 9ee8888a80fe2bd20ce929ffbc1dedd57607a778)
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7d6b12f8b8d05..107e726f2ef3f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f852528bdc246..a20ceb4d27ccc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
+		return true;
+	else
+		return false;
+}
+#else
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	return false;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (check_ima_segment_index(image, i))
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 501b952b36981..4de9834c3e133 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -164,6 +164,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -174,6 +175,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
-- 
2.50.1

