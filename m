Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68D3A6F19
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253181; cv=pass; b=fE2ftmcQ/Z+TIhZTTRRA4/i2LK8/UZRvof3bV0J0+ZlE3pXOQBQVDCxMhMogL4igEW1pgrj/DfXBt4GgeulYOtHQqW6boQaKfWZqckJc5vl6smtIQOZP08XiVAoLcmlEC1YTHdC8xUYuPaHpaiOAkT1hFKEBPJXg+diKwhFSbbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253181; c=relaxed/simple;
	bh=EBJqidiCcHqzIqgjqJGYqBp8ou/sDr6lv1shRSRmZ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2S3kXlKnLyuUjhs9mRZteDq6XvzUwCfnggS2PUXJSWOpETCCw+qYfzmj5ld6q5PQAq8FC8t58Vh5qVB6VXfEuC4o+Knybe7nN8SZA8RW/r8OQoihCuDppJKZyPQhmn5TIVu+cIseL6CU+PHdEZv7V3WUJfvzFKWqlugVzZgPtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjtxiRk/; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjtxiRk/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so499957a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787253178; cv=none;
        d=google.com; s=arc-20260327;
        b=MU4TE/yHk29qBKDs3SPlcyoQpULVT+SfU9Hl1nKfDUWCpPwE1ZZXHFh9gC8Gtvmkmr
         aEg/85J/OTVpJrF6CISrvo5y80PnsfG+0xIOeRurNitWOrGxOG7/VJdwetUtoYX4w0/p
         1BBarT2EcMOtatfnbJFfO4dfaBlPPmtbAbXZi+Oxzhh/7iU/tvz+CEyMCzHVC206uc5F
         nhDKK7SicoqYVV9JuQwTJr93zsRRjdbx8WO/YE7q6k+nkWyocV1CedF22o+G4NgQz+lI
         dk8IaJtwk0QRuq64ScfJ6Fr0i+NUQodTpda2IqjqTwzEbytX1mnjocR9RHWCgD7shMJA
         eUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        fh=25Ek/L3iyqnyyHevkuOxQ0OTvYCDQxLKcZhq2LQA9mM=;
        b=Gh8t8m648Azan4FzrY2ppMuFMXi3z7XAgEHHeisQEdti8bfamVm3hlko9zRcXAwgA5
         XS4pVXdKo7m8v+4vdmMxMyVBPWBvWAtDyBLikl0+mICvRRod5QlNUBkN0GZ4p9rS9W/C
         /Mjv8t4WuScxie6tknC+HvMn9p0d7unpC3uWnRnkCrw+WA9QQshvCvIYvK3L0+vBpiMp
         FDXja3zH9NBNDXtOlKSoh7qVO/CB6BLUgXo4y0Ug6IF9qBIVgFSk7l9L6kzW7b29xLq1
         dHu1Gcvja61LOFzWRBfwXSEhYGR5pkHyl0u6ywoYlTjJeU5VHurCblkhtPM6K2SU1xGI
         mmbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787253178; x=1787857978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        b=HjtxiRk/0YfnOV09MlXe0Pfo0XYkO8wCmAN59X9bYO1GQi35prQemChY4NLZhVlLw2
         HVS/N+fvbYBhFREreghfMAHH1z0MxyrHc3oeDxHPPXpPf/S9kp7qIXnxxqDeNK9hSu3u
         65FwLR7TslEzv/zupeh3ceQTAZTxoNnJGWq5LNx0sJB02AlKQzX0cTPs/c3fg1Z3QpRg
         dXhB9r46Pwvse5Qn2o3mQJfFsqtEA4i7BK+sw1zQqntH5xe9IDvwgHTW3ftE+3wIMVoz
         EMTEH82F4xWv0qD2sq8SsqlugnnMo7DhPN8twOZ1PemNCDBYnHrU5xwzEhF4jrdisLS3
         uP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787253178; x=1787857978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        b=p8pOGgPC8AEZsjXuR8mq/04l/Ub9AtOaeb/e/MPrhGgG/G2H6zcOK+xFUsgGA8ar9d
         ynLrgeq5EvOGNSyJq5h1QiKcZxC0EmjLtuHh6kDUtBK9PpXnG6RCPegzFoXN84KphDZN
         sFlxcRomlMrPmvFNRTYv9ugxDym0NbCYayau0AweKOCfr/mJYD5HpT/fb+qdC6/a+Grm
         JLT1mkF4IsmwOUaSx9DyLez+mkDoiIQXv0j4TdT/PHD4uJTwjbsQIa67uypqRZ8+ujzj
         lkt69MA2S6nDDzxboyCmAryf1JXSSIs7i5ov5WVBI1HCYRsIYKXkNZc0yUJ0Qht72duM
         x5gg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2ZFJph9HMfC60pi0I8hd82dnfEUoMRLV1g56IVCx1wAJ2F3gqKNp/umoVhiXwC2c3u/IbHbc=@vger.kernel.org
