Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329059;
	b=5W46v1asbF21bQvqh1qYFQczBW5xMkLvB/v3rkMxfIehXsm4uJplAWIF0d0MotXA6gAA
	 ZpwIciFxTNAHm9+ww+9HdqqCpEDzz3YDA+XAk1+0JLkg/UFuBItmP/q7UxsqrYCj3mt5c
	 da765VBm3hfPDXkBJN5YdpkTcy8v1RjuPH2tFaWTrJ3CG3N+QXQ+pEUFpm2a9hqYG1QNV
	 A6KuFsysfBfV7+WfidosUcLcC4USMqPVym3xySaioqrywr1DuN9SkdyouA/bFs1Y1nSdF
	 lwCR6Mcopa8iq/SvHfgADTKVM+cXMY0PakHiRjOkXt7kGyd9xoR8MwydRheUUQGVWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R29eOO7MluwzQ+8n9YmxiuPXIbP8eqbXNdA0VYXai58=;
	b=gwZvBMyKS4o6AUqWsXxnxyjsgpTE2urWpyO0a3EJ2eOxBWfcTax+zoZBr4QHeMIy3khQ
	 CKvj32LcG2x1qqQnqcH5xArNkjXVHtwzUsnRQ3Qv579cd5K8fYtjyuSe25oX6YBVcp1xh
	 G5SY4oxvymLKBH3JSo4NS+VEYr/hrbt3xS4ne7oDB98yuhHbgLKIhCBsm2glO6NfVBHvF
	 nAHAvhiYPgM4kE11qEnLBgn1913fe4ErfiwmAlJfSPbQ+SefAy9s/J5Rb+/zj8VFqiIkH
	 LuLAWk8OpDmQodWnn0Pm7f7oUsnACJjxeFEy0eo2JY4oSehgaVVwPKo3JajxXtlz/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=D0h1BDdj;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18A606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C18A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=D0h1BDdj
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67989a98f8bso141755d50.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793329057; x=1793933857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R29eOO7MluwzQ+8n9YmxiuPXIbP8eqbXNdA0VYXai58=;
        b=D0h1BDdjx/7rfkEfgzolA/olPpLTEtkcAC8fILKxjO6ClRo7FoeIHl3TtFT2euqOQN
         zfMslcyqheQPRgDV9RBjtgAZPrzG/20Wbe5GarD9g4supvFu2wBlfk93dan3O0LFaWyr
         X0rqlIhGXUm8vgBa0NaY7mOutQnpxMs+jON9lh1Y+msRnGBSePP9tFvWcqfyofMUtiNa
         FuH1SvPNkoKLosDdYSQI8hbWWNbyE+QArk4pbmL1jeNsT1FPDznP4/UkMay7mtHk2ApD
         1JlZRH6aptNzMRLrluUniTEJ6jccyc9NCbjHEsRI+Ee5iGqMkoLCyTrfdx1wXyazjMV6
         h6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329057; x=1793933857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R29eOO7MluwzQ+8n9YmxiuPXIbP8eqbXNdA0VYXai58=;
        b=RggIY7To2WTcqF1/9SbJnZpiwdOiQN4llG9dOZnh1q93WAzJGPvFqfvjt9PyrRwRBA
         kuvkGjAgUJFZ7M/CmnMFKj6zRunZuj47P2zVSzH0wIVinnAqbvGEU4mu+o8UMBJZOCVK
         8KYcUFG0xCsNx5qkBViSMb14KGhwCPCGzRu/47600ui3mwJeAsN2qtlT1dy6nOPNO/qk
         bLRHjVTOKmfi31BAJKKgcLY+i7+k2vDTkwU/aTT6tT0zAcL72LIxmWkLl3oVwDCWHVo8
         Ekci1ij/wRfZAlvhqQvmJG4x5VXKosMJ8/Zm9Of75re53QkO3ffK9eVrMX2J2hpoHQ5K
         onCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrcovXJSlyRqJXr6nKBcvaXVFjM2nyRCZbFm73PENNMjI5+BimT2wqqhxvW7JoclFWvPBOx9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE70G3uwXuLuSeUYGM9S9C2vYzYWexbW8IbsNiRL6uV8reIayI
	eYZxQb1NnF84TMWC/mIR9ziJ4r82YeKlUJXHFgp56FwwIII9CqsvH6s9bfo/YmyzUg==
