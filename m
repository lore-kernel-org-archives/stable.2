Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581784;
	b=iM4yjRUyqsLyspi1APHCG6AQFklyOHayPNHECuoLydQEzl1jljL8keWL+VxqfwHbdy1a
	 vrD6KuN5iGNNhdCdPOJEEzn/gbcLvTjOgRlGp8wkNAZA4cLEp7z5B+dK/zUxtHatKN2wJ
	 Qa/ZvgriLfLWdmHAddvJU86eWIsqbCv1gOars4LMeC3MzyIS8KAGdR5wa2CkS3lBuH1Ak
	 2QYE6UzhVWiJtNfYobsKiYrgQTJe3Apn82O/7gN5eMcf+jPcYlLkCJFnbpAP/Uk7qVNgt
	 LC6+v1zgcoDaJofcEthg5oYvCjM9BUsRKH/A52uqIJM9XZdKKHGefJrHaKheYvN6vqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581784;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OH0aiSevvVCIDttAoP6h2DzxTrt17u0Nto4UmtIjPDg=;
	b=zZeaSJO4efehwekLOBgj06xpCSEpLbMqSP7464vMVtGnUjwd6ba/D93gMWEuGFPsejK+
	 y4xaq2Uz8hiJKHxz0RXhPVU2rekEo1zRv31nrRXEMQZo0USY/X/RhU85futvxNCy+gn9i
	 dAcJi9nIKuzL89/U10wlfKSguTAA3e2HDlmesU6Z6c71Pn/xpmCr507i9/jkWRgVQVU17
	 VBEmDdpQ/NWG9A6L6xoFWGV3BkfDY1xofHZrUQBe2I/AYP+uIl2HavnwuPVSXg58CnIRE
	 Yt4t6dTdww2GZerlVawwZwnOb2fpgHWh6Dx4FDaetVWrmCUyltU0rpF/cvZoAWNaUTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rT3fCwEf;
	arc=none smtp.remote-ip=115.124.28.148
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BED606A331;
	Fri, 13 Nov 2026 14:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rT3fCwEf
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794581772; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OH0aiSevvVCIDttAoP6h2DzxTrt17u0Nto4UmtIjPDg=;
	b=rT3fCwEfIwTO95qQ9RJA0dL9C40y3Wg/PkcWrGnJIKTfRp4r8pWLjwnR8o6xYhQK1KQDH/4e2cUkw9pqORPpg8Nt/zVFGPFydnozyYkbfJGGc9DeDj5mCzIKWZe20WtW0DVoXeNn+B4aLtFb/w2Sxi/HPErGHlak6ggnCXdwwBI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0194488-0.0010187-0.979532;FP=1727475787545513210|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k1SQwDR_1794581770;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.k1SQwDR_1794581770 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 22:56:11 +0800
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
	Zhu Guanglei <zhugl3@xiaopeng.com>,
	Lin Qiaojie <linqj@xiaopeng.com>
Subject: [PATCH v4] ima: fix races when deleting measurement list records
Date: Fri, 13 Nov 2026 22:56:10 +0800
Message-ID: <20261113145610.1826692-1-liuwb@xiaopeng.com>
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

That exclusion only covers cross-process opens and is only enforced at
open() and release() time.  ima_measure_lock() registers measure_writer
at open() time and even lets the same task open the file again by
incrementing measure_writer_extra_writes, while
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
without taking ima_extend_list_mutex.  Readers from other processes
are already excluded at open time, but an independent O_RDWR descriptor
lets a reader thread of the writer process race with deletion from
another thread.  Adding a concurrent reader to the writer reproducer
triggers a general protection fault in ima_measurements_show(), reached
from seq_read().

Introduce ima_measure_rwsem at the file-operation layer.  Writers use
down_write_killable() around _ima_measurements_write(); readers use
down_read_killable() around seq_read() and seq_lseek().  If a fatal
signal interrupts lock acquisition, return -EINTR without entering the
protected operation.  Cover the binary/ASCII and current/staged file
operations, since they all expose the same list traversal and deletion
commands.  The resulting lock order is rwsem followed by seq_file's
lock on the read side, or ima_extend_list_mutex on the write side.
Freeing the private trimmed list remains outside the extend mutex but
inside the rwsem write-side critical section.  The existing open-time
exclusion remains unchanged, so one task cannot delete a staged list
belonging to another.

