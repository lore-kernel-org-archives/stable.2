Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DA481640
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859559; cv=none; b=FlcoHMiOlGAkqXs0dNcRn9pPBqaoQ8ixbdNDkGp+kDIwH38ECxftvSR/g53TlLsE0bsNLfcthlhMPx3leLh5nQE4QFPUVMsyP7REeJadhYbtv48L46NFqe2o2cab9Adwz37OHVxC57lIQdfUmq3FvY2XcjXvzWnTRRvckfNqtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859559; c=relaxed/simple;
	bh=iPf7ChaqIsVoGcvfLFkYqgjfgPL7ty9oLZe40l5pQ94=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MuyvYnj40xmg00V7RP18ma5MXvrWpsFDE4V6x/x8ehoCyFfkGmQQVT1GMjH7Ad3221PvmmQ27dwvX6WqcOWsZhCpo6sQsuuyW492bFJ08korfEquyMKSeUVoZmRAxbPY1/jF3wcxbjZy4wFsCITdOydOIIEMH7wkmnelQgrCd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M26My0rY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M26My0rY"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cbdb54616so1083146d6.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787859556; x=1788464356; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtXig1FMjrSYmMbsrTikOQfn2mLp1bwY+1B2vUa6dN4=;
        b=M26My0rYrgdO0gTlVMfWMdPjzbeHoC8fK4mejQsRtSNQDN/fAXdU6MHaC8hYlJ/tqH
         60FrO4apdelRF/SHafEfJmxkxplfMgI/Md+2iEf09zzupt/Zg7jfZI07nU0WDw4CMdlB
         ZbOfIjMZLPSCG48J0xZXlWR0mf0BDEKe7d6BES4LXclnbKViK3uuP/kOrsw5ot3AhD5I
         AMgXBRHJGfeWsVY+9mP7ND1u2wbnpvG4npbN1Vu97HknZFwhLCUJm/tCaVBlJkFgs1em
         gPSXnG9XE83PC0YpLym6+bX5tz8Pbb1eheq/DawaO4911KqNYQia/0JWrWn1qXPO+uMf
         bf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787859556; x=1788464356;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtXig1FMjrSYmMbsrTikOQfn2mLp1bwY+1B2vUa6dN4=;
        b=QYWZ+WKYSXMd123q3gBQDsJJhBC5Yi8EjzsYnrIwoUWAVJUnB2DOcppaNBfHoV+OZ4
         Gz06ziKo7qnZvhWPw4q/IOk4GO/V6rlo+B6Sr/wUmGkhFIsdpLmNQZMRdCI4dekYePaN
         CtQ8Yy+xEQpp+o50GHi9xOYjuQbAT8xR67s15j6fv+M+oqgzDpK07DIBG+OfjGcACj3t
         IMY7zYPrWbXBKkM2o9GA/aeSLGIZkYVNG/fgI/4L30XKdYq71U3OvBShXbLjIC5Q6OgE
         f0LhdnTHdd22/jlbGudnsfC8VpAfbw9XFXS/8UqauRG3DkbpZ5i+QkiaFykMjXBW+7Sc
         s/SA==
X-Forwarded-Encrypted: i=1; AHgh+RpdY+psPM5juoWE1hq91U7dv7wKTeJkC59oHX/KqfcRdIp5SIKIfe9ntxSDKXetOg101/8MDnI=@vger.kernel.org
X-Gm-Message-State: AFuF++kActs/cW6kAI+UwhhwE5TVwTLQ0uqPChOil3V8DnpdFRUJ9Xi7
	ik+fvyUIvxMqjAWTOQ30zxkd/cZfARZwZSi7YtufzMamk5PyqoR+9cn6TCj6RMnSlA==
X-Gm-Gg: AR+sD12kJ0mRC2Rw2SxBx2W/NAquZcXi6ftaZ2hdQ7Bby9tPK+ZqyN0VRFIQfgR9gzM
	yLiICpBbVYLGf2Rn38e9Ue9YcTaVmI2RtF6epCyB9ffM9wbPviYl/irYk7CJh5QOC7OwnWlRIKB
	Ltl+DIZ1GHZt6X4txzLSrtbIkX5BcqTbxUjCru4A4wYAUSh3DeC806/cI3HtD5CAWqEAgTK38Is
	DXEV3PfIJTBWahJaOzZPVeulbHUUHOCT/xE+oY7TkQKAQAQDh8fFlwYgG0n2+MYFXBUXd/TWj7z
	Vxs6qJS+lbu2k4k9zqQ4dvSrsOaNUcM8S/ITU+VKeRiu1yqJfSDjL+ljV09bPyFNrJT/fxEj18O
	3D6K0V2/qgmqgKAtRbgdtXM7wYtBdn/yWooXnPSRrj9I0cxO1DYG5z7/3jahKxjUuGyk8JH6934
	sneks0gBKxrYJnzo0L1AN/vXxGF2iH1gENMlMQgRacQuSIhp/PLwXMfOxEqCk7UErRTG4DHT1Dv
	nfYojmzXizjSiUNioLWWmGfO6OnMqlzmoYdLf817wuG
X-Received: by 2002:a05:6214:e43:b0:908:9fd5:ed42 with SMTP id 6a1803df08f44-90ce0f06bdbmr20681366d6.28.1787859551742;
        Thu, 27 Aug 2026 12:39:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73fc28dsm24026946d6.34.2026.08.27.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:39:10 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:39:10 -0400
Message-ID: <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260827_1501/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
References: <20260820175832.44512-1-kmehltretter@gmail.com>
In-Reply-To: <20260820175832.44512-1-kmehltretter@gmail.com>

On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
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
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes in v2:
> - Add selinux_file_user_sid() helper instead of open-coding the lookup
>   (Amir).
> 
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
> 
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0

If you could share the distro and some more details on the testing
methodology that would be helpful.

> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).

Additional comments below, and while this patch is useful in fixing some
of the problems (thank you!), we obviously need to fix the others as
well.  Is this something you think you will be able to work on?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..171b90412ff1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct file *file)
>  	return 0;
>  }
>  
> +static inline u32 selinux_file_user_sid(const struct file *file)
> +{
> +	if (unlikely(file->f_mode & FMODE_BACKING))
> +		return selinux_backing_file(file)->uf_sid;
> +	return selinux_file(file)->sid;
> +}

I'm a little concerned that this only works for one additional level of
filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
unreasonable concern that at some point in the future that number will
increase without proper notification or testing and we will once again
have a problem.

At the absolute minimum we should have a BUILD_BUG_ON() for the stacking
depth.  It would be good if we could watch both the overlayfs and vfs
constants, but the overlayfs constant isn't available outside
fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit).

  BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);

Ideally, the code would be written to keep diving down the stack until
it hit the true backing file.  No one likes to see recursion, but at the
point where this function is called there should already be a reasonable
bound on the stacking depth and the work involved.

--
paul-moore.com
