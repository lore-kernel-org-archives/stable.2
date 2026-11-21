Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795227767;
	b=bcIOrOfksmeYDcjUl1mPG8hECN4IKqHOjsbt/RqxGx2ZtFQTDJ6Azm/ks1pMl4kHEzZZ
	 5cTl4HMxIYYnLx3y7Ey82GS2ZxE+MXM41XVy/hV3xZDe1y3nN/1vtrCele2918NkBJIw9
	 y/BGR6FZRWU4RXDxFJe4RJOD9Yn8TwM0uuXJMO+tp/qsdPkQFxiBx9AM+lZT4N5QAmDyq
	 ByxL/qcEYOFbn+wWmTaxpFPVqK6eT5j9tZuJHNY0ksZO6e8/Yh9+lnQlTU6ZSCHe4vRZ+
	 Cd/OIVICIR6r1132/+KWFUGT37F+QzBxCvLlxbnkvWhx4oH5UxNLohFqylqklGymWiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ULMqDPAIp2srWXkfEvxQ7kXK1Eoc5pC2DGM2zNqyAO4=;
	b=gdcFuC9NTWbDBJqrnMf5kIBWprVNBb4WIJxZPMgRovtyWzXgOtwWTiJT4NrpEKSSZITY
	 HCCRgY9aumTLTzVT0wt2g4cOsgh7QJraCugVBbqnFOGEmpIQnHzgUGiIHHxMoqT1DNEHd
	 CyZfqzKwfE1dAWor5XHakUkYOOPhCAk1K6xWFkMSwaOE2sHWDUun2ROMbDVQ8cxDDPFy1
	 d72DXeIbdya0KuxAXTCnW23TkGDyXVJjuvMQ4GCkJeAWVWYI5b9RjDreSfshtEDRs3zeY
	 KCINhZVf2/lDSFwGakYSFojfjstd7n5gfUz4vXMMlBca9NEjHgKkRk//8Gdsirzajtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6cyi3Ss;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9B606A680
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF9B606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6cyi3Ss
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ace304021eso14163851fa.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795227765; cv=none;
        d=google.com; s=arc-20260327;
        b=JyF2+7S6TotiS48UitY7sxKwTqsi1mw2TzsVFBZS0vq/VXsUWw4uYeD11zHEV7mdn9
         tYHmgjkvM4RAKDeR9METVIwYAYgGttIhepbaLt4kVxqRzhCJORzfThPr4S8JBdaaB/SH
         iYGTJVt8BRVUHx8eMvU6PB6aenmtaljmHah+lXQaaAzYlN954wUhCkOXrKVOvqyalUoC
         nbjaO2ehDQWljUOZZPJu20EQsVIIq94w1blYtZydjDF/eFwGcULf6hapItEQWOIaCzpP
         HIvDHrzQ3vIILMAgEGkzKFKrxgFVvkCJ+XFuhXEhNEi4yF0D4eJ+OKAe5pxJxoIp0SBz
         yphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ULMqDPAIp2srWXkfEvxQ7kXK1Eoc5pC2DGM2zNqyAO4=;
        fh=8l8kwDU4V/F7xM8RE/yAPJQ9NW5cGCbrJq9HeCKhBVc=;
        b=UhiCxK3bjvKlDoADsdmSwkD8MR3M1d3aOgAxUTx3LR1CfMhNP9t8RWe9iSm5rXAMgU
         btCxMFwjBGce9BgwR3ewc3jZq2aO3/24NvqMqsy8yXF//lZa4IYG+26hlo8axYgWSf/Y
         //3LcHrUHiGS6Qhby3PGb7kHUUY6mH5JGp1ZzI/CYKoi7mGBbxObZhw0gwNpr9PGGPrc
         QeM95n2rOKMn5aZkKg7BLErY9ZlHayEDFJT+Gj62cWj8GvnVyd17EbD4CHyI7dC8P/mb
         PPdHqEcD27HVwiYfEHeuqv4rJlK8Hqmwt0HL/BsMmKbbnuewV6iolHNSPDANyoSWWD+f
         BwSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795227765; x=1795832565; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULMqDPAIp2srWXkfEvxQ7kXK1Eoc5pC2DGM2zNqyAO4=;
        b=w6cyi3Ss+wbiC3C8XxxrZV19kXQstHaX//s0D9DupitfH57fy2LSqF9AGvSakbJo1U
         DWngLwIbV5RcD1xFni6smAEKlKvWTv9Dq1RZD+Q4OBQPbEXaXCTqogem4Ilrsj2ju1tK
         q/4CB231QQiwgsJOI3r8X4YaV0oDdDXVb/cqtdwBibMhhfKr2dl5WFs3GKhqIGHKe2ZN
         eq2aKdXy46ateVrk/0jLy8iGFIue22gZSWNPOmYQJUb+ZYfaFqpbsWCmdAHnT3tQQHRo
         5kXV5GMRKUsnd4ruCy4uKQrx6qfOyz5BIjGzINOUC+wvruyctc6XxXD33P4GNL2aoqnG
         wEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795227765; x=1795832565;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ULMqDPAIp2srWXkfEvxQ7kXK1Eoc5pC2DGM2zNqyAO4=;
        b=yXbnde0nOIf1KnWb+dSXBGJfDG1Cv8gZAkHJ+y4ldjqN88GgpAtW+s4esMeGJU3cWZ
         mWiWhRWCeXWrtVo1ZNloH+e0xF649Upo6sfd35Upzc5LRvljV9UphRaa1GFjRfF0IEbw
         j2UxtlcXiKdwTQ2phZiy9Ni6y+U0DJel1mK/amGRhoOfJ33+UDHFEjnOGZS9Lr9sO1RO
         WCN+9LVmYmr+9QMlZyE5ibNJMPaXfaQSKtD62Kh80ah0y/+eYr1vidsGXmWJfJqA1Emn
         8W6zO5NvH07UbbzqE94q/ONIfcUVtR5xwXsIybbG5c7CB/FmrbjM6YQlzVTt+Pk3PKAh
         6sbw==
