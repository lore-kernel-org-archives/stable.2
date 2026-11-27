Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766469;
	b=c48zoddfk/qzDfmZA3aT9ox7Xn/TWW7llTFPeBp+EkScIMwGtserA7qR6GMWpXiB9Agw
	 ZkHBY5h10nmi3kYHJcEEP18fJVWR7kG6wawwbQueQuTnaLWR5dabVwGR5y0j5tU1C1vPp
	 BeowqXpN8Dffz0l5xixFYYTWI/FzraLV72TgtkM2km7FYSa8Hj5qeKFsPWNSghneqQ97D
	 nz72o1RyiRNmEm5030hCjxPA7hQY79vdvEsDAaW6mQ6elkqENM7vJhoTQny6KyK/BJz1l
	 oDGryBLaSBpref9/3mMY+Jrk7mzH/0UVGb0XowaXkmqLGZj4C8qIrzK9YETL4D5Mwxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766469;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jebClsNtqZW2UdPECaxMAtUOon62OHBrZPKO/lmJFnc=;
	b=qmpDb1pCGgou2DqwuPUJQ9we9Q58PDgVeU81oWyKBg3yOG2RO7YaA7o/FZMURBwwMokx
	 HzJfFBXGweB55WqhxcPB1DA9Rkr4qyMqfK061IsFmcsNw5l0nyK4U9BUxJEWc6iQqQQPB
	 41PM2OhnYITqv2Vy45ppHyGQFMdKKvH5QmHE7rePgF89DvHeofhrf1h3CiGYAfP/6mxB0
	 3oaYocP9pCK03JHkftVUZ7ufLK6ZqyxqOMmYTxqn1oZL6edluQWHCJej7J0thAqfHAMq7
	 rdRhcrtq5HtOb1wGnyz+hQtPV97WwBZYoAjiaW6WkIumIq6voygZWlmzTjSQ2rzVh/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Fb7JKzYk;
	arc=none smtp.remote-ip=43.163.128.52
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952F606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9952F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Fb7JKzYk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795766459;
	bh=jebClsNtqZW2UdPECaxMAtUOon62OHBrZPKO/lmJFnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fb7JKzYkQ2r0XVtmTu0rrxcUGa3tG7BV2IoOHpW9oYEBEycuFtj5cR8EWQHZIgHix
	 dRo0gD++MULkFM7jnsJTR4lvyizjTHO2Avcsvm6uPSJstXz1Vy08kiTtmZidyG+StQ
	 M+GvG+Dn8c97ef/TdsuzML9uGRsm0rENOjn1VSjs=
Received: from smtp.qq.com ([112.111.6.181])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 3A0ECEB; Fri, 27 Nov 2026 16:00:58 +0800
X-QQ-mid: xmsmtpt1795766458t942qbe1u
Message-ID: <tencent_03CC42627A9033070327CB3A00684CCBB008@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GsMNz6s8OJPd0KfQ357A6Mf0VtxOPCb7NAm8YZ+qYJjeBgYRAYt
	 Hzx2wETJnmx2nslkIl1DnJZ1kSYuTDsW6eH28mqOoDGlx6YTymO0oo5/bBGlAGLiyMZs2vnkmfir
	 A/2Cy5bSX1cmUrY7Re9JJlm9PfQ6ZW5I8H5prfvEqShsIRIse15s6cNjs/7kjMAgfnFLD2su6S97
	 KrtHtZ7I/tpm5QYIdLBGVZ7mQ9Hwgs/lquvPo3pr/OfsCVfKQo23I0yKt40W+D8/p8B9HIf/sbLL
	 O/FuC1YCIvdJL/56pwBGYk6MMKQPbUQ9UmyRkP4TUaafK0wtu3HNPL6egSUCMWYxkSG9iZGiuR4L
	 EEyT2on3Lywo8KbcRI0Xj+X90An7Xd4T+Kv+CllYEupf74tScB8T8Tl5KQVviEcj9AtYuwA6iYDk
	 3lvMy7TBB732hVGopuZufkyl1Oa84FeQ7lIj4WzN+CJIXderQoGssWAgUCpiim03e7owMopgazFC
	 Fde/LgeH4LsEIAcHRtLWdJbh6mX8Z+NFCv1TgsVKnPVqnUzOay8PXwBB3vSJmXf9bIZGDxPYYtSl
	 vNO8O/BChHlDKCYS++ymnBjhqcOlL33rLRVE05Wt0isFeC4bDBbhtGBYeipNnB+E7fiw36tgLdE+
	 xL6FFEhRKce07+MueelCCG3kVuuasrCFwpeL+8pMkbZJtjncajZcSd/yWsXRwyPIo4B4xXslkU+4
	 Gk7IoaRUb3kvpK8zzcYBRST6pOVgeeAfvwLiSbgaHXBrT98RTz1kQRLHwTq3mC6x/akz7E9PnteO
	 koHFDoqCERI9RuNbI5hZa/wJA6iOIsrjVu7VSyKcMd1EbG6OziSLjHX79HwLCWbfa1GcStx+yFrc
	 283wnOqhCbqqsbzF9lsr4jJu8hNRCoeU2HomEOp0UQmgdmH+pmSxRG/8XgPEmZx3QvNMQ1ROlwlz
	 WKVq7riEsgacvQR9P3wKobWbMGcaW/+uXxPFarZejl0TwwY3ZP32WO7KclfnNbFzVt7lshe3380A
	 9oF+YdgYide/7U6GmYbrElo0POz1Dozf3wmmhJRI+//D6qkDXx/WTM5cmDYWo=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Chaoyong Zhou <zhoucyfx@foxmail.com>
