Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228610;
	b=k9TFeF4T3C9OC/6DUDNYd2cL4woDzLNSI2VDK9FiJktHXMviizSoJL9HMNQh6aUKrl0r
	 ch1V4KoWWXTVAYrRH+ZHHeeTe/KFi4G9+J+Rz8LaJUaOKSjQMuI9BDJnMErpKuEfDdt+h
	 1WVHVoYW5tXssLRVJWtW5O0AQewhbVMg5rQgcXGQuD5dYGDn6E3oGm9M4mWsFXPUXW3eY
	 Nrslg1DrSsh8bmZlvOxLDN9j/+YSF8ffRBNZHq6trq/fZL7w3Z8x7AunudW2JIQmkt5LS
	 oHMSi3+hkz2XiiZpNI1G5NmqP2tLuocHVmWu3aP6TOsUlp/7i+ai3x/Nxg7wdAXzrtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228610;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ruNB7+aZem2nemlQRXcbNJzHv2mj+4H0kv7LrhCTM/0=;
	b=jcskSHgyF+OF2fm2TOcnssD07LtIF07G5PpaqqPvS+jBBx4goel6RoWwMqlzNDFLlzlf
	 zsrS1jXSENeuQT/H6DEK4uXdhHUSgX89RAVYI0RoJiqi/mfZ/G9HCNLgvftXIEpBEyN+N
	 IPfMka1387dQ6EKbUaL+aYoIOUV+aewOzPAwCh+cfiofUfnVhIMLvnmz51QZDpJ2dvhG9
	 Y4td9PJxiSAFigYCUbdN3eKk9Mm7KpWRqLUg1+F7gY4uzpjMIbuGDli5XhCzWjaCrH9f8
	 frfcvbH6yZhcW9KGciB8Pnn6fo/sd8ShdycDgcUkmThyW7rfBTOemO/HNrhKbvMbFGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.23
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF997606D82A;
	Mon,  9 Nov 2026 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF997606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jNV3c5rksz1HCKM;
	Mon,  9 Nov 2026 20:49:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.218])
	by mail.maildlp.com (Postfix) with ESMTP id 62B2140558;
	Mon,  9 Nov 2026 20:49:57 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app2 (Coremail) with UTF8SMTPA id 2hC2B0CGkU9qwfFqwoQQAA--.6369S2;
	Mon, 09 Nov 2026 13:49:56 +0100 (CET)
Message-ID: <95b47e1a0a30022ede9f52ce0e80b0f957097b5b.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima: fix races when deleting measurement list entries
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Weibin Liu <liuwb@xiaopeng.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Steven Chen
 <chenste@linux.microsoft.com>,  stable@vger.kernel.org, Zhu Guanglei
 <zhugl3@xiaopeng.com>
Date: Mon, 09 Nov 2026 13:49:43 +0100
In-Reply-To: <20261109123335.432186-1-liuwb@xiaopeng.com>
References: <20261109123335.432186-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:2hC2B0CGkU9qwfFqwoQQAA--.6369S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kr1UWFWfCryUCw4xJryUtrb_yoWDCw15pa
	9a9a4xCr1kJ3yfXr1xG3Z8Zr4ru395Ka1DWr47G3s7AF15JrnF9FW3Ar12krs5KrW8Jr18
	ta1YqrZ8uan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASDWrxOrle-AAFsi

On Mon, 2026-11-09 at 20:33 +0800, Weibin Liu wrote:
> ima_queue_delete_partial() looks up the queue entry at which the
> measurement list has to be cut without holding ima_extend_list_mutex,
> and only takes the mutex afterwards for __list_cut_position().  The
> comment above the cut justifies this with "ima_fs.c enforces
> single-writer exclusion".
>=20
> That exclusion only covers cross-process opens.  ima_measure_lock()
> registers measure_writer at open() time and even lets the same task
> open the file again by incrementing measure_writer_extra_writes, while
> _ima_measurements_write() never checks the caller's identity.  A
> privileged task can therefore open several descriptors for the
> measurement list and use them concurrently from its own threads.  Each
> open() creates a separate struct file, so the f_pos_lock taken by
> fdget_pos() serializes neither these writers nor their readers.
>=20
> Two racing writers can then resolve the same, or an overlapping, trim
> position, and the second one dereferences a queue entry that the first
> one has already detached and handed to ima_queue_delete().  Depending
> on the interleaving this corrupts the measurement list, reads freed
> memory in __list_cut_position(), or frees the same entry twice.

Is it still true with the new semaphore?

Thanks

Roberto

