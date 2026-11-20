Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160240;
	b=y/j0vnDVVCvG4Qe3eUMfwFbb0GinGtRNCMQSuzbHM2jQsstUxemJ2vV1wVmXyEkgmh1e
	 NRyFosGahd4sm/X/7x3KzV6BA84HWy+tHqtgShD9iUYpEPb2QSOtNS0EI4K8ozcMLjMMc
	 MhjcrVO2EcUULsNQvHP1U89ahBg1aeqGxliby6M8QgPZKGD4PeNEIZcwEYRsB+mZ3Qe3C
	 COOqNnK59qSgO4DGivd5zGu52KU2sKxTNMJA080WGTOOh0x8Z3TXhXazDN1OQ4AHEnhad
	 ilEaey740Qkt418dfxxqIxTPUjys/uwXTkxSxDzv/ZalxEEVAyBfwguObRpA5BXr0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
	b=00coycGlKspl2THtx92HWqcsX5osuaXaijSBI2eOBWC9Qc/EEhP1xLOLeKPW018QGa3V
	 kAwmjw+YwC43fMhV4DipnXDgf6swJiGtFzJcGClqbhARNuc+5vzxvz5F7ZPs+iRDrNQLs
	 6okrMusVbJ/wpp8226WLTg7XmKO9usJD8hNt4m91+ZhoRbkYE1TMBqEJQD3V6ljr0yh78
	 g41ul8mntjD1oMR60qi+EqToFg2aiOMAJigAg/l7NM7b20Dm02nEzu9Py12ajrulpk1/v
	 nJ1DoM8vbVQ1dm4asu715/jbTcnuosTvfRx8jbA+lp69wD6JlC8GdzotWTQwanKmcPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hceukMgh;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908B606A331
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2908B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hceukMgh
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so740733a12.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160238; x=1795765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
        b=hceukMghY7le6BIvmBla2eFNVCQIbmkpOBHR0Qmni9s9Tx5CJJVqMf3vpfilPmRW5G
         K5wgOLsqd9MAS1z6OmEN/CrYQRV9tFx2RXS6txqkQxbbd/dKWCfmrVKOilSn/zmap3b1
         YNsLVgq+Vm8OssuoTDaCUB7VlZ5YhvYFA+SIyOP0/6fykgUwThttvdaJNRdt+00yImGy
         +T4jsEnKlm3k7w4G0FPANL64WVx4J3DRwpm0UjGciS6HVC6q0moeniT6KYlLWLNDEAVd
         f5BhGFbkXk8GTLaKY51IysD3Ajx4lCQI120uvi9wU/CNygHwZmyVXAHogmXGeGP8PVSE
         HcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160238; x=1795765038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoorVLMi62FuFQRrqrflAmA+uFRRnvjjHFtI7v/dMic=;
        b=XAldRlVl9RaEQAxtZHDTg9HnOTUdJzQfwlFEUrhfueh9JZXfkzT8H+UePExGYyphtf
         UIWF2VBSWGuB5s/aax5CrPbvdwU/fDXPzx7gdB528h84jbw/3gJaEMlskenYiDNmQz2Q
         MSM7RaOF+2REjtYPVwWXq9lozNWhniqGDV568Ph8obgip+AOdjAT/LqAoODVp7pcgLWX
         WKQqYjQHr4zXSQoeAwpA0wgiMwh4ZrRom+0OKooGZFDawbrVIMlQOCKyCVkwS0/YYyLO
         cObZeaTS8wn6IUeLb+517YHLKP77S2HB/jaZ9Ax4Npd0it2ODtdzz+4nOjJUwdt/8xAs
         YOmA==
X-Forwarded-Encrypted: i=1; AL+hErGbybGghWXSQrEtRX8QpLXRnMbts1tJwXGFhxar8XSH/k8CnwoC/XAnEYBLGY+isDParitMTt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MSrU4gX6mog6iXaM0Tn9ZWICHJiUXN4jrkEz/zPP56ZI/9wEy
	//hiPMeb2d+1DnEE+eAO+vT+Y3MvZBQ1SDGQuMVhQOS5pFiEdPTNBihQ
X-Gm-Gg: AZFdTZdrh5ZXSGZy2b0JQ/i3VqK1FwGsL+4ahV2BvdFTKIsOoG3ZJNaY/O2fYdo0Ppq
	ErOQdtwMc0V3sZEtAre5/tBn6PDKl7ICgt2vnOFhjI9o66+gQ/tT54AqWuGx/O/mpCXB9/fBJ9s
	873MkjsFCQN1KHIquYlWc3WBcX9hN/HrTYh3UnzF2JTuXigHqDc63jbw1F4f4sS/2YXwpVziMjb
	vVmnn8VTyw3/gP4SYB2SWyl5Y9tgo1XvbY7PZBOQQtf3f8GMqxV2mQzaaEBAp3SYJmSi1KyOts2
	ctECF1AWfmnYGm+cI6HqhTb0BNldP3Q41AZIaHYABTL/2lL2HDoJ/m+ICf686fRt2ppBZvSIYvc
	UT/VNclPr7Txss5gWadgDWrr+jXQ2oDdQ+AF4F8GeNu5oUylx+GKFHOri2tgjG6ftvGwJaKUXOB
	FtEs7NqvIvO7hFXiB3+pqws2ixdyYgvwThf2QP7SrTRcbYFfEGLMdWtGYivBd7NJHvqku809t5Z
	h3PVv6TwLN8pnzOn+mmorVxZxFMlKpAdxIUY+ygRX1eOrOY7HcH4oGXV1PhF5G2VCpMzbjVnz0v
	2hBnOb8XbkT5BLgw0lnjvnEEOmgcVLXb3r6+bO0+jFeTm/9ib85llEJb6lDlWuEG1UZNmRkVNRI
	vxqYZmsTfbfk=
X-Received: by 2002:a05:6402:210a:b0:6ba:4bf3:4a7 with SMTP id 4fb4d7f45d1cf-6ba4bf3066fmr408910a12.23.1795160238249;
        Thu, 19 Nov 2026 23:37:18 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm841867a12.25.2026.11.19.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:37:17 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] lsm: put the copy up creds when an LSM hook fails
Date: Fri, 20 Nov 2026 08:37:16 +0100
Message-ID: <20261120073717.1588080-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Apologies for missed the LSM list and maintainers in first posting [1].
Resending with proper Cc list.

I think this LSM hook was introduced with confusing contact for chained
LSMs and this change makes the hook contract more sane in this case.

Thanks,
Amir.

[1] https://lore.kernel.org/r/20261104082128.3573690-1-amir73il@gmail.com/

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

