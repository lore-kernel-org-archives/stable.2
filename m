Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792555009;
	b=I1wJ2I/bf81fnVDJYeO/F/jF5emzmD/3VbbYma5Xxy8UP8+5pB/YPga5UIJruy3rVztV
	 Sh9U4Jc6Y3NmSpQHnNYH4Woq84oJAawoHlsvY0O60FRSuIyReMslWa6xjt2SXV5Bw4B7p
	 JEIuysqIn5knKohQEt5MGEFBh0o5WleLCmlp97NP/M3ekWmnEZlPbZ40c58tRB6mQuNV8
	 bEOF++1Q9o58asgYdmjl6ydwsNfLvmmjbfHTlZgmQgmbo+NqXWwXgiuWWtO32a3gxeyUo
	 HI7IiBN+mI0V/imccBH5ClGbn/lvoYQgsj+wHPf/OEvuwM6wghHgtDgWA2PX2CszJtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TsxIu5w5FY3ABJNnJou2C+ZIq2e5DebUIuAtyHX8ZHY=;
	b=D6DhH/r23JETCeNrS1dVHzQx8q+1G1kxZYphRQDyEICxRg2YCokaE2P19LKvco/MMf8w
	 W7zqE9Z29pmmBFRgL/8qdx5EN/5LgbTXS5FK9ZFG8qNNGMfnvZECw6xBzgG93g/OMzKuW
	 FwpqOGKX1afMwzaZNUhqC3cZ8WeBoeajGiFKk4Qvu4qMlftO199LioxuOgA8uKre6597B
	 ZOSh/89RzZqXSV2Ow264y5R5EBuIYurLyO8ovZdQxqgtt5huiMaKoBEk/ZSXA0xSZnJqh
	 ctol6PEWJu7PCPdoBCsLMo7j7rfrib1yNMk61xd5gnniAg6UVDP/KE+rSMrEMcqORpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aL+Eihkq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14A606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D14A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aL+Eihkq
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b83459526so3970216d6.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792555008; cv=none;
        d=google.com; s=arc-20260327;
        b=dK5Ky8I2+I6lJLGOoEVDyHjqZ2ePVkwQKA7K+D0jkjzdZ3Qb80z9/Li7TH6+hO8ujF
         kIYnUbW3w6BJ2A654bt8WnqztIjlV1hHXeVdu0qhUdfG9PL00JJjmp/szdtD0YXCDZmX
         j7b+/nrDnJ6ycbKe5MHEbigREUCYSYMDQK3zfdEs11IvowbRjbNBqKybPyD6LRRO98KC
         UH/7u1wR2zaw0vu/Jn6HcnwS9mqx+yrADkoM6KOQZBvF56tVeE8MdZnA/YgUcDyHEphY
         b0HmPM1mxwp1RWxYQZg1QwuHAxNwhvwTfw0O7xKCIXuRah8WAJOEhXBjHAjwaMQRuh1S
         C+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsxIu5w5FY3ABJNnJou2C+ZIq2e5DebUIuAtyHX8ZHY=;
        fh=vBr5UQjdpMTKCbyOeZbkWaGrITe+9WuMAq3W4AbYN8g=;
        b=mNc1vMa2QKKFxrilCx/AWN3Bg0v923w3wJVZhe0G33Fpzu+iMiSRoCwS2LVbbJvWTk
         YrU2k320slmKKedCV4TyOaemepXa0rNJ8WyqQPFASlv8zyRIDTYfOOilD0DHvB9pjPX6
         po3ld2L+qbarQYur2KajpwnN98M5U1fbdkt5GCzbVFweJ525pNZlPtQZ2pcX3SIVqfgE
         rkzP9nE0oLABrseAMX7qCtltBB6+c0BmvViWKVR8SRDRa4uv1ooRKTIPyHtJ1MijY+bY
         lOujAlZ5hB2J0i4bHtFYS2268duDS67tPEes2Sag8QmojmlMSowoGF0uB8NFuIK0t+5n
         mEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792555008; x=1793159808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsxIu5w5FY3ABJNnJou2C+ZIq2e5DebUIuAtyHX8ZHY=;
        b=aL+Eihkql5I2435do2UXmzZTjw8S+G0swn+RgK8kqDk4s/RGVdvrLOKwlYQjHWCTKK
         MsRNMDi1OItJ+BfgUKb3N3JitUpNb/cxGLxqNjV/ujmsI2V/T5akTWrXpBaBvzsoaxWl
         99WitaldvKWquvxj764wQpiTGzjEonBQgAomKgzssD7aCdqgq15zscQUoxQL7OPvK6cY
         NQO7eUGA0y4UW6YWNifG2olaIlFHW/ylik680h7hZr2b/z7oQmFaOv7FhOxNGA3lT7w7
         DLkN4USI4sjMYQYAOF5vEhP8CnE8VKRwzOEx2slax2gos05BXgN7g0wFbEeADwJhOZWl
         9kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555008; x=1793159808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsxIu5w5FY3ABJNnJou2C+ZIq2e5DebUIuAtyHX8ZHY=;
        b=QtE6is9RCg6gIEli7o3b3dlrZtnR9oCeFXGdB9UpdA5LGgF/tEPLd9FP6Ae80dPQwp
         CsDvEZoy5RcyWuXXXPF47AEXqTLGHygkRBL+BldnMyhbfbn529XDvxgY+M2wARj7/QJW
         NW34Xt+9VRrws15Tscb9GwJMXO1Me0u82/9pWkGGgiRJacBcQQF7RP5I+JXQArIWTB4T
         2S4cs8055B+++eSKMyXMwgpeITrcnNmC61tmtGP+WH8y0pdp3+l3iK60hrMI9oA88yAX
         FTR+TwRH9P4x2UZAPtXts+yEKfjDFz8gL2Wo8QDAgeCBi3ZBbk1c9vNFzxXKfKI//vYa
         jVYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFWqJP0MPF6wr4pXTI79Cj93MKeMOK4kXBnp1OiurrhS+REUBPO94JI1gYrKBCZcVSkTl2P/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuF2126kI59spljVt/jIeZbPjx4UzMIFtnjpUQQqScPUwBcrGU
	z7q+ju6VjtikklPIRJ0ux9iRp1D/kr/TzolU1gYZrd4IPCJYSKKM4l8SJHj5VNsyBfxnHlRqKWR
	DD7a3Si4XndJZ79sLDXy/5W2TSLNy7rg=
