Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227624;
	b=R4Pd3xGfIzrU/iK9Rlad7AaI9nsoFNGfO0MVZJ+8zp9AVZa5VIKIOu2NxAfUPIZNfsHt
	 oTMT6lCLTxnfmrNU1TN6h9eFacwB85AAv2zzM81/bxwV8qsKmUq5nlHoQ4SEVLvIqcl0/
	 eDcjgr2r/WT21dlgLf2syYQ1XEc+HzIn2/aKHzuFFw6XZdZKoTLm/ZAMUxI/7dEPx4IeO
	 51GF6K+/ygOjst1UdpZc9sglSiDu5LLVgH8JZJhSbwOlo2ulCPNvX/Gi2+sxehcnqy9Fs
	 Ng0edEKzwpspL+q0FtzL747F/6TMg/YGs5BXNGZTHV5thsAuoR25F9ci0pR/201OHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227624;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rBSc8CVDCtdGkoWEzKeAD/S40HXXSsxBxvTz0eBhay4=;
	b=Kz2DB8uq+cdGniE8PtG11RT4URCq+mBSsmG28KucJWgCTTLMTpj1slU0wMg1G7xxMZIX
	 c8cTEqvJrFb0+9zWT2LYjM/AucapLb/32Bi2Egvlxk3FQtZH3pkSAwUzZPmnXXarfpJoQ
	 Qg5q7XRuDSJ2zTdmuXoKJY8cy7LMPvXRtjXRQFmMkfzKcyXOiXuONk7ls15CmIvI+mmBg
	 qc+56d4TTveGr/gr7/n/d9g5nvvSuEq/0R7u0Gz/Km4I6akS5iNNdM/c5A4Zu+hX+rlGI
	 vQl3NYcukN5RFOtSPeFm0SuD9fUCq5XbWIgPZPxYJsQUqP/9SegdrwxFmTVW+p0GZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=L4qTnTxj;
	arc=none smtp.remote-ip=115.124.28.172
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60C606D802;
	Mon,  9 Nov 2026 12:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D60C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=L4qTnTxj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794227618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rBSc8CVDCtdGkoWEzKeAD/S40HXXSsxBxvTz0eBhay4=;
	b=L4qTnTxj3UT0x14IdkjXfVRES6Z8Iswt4doLOGng8O9e5yzNN2aT/gkLgxgX3kPH6jg3bSwGp0kUkxPM6Ao+4vl5wkkGUY5oo5t3S5ZA8sP6DeRZBAFNmhgFzXJGMHw8uo+x9UuOX327n+7bBkKyVpG5YtIhHsJ+w8yu2W2lZbk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.156171-0.00631644-0.837512;FP=2294930457285428474|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k-Dhy3o_1794227615;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.k-Dhy3o_1794227615 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:33:37 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Weibin Liu <liuwb@xiaopeng.com>,
	stable@vger.kernel.org,
	Zhu Guanglei <zhugl3@xiaopeng.com>
Subject: [PATCH v2] ima: fix races when deleting measurement list entries
Date: Mon,  9 Nov 2026 20:33:35 +0800
Message-ID: <20261109123335.432186-1-liuwb@xiaopeng.com>
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

That exclusion only covers cross-process opens.  ima_measure_lock()
registers measure_writer at open() time and even lets the same task
open the file again by incrementing measure_writer_extra_writes, while
_ima_measurements_write() never checks the caller's identity.  A
privileged task can therefore open several descriptors for the
measurement list and use them concurrently from its own threads.  Each
open() creates a separate struct file, so the f_pos_lock taken by
fdget_pos() serializes neither these writers nor their readers.

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

The extend mutex alone cannot protect readers: the binary and ASCII
file operations call seq_read()/seq_lseek(), which traverse the list
without taking ima_extend_list_mutex.  An independent O_RDWR descriptor
lets a reader race with deletion from the same task.  Adding a
concurrent reader to the writer reproducer triggers a general
protection fault in ima_measurements_show(), reached from seq_read().

Introduce ima_measurements_rwsem at the file-operation layer.  Writers
take it for write around _ima_measurements_write(); readers take it for
read around seq_read() and seq_lseek().  Cover the binary/ASCII and
current/staged file operations, since they all expose the same list
traversal and deletion commands.  The resulting lock order is rwsem
followed by seq_file's lock on the read side, or ima_extend_list_mutex
on the write side.  Freeing the private trimmed list remains outside
the extend mutex but inside the rwsem write-side critical section.
The existing open-time exclusion remains unchanged, so one task cannot
delete a staged list belonging to another.

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements records")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v2:
- Add rwsem protection for read and lseek, as suggested by Roberto.
- Cover all current/staged binary/ASCII file operations.
- Keep the open-time exclusion unchanged.
- Clarify the lockless kexec dump protection in ima_measurements_show().