X-Gm-Message-State: AFuF++nYIahOScpv5GNqsjzk9XQWniHESR88+FQjTJZ/HOjmYPiNP9A6
	Tm0d5bp8tXU4+Z5M184M+noCLLar6QygHkSliozi1UJlYgyaHv0kJUh3FChqMjO7XUApIxbOFIF
	DoM9bos4kkJj5W2lx9/ToeCiWH07JZBY=
X-Gm-Gg: AR+sD12Ix/p91Wg9+obNnMneFRYg1RbsD+Lzo1YzTr6kEyPCT+YMAn9n9xoRIfdoXjI
	2hw8mbMt82eig3jMHbkAgq+dH7d2cTVowFmjObHq/NwdNILWgg/nS6dBJM9fOTnFRC3zgFYnnwy
	i/l7BZ6QlAv5e1da2MXGCw4W8qXR5sgytvvYYrxKJpZC+aon+HIOmoqubqcKQPC49/C9AdjqCQO
	PuNK9SEzLMgqrBixSEv/cAfSCZTtb2nbPom76TK4/GVMA5/IXCMZ/C962YtLz5EFO+ycD5NX6Vo
	MFGUi3gYQVKGbv3VNFQiBed/IhOi7FjcJhNnntR2M+cOww==
X-Received: by 2002:a05:6402:e09:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a42f14d945mr881033a12.1.1787253177867; Thu, 20 Aug 2026
 12:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
In-Reply-To: <20260820175832.44512-1-kmehltretter@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Aug 2026 21:12:44 +0200
X-Gm-Features: AcwNN1VoTb8-Y4yAhAEdExFUOY6_E29SmGdgjuOoDLFC6HRxDrS8gXBvh8R9q5E
Message-ID: <CAOQ4uxj+uFAR3YjE+XX98iJAdxNNqnaM6pptsqPaXnqJk4OXWg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:58=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
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
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

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
>
> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).
>
>  security/selinux/hooks.c          | 9 ++++++++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..171b90412ff1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct fil=
e *file)
>         return 0;
>  }
>
> +static inline u32 selinux_file_user_sid(const struct file *file)
> +{
> +       if (unlikely(file->f_mode & FMODE_BACKING))
> +               return selinux_backing_file(file)->uf_sid;
> +       return selinux_file(file)->sid;
> +}
> +
>  static int selinux_backing_file_alloc(struct file *backing_file,
>                                       const struct file *user_file)
>  {
>         struct backing_file_security_struct *bfsec;
>
>         bfsec =3D selinux_backing_file(backing_file);
> -       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +       bfsec->uf_sid =3D selinux_file_user_sid(user_file);
>
>         return 0;
>  }
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 3c0a16ec978b..853f7266ed18 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,7 +87,7 @@ struct file_security_struct {
>  };
>
>  struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };
>
>  struct superblock_security_struct {
>
> base-commit: fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3
> --
> 2.39.5 (Apple Git-154)
