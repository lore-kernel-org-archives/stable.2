Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95F419FB0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862869; cv=pass; b=L+CSXH827tg4+CoB3pWxSBI7RMIoy6iwxuu3v4Ro6fLAIrkRFRuYEF54yM/sEGzHRQINC6FvWP6hfLeV6ynK2DTI6PD1/WcByX/EEi5LgEFIiobDqy+Sm/O/DoIkOE5C6MRTFxArkRHxMjwSKOW2aXVCrWF9vqVcjucD7/vYGD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862869; c=relaxed/simple;
	bh=NN7RQwZEWIcd3u0Kef8iTQYndBZrEjQokV6obVKC/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcdqSxzgvNpHqe9Snu2SR8OUpZmrbeewPiurmfdZ2gdcKx8JfJOl10yWVasft8m3xyym5SxapjrlRtlZjGd+Uufs3/kchM1qe5edhn1HUlaoflO5QjJGT5CFF9zR6EVXKIaGGqNpENKkeeTEI38YAbDO15YQMjzS9EySXp62QMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZHhjSu+; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZHhjSu+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so20307a91.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862855; cv=none;
        d=google.com; s=arc-20260327;
        b=ixXwFcaEtHVUJ7XBoD1Y1PendjB/6UnPDpWSEHvav+RQVjr1tYj0n27TmGDgXxgerz
         Yf1pd2aGpVRGRHT/Z+FqUmzJWkdV6rrKmLefFnPOB0EhnnvsRuQnJYXxmG+GB2gb36P6
         63Znkxz1iRnRLpi639r2N6vO6OtWDTXzsHIm7q0xabHkxZ7jh77O3wDQsrxjAzTvgEwy
         kiwgjv+QPSsMJfCWDdPTIv+6w0FWx+K+ozGUuflxF5qxyo4KxAj5ixeztmKCZVBo0iVI
         cN1Y/nCe73zg/USgDFtlXAHAsOi77/JH+BOLEkiCKQFsf4vhYRkkI39/XqCpVk3BTPk5
         0Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        fh=A/wLj16+The6KEKaNF6awFUFN0CINuLekqZmdZg0c60=;
        b=soqJ9Y7HEAkKUPn2pr60dIHdkrTAlOPUbixu+UQ2gH7bMYr27n0hoUohxpbk+6dCTI
         MACLdU7rDKFtMUylXVjhEq6tvvuA3pszs/NYUvt/7Aidj/9NpJQrdixpVPTUjjs39ajd
         ynQ9A31xRDEc4Df0jMyYtnmwC/g34ozTIJLTf1QdETXtBA2Yfk8S/ldRI6iD3JE+y4w/
         tWGp2iuef11mSTfiMpu2CjF4xFgZfr5EiAywqRvNqvtKeazOTR2+a3Fkd/DaTw16T6Jy
         WZyaOOsllSgXI+5cLLw9fYxbF+3aR9UjrabW1lC/ORc6G5a7vmAq361e43Rvc+5SsWmz
         C1Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785862855; x=1786467655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=SZHhjSu+914kO7qex0mPblU4m6opNNQ8SYzai3bSARLJLgxVPtp34YzgW7oNbu+Fuq
         4k48OU3THdvgN3jqv+jM8b9hg4IuP4x5ZijnVcsu409eI/9qvBshVlFF9iR0I16pcYE9
         8EkVEiEQ0LZ4BthS/SlV0K0QhtVk8no3npBUgkYyjDuhrbnahz6Q6mEKaxT+xuEvfw+O
         HGBFPVy/uByJ5rIO9oNE0+N946LUW2e2Kdacwu07ETwulGTTUCTxb1+jZ4znPHIPIpVC
         FB1jraJdPJh9m/LBOHcBHjtCTxZu8G794pvx/MD3enegq88zBZWC0w0rApfKO0ybDjfA
         3Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862855; x=1786467655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=Ek2wviAhX3jhuBB5qZMUMOJCn9ssEvIxg3wjFmhm+yQg/mThSME9O9tYmspiJ42UBj
         3J7rMfTaiLBqnnXICDwreajvaKh0pldQnbh3xtQs96jgPzAW2ypW0wnfyZBVIFXsNJUj
         9tZ/oqNMcefwtNxahn10QlMhPYvJ8TlXaV8H+9fjb6hJsjCP5FyhzneGASl3cxHMIOtA
         UpdOiF89e9jJ4LGaVFjfi3cTkCEJQLUe3z6NkL1n4edjpyP5pmg5WpMdrx0/IOmA0wjW
         jKIfpuIfLTZEsQqIvHSPmkZfU3tv5+gkkDm+TpT0D3qPKWzbxZ4mk6X3ImA48G7hxizy
         17aw==