Keep the existing list_for_each_entry_rcu() traversal outside
ima_extend_list_mutex.  The rwsem serializes staging/delete writers, so
only ima_add_template_entry() can race with the traversal by appending
an entry.  The selected entry stays valid until the cut.  Take the
extend mutex only for the suspended check, the cut and the accounting
updates.  Preserve the error precedence: a short list returns -ENOENT
before the suspended check.

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: e9b491e27bf6 ("ima: Add support for staging measurements with prompt")
Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements records")
Cc: stable@vger.kernel.org # v7.2+
Reviewed-by: Lin Qiaojie <linqj@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v4:
- Rename ima_measurements_rwsem to ima_measure_rwsem.
- Use killable rwsem acquisition in all four read/lseek/write wrappers,
  returning -EINTR if a fatal signal interrupts the wait.
- Clarify the open()/release() exclusion, reader threads and RCU list
  traversal in the commit message; fix the append function name.
- Add a Fixes tag for the staging-with-prompt change.
- Rebuild and rerun the current and staged KASAN+LOCKDEP QEMU tests.
  Add a deterministic userfaultfd/SIGKILL test covering all four
  interrupted lock-acquisition paths.

Link: https://lore.kernel.org/all/20261110071909.2056650-1-liuwb@xiaopeng.com/ [v3]

 security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++++------
 security/integrity/ima/ima_queue.c |  7 ++--
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3b8174a91a34..5c2919e35332 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -39,6 +39,8 @@ static DEFINE_MUTEX(ima_measure_mutex);
 static long ima_measure_users;
 static struct task_struct *measure_writer;
 static long measure_writer_extra_writes;
+/* Lock order: ima_measure_rwsem -> ima_extend_list_mutex. */
+static DECLARE_RWSEM(ima_measure_rwsem);
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -161,7 +163,11 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
  */
 int ima_measurements_show(struct seq_file *m, void *v)
 {
-	/* the list never shrinks, so we don't need a lock here */
+	/*
+	 * seq_file callers hold ima_measure_rwsem.  The kexec dump caller
+	 * relies on reboot notifier ordering: measurements are suspended and
+	 * staging/deletion are forbidden while it walks the lists locklessly.
+	 */
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
@@ -400,32 +406,80 @@ static ssize_t _ima_measurements_write(struct file *file,
 	return datalen;
 }
 
+static ssize_t ima_measurements_read(struct file *file, char __user *buf,
+				     size_t datalen, loff_t *ppos)
+{
+	ssize_t ret;
+
+	ret = down_read_killable(&ima_measure_rwsem);
+	if (ret)
+		return ret;
+
+	ret = seq_read(file, buf, datalen, ppos);
+	up_read(&ima_measure_rwsem);
+
+	return ret;
+}
+
+static loff_t ima_measurements_llseek(struct file *file, loff_t offset,
+				      int whence)
+{
+	loff_t ret;
+
+	ret = down_read_killable(&ima_measure_rwsem);
+	if (ret)
+		return ret;
+
+	ret = seq_lseek(file, offset, whence);
+	up_read(&ima_measure_rwsem);
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
+	ret = down_write_killable(&ima_measure_rwsem);
+	if (ret)
+		return ret;
+
+	ret = _ima_measurements_write(file, buf, datalen, ppos, false);
+	up_write(&ima_measure_rwsem);
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
+	ret = down_write_killable(&ima_measure_rwsem);
+	if (ret)
+		return ret;
+
+	ret = _ima_measurements_write(file, buf, datalen, ppos, true);
+	up_write(&ima_measure_rwsem);
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
 
@@ -440,7 +494,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
 /* print in ascii */
 static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 {
-	/* the list never shrinks, so we don't need a lock here */
+	/* The caller holds ima_measure_rwsem. */
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
@@ -497,9 +551,9 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
-	.read = seq_read,
+	.read = ima_measurements_read,
 	.write = ima_measurements_write,
-	.llseek = seq_lseek,
+	.llseek = ima_measurements_llseek,
 	.release = ima_measurements_release,
 };
 
@@ -519,9 +573,9 @@ static int ima_ascii_measurements_staged_open(struct inode *inode,
 
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
index 67782c004cdf..b35aa0c42f8a 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -429,8 +429,8 @@ int ima_queue_delete_partial(unsigned long req_value)
 
 	/*
 	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
-	 * only list append can happen concurrently. No list replace due to the
-	 * staging/delete writers mutual exclusion.
+	 * only list append can happen concurrently: staging/delete writers are
+	 * serialized by ima_measure_rwsem.
 	 */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
 		size_to_remove += get_binary_runtime_size(qe->entry);
@@ -451,7 +451,8 @@ int ima_queue_delete_partial(unsigned long req_value)
 	}
 
 	/*
-	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
+	 * qe remains valid because staging/delete writers are serialized by
+	 * ima_measure_rwsem.
 	 */
 	__list_cut_position(&ima_measurements_trim, &ima_measurements,
 			    &qe->later);
-- 
2.50.1

