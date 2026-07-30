Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C4364934
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377101; cv=none; b=JjDnZYQbJr67piMPhaObxEVDyhcxdjpEaxax9ZILXJ5mXEZuMO/aRZ+xYXSezHyKT4+csBMMWImnELG0DDRlASZZHaknyYzb32mwf3dCUk6hsiCRJwnzuoZJL6uaFCYRb+Nb2uyDPfcmfM7t3zXUXwokrFBA73uM9+aJsHrAWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377101; c=relaxed/simple;
	bh=JoH7AFNLZXEgxUKRG+C+UpsGoktMEY1yfg7lu2KhfNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rGtijcuM8iq7mUsiLhVYvjyJbbXPfBq0mh98H5jgLl1tw3yyNIACGTndh0LxwcUpowXNZOKzoMW7uZw7+jC4yl1iRTgZ6pIZ65tBRVwNmCh/MezPXFtc0Gds055gtlmmGj+RPiTsf9nDeB2XRp1drhfk4HxIDZ4bjlfB0WuLv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prPrpGaB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prPrpGaB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381216921aaso1449618a91.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785377099; x=1785981899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+14EYzBOuD0YiEFKuGWW9whxbRB9TOeqEBVvomvYHbY=;
        b=prPrpGaBm6ixGGFLhq1pUQgi4mN3tfZ/a2f2h0GMbgzZ9dqVrvCdyPXnAGhogrUv8M
         n9ISfUUrYitM1+O4GgZa6Z60F8qChF+PdcOEqcu0LQmYe9RPnqx7xf06LktdNWQfIowY
         qz+IS9Pm6gu+3WBTKojatBYi4IcmzeGjYfw2WkGS1aJNog10GXgtarsRCGqcrnd9OiZp
         DndvtwdNVJ0ErCgPMpDrJNLP80OiJ+3JcByixaPuQMcesuzgpKV3+wyQ8AmOhEsgC2Gh
         ATetK4xyOR1jznSyYGYQsB0ikBK/gjGWNBRCEl+4PeKOZIMQyOFvIlHsqFuqvy87mQtX
         i10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785377099; x=1785981899;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+14EYzBOuD0YiEFKuGWW9whxbRB9TOeqEBVvomvYHbY=;
        b=qbX45Ff4czH7JCUp8E5meHiRcxbhY6PHHwFP4/fRrm+K0wJhjJmxUxHl2iQ9ttErhv
         rYwCNJzKsbJm/ES9yL8RHqPZglDCWmvzBbL2VujVspzmmFHsRdSCQ0hYLvfYTh/LU/mm
         3W0UGTVeA1Vzqr2U+Z6lKMKS0XhlyRxuHm3lnMj9ZEWrCHWuugZVTljHMRks/NjG8x1F
         dzHqVqt3TVEj3Afo8iwXvECy59ZsrO5LZsmMeZpgS9MgSjmaYA6G8afzqYAuO1GF9FSR
         0u7A1ULqDx6V+7raOeByi+Ja5XtIjhr2xlAcde83AYMmtGfP4BFzZTA6d3BywRzy4lgH
         FBBA==
X-Forwarded-Encrypted: i=1; AHgh+RrxmOzxv47UsBme/vtngZSIWsoNWWfBT3AUcEB9r7qP97iLD9OuGIPPDlPR0nuKDxZfaJDqpdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysjcwcXKHtDRwlvDGy0QMV5KZx2daeFSkPfNW/9ukKKsgC4BA
	ySjQOFm3o9GnnR1w8TubPOjQ8OER/YreA3BaxBz3MFc1fJ6s1kYQ//eT
X-Gm-Gg: AR+sD108nxPCcfME/tDIY4xrH8Yzd+uIWwR4FcPoNCPeldqpr5eSD/7zipcyOBwQYnO
	6P/g/I1qOQYxclw4ZqhEuGHcwaYHg3YDYdBuONWMtJySnxtj0Vh8R1jYbS/prZn1h3nrQJb8PLO
	7TlhfsoCT9HeTTVioq+vakOeFS1YFBW36GW+roYu/OfmKXa84P7T/MgvtR4elJfQniA5GwQNtNn
	fcKCv/idslaDczvt46QhJ4LvycDG0xa3VNU26mqGhe+ZArwKgNkdL9Rie7OkIGBigNM4Z/R819I
	yMmVa0efwmn7twqitrhvrtSQ2vQENKHQaHVpb1MKp8SRDakO666OgbGFsXo8bf6RXMcF3Vp8LIp
	hCJT8/VPEkha5ekOAck7ZuYcDpNDzGlUWtkBCyUPh/5OmbIqKbcHfTjjghYhfwtNH7oYfaAZAnY
	CKvbKLwBNDofOzrp79OlkgWAmOwpFR2QHTP4qVbzWy8lLZem8vSGXxkjzguw==
