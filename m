Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645130;
	b=Jxi22/nm9Gv6lmxMrp0/H4EKjtSNUfu8m0GzGOUbN1dbbMy0X0/i40Hxh79WLJmsIymp
	 bMMOfpPBucYn3Qy4aSeSxvHFbc/pSyYM62mly8yeGWTxx1+nVAIHjtg4bhPbsHKOujGbY
	 UwCNtjBSScy1jKplwOpLsuKVWnv3nAaOO1EMBb3Pp4JpkQEHXIJIsAG1NA8wvwx7f71b4
	 1a/nJRTNaJ3idN/lW/O9ILjNy1B2Y3Z7odP30Fsj8zR+w4C8aMHiUtYTd1xVbX5DAQs5D
	 eG9lF3JdZThzH3MrnZC+OQx14/ue35aJsKMfuGyZzoMFlLiORO8OQil2i0pYXndrxOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u2+GtbAzliCVLY4qt9XkKEEOn7y3no8jVdjlKGtflhg=;
	b=mn39R8spVTGYnnK4D00svSM5AKRPU5qO57iI+ZmiaKq/4Vm+vPOvOICs4EBGUQvHLyz0
	 L8piGM8tUpcze1lT1eRMIo6tO/96Y61FZXgkSkjhFMF+uOo7C21A9jEw8oO1Cv/CfFwlc
	 Q8Vm0yRJMUGBXjW1yK3jxIU0baicnuLGEnMVn5vmHqImCFqxutK30s7cRTtgDRrMv8jGM
	 N6xuPRFKXe2PGEDayXqqZAiCz8AsEBgZrDgF5OUhclalyHZXNDI2466iB33zCHlL0OXDq
	 5+KthkLRHDkL6yfY8CFp56fbhAj9yi8mJaZQMOH/brnKfE8NT/KgMAdI/vN2rkmsuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q1yNJE5J;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29674606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29674606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q1yNJE5J
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38355b03cb8so5972759eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645129; x=1796249929; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2+GtbAzliCVLY4qt9XkKEEOn7y3no8jVdjlKGtflhg=;
        b=Q1yNJE5Jql0gSdpOJaxee+sYbAdE4vnO9HYViUBT7dcZuqOUWfAGz6ujF6vvm059uG
         bkOO8kYVpx4hvdU5anFdhMtCACp8MQ9Zbr0EqqWWUrkKFIgHlYfCush9fml4vs8IRqHq
         F5gHH5hEiTsNDrCCP01faNxe2nOzkQEOMfQ+t3B4mKafRr4igC/56NH8lSjaG1Sx+fKf
         HYI3vqyBaRzdEUzMvXNfBHsgty6iGew4dx8XnqN3hH6xcWtf5ZoFDUmksU5gN9fvnGUl
         9iXb0GXcWrku0pEI0oX5BBEU8Q9QyKSASZ0xpicvvmik7RCSsOFIij8UgbCuwQxtkcF7
         xJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645129; x=1796249929;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2+GtbAzliCVLY4qt9XkKEEOn7y3no8jVdjlKGtflhg=;
        b=n2aOr1a5Wj9Wz8NaK6+ZfinD1HAbruYMxM/1TC+X6HsAdxf8Lw87zA93oF2Pi+6lpU
         bLygDpzCIE8gE/t5TFXzBzALZhc6SC5eLd/GMil3PcFTrqs3fB5WZJE7NIV85Mlu8VA5
         aBqpa7JWmGjU1Rjcw1IurgcckJz95HgUM7dyNleLB+nCS2VY+ai6yrECQi1TKJiib7wp
         VMthOEoUAV4mFSuSs3XFjuFwyWkz4lKVMSTWH8/9z8XC176ZBKj3ysa1c4zLouzR0j1H
         lK9UKO5r/tk3ageJwe0NdBoyINvCVYeAeN3ZBeyin6YmtjUY4tftEegFa2LY0oK+B0f9
         t2JQ==
X-Forwarded-Encrypted: i=1; AL+hErETXeXf/iYlE4nW1Kh3OVrLBEGU2ClRX7JnFEzyFCoQETUfsH7d5x9TVzzdkyscRW7Phjxizis=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YEMwAoXb34MI6QvR5x3V4EHht/f/rJ/ynNDDhUe3X3zks5dvQ
	0lT5Yoylgq+L8GRfQ7ZLqm7y4i4VUqHzJkybnLoGId94utHTrw+tN0h7Zy/dvC2QnP1Xy4vTUc4
	EBg==
X-Received: from dybla7.prod.google.com ([2002:a05:7301:1a87:b0:381:610e:404b])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8948:20b0:386:b08e:4b7b
 with SMTP id 5a478bee46e88-386b08e4e93mr10610272eec.29.1795645128820; Wed, 25
 Nov 2026 14:18:48 -0800 (PST)
Date: Wed, 25 Nov 2026 22:18:12 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221812.1423319-1-elkin@google.com>
Subject: [PATCH] nfs/blocklayout: use div64_u64() for chunk_size in bl_map_stripe()
From: Elkin Cruz <elkin@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In bl_map_stripe(), dev->chunk_size is a 64-bit integer (u64) decoded
from XDR. Passing dev->chunk_size to div_u64() silently truncates the
divisor to 32 bits, causing division by zero if chunk_size is a multiple
of 4 GiB and silent miscalculation for other values above U32_MAX.

Use div64_u64() to preserve full 64-bit division by dev->chunk_size,
and reject zero chunk_size or volumes_count upfront in bl_parse_stripe().

Fixes: 5466112f0935 ("pnfs/blocklayout: Fix a 64-bit division/remainder issue in bl_map_stripe")
Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

Note: Liu Chao posted a patch on 2026-10-16 checking !chunk_size
(https://lore.kernel.org/r/20261016041139.2292455-1-liuc63@xiaopeng.com),
which is not yet in linux-next. This patch additionally fixes the 64-bit
truncation in div_u64() (which still divides by zero for non-zero multiples
of 4 GiB) and zero volumes_count. Happy to rebase on top of that patch if
it is already queued.

 fs/nfs/blocklayout/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 00462e6affb1..8c7af13d45d0 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -274,7 +274,7 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	u64 disk_chunk;
 	u64 disk_offset;
 
-	chunk = div_u64(offset, dev->chunk_size);
+	chunk = div64_u64(offset, dev->chunk_size);
 	disk_chunk = div_u64_rem(chunk, dev->nr_children, &chunk_idx);
 
 	if (chunk_idx >= dev->nr_children) {
@@ -536,6 +536,9 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	u64 len = 0;
 	int ret, i;
 
+	if (!v->stripe.chunk_size || !v->stripe.volumes_count)
+		return -EINVAL;
+
 	d->children = kzalloc_objs(struct pnfs_block_dev,
 				   v->stripe.volumes_count, gfp_mask);
 	if (!d->children)
-- 
2.56.1.839.g22a8290db9-goog

