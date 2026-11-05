Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894834;
	b=fNLwFiif9hDZwh+K3SijGwnS/oD63EbwzbOIjRiBBkWrwynv9l2Yb2Ktn3Jf6rQaOqF+
	 wm0VVGg/9jIlVbkNJaRj1M6S2tZj6HIznOvE1IumosQY7ZTv68n0mgCKxxXWmg392q2F8
	 azg1ZimLfHpXeVuLrO1wU+TSAzr+jznjK8byplTMu2oHq8dIyno8hBcPSDwsnxF7mOq4F
	 87ObQRTBGbZZoqxSVEuNsm2cKgAZnPCIPb/U+KrO1gll0ahosEOR19sn1h/CbxKTWAfua
	 CIwg228ooyYckysYTopPanuu7uF7trwEbklcDczbFDN4D+tyW9tjLWQZZodRDa2xnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894834;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xx5/rJe0/XQBZuUO9PHWJWNTnjJFKaJX5lV5BiHZwec=;
	b=f7EtlymV8BrIxKHQsMpSBblOm2gCklfRTCUFJw66aKeJtDlSEcIea5E8H5b0uNQt3j73
	 5r+0Ag8lg+Ggq05UhM6FP4/JH4FMoVjfLmlBx3pWqX/E0sGPxcAPcWoo8Wc/Xpa82uiCM
	 GpvFr71kXn3t5DIS4X++JpNdC/vlbGjJ9qLZa+gZJcuLfqz8TIK5G41ee3xdGz+qtYL4R
	 Vz96TEJzXJiKzItZeqRX+a5Tm81g9XriNVghPriJTLQKNQWr2/BoPl0VhvxUQzLwjooY8
	 1m/dZsFUV6NZDZUb5w8qT8UWdyAfdnc4893NkTIbSde/ynQhnZ5/XVTeS5yegFN52GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.46
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32E606A339;
	Thu,  5 Nov 2026 16:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C32E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4jL6d14f8DzpWSw;
	Fri,  6 Nov 2026 00:06:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 7099040006;
	Fri,  6 Nov 2026 00:07:03 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0AG6l+eqexqDYkMAA--.2475S2;
	Thu, 05 Nov 2026 17:07:02 +0100 (CET)
Message-ID: <012a5324b4e77e1ab1e952670e1de5e4774503c2.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: hold ima_extend_list_mutex while locating the trim
 position
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Weibin Liu <liuwb@xiaopeng.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	stable@vger.kernel.org, Zhu Guanglei <zhugl3@xiaopeng.com>, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com
Date: Thu, 05 Nov 2026 17:06:51 +0100
In-Reply-To: <c7c8104ca8734f52a50ac2cfd058d4ce95e1cdbc.camel@huaweicloud.com>
References: <20261104053705.3967228-1-liuwb@xiaopeng.com>
	 <c7c8104ca8734f52a50ac2cfd058d4ce95e1cdbc.camel@huaweicloud.com>
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
X-CM-TRANSID:nRC2B0AG6l+eqexqDYkMAA--.2475S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Cry5Xry3ZF15Kw17KFg_yoW7Gry5pa
	9YgFy7Kr4kJrWIyw1xK3Wfur1ru3ykWF4UJrnrG3WUAFy5Jr1j9r13Gr1Y9F95CrWDKF1r
	tF4aq39xAan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAODWrr9Mtr3gADsK

On Wed, 2026-11-04 at 13:34 +0100, Roberto Sassu wrote:
> On Wed, 2026-11-04 at 13:37 +0800, Weibin Liu wrote:
> > ima_queue_delete_partial() looks up the queue entry at which the
> > measurement list has to be cut without holding ima_extend_list_mutex,
> > and only takes the mutex afterwards for __list_cut_position().  The
> > comment above the cut justifies this with "ima_fs.c enforces
> > single-writer exclusion".
> >=20
> > That exclusion does not cover the write() path.  ima_measure_lock()
> > registers measure_writer at open() time and even lets the same task
> > open the file again by incrementing measure_writer_extra_writes, while
> > _ima_measurements_write() never checks the caller's identity.  A
> > privileged task can therefore open several descriptors for the
> > measurement list and use them concurrently from its own threads.  Each
> > open() creates a separate struct file, so the f_pos_lock taken by
> > fdget_pos() does not serialize these writers (sharing a single
> > descriptor would be serialized there).