X-Received: by 2002:a17:90b:528c:b0:38f:57f0:1f5d with SMTP id 98e67ed59e1d1-38f9bdd3245mr681861a91.15.1785377098709;
        Wed, 29 Jul 2026 19:04:58 -0700 (PDT)
Received: from [127.0.1.1] ([2804:d45:3612:3b00:99db:e813:f3:8eca])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271e9d3sm13596816c88.10.2026.07.29.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:04:58 -0700 (PDT)
From: Lincoln Wallace <locnnil0@gmail.com>
Date: Wed, 29 Jul 2026 23:04:50 -0300
Subject: [PATCH] ima: fix out-of-bounds read in xattr_verify()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fix-ima-underflow-v1-1-4ac55f7ee262@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL73YKJFHaV6GPLtRbKQukB0d2TP
 gdm5oHEUThBWzwQ+ZQkW8hQlQWMM4WJUVxm0ErXqtEWvdwoK+ERHEe/bBcaNThtLFnyBLnbI2f
 pf3b9+37jolmyYwAAAA==
X-Change-ID: 20260729-fix-ima-underflow-40bd249a9afa
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Lincoln Wallace <locnnil0@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5195; i=locnnil0@gmail.com;
 h=from:subject:message-id; bh=JoH7AFNLZXEgxUKRG+C+UpsGoktMEY1yfg7lu2KhfNE=;
 b=owEBbQKS/ZANAwAKAWwfHIW6XOyvAcsmYgBqarFHmbZr2pNYGKrL9c+teszGTm1rp6a5qttkC
 moixThBBwmJAjMEAAEKAB0WIQTPur+Hzv70Sl/Z3D9sHxyFulzsrwUCamqxRwAKCRBsHxyFulzs
 r6yoEACtfnTV3cNy9rwkNwv0PH2D26gwigoFN/pyklqz+IzQszPtHfNRdDXr4amFhR17e49PIIT
 MUgjVRFTloUFZUEgKJBE75mJY1Bqh0sfbQg7sGbdrciCBWdGgTUYXEJe43kFB3PS//Uujizj5dg
 FKn0ioqthMNiGoRxaG9FLc4qZUL2A3GNc6++GCnXEGwO7QZ7WPuYvgvONbHBJ2yrZdtxDnJVWBT
 ZMX/J4oT1OyWuVfsfA3vKUHrPt2bShfUleJWqHiBCAGb90vChjl1wFIwzDGpaN9uGepLAuMplxY
 otWaZ4HtkwXT3x/qIsDv6ycIdbn/5Vf1MfaqMYahLR4EhtSTqzd+Xjyy4alD53AhpQsTZ02RveG
 Dvyl0JUigduAE9M7YSo3qtMjoqClx3+ugmZQ+L+Sg0tGU/q68EyZ7VZuoYty88sVvPCn1NZ4gIC
 1PV7x+t63Z/RHVhhzAu8gUNqNZB7eEhUJYmcJBVqYtQMIJs8HfAO9P9syCZ78QLRLU/gl7oUUy3
 65Dh7TYBZWeGBW9zeoQjAp5u1CzCnwNl3YaZ9jEAaE3y73ydNe7L48AbH716mCj7/656Mpu8L2r
 l7GDPKrd0ommZVqT93pHCmD7nBxAe+sY6vdRmMIudygeUM6EazQlBcaJo4Og4yCapIqGOBYPOeU
 cdF5h0S7TE1YykA==
X-Developer-Key: i=locnnil0@gmail.com; a=openpgp;
 fpr=CFBABF87CEFEF44A5FD9DC3F6C1F1C85BA5CECAF

The digest-length check in xattr_verify() mixes int and size_t:

	if (xattr_len - sizeof(xattr_value->type) - hash_start >=
			iint->ima_hash->length)

sizeof() yields size_t, so the usual arithmetic conversions promote
the whole left-hand side to unsigned 64-bit before the subtraction
runs. For a truncated xattr this underflows instead of going negative:
a 1-byte IMA_XATTR_DIGEST_NG xattr (xattr_len == 1, hash_start == 1)
turns "1 - 1 - 1" into SIZE_MAX, which is trivially >= ima_hash->length.
The check then passes and the following memcmp() reads
iint->ima_hash->length bytes starting past the end of the buffer
vfs_getxattr_alloc() allocated for it.

