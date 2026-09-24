Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA993D25AF
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216460; cv=none; b=EL3DvkfSWF8nCqfAOVMq0v/NcuXwQXP6muVOZSBKxppAesyHnFiMbPAg+kHsJ+9kS/+EERR3GN5+qgFiIVtpYBaIOlBO+kJUgZSKmO8aobeX0rBn2dwXsNshtm46xg6l5WewlHMOA55O1ICnKVwY+4eVtzevqKgFNenpaA7dwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216460; c=relaxed/simple;
	bh=lcL5Eetl3nG3gsUqwm83uBVrTGBkvNDFKF7rcFmnNeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sMQe7MyIqBUohdT1BlRhVoau4v+87dcXV40nc4hJh7LEy4I/RJ0OgWDVraxLsa++NPvHh59FXpR4gm+ioxdZxEiMeIVZ349Adx0EOvSPmfm7rcIA48ldXkqIpZzfA3wvmK8rOmasswnNooCLReWM2URZXTd/lEzc8DOxYS5H9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZ2Yfmk; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZ2Yfmk"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso873236a91.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216457; x=1790821257; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=eCZ2YfmkNf4A0dspZwt92Q8K5g21yl9N5y1EctpberS/8Ha4zbwyMdbiYDNf8ezbf1
         NVX6fzPU1cQiMyK+pg+y3zYWgbAC7LdVqeF5IpYtZj7vKWU7jCnGj/ZG5fSNtv3aQlaT
         eGl29sjcNiOVzPYyMflrnEdaN3XNN5PR19cHaCi+V1sTv+mvS8GvPH+FkVayHNGMltnq
         S4iTuECHrKa6vcjr7807YYE0a4RN+BXYNsPIOg5ZKqEXI2IGLwIlhOZaghiJtyGgeDrz
         ZgSKKFbCm73sITZzz/ed/IG+y92/4YRlaRd90zKvbGt6guXwhvQkFNozEpUA91LXpG0l
         Ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216457; x=1790821257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=bV45i9sQ0IGqFBQgqXRcwTdnRRDn9bmGNC29pjT2AwLFoDse/w4z+1hUCzYNZdKGyb
         w1T3pb1O1YURhWbP583KaGORaUNQCBC44CsadgfR8UZ639xckSQX7aIgmyiNgPxXHIwi
         rA0RlWvmuBTV5VgXofUG+KI5Wy0MCLdSDVdCx+l28Sihx3RzbfXUjbJES5OAgNP/2nUi
         hTFwGGEGkS7VCwVpyaSuR30zjmR+GikEEnVPWEPVZcpSRTAwHQcEjIPys9Dyf89ap3j+
         f0knyZiS59JpSN057dCu63THIUZIQkW3SqcseMqXn4BeepG3xqMqKLswCKWXrb73RZOb
         La9A==
X-Forwarded-Encrypted: i=1; AKwUvBwbfMpSZWnduCNbcsflcxL3aPBB52YA1YLLileTCLM7dcrPK0gMlrYl4k5xPvX6iHQtCSzHwuo=@vger.kernel.org
X-Gm-Message-State: AFuF++nNqd8s35a4xNcUHZ3ubgpM2ghpB7Q0i4mYZ365a35PFOfv44GT
	8MNITDJO/5qUHaDlyaKNmtq+pVdqnBBmlM/D5U80Eu/a8KxQvO1PPoJe
X-Gm-Gg: AYBFou3HDTqsnZP/AwqrC/87dgET4RofTP2TTHtXUwpbXWMSIAetS66fhW29NvRdt1/
	ao7uRLMU7Ux7xFkIYAQ0d5tZfhDqAqBNIuKUja0e07mY821bZsQdw0+BJlWa3N3RBaU8dvOlANW
	iERk71yXycj2Q/8hn1F3p+feCQX8smi/LETpMyelIvuOKCLuphGhPcLr09CwvIzU/vo3ZRpQzcY
	LU7BavHN1jvl3jooBVv6VqxchN0g1+5VzB0ETaM4Y0IKxgwJbbB29zLJ/EIXK3JxXN/xqxUFWz3
	OXmmNoZzR+64pI6/QB0tOj/2XewM8ofwviO4fwb7HzjvGva168G+FWDeWplbNYrrJhIPzHhGXfV
	/6m1yU9fKZxsE1BaiZ7sjGwsu0YICdBXhjnuV3plYb8Xc1n3Bg7Vu2ZUutgV+O4z7FH4/CyJbXn
	HosM7BklaElduzDPozJo/zqeP2n8PIXUR/J115zz/cRVPDfNDgEZVkgQ8eKBVxTlCczKGhrl1pX
	taCvA4uD3vN+t8AfQnMlYuUOSFq1yygSNaX728t1KVEGG7EEAvaaE7wNbV5dSEJaDgo5Bce+4yn
	X7qLgZ/O/fKIXg==
X-Received: by 2002:a17:90b:540e:b0:39e:6a7e:ee1a with SMTP id 98e67ed59e1d1-3a098da41a6mr835896a91.38.1790216455439;
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a082872cfasm2420945a91.2.2026.09.23.19.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:20:54 +0000
Message-Id: <DLN6RPOBSYOQ.13B97Z6OSFXY5@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in
 path_unlink/path_rmdir
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Parri" <parri.andrea@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Alexei Starovoitov" <ast@kernel.org>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922145530.369775-1-parri.andrea@gmail.com>
In-Reply-To: <20260922145530.369775-1-parri.andrea@gmail.com>

On Tue Sep 22, 2026 at 2:55 PM UTC, Andrea Parri wrote:
> bpf_lsm_has_d_inode_locked() makes the verifier rewrite
> bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
> that the caller already holds the inode's i_rwsem.  The path_unlink and
> path_rmdir hooks are listed, but security_path_unlink() and
> security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
> victim inode's i_rwsem, so a sleepable BPF LSM program attached to
> either hook mutates the victim's xattrs without the lock held.
>
> Drop the two path hooks from d_inode_locked_hooks so that the verifier
> keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
> the lock themselves.
>
> Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xa=
ttrs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 6cb8772679782..357a379ef92a5 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
>  BTF_ID(func, bpf_lsm_inode_setxattr)
>  BTF_ID(func, bpf_lsm_inode_unlink)
> -#ifdef CONFIG_SECURITY_PATH
> -BTF_ID(func, bpf_lsm_path_unlink)
> -BTF_ID(func, bpf_lsm_path_rmdir)
> -#endif /* CONFIG_SECURITY_PATH */
>  BTF_SET_END(d_inode_locked_hooks)

Christian,
this looks correct. Want to take it via vfs?

