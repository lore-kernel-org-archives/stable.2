Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB1432BCD
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039190; cv=none; b=HGhamfS6UcBXaVXqwXi680VpKvDBv0/KPTHioP7htrOgf1TXFA7dG5pvDbK2dUW4rV/IGtmFXJ2pylMd0SsdgwV2yr6rZ21AMW2slL6cRr8hYb/eFmMGnjUTuVKhZdD2lR/BqBeP4gIn8dzGZGE064qb989n2WEFMAFBMrngef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039190; c=relaxed/simple;
	bh=LO1QiG+tuqYXw1xkU6kH+n25tHtzPNegmiTgVWdxIs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmgIeQPUGbyvDFbK9/jeJ0z2KFoPH9dVef8gy0xZyiJ7rquKXxCWoJB+Wwl2d8+ZRIl/BjjUU4UlPXzX82dOHCD2KAsAC9ldWKd9aEiaDCVm1lIzBzwQTDUc90xQBRv3q54P2s9wOtMeZcYNqUGTRILP6pSC5RyFO995gadsL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5pzNf96; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5pzNf96"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436216a98so152671f8f.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788039186; x=1788643986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPdTmo/psYzNVIunLzBuzuNQ62GIR7HvuoO8VwCkzsQ=;
        b=l5pzNf96MTYV8/moSN0WI9ZuXaKDZa5UHbuy16V1DyGljLFlTwV1CHBrDnvAO8Qoc6
         e+C1W9+hDhu6kCQH3ubu3UbQZt451RX8Ep+8ULGqms3kUVVwTBHdILpGtJiHJGnZ8pwA
         35c/HQWRfteLGTcX9XtWAkMXAJeeDsJf4Y+UrLVhUm0chhLm/uLoeHpesdV8dIhJj8QB
         c9vj+O7T8JjfDTo050/B90yPDpAuhcXoSR1NbwafUI+pCQDpkYTqCc3vbnMuGgeJ4X7T
         Meekeo+ASAzUBPAG4ShXUu7sVEjvZ50qmnrspoQHEWXGwh07mTlzE68n0o0+atq/FLIK
         oAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788039186; x=1788643986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPdTmo/psYzNVIunLzBuzuNQ62GIR7HvuoO8VwCkzsQ=;
        b=I2nLVP7oPFlRp20bNG1SIRTcBiwH9puCT63z9+QSoI4H7Pq9LA0twvW8Tytscmd1VJ
         XHZiDZMlN195HGkcjhj1PDCZ5gElTZrnrqlsNgD9oNKnPIGMqKrybhJmD994T7mc+7MT
         uyYiNIFGIv51qeuH3Jqdt9E7c/PtyIc51eG04czrjNP5di4peMoiMhbOgDq3EFTYpKSc
         qL9E4cyjB3azzFBzXsWxqPg3ltbOKP6zoyxCJJrXmwab68k00a9byl8nzy7pXurBHL8T
         tK6EKOPimd6g6I4+qLOtBNbM2Aywoeasc6s1tC5/9bAu0DKFiwixCWPU7GICvXHfykGE
         tU6A==
X-Forwarded-Encrypted: i=1; AKwUvByyJQcSEp5KylPrjrHJqlLH+a0DQNV4GgGAP//hV4nBHw1mQTzzBPxeAIeEOzbRhBG/gUGdIjo=@vger.kernel.org
X-Gm-Message-State: AFuF++keQjRJ9RwGzw0zudV4ezGSFiZLSxzQnZ0GqDjvVdjPn9tqD6Cd
	w4/rnagXRtceUJiZtY68hZ5UMgmmBfVpcXNY61+vRBwTjL2SD4VGL7x6