> Reproducer: generate some tens of thousands of measurement records,
> open() the measurement list for writing several times from one task,
> then write "20000\n" from that many threads using one descriptor each.
> KASAN reports a stack-out-of-bounds access in ima_queue_delete(),
> called from ima_queue_delete_partial().
>=20
> Move the lookup into the same critical section as the cut, so that the
> entry stays valid until it has been detached.  Holding
> ima_extend_list_mutex also excludes ima_extend_list(), so the plain
> list_for_each_entry() is sufficient and the RCU variant is no longer
> needed.  Keep the existing error precedence (a short list returns
> -ENOENT before the suspended check) and keep ima_queue_delete()
> outside the mutex, since the trimmed list is already private.
>=20
> The extend mutex alone cannot protect readers: the binary and ASCII
> file operations call seq_read()/seq_lseek(), which traverse the list
> without taking ima_extend_list_mutex.  An independent O_RDWR descriptor
> lets a reader race with deletion from the same task.  Adding a
> concurrent reader to the writer reproducer triggers a general
> protection fault in ima_measurements_show(), reached from seq_read().
>=20
> Introduce ima_measurements_rwsem at the file-operation layer.  Writers
> take it for write around _ima_measurements_write(); readers take it for
> read around seq_read() and seq_lseek().  Cover the binary/ASCII and
> current/staged file operations, since they all expose the same list
> traversal and deletion commands.  The resulting lock order is rwsem
> followed by seq_file's lock on the read side, or ima_extend_list_mutex
> on the write side.  Freeing the private trimmed list remains outside
> the extend mutex but inside the rwsem write-side critical section.
> The existing open-time exclusion remains unchanged, so one task cannot
> delete a staged list belonging to another.
>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements re=
cords")
> Cc: stable@vger.kernel.org # v7.2+
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> ---
> Changes in v2:
> - Add rwsem protection for read and lseek, as suggested by Roberto.
> - Cover all current/staged binary/ASCII file operations.
> - Keep the open-time exclusion unchanged.
> - Clarify the lockless kexec dump protection in ima_measurements_show().
>=20
> Link: https://lore.kernel.org/all/20261104053705.3967228-1-liuwb@xiaopeng=
.com/ [v1]
>=20
>  security/integrity/ima/ima_fs.c    | 66 ++++++++++++++++++++++++------
>  security/integrity/ima/ima_queue.c | 20 +++++----
>  2 files changed, 65 insertions(+), 21 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 3b8174a91a34..9da881308d52 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -39,6 +39,8 @@ static DEFINE_MUTEX(ima_measure_mutex);
>  static long ima_measure_users;
>  static struct task_struct *measure_writer;
>  static long measure_writer_extra_writes;
> +/* Lock order: ima_measurements_rwsem -> ima_extend_list_mutex. */
> +static DECLARE_RWSEM(ima_measurements_rwsem);
> =20
>  bool ima_canonical_fmt;
>  static int __init default_canonical_fmt_setup(char *str)
> @@ -161,7 +163,11 @@ void ima_putc(struct seq_file *m, void *data, int da=
talen)
>   */
>  int ima_measurements_show(struct seq_file *m, void *v)
>  {
> -	/* the list never shrinks, so we don't need a lock here */
> +	/*
> +	 * seq_file callers hold ima_measurements_rwsem.  The kexec dump caller
> +	 * relies on reboot notifier ordering: measurements are suspended and
> +	 * staging/deletion are forbidden while it walks the lists locklessly.
> +	 */
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> @@ -400,32 +406,68 @@ static ssize_t _ima_measurements_write(struct file =
*file,
>  	return datalen;
>  }
> =20
> +static ssize_t ima_measurements_read(struct file *file, char __user *buf=
,
> +				     size_t datalen, loff_t *ppos)
> +{
> +	ssize_t ret;
> +
> +	down_read(&ima_measurements_rwsem);
> +	ret =3D seq_read(file, buf, datalen, ppos);
> +	up_read(&ima_measurements_rwsem);
> +
> +	return ret;
> +}
> +
> +static loff_t ima_measurements_llseek(struct file *file, loff_t offset,
> +				      int whence)
> +{
> +	loff_t ret;
> +
> +	down_read(&ima_measurements_rwsem);
> +	ret =3D seq_lseek(file, offset, whence);
> +	up_read(&ima_measurements_rwsem);
> +
> +	return ret;
> +}
> +
>  static ssize_t ima_measurements_write(struct file *file, const char __us=
er *buf,
>  				      size_t datalen, loff_t *ppos)
>  {
> -	return _ima_measurements_write(file, buf, datalen, ppos, false);
> +	ssize_t ret;
> +
> +	down_write(&ima_measurements_rwsem);
> +	ret =3D _ima_measurements_write(file, buf, datalen, ppos, false);
> +	up_write(&ima_measurements_rwsem);
> +
> +	return ret;
>  }
> =20
>  static ssize_t ima_measurements_staged_write(struct file *file,
>  					     const char __user *buf,
>  					     size_t datalen, loff_t *ppos)
>  {
> -	return _ima_measurements_write(file, buf, datalen, ppos, true);
> +	ssize_t ret;
> +
> +	down_write(&ima_measurements_rwsem);
> +	ret =3D _ima_measurements_write(file, buf, datalen, ppos, true);
> +	up_write(&ima_measurements_rwsem);
> +
> +	return ret;
>  }
> =20
>  static const struct file_operations ima_measurements_ops =3D {
>  	.open =3D ima_measurements_open,
> -	.read =3D seq_read,
> +	.read =3D ima_measurements_read,
>  	.write =3D ima_measurements_write,
> -	.llseek =3D seq_lseek,
> +	.llseek =3D ima_measurements_llseek,
>  	.release =3D ima_measurements_release,
>  };
> =20
>  static const struct file_operations ima_measurements_staged_ops =3D {
>  	.open =3D ima_measurements_staged_open,
> -	.read =3D seq_read,
> +	.read =3D ima_measurements_read,
>  	.write =3D ima_measurements_staged_write,
> -	.llseek =3D seq_lseek,
> +	.llseek =3D ima_measurements_llseek,
>  	.release =3D ima_measurements_release,
>  };
> =20
> @@ -440,7 +482,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest,=
 u32 size)
