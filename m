Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8751C322
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070020; cv=none; b=bXPpI3BkqdeQ4XJBDtnLNtr3ZG6U305GfsGT8905PY4cRLckLsekyiRIP041EGgiJLnnaU9SOeaEY90k5s+vjkI7kwmrZaa8+S9Prprjf2iTbRALGk7EoRu9U+Kf6P+24kxK+reSEr4Apdf6PRYmLG+5eNsxZS+F7lFDGowYLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070020; c=relaxed/simple;
	bh=ucFZ8Mq7ewmyXcDTFKP7UULK5m7ZGXARwwBrJyVQ/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI+TvMo9TC34nS3SqUy02BeiqOYnilqWLoNtJNtnCz3X8Mb7dIgTfur7xGHbCuPoqT4w4Zb3LMm4XQkxJvIGtJDv7hg7CFEOxROcfL/4KxFoQnC2s3/t347+BNZONZ2DbkEbseOdWoxWH2G69zjnZS2+u00hM5/ldQjblTvFk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFozGoY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFozGoY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FE11F000C8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070017;
	bh=GnEkXDjMJm1exlC5tTiLHa25Mrd5Uvr2qX3xMMnipRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dFozGoY5ns8VBK7wD15lqifaPgZ5oRl7bS5qGyXzFGtf5JYcKUo6Ckh7lOZqaxhYR
	 DLj85OQ8ASr5MYvmCcys2yYLuwqteJELC5+5SapxUbX2EF0Aj29yUJ1ershJvccHnE
	 /ikMhITy18YX96OzVX0ctoBTREeIA/+3VP5iRNivJmPFWMuMNUB6uc31iZDqmJrZFr
	 2VlFH7SPEOnWnKG67yaPjJ9U6R41FT39i2Q4+fcE+cVdSj7ykYBqN2QcjOres0wxs+
	 +0lILV9W7gl6pS29jIS8ocoN6fi45+sp/j1KY4/Q6TVxAZqBa08jQR6wmutci5dyVD
	 1AkNb9jUGmzbA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso765975666b.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:13:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxF1Fea6pNgvJ72qjQL2G3dFSMnOAYVSISnU+xb0S318TmgUGuEonNL+gh5kGxAmiohnSCAeqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBPv+CHMCYX0QaKTmp7jae41mGiMHcdLQcaKv9SEDkHOTqiKiY
	Z0rOcILZW9R4tiPLQxAONTLZezSkhDrtELMlPOcCwhxthwBBnEeeVbz+fXNGeUtHc7f8zOpbQfJ
	O2Es7vc1MS/8QveH/iibdZB8Yx5jnqaY=
X-Received: by 2002:a17:906:dc8c:b0:c2d:ba08:9092 with SMTP id
 a640c23a62f3a-c31a9fe730dmr1694771866b.16.1792070016069; Thu, 15 Oct 2026
 06:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013015652.19724-1-zenghongling@kylinos.cn>
In-Reply-To: <20261013015652.19724-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 15 Oct 2026 22:13:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_O0Xf3pUcPdwKVVMf_jn0WD-J4i0xmQ3v6a=y1kOmoRA@mail.gmail.com>
X-Gm-Features: AclHuK_62zyJ9s2LrW-rF8gXePKSnnjHw0Oo6L11_y8j6ZkpLN8J9SMhVA2HM00
Message-ID: <CAKYAXd_O0Xf3pUcPdwKVVMf_jn0WD-J4i0xmQ3v6a=y1kOmoRA@mail.gmail.com>
Subject: Re: [PATCH v5] ntfs: roll back the ACL xattr commit when the WSL mode
 update fails
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:57=E2=80=AFAM Hongling Zeng <zenghongling@kylino=
s.cn> wrote:
>
> ntfs_set_acl_ex() commits the ACL xattr before it rewrites the WSL
> mode EA, and removes it again when the rewrite fails.  That only
> undoes a set that created the xattr: when the update replaced or
> removed an existing one, the old ACL is discarded along with the
> failed update.  No error is recorded when the undo fails, so the
> new, typically more permissive, ACL is left on disk while i_mode,
> the mode EA and the cached ACL keep the old values.  After a
> remount, a chmod 0640 -> 0777 that reported failure leaves the file
> accessible to the relaxed ACL while stat() still reports 0640.
>
> Save the previous xattr before committing the update, and restore it
> when the mode EA rewrite fails.  A removed xattr is created again,
> since XATTR_REPLACE fails with -ENODATA once the removal dropped the
> entry.  Remove the new xattr only when there was no previous one, and
> skip the undo when the commit changed nothing.  A failed rollback is
> recorded: NVolSetErrors(), which the next persistence point persists
> as VOLUME_IS_DIRTY, and a log message the errors=3D policy acts on.
> The flag cannot be written to disk here directly: the target inode's
> mrec_lock is held and the $Volume mrec_lock cannot be nested under
> it.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Cc: stable@vger.kernel.org
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
