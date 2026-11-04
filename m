Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780491;
	b=FKpqOB/VtBPU7X7LMp+4OrWMxrACGPsPV2apec9VIxoITY36rjqZ8JUisYgbrCg/KAgB
	 uvsJ9646qjVjIyIhAbSotsJbQK3rZc+b9GG9Ez24nwP7pe1bykXvtI2C5lFmB7isKpohp
	 GNasKyqU3JJshQXXTZA9GZ04dtPsETgLCQXzF0xxTxLzieBh5qFFEgYvfgz+Au/cTm6mU
	 JYilqCYCn4KLnfWwWv75ObvjU8CRkErUyx/VC8N1lS1fw2on/nU4CZjDCwfaPW1z6Y6vG
	 3uQz7YIL/FuJ/3oUycYG1Y6gCYIaQqdzlsFO0nofvqLwdIn+MYCyeCOUHLbeFqKuNPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
	b=qWBCUCIkSGGEKrCgrwEsjxDdrCb4NT8n6LT0xAVHQK4I7GGPQ1oD9IW/OLjYEzfX/8L7
	 Jn2KZMeesshNZKGLY2AEO59K9MPJePNDvxHNynrF08C/X4Mai3jsptNQgwiZXMmV+8Oau
	 zIw+ClauXgP+yZsRp3M77TZEog693Zwm6Clftf9wi2dtPfS2eOCjNmqEQ06e8lTJl3w80
	 cph0FOYLrqOSqbyN08uPfa8RKSSN8MAW6el8CV9CSJsOxybaIYTiGK4Yq357/vxnnpI0y
	 1BfYsQXGAez9K76btdAXfOnWual0b/kgjtj4kOgsKbzFPhqCp2azaLDI8F+R7GxrfeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8lWT74G;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF0606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EF0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8lWT74G
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a215e64962so3767365e9.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793780490; x=1794385290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
        b=d8lWT74G+yXWFlqGK8Bo4Tdcnvx0gGeCOXNOZ9hvAcn9Mnk6EPmrQ2cIwxDsCNRczn
         B8MmhbTG1GF8PnLdup/yJuHZA+v673ZG7cqmCYKELm34vpU7ONvPW/4n9hfSl8n8C9Fx
         24l1fernS6sYW8RQKkQiuEwgOWPgW4dwSkJsp2Xa61RvxLVVrO79WG0irFpzRmXVhAnP
         BYYO+Xmx8yrSRqVMr0LBFCISWGGUmUb7RTfWAXv8gyV9592UIQHQPjFiAVvz9grh37U2
         hokKw3BIWzPcJNNRWESawKpKIKF5nE6j2hzCQ6Kv4TG97G36A/ELCdjQw31mBQ6eRK2p
         zkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780490; x=1794385290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
        b=xp92EYoXaxxyEgIrBv2RcaSEabfKPHx9lL3NchZ3o8SeIKCqUMG5w1tIXlZgpcx31h
         7jEuZ7eXkzns0uEGKWffst6WZnEhp4n7OYluHsTk18PRVuLwkfulhFgnF2VmZ1Nx/TOa
         wC66NoPig//heHgqVWI4TnejELKfDFKff1wchKQfuy3yIRvivySbW/QqqF9rEIAtSJil
         S/qvkeUE+Pl9/12PktoD2d9MQyAKumH3om44RDbo6VWwoTgH+Jp6F4HhmPa7/HLSET7U
         vlN1rtPwbb19cGeqbaCRhAKRSGbSXECaI9rS0YsVWZ1xrKBOx2/0LCBQ9fsD0N2moNUJ
         ucJg==
X-Forwarded-Encrypted: i=1; AKwUvByzshP1RBwkhEU3EeaQWZumo0umz7JvzpobCNBinSHw5MdehWfb8KIxIObu9fD9D22CjQOuN24=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vhptg8P3FE1PBtcfEkCY8ZWrA+IeKi3ZZ16OKlVnqCh7dLnfF
	aAo84bCP6MawbRSWBkKneWJwg5L6ftKV8ELqpWtcfjpIm7JM1qhrbNuC
