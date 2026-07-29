Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCD430789;
	Wed, 29 Jul 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311653; cv=none; b=UGDQDWqy7ZrJZwBcb+mv7gJT3uhfd69nRePZQ8QIELWw98ahaRgwhHN2ftDBaTYZTxBPIz5ERERnbAM+LtfKT5O+86dzup6QLPxaszDf4XP+XT6Th8vTSF6BQ75UPgs0t1KQETCJf78hrJM7CrhUbmDAmE2bEDU/28ZbYPzSWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311653; c=relaxed/simple;
	bh=+QAuJHU6SgyBKECnDX+nf45rdY70yAkmP+fph6HnnCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRz40S/QZ/Wpqn3oxOyZBfOZ4SxlM84qEdlKEp7YoG+tzbvAuipJi5vlZ3JMYd0JE+750WfcBZal/d3xOfeFV+YrFfFq5ZRy5XxeHimEfgOOzq2/9QCcGVgcs1Vpw3O+vJcGhuU176z7kSuBfYy3RAgX99Of7TqEHWxRNObKRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rho0aQ6u; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rho0aQ6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NY
	CRsjdNejY70awpeyUxSlEcWOiioWnto7d+vTISsuc=; b=Rho0aQ6uqpi2DV1bZc
	MW/wLFfZLWZI3ghcT82lYfcpqTZwNgrGmkzJ+7qOO17ytC3WlFh9T0iPWaapXhHJ
	j4j2KUuRRf3kwNvM81LJi5pswMkjBN697fhIgzMqEYmM/NMsEYCGQtMerL3ADr+C
	G7Ns7ZjQai9yvnCaAl4A5FZvw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHpqZzsWlqBGZiMg--.45309S2;
	Wed, 29 Jul 2026 15:53:24 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bpf@vger.kernel.org,
	stable@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org
Subject: [BUG: 6.6.y] bpf fentry hook on _raw_spin_lock_irqsave triggers hard lockup
Date: Wed, 29 Jul 2026 15:53:22 +0800
Message-Id: <20260729075322.628521-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpqZzsWlqBGZiMg--.45309S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1rZr4kZw1xAFyUur4xCrg_yoWrXF1kpF
	W3tF9IkwnrZF18Wr48uF1vvF47AwsFgw4fGrW8Ga4rA3W5XFs8XF1xCFyYvryYvr4xWr10
	kryqqas8A34jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbCztUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RZ+9mppsXb2JQAA34

When attaching fentry programs to _raw_spin_lock_irqsave/_raw_spin_unlock_irqrestore on
the v6.6 kernel and using the BPF ring buffer within BPF programs, we encounter a hard LOCKUP.

Reproducible BPF code is shown below:

static inline int test(void *ctx)
{
        struct event *event;

        event = reserve_buf(sizeof(*event));
        if (!event)
                return 0;

        submit_buf(ctx, event, sizeof(*event));

        return 0;
}

SEC("fentry/_raw_spin_lock_irqsave")
int BPF_PROG(aa)
{
        return test(ctx);
}

SEC("fentry/_raw_spin_unlock_irqrestore")
int BPF_PROG(bb)
{
        return test(ctx);
}

We suspect the hard LOCKUP is caused by the call chain:
aa->test->reserve_buf->_raw_spin_lock_irqsave->_raw_spin_unlock_irqrestore->bb->test->reserve_buf->_raw_spin_lock_irqsave.

Mainline has merged the rqspinlock patchset
(https://lore.kernel.org/all/20250411101759.4061366-1-memxor@gmail.com/)
which resolves this issue. Should we backport the fix?

Alternatively, would a fix modeled after this patch
https://lore.kernel.org/bpf/20201029071925.3103400-3-songliubraving@fb.com/
as outlined below be viable?

--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -30,6 +30,7 @@ struct bpf_ringbuf {
 	struct page **pages;
 	int nr_pages;
 	raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
+	int __percpu *ringbuf_lock;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
 	 * the spinlock that is used for kernel-producer ring buffers. This is
@@ -165,6 +166,8 @@ static void bpf_ringbuf_notify(struct irq_work *work)
  * considering that the maximum value of data_sz is (4GB - 1), there
  * will be no overflow, so just note the size limit in the comments.
  */
+static void bpf_ringbuf_free(struct bpf_ringbuf *rb);
+
 static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 {
 	struct bpf_ringbuf *rb;
@@ -178,6 +181,12 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
 
+	rb->ringbuf_lock = __alloc_percpu_gfp(sizeof(int), sizeof(int), GFP_USER);
+	if (!rb->ringbuf_lock) {
+		bpf_ringbuf_free(rb);
+		return NULL;
+	}
+
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
@@ -215,6 +224,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	free_percpu(rb->ringbuf_lock);
 	irq_work_sync(&rb->work);
 
 	/* copy pages pointer and nr_pages to local variable, as we are going
@@ -418,9 +428,19 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 
+	preempt_disable();
+	if (unlikely(__this_cpu_inc_return(*rb->ringbuf_lock) != 1)) {
+		__this_cpu_dec(*rb->ringbuf_lock);
+		preempt_enable();
+		return NULL;
+	}
+
 	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
+		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags)) {
+			__this_cpu_dec(*rb->ringbuf_lock);
+			preempt_enable();
 			return NULL;
+		}
 	} else {
 		raw_spin_lock_irqsave(&rb->spinlock, flags);
 	}
@@ -449,6 +469,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
 		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
+		__this_cpu_dec(*rb->ringbuf_lock);
+		preempt_enable();
 		return NULL;
 	}
 
@@ -461,6 +483,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
 	raw_spin_unlock_irqrestore(&rb->spinlock, flags);
+	__this_cpu_dec(*rb->ringbuf_lock);
+	preempt_enable();
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }

Thanks,
Feng

