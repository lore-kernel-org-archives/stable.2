Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB323AE71C;
	Mon, 31 Aug 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157998; cv=none; b=McwSjgaZsIt1P37trAH1pAQ3Ilnhv2zB/RnifLjdVLBygtezc1fA/KRQEsouIW5lJzjZ4qxczD3P3MCytT3QpU160BdroNGi6D6WK2pSO8lbeSVO+Md14RWRqVTe0zl1EX3pplhzDMFS75NZr+zNtCXJTjdrHy40FygLNb19hwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157998; c=relaxed/simple;
	bh=vFBIUud4P2Tvxm2pxpYsRumvEk7MnI0MItsv+VdQ+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buJxJ5C3ZcmzJ8Ge0xmxmb0XzUZzRhUOKS4xf/m8RaRuRaSztNqwVw7On4jNB+lgZ7nA7kYxrUuHrDYF5UpkiQWMY+bnD9NyvYcmx+CKYJsIA4+21rRANNB/cXAYc9Y+ubuxaB+RfbgF45ihcTbk5qsTn3yB0hk/xmZond060xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=agY+tXrB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="agY+tXrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8k
	fqIVRa33E8P4BoQKZrY5KmL+nKyxpdY1wHBO9sKtA=; b=agY+tXrBygvoZKcoBt
	XLa5Oo0pvPxLAFKnXLnrzVxBxMKVYWN7E4N49cx/I182Cd/GAuun63bo9Aas7iwo
	QIrWZMNqR4QrMCwgTohv+4KTSxCM9ZcdpZrTqcTGkwAuNAjJ1uPcxBwilEgGsHIo
	2ivR9+5nyiPLjWomApy+5Av98=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHMGIDIJVqTbDjMw--.5247S3;
	Mon, 31 Aug 2026 14:32:39 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH bpf v5 1/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 31 Aug 2026 14:32:25 +0800
Message-ID: <20260831063226.621309-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831063226.621309-1-chenyuan_fl@163.com>
References: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
 <20260831063226.621309-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHMGIDIJVqTbDjMw--.5247S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFW8WF1kKrykGrW8Crg_yoW8ur1fpa
	n5JF43Jw1vqr47t34kJw1UXF97WwsYgr9xKFykKry8ArnxWr1xW34xt3WaqF93Ar1kJ3WY
	qFnFgrZ8C3yjya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjJPiUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5ggKx2qVIAjjowAA30

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
v5: drop the explanatory comment, as suggested by Andrii Nakryiko

v4: simplify the bound to a single division-based comparison as
    suggested by Andrii Nakryiko; this also rejects max_entries == U32_MAX

 kernel/bpf/queue_stack_maps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..b5628e414981 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -59,6 +59,9 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 
+	if (attr->max_entries >= U32_MAX / attr->value_size)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.43.0

