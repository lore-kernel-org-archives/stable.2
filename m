Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BA45A28B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437427; cv=pass; b=bVsfIDY8allrJFyQDcxIX/La1SdDtyp5i+vMWoP6W6043tfGTd8wrhk+Uum11BXkQe3ud+Lm52hC6v14ht6lCjQNn0PVbxjlCk+zVZzdhwDPhzSB9FtDfLX2y7Nu+UVfN6X5uL5+2w+CtDMC8Q1upC+EpqtWrPsyj3k4kVDg8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437427; c=relaxed/simple;
	bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMKkjmn74GX1CcHPuTiFx74ayd9Ccw2mixkqT/Z/O0uXoU63au5BbdN5j/c2XVCT3OH5mxWnpoDT+P7alR1COHEEiSA/PEIH+4D/TYrVwYoWvh0+SPKwrJzyKZGDvRvFHkT7Loo1SZfPEZguMEvCUJN4UokhdeEQ4MGCzRHpLoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Ej7zYc; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Ej7zYc"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-45171f2f608so146110fac.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437425; cv=none;
        d=google.com; s=arc-20260327;
        b=KX9fL8cEqtuQME5NvkHN9fnbu7zkmEM8Nh4/xisp0f1Ap25eRsuqi5VPvRUK9xQcM6
         AK2aA9mnTZ8ZF5GhigqFbipvi36hX2QJ0TNL2ZY+pBNDaI6eBeIGDii9PuBBQh6GGaXj
         MO38+N/OHtXPN4b31OTZ7HIOMllrc1DhWgFDhHKDtVC4h1kbBZnxYBzQ2p+v2o/1Q1Gh
         MJkO05R96ct5psq3fD5/aB0c/ZhilZRl+QI+tMvJ0tk6J/e+SzejvcCZ5jNF901HA110
         1+X4jZkS2qt32tZ2pDu5vlO4PRfk+rpLYz+OvQMvqaNe/O4pVAOdOxlcOcmiXnH7rZOH
         7FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        fh=lZDeCDUagU79yVax10wc/OCBlbBeteLwRU1SDl8nhz8=;
        b=QnH2al0mL+mjUMJEKyvBJBkc6rmQXSlit8dqiX7vUBAtUpeSti+F/5K6+83tHHwtBg
         p+y0zO10TWjJRJPULi+oCp7Vnaa/WVVN2DZ0T0on+TF8vsJjnNksaWJcpEyVorspoUIr
         CYDBzG0hu4gWTQh5vgF+S0iH/8EfSLgD+j9KtXhXp4aigvVHzwGxOVCORIgNUHKD0rE5
         vuhyqDOmvSW5fCdWal6ex9kPZGhD2SVb86pS8dtbaupGpGj9ag4KPGIDi2zNiS1l9uus
         QLd6VPst78yyf1o3z6SN/4tvTIkYWW8wsbE9zz28U6JgE1xO68Fs5l1fNqHJLOFmJWyF
         TYtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437425; x=1786042225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=f8Ej7zYcREBo1Ix7zZLzyYMQJtQKmTw4vQxRTwvgZZ4l45bRzkXbQePryCxlA6Gpym
         usN/hO1GLpIZSxskRSKwpaR8otVXoEkHEd3JjzWhJL3aLkcfslWeD48SDFTXsi0PqLKN
         dhnwpfW4BT+GatS98gLfA+20Qdb3t0C5y0NDuNNK8ecekSSTGBi7r+BZol9czngbZhNW
         1ASfRJ8CxI4ptIlM4fLxkEwKq3qaEaT3qx1+FkZrY4QBhxQr06m33FACAdtcWh2LVMcO
         KAsDdfDivuX3+EnVudaXUvGbdN6y1GS41aw+5dGCImrGPpIx0wz3azmyE2bpaxUfXkie
         M4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437425; x=1786042225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=pZRpraBEJMj8z6anZ/yLyvlLSnokjy+4GBRdoN8PgB2FP/ZyQblYhWCTOsu3bTQUPU
         0fd4Bk8aiVBPfu5jHO8XpmebYhZ5Qcw0VV4+ax4AQEqbgYiekJ+U8vQxpr4+4rOozyVV
         gqjwa4758n4ui2nZPaRm6e/J7/hxI4uV/wCn201GQs9nx4ypcSFJFVPZjD+ZamYdloJg
         P5jUe0dAOHPEN096utKVB1yXxiK1WXREoKvTjWP/e0gy10KAdt+QxAA8exTqV1tDM6MP
         zLhhX+oBounEnSFVEleRr2d9wjJ5poOEYRuN8AkVybN0CIy21kCrI+zj562sQtkX96fn
         1xnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKNNaT38BheG302tzA9r+NLzooxIoRun8We7b6WOjQdUVcpnRUgt/+RKFINMPhTZYRvx3DdNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOUdKmKQQPXB+TAWuBUH9QiudAl2wG22d/LvVMmZQlQJ5t40e
	RtolGcGxrIZjPIT1vqX8L5yTfwY95AoCCiNbxVXGD7zLq3BkVUl22FomsvV/PAGq35A1XwsHrM3
	M44Xd9vy+ZczlorpucAX9Hiw8bff6fFQ=
X-Gm-Gg: AR+sD10qvoNGu1FDxE8pdJ/r544cgp9MZZNMJTPozP2eVt3icegOEqssu3LN0MdukiC
	CNAIUHBD511J1xncQyDnzsw7OhKP9RRZUMoAsagUDBRU6nd57gl1gh+WjPX20/m0xika3WAUy7F
	ac10PBsplw1Yhu2uUXFICQXUGQ8Le/HwsfW78OWhK7FYgbJbSQbcXjDGRpiCy5DMq/lsLDDLt7r
	/o8TJUiFT2g+SdVJyPIzspdYx6UQ32+8TbwkPRMutjLdjSGgGVQ/F7jG/3rnrLgL4puX6D4UzIX
	t4FyCK2ZMRoMfU8EehlmZPP4s9dMOIl9z/SVN/Q7l6u5
X-Received: by 2002:a05:6870:8a29:b0:456:b249:700c with SMTP id
 586e51a60fabf-458c0e1c200mr2600508fac.19.1785437424719; Thu, 30 Jul 2026
 11:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net> <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 14:50:13 -0400
X-Gm-Features: AUfX_mw-sWflnKZtGKmCqYRU0sb3jjE3qrtGy_CKaW2nfsOdhimFd1pr1NGG468
Message-ID: <CAEjxPJ47CTKXxx_DvSbuO5F28T-eNPnQQ+Gm_-qaAeb6R3wPfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:10=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