+ Microsoft folks.

Roberto

> Yes, I assumed the good behavior of the privileged task, but you are
> right that it must be fixed.
>=20
> > Two racing writers can then resolve the same, or an overlapping, trim
> > position, and the second one dereferences a queue entry that the first
> > one has already detached and handed to ima_queue_delete().  Depending
> > on the interleaving this corrupts the measurement list, reads freed
> > memory in __list_cut_position(), or frees the same entry twice.
> >=20
> > Reproducer: generate some tens of thousands of measurement records,
> > open() the measurement list for writing several times from one task,
> > then write "20000\n" from that many threads using one descriptor each.
> > KASAN reports a stack-out-of-bounds access in ima_queue_delete(),
> > called from ima_queue_delete_partial().
> >=20
> > Move the lookup into the same critical section as the cut, so that the
> > entry stays valid until it has been detached.  Holding
> > ima_extend_list_mutex also excludes ima_extend_list(), so the plain
> > list_for_each_entry() is sufficient and the RCU variant is no longer
> > needed.  Keep the existing error precedence (a short list returns
> > -ENOENT before the suspended check) and keep ima_queue_delete()
> > outside the mutex, since the trimmed list is already private.
>=20
> Not enough, it does not protect against the read concurrent with
> replacing/cutting the list (originated from the same writer).
>=20
> A reasonable way to solve the problem would be to introduce an rwsem,
> and wrap the write, read and lseek operations. This restores the
> assumptions the code was written with.
>=20
> We still need the current exclusion to avoid that a process deletes a
> staged list created by another process.
>=20
> Thanks
>=20
> Roberto
>=20
> > Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements =
records")
> > Cc: stable@vger.kernel.org # v7.2+
> > Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> > Reviewed-by: Zhu Guanglei <zhugl3@xiaopeng.com>
> > Assisted-by: LLM
> > ---
> >  security/integrity/ima/ima_queue.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index 0f1b7e4113c4..cf8c164eea13 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -427,12 +427,16 @@ int ima_queue_delete_partial(unsigned long req_va=
lue)
> >  	struct ima_queue_entry *qe;
> >  	int ret =3D 0;
> > =20
> > +	mutex_lock(&ima_extend_list_mutex);
> > +
> >  	/*
> > -	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> > -	 * only list append can happen concurrently. No list replace due to t=
he
> > -	 * staging/delete writers mutual exclusion.
> > +	 * The lookup and the cut have to be atomic with respect to other
> > +	 * writers: ima_fs.c serializes open(), but write() can run
> > +	 * concurrently on independently opened descriptors. Holding
> > +	 * ima_extend_list_mutex also excludes ima_extend_list(), so the
> > +	 * plain list traversal is sufficient.
> >  	 */
> > -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> > +	list_for_each_entry(qe, &ima_measurements, later) {
> >  		size_to_remove +=3D get_binary_runtime_size(qe->entry);
> >  		num_to_remove++;
> > =20
> > @@ -441,18 +445,16 @@ int ima_queue_delete_partial(unsigned long req_va=
lue)
> >  	}
> > =20
> >  	/* Not enough records to delete. */
> > -	if (req_value_copy > 0)
> > +	if (req_value_copy > 0) {
> > +		mutex_unlock(&ima_extend_list_mutex);
> >  		return -ENOENT;
> > +	}
> > =20
> > -	mutex_lock(&ima_extend_list_mutex);
> >  	if (ima_measurements_suspended) {
> >  		mutex_unlock(&ima_extend_list_mutex);
> >  		return -ESTALE;
> >  	}
> > =20
> > -	/*
> > -	 * qe remains valid because ima_fs.c enforces single-writer exclusion=
.
> > -	 */
> >  	__list_cut_position(&ima_measurements_trim, &ima_measurements,
> >  			    &qe->later);
> > =20
>=20
>=20

