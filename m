Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F71364934
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529408; cv=none; b=oUHHPLDbP86KsL5FPenjP+rnHwy4uP+17/UQhB3vLcr7vbPyirP94ggevZOxE42n4l8pB5oZPDdVv8r23KfZaz2Ra595tp3vC8USgFtZBFWSOXyGZBvaia/+VAhh050HKvux/ky0FkmGKkNm7D1BtzO1q6Sy9pK9fvmL50we1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529408; c=relaxed/simple;
	bh=hUkGjqs6qcYuVfKb4FdP0YcKEPyEotgH3ArbHxEaHSc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=J/pOcYvAtroQdXOy3zxpf7X0EgLdKpbEPnQUvBmk3noK1QBCIL+6TMDwk24v7Cviys7FsTgY7mAbA9z81KR0AbiaL24A48VPZW9cJb8peejnRRHHyjplFuLnbvEWsXoN2S2ANxLGn+GQwGd73p2sEZ3/YzX4qdBeXyGhSiKtFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hlpw/N0H; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hlpw/N0H"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0299c787so36366485a.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789529404; x=1790134204; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=Hlpw/N0HkHsQTYtj7U049Cw8JPDLlHumzPZoCMRvVh47ABqMOdKmPjM/3x/3R3bKBO
         HPYs157NAxLqMOkhAMr2Ta2nSZLPD7YObYHyJqdDqTOTlPlmTwxtC2b2g9pYqaGuhEtK
         6ikSZnxGyzN9HhUvPjqqjnENe2HJe57yFSgPmRRS8TOc0dkvWxRW142W/TKz4GTu4ydT
         R/DgB+IeB/0q4CS9LvEEPQsduNBFZ7aMdxBiesFkoWEZOIAjEhwyqbWzvASoni4zjgOK
         kLJ9oQXTHDilMuHbvuc85vKEhw3XW9rpt8vfVEbxcZOyryESZG2ogmm2hj++uWprY7QO
         Yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529404; x=1790134204;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=hl5b78hBnavqF+k+ZDfrsakqeBuFnNTCFdwwdqenS41F4LlRZo+OWW8IZUEs+RqQD2
         Lj7fE1czvLC8CVPhwp7505JEpHj57OrGshk0SR4rqbIOz1nJfHau3u7glLzY96bRYJPf
         dklaKVACNOnWCs5DGFYPvN+MjjAlrOWWoeXWzLDVf3p0FtdrBG/c7mnY70TjKZ/kKgdY
         9g+jClAP6rj/fFcZEd2pSkY6EzDOcgOsral5T0zTv3iaRECYNpeu4WSvyhGFgaa+s3i7
         gZtDIgTSVu2UFWBM2KurXl89X3q+9BwrWAuxmD7wHioqtoU/yciygtQdwJlFuIG8O7u1
         +Uog==
X-Forwarded-Encrypted: i=1; AKwUvBxLk/L+U78hka66ycOp5dCA0zf+geFZAJLcjix81azrMZtXAa2rReAL2GUT6EiUEq288t2a2v0=@vger.kernel.org
X-Gm-Message-State: AFuF++m+YlZZHFC7yH1aB72498cCKb0+tjxwnbPegdWelHdhc2lZxhad
	4Iu7RfxUuemihBftLeyvEItqq/YA4ouDLJj+TOyTL7F/irI9W+7vcCkG5xFaPbAwUA==
X-Gm-Gg: AYBFou1jocjT1/EKbil92X8RwNDz5yvyDF9hhtTadOVcTYS4Q7/kYqJV8d74WBzVk+o
	E5oAwkvfLbmFrAV358OqrHNJJV+zeoN8X3SbcruvrKPe7xkRgFwDa5MZqvu9ce8AG/x6l0WTRFd
	28Ou74XjW35DVYX4MGiszxUg0T6cCNviZup/N/VFkX8Gf8iHrkqqQ69u65Wl3Vr+GdkAo6po1T0
	C1dVOehzwiDybJaDKOuhwWZ6XEEX0U2K9oU6y75Us5evZ8TOhNJAEmc2RKKQnSqM3JBk0U2OQQa
	gC3cmG/VOp50KqvGQV5qB3VDw7GuuiTMzERo9+rOBygdw3lp5BBntXkrfE5dxva+D6J/S9RcjWM
	REeM8K95SimfQnztWnaZ2CRMCgc9NcVnAwynzaF1w8tYHQia7KgqKbTharp61PV4cxC9RvZS8Pa
	ZbYJSj/JvXMO3LQ9EyHLgMN0VSlYHftGX6ET3frFe0A9ei7NnrpKpqcMNnJr6k1Pz1xWd9rs67Q
	+a7vCZBVW+ugZyARSGJfiFKx4ug5ukJqjk+9Y3fbQNsZirf1NQR1pKa6h9KDq7Cz3bUuyTLafrI
X-Received: by 2002:a05:620a:4709:b0:939:35e5:94ba with SMTP id af79cd13be357-93bb766747bmr170559485a.6.1789529404169;
        Tue, 15 Sep 2026 20:30:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be648e5sm15710696d6.8.2026.09.15.20.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:30:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:30:02 -0400
Message-ID: <d852b4ae61860446e038f69541f36f9c@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260915_1728/pstg-lib:20260915_1318/pstg-pwork:20260915_1728
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing  files
References: <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>

On Aug 29, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
> 
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } against
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
> 
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
> 
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
> 
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 9 ++++++++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Merged into selinux/stable-7.3, thanks!

--
paul-moore.com
