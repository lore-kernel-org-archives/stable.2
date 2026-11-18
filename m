Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993742;
	b=SE7q0vySiry6Bnna04yRHRn1A+Tl6scj62cPY2n3rKoMC7JF35t2rjckVjaNsGh2W4CT
	 rHMp37iDP6lcG4gGYkoeenVMvS++RIGeaHn68OTUe4o5NxHKDAhmDMgMu6Ch8cfrQu6dT
	 3UgiVLqIuE1OuZisGZ3Qg4UR9EuaSPIpaLEEpvoOXu3/AO7ivvxq7EHg86ndOo9ReoWd0
	 /Sm7kbBZWoLasMvmhN1ee487Sl+wV4UwigHZJG8H4AiLRPABiDxf8XZEP0jKGvs4EwPXu
	 Lg14jCtjHYSf8v+z4HlBXBfAJpeI2kXQ3RORG+BfuZ3aP4FwsatxCqvGZELd1xy11IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993742;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=y3A5nvaHb6xbMymh3D7AhfMioV+P8pBA8YDNGDeqscY=;
	b=m1tMvfu8YQdRjUl60+NElv7+VLEcc57Mk9Nb2Jf+LEMT3f2xBti/UmpDv7BQSJZT8gVz
	 te2p+EkcGHg+l/ldaid667K+mfAAkmAViITXszeUzS8/3w47VPdQ1XOmmdXusxdoM0+BQ
	 DLbzSWk8xR45TyL79Ci2o8AhGNHx65bXT/rLk1EYHCmEkcBe39C/QgDMoWlTc21roUc+f
	 kKcaTipzEJ1GXoVz+5qDrzZ2CNDicqSyNBT9i06q0fcTAIcuxMaHJwOmlwVGGW6ELrQxQ
	 XwKIavtWB4NqZUrimR692HWKWrlT6+59NoMbYbynClA0cAwl7GqWLAjUtnwAtXsNTmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.46
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41766606A331;
	Wed, 18 Nov 2026 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41766606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4jTx1Y35f7zpTty;
	Wed, 18 Nov 2026 17:21:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 2ED9840545;
	Wed, 18 Nov 2026 17:22:12 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0AmBlw5bv1q8LMbAA--.13214S2;
	Wed, 18 Nov 2026 10:22:11 +0100 (CET)
Message-ID: <7d0ec1b06038d1a6f3279e28447602342835c1e3.camel@huaweicloud.com>
Subject: Re: [PATCH v4] ima: fix races when deleting measurement list records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Weibin Liu <liuwb@xiaopeng.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Steven Chen
 <chenste@linux.microsoft.com>,  stable@vger.kernel.org, Zhu Guanglei
 <zhugl3@xiaopeng.com>, Lin Qiaojie <linqj@xiaopeng.com>
Date: Wed, 18 Nov 2026 10:21:58 +0100
In-Reply-To: <20261113145610.1826692-1-liuwb@xiaopeng.com>
References: <20261113145610.1826692-1-liuwb@xiaopeng.com>
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
X-CM-TRANSID:nRC2B0AmBlw5bv1q8LMbAA--.13214S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWfJF15Xr4UWryfXw1xuFg_yoWDtr47pa
	9Y9a48Cr1kJ3yfKr1xGa13Zr4ru395Ka1DWr1DG34xAF15Jr1q9FW3Ar12yFs8Kr9xAr10
	qa1YqrZ8uan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHDWr9GE1FpgAAsq

