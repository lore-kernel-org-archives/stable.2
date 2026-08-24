Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F753AFD12;
	Mon, 24 Aug 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560463; cv=none; b=RwUAtktfgKAlFU5Smg08eI7MQ3OXW9lcZM0uP5a81CIj9b80Mf/yurkaNS9Ep9x1Qztxfmot1j7DR0y7wI0tMOaM+hL6kMF8ZnXCOdtGEdB+o02YvHwGl4ekW/ooxoFufarzO34UPIx/GFP7Apm68daFxi7VFiw40f1Hi2oUTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560463; c=relaxed/simple;
	bh=4hMktIonYGMo4nseOjYHcfF7ybqZ+nla28hsULoC15Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioisvkwop0S/EyAquyKzJkEEUIFgr9wr/H8i+RVhovPNTc1lMHPSXbldSpZmEGYXVxdvkrz1lqAhoHTTtZy6PeHBxqPh8OMAKgNK6bmth4d+ZrSBwmU+mEt9oReB5tcHzfNsUau3VGiB6E3XOO0A/YLbMhxMyOkAYDAPR2JeQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d/94EzBC; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d/94EzBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ya
	4Qdtkwf1HPY1q9ceDVf7j40a6BO27XmdRz/ST8T+M=; b=d/94EzBC3rr7MlR+dh
	NuDXfenNiiCOOfHxPHPqmFgY9q3LiQUsLDGTz9ZDpS96L/oGnBaQeCjz+2RbRdBh
	BXcvNc2aKS2cK0Ne3PU6RR59mWLkAGV714wHjY1+sqHMV9s2bvGKg6RGfXaJPsxN
	sNh/T2tOh1W1nZ16wSgCtIbpY=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3hgXdAYxqoLE7Ow--.19386S3;
	Mon, 24 Aug 2026 16:33:36 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
	Yuan Chen <chenyuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH bpf v4 1/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 24 Aug 2026 16:33:26 +0800
Message-ID: <20260824083327.1708560-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824083327.1708560-1-chenyuan_fl@163.com>
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3hgXdAYxqoLE7Ow--.19386S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFW8WF1kKrykGrW8Crg_yoW8tFWDpa
	n5JF43Xw1vqr47t34kJw1UXFZ7Wws5ur9xKF97Kry8Arn3Wr1Ig340q3WaqF93Ar1kJ3WF
	q3WqgrZ8C3yjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjJPiUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gA282qMAeC1UQAA3A

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic.  When max_entries * value_size reaches or exceeds
U32_MAX, the product wraps and push/peek/pop operate on the wrong
element, corrupting map data and leaking stale values to user space.
max_entries == U32_MAX would also make the u32 capacity counter
qs->size (max_entries + 1) wrap to 0 and permanently break the map.

The original bound check was removed by commit a37fb7ef24a4 ("bpf:
Eliminate rlimit-based memory accounting for queue_stack_maps maps"),
which deleted the bpf_map_charge_init() call and with it the
U32_MAX - PAGE_SIZE check that had earlier been moved into
bpf_map_charge_init() by c85d69135a91.  Oversized queue/stack maps can
therefore be created again.

Restore the bound in queue_stack_map_alloc_check() with a single
comparison that rejects any max_entries/value_size combination whose
element storage would reach or exceed U32_MAX bytes, keeping the u32
index multiplication overflow-free and the capacity counter valid.

Fixes: a37fb7ef24a4 ("bpf: Eliminate rlimit-based memory accounting for queue_stack_maps maps")
Cc: stable@vger.kernel.org
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
v4: simplify the bound to a single division-based comparison as
    suggested by Andrii Nakryiko; this also rejects max_entries == U32_MAX

 kernel/bpf/queue_stack_maps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..0d9e0b807a50 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -59,6 +59,15 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 
+	/*
+	 * The u32 head/tail index is multiplied by value_size to address
+	 * elements[], and qs->size (max_entries + 1) is stored in a u32.
+	 * Bound max_entries so neither the product nor the capacity
+	 * counter can wrap (this also rejects max_entries == U32_MAX).
+	 */
+	if (attr->max_entries >= U32_MAX / attr->value_size)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.43.0

