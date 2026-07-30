Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0521449B31
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435018; cv=none; b=mlHfnrSM0DJKZrPA6QGdZPufIlB9mQjakQj5/TLQznUzZT0k6koL+3x142XyHmCvHnmc8Wn/CGcnua9hHoMw0QBzVgs9JPraY2lzkx35klyiHn3fWIDpMRcBi71qZb8+/SK25UIUXBOFolRtOH2WsahcO5nRbp7+pLYYHV6tfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435018; c=relaxed/simple;
	bh=j4uG85a/lUOWlekw+/37SW+8lcXDbeUugVTGhEIFrNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QbOSj1JSQiP7tZTZyeoO9PDJ2oqiql3BqzneB5dswSih7S0nDL4ZfVaxQxwsKNppA5WoB4p4pEDCsQz5SREbc9XP1ZxNpQxltXLOJGMVR1nlD5rBQycBOnU0hpEiHkiPK+2fKtWX8sRl9vRxjJsc7hqvnim4nziC7ft22CzfF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSsF5K32; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSsF5K32"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso215113a91.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435012; x=1786039812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J+SX8dpZwKLLQ+HLHdBpKmApVdFrMwrn1102lcbc08=;
        b=TSsF5K32AejbDCJcn/YMBtVjqzkong6JGX2vhYbaLeOHfH9HkOtH4up5GFBy5+S6hj
         j0Ncik84ofrqHEJDw0TXEvrYl2YvwzWAg4FOoyPh9gTwVf7B5Ffen91Skpwa4Y8KXI/E
         Lxql/Rb73H6IUHxNYRFEbsJoKWKGZHtqhs8EQ0qfBQWe3NDYUOmd295fZDHNcsC8JVTT
         2iTnq6LO3Eaz9WIuHtcbQA8JFJFiedfx0texYuMq+3HrUYUtOCiFGcgeWf0zvs7PUGfu
         Ps5SzA5e+eIKNYLamcBucKAB3J3LNZcT7G7KOlQMy+npBuSSYOCCXvHejM8a2z3wsclW
         qZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435012; x=1786039812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/J+SX8dpZwKLLQ+HLHdBpKmApVdFrMwrn1102lcbc08=;
        b=hwC5BkgQHwFCHsXJw852KCmHXJR80d7ziPPFiXhkwz9wyIMYFykqUXHr5A10Rgryzl
         OvcqzDkvo0RBjN/pr8A1yvZMUFOd4iBOUwj7w+tD5DvM1FlgVOS6arHwcHJNtkRfc2nD
         QEwy0UJSIV4NyrjypyHB/+cbw7PikSewyqo5pWYfKlJ1Ifm6p613kJy8LqiiqvhKywqi
         lAT3rcflsJrYD+iSsgcSdW9gBVjYRd26P0vE2OGL0+S+tuwJJm2Wb2LUjrivKJXJ6p+T
         JJUdxMGI7xyALfemmiI1A6Xio3JCvFTSAZdrW5AkZq431QO7Pxmo7AimGYF6ILl4jCHF
         t3Nw==
X-Forwarded-Encrypted: i=1; AHgh+RoQ54Gwy638r6eR2IcgKeTij+DilTcW/diAPw2zimmSMTkNzl3kICJ0LOTbnOHNL1+EIE/8s4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3BLaRhx4O0DK0rvnkDB0wiEQxDCLEFR7O5xuNTm1EYCqk1N6
	PRs7LUaKh7Y5VjMiDkH8lMy6I27Lgir6zVubVOob0m93UCQ4lf2rr8NFbhaW5O1zdzjngRS4cLC
	4xmXXXNLjoVJzaA==
X-Received: from dybvk8.prod.google.com ([2002:a05:7301:53c8:b0:30f:45f6:de06])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4b:b0:38f:c71:2342 with SMTP id 98e67ed59e1d1-38f9c00dfb9mr2757140a91.31.1785435012102;
 Thu, 30 Jul 2026 11:10:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:10:07 +0000
In-Reply-To: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730181008.3654413-1-cmllamas@google.com>
Subject: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

selinux_inode_init_security() marks the isec as initialized before
checking if mount labeling is supported (SBLABEL_MNT). This was fine
until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
xattrs) and yet leave the isec->initialized. This breaks subsequent
calls to inode_doinit_with_dentry().

Do the SBLABEL_MNT check before the inode security is initialized.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d6945edae7a..09a12eb8652c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	if (rc)
 		return rc;
 
+	if (!selinux_initialized() ||
+	    !(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = selinux_inode(inode);
@@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized() ||
-	    !(sbsec->flags & SBLABEL_MNT))
-		return -EOPNOTSUPP;
-
 	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
-- 
2.55.0.508.g3f0d502094-goog

