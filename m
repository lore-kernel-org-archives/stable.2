Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14373D952D
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449240; cv=none; b=KDwGgQYwSTf51lLrKcS3/wBqNOKEIh+amQjndwtCwe+LpUG1P8Ddr6qmSCL0JihTrvQpmRWv7RDz0MViZABqDgWe4Pq4tiU4nPMWJQhJruv878cWEQtqCfF16FxnysJh1dwgsBV1oAmaw4tsgI7bo2yPtWZud9GuldX816ngZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449240; c=relaxed/simple;
	bh=hUl2zOVyzUL8lT3SiYapCjovg+lHxQaZIYKJ8BlXglU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsBhelww5xdLIQS/oDy2VwtL0T2KVxztWuasEW8OpJubagaJ6HSn2I7feQSwypra1xta8GPq73iWrQhX8wemJ6MFBeRUSiHyLj8Zaw4JCIABBP/utyL5vckrpVu4adQxlsMkTAsKDNlh6aYE/boT+mlwRf8qj8JFEmTQhKlRK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXKviWlt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXKviWlt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso37415ad.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449237; x=1786054037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=VXKviWltygZBhIUkoOLT7VHl2k2xtoKQag7xfM1vfgUpf7y/3JnAbcn8oJKtYJHmN5
         LSyJKaTY32D/ChgDDyundLtIVjDPBtF5NBEqkABNORv4UQeqQE3YX8/tZAKalcxLYzpr
         7alRMO8gO1XZn5M3o19A93TKYIMJotzA8LwitqV8Jup8QLj13ohXkbOVfMhdRxHzRzA+
         PNMJ9GZt9s+rfXJbrBV6xjuffXQgg3J3RwWXMBLKjKRuT7BfzuSX05+jsoK0OkFVChtR
         LKzgbp8Yhx+pBDrGvKqCs6hnaqMuUSjsdN/nSXbm8ipuTNbYWdd/7Jnz+jAAX4Msc+iL
         Te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449237; x=1786054037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=OK5dFvNYyUN6qKvUSpztPYlVjpn3rVn5ZGLwN1jrlKva6cnvRqQTKvHA1y1rWc9IPD
         V63ADipdcxNUNk7IxMPuJ8XuCkyy0bL8ZHO3dMEHvwz0PSqhdKbzaSeBBX1JN7JjUjTk
         LHStUcOQZNY0D0j7FUk++DheaEP7Fb/25mKaBocwOMFLdk17K+qGJ5mUieK++Al5Ryho
         wX0Wh3qB5mN18R9EEwj4g5DeNwzVDUnJtZLIqREEuJCu90SS4JU1JQpn4Ob+Zhy5YLNA
         fdMgNMGjilzAvQPEM9BrB99kKpAbgB4IAht/AnsjWHZ1DuztXB0uitQjAnvTbggOij7Q
         6mRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNKHd0/fs1ss+MfI9mymWFe4UPUXRqFVfSIq426xgHKarXxnMuF1yjzjB8W92+1/UeS4dWvRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TFVAcLZHHyItE23M0lfT//O9dM6I+Upi7yIljdwTMOLlUdXy
	gbGCyhmM74mvi2/S+uRDKeqwVMD0Pmj7zKV+XYATqte5PA/NwPVrqBp+gbE7Z/5Wjw==
X-Gm-Gg: AR+sD11bTnXmmJDNC3Fg2NN3G329GjclA4FaDdD+2sP668zhay6oqzWgJOsGYoymbVW
	LjoMyyPFtDQPuYYzRxgz2vawbw0h0m2Cel09U/2AeRkTHX8f7OQh/TJVSxu/8DOurO7GiXe1d/A
	dzIPj0/1rKVg8GygFjqiJhV6SMGjn51j1evirGYTnlkwuEFFjadr3D1Tg1wylg0I8wz9ZliDqq3
	zh3F3o2zFJCWmuKEky0EOM1bFeOrt0zGd3+PCgu9oELwuPtpHRLF0wirx/ng1vqHbqUUEit8/hn
	XQtpOOSoBUyDXU2uYXfq7qLi24BaVJQ0GUXsHdw3FCAgOY2hB6jRguxQROUIOeghLKGLxaUmnEx
	Nzmke7OU4WboLVm6UsIwE3dbgPeobSy5/ApeEDtMfgPoCEazkEEuaE7J6wknyeXIrbTVi51Z6ox
	93fNWEJqU2c1gSzABHbsw61hbPBTjEFpZU6KG3kkuzyrFFXSRfXGrQt38Wud7YXHjHNPW5kwkAQ
	xsQZd0cfW4BlfC4tPYCaj43KBS6eK+EuxJW7Ek5tT6fGkz8K2Gmwa9bRkKwPDCaKd/7jJA62R48
	0HqMWpZhJt2JUMeN0g==
X-Received: by 2002:a17:903:2385:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2d043edec5bmr1360785ad.11.1785449236599;
        Thu, 30 Jul 2026 15:07:16 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00507b0sm3691939b3a.14.2026.07.30.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:07:14 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:07:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
Message-ID: <amvLDoB4g7NMlf4R@google.com>
References: <20260730181008.3654413-1-cmllamas@google.com>
 <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>

On Thu, Jul 30, 2026 at 05:10:00PM -0400, Paul Moore wrote:
> On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> > 
> > selinux_inode_init_security() marks the isec as initialized before
> > checking if mount labeling is supported (SBLABEL_MNT). This was fine
> > until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> > where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> > xattrs) and yet leave the isec->initialized. This breaks subsequent
> > calls to inode_doinit_with_dentry().
> > 
> > Do the SBLABEL_MNT check before the inode security is initialized.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> > Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8d6945edae7a..09a12eb8652c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >  	if (rc)
> >  		return rc;
> >  
> > +	if (!selinux_initialized() ||
> > +	    !(sbsec->flags & SBLABEL_MNT))
> > +		return -EOPNOTSUPP;
> 
> If we're moving this check, we should probably just move it to right
> after we assign 'sbsec' at the top of the function.  The calls to
> inode_mode_to_security() and selinux_determine_inode_label() aren't
> doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
> cases so let's avoid the unnecessary work.

Ha! That is a really good point. Let me move the check further up then.