To: tglx@linutronix.de,
	maz@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH RESEND v2] irqdomain: Restore block-wise Multi-MSI free semantics
Date: Fri, 27 Nov 2026 15:59:12 +0800
X-OQ-MSGID: <20261127075912.1503878-1-zhoucyfx@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8cb676da416dc4dd3cdf4c6ee1a87db887e70886.adc02e38.fb00.4c86.a424.c9153ba82907@feishu.cn>
References: <8cb676da416dc4dd3cdf4c6ee1a87db887e70886.adc02e38.fb00.4c86.a424.c9153ba82907@feishu.cn>
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

From: Chaoyong Zhou <zhouchaoyong@ruijie.com.cn>

Please note: this is a resend from my personal mailbox
(zhoucyfx@foxmail.com). The initial copy on 2026-11-25 was sent from my
work address (zhouchaoyong@ruijie.com.cn) and reached you both, but our
corporate mail gateway mangles outgoing mail into multipart/alternative
(HTML), which the infradead list rejects with "550 Mailing lists do not
accept HTML mail", so the list copies bounced twice. Sending via git
send-email over this mailbox keeps the mail text/plain only.

The interrupts of a Multi-MSI descriptor are allocated from the MSI
controllers as a single aligned block: the ITS (GICv3 and GICv5) and
the Armada 370/XP drivers, amongst others, round the vector count up
to a power of two and carve the region out of their per-device event
bitmap with bitmap_find_free_region().

Commit 4615fbc3788d ("genirq/irqdomain: Don't try to free an
interrupt that has no mapping") changed irq_domain_free_irqs_hierarchy()
to free the interrupts of a range one at a time, to protect against
error paths trying to free interrupts that were never allocated.

That changed the contract with the underlying domains: a Multi-MSI
block is now released one interrupt at a time with nr_irqs == 1,
which cannot unwind the aligned region the allocation created. The
unused tail of the block is never released, leaving stale bits in the
event bitmap. As a result the MSI device is never fully reclaimed
(its_irq_domain_free() only mops up the device once its bitmap is
empty), and re-probing the device fails to allocate the same number
of vectors, silently degrading to a single MSI.

This has been reported for GICv3 ITS:

https://lore.kernel.org/all/20240708153933.GC5745@thinkpad/

Restore the pre-existing block-wise free semantics: when the whole
range is consistently mapped, hand it down to the domains as a single
block, exactly mirroring the allocation. Keep the per-interrupt
fallback for inconsistent ranges, preserving the protection introduced
by commit 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt
that has no mapping") for unwinding partially allocated ranges.

Fixes: 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt that has no mapping")
Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Closes: https://lore.kernel.org/all/20240708153933.GC5745@thinkpad/
Cc: stable@vger.kernel.org
Signed-off-by: Chaoyong Zhou <zhouchaoyong@ruijie.com.cn>
---
 kernel/irq/irqdomain.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 57c819da30c2..4b67f1e9200f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1610,6 +1610,29 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 	if (!domain->ops->free)
 		return;
 
+	/*
+	 * The interrupts of a Multi-MSI descriptor are handed down to
+	 * the underlying domains as a single block, mirroring the way
+	 * they were allocated. Most MSI controllers round a Multi-MSI
+	 * allocation up to a power of two and track it as an aligned
+	 * region (bitmap_find_free_region() and friends), which cannot
+	 * be piecemeal unwound one interrupt at a time: doing so leaks
+	 * the unused tail of the region and eventually prevents the
+	 * device from being fully reclaimed.
+	 *
+	 * Only fall back to freeing one interrupt at a time if the
+	 * block is inconsistent, e.g. when unwinding a partially
+	 * successful allocation.
+	 */
+	for (i = 0; i < nr_irqs; i++) {
+		if (!irq_domain_get_irq_data(domain, irq_base + i))
+			goto unwind_partial;
+	}
+
+	domain->ops->free(domain, irq_base, nr_irqs);
+	return;
+
+unwind_partial:
 	for (i = 0; i < nr_irqs; i++) {
 		if (irq_domain_get_irq_data(domain, irq_base + i))
 			domain->ops->free(domain, irq_base + i, 1);
-- 
2.25.1

