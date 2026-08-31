Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7256510A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184083; cv=pass; b=L5f5pgEusGP31dtryvYoqhmvbR2Ib/juS4R4drt2hu7At2H5SYCOR/gVTB1zn9bc/gFSWxk5XIy4vVtjNQ4jwDjqzSuvnwjIcw/GXrRBp7maGUO27AiXr+q7A7UFFaJ+CjxmpSDNIc+tQNHg3xb0boys7VGBqXDJ7jYx7Sg6rDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184083; c=relaxed/simple;
	bh=6EmNPbgdthlv6HmYz6yjs79CFf+7Dk2QeNRcHQINiD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2n+E36tpsc9NMHj/tNmgxLyNrWKgBaN3Jyn9WKG3EB185+blXtvZzRd8FRO6JWImWTHKhB5ilqjXF2orzLUHSQ0kdzN08o+CEc1PX8jKWCgiLFhVnDdNqIJ0T7zdkomf+Riif31CwAjOOUCVtRf/NkFYSVdGjIE54bgUnoscaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3NnNCrv; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3NnNCrv"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1b3d7f10eso1092542eaf.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184079; cv=none;
        d=google.com; s=arc-20260327;
        b=rVwmllMEWcBjr7TqN3ErO2+fg23Ui99OfpRWwN24Yjo57LPRGy5o333QPtTQ109/4M
         4YytRo5vWNaCgJ/CG6v+7K+sWqqvrdphKM9LHa5NtdvmuVlpkgOYWhXA/2mdg13j8hyU
         16RnSU/Bpl+D6RLjhV45xuCrPGD+U92KZWbVGtKqRXH1MVNSq8oL7LBbf8cAPoBJa1bJ
         vj5fR/P3e7mjUY156R8GFB0pBuNFHgP8y4u2ZZ0BA9nZ8P+ubU9JNQvP/R87c1BrrYTI
         R3eoyIaJ3/IhFAZDKoyDNh1smQFGrJZeyZeamf1hnmGFRvf7g/jVXNvqAtaD5GfkL3tM
         +H4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        fh=xkbYUIU//caigG97xqVPBOW0IddwFv7il7BD4rVT4GM=;
        b=l3zYiKfVGMOohpX4b47IzWRRAGqd7QwV54oc0/Atc7NHAKKf3ySk7xItg3FgSHD8dG
         NtyBuPm+Z7GgpZSGl5hK+/QLUI0DMtq/MJrDQzkZQpEhbOgdFTomfV4r/5UdjidhEv5O
         IIutTUlRTdzdBl+9Lgf+Y7aZwLNAoVxs31DX/6+wJAg1lARQxIOoAnsLOfaUU4ksmCR+
         MwH7a0ogeAFiIxkfhWlNTbzXhDLeHkIYGjOYuIjVmIToTwgutrZH5xACQicEKfuPrGlc
         H5sHVd90rOxZx8BlB5hnCsO5xBtvc2ro+J9bREUHiqjLv+kQ7vI/WVOnS1hLT+U2vrJa
         MskQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184079; x=1788788879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=O3NnNCrv8fE+NwgENRV1hTWmfNlmYQ04qnTpHeyCr23Fszt14vlRqOb1klG6VGPuIM
         r9JvptzArNTlUaDCIVnBbcOnJlAXLK0rOsOwNyeFRLDTJN7Ixj5DAyrBA3azQthyUG09
         VcYxjs4FbKX9TWSTCJOCoWJWTtMJfd9MGYJwhRIsmikqdUB6MSzZazHPeGV52sYQ89Pm
         rxusbQb1lj8/HjcHXMP8lJuOkl5EAfWJb61G9cesuVJwIP9CvBzcA2zdtsNX3eN60f7m
         BQ3xS2p/vG3UzbWx86PniiA04tVscsBreLzSJx5XMZRV/X0UoLfGYgGEz/jz90bICLKP
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184079; x=1788788879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=AgXR4ykpCr05PVGpjQBO6Kk2Q5Rb4TgNXa//Nv5ZIiJY+1AVlh2l65w3rSUq0c23PL
         g5o9TtxTKv6bZI2ZpzDqyX0zldA8nhMJ/iQ0TO/8OJWXRcgpes0t3GrCtyGMSRdIq9xH
         A8lTfPDbyAzrYRROGUeICradgQGfr98hUISDpll3NVpyqAAI0tAf7A6v0V5X8h9JXLC5
         Fhe9x8kuskMoD6q8tqWRCrpqRzgzqhA9e+LBApFjMZi2zZpK6BJDYm/RxAoUkMV0stsT
         hhy5jxI4kPZbY2+D8pxmTwSSUYe/9ouI8TPzMLrMHEuEUkofgtezLk/wbg3kvsPlYtBR
         9APg==
