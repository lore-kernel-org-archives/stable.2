Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880477;
	b=LducPjVFn1nB9dEW1nhuXlke6vfQ0U8YBquaK4g2HEqcAoFhMWnY/XsfJ32yuV61P5sd
	 2k/2jMYHZFFfCDgfdC7++9Zt+w3nNXoXYHmDQSRDhqEc5L+hU0L9nN8J/cpnOEbcihxD+
	 eI2S5ZnLOTlHs4izySN99bc9hwRMyJ5bPMEYCpMJto+FphqtXxWXumaezi9XvhpJnLsSY
	 WOdawHMWF7g8yqxrBTAGd/+xcO3YSSFUXLCTZv16UqzMXh+tH4qq8t2Ybyb0wnwwxXYdW
	 dxu/lv2kIvfpQibmmm6HpIwlvufUVq5ykGgZJ+w/j9CZyZ74+QS4IDsCWC0+76pwsQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
	b=IHP7OjvDYNWzC5yN14k2DbF2chkAFVeJ+RDNJ81Awue72F7FCL5TRVNAkjRHVFf1aef5
	 BHFDclxNtogQEFqjCk7nj+5EsKCtj08XliivL0RXHDFZpPiQHbHZln6SptGIoQoMZ3LSP
	 2qSXthanDKrge9m/mBHlTMuLrb3EgLrBy/F+1lCoP59mKyZfkOF0qadOjAf9H7Y85SSp8
	 I/9v+Qsd09RbUZFdPRRogJSThNdbnlhJ+GILCGVQ9hAvDhH0FaQLX0VOEZfxWup2BHjtY
	 9M7p5N+Sw7YkIdAi81bLbF4suHSL1FSUsbTfE/pN3b3Qvg9SP3gMEzQifAkBXDJ3qHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IrmUa9eo;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7A606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA7A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IrmUa9eo
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36dc4797082so464379eec.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794880475; x=1795485275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
        b=IrmUa9eoYFeis8Esr7n25k4HrHbH/LcZHw0yYRdA4sj2+6Sr4caNhM3N60DO9Idurf
         uaIQFZgDZ1nFpxlOtNV3svg8ufAjuBIK7Np/QULiysSmdJwilQ4I29EhJUxmSTbcKbbA
         FCYscG1G361lIP9MeS+QBhWN4J0twWh0CRrYVjCRAh1upb1dSQ4KEIWy2IL6ldo8LLdt
         u8sOeaVFih6h6glJ1J45c2rrGOuXVDsV/6VIUbLoGMjcs4bFVuw68IKqpeUBNhwLnEME
         NfuRu0zv+bznSdKP1MiTf+5Oyj+SAkZJQFcX4763W1M0JSftpMQz8t8NkVevvtCeWTYw
         yyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880475; x=1795485275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
        b=J6Bf6ZTfCvTe12V59F53OaoVTQFfpmKjU6jOfc1BqUgBjpZHM3SfOZymvgMKa0usP0
         AUUwLZezgjtThz0J7k+QSCFLhk8NGlyXeR66gMEY0xemi/t/NOLGu2PMp2hjFfkwDA19
         EoK+clPq5ExFcQEsav0bSqCY64jJKuv+R9V7YBrCQ6DEC1tnuBdUU84r2q/dn2uZLR4X
         d3VUS4Wnw8rwUnFgEQIJQQPbOB+P3dGhx3/rzAIn5Lpe6A2DPWBbNk7/NH3aJJIuk62C
         /vJLwsW2vVO70JavqKnpgMIuh3kcNrkAWu9DlYMRaBVQkAu59VKyytLqo7d/OM+JQQ90
         AH2Q==
X-Forwarded-Encrypted: i=1; AL+hErHOfRUd8tsvhywUGMlg1YvbKgyJUgY+ioce9Hz805B2itSJcZgxo5Hn/gR5PVBT1/k6dQW6Kmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AQbHnBU/Bzh1AavksiuEzkX2763j7iKsuMk7h9mXQmpy+JBrx
	KW+V5SgfRLKdny060PfvbwU3YazT/arrZ8bvdtpnbqhhYdzWr3oEsFbg
X-Gm-Gg: AZFdTZdf8Uxfd6NXRPwi5KaYTjw96YkeWEf44W7KDNskuwxNKxcJk2Bt04+rm2/TLZ8
	qtMXJEC4uzV6TVxBEM1WGY0+jaVJ8+H4mTrRXRvEDAAmSees742Qhy0QM4x0tmp2MVHaqw/XsOk
	lmUgtPbXTfQSXRiMCmyyBAKopytrmDYEn7Wk2SFlGekJKPFLUElER+z55HAGwS52nZ7gmvQOiXs
	pd4ekAyI6R/zvldgYGGTrGZ+nEJhYA7P98KMksuHTLPqhoG1GRL40wMWi43tUmwuFLdz15zuz2m
	srkrKEttCiO4tfFosnIuciYMwZmeRQfxkjo2vsNq7BkA7ols04tvEx3ySYauATmVJqCm7GesiCk
	C2iudUzwm3+657lUdVEkDPyIFDwrKgQf1hpFIrlQHqFqxSce5xbQ+BaFXes61uHfZV6x9jdjkGG
	Zch8YavXaK6dT8+odWtmIs5Q8OGNN2sTCbqbTbDZy18ohObWFn8FO/PHTSlPuAa9y1TmDVlqo3q
	aj2S1nJSAX32gVC8Z5WGthfiJR3eGOWbiAfbUNisBeXuC51TTS9XmexZsf6YA1FSI0GsTBvLtwu
	EFCHsYBe8BGk1M3CdFxqejLhMEf4ArkGmZ1dfYqQpjR4aV9Y3v7aPw88x/WKSUiz+QFKQsN0QrP
	VOnd4rKPJJo/5514yo2s=
X-Received: by 2002:a05:693c:881a:20b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3796047ff23mr17786935eec.0.1794880474975;
        Mon, 16 Nov 2026 17:54:34 -0800 (PST)
Received: from localhost.localdomain ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm34139971eec.4.2026.11.16.17.54.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:54:34 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iommu/io-pgfault: unlink partial faults before freeing them
Date: Tue, 17 Nov 2026 09:54:08 +0800
Message-ID: <20261117015409.25492-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
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

iopf_queue_remove_device() frees the pending partial faults without
unlinking them, so fault_param->partial keeps pointing into freed
memory.  A report that is still in flight can then list_add() through
those dangling pointers.  The unlink has been missing since
iopf_queue_remove_device() was first added, but the race only became
reachable with a74c077b9021, which made the fault parameter
refcounted and able to outlive the removal.

Unlink each entry before freeing it, matching
iopf_queue_discard_partial().

This fixes the dangling-list access only: a partial that arrives after
the drain now leaks, because the parameter is no longer on
queue->devices and its final put does not free partial faults.  The
next patch gives such a partial a defined fate.

Fixes: a74c077b9021 ("iommu: Use refcount for fault data access")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
iopf_queue_discard_partial() cannot be called directly from here: it
takes queue->lock, which iopf_queue_remove_device() already holds.

 drivers/iommu/io-pgfault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index c16ff1f..55a3c29 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -479,8 +479,10 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		goto unlock;
 
 	mutex_lock(&fault_param->lock);
-	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list)
+	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list) {
+		list_del(&partial_iopf->list);
 		kfree(partial_iopf);
+	}
 
 	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
 		struct iopf_fault *iopf = &group->last_fault;
