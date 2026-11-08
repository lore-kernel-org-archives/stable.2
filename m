Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164749;
	b=IRwurULyhm+wTumn40tQ8aZhW7htVNwsJCWHZiiQ8SZD2o8oreVMGIPvOFCSfCokjsrd
	 WexL9fVyOf3U4N4uZpmJqSl/wf9na9IvSd/iu8hNC8HrXCwXwXQfcWv6n+goby+NjGSbS
	 ZmI7Dae7au3r6ijnVnmiWHZKYXEWpmRPQ0L/GZegC22pIQhJKrJbwnGzjP9BN40XFsguw
	 29u2qU2bsIPG/SsuppzHtfMINnoj7t1X1KlUn+4sPItv3x8TsIEYwHyvsj57GTNeJ7itt
	 eIfsxUf/eUldAY2m0qpB+Rn3Wx0Lodt08hlXCaD9ZZ1kGKH6lAZ74ZF/NXcp32+a0Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164749;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=rLyxJwr2Q1zmyzbvbW4Jg4mYpaRFZWR35m+j3Gs4cMU=;
	b=v5MVoTZEb+FNmsW3+mcPNHWosCAG36gbi3T/XyV2QrhOSMaZ1ZOFxtgk7l6o5uEVYxj6
	 4HUgJMZQTrR+ak9e2t+ysnd4WIV7HPKSvsEJfJZ5TEPtjfVzw3pCvBWsPndRamfT4eBvQ
	 /wo9PqlY+7h4lPPQnDokEuxUWN8LW4IYmW1Vu7Krjo98TXN6aExyV9ZjmjNkk+yYJhByn
	 xISvQPLPUg5QWLZ4Brn4SgjlUtsW1lsO82lV6j9Y7LXFOKsaj4XFkooVvJWOncTuMUE9K
	 Wk6HNRC8fWw0ZuQhuaMf6ilHclbrxgqxfxm1tlYW2S7F7ykJDd1pRMev/XEteWIhtkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=a5SwbWrC;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB7606A320;
	Sun,  8 Nov 2026 19:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60FB7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=a5SwbWrC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rLyxJwr2Q1zmyzbvbW4Jg4mYpaRFZWR35m+j3Gs4cMU=; b=a5SwbWrCywIz3dU7Pd5cFDAovJ
	tw1hgr/BiXpgfHmDacdZlRj1+jIEe9f9QDF5XE1GMEQyMAy3ENDUBtM6fwSiIimMTgBcOZzOWKtUX
	m+9rAKuXEtL7N7bl+bZT7OBAKuOGgyVSsVSNq5O8uufgFwtt40p3BXSI38F7m3t6/HDLkBBBWycqw
	xhkvHRBjX9rdMgpVQnRmwtiCIXqqH/rpSGY7ixvOEyjv3dtgsbx6Wb5iLvRdNGIAgKcaPyLFzxMZn
	WUGPxze9Lu+1LYeboGWEw3DI44JTkjYHZnxvSmCCT1HwEv8+VjhioWMfqdXE/Gumlka30XCl4wRVK
	oZ5TfiAg==;
Received: from [151.115.150.205] (port=41786 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xQ8D4-0000000GibV-17vF;
	Sun, 08 Nov 2026 20:05:46 +0100
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
Subject: [PATCH] ima: fix kexec measurement buffer overflow after failed loads
Date: Sun,  8 Nov 2026 19:04:04 +0000
Message-ID: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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

When kexec_file_load() fails to install a new image, it can leave the
global IMA scratch buffer larger than the IMA segment of the current
image. When that image is executed, ima_update_kexec_buffer() copies
the larger log past the end of its reserved segment. In a test, KASAN
reports it as:

  BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
  Write of size 868426 at addr ffffc9000004e000 by task init/1
  ...
  Call Trace:
   ...
   __asan_memcpy+0x3b/0x60
   ima_update_kexec_buffer+0x265/0x280
   ...
   blocking_notifier_call_chain+0x88/0xb0
   kernel_restart_prepare+0x18/0x40
   kernel_kexec+0xe4/0x130

Limit the dump to the smaller value between the scratch size and the
installed image segment size. Update the IMA mapping only after
machine_kexec_post_load() succeeds.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/kexec_file.c                | 6 ++++--
 security/integrity/ima/ima_kexec.c | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68eed..0b3245389b758 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,11 +206,13 @@ kimage_validate_signature(struct kimage *image)
 
 static int kexec_post_load(struct kimage *image, unsigned long flags)
 {
+	int ret = machine_kexec_post_load(image);
+
 #ifdef CONFIG_IMA_KEXEC
-	if (!(flags & KEXEC_FILE_ON_CRASH))
+	if (!ret && !(flags & KEXEC_FILE_ON_CRASH))
 		ima_kexec_post_load(image);
 #endif
-	return machine_kexec_post_load(image);
+	return ret;
 }
 
 /*
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 0d845693a1f78..f7be8d85bb9a7 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -65,7 +65,6 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
-	/* segment size can't change between kexec load and execute */
 	ima_kexec_file.buf = vmalloc(segment_size);
 	if (!ima_kexec_file.buf)
 		return -ENOMEM;
@@ -98,12 +97,14 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
 	if (!ima_kexec_file.buf) {
 		pr_err("Kexec file buf not allocated\n");
 		return -EINVAL;
 	}
 
+	/* A failed replacement load may have resized the scratch buffer. */
+	ima_kexec_file.size = min_t(size_t, ima_kexec_file.size, segment_size);
+
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/*
@@ -239,7 +240,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
-	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_image->ima_buffer_size);
 
 	if (ret)
 		pr_err("Dump measurements failed. Error:%d\n", ret);
-- 
2.47.3