On Fri, 2026-11-13 at 22:56 +0800, Weibin Liu wrote:
> Without this patch, ima_queue_delete_partial() looks up the queue entry
> at which the measurement list has to be cut without holding
> ima_extend_list_mutex, and only takes the mutex afterwards for
> __list_cut_position().  The comment above the cut justifies this with
> "ima_fs.c enforces single-writer exclusion".
>=20
> That exclusion only covers cross-process opens and is only enforced at
> open() and release() time.  ima_measure_lock() registers measure_writer
> at open() time and even lets the same task open the file again by
> incrementing measure_writer_extra_writes, while
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
>=20
> Reproducer: generate some tens of thousands of measurement records,
> open() the measurement list for writing several times from one task,
> then write "20000\n" from that many threads using one descriptor each.
> KASAN reports a stack-out-of-bounds access in ima_queue_delete(),
> called from ima_queue_delete_partial().
>=20
> The extend mutex alone cannot protect readers: the binary and ASCII
> file operations call seq_read()/seq_lseek(), which traverse the list
> without taking ima_extend_list_mutex.  Readers from other processes
> are already excluded at open time, but an independent O_RDWR descriptor
> lets a reader thread of the writer process race with deletion from
> another thread.  Adding a concurrent reader to the writer reproducer
> triggers a general protection fault in ima_measurements_show(), reached
> from seq_read().
>=20
> Introduce ima_measure_rwsem at the file-operation layer.  Writers use
> down_write_killable() around _ima_measurements_write(); readers use
> down_read_killable() around seq_read() and seq_lseek().  If a fatal
> signal interrupts lock acquisition, return -EINTR without entering the
> protected operation.  Cover the binary/ASCII and current/staged file
> operations, since they all expose the same list traversal and deletion
> commands.  The resulting lock order is rwsem followed by seq_file's
> lock on the read side, or ima_extend_list_mutex on the write side.
> Freeing the private trimmed list remains outside the extend mutex but
> inside the rwsem write-side critical section.  The existing open-time
> exclusion remains unchanged, so one task cannot delete a staged list
> belonging to another.
>=20
> Keep the existing list_for_each_entry_rcu() traversal outside
> ima_extend_list_mutex.  The rwsem serializes staging/delete writers, so
> only ima_add_template_entry() can race with the traversal by appending
> an entry.  The selected entry stays valid until the cut.  Take the
> extend mutex only for the suspended check, the cut and the accounting
> updates.  Preserve the error precedence: a short list returns -ENOENT
> before the suspended check.
>=20
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: e9b491e27bf6 ("ima: Add support for staging measurements with prom=
pt")
> Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements re=
cords")
> Cc: stable@vger.kernel.org # v7.2+
> Reviewed-by: Lin Qiaojie <linqj@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
> Changes in v4:
> - Rename ima_measurements_rwsem to ima_measure_rwsem.
> - Use killable rwsem acquisition in all four read/lseek/write wrappers,
>   returning -EINTR if a fatal signal interrupts the wait.
> - Clarify the open()/release() exclusion, reader threads and RCU list
>   traversal in the commit message; fix the append function name.
> - Add a Fixes tag for the staging-with-prompt change.
> - Rebuild and rerun the current and staged KASAN+LOCKDEP QEMU tests.
>   Add a deterministic userfaultfd/SIGKILL test covering all four
>   interrupted lock-acquisition paths.
>=20
> Link: https://lore.kernel.org/all/20261110071909.2056650-1-liuwb@xiaopeng=
.com/ [v3]
>=20
>  security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++++=
------
>  security/integrity/ima/ima_queue.c |  7 ++--
>  2 files changed, 70 insertions(+), 15 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 3b8174a91a34..5c2919e35332 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -39,6 +39,8 @@ static DEFINE_MUTEX(ima_measure_mutex);
>  static long ima_measure_users;
>  static struct task_struct *measure_writer;
>  static long measure_writer_extra_writes;
> +/* Lock order: ima_measure_rwsem -> ima_extend_list_mutex. */
> +static DECLARE_RWSEM(ima_measure_rwsem);
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
> +	 * seq_file callers hold ima_measure_rwsem.  The kexec dump caller
> +	 * relies on reboot notifier ordering: measurements are suspended and
> +	 * staging/deletion are forbidden while it walks the lists locklessly.
> +	 */
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> @@ -400,32 +406,80 @@ static ssize_t _ima_measurements_write(struct file =
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
> +	ret =3D down_read_killable(&ima_measure_rwsem);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D seq_read(file, buf, datalen, ppos);
> +	up_read(&ima_measure_rwsem);
> +
> +	return ret;
> +}
> +
> +static loff_t ima_measurements_llseek(struct file *file, loff_t offset,
> +				      int whence)
> +{
> +	loff_t ret;
> +
> +	ret =3D down_read_killable(&ima_measure_rwsem);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D seq_lseek(file, offset, whence);
> +	up_read(&ima_measure_rwsem);
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
> +	ret =3D down_write_killable(&ima_measure_rwsem);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D _ima_measurements_write(file, buf, datalen, ppos, false);
> +	up_write(&ima_measure_rwsem);
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
> +	ret =3D down_write_killable(&ima_measure_rwsem);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D _ima_measurements_write(file, buf, datalen, ppos, true);
> +	up_write(&ima_measure_rwsem);
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
> @@ -440,7 +494,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest,=
 u32 size)
>  /* print in ascii */
>  static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>  {
> -	/* the list never shrinks, so we don't need a lock here */
> +	/* The caller holds ima_measure_rwsem. */
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> @@ -497,9 +551,9 @@ static int ima_ascii_measurements_open(struct inode *=
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
> @@ -519,9 +573,9 @@ static int ima_ascii_measurements_staged_open(struct =
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
> index 67782c004cdf..b35aa0c42f8a 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -429,8 +429,8 @@ int ima_queue_delete_partial(unsigned long req_value)
> =20
>  	/*
>  	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> -	 * only list append can happen concurrently. No list replace due to the
> -	 * staging/delete writers mutual exclusion.
> +	 * only list append can happen concurrently: staging/delete writers are
> +	 * serialized by ima_measure_rwsem.
>  	 */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>  		size_to_remove +=3D get_binary_runtime_size(qe->entry);
> @@ -451,7 +451,8 @@ int ima_queue_delete_partial(unsigned long req_value)
>  	}
> =20
>  	/*
> -	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
> +	 * qe remains valid because staging/delete writers are serialized by
> +	 * ima_measure_rwsem.
>  	 */
>  	__list_cut_position(&ima_measurements_trim, &ima_measurements,
>  			    &qe->later);

