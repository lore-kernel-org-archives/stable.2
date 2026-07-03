Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F803DA5B1
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075255; cv=none; b=JqvR7wGFRA90Zj8Ma4Ejw8GvGZ+uVl7vRACYMaW6QFLJ3grY/2riBrDureo9aaq74DnLWMiXZwgsk2SnFcC63qInaswdCpBp0yQY3QLLjRbskCCcac3MOoI2itVQiegNX3yWO4ZI+VDaxkOx4xrQ1rwKqw42IYS2UQsqH/hkkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075255; c=relaxed/simple;
	bh=AkoWR+AdiXPTUx4iCETHb/H8DfHnbsY9fjNrVoKT+DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qumqTcCjriuQlb+fQlyZcRLWioKgB+NcY1d2IGP/dJMuP5e5AbhKBbPaKLiWjObsKizSR/r9EkaMr/samBtw2Ddw9TJNoaRHCWhZTLt1+J1z+zZM2meE5mB5VbsIS46raTc7FZpq24l+rBzL/XMTbV5TQ+o5w65SEfpQPnbay9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFTYdUWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFTYdUWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7051F00A3E
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075254;
	bh=qG7seIUwNEkDWm+Y5e7nT7Gnpb5llLOL25VCASREZDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cFTYdUWNs11Flhjkty44dJdMenmOmExA+tKvnX5kwY8wdfBHbEf/ULuI4MwmRnAxD
	 r2vxuovf6EEtoEF4HxPjwoZ2ixaPzfEqcuYvLexELFzAyK7Ra/h+9L/lSFT8d2dtL0
	 Fzarz1T6+jMPUEZyos2sKs/aoQ1xYo4O+vBZH0Pj8hs10lgDBKBmWQQkGiz0LHtPB7
	 UTtH1Btp0bZ+8ttESGH6RJ238+5CB+PInzibXFo3J+mMeVTKGM4nnW+7uAP5OnALDG
	 1E0hyRofOegUBIeccpsREvgUQ56W4ntCO1vNxCS3cAMjjZnwMnOyvBECc78DjDMfTH
	 QrUnkCsu8R3EA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso35459366b.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoT/O3GC4etjSVL6MVPNnlieOtB1Jyqz1brTV4MjUcO+/7hq+F8sDNzZIlzVumM9iEtkIECLOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9F2gfETdhBq/P9a8YZT62SQlG3EzVHa9l9/A9ZIYcYB4D9iwr
	bo1XdqUV1fyUnr2EoA5bCDUEFASvZL4JeQoBwKYNoWGk72RdSyG+nVMcx3aT292m5XKx+qwa5gy
	0glSx1XLjmjkKq9nwId1FwqhHqwYE38I=
X-Received: by 2002:a17:907:7a8e:b0:c12:5bd0:b9a6 with SMTP id
 a640c23a62f3a-c12ae8b4756mr412088366b.64.1783075252789; Fri, 03 Jul 2026
 03:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702033656.23048-1-zenghongling@kylinos.cn>
 <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com> <6A4771DC.3030301@126.com>
In-Reply-To: <6A4771DC.3030301@126.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Jul 2026 19:40:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9jk3QH=JbOk-79apX6X-v+Yi0ixs4JtkaUGUP723LPDw@mail.gmail.com>
X-Gm-Features: AVVi8Cd7Hgcb0DpvUBYDe4waQfwCm5ZMg4nnBNzmhtrXTC4kjqkTv4Pxv-lFGEc
Message-ID: <CAKYAXd9jk3QH=JbOk-79apX6X-v+Yi0ixs4JtkaUGUP723LPDw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate error codes in check_windows_hibernation_status()
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, hyc.lee@gmail.com, charsyam@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 5:25=E2=80=AFPM Hongling Zeng <zhongling0719@126.com=
> wrote:
>
> Looking at ntfs_lookup_inode_by_name() more carefully:
>
> All error return paths inside the function use hardcoded kernel errnos
> (MREF_ERR(-ENOENT), MREF_ERR(-EIO), MREF_ERR(-ENOMEM)) - these are
> already valid by construction.
>
> The actual risk occurs when the function returns a "successful" MFT
> reference from disk (ie->data.dir.indexed_file) that happens to have
> bit 47 set - making IS_ERR_MREF() true at the caller. In this case,
> MREF_ERR() extracts garbage from untrusted disk data.
>
> This cannot be fixed inside ntfs_lookup_inode_by_name() without
> changing its return value semantics, because from the function's
> perspective it found a matching index entry and returned it. Only
> the caller, after IS_ERR_MREF() triggers, is in a position to
> validate that the extracted error code is a legitimate errno.
>
> Restructuring the function to distinguish "real errors I generated"
> from "disk data that looks like an error" would require a more
> invasive API change (e.g., returning int + out-parameter), which
> seems inappropriate for a legacy filesystem in maintenance mode.

I think it would be good to fix it like this. Let me know your opinion.

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 4b6bd5f30c65..6fa9ae3377cb 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -23,6 +23,13 @@
 __le16 I30[5] =3D { cpu_to_le16('$'), cpu_to_le16('I'),
                cpu_to_le16('3'),       cpu_to_le16('0'), 0 };

+static inline u64 ntfs_check_mref(u64 mref)
+{
+       if (IS_ERR_MREF(mref))
+               return ERR_MREF(-EIO);
+       return mref;
+}
+
 /*
  * ntfs_lookup_inode_by_name - find an inode in a directory given its name
  * @dir_ni:    ntfs inode of the directory in which to search for the name
@@ -178,7 +185,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode
*dir_ni, const __le16 *uname,
                        mref =3D le64_to_cpu(ie->data.dir.indexed_file);
                        ntfs_attr_put_search_ctx(ctx);
                        unmap_mft_record(dir_ni);
-                       return mref;
+                       return ntfs_check_mref(mref);
                }
                /*
                 * For a case insensitive mount, we also perform a case
@@ -273,7 +280,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode
*dir_ni, const __le16 *uname,
                if (name) {
                        ntfs_attr_put_search_ctx(ctx);
                        unmap_mft_record(dir_ni);
-                       return name->mref;
+                       return ntfs_check_mref(name->mref);
                }
                ntfs_debug("Entry not found.");
                err =3D -ENOENT;
@@ -413,7 +420,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode
*dir_ni, const __le16 *uname,
                        mref =3D le64_to_cpu(ie->data.dir.indexed_file);
                        kfree(kaddr);
                        iput(ia_vi);
-                       return mref;
+                       return ntfs_check_mref(mref);
                }
                /*
                 * For a case insensitive mount, we also perform a case
@@ -538,7 +545,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode
*dir_ni, const __le16 *uname,
        if (name) {
                kfree(kaddr);
                iput(ia_vi);
-               return name->mref;
+               return ntfs_check_mref(name->mref);
        }
        ntfs_debug("Entry not found.");
        err =3D -ENOENT;
