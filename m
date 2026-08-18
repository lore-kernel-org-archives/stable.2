Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D21473C67
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058914; cv=pass; b=VKMxfRY6rbeEzwgifkYJ4048y3EJgJ7RCXej1Wvn14AutambP6G5yXqF4K7f5Ha3pLRYhQ1GKty3omTJ7wluJuHcy9eRjUZet5ZOk4+1GRe7/rlTRxRuHKjsMrim24pCQrZXXC0DQa+9OvhhtT76qJoSDb47I/Z34wPEsUJ3BEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058914; c=relaxed/simple;
	bh=KmOPgecutUsmjwBlgKM8KuaPjy+z2DOw9/Sj82TrOBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLhVgWDC0CvA7gxUkzNV6SdszLfsy6gUlC3DyouxHJm4TcP2raTHASMLYJgfb1FXRQEP9Lm1g/ThoUb14UnqCgtpa6O4hHbofI6erSy3sfCSHSCm7QF+X4siP9aA8ekphcv/SkppaoehthQBHjxb5S2Xk5Bgafqt9ntW8uyJE4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=R7WpH7XQ; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="R7WpH7XQ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936c02e58dfso295720385a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058910; cv=none;
        d=google.com; s=arc-20260327;
        b=hiezxcpw2HcI0/WqUPDV1drcju419AtvkN+5z0nuXMaMQSce3R7WjxkCfv/GRBsczk
         fuou+AhkxIboSZiMGXh077sYMSkSTc+CdnB0FzGpnEQbo+onJzfEgluX8aG/OOKWHTX9
         IFaYWLF0BkZEVj54EQJxjAG1uTiDfu6O//CE72+iVn7wXHDnew8Oyt56PK4ZuTsHvsnW
         ohK0fx4IKyK2+8LJ/nhNAMwcCiRO2oIpi036sUZS/R5olpJK0Q/PWNqulrJwlPuOsYpB
         Yr9vaDTA2POYOy1akTE8V9/IAfil2Xr9y5NtzcHW9Lp9y0Cz8BYDfJTYBJnWygbXXVpY
         1UQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        fh=eWYklhjph1TJUuOqAKHHcskWNIsl59IVZH0he9Q+h58=;
        b=I3CogyqtvTESTFzlVQ5DUCbsNijgnhN6dJcABWAXhf0xLoi7qja06YyjqUxursHBGN
         RlHHmm9mGF2tWDkIGEF+WDPpIgnK8+3lN++FXJ1D1k33HJtdCL3SaIXDUJalcMmcs1ug
         xBLTR0izOSrcZQl0wbf3BmDZAEVCUPy/MFPlBoKcxfbSLghGBLQxpv5GLAqgKtiIpwyf
         zlGa3jvaNh/iszcZ8m2eiTyuqku6kSi/RTQoxf9T4G4zdzJA4kb4Rzf9VWTd4EJJfuw0
         bDrFymi8DTwxrvfr3FB+1CBxlQXgV6AZ8uDavjIrhY8TkOkahnFVQmvhCqMRAkQD81yh
         VKHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787058910; x=1787663710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        b=R7WpH7XQU+s1dPr0CcPCikdC0N2EQs40h248ps8kh/hFM5N9xQ/hD2TfPWcl9xaOqz
         PWrcFWccreowAZlgmWR+EvyZYndrZ96uTCaa8V4GzKuPrf6C7X8+VoTjCI4/WSAJ65KD
         4AOjAy8XRa03bEX8khTR8J67UGihvM+9P8HEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058910; x=1787663710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        b=p//iRn0C5/YfGxiTq+hag0/pDIb56y5iZGiuBNd86r+zz7UOisTSmzNYfq4FmjPyVf
         Yo7oyeuBe4CX6ttK2Rq+Se6ZDr5U2dIysnxZB/YfM09D5RMOBpK8fqROs4492wpdKxj0
         OFKnPrKoy1aXI96ImFhULhRyYIjcvIvhkEk5p2gXEmH6mUisACkciO+X87iTez5Ls107
         rGg/rkeu0SowkVo5hhG7tp+QVQ1B1reQt/dqzJHe+PaRoK7IxFhujZ+F75DzG7/zCg3T
         2kICVUCp0ULsH4/3tizNCegflreQ+UhdxM3unqK/QtknvtGok6lpph2lSyXUVHs6gMug
         UfYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpkk+Vftax49PDUBmU7FJMAU5y1lQoEx17ulXngDfPwcBRRc9pvk0X78qB306Q+zEcYn56KdVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSA2hNQqiXOke16zzJYCJRyOF1FPqBmbwGKVaH8Uld0872VaV4
	rtAzuKPBWWKPAqgAzD4DPieKKg+pBjWl+mp9slP6VAtNuYj0TfCMoPiLPykS4rHL8ynOpyIuFhp
	OtWxuskHvZS5RZJWLdyW2dMVKmhW4hCxXY0uvtegawA==
