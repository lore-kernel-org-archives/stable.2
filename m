Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949521;
	b=iw0+5QMsgHOmywb+WEtzl3A3fG238zeltimu7Ey1K64Ri8vX1N1Y4FZd2KENxKX+3MYJ
	 h+M1/zEgnX1BctMMA1SOGqpMj0eGJUSkB2mz2Tr7lacLhGhsJVj/ZYdOWFNX388O/Clde
	 vqmxl7WDIQVnFfcjn4QUfLKA/ddYf0wklglPTNO8UYgl7cbyhamBvmS7BIoRa1+dTwjIn
	 rxjzBfbtJMYp/yeKxYm9TdnQ7DpUiMrbU5lzOuYj6PXogZrZ2wvoi0FH3/4b/JsCAYUAo
	 6pTSm3Mv5TpC6cvJ4B88veCYwgq6CcSOBrfdyEAUxyqH1SBfEvCE0XKZoyTy5tmmmBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pAAhED+ct3sZOaLZuL2wp4pJ6byCoV8CC5//LfmSI9U=;
	b=gGYBezEjdix7XGuUv2vlex60VzsGCpWUixOJC+qfirlGXBmY8Cmgrn3xrbO9RJN30jkg
	 924wNz3VEPAxhSG/L13qsdsgKkBLv3Y9GOHtwByHSDd3kPm1RBUqUBYKEvMRBvPU1X/79
	 KF626jDvTqdrEHLWccsYVxUXhRHXuIqlJtvGlrvpg8OnUo1+uDJym785lKGPB+DJ9YYW/
	 Le3Sm7o71bSO81vpd4W8LKJ6Pnhie9L35nmLV8cIDZy4K2Z6KIeBHlEYrNtwX1KjvmwHy
	 zFDCFZOuks+H84af+u89MNk/V6cOCPRWSyvk9fsx3o9GdYequUnHVMBqESDKLEhqoTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SfduLc0j;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2D606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SfduLc0j
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59622so1514054c88.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949520; x=1793554320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAAhED+ct3sZOaLZuL2wp4pJ6byCoV8CC5//LfmSI9U=;
        b=SfduLc0jiuFFPlslR8C0O+bsZDaMfCReVWXZ8LTNvSLLPrlUBzRaDbLkzgUKwEt0gh
         93Y67k+5N8Ptar/vxhBr7ZAUysO97Jhuw3MdbmCPK3KBvZjpKAenGoIZa0MB8kkdr8Wi
         BQzFjLZ1MxcxxWfQTv+xCemcXPFx6m6mWaw4JNzSOYTWQvWMuWQmHRADTj9w3eNegCQ6
         vhOlGmlaIPFLjmajsQjw9qePSf3GcMRTuYuInTrcXJCK4EkiaF/bfZq7yaYyLLS0hYjS
         0kWz0CaU6gIibqNT1EUi3cWw/ZcaeI3IP9PeZ2uUva6mkj4SWCpvUuMEv6oRVJk2M5Cm
         bK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949520; x=1793554320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAAhED+ct3sZOaLZuL2wp4pJ6byCoV8CC5//LfmSI9U=;
        b=enPJGlXkPxe6bHm/ZysbjmVEZolFFjp/toW4H9WJTd4eieAWylr1Dn0vkr+RtJ9odF
         rmwvjMOaS0iUIKzJ0L06y6Mr6Fa0uKWZC1Zhiy+afD0aSsjjKoyadMgyfNWNzUOY8bEi
         UQaWWpAMqo0qxH/hgk23Zi0Av9n9RAY21x2zwa+BHMHYCmvpjq2rOXV4wcoJtjhLApHS
         7irj3z38Tw7zV877V/kz5LFq1I2WqUCJelDe8bQNBxoBPHTRy7+ewo9QNab12qHtf0sB
         zG2M+kYfMJMrXLk3tCy6mKwzGikmkctgkg2wzGfLvQVEYaHijndN+OKpB4YeMZrYAPCp
         z8Ig==
X-Forwarded-Encrypted: i=1; AKwUvByXmGeOT572qprjK5nptUyIf5tUg7Ww5BR1w53ajqayu0z9tGsHxK9QX/4FHTN5dszVq3WgBSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAV03WIEh9XNwIxjnvkmDwbUu/cejRRIRxuJsBL3x9RshkCl2A
	NUhJSXO5TQnaRIzG8o9UEhLTQTVlq4AzXwGc/RpxASGNgAc/OWiN1Dqo
X-Gm-Gg: AYBFou1Uk5GiyvL1HwLx1E4MyRDhRqBXuAl4hQPaIRMWT3Q/nsBWJtnYh5FmG/haxLv
	nz73BZzDwVxtuZTZBFld2iQpZ6sJX4eun2r15dcS5VUI+cjrNX/OTVsfXORikGvTVCpG/d3QceS
	h7n6rFZLfrQsleIZqGlRjCOBFOcdM84gtrRmT+kR8Q9/V6nTYKVVoYQ0vcMtnuNAAVbZrPnzTVm
	W2h4YrHB+/3/9o3RXos9kEa1vhOCRhZokXvi6JQNr7bR5vHuRJnowxQPJrUbKzPTBr6h+jmkJEA
	lRGeeyiF5GD4LLHnPLXlIlSpncO5ltSBGjx9cx0zs21xv6nZqviQiGD9DXvTjRtEdb1V582FEAe
	7nliVAeUwvdaxnKqfcq7igzVKhxoyDRlGJfhm5TwumgvQxZ2kwBkxJWOghrrBQLB3cZcebBUOqL
	4mPvZOF/PpsjTgZ8RvBKtZY7vslsV52tGr3iDLTFGoqyNzLW/I+lOd79/j936jqVdvoIP+Wnly2
	+emQ5/raydkdV6ltPNoUkdp2gdHxcrnsZB4pRWN+BF4Nw5seqxyHUEHu91oGK18RZzjuBfx2rT0
	/03DMEeznmQ/VnsPmXs95OkEt+CI0GeoF7/h6LQAJK21ohLrtqmGbMJU65Fh0/zcbRVaQSLL9Hx
	78AVp9YMLM2emEHY0mG0Vad9YAQ==
