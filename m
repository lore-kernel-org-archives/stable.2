Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21D280CE5
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782361; cv=none; b=OKlti2d/AklPaE1R+5Q1itjGm1mnrYKqOEgvl5gnbZHZ8I3Z4Hmg+oKnVYlLIFt4HT05Hj115HpUhSNG9rFOj6AhCs6uZKMXiaAvrWRRveTLQl8nbQT5IkUPtrtuRGmkdSTOLKloPrtyMYmS3IatPUDUPdmIICn3k9c/HbWOkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782361; c=relaxed/simple;
	bh=k+E/AHBP+Zx+ARWbImRQV03XJYhigmgrMOmIGmqx1Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsKwjNyv6k/jzN7kV15j+QwjKf+0FYxJFMmUQhAMwGJfaNthr6D48BLvx3nXRYnWwaEUHCz9mxKVQEqfb0s9eB6Up0FJ3p4F0xw/HS6s/0ZanaRknmzHsbf2ER+e260nDQhlhbGgeyX7vHiN5GaAf/ptDC+jssPWKDHFUKy2TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu2cwe9C; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu2cwe9C"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so14479456d6.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782359; x=1784387159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EAx8OQB6mwEunipzmDLE3fqBbjdRzmKEhIwMzOXLjyg=;
        b=Yu2cwe9CgjNJcezcO2S9Wp5HtW7MDg72sEj4Fvk+AsL9oB97DPCJpfmq2URFboPnSZ
         VEA2bYF2qE9Nd5BIkLWYfJkvI5zVrkfG9mOCJeoSBeR2oYpQF4U/R3wnbEPVksDSMnZE
         yZ5IY4wr9KtDgZMTJpkd3h9zWBML/YyLAKc8dALb14kI/6ie4SJGcIgQdYW95atC3ZFS
         Qxd4RsGd6AubRgrYec8uJrnPjyraw9mG+eemTI0G/rvIXlh9MEZk4XQrJVg1VrZt09Ec
         rLj8NDwJtpm7OIvMMPEijdMRK273/sEkVdGnFBsCluS+TBOyDpCj/Q5PgZSnjDtMEQFr
         1xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782359; x=1784387159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAx8OQB6mwEunipzmDLE3fqBbjdRzmKEhIwMzOXLjyg=;
        b=OHKAEMzzKAZD/nqXtI+rSIDSvSS8lYmeiViNBrxgfuziuKtd8fANqTnxZyJ8+ix8cU
         NprCkkzSLUx7vKtW2NujZcYPo/qlpEkh7Y/9uFxIFzVq+OVzDJWJcWI1ejNfUQixDLCM
         i54r2/sS4hsi4JC6eR4YcKFDELau/lkU4wXvpZ+Yc1vONa3w9Cf1bmdEnmyqhsA4w5V1
         i5L1rZdlWHkNZVA0LalaubZnKQJEBdgbHTgbzhbOMB35O6wB6RC67EMwPszu6UeKvAU2
         0F+1Gyyoz5NunqlaBRReT2+BO3FveJXnWxz6+JbDA3ufyuyUf43lLL+nZcfDDzYSVrnC
         cxxg==
X-Forwarded-Encrypted: i=1; AHgh+RqCj+H8MRaWy6EA2abEmgaJ80O7kcGHjTs9C1qBtnMdnRw7cR22O06njepCGuwVZN6hZOJuM0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZIRhxP85GRjKWpP3AkyR+8RvThD6OldZVFGjt8HU5L+uqOk4
	vKrbVbb1D5GXoUIiW7alU04in3OomU7YRg/W8MZ6Y1qVVPU87kfk0fZi
X-Gm-Gg: AfdE7cnS9odvpGwP/BJUzq8I5s1jRD2iYj1PGdpL7nXOJjud9ECwuSvAb5aYFA4l2eZ
	jRrkuV8ondh+jAyaiFZ1kA5ZbNVN+Egzgx18jEzxMEJtYfYKOJn0V29wk+8WS/Ypwvv5f4E/NFD
	cWRMrp62S1dlEw2SMf1HnoV6L+b71BFQ0rBw+GLRtBZnBtcmQwzPQ+8kmEu5gzQEwvFC7XPivqC
	maiapF+/fBA5ETqxB+w4P0Zzcli3jl/gQ38CJZNqEYJkiAOkdWOHn6rExQdyEqlee8XXbUcaY3+
	hb3u+tKVYPQoEvtMbOQPLAUHp3ovi/vfMlSZDPrW0DbEt1FZDs5jSKLA4pkbnwNzb+zBOovGEbm
	xHT/66Dxz/shzJIIUE1XiW9YTx6EFuTw7DVwsbqbm4m7awc8XcuFIJBcdfXvKHb+9u1jZqMvMyE
	4S7qoC9v+USwEVIAf/DSrVd4rH7Rq9Rf03TPvPd4hIhpL0RzOBRe52XY+i9n/p7tKJcXDyxxkrB
	xGj1Z0X6w==
X-Received: by 2002:a05:6214:509a:b0:8fd:6e22:c7ee with SMTP id 6a1803df08f44-90402e69077mr35450716d6.63.1783782358994;
        Sat, 11 Jul 2026 08:05:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm68559686d6.19.2026.07.11.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:05:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pnfs/blocklayout: reject zero chunk_size and volumes_count in GETDEVICEINFO
Date: Sat, 11 Jul 2026 11:05:47 -0400
Message-ID: <20260711150547.2912006-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

nfs4_block_decode_volume() in fs/nfs/blocklayout/dev.c decodes stripe
parameters from GETDEVICEINFO XDR without checking for zero values.
A malicious pNFS server returning chunk_size=0 causes a division-by-
zero panic in bl_map_stripe() via div_u64(offset, dev->chunk_size).
Separately, volumes_count=0 passes the existing upper-bound check
and causes a second division-by-zero via div_u64_rem(chunk,
dev->nr_children=0).

Impact: a malicious or compromised pNFS blocklayout server can panic an
affected Linux NFS client after the client mounts/uses the server and maps
I/O through the poisoned blocklayout. An in-kernel parser/mapper KUnit
reproducer is available privately.

Reject both zero values at decode time with -EIO.

Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfs/blocklayout/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91a..fc60669db3ec4 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -183,8 +183,11 @@ nfs4_block_decode_volume(struct xdr_stream *xdr, struct pnfs_block_volume *b)
 			return -EIO;
 
 		p = xdr_decode_hyper(p, &b->stripe.chunk_size);
+		if (!b->stripe.chunk_size)
+			return -EIO;
 		b->stripe.volumes_count = be32_to_cpup(p++);
-		if (b->stripe.volumes_count > PNFS_BLOCK_MAX_DEVICES) {
+		if (!b->stripe.volumes_count ||
+		    b->stripe.volumes_count > PNFS_BLOCK_MAX_DEVICES) {
 			dprintk("Too many volumes: %d\n", b->stripe.volumes_count);
 			return -EIO;
 		}
-- 
2.53.0
