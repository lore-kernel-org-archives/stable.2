Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686235;
	b=T3vxqQiPzHXSu0TOU81gUt1gwmxhMatikxkVEpNUWSfUmTtVpRz47VCwO1Z1XeEC8tt5
	 jW8J/Xk5AIKq+fud6b2FBnZIWroUvaZhqimRf76FxMNj/T6ndKxLrP8M6U9oAfLZL/bHC
	 n+wIgauIpcpvQkIHCrnlYPRLZnxBnUxtEzJ0fP/Xh3c6gUiOc+AXlBUTWZkvQOJA6fvQZ
	 JzNFUQ04l5jeaUSYjqfEIzcyXQa1oKOzATBrsatLcWZionvsBXBcHmG+M8dq5M3Vb4q5v
	 /Qgb3xoLmV8ydcRFU9xWZBUIiXdZLZO8Pj3PHocrbD0hTfgueXdEbj7MWUE1Zy0Gz7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D7f/7cfhMuxRUvMF2+7Ngeja0NaB7eB5cH8ZEWQf8hE=;
	b=HjaaezEZ3sLI42XNnBSHjCOwO45SqolNXAatwwvyAIhtt/hT+H0mxEm1r+wrf/Q87w2q
	 IEaWH/AoaqgX9zuAaKvoFQJBZt0U2CRisPksmnRt/8UHvt6F9i6Sh+AV44kHGk+j4c6mo
	 Kj8C5AvALSC44xNJR1uKgOiiBSQT28q0zd3pt/YGVRYiv5iL3QjiJJTRifn8p6U9HgEJ6
	 NrZHQ/kuaqCSPyHogidLT919s1GfSdxjhAlT4RJ9VHZXX/QCm4I20WxJES2wwtnLci9uf
	 YE+2mNWqJIyHQrdpN9h6LUkq2AroaoCi56mGAZJw7dpTJuwPz4FVruLABg6ENA10gKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=OB+8CPCL;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B0606A336
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 06:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18B0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=OB+8CPCL
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c75be77c4so38151826d6.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 22:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793686234; x=1794291034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7f/7cfhMuxRUvMF2+7Ngeja0NaB7eB5cH8ZEWQf8hE=;
        b=OB+8CPCL3Zw1NNu/20+ZOMwJ8pRismzLJcCVuJHPrrEM8/rSrzdl2OEG5XJnhPn6M2
         5sBiNPt1EmI0dRmbugAnbvxmTDjyTSn1y5uKaQz30Cft5UYRyf9FSmkt2K5IBP6EEy9L
         Qy0j/GCRQsFo/BHB5zhZDkPNlP38OG7B9UMegjs6DClNJx/PshbxLkic3jRDs6jwOK6e
         fjJMxzDN3iCAoz6t0cP/DR+sb90MR5WRVXCAMV20r/VJdigErUpOhhrYK79osR6u8t1Y
         toAZtS+WaVD9gN+PiIOYbbAtZ/RGcIgXBflCFU5kzrLEEMLtdpHDOjgrUN/YjJq5/SVm
         UKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793686234; x=1794291034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7f/7cfhMuxRUvMF2+7Ngeja0NaB7eB5cH8ZEWQf8hE=;
        b=VNr0MZm/N5Ee8YdZWbqBr6EmnkD8z9mJmKTWqR8wXQExsK4Aukwsc/0I8VcSzXdRQ8
         HnrJqSATt2FwKpUrtNfhhM4hKgW68o7u4F+kF5jqrlYYaJEf6eYse9sKe7oo8ZL4WhdW
         ETOfGFY3Vk+r2/vRsHH6/DYyauaTRwYy9ZsOt7FCqC56vNHk81p65G5hkYVIc4VfTzvZ
         xNTZ85hA7Yu4SITh3p2MgR++I9KoBXKu/eEJZ7NO+D4WoZtgRHKgtjSHc/ZDTE4vF5Me
         L6Q8C7+I2+6pVikWaerO3mXMS83zGKJVf33y47KZVvMCvV/V7z13yX6iUFuUkN3D70/n
         L1gQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZXn6oRjUetRPfRCwKWRgu+RPT6ecWuxTIzyXyD/l6xEDm8HiHIb90UGoJTYWTOfhDufVnwDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b0AOZsK4Y864o0IWUvfRjsMjmsVSl6LFyL505oMqllOd3oxRZ
	j3ks3heBNfIubKrEVx1yMSzyh2/zj/1ApGXEPc3Jwzf1JldoeuS7bMqgCl7BDTp1qg==