X-Gm-Gg: AYBFou1m0Jd0F9KmiFY50hplW3puC3kvtOpJKJQL3nIqR6LqnKsJUwH1naazB75Wqd+
	mbDXLZXkOrFVaOJvduzaj48Q9cvHDIOqswQr+97ypOFBH/wAYfiSeYW4VcR1SHsdwTZFHRn5I8J
	mQgJSfQ36/0ul3AuhSyZDxukbnje6M+ei8xwjrgW8ptDSb1sGU6fdFdIKh0hmAWODc1bCx6qaC0
	g9Tu3oLiaUAwC095q9b5zMJY091i92EQD/tmg9nGkCKO0O/sqbBG0/oUxefbnmq40sRSKjjuUGI
	MFgmyK+FH5jO3K63kaaMZAiIpBo2b7CYGNyHuBW7xoIiQPd/TnPM3f3JnerxcKIvDQ4Ffqt7Ww9
	Y2OK44bMo5DLGd9vELEYz5ChnnlWddKdyCZKY+4NhVBy4YwBPYTn9CmWa+DcSEqCknRfGeCFJGq
	1IAf/Aj1c59YD5EHzNjSinG6spqGWR2YD6tAaID9jHH3Yh2HAgfNyzlvs5/XBj1QBV/iykGRbFB
	vxYnW6n/QWrg537SaUNbhG9U3XzrsDhl7796WLClpjeFnGyNLmlUa0SbqP1nPiYq5uV0/keGYwC
	biGoRcZg1Jlt3cdiFTkxDV8hun2qJ2OOVH89B2a7EKBkMvgdamlhSsqabrMWeY6F3pg=
X-Received: by 2002:a05:6000:41e9:b0:484:3621:6340 with SMTP id ffacd0b85a97d-48436216a9bmr3184979f8f.16.1788039186041;
        Sat, 29 Aug 2026 14:33:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm12540616f8f.36.2026.08.29.14.33.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 14:33:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] selinux: preserve user SID across nested backing files
Date: Sat, 29 Aug 2026 23:32:55 +0200
Message-Id: <20260829213256.51527-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260829213256.51527-1-kmehltretter@gmail.com>
References: <20260829213256.51527-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SELinux saves the user file SID in a backing-file security blob so it
remains available after mmap() replaces vma->vm_file with a backing file.

For nested backing files (overlayfs over overlayfs, or FUSE passthrough
backed by overlayfs), user_file may itself be a backing file.  Its
fsec->sid is the SID of the mounter that opened it, rather than the user
that opened the top-level file.  mprotect() then checks fd { use } against
the mounter SID.  This can incorrectly deny access without a domain
transition, or check the wrong target SID after one.

Copy the saved user SID when user_file is a backing file.  Keep using the
regular file SID for the first backing layer.

With two nested overlayfs mounts and SELinux enforcing,
mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
mounter SID.  With this change, mprotect() succeeds.

Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
SELinux policy.  The original test was also repeated with Fedora Cloud
Base 44 userspace and gave the same result.

Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
Cc: <stable@vger.kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 security/selinux/hooks.c          | 9 ++++++++-
 security/selinux/include/objsec.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1da..232b7e7bfcafd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct file *file)
 	return 0;
 }
 
+static inline u32 selinux_file_user_sid(const struct file *file)
+{
+	if (unlikely(file->f_mode & FMODE_BACKING))
+		return selinux_backing_file(file)->uf_sid;
+	return selinux_file(file)->sid;
+}
+
 static int selinux_backing_file_alloc(struct file *backing_file,
 				      const struct file *user_file)
 {
 	struct backing_file_security_struct *bfsec;
 
 	bfsec = selinux_backing_file(backing_file);
-	bfsec->uf_sid = selinux_file(user_file)->sid;
+	bfsec->uf_sid = selinux_file_user_sid(user_file);
 
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3c0a16ec978b0..853f7266ed189 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -87,7 +87,7 @@ struct file_security_struct {
 };
 
 struct backing_file_security_struct {
-	u32 uf_sid; /* associated user file fsec->sid */
+	u32 uf_sid; /* top-level user file fsec->sid */
 };
 
 struct superblock_security_struct {
-- 
2.53.0

