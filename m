Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487984;
	b=KaNuwqr0iXxsdhefx+mJaXsOMXZdHf9qsH3IQVhI5L4sIIT0UL3vd+6DZMzgXeuka6Lt
	 VC2885knWiNrRvMzjkrQfymMhDyni1nGnVF4XRwsR4ciLjkf2j6BQ3rO6pAKvL4HnJ2YD
	 6sg71QMv1cJJIdfLCtT/E4u3p41KxNyd3tpv4ykALrJM+2DstyzpyLRhHhX8n1GoBtYTD
	 glBpq5GaIw93r2ev3laIo5UZfeL7JQerSrElyNhYzQQnXSXPU1rq9OFQ867CSE8r219JS
	 izCelbbrrUx2OnmvobMEj0g8t+G3zwOHZw3kQOoIo+hY0Et5uLdejJfmeO5wi/m2dIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487984;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=tF49+JupgZE9xGK8EKohysErvg0QsCmNr2anu3IocEM=;
	b=DhcOBCvSymKBranwNtpW44LOZg4jv5DrsWRXQj60X2Qe9UAAYrX8Z3sIadgxLvKuoyJz
	 8GC/vBI/1OZCkBPVEnaUvru32kab8rRtL2Fwv2QfIo67KaMabmoUBQqMMUog+lpLq0evd
	 eUNDwqYtlionxXIUia3ryilKRLH/ZadcDVeTcwMsebdeTEtLQtkK7JAcFXHesB7onDf/a
	 fvRpbIb8hkmWmni0pJ4Oi90V2CX7w/m3h+cVcP53Hl9S2r7PUSI4gb777f7W9pTilTIpF
	 tO47EdQo4mYhHc2yHi1VJjt8fw/dETh055B2/+b94EHmXNfT4kt3h8mDEwuILGdUN+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Sc0PhQT9;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A3606A333;
	Thu, 12 Nov 2026 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59A3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Sc0PhQT9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tF49+JupgZE9xGK8EKohysErvg0QsCmNr2anu3IocEM=; b=Sc0PhQT9Su7h7qxLJdtbnFU0Jq
	m7sPeEM20P9y8mnSG++XUGfE5cfs9sjhxGm0w5nBnWGCA5Bbh5guO6jTW8ymF2Xu6pd5nOpPPNQlm
	ZkKAlN2hLgh5E0eh+IQm2MzWO7NwRyBFhL2w0RtAt8DJ2nfPsTM7/vvWBogNLtV0OTRUyZEZmiQfV
	9Y1xsKqdqaQHGLHd9NAlF4WCC/icJQd4wzP/1OIc2k+av3JJTKXxM4NZs7KtHsyV0Rrq9JoIbgWDR
	7ytgv8rEJDbdHit6sOPt8J/ZPJ4P5jc3fe35MDUc0e6wRac3pjjUNw0drrSWNG0MFjf2tDk4BIzgT
	HI1TJyDg==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIa-00000003H1G-0duP;
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
Subject: [PATCH v2 2/3] ima: keep kexec dump state tied to installed image
Date: Thu, 12 Nov 2026 12:52:46 +0000
Message-ID: <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
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

ima_add_kexec_buffer() updates the global measurement scratch buffer
and segment size for the new image. If kexec_file_load() fails, the
new image is freed but the scratch buffer and segment size remain. When
kexec starts the installed image, ima_update_kexec_buffer() dumps the
measurement list into the IMA segment. A larger failed segment causes an
OOB write, while a smaller one truncates the log and reports the wrong
size in the kexec_execute event. KASAN for instsance reports the OOB
writes as:

  BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
  Write of size 868426 at addr ffffc9000004e000 by task init/1
  ...
  __asan_memcpy+0x3b/0x60
  ima_update_kexec_buffer+0x265/0x280

Leave installed scratch state unchanged until all later load steps pass.
Store new buffers in the candidate and reuse only equal-size installed
buffers. Emit kexec_load before those steps with the local size.
Allocation failure still omits the optional segment.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 security/integrity/ima/ima_kexec.c | 74 ++++++++++++++++--------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 0d845693a1f7..3aa8b1096f81 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -35,7 +35,8 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	sf->count = 0;
 }
 
