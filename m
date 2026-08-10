Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C553B38BB;
	Mon, 10 Aug 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370431; cv=none; b=NKCktJKPJ61M/lg4LvODW0xkW/Rf2Fdwv/ocDdsq4QsgCcyoqBbKLblMNfnpOC2P8WBPTOf+VzD4v1pCPDmIB/qMaPVKn/9UF8r6/W9YV7ygvaa6euBjBoDwSH44Q4YO/F28AAhujGfnESuNyUmseW3rVA+XoX8VsiVjYgCkxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370431; c=relaxed/simple;
	bh=R3zAdHQ9uQNv/F5lj5AEdpSWaxv3b+49l5e+qPlVHrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAxx409rJg1ugecKPkzVaCnlbCPPq7WkdynPQLW49QTzp7matFIoJTlFr8DKrePLSSVQ7YIVlU6dNe/R6uOzz/a4b9I5AzJG8N88H7RRTcs3elNrPK0OOYi2dxM6kOI5ekJswKmDR8fyCcXhe1+kalHlXNVVnT68QgPhkx3+U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MzdKR4NH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MzdKR4NH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ph
	ux5AD7slRZPfRkakH7WOy/xNikj9T9GmqZSS5Q8V0=; b=MzdKR4NHEbcgBS/mnL
	Hw4w2Vi4mpZ1kSue/mY6oHByLnJltMKemHpVCvnw8SHpx4wOIvwhyHO5KEQU77jC
	aogOhA3OLCgwyAdVyHkCub1fL851nfOqek7jw3jt4YkhySzh5Gq63dXEtUv9gb36
	JmwEZDJsW6mqhTFXPQGxvf5mg=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X7VQ2XlqRT48Og--.14699S3;
	Mon, 10 Aug 2026 21:59:46 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 10 Aug 2026 21:59:33 +0800
Message-ID: <20260810135934.2887684-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810135934.2887684-1-chenyuan_fl@163.com>
References: <20260810135934.2887684-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7VQ2XlqRT48Og--.14699S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFy5uw1rAw15ZF18Krg_yoW8ZFWDpa
	n5JF43X348tr47t3ykAw48JFyDWws5WF9xKF97Kry8Arn3Wr1xW348Ka1aqF9ayrn7A3WY
	qFnFqrZ8C3yjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjyIUUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hKDQWp52VL6GAAA3M

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
product wraps and push/peek/pop operate on the wrong element, corrupting
map data and leaking stale values to user space.

The original bound check was removed by commit a37fb7ef24a4 ("bpf:
Eliminate rlimit-based memory accounting for queue_stack_maps maps"),
which deleted the bpf_map_charge_init() call and with it the
U32_MAX - PAGE_SIZE check that had earlier been moved into
bpf_map_charge_init() by c85d69135a91. Oversized queue/stack maps can
therefore be created again.

Restore the bound in queue_stack_map_alloc_check(): reject maps whose
element storage would exceed U32_MAX bytes, keeping the u32 index
multiplication overflow-free. Also reject max_entries == U32_MAX, which
would make the u32 capacity counter qs->size (max_entries + 1) wrap to
0 and permanently break the map.

Fixes: a37fb7ef24a4 ("bpf: Eliminate rlimit-based memory accounting for queue_stack_maps maps")
Cc: stable@vger.kernel.org
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/queue_stack_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..bb2453693b80 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -59,6 +59,16 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 
+	/*
+	 * The u32 head/tail index is multiplied by value_size to address
+	 * elements[], and qs->size (max_entries + 1) is stored in a u32.
+	 * Bound the map size so neither the product nor the capacity
+	 * counter can overflow.
+	 */
+	if ((u64)attr->max_entries * attr->value_size > U32_MAX ||
+	    attr->max_entries == U32_MAX)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.54.0

