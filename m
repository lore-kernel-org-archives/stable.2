Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795666;
	b=Hd+EODyhUvwLtHtTDJftCcQwWAxxybjAa+QImEDqe/s3XwZeq8ucmuIHsX4GoKXSJjhh
	 B3PLHxcOrmMB6ibd+j8PNqXWymFKU9Oe3h+THENzbXVjbRozq7zc89zURpqA7qaDsSJoX
	 RPQZh5wNAYZyTx8yk4ZHp9tNkpWYm0rUJHdkt0FeO1XeYu4qlBjSwpX616Itvno3S2aWv
	 eoZfDAkwtvey0bdrwpl0gghuaCO/r8K1KD9RsYe3wHCtxw0Swwa3zhoUkFe61eEsb7d51
	 X3pwG3mUPJd13mIA17u/goQDi4nauOTWLQ4P0//JxFp4ULfCCQuApsDbrNBf30KQIfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795666;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=fbDHR1bhb6fo9f6gQs2i+yeEbU4uHrwRuAQ4UhfQaQQ=;
	b=tBVEV1oJBlLKQolDAitFlGo0cKpVmvXXZFLMxh/iyuT1mwfi76O1b9e2RlqLXH7C2LcI
	 qRLQP/LS37zMtRz7ZAyW79CHBwQQDalYoX6b46QL3+W8MtGAaRyLNRr9VZF0wTI4LlQRr
	 3QyrNbpd6t4AaTbDSAlFvfNUkvt2RYvuKFGHKO7a7jQYFQkILPniWsCtUqzXZJraEjQkF
	 VlDVn7H27xGk9CFfCht5KUhV1FR+TSgyk/E9gXxvmtrgC8okL7FNs344yAMz2mCXZnaoz
	 sSS4MJrkzbJKyVRBduMUQsECVHoY8Bh5CPhQ1oLAbL4JNl47M7ZjBiwpmLwAN0dC4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.154
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735D606A326;
	Wed,  4 Nov 2026 12:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3735D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jKPxy1mxrzsklp;
	Wed,  4 Nov 2026 20:33:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.218])
	by mail.maildlp.com (Postfix) with ESMTP id B17FB4055C;
	Wed,  4 Nov 2026 20:34:13 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app2 (Coremail) with UTF8SMTPA id 2hC2B0A2QlA9JutqGi0MAA--.11855S2;
	Wed, 04 Nov 2026 13:34:13 +0100 (CET)
Message-ID: <c7c8104ca8734f52a50ac2cfd058d4ce95e1cdbc.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: hold ima_extend_list_mutex while locating the trim
 position
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Weibin Liu <liuwb@xiaopeng.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	stable@vger.kernel.org, Zhu Guanglei <zhugl3@xiaopeng.com>
Date: Wed, 04 Nov 2026 13:34:03 +0100
In-Reply-To: <20261104053705.3967228-1-liuwb@xiaopeng.com>
References: <20261104053705.3967228-1-liuwb@xiaopeng.com>
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
X-CM-TRANSID:2hC2B0A2QlA9JutqGi0MAA--.11855S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW8JrWfJw4DuFyDWF1xZrb_yoWrKF18pa
	9a9Fy7Kr1kJrWxtw1xG3WfurWruw4kWFWUJrnrG3WDAFW3Jr1jvr13tw1Y9rn5CrZrtF1r
	tF4aqrZ8Aa1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANDWrqozefaQAAsg

On Wed, 2026-11-04 at 13:37 +0800, Weibin Liu wrote:
> ima_queue_delete_partial() looks up the queue entry at which the
> measurement list has to be cut without holding ima_extend_list_mutex,
> and only takes the mutex afterwards for __list_cut_position().  The
> comment above the cut justifies this with "ima_fs.c enforces
> single-writer exclusion".
>=20
> That exclusion does not cover the write() path.  ima_measure_lock()
> registers measure_writer at open() time and even lets the same task
> open the file again by incrementing measure_writer_extra_writes, while
> _ima_measurements_write() never checks the caller's identity.  A
> privileged task can therefore open several descriptors for the
> measurement list and use them concurrently from its own threads.  Each
> open() creates a separate struct file, so the f_pos_lock taken by
> fdget_pos() does not serialize these writers (sharing a single
> descriptor would be serialized there).

Yes, I assumed the good behavior of the privileged task, but you are
right that it must be fixed.

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
> Move the lookup into the same critical section as the cut, so that the
> entry stays valid until it has been detached.  Holding
> ima_extend_list_mutex also excludes ima_extend_list(), so the plain
> list_for_each_entry() is sufficient and the RCU variant is no longer
> needed.  Keep the existing error precedence (a short list returns
> -ENOENT before the suspended check) and keep ima_queue_delete()
> outside the mutex, since the trimmed list is already private.

Not enough, it does not protect against the read concurrent with
replacing/cutting the list (originated from the same writer).

A reasonable way to solve the problem would be to introduce an rwsem,
and wrap the write, read and lseek operations. This restores the
assumptions the code was written with.

We still need the current exclusion to avoid that a process deletes a
staged list created by another process.

Thanks

Roberto

> Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements re=
cords")
> Cc: stable@vger.kernel.org # v7.2+
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> Reviewed-by: Zhu Guanglei <zhugl3@xiaopeng.com>
> Assisted-by: LLM
> ---
>  security/integrity/ima/ima_queue.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 0f1b7e4113c4..cf8c164eea13 100644
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