X-Gm-Gg: AYBFou0u0e0+indtGOGX7OZ5hS+vOnfshCY+bgoGaHZ0iq1A8/TtHPiNPFsEPy2PjzG
	OxaFwBMmR463GEf1uQ6/yFIQJ9nBKCLqGpkC4WdeVKv08PCz9QP6adOv7tqZm+sIo9iEnSE5gKD
	jPc3GYKg2CzgPDiSivi9DAy1o8+Osieuv+rA/3ZCF6wtI74eUvmiFxJ1ysc+vsegJFI2f5Xmbfi
	fOoOwHeAEdOBYu+QavpjaBFZ5SPJDfSXzZedpBLLMK65dcmFTTvuHVB/+Mzjr8hdwPeBZrdqpwz
	0rtuF0lm3Qv3d2H2KWb8LRDWkUjxddW6ABuzu49lggIeZvjhzXrOgI8bqCKDGCckvRul3oOrrIE
	GWgRWSSKkPbcHm/+nDRYTDYck0WazApWorgBsOf8jMxj/HTVxktAMLuk8ToZhIYjt8Nf72wg+Ag
	r4WeECfXh/2P4Li3PXS1oK5JfLDg9PHqL57FoHfLkz+/vW5f/NyYGQx9TEp94342e8+OQ0842UT
	1kDmtB4J7a3Q5rR0CDA7yY1V5qNqYl3ymbN+RsQlDH82KswHQ3iO3bmMk5TkqTk/Jj44Alqjtc8
	YMH1Hugp6iOy/CranzaM1st1MNg3rJ2hHR9f2hBf3O4e1uj7Zj8=
X-Received: by 2002:a05:690e:1243:b0:671:70d1:d6e1 with SMTP id 956f58d0204a3-67ba4fdb0bemr838413d50.83.1793329056973;
        Thu, 29 Oct 2026 19:57:36 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba7509f13sm242820d50.13.2026.10.29.19.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 19:57:36 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kartikey406@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ext4: do not report inline conversion allocation failures as fs errors
Date: Thu, 29 Oct 2026 22:57:30 -0400
Message-ID: <20261030025730.3965245-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

When truncate grows an inline-data file beyond its inline capacity,
ext4_setattr() first calls ext4_convert_inline_data(). If the conversion
fails, it jumps to err_out and passes the error to ext4_std_error().

Allocating the first block can fail with -ENOSPC or -EDQUOT on a healthy
filesystem. Reporting these as filesystem errors records an error in the
superblock and, with errors=remount-ro, aborts the journal and rejects
subsequent writes with -EROFS.

For example, create a filesystem with inline_data,quota and mount it with
usrquota,errors=remount-ro. Create a small inline file owned by a user with
a 1 MiB block quota, then let that user fill the quota in a second file.
Growing the inline file with ftruncate() returns EDQUOT, after which even
root can no longer create a file.

Return conversion errors directly, as other callers of
ext4_convert_inline_data() do. The conversion helper handles its own
cleanup, and lower layers report metadata and journal errors.

Fixes: ed9356a30e59 ("ext4: convert inline data to extents when truncate exceeds inline size")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested on x86-64 KVM with KASAN, comparing ext4/dev at 8c4f6e337634
with this patch (28 allocation-pressure cases per kernel):
- ENOSPC and EDQUOT with 1K/4K blocks, default/nodelalloc/data=journal,
  buffered_iomap and bigalloc, using remount-ro and continue policies.
- Failed conversion preserves inline data; 16 repeated failures on the
  patched kernel do not increase quota usage. Removing the allocation
  limit permits a successful retry.
- Remount readback and e2fsck -fn pass for all 28 images per kernel.
- A device-mapper block-bitmap read failure still returns EIO, records a
  filesystem error and rejects subsequent writes with EROFS.

 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6ede3644a738..02011f65ab32 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -7123,7 +7123,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		    attr->ia_size > EXT4_I(inode)->i_inline_size) {
 			error = ext4_convert_inline_data(inode);
 			if (error)
-				goto err_out;
+				return error;
 		}
 
 		if (shrink) {
-- 
2.53.0