>  /* print in ascii */
>  static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>  {
> -	/* the list never shrinks, so we don't need a lock here */
> +	/* The caller holds ima_measurements_rwsem. */
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> @@ -497,9 +539,9 @@ static int ima_ascii_measurements_open(struct inode *=
inode, struct file *file)
> =20
>  static const struct file_operations ima_ascii_measurements_ops =3D {
>  	.open =3D ima_ascii_measurements_open,
> -	.read =3D seq_read,
> +	.read =3D ima_measurements_read,
>  	.write =3D ima_measurements_write,
> -	.llseek =3D seq_lseek,
> +	.llseek =3D ima_measurements_llseek,
>  	.release =3D ima_measurements_release,
>  };
> =20
> @@ -519,9 +561,9 @@ static int ima_ascii_measurements_staged_open(struct =
inode *inode,
> =20
>  static const struct file_operations ima_ascii_measurements_staged_ops =
=3D {
>  	.open =3D ima_ascii_measurements_staged_open,
> -	.read =3D seq_read,
> +	.read =3D ima_measurements_read,
>  	.write =3D ima_measurements_staged_write,
> -	.llseek =3D seq_lseek,
> +	.llseek =3D ima_measurements_llseek,
>  	.release =3D ima_measurements_release,
>  };
> =20
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 67782c004cdf..8c69684abd25 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -427,12 +427,16 @@ int ima_queue_delete_partial(unsigned long req_valu=
e)
>  	struct ima_queue_entry *qe;
>  	int ret =3D 0;
> =20
> +	mutex_lock(&ima_extend_list_mutex);
> +
>  	/*
> -	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> -	 * only list append can happen concurrently. No list replace due to the
> -	 * staging/delete writers mutual exclusion.
> +	 * The lookup and the cut have to be atomic with respect to other
> +	 * writers: ima_fs.c serializes open(), but write() can run
> +	 * concurrently on independently opened descriptors. Holding
> +	 * ima_extend_list_mutex also excludes ima_extend_list(), so the
> +	 * plain list traversal is sufficient.
>  	 */
> -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +	list_for_each_entry(qe, &ima_measurements, later) {
>  		size_to_remove +=3D get_binary_runtime_size(qe->entry);
>  		num_to_remove++;
> =20
> @@ -441,18 +445,16 @@ int ima_queue_delete_partial(unsigned long req_valu=
e)
>  	}
> =20
>  	/* Not enough records to delete. */
> -	if (req_value_copy > 0)
> +	if (req_value_copy > 0) {
> +		mutex_unlock(&ima_extend_list_mutex);
>  		return -ENOENT;
> +	}
> =20
> -	mutex_lock(&ima_extend_list_mutex);
>  	if (ima_measurements_suspended) {
>  		mutex_unlock(&ima_extend_list_mutex);
>  		return -ESTALE;
>  	}
> =20
> -	/*
> -	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
> -	 */
>  	__list_cut_position(&ima_measurements_trim, &ima_measurements,
>  			    &qe->later);
> =20

