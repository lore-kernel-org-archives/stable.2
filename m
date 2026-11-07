Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047159;
	b=VTTyCh/gtVL8MnqazzonYZDUL+LIK9nazaavUUzcyVedHw5L9uUl4Qc2aobw0s6Xegj+
	 3LzqeABnpb6EE0NozTGYTvwa7tLC6gW9EFV9IiltW0EvEg1hNeqQnSZb7HgPyM/WeLfrd
	 C1YzTDIr+3FCdHckt5EyaDWmrxTE0rkbeDL/LPflKM0uEIfgWgrW+IXz/Or6LrB50PVz1
	 u+9xNIvtTj4Q/88AE3YJP8RIPNi+6WP387hNWKxMYKWARlLe0zLvShBnRUtTxS6dF/woI
	 IDpAvmXJPK2NxIkuwr+7Qp6427efIRthJgAStx0xQidFA/h9UUQMqOHaIxXBSqQDkzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
	b=cmbYRksgiF4YQMMcqRFlQx2aVRRYLdBv7kWxI7xW+1JPcoiZFZTfaxgVWu3M6nGf1+RG
	 +T2HWNbf7+bis014QipYdD8DMgt04Xm+zM/w6fdKAQbgMg7roBvo/lIizxmh8iLyfPILD
	 cGtc+BigIK4XDJS9/3pweHq9nlCVhH22Kn8KfJx/tKGBe/AjQX8Uqs+lqntpA3eGr8Im1
	 hFTrf3qIi4MCYv/GAIoPboMgBKrAid9Y8NJhXdDsdWSh/IDq1Z3cMDChPjJn1dnHQfad4
	 5/l1QD3+CWxJlSsEdQ+n8tX/RcZeHfkrRUsRxuBjMHgYbPMyLNteWUZUkRLHydPYcvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBdh8iPP;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9A606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A9A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBdh8iPP
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd3310348d2so150127a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794047158; x=1794651958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
        b=uBdh8iPPxh7WomiEfzTY2osL0T+VlcuAAKoibyb5LRkVlhERGFHzSR2+04VBWRR3Lv
         ISdrSLOiy/SVIRDzf9L9csYQh4Xxj9l3qdogTSrrMZ8CJaKLYHMSiQhpVOzMgo3nvxky
         UW7CHI49A1zzcz8AUGGVlpcuPO/LbVCgUPMZbC2eXW99RtNRwabBp/wz4KGhyRz/EGwX
         2UmVnevy8paOcXpZ3stRsCsu6NQGYnJCeJgvoQqIi9FdEHFSrnH/PuU8Bi24rPVxb3c8
         gD6fdhk1W1/JzOgKxVj4GJ2YJGZ9lWkrQsDNALhzVKmZMe3Rwdm95o9QnRCUr3dT41RK
         Z/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794047158; x=1794651958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
        b=HFFXxNPqDFEBOHOtEj+cpKNujQYrCR5IprWWzfb8FbTaGOjulwCDdDhf8Fo4jCZ5BD
         22KTYSn3nj3BPc48amL/aEIplna8JiJT/lle23GCX/FbDqVsrWZdgssKIduKWBI8gIhm
         hS4+uVJsYBC6S8wSFLOWvTly68faT3mcCOWbsDBdWHvKLaIrwVHmgRirWTqXEzCbedqm
         El44Cy1EQF2Z9seEEAcK6Xbdwmsrjp/iswSXF7aVttEg7Vj2wy5iSznVGM/o7e6LUVgV
         ERF0bVW3TdmOaDCeSqaD8YjBwegUB7rPDFkBXtoT5EvKMHnXlldT/FJSPu9cKpddUhR+
         Y2eQ==
X-Forwarded-Encrypted: i=1; AL+hErEw4V+PElcIok5kdlneT4ph2Mfa2GuvEKPpFI9mtoKLj0K36kUzCv5bEfuu66VPRrV6T+9v2js=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vwGOs76O7DRid1awpxFqxALQSGwd4Fo8YyeAIJuRpc+SCqvCS
	Oix1dovuYBlpASzDgsrx6bpfEu8fIKfgDbi0iDSU2e3geKq6DDuMKqav
