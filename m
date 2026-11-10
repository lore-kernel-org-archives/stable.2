Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295161;
	b=2LvJOOBErs02PckcOC8Y7TfNQwEZKsyDCZpnNTDKXL68Uf2BdHUFH4EZnTKnW7cS5xRf
	 T4MUFyB6XNCssBlqGHVxCOw6TrZuzTytE8rjmNUYYa538kQJoUO+ZSoejo4l3R6JCTz9z
	 f0EtbAlHUF71jLqnFA+boRHdi4rDRUHPvgVeApvkFQMv0PXVIDYzcQmNblRUus9GHtiB4
	 oKBE0bE48b67JaMxamCC3sQJVomBVan4/lChxuUa47EElUyFU5l5H/xtHHOT/624NTAWY
	 eoERIjIoe/P6TULn0sJfYH+EQ7gIb5C0F79RvKAGSw2AVcXpT5MQLzJi+f8re3D3anQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295161;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4xHyI6ef/tGBG/UvRRO2lHZmu71l6/1WUAn2BLWsbvc=;
	b=jl0XlwUxKgcKOJJfGJXdqtGt9tcWqulZH078QUEjgjjtMPAIwUF70BtDkfH21qyXaMIo
	 gdlYDMlcQzZ46uuN4qmx9yTeSR+CQy72ouuTRSSEdmD8S2rZ/SN57AvpC8BlRkfbsFDEJ
	 Dw34iunztEWThTbG7T238Qufjxz1kpQG2OJDkdqGdYfApFEp7r7HpOw3ZFp3sMs/S91Tz
	 otmvQ5pVU2L3ZQKDYYSsVZ0CbimZf/ZlRnmozzH771/HokjvuGhL2o/tXI/0Y/B6jaN5v
	 ZHqutAXbmL4rhIGolNXT66/PHTHpU4f8kLDMpGkep/yGuq/ppa2boUKY0MLCLhqSHzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FWc3Jeb1;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B7606A334;
	Tue, 10 Nov 2026 07:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A7B7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FWc3Jeb1
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794295151; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4xHyI6ef/tGBG/UvRRO2lHZmu71l6/1WUAn2BLWsbvc=;
	b=FWc3Jeb1etQeokTAFyZ+iQoaor4FUpJDDACWhxJmQQnFqnU229F2Ige8UyUNn4lm5z25ZuvE3GGoZVrGbP3FxBHP3tingO1F/sAuIAU/mOgmLxhBSauxGe6SA4a628QIsOtrBpEkzQP4USMRujUlnSC7ZfI6NTynSYethPF2JGA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0200634-0.00108156-0.978855;FP=2222871759440907514|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k-iRqWm_1794295149;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.k-iRqWm_1794295149 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 15:19:10 +0800
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
Subject: [PATCH v3] ima: fix races when deleting measurement list entries
Date: Tue, 10 Nov 2026 15:19:09 +0800
Message-ID: <20261110071909.2056650-1-liuwb@xiaopeng.com>
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

Without this patch, ima_queue_delete_partial() looks up the queue entry
at which the measurement list has to be cut without holding
ima_extend_list_mutex, and only takes the mutex afterwards for
__list_cut_position().  The comment above the cut justifies this with
"ima_fs.c enforces single-writer exclusion".

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

Keep the existing RCU lookup outside ima_extend_list_mutex.  The rwsem
serializes staging/delete writers, so only ima_extend_list() can race
with the lookup by appending an entry.  The selected entry stays valid
until the cut.  Take the extend mutex only for the suspended check, the
cut and the accounting updates.  Preserve the error precedence: a short
list returns -ENOENT before the suspended check.

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements records")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v3:
- Keep the RCU lookup outside ima_extend_list_mutex, as Roberto
  suggested.  The rwsem excludes staging/delete writers; only append can
  race with the lookup.
- Take the extend mutex only for the suspended check, the cut and the
  accounting updates.
- Rebase on current mainline and rebuild.  Current and staged KASAN and
  LOCKDEP QEMU tests passed.

Link: https://lore.kernel.org/all/20261109123335.432186-1-liuwb@xiaopeng.com/ [v2]

 security/integrity/ima/ima_fs.c    | 66 ++++++++++++++++++++++++------
 security/integrity/ima/ima_queue.c |  7 ++--
 2 files changed, 58 insertions(+), 15 deletions(-)

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
index 67782c004cdf..34a42f323fc8 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -429,8 +429,8 @@ int ima_queue_delete_partial(unsigned long req_value)
 
 	/*
 	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
-	 * only list append can happen concurrently. No list replace due to the
-	 * staging/delete writers mutual exclusion.
+	 * only list append can happen concurrently: staging/delete writers are
+	 * serialized by ima_measurements_rwsem.
 	 */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
 		size_to_remove += get_binary_runtime_size(qe->entry);
@@ -451,7 +451,8 @@ int ima_queue_delete_partial(unsigned long req_value)
 	}
 
 	/*
-	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
+	 * qe remains valid because staging/delete writers are serialized by
+	 * ima_measurements_rwsem.
 	 */
 	__list_cut_position(&ima_measurements_trim, &ima_measurements,
 			    &qe->later);
-- 
2.50.1