X-Forwarded-Encrypted: i=1; AHgh+Rrnzw6WMygmuACcdRItW9iQblxyHO7pV3Osu01t1jCurvRwWsCLpUsFwQxz05GOt7y+8D4Mo2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJB/9elgkiYzL8Ecbk26wIVCD44j1w8wOWKnOYfr9Fck9lHhK
	090+r2IM2c1AzN8UKSbK2vpTdl7d1xKa9YiFgtXZdnmQw1Wv+5HZnqD/Ozso2105OPepND1cr8Q
	+84jOhk9NShqiM+xtAzuG3YtOW8XJ85eFczEa/LkH
X-Gm-Gg: AR+sD11nRwOB0MxXnXMsDT28ihUaEjwzYnZER9jyT+TpYApomV80Mp7WzfN3bwN+kh3
	U0FvD0v+pewCxnr53sSRAcdnHq8mEvahwtLFMJwIFF7LEU1an9uRrPCAt84uSc/GB/YVuw7K26N
	JMTUMFNmvbW0OKw/k3sJti8+y6+pWzyB1y2qX9HfiM5rnJK92/T7lqCXBiS2LP2ahw6G9MJ6fql
	O0mnGpq0JwoL3RXpWcO9SI5qPQr8DzWNk1HXYCw1O6xgr/ZAeyL4hIq7y0JS9a68zkxFSgw6dgl
	CfJBVTAd+Tue4hwLfYKMurEDezXIvcqtxLPXROC5qOnp
X-Received: by 2002:a05:6a21:3204:b0:3c3:834e:89b9 with SMTP id
 adf61e73a8af0-3cb85e7370emr306570637.17.1785862855065; Tue, 04 Aug 2026
 10:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Aug 2026 13:00:43 -0400
X-Gm-Features: AUfX_my2GHODSgWpz7u9PLF5sftBX1mO9fjStT4uqGF3r0dq7sFB5ilyjzEJ3cE
Message-ID: <CAHC9VhTWuX6D0yeBKr0bPbJ_mKUdiLYRtQpcwq-jJgovY_akDA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix user path of nested backing files
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, serge@hallyn.com, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:42=E2=80=AFPM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> backing_file_open() derives the path to be stored in the new backing
> file from user_file->f_path.  This is incorrect when user_file itself
> is a backing file, which is the case for nested stacking filesystems,
> e.g. overlayfs mounts where the lowerdir of one overlayfs is the merged
> directory of another.  Since commit def3ae83da02 ("fs: store real path
> instead of fake path in backing file f_path") the f_path of a backing
> file holds the real path of the intermediate layer, not the path that
> the user opened.
>
> Commit 924577e4f6ca ("ovl: Fix nested backing file paths") fixed this
> for such configurations by passing file_user_path() from
> ovl_open_realfile().  However, commit 6af36aeb147a ("lsm: add
> backing_file LSM hooks") changed the first argument of
> backing_file_open() from the user path back to the user file and
> derived the path from user_file->f_path again, silently re-introducing
> the problem.
>
> As a result, files mapped through a nested overlayfs show the wrong
> path in /proc/<pid>/maps and in perf/ftrace mmap records.  For example,
> with two nested overlayfs mounts:
>
>   mkdir -p /ovl/{lower,upper,work,merged} /ovl/nested
>   echo hello > /ovl/lower/foo
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/lower,upperdir=3D/ovl/upper,workdir=3D/ovl/wor=
k \
>         /ovl/merged
>   # at least two lowerdirs are needed when upperdir is nonexistent
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/merged:/ovl/lower /ovl/nested
>
> mapping /ovl/nested/foo shows a disconnected path instead of the user
> path:
>
>   # readlink /proc/self/fd/3
>   /ovl/nested/foo
>   # grep foo /proc/self/maps
>   7f6e2c100000-7f6e2c101000 r--s 00000000 00:24 15813027 /foo
>
> The bogus path is derived from the f_path of the intermediate backing
> file, whose mount is a private clone that d_path() cannot resolve.
>
> Fix this by using file_user_path(), which returns the outermost
> user-visible path for backing files and falls back to
> &user_file->f_path for regular files.  This restores the behavior of
> commit 924577e4f6ca ("ovl: Fix nested backing file paths") for
> overlayfs and also fixes the same problem for the other
> backing_file_open() callers, fuse passthrough and erofs ishare, when
> their user file is itself a backing file.
>
> backing_tmpfile_open() has the same pattern but is not affected: it is
> only called by ovl_create_tmpfile() for the upper layer, and another
> overlayfs is rejected as upperdir by the DCACHE_OP_REAL check in
> ovl_mount_dir_check(), so its user_file can never be a backing file.
>
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/backing-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The selinux-testsuite runs clean with this patch applied.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