X-Gm-Gg: AYBFou2h7zJmp/1hS3xfKeO5Co93GPUMlNSEqrixcrknEhwN4omqfzyBBblVstwwgUa
	/1Fsqq5kK3H1E2j2oEKMlyKlFzoV1eenBJsEUfUKsS9Vdstp461ENMyurKdLJPf6rAX3t8wOvYH
	istMyw2zIOgPa7naLKaeyKZH+H7i6Pvu/LvvoPVqV55vaudWuqnWMszWvnBTaD7clMj74xkqeGM
	alyCqxap3DipMV+YEVTjVWj3cBrYafHW/SDjFfLEExYIsuJHskDgCbQhzZSklj+6ari47z+dOZz
	nHC4kqQpOqQZRYZ3ZPUFYk7M1il3lD5tHvofhAIkPd9Gi/LyaXY4t302LuTZWKHH6olv8fKuWO4
	LSpGEBYNfKy1B267jL8PDaClFEILLvtlpKaNF8l1gUyyEai9Hoy5slrbaD8VxIXclwdJI+gtCdp
	3RVgfaY8FHMnM/PNTYYiUvLDrsk0WnglWXXCm8QReFhjLAQOpIRV7V/KqLc3FEtIAgf6AWadtfK
	tLULfKH8vKu+XX/ylbEHa/dym2/9UmWojMD3h3uqhnXwlOThyTQCeT/un2PBsxZSEqN0d2AVZ8z
	PaFaEybft2yZC3oYHNgjWJLMLuNVkNkAAMwg8F5LyTQ=
X-Received: by 2002:a05:6214:ace:b0:91c:7a68:2ab3 with SMTP id 6a1803df08f44-91ca4bb34camr203741326d6.37.1793686233610;
        Mon, 02 Nov 2026 22:10:33 -0800 (PST)
Received: from localhost.localdomain ([2600:1011:b1ae:f075:aa26:e161:414d:7ec7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca807d8fasm109173076d6.41.2026.11.02.22.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:10:33 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: dsterba@suse.com
Cc: wqu@suse.com,
	boris@bur.io,
	mason@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: tree-checker: reject extent owner ref without simple quota
Date: Mon,  2 Nov 2026 23:10:21 -0700
Message-ID: <20261103061021.2213691-3-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103061021.2213691-1-smish149@asu.edu>
References: <20261103061021.2213691-1-smish149@asu.edu>
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

[BUG]
An extent item can contain an owner ref.  The owner ref is correct only
when the super block has the SIMPLE_QUOTA bit.  If the bit is not set,
check_extent_item() gives a WARN_ON() and then accepts the leaf :

	case BTRFS_EXTENT_OWNER_REF_KEY:
		WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
		break;

For all other incorrect inline refs, check_extent_item() returns
-EUCLEAN.  After the tree-checker accepts the leaf, a free of the extent
calls btrfs_get_extent_inline_ref_type().  This function ASSERT()s the
SIMPLE_QUOTA bit.

On a kernel with CONFIG_BTRFS_ASSERT=y, a free of such an extent gives :

  WARNING: fs/btrfs/tree-checker.c:1782 at __btrfs_check_leaf
  assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA),
  in fs/btrfs/extent-tree.c:354
  kernel BUG at fs/btrfs/extent-tree.c:354!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:btrfs_get_extent_inline_ref_type.cold
  (fs/btrfs/extent-tree.c:354)
  Call Trace:
   lookup_inline_extent_backref (fs/btrfs/extent-tree.c:919)
   lookup_extent_backref (fs/btrfs/extent-tree.c:1100)
   __btrfs_free_extent.isra.0 (fs/btrfs/extent-tree.c:3319)
   __btrfs_run_delayed_refs (fs/btrfs/extent-tree.c:2134)
   btrfs_run_delayed_refs (fs/btrfs/extent-tree.c:2246)
   btrfs_commit_transaction (fs/btrfs/transaction.c:2278)
   ksys_sync (fs/sync.c:104)

Without CONFIG_BTRFS_ASSERT, the kernel gives only the WARN_ON().  Then
btrfs continues to use the owner ref.

[CAUSE]
I made a crafted image : an owner ref, no SIMPLE_QUOTA bit, and no quota
tree.  I removed the file of the extent.  At the next commit, btrfs
frees the extent and gives the BUG above.

For an owner ref without the SIMPLE_QUOTA bit, the tree-checker gives a
WARN_ON() and keeps the leaf.  For all other inline ref types, it
rejects the leaf.  Two sources can put owner refs without the
SIMPLE_QUOTA bit on a disk : a damaged or crafted image, and a kernel
without commit f2363e6fcc79 ("btrfs: fix transaction atomicity bug when
enabling simple quotas").

[FIX]
Reject the leaf with -EUCLEAN, as for all other incorrect inline refs.
Then btrfs finds the problem when it reads the leaf, and the ASSERT() is
not reached.

Link: https://syzkaller.appspot.com/bug?extid=d7d1fc7e21835ca19219
Link: https://syzkaller.appspot.com/bug?extid=4983e68a6d77180bfe33
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 fs/btrfs/tree-checker.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index bb86c30a2..f021ac14b 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1779,7 +1779,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
-			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			if (unlikely(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))) {
+				extent_err(leaf, slot,
+					   "extent owner ref without simple quota");
+				return -EUCLEAN;
+			}
 			break;
 		default:
 			extent_err(leaf, slot, "unknown inline ref type: %u",
-- 
2.54.0