-void ima_measure_kexec_event(const char *event_name)
+static void ima_measure_kexec_event_size(const char *event_name,
+					 size_t segment_size)
 {
 	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	size_t buf_size = 0;
@@ -48,35 +49,26 @@ void ima_measure_kexec_event(const char *event_name)
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
 		      "ima_runtime_measurements_count=%ld;",
-		      kexec_segment_size, buf_size, len);
+		      segment_size, buf_size, len);
 
 	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
 }
 
-static int ima_alloc_kexec_file_buf(size_t segment_size)
+void ima_measure_kexec_event(const char *event_name)
 {
-	/*
-	 * kexec 'load' may be called multiple times.
-	 * Free and realloc the buffer only if the segment_size is
-	 * changed from the previous kexec 'load' call.
-	 */
-	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
-		goto out;
+	ima_measure_kexec_event_size(event_name, kexec_segment_size);
+}
 
-	ima_free_kexec_file_buf(&ima_kexec_file);
+static int ima_alloc_kexec_file_buf(struct kimage *image, size_t segment_size)
+{
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		return 0;
 
 	/* segment size can't change between kexec load and execute */
-	ima_kexec_file.buf = vmalloc(segment_size);
-	if (!ima_kexec_file.buf)
+	image->ima_buffer = vmalloc(segment_size);
+	if (!image->ima_buffer)
 		return -ENOMEM;
 
-	ima_kexec_file.size = segment_size;
-
-out:
-	ima_kexec_file.read_pos = 0;
-	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
-	ima_measure_kexec_event("kexec_load");
-
 	return 0;
 }
 
@@ -160,10 +152,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .top_down = true };
 	unsigned long binary_runtime_size;
 	unsigned long extra_memory;
+	size_t segment_size;
 
-	/* use more understandable variable names than defined in kbuf */
-	size_t kexec_buffer_size = 0;
-	void *kexec_buffer = NULL;
 	int ret;
 
 	if (image->type == KEXEC_TYPE_CRASH)
@@ -182,36 +172,36 @@ void ima_add_kexec_buffer(struct kimage *image)
 			      extra_memory;
 
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
-		kexec_segment_size = ULONG_MAX;
+		segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+		segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
 
-	if ((kexec_segment_size == ULONG_MAX) ||
-	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+	if (segment_size == ULONG_MAX ||
+	    (segment_size >> PAGE_SHIFT) > totalram_pages() / 2) {
 		pr_err("Binary measurement list too large.\n");
 		return;
 	}
 
-	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	ret = ima_alloc_kexec_file_buf(image, segment_size);
 	if (ret < 0) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
 		return;
 	}
 
-	kbuf.buffer = kexec_buffer;
-	kbuf.bufsz = kexec_buffer_size;
-	kbuf.memsz = kexec_segment_size;
+	ima_measure_kexec_event_size("kexec_load", segment_size);
+
+	kbuf.memsz = segment_size;
 	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
-		vfree(kexec_buffer);
+		vfree(image->ima_buffer);
+		image->ima_buffer = NULL;
 		return;
 	}
 
 	image->ima_buffer_addr = kbuf.mem;
-	image->ima_buffer_size = kexec_segment_size;
-	image->ima_buffer = kexec_buffer;
+	image->ima_buffer_size = segment_size;
 	image->ima_segment_index = image->nr_segments - 1;
 	image->is_ima_segment_index_set = true;
 
@@ -269,8 +259,22 @@ void ima_kexec_post_load(struct kimage *image)
 		ima_kexec_buffer = NULL;
 	}
 
-	if (!image->ima_buffer_addr)
+	if (!image->ima_buffer_addr) {
+		kexec_segment_size = 0;
+		ima_free_kexec_file_buf(&ima_kexec_file);
 		return;
+	}
+
+	if (image->ima_buffer) {
+		ima_free_kexec_file_buf(&ima_kexec_file);
+		ima_kexec_file.buf = image->ima_buffer;
+		image->ima_buffer = NULL;
+	}
+
+	kexec_segment_size = image->ima_buffer_size;
+	ima_kexec_file.size = image->ima_buffer_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
 	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
 	if (!ima_kexec_buffer) {
