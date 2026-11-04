Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770634;
	b=k6Ng1hEramHHwW/oN4Hz0KTECShKwApyi1haY2WICOQUP3KoaMt9BcHRGQSi4NmnQWDe
	 Cfmy4qlO1QR8c/5njVblW/YfPpbJaoUvIHyyqaeGYl10HlEAEZPoNgIGuVZUF0FS/tQl+
	 pAoD6DOdRC/mZa5rCqjoJejKbo2Dy1VgUS15DRMmakD51cj7AXL6ZrsH4C/H9dCsEbe4x
	 boznc9Ww2MrApfM+uRGQk2W2+Pknl6knAiZbrBdkQ07EYUtEf2YME50HFpLSLdxknTh7u
	 FDb+MmRph3dNFYlQu9NAwd+GXSkaoi5g5miIj8BuiURrF3PyyfURtkNHMUjsOGouSRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770634;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nDRNxsDnkcgSBTFbAhj7C2jtia/Fnvvda25FOYiDmms=;
	b=Prio/taKXELJ7FbRuVVDX67kDPWYELZgaigAQEpwurS5YXAQyOx51z+sLinK4SU+iqdz
	 Ei5KQOGOSIm0iWcBF1JIp+7FTgdR2QfkQlvb3mV2+Adk0XnNcy4ZgDU9l/ZXGtrZiMj2S
	 sHJUK1EvJOaqUkLbVdrBbmxYETFXG7UonJqReG6R7AIn83oJKzVm60j14co5Tjr+2nnxM
	 mBxzNDMon+qZ5W1QmX0x8ZlqaZha1i6j+Dj/Y2sVZ+yVMuao83me9eHYnvhYxPdA5Y9lg
	 wwYD/gc9ql17aJmZed2wM34t6EDGhfNwShRGGtUgPdbGaeZnmKglZ9RuNHHu+xVVrhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=VXCY1mMc;
	arc=none smtp.remote-ip=115.124.28.75
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0F606A31B;
	Wed,  4 Nov 2026 05:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D0F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=VXCY1mMc
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793770627; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nDRNxsDnkcgSBTFbAhj7C2jtia/Fnvvda25FOYiDmms=;
	b=VXCY1mMcCuJTwcHW1IdvuaG0dkO9A/sG4kDNsYTOsESwODTsmHCxM0zu7HH9HdQnp4+jxaOMNudrToz7W20YPvtaLDdLEcCSP0zUIC6zp4PyGt2xkROt4QnrKJRjS9CURM08GNWUAysUq/UzNH1oICLYBO/PTvCbsEORgd312AQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436352|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.142451-0.00490227-0.852647;FP=9066074887955760626|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jwHy6qj_1793770625;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jwHy6qj_1793770625 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 13:37:06 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	Weibin Liu <liuwb@xiaopeng.com>,
	stable@vger.kernel.org,
	Zhu Guanglei <zhugl3@xiaopeng.com>
Subject: [PATCH] ima: hold ima_extend_list_mutex while locating the trim position
Date: Wed,  4 Nov 2026 13:37:05 +0800
Message-ID: <20261104053705.3967228-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_queue_delete_partial() looks up the queue entry at which the
measurement list has to be cut without holding ima_extend_list_mutex,
and only takes the mutex afterwards for __list_cut_position().  The
comment above the cut justifies this with "ima_fs.c enforces
single-writer exclusion".

That exclusion does not cover the write() path.  ima_measure_lock()
registers measure_writer at open() time and even lets the same task
open the file again by incrementing measure_writer_extra_writes, while
_ima_measurements_write() never checks the caller's identity.  A
privileged task can therefore open several descriptors for the
measurement list and use them concurrently from its own threads.  Each
open() creates a separate struct file, so the f_pos_lock taken by
fdget_pos() does not serialize these writers (sharing a single
descriptor would be serialized there).

Two racing writers can then resolve the same, or an overlapping, trim
position, and the second one dereferences a queue entry that the first
one has already detached and handed to ima_queue_delete().  Depending
on the interleaving this corrupts the measurement list, reads freed
memory in __list_cut_position(), or frees the same entry twice.

Reproducer: generate some tens of thousands of measurement records,
open() the measurement list for writing several times from one task,
then write "20000\n" from that many threads using one descriptor each.
KASAN reports a stack-out-of-bounds access in ima_queue_delete(),
called from ima_queue_delete_partial().

Move the lookup into the same critical section as the cut, so that the
entry stays valid until it has been detached.  Holding
ima_extend_list_mutex also excludes ima_extend_list(), so the plain
list_for_each_entry() is sufficient and the RCU variant is no longer
needed.  Keep the existing error precedence (a short list returns
-ENOENT before the suspended check) and keep ima_queue_delete()
outside the mutex, since the trimmed list is already private.

Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements records")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Zhu Guanglei <zhugl3@xiaopeng.com>
Assisted-by: LLM
---
 security/integrity/ima/ima_queue.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 0f1b7e4113c4..cf8c164eea13 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -427,12 +427,16 @@ int ima_queue_delete_partial(unsigned long req_value)
 	struct ima_queue_entry *qe;
 	int ret = 0;
 
+	mutex_lock(&ima_extend_list_mutex);
+
 	/*
-	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
-	 * only list append can happen concurrently. No list replace due to the
-	 * staging/delete writers mutual exclusion.
+	 * The lookup and the cut have to be atomic with respect to other
+	 * writers: ima_fs.c serializes open(), but write() can run
+	 * concurrently on independently opened descriptors. Holding
+	 * ima_extend_list_mutex also excludes ima_extend_list(), so the
+	 * plain list traversal is sufficient.
 	 */
-	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
+	list_for_each_entry(qe, &ima_measurements, later) {
 		size_to_remove += get_binary_runtime_size(qe->entry);
 		num_to_remove++;
 
@@ -441,18 +445,16 @@ int ima_queue_delete_partial(unsigned long req_value)
 	}
 
 	/* Not enough records to delete. */
-	if (req_value_copy > 0)
+	if (req_value_copy > 0) {
+		mutex_unlock(&ima_extend_list_mutex);
 		return -ENOENT;
+	}
 
-	mutex_lock(&ima_extend_list_mutex);
 	if (ima_measurements_suspended) {
 		mutex_unlock(&ima_extend_list_mutex);
 		return -ESTALE;
 	}
 
-	/*
-	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
-	 */
 	__list_cut_position(&ima_measurements_trim, &ima_measurements,
 			    &qe->later);
 
-- 
2.50.1