X-Received: by 2002:a05:7022:e27:b0:160:6a5b:7edf with SMTP id a92af1059eb24-199377d8e91mr10837106c88.44.1792949519509;
        Sun, 25 Oct 2026 10:31:59 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.203.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm16844251c88.3.2026.10.25.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:31:58 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] jffs2: return -EIO when a decompressor reports failure
Date: Sun, 25 Oct 2026 17:31:52 +0000
Message-ID: <20261025173152.147123-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
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

jffs2_decompress() passes the decompressor's return value straight up.
The rtime and zlib decompressors report failure by returning a positive
1. That breaks the kernel's error convention: a function that can fail
returns 0 or a negative errno, and generic code (the page cache, the
write path, IS_ERR()) relies on that, so a positive value is read as
success. JFFS2's own callers only check for non-zero, which hides the
violation: the value travels unchanged through jffs2_read_dnode(),
jffs2_read_inode_range() and jffs2_do_readpage_nolock() to that generic
code.

On a read, filemap_get_pages() returns 1 without filling its folio
batch, filemap_read() carries on and dereferences the empty batch:

  jffs2: Decompressor "rtime" returned 1
  jffs2: Error: jffs2_decompress returned 1
  Unhandled fault: page domain fault (0x01b) at 0x00000000
  PC is at filemap_read+0x1d8/0x5b4
  Call trace:
   filemap_read from vfs_read+0x23c/0x318
   vfs_read from ksys_read+0x74/0xf0
   ksys_read from ret_fast_syscall+0x0/0x54
  Kernel panic - not syncing: Fatal exception

On a partial write, jffs2_write_begin() has to read the old page in.
When that fails it returns 1, generic_perform_write() carries on, and
jffs2_write_end() is called for a folio that is not uptodate:

  jffs2: Error: jffs2_decompress returned 1
  kernel BUG at fs/jffs2/file.c:270!
  PC is at jffs2_write_end+0x50/0x3b4
  Call trace:
   jffs2_write_end from generic_perform_write+0x144/0x280
   generic_perform_write from generic_file_write_iter+0x64/0x10c
   generic_file_write_iter from vfs_write+0x230/0x3e8
   vfs_write from sys_pwrite64+0xa0/0xc8

Garbage collection has the same problem. read_cache_folio() returns
ERR_PTR(1), which IS_ERR() does not treat as an error, and the "folio"
at address 0x1 gets mapped:

  jffs2: Error: jffs2_decompress returned 1
  Unhandled fault: page domain fault (0x01b) at 0x00000001
  PC is at __kmap_local_page_prot+0x8/0x5c
  LR is at jffs2_garbage_collect_dnode+0x1dc/0x518
  Call trace:
   __kmap_local_page_prot from jffs2_garbage_collect_dnode+0x1dc/0x518
   jffs2_garbage_collect_dnode from jffs2_garbage_collect_pass+0xa54/0xec4
   jffs2_garbage_collect_pass from jffs2_reserve_space+0x12c/0x344

Restore the convention at the one place every decompressor result
passes through: convert any positive return value into -EIO in
jffs2_decompress(), the only caller of the decompressors, so that its
callers get a negative errno. The warning still shows the value the
decompressor returned. Negative return values (lzo returns -1) are not
changed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: fe051552f507 ("jffs2: Prevent rtime decompress memory corruption")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---

Hi Richard,

How this was found: we backported fe051552f507 ("jffs2: Prevent rtime
decompress memory corruption") to our kernel without b29bf7119d6b
("jffs2: Fix rtime decompressor"). On an AST2500 SoC, the off-by-one in
the rtime bounds check then rejected a valid node. We reproduced the
resulting failure paths on qemu, using crafted flash images that make an
rtime or zlib node fail to decompress.

Tested on: qemu ast2500-evb (aspeed_g5_defconfig, v7.3-rc7, 32-bit ARM)
with images holding an rtime or zlib node that fails to decompress. With
the patch, read() fails with EIO, a mmap fault raises SIGBUS, pwrite()
fails with EIO, GC logs "read_cache_folio() returned error: -5", and
nothing oopses. Valid rtime, zlib, lzo and uncompressed files read and
write the same as before. We did not test GC with zlib or lzo nodes, or
on real hardware.

 fs/jffs2/compr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 764f19dec3f0..da317ed3ccdb 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -288,6 +288,8 @@ int jffs2_decompress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 				}
 				this->usecount--;
 				spin_unlock(&jffs2_compressor_list_lock);
+				if (ret > 0)
+					ret = -EIO;
 				return ret;
 			}
 		}
--
2.43.0