X-Gm-Gg: AYBFou3PpKU6y3YqvuboDTdATYrqgald1wW1M8E3R99HdKpRzwcAB9Zw5zCLghMzhl8
	iKyccb5udKsTo6jLdkC0xu1gZSOzsBCkhpm5owhfAc/K62qlir2y0JqnkJnW9Q8uZkkkfVI+d/Z
	BZd5bxHL/8WLSGe1Ai0YBp6lZemnjlHeeqy3RG+KivSXh12+7d30w7DRgs+ntRR75cUt9lvUnhy
	xobiOVIuCHSmOlswNviVfB1K58dLtKLMzZNdRh9gK1LveqXwjmuZ4KAqS+GoDLfuQ7d9oq5kaB8
	nIkITS1MZAj1OTfcbpsqxsaTkCB9EKF7gBcyJMUaMy/K4mq8UB52+ono1yzO/yFrslWeEJWYyVM
	9g0olnOCa1gkvqq3+9PTbirj6A8DaG0YJ+Ky7WbAKaYMdIUoNb+9ZP7i3D2iyRA1hek4o
X-Received: by 2002:a05:6214:2b94:b0:914:4511:9271 with SMTP id
 6a1803df08f44-91c12f031bdmr16014616d6.22.1792555008068; Tue, 20 Oct 2026
 20:56:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020175254.900284-2-bestswngs@gmail.com> <CAKYAXd9nwp=X8AfzqTs9231i6SVoX7wuBqVvUfgBP2a8xrt+ow@mail.gmail.com>
In-Reply-To: <CAKYAXd9nwp=X8AfzqTs9231i6SVoX7wuBqVvUfgBP2a8xrt+ow@mail.gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 21 Oct 2026 11:56:09 +0800
X-Gm-Features: AclHuK9edLT7Ue1NZq0Si5aKsqQpW65ATZGLO5S5vLoxrR-P6z-TcbrWHv5GkKc
Message-ID: <CANgPUi1Tn8vvQTWNCXUB9qPmy-LqXk_G8YiwS4DMU2kei3eHaA@mail.gmail.com>
Subject: Re: [PATCH] smb/server: prevent file publication after tree disconnect
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org, 
	co+d531129f2f9fbf88@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Namjae Jeon <linkinjeon@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 10:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 21, 2026 at 2:53=E2=80=AFAM Weiming Shi <bestswngs@gmail.com>=
 wrote:
> >
> > TREE_DISCONNECT closes the tree's published file handles before marking=
 and
> > removing the tree connection. A concurrent CREATE that already holds a =
tree
> > reference can therefore publish its file after the close pass. When CRE=
ATE
> > drops its reference, the tree can be freed while the published file sti=
ll
> > points to it.
> >
> > Mark and remove the tree connection before closing its files, and seria=
lize
> > both new-open and durable-reconnect volatile ID publication with that s=
tate
> > transition. An opener is then either published in time for the close pa=
ss
> > or rejected after disconnect with STATUS_NETWORK_NAME_DELETED.
> >
> > Keep a tree reference while a file carries its tree pointer. This prote=
cts
> > asynchronous users that can defer the file's final destruction past tre=
e
> > disconnect.
> >
> > The close pass can race the successful FP_NEW to FP_INITED transition.
> > Take the opening request's file reference atomically with that transiti=
on.
> > This keeps the file alive until request completion even if teardown rem=
oves
> > the ID immediately.
> >
> >   BUG: KASAN: slab-use-after-free in proc_show_files (fs/smb/server/vfs=
_cache.c:126)
> >   Read of size 4 at addr ff11000101540f80 by task poc/153
> >
> >   Call Trace:
> >     proc_show_files (fs/smb/server/vfs_cache.c:126)
> >     seq_read_iter (fs/seq_file.c:231)
> >     proc_reg_read_iter (fs/proc/inode.c:299)
> >     vfs_read (fs/read_write.c:574)
> >     ksys_read (fs/read_write.c:716)
> >     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> >   Allocated by:
> >     ksmbd_tree_conn_connect (fs/smb/server/mgmt/tree_connect.c:35)
> >     smb2_tree_connect (fs/smb/server/smb2pdu.c:2819)
> >     handle_ksmbd_work (fs/smb/server/server.c:368)
> >
> >   Freed by:
> >     kfree (mm/slub.c:6801)
> >     handle_ksmbd_work (fs/smb/server/server.c:332)
> >
> > Fixes: f44158485826 ("cifsd: add file operations")
> > Cc: stable@vger.kernel.org
> > Reported-by: <co+d531129f2f9fbf88@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> This patch does not apply cleanly to the ksmbd-for-next branch. Could
> you please rebase it onto that branch and resend it?
> Thanks!

Thanks for the heads-up. I'll rebase the patch onto the latest
ksmbd-for-next branch and resend it shortly.

Best regards,
Weiming Shi