X-Forwarded-Encrypted: i=1; AL+hErEBDdM5tLLSgrF+BhR8adHnMbxCvx+5oHEWOAMa4yKkWukvhTbrM0xtM4i119sGcWHu+MSrA08=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hjE7eEOLQyApa6IqnpJ/sGEavVfQGE0cfX5QpNuNvY1i9Qxpe
	zJdeN3EswZv3aWu7azVk46l04SnCbv71M9qyIvKlmq+BFm84w6PlBOGEKp2CW+I9LcNhmF8jPuu
	PiWnxWE+zBonqijuOznKhi8vCt4k3Yy9MiSlYexs=
X-Gm-Gg: AZFdTZcERNiZmBOQDx5kYJ9+pJTtiZJJef5l4i8K8dF+KGenIp65l3s3yUqMmDu8MxD
	A8odwuy/GGrpfGgTyEwlldJWBjGEhC65Vyol/r1SclDViGLuJuLTtJyPJIxw1Q7UTrVVL+oY+9W
	Y9SU9IkZiDCUyISFqwWROJFe9Ukkvfy1H1CFWR/3kvYITc/bYqGI/7AXYY2zC1cEL5S9eUjScYr
	MuOkOojp0obkb6orMPnpeX7gwxNuaScryR3A6RcvU1MlXZcRxYTOQbOYbsxz5eWSNOWHanaMKxV
	Udgarzp1dSUm07DfVMVBD0yQqVlYzCMqavLwpr712IBNireMr/6r1Ngzp6R3KPvnyrvolkFZP3D
	bH+SaADkVfFtrQnispiU0S346j2ihIQaA/RJ7jegjZtVPY+bzSkynnZ8/t/jcf0kxs/RAnWA=
X-Received: by 2002:a05:651c:12c3:b0:3a9:d70c:f75e with SMTP id
 38308e7fff4ca-3ae7f9b13fdmr13720461fa.7.1795227765107; Fri, 20 Nov 2026
 18:22:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Tanuj Sharma <ertanuj96@gmail.com>