X-Forwarded-Encrypted: i=1; AHgh+RrdjeaPOIltMDGPepnyUZ9wBUWCYIlogNWUHebGhV72p4J/Ak1/Z68DHLW22HVCIOn/aqYV6qU=@vger.kernel.org
X-Gm-Message-State: AFuF++kSA7EH65mF3k37L9yZ4sN/9yhaJCa3eihXP+HgggtiTlcZBR2f
	hbKW6SUMdaaikbSSGAXdo3COnCXPoyfqr4dFmknYlUfT2CDMU0gJNHW2P/T4CB6IrH3Nf4hR+g1
	KqzuUpXbOsoD+cve1Nuj7shizC8C+cp8=
X-Gm-Gg: AR+sD12RPqCyD6bZ++AIn5/zC6ciw3VrRinjU0U4SYO4qGheSJ7jhTCwPpOC68+Ude7
	N20oJYJX4ZkI0KcC1ckeb0XUsOh+66kmx23hvTNe6OqpaMm/FnCsYvU2VuLE07YkRdielYa55tV
	wgtQ2R8Zc4hcDW8pGPIssRf98dX/XQeeR8fSbHZFkfXV1Sb1N97wO2VbGRwSaKomzVoS/m54em4
	4t+EMj19ploWOn9oNZ3SIptW5DcbmjYcN7TJmJKykGwv+JHAPBziZPb6mq256hmBPfKw4Yr05En
	sMUfHA/9kN33k0tEeNQ7SIMvqIjse4dhQYCqvttCo7fEYa//A06GP9vn
X-Received: by 2002:a05:6820:26a:b0:6ae:c68b:3a7 with SMTP id
 006d021491bc7-6b1c6753623mr18493696eaf.16.1788184078901; Mon, 31 Aug 2026
 06:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-3-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-3-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:47 -0400
X-Gm-Features: AcwNN1W99CqXWvenoG8rROnmu5fRwQuT08OeAJUbXEa2X-h97G_VigU5iiBhoYc
Message-ID: <CAEjxPJ6TRV5CZyuMHatON021ptwzfhsniVKER-vE6ASh0qhpRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: recheck intermediate backing files on mprotect
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> mprotect() can be used to bypass the SELinux checks that mmap() performs
> against the intermediate layers of a stacked filesystem.
>
> mmap() checks every backing layer as the request descends through the
> stack.  mprotect() only has the lowest backing file in vma->vm_file, so i=
t
> rechecks the top-level user and the lowest mounter, but skips the mounter=
s
> of every layer in between.  With two nested overlayfs mounts and a policy
> denying mounter_t -> middle_file_t:file { execute }, a direct
> mmap(PROT_EXEC) is denied:
>
>   avc:  denied  { execute } for  pid=3D71 comm=3D"nested_exec"
>     path=3D"/payload" dev=3D"overlay" ino=3D9
>     scontext=3Duser_u:base_r:mounter_t
>     tcontext=3Duser_u:object_r:middle_file_t tclass=3Dfile permissive=3D0
>
> while mmap(PROT_NONE) followed by mprotect(PROT_EXEC) succeeds.
>
> Preserve each intermediate path, mounter SID and file-description SID in
> the backing-file security blob, copying the saved entries when another
> backing layer is opened.  Allocate the array only for nested backing file=
s,
> and release it and the path references in the backing_file_free hook.
>
> During mprotect(), recheck fd { use } and the requested inode permissions
> for every saved mounter, and include the intermediate layers in the execm=
od
> checks.  Policy for nested stacking may then need to grant intermediate
> mounters what a direct mmap() already requires, and execmod on intermedia=
te
> labels for binaries using text relocations.
>
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy, on a mainline tree containing
> commit f2381b546e7e ("fs: fix user path of nested backing files").
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
