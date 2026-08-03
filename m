Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F5417BE2
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765041; cv=none; b=M5F1YRmoc+dI0ZQMKn32CBaoXw4zMgkFwsCEPQ2AaVj1wWngSRP3uQOKrcnYDv+QaZc5ac+XXrL8pGFzi/kDxTxQ2cnvOWM6CYu4BQjdHTD4opI7bcohWdH3ujs6Wh/bGy8EnWlkNRW1PJiYMthi5Jz4Waii5TQmce/jpEbf7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765041; c=relaxed/simple;
	bh=LPGiLQw5RcBm2gtXtkMBX5n7H0T2a7aVaC8j802eRRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rLdZ/k/p2ZdzcIMlGiFKxOf6WM7xmP/KfRy7Vxz8r2o7MfphL5bHkDyk+xD8xqB/VIV6CfIOuXZuCbDxxoYhFFQfdNV+FP9GWYXrw4cSQkIhLpG6oR9YKFbSQ8D2FBVR81mJOF41P1jV/MiYK4Onjq/EokyKbGjqbc1e0SqiX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbuVOyYF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbuVOyYF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2025519a12.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765039; x=1786369839; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NQmyofkgF7S5g7WDKL1YdgJcT1PNGV6nNZJ8ZQGA+8A=;
        b=CbuVOyYFLAxIfg9Vu1OG2XuOE+ahLf8F+i157Bind4CyjVajStxZllaQtuCFnBluZS
         myRGQZ6YHJgzHPIgtkmJzFuWDp72396+8Dd/ButPHFAF3k4tsY/vy1bL54l9mH+CgFE4
         cK8R3gEPO/TZomvq1JbNDWxje974hy38U9P/8r+X2UC7kdIPuaxtUtI/27PhB8FKeuQ1
         AROMCh2NuSTr3cP4D0lCun0eXtnwcdUBrHWe/H6zkzqYXLR0+7h7Pns9TrtxGYpOqAnc
         L75VnpNkHBvCVTeZGCizSmFHnCMtNiJG2g/6tPLrIOCWPljBhzCzYbDhi/yhtk/ZMVf4
         VMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765039; x=1786369839;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NQmyofkgF7S5g7WDKL1YdgJcT1PNGV6nNZJ8ZQGA+8A=;
        b=sfsRHiTMg9TArh618SJMs2BE78E/vgDUWqYAPpgrccClMtfbW4W3VVlRS2SYRwBRev
         iPCpF72GoQKVHJGvbXiKPTwqEJnZuR6oGidm6DyFZSiOcje1mn1FALDlvbd+UCRB8ZVl
         BqXQXm/OoRlnm2udNEbCtXEKgVWsd9JPOOks1w86bqONTX91QOkEz63q6/5yUF6+RkFa
         Ukf9+FI1FzGRPVK+LHTGmL8o4v+96DpDwdHngyUW9B0roYYul6gN1HsrZ/jVLmrPVtu0
         p74WMnMGF8y0TsuFs0hgAgtaTbHG1CMOOO5b1BcyzExPt/CE1HarkeWJBEuAyHaRGMtf
         JQkA==
X-Forwarded-Encrypted: i=1; AHgh+RrlONG4d7lDGCHdRHM3/CHVhkKPzhR26Ex5izudbfr8Q8lfCX0py9qyoUZoVIClrlcGiWULvrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqWGV5CdyV9y0Fj+WK4I0xrIvLTFUlih2fZnfAVeUMfvL+ljr
	wM7eRez2E9c5WVbLjAkjwd42Ios4IHzMkeTUJZ3E5Wz3yl2iIMLouQ0Y
X-Gm-Gg: AR+sD12nL0PvmWQXs9M0E9KUW1dYhVEDTvGCrA9J+xRaGJDvC8brrOGopuueymad/pm
	uUUQCEIq0hNOQzj/KuZdSyk+1pzjBZiIakw7K5Bxu5UmpsqmVL6jGr9iAnATTA4n/48CDejpBY6
	w1Blpf1myqlnQO7ZHxM7jezckzchuU1sxgeka4+Sc0NuMS89ZTNx4rzF+I6oD+kZE4vu5wq1por
	oapgrbOfnUBy2tsHzUXG8eC/yCk+sNTFvI9A7YgVvEBMSuPakb1B8KBXrajQrDbcGLc8LgXTTIN
	zlblHpk8XbRHAB41qdCrTIMVTLQMk9ddn3jSTjFMTjdmI5Ud7CzTJxEAAmxBPK2ldO/8stnN8+7
	PQH3L65Vx1/Bhk01Xm9poffpSmHBOWApl4rvoeNvyciGREBgcXrHQt4gDs3Xjcm8xrAbM/Ox/6D
	OMiiWDRg7F+J/UR+1FE7NBU5jisRpyGQIY23ogWbGyzTD5GmCWzp6ynFtS/Gcv