X-Gm-Gg: AYBFou2kCGV0omCWYU9EiowMib/MmK8Ok+iTSW9/oweB6ND5D6kSRaxnZU82+0nAYGO
	a0bNAc6A55P2ClUdSyk3gYrEhbwSFST0vvBy1PPcEtTtfT/uZcxxDQZydG3YcJiJBlDJFdi2va9
	64iCV81CzDttBc5cIGDjuQLLwD777nY9TlbE2hI5OE49i/mGkxNuK59xaZ3eW2hMf6rQzGeDAAu
	ord0X/ExgTnLnjkeRZ8ZXsAUPRTiB0nNGDdInaxKUrIXUZvND1VP5K7CVP87+SIPlTvb3XBsqa0
	lCTtfGRa4rKO0sXxl1wCT7iL/kIEQPiIMZjV0QWUOZaPlfUHIZf0BDxEMrt5Ms1LXmtzVBRTBUw
	H1gB3JQyM1X/IMTBn58IkcI+BN0lG3qDDSABnG2Jhg8J+xN0zPEzxnTLfNikn9gHr4VjSE9H+vL
	qtRwuSzSophFUz0HmCPqhKBcRv5Ejt4P9myguztdNBTfi+wctgz7PKYDQIdT/N12rRAmIu4+Fw1
	ABo61EB/f7bkvXWDao4lbcTc9oTW8kb0iVmmFnmH9tRj5P0qdDXMLYSsOETe2BUgH/LkgG1xk/+
	MyWtxCXWbgEKhtczwXmAa2G53/CjMFObUs+wreJ/rBdnmo/yB5Xd80J0SAtHYfPyCTYlN1j3V/A
	EAQtZfGOYRDg=
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id 5b1f17b1804b1-4b3ad9d0e48mr67987735e9.12.1793780489447;
        Wed, 04 Nov 2026 00:21:29 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cff3fcdsm35490905e9.11.2026.11.04.00.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:21:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] lsm: put the copy up creds when an LSM hook fails
Date: Wed,  4 Nov 2026 09:21:28 +0100
Message-ID: <20261104082128.3573690-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Chris Mason <mason@kernel.org>

security_inode_copy_up() leaks a struct cred when one LSM allocates new
creds for an overlayfs copy up and a later LSM then denies the copy up.
One such pair is SELinux and a BPF LSM program that denies
inode_copy_up. Enabling both LSMs and loading the program requires
root. After that, each denied copy up leaks one struct cred, no matter
which user triggers it.

The hook calls each enabled LSM in turn. SELinux or Smack allocates the
creds and returns them through a pointer argument of the hook. A later
LSM can still return an error, and the hook then returns that error with
the creds still allocated. Its kernel-doc does not say that the caller
owns them on error, and the only caller, overlayfs, does not put them.

Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
and chmods by an unprivileged user on an overlayfs mount left 36000
struct cred objects allocated, which kmemleak reported.

Fix this by putting the creds in security_inode_copy_up() when the hook
fails, so the caller gets either creds that it owns or none.

Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook for unioned files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: put the creds in security_inode_copy_up() instead of in overlayfs]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Paul,

I think this LSM hook was introduced with confusing contact for chained
LSMs and this change makes the hook contract more sane in this case.

Thanks,
Amir.

 security/security.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6583d5073959..ad382afbff271 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2314,18 +2314,26 @@ void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 /**
  * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
  * @src: union dentry of copy-up file
- * @new: newly created creds
+ * @new: newly created creds, must point to NULL on entry
  *
  * A file is about to be copied up from lower layer to upper layer of overlay
  * filesystem. Security module can prepare a set of new creds and modify as
  * need be and return new creds. Caller will switch to new creds temporarily to
  * create new file and release newly allocated creds.
  *
- * Return: Returns 0 on success or a negative error code on error.
+ * Return: Returns 0 on success or a negative error code on error, in which
+ *         case @new is left pointing to NULL.
  */
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, src, new);
+	int rc = call_int_hook(inode_copy_up, src, new);
+
+	/* An earlier LSM may have prepared creds before a later one failed */
+	if (unlikely(rc < 0) && *new) {
+		put_cred(*new);
+		*new = NULL;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
-- 
2.55.0