X-Gm-Gg: AR+sD11OjSRX0++GlWegDBHeuIoxzDaCsMUTDcZ8VsIZTyhnB2W00u9RMpT6O20LI9S
	w6UcxPzlmyXac8AEy/uYcwGGZELNS5uOsE8BgDygQhpPRMZWdKI1zl/agCHdtBGqY39NO0MPHsF
	YtwWpPyyx364ZTasLL7NUf+y2fWNIPMb9k5ktvZy432G+cQVbkiwKdUbPgEp6+TsVhmJPNF1Nvc
	XH+rAXZ7Z1YrJ2wP6DCRNz02mq8TN00pRhuaNKmDETSjanwWA4uOvZjdWDCdrp1RVpNUetFzD5y
	ORCfGpmJiE7HYj3t6mV62dElQzi6SlK6zP1mxUmjiaaWtbqo1TqCibfidRA0GNd0oVO/fcRbK7r
	L
X-Received: by 2002:a05:620a:404c:b0:936:e3c3:8cb8 with SMTP id
 af79cd13be357-936e3c38cc9mr2458814485a.45.1787058910323; Tue, 18 Aug 2026
 06:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-work-fill_super-warn-v1-0-4e987911a39a@kernel.org> <20260802-work-fill_super-warn-v1-1-4e987911a39a@kernel.org>
In-Reply-To: <20260802-work-fill_super-warn-v1-1-4e987911a39a@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 15:14:59 +0200
X-Gm-Features: AcwNN1UBQAWcx1tOEiU47Frr3JyAbsHxepEKWSi_zYBw_ITdoj7CtNDGWqz3aiE
Message-ID: <CAJfpegtXbdpFZmV2dYSbp6eL0DBGmZin98TFr42nxJCfuryfrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ovl: don't warn when the mount is completed from
 another user namespace
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Aug 2026 at 20:00, Christian Brauner <brauner@kernel.org> wrote:
>
> fsopen() records the caller's user namespace in fc->user_ns and hands
> back an ordinary file descriptor. Nothing ties the task that calls
> fsconfig(FSCONFIG_CMD_CREATE) to the task that created the context. The
> fd is inherited across fork() and exec() and it can be passed over a
> unix socket.
>
> Completing a context from another user namespace is allowed on purpose.
> vfs_cmd_create() authorizes the create with mount_capable(), which for
> FS_USERNS_MOUNT checks ns_capable(fc->user_ns, CAP_SYS_ADMIN), and that
> succeeds for a task holding CAP_SYS_ADMIN in an ancestor of fc->user_ns.
> So an unprivileged task can reach the WARN_ON() in ovl_fill_super():
> create a user and a mount namespace in a child, call fsopen("overlay")
> there, send the fscontext fd to the parent and let the parent issue
> FSCONFIG_CMD_CREATE. Both namespaces come from a plain unshare(1) and no
> capability is needed anywhere:
>
>   WARNING: fs/overlayfs/super.c:1551 at ovl_fill_super+0x7b9/0x1e20 [overlay]
>   CPU: 3 UID: 1000 PID: 3243376 Comm: fswarn
>   Call Trace:
>    get_tree_nodev+0x71/0xa0
>    ovl_get_tree+0x15/0x20 [overlay]
>    vfs_get_tree+0x2a/0x100
>    vfs_cmd_create+0x60/0xf0
>    __do_sys_fsconfig+0x4b2/0x500
>
> The child needs the mount namespace because fsopen() itself gates on
> may_mount(), which asks for CAP_SYS_ADMIN in the user namespace owning
> the caller's mount namespace. fsconfig() doesn't repeat that check.
>
> It is a WARN_ON() and not a WARN_ON_ONCE(), so the condition can be
> raised in a loop to taint the kernel and flood the log, and it panics a
> kernel booted with panic_on_warn.
>
> Keep refusing the mount and stop warning about it. ovl_parse_param()
> already spells a user namespace check this way for Opt_override_creds.
>
> Fixes: 1784fbc2ed9c ("ovl: port to new mount api")
> Cc: stable@vger.kernel.org # v6.5+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 60f0b7ceef0a..60b808b85fc4 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1544,7 +1544,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>         int err;
>
>         err = -EIO;
> -       if (WARN_ON(fc->user_ns != current_user_ns()))
> +       /* The fscontext fd may have been passed to another user namespace. */
> +       if (fc->user_ns != current_user_ns())
>                 goto out_err;

Just one comment on this (I know it's been merged, will do a fixup
patch):  EIO should be turned into EINVAL.

The EIO was used to signal an internal error (commit 9efb069de4ba
("ovl: add warning on user_ns mismatch")) , which is no longer the
case.

Thanks,
Miklos
