Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B411559C81
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184037; cv=pass; b=FHI0wn86Tz1C9KyYwj+iGX5lBEJNOQcNGd5UJ6om5dBvZS7/klfEhNpAoZRPB9CexnhIgckuqNlVmmvCOKmdEz/C/N7ajInhJBkEU6XnikJjNkFzXjob7mD5EvTsGXdsNYZhkW7svpUzdrvxhbbMB+qvniQdJYhE5K2ALYTl0Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184037; c=relaxed/simple;
	bh=sJI2mOCc7tznZH1xeE6WUqxrzQLAatMXruEgFfzLUks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSemYAbHf6PpLov/O1d0SNFLCk2o3mhw5vI9LuGPP04o5JlALb9osOc1L3AKsDfbTiARNsClyrixAqPUaP3ZkLRzff+NnKzUZ8EW5m7eELcOf82yz1f0l33oew6bAdOIYbkVOjofrR3m5maifZkx1UVwnOf9nh6+Pt2HpRSvEPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRp5bbzk; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRp5bbzk"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-467a6834028so1888575fac.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184034; cv=none;
        d=google.com; s=arc-20260327;
        b=LCT5lLbOdlkrSgiEp/bV3yREiyaT/pKeRuPKr41LxOaNiMylhDnUBNEF2jNSgBzvSs
         3QhBUT/xqYM/vEqHqYz/kkd0Sp0MnYW4LZXJzxvCr34/7UJlefr46bXouOfK58PzehQh
         hHkP0GgDtgO2v1DUi540EdaoUzJOcSouZIuivuENAmEVrOVEYKbiMsv+fSROpNZsyqiZ
         PcJ70PoLnXH2m0T8tQUeir9BxIM+KI9sXnPqgLh3kXmESPfu8MWyHJmnBig1f8/Ie+vD
         n1rvNiz7JJyCi8b+kp1e894y9rXqPP7jwn/cvTLs0EHfnJrwyotO53EGA6YqnwKJsaOL
         c06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        fh=blHsnSfI9JNf60lAg5vzcHO4oP/EmjgxdLZnkAQPtVo=;
        b=WmdmMuOgU47WneI0t3YZcUz0NwUHfFhuMU9JbrBybHrknnK+wlaMDxnk2ib2kPEhXw
         eOjNse/xLj50sFe9wesBGwa46GlbloBUo82K0nh5A1lQOALknTt4fxGSu/qW/8yvNhXA
         YjgjfbYLJfxmD2RClPUo+X8qCunGZZpdCP7oMHcUYu2QEGw6bp8YcmmNEVL0piPxkn9o
         0JoDfOKF+pHI0a73YG9YwCwXGAEiUQ9cOUWqiOD1h9pKyDXO2nnSz7vhp84jFH/GS+8G
         4aVwaJk2Bqlenb6pMHF7/IquDP+FCppuP0ik838Q1t2AUveyQm92kQW8ptcOEelTfR6P
         nA6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184034; x=1788788834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=lRp5bbzkRDRp1K+S8y1GX09DnnKFU7PE1Gbf6wVUdRHBAavcLK4s2XmKkW5zbMKSUK
         k6b2AzuuUC9a7Z1nvd3ZtIdvJdHipXL1J/VlYPmBCx1NiiALUOaF5dPz/a496trHg7fP
         chBjZyGRuV3NAxUkFIASlQW2GilvxdaVd+N9cTSaGr6H6Xp85ws7MyjeWL/sI3eB5VXc
         /7EcPZd2gmttVD7+Li51Rynu7ka0bZ/3j2Q+422slcn6kD7sSyGPEzjjpp25mnyuTqt8
         L2eMwDUbUrNAhy9+xgz5EAq0+G462Ra1/xGYwnCNWRb/7Ds9favOJtVkBQJYNin17pzh
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184034; x=1788788834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=qJjPhWPnJAxExf8SDkqLTzPTshgkeY40zA16ZKN+ZE5b3K41Eloh+gNm7pJkzJuvwj
         5LscHZlpYN6S48xCkL3NiOYn7c0cOUkS0NbB94l6Bj5VQ7cAImIYSw7r0Gk7/lNho6eL
         9Vv1THKyX71SNmqMQQSdUpTy8L9ows/4mIaJgBqfjKW/fW0K+ysbOgLhvRuW+lx6Xi6a
         LBFaGG6vPkXyhYc0BXosd3D4zYvvgRhYRWH9jF/VGLwI2tsEkwAVlc92Z94LBFpE8Hp8
         amuy71h2LeKCCkZaHBydPPF5fZW0VJ/gkJFb1XBu9pCAi7A8xs/ettEkz3EquzXqg0SW
         K/Cw==
X-Forwarded-Encrypted: i=1; AHgh+RriWg6WIk6+MLi3JtQ2+QcMLagJYy7VoppqJaoOMcTZ4Pze406f2GfDqCUXKsGheCiOrDoIhCA=@vger.kernel.org
X-Gm-Message-State: AFuF++meXaIMMMU0cFMaA7V1w6v26LgrUvRJnDhuYx7meC7FtNGk74f1
	6gHXcRp0eIdJQDLPTHTgjfoCBfdvgW7GqN4Sqa+/NeIdQVBPXu0EXJPk95ITlCPmEYMOyVnBgf1
	D2DePgrlUoc4Kx/hvlZXvdTkcYjY0uR0=
X-Gm-Gg: AR+sD13G6t0Ft0HPr4kF3qTAeK/PDWIhje5Gt7KCcLi33Ji6zD726rGcO92j4h88JnK
	jeCohkmYt9TbPjoOFIhWP6KnbM83KYinEp2N1Ue4mpRpm0+JvHoxRAERyzQHTM9YqU3KJGpqbVl
	vDzUFtD5LCrQsk+UuVbn+cd0BHIkqu+jqnJ6bl/hAnfXvfPbztG5uDgptiVpc4d+V1k+gxFOdnw
	woDRF93Dbq8HFBo3CcVmqH/+pTwyRUXOfdTtQCHOkPXazysTKcbn2/SivN5N6xHqiw8Bfk2x87I
	+yXQ5viPJBVQ/jM5SZRe8ZA+KtsRSRRJbBZtRUmPLSMlHw==
X-Received: by 2002:a05:6870:9d94:b0:46a:9a34:c571 with SMTP id
 586e51a60fabf-46af57f1aa7mr1054584fac.19.1788184033715; Mon, 31 Aug 2026
 06:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:02 -0400
X-Gm-Features: AcwNN1XH17mTpK2KblerbVrKlCve1RclfFZ2A5wUG-rwX01P42n-jv3618nmM4k
Message-ID: <CAEjxPJ656tz7PZuVfKU5W6tBU01-Y2+EoD3wLQBanDnj2CbXng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing files
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
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