Nothing upstream clamps xattr_len back into a safe range first:
ima_get_hash_algo() only special-cases xattr_len < 2 to pick a default
algorithm, and evm_verifyxattr() returns INTEGRITY_UNKNOWN rather than
failing when no HMAC key is loaded, so a truncated security.ima value
reaches the length check as-is.

Rewrite the comparison so every operand stays a signed int and no
implicit conversion to size_t can occur.

Fixes: 3ea7a56067e6 ("ima: provide hash algo info in the xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
---
Verified with a differential KASAN boot test: two kernels built from
this tree differing only in ima_appraise.c (this commit vs. its parent),
each booted under QEMU. Config: CONFIG_IMA_APPRAISE=y, CONFIG_KASAN=y,
CONFIG_EVM not set (so evm_verifyxattr() returns INTEGRITY_UNKNOWN and
appraisal reaches xattr_verify()); booted with
"ima_policy=appraise_tcb ima_appraise=log".

The victim file must be on a real filesystem (ext4 here), not the
initramfs, since the default policy carries DONT_APPRAISE rules for
tmpfs/ramfs. As root:

    unsigned char v = 0x04;              /* IMA_XATTR_DIGEST_NG */
    setxattr(path, "security.ima", &v, 1, 0);
    open(path, O_RDONLY);                /* appraisal -> OOB read */

A 1-byte value passes every gate on the way in: ima_inode_setxattr()
only rejects zero length and type >= IMA_XATTR_LAST, and
ima_get_hash_algo() short-circuits xattr_len < 2 to the default
algorithm (SHA1, length 20) rather than rejecting.

Before the fix:

    BUG: KASAN: slab-out-of-bounds in memcmp+0x226/0x250
    Read of size 8 at addr ffff8880087a1342 by task ima_poc/74
    allocated 2-byte region [ffff8880087a1340, ffff8880087a1342)
    ima_appraise_measurement+0xf49/0x2310

The allocation is 2 bytes for a 1-byte xattr: vfs_getxattr_alloc()
does krealloc(..., error + 1, ...) followed by
memset(value, 0, error + 1), so the buffer is {0x04, 0x00}. The
xattr therefore contains nothing but the type byte: no algorithm
byte, no digest.

xattr_verify() nonetheless sets hash_start = 1 for
IMA_XATTR_DIGEST_NG to step over the algorithm byte, so the memcmp()
starts at &xattr_value->data[hash_start] = offset 2 of the
allocation, past the one byte the xattr actually holds, and exactly
at the end of the allocation. That is the address in the report
above, and why KASAN records it as 0 bytes to the right of a 2-byte
region.

After the fix, no KASAN report. Program output:

    ima_poc: setxattr OK (1-byte {0x04})
    ima_poc: read() returned 10 (ok)

dmesg:

    audit: type=1800 audit(1785342238.773:2):
      pid=74 uid=0 auid=4294967295 ses=4294967295 subj=kernel 
      op=appraise_data cause=invalid-hash comm="ima_poc" 
      name="/mnt/ext4/victim" dev="vda" ino=13 res=0 errno=0

The audit outcome is unchanged: the truncated xattr is rejected
either way, and with ima_appraise=log the open is still permitted.
What changes is that before the fix the rejection happens only after
memcmp() has read past the end of the allocation.

Found by applying the Squeeze Loop strategy ("The Squeeze
Loop Strategy: Catching Coherent-and-Wrong Artifacts with an
Author-Independent Executable Oracle," Fabrice Derepas, Zenodo, DOI
10.5281/zenodo.21098476, 2026) to this code path with Frama-C/WP
deductive verification.
---
 security/integrity/ima/ima_appraise.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 18d0d9154317..e39627f9c46c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -274,8 +274,12 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		} else {
 			set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		}
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+		/*
+		 * Keep every operand int: sizeof() is size_t and would hide
+		 * a signed underflow as SIZE_MAX. Do not rewrite as subtraction.
+		 */
+		if (xattr_len >= (int)sizeof(xattr_value->type) + hash_start +
+				(int)iint->ima_hash->length)
 			/*
 			 * xattr length may be longer. md5 hash in previous
 			 * version occupied 20 bytes in xattr, instead of 16

---
base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
change-id: 20260729-fix-ima-underflow-40bd249a9afa

Best regards,
-- 
Lincoln Wallace <locnnil0@gmail.com>