Link: https://lore.kernel.org/all/20261104053705.3967228-1-liuwb@xiaopeng.com/ [v1]

 security/integrity/ima/ima_fs.c    | 66 ++++++++++++++++++++++++------
 security/integrity/ima/ima_queue.c | 20 +++++----
 2 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3b8174a91a34..9da881308d52 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -39,6 +39,8 @@ static DEFINE_MUTEX(ima_measure_mutex);
 static long ima_measure_users;
 static struct task_struct *measure_writer;
 static long measure_writer_extra_writes;
+/* Lock order: ima_measurements_rwsem -> ima_extend_list_mutex. */
+static DECLARE_RWSEM(ima_measurements_rwsem);
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -161,7 +163,11 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
  */
 int ima_measurements_show(struct seq_file *m, void *v)
 {
-	/* the list never shrinks, so we don't need a lock here */
+	/*
+	 * seq_file callers hold ima_measurements_rwsem.  The kexec dump caller
+	 * relies on reboot notifier ordering: measurements are suspended and
+	 * staging/deletion are forbidden while it walks the lists locklessly.
+	 */
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
@@ -400,32 +406,68 @@ static ssize_t _ima_measurements_write(struct file *file,
 	return datalen;
 }
 
+static ssize_t ima_measurements_read(struct file *file, char __user *buf,
+				     size_t datalen, loff_t *ppos)
+{
+	ssize_t ret;
+
+	down_read(&ima_measurements_rwsem);
+	ret = seq_read(file, buf, datalen, ppos);
+	up_read(&ima_measurements_rwsem);
+
+	return ret;
+}
+
+static loff_t ima_measurements_llseek(struct file *file, loff_t offset,
+				      int whence)
+{
+	loff_t ret;
+
+	down_read(&ima_measurements_rwsem);
+	ret = seq_lseek(file, offset, whence);
+	up_read(&ima_measurements_rwsem);
+
+	return ret;
+}
+
 static ssize_t ima_measurements_write(struct file *file, const char __user *buf,
 				      size_t datalen, loff_t *ppos)
 {
-	return _ima_measurements_write(file, buf, datalen, ppos, false);
+	ssize_t ret;
+
+	down_write(&ima_measurements_rwsem);
+	ret = _ima_measurements_write(file, buf, datalen, ppos, false);
+	up_write(&ima_measurements_rwsem);
+
+	return ret;
 }
 
 static ssize_t ima_measurements_staged_write(struct file *file,
 					     const char __user *buf,
 					     size_t datalen, loff_t *ppos)
 {
-	return _ima_measurements_write(file, buf, datalen, ppos, true);
+	ssize_t ret;
+
+	down_write(&ima_measurements_rwsem);
+	ret = _ima_measurements_write(file, buf, datalen, ppos, true);
+	up_write(&ima_measurements_rwsem);
+
+	return ret;
 }
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
-	.read = seq_read,
+	.read = ima_measurements_read,
 	.write = ima_measurements_write,
-	.llseek = seq_lseek,
+	.llseek = ima_measurements_llseek,
 	.release = ima_measurements_release,
 };
 
 static const struct file_operations ima_measurements_staged_ops = {
 	.open = ima_measurements_staged_open,
-	.read = seq_read,
+	.read = ima_measurements_read,
 	.write = ima_measurements_staged_write,
-	.llseek = seq_lseek,
+	.llseek = ima_measurements_llseek,
 	.release = ima_measurements_release,
 };
 
@@ -440,7 +482,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
 /* print in ascii */
 static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 {
-	/* the list never shrinks, so we don't need a lock here */
+	/* The caller holds ima_measurements_rwsem. */
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
@@ -497,9 +539,9 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
-	.read = seq_read,
+	.read = ima_measurements_read,
 	.write = ima_measurements_write,
-	.llseek = seq_lseek,
+	.llseek = ima_measurements_llseek,
 	.release = ima_measurements_release,
 };
 
@@ -519,9 +561,9 @@ static int ima_ascii_measurements_staged_open(struct inode *inode,
 
 static const struct file_operations ima_ascii_measurements_staged_ops = {
 	.open = ima_ascii_measurements_staged_open,
-	.read = seq_read,
+	.read = ima_measurements_read,
 	.write = ima_measurements_staged_write,
-	.llseek = seq_lseek,
+	.llseek = ima_measurements_llseek,
 	.release = ima_measurements_release,
 };
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 67782c004cdf..8c69684abd25 100644
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