X-Received: by 2002:a05:6a21:4e03:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c92a7c8caamr10441373637.47.1785765039193;
        Mon, 03 Aug 2026 06:50:39 -0700 (PDT)
Received: from [127.0.1.1] ([2804:d45:3612:3b00:fe04:bb65:6aa0:f6e1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab143a7csm28550344c88.4.2026.08.03.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:50:38 -0700 (PDT)
From: Lincoln Wallace <locnnil0@gmail.com>
Date: Mon, 03 Aug 2026 10:50:21 -0300
Subject: [PATCH v2] ima: fix out-of-bounds read in xattr_verify()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-fix-ima-underflow-v2-1-36eec5e8500e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CQBBEr0J6bRumwye48h6ERQs90AnMmBlFD
 eHujhzA5atUvdogSlCJcMk2CLJqVO8S0CmDfmI3CuqQGCinKq+pQatv1IXx6QYJdvYvLPLbQEX
 DDVuGtLsHSaXD2XaJJ40PHz7HxWp+6T/batBgwX1Z2lqEKrqOC+t87v0C3b7vX8HJCa6yAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5398; i=locnnil0@gmail.com;
 h=from:subject:message-id; bh=LPGiLQw5RcBm2gtXtkMBX5n7H0T2a7aVaC8j802eRRs=;
 b=owEBbQKS/ZANAwAKAWwfHIW6XOyvAcsmYgBqcJyrqtCqE3tE8LgWZFXh5OiNaOiTM/b2Zf8ry
 DhGjqPNKCmJAjMEAAEKAB0WIQTPur+Hzv70Sl/Z3D9sHxyFulzsrwUCanCcqwAKCRBsHxyFulzs
 rxyXD/0RXpcmRO8KQhmkBoM8UPrr8G/ofnGYUJGuYEGIJWNAPU24W1O/+0cQE7AxGZIXs8McpBk
 LQDkQLNVhO78CpT9uOEse3DTJ1cn8TImPTOECvJoo9GYsYUgy7FIXijQLKR+e2Ph2dt0NicXwgG
 X0isx7Y5BDx7ouSMhn486dlDDXRiX2ImmPjO/nwA54wPtygmbCAZsR5juZy1V4OmUo60sH6NEnb
 WE1eoChJnl5djlrYTG1V4NpafLYr9w4NsCxzBaU6nvId+Vd9ncMPmIuie/RH9P4tjnbJxzU2eNF
 oLoA5dJfPtpaBgveThVIII5W8bCY7ZMxM82YmN91SzpxcoO7tig8FogOgbUFV+ZUUdhpq5TVT1G
 evM5w7WwoNp2REPMnKtVafd9PGTvB2A2zYYv9Lw13JNqWR7X6mhRZyz4lJSSF06erDg4bn0i0Sj
 AUTEJJIipkXe67JLuumT0jGLPpLy1BFfKrX0lOG3h8FHIAvLlXMvbeKlbC8eFue2vvWxcKt7O5F
 zGYlKFOGtgJaRLXxAN/GtB4dtaYSX3L1PrhvOHQ/+LQ7pvM5QT9az/PIqVWOdv0sb+fEW7ifC9D
 Bj/kIzoiJ/gmsTJRYCDhpqkgTdYeLd9H8Cyx4a/1QzZUAmQKpDrGrAICG9Md/Nfb75CiCefW/27
 juUvPSWVsKzqw/w==
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
Changes in v2:
- Reword the comment above the bounds check per Mimi's suggestion.
- Link to v1: https://lore.kernel.org/r/20260729-fix-ima-underflow-v1-1-4ac55f7ee262@gmail.com
---
 security/integrity/ima/ima_appraise.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 18d0d9154317..ced2e131b061 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -274,8 +274,13 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		} else {
 			set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		}
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+		/*
+		 * Use addition, not subtraction: sizeof() forces unsigned
+		 * math and a short xattr_len would wrap around, bypassing
+		 * this bounds check.
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