Date: Sat, 21 Nov 2026 07:52:32 +0530
X-Gm-Features: Aa3M54rDAXJcpA9nCVZd8G2ChiOyncW1wB5IyOLgej5uGhtNbAmnkCcdrDrsfTQ
Message-ID: <CAAnb6FRwYjE0jXUxqFHKu8ZAmLyX_+hwpjSuuD1RHjKGVeAOcg@mail.gmail.com>
Subject: [PATCH] ntfs3: fix out-of-bounds write in do_action() bitmap operations
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This patch fixes an out-of-bounds heap write in the ntfs3 log replay
path triggered by mounting a crafted NTFS image. The buffer is sized
by bytes_per_index but bounds-checked against the larger lco, allowing
bitmap operations to write past the allocation.

Thanks,
Tanuj Sharma

From d6abed28f9eb5941da61bbe2b59876f93b4c75de Mon Sep 17 00:00:00 2001
From: Tanuj Sharma <ertanuj96@gmail.com>
Date: Sat, 21 Nov 2026 02:15:09 +0000
Subject: [PATCH] ntfs3: fix out-of-bounds write in do_action() bitmap
 operations

In do_action(), when replaying log records for ATTR_ALLOC attributes,
the buffer is allocated based on bytes_per_index (typically 4096 bytes,
kmalloc-4k) but bitmap operation bounds checking uses lco -- a larger
value derived from lcns_follow << cluster_bits (typically 8192).

This allows SetBitsInNonresidentBitMap and ClearBitsInNonresidentBitMap
opcodes to write past the allocated buffer into the adjacent slab object
when processing crafted NTFS images with malicious $LogFile records.

The bounds check compares against lco (the full LCN extent size) but
should compare against the actual buffer capacity. For ATTR_ALLOC, the
buffer is only bytes_per_index bytes, allocated here:

  if (attr->type == ATTR_ALLOC) {
      t32 = le32_to_cpu(oe->bytes_per_index);
      if (bytes < t32)
          bytes = t32;
  }
  buffer_le = kmalloc(bytes, GFP_NOFS);

But the bounds check uses the larger lco:

  if (cbo + (off + 7) / 8 > lco || ...)

With bytes_per_index=4096 and lco=8192, any bitmap_off >= 32768
(byte offset 4096) passes the lco check but writes past the buffer.

Fix this by computing the bounds limit as the minimum of the buffer
extent (cbo + bytes_per_index) and the LCN extent (lco). This ensures
bitmap operations cannot exceed either the allocated buffer or the
on-disk extent, and also prevents a crafted bytes_per_index larger
than lco from weakening the existing check.

Found by code audit and confirmed with a crafted NTFS image that
triggers the OOB write on mount.

Cc: stable@vger.kernel.org
Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
---
 fs/ntfs3/fslog.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 1879d04e3cd05..85590f56587c2 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3751,10 +3751,16 @@ static int do_action(struct ntfs_log *log,
struct OPEN_ATTR_ENRTY *oe,
  off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
  bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);

- if (cbo + (off + 7) / 8 > lco ||
-    cbo + ((off + bits + 7) / 8) > lco) {
+ {
+ u64 bmp_limit = attr->type == ATTR_ALLOC ?
+ min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+ lco;
+
+ if (cbo + (off + 7) / 8 > bmp_limit ||
+    cbo + ((off + bits + 7) / 8) > bmp_limit) {
  goto dirty_vol;
  }
+ }

  ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), off, bits);
  a_dirty = true;
@@ -3764,10 +3770,16 @@ static int do_action(struct ntfs_log *log,
struct OPEN_ATTR_ENRTY *oe,
  off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
  bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);

- if (cbo + (off + 7) / 8 > lco ||
-    cbo + ((off + bits + 7) / 8) > lco) {
+ {
+ u64 bmp_limit = attr->type == ATTR_ALLOC ?
+ min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+ lco;
+
+ if (cbo + (off + 7) / 8 > bmp_limit ||
+    cbo + ((off + bits + 7) / 8) > bmp_limit) {
  goto dirty_vol;
  }
+ }

  ntfs_bitmap_clear_le(Add2Ptr(buffer_le, roff), off, bits);
  a_dirty = true;
-- 
2.43.0