X-Gm-Gg: AYBFou3ljnIafGXey911AmPpjPNG0P3Ijpc7/RcHHIwhfi2oSnyJMQ8GFdFMGx6vvGP
	Q7UAXV11M8D1dIlvVgKYpWuOpvvTOoT7//WNRo9ayVS1dLClKt5iHY/gmI5QTO1xJjXTI6ReeW4
	UUiyNJhLwc0D6Pe7NicOi14P9CxtDMseHqIl+sz+w9I/W2E+qFlp+cR8dYrK2DdjFK4RW1/F6If
	MEGhW0lqAJzvSCzVOVtVce6pHRycV81UVCXJkAYSdMyLk27eZ+l9GcMvlJwrv9LGH3bmMKA2XJh
	GA+CS4YTKkEyHe5ot0wPPIoeyj960Pbk+8pTQvpYzXdrULdyH3hbHA8QghhkWbw0YipeCyoPZww
	6n20Dg67v8HggZ5D8YUljWmnIDuCjoW2R3LU6ZHwe4iig+2V4HE6TUucttpNNcLb4BrHY5+omiL
	NSWPIkrWufae8+Uiln4pEeswmtgRT0Fe5WVM9wZKCfIloI1XJlAJKsjAXmrwK4as9KbJMki/SdU
	VNNfXopO/owdmVaskX+9xGfT+3UIE/H/43pZ9A9w8CEimUe9MMMtuhJeTk3y6qovXznyGn5mQnU
	ZtE8kf+M96YSNfphIP47lXECArja7ELMJhOtsI6jz/8zUT1u9021gw2RSJH2lbyNlCMg/CNUjI7
	8sA==
X-Received: by 2002:a17:90b:3cc6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b10659feaemr1154902a91.37.1794047158052;
        Sat, 07 Nov 2026 02:25:58 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1152fa888sm207764a91.9.2026.11.07.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:25:57 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+c85e76ce40a43b9b@bugs.sh
Subject: [PATCH] apparmor: safely acquire the cached label in aa_file_perm()
Date: Sat,  7 Nov 2026 02:25:35 -0800
Message-ID: <20261107102534.816756-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

aa_file_perm() passes an unreferenced RCU snapshot of fctx->label to
aa_get_newest_label(). Its non-stale branch uses a plain kref_get(). Policy
replacement can drop the proxy reference after the stale test while
update_file_ctx() drops the cached reference, so pread64() can increment
the label's refcount from zero.

Acquire the RCU-published label with kref_get_unless_zero before testing it
for staleness, keeping the label alive while resolving its replacement.

refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130, CPU#1: AAVICTIM/5091
RIP: refcount_warn_saturate (lib/refcount.c:25)
Call Trace:
 aa_file_perm (security/apparmor/file.c:657)
 common_file_perm (security/apparmor/lsm.c:529)
 security_file_permission (security/security.c:2392)
 rw_verify_area (fs/read_write.c:476)
 vfs_read (fs/read_write.c:566)
 __x64_sys_pread64 (fs/read_write.c:770)
 do_syscall_64 (arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: bce4e7e9c45e ("apparmor: reduce rcu_read_lock scope for aa_file_perm mediation")
Cc: stable@vger.kernel.org
Reported-by: <co+c85e76ce40a43b9b@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 security/apparmor/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 694e157149e85e..59c27b9c5a8d15 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -621,7 +621,7 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 		 u32 request, bool in_atomic)
 {
 	struct aa_file_ctx *fctx;
-	struct aa_label *flabel;
+	struct aa_label *flabel, *tmp;
 	u32 denied;
 	int error = 0;
 
@@ -654,7 +654,12 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 	}
 
 	/* slow path - revalidate access */
-	flabel  = aa_get_newest_label(flabel);
+	flabel = aa_get_label_rcu(&fctx->label);
+	if (label_is_stale(flabel)) {
+		tmp = flabel;
+		flabel = aa_get_newest_label(tmp);
+		aa_put_label(tmp);
+	}
 	rcu_read_unlock();
 
 	if (path_mediated_fs(file->f_path.dentry))
-- 
2.56.0

