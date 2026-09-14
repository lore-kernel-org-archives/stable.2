Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F422FE057
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350609; cv=pass; b=fKz/uVrCJRaZXYUYZbSV2k1zTSs50px04CUKxxTENaDUIwwtSWrZiBhX5ceOJc6rlJtmmpz/dHkktW5U+ecCCvN0nBcwqEb90DJYXhm/81fgGsKrawultR51LWdWX57rD15uY+0SGKuvsszu9tZoqYEPZK4lZT2fPqyozaQIPeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350609; c=relaxed/simple;
	bh=6JDat1egMs8T2AopmiRxNOMRANZPNk5p+3KGcSZ8/GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Riv8Ykx5Bc3rztoLFFKpCLe0dc3mhQCUcdS5aHlk26/EJWDyhJ5abEMnYO5VRgC+9vNZ4pe2xnx2yVjQSJ2B9mFmgmsOQz1BVVVwOJyzU5ePDtDbKscQHkv6Pzm1azP7ew4wO7dbE+7YH85F143aTK2n+kQ8TBj3oxF1mXMzBT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfYXgsy1; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfYXgsy1"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c25b661d37dso388086766b.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 18:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789350605; cv=none;
        d=google.com; s=arc-20260327;
        b=fl8ilgEQyJms2z7dotxzSpFlvYR88iPkMpwsWau0JpMZMDm7Tz8wyDfekY5ITEgRgs
         qh2e451QjKVIKE0/0brAfBUAs6Wh3405cD9rmI0Q51J5kKP7Y/6hOyWdCSsV2bruqqgE
         XPzCfDiLfRzwicM3yTtjx+WgH56pCfVURkXT5AMG/nr0t0TvWhp6IXP8IROmeZJb6KS3
         6QMhA8oRhUVGzgHLpkLjxXZimii9DdRN1cX2IpUwFzyxBC48zNFfi8FuEsUkNPaV9rqG
         v3MbwF9cKN9SCZ5Hr3kZGZAU53+hjawk5gb4IVG6GDgJk7Wj35hv4Ps9FECZkRtngiz1
         14hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDT39FdBcImVCPVb0QHT1U8B7f8POVTcW4tGeOBDc0c=;
        fh=tU8NzYVZMIfwfMOMmyzeDN+kTdLrlp2ubM/ElhPCVqo=;
        b=aQ9ihQRg0DUUNeeWi/aoapEOYKNTadbVgqohDtiGI8q/QsoWUcoARBKLPr1hjCNY+c
         C6/f8Y2aV1lMLBxuZ9tyjC2m2GAb4hCm4Rv49gg+eKCfN5j3hKzggx4C4lqEJL+XoUw8
         C10iy5HxsRru8q/BgZERUwOMg7lzcNN2S1EvOE4Jx4FQCNR6eYlTykhNYNj0pNA4vMJ5
         LluXXkOYN75BuV4W5T04XDKHJ4bKHnbm4iAtmpL+6qvSUYcV2Y3DBT6Bo6qb+tTdWH3E
         wxpuLOAg+hABzMQMulQsa3LMt9V0FVkYwlAj2hmC9/1oC4gYx+nEe9r2BAXjc7ssxKIO
         fMTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789350605; x=1789955405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nDT39FdBcImVCPVb0QHT1U8B7f8POVTcW4tGeOBDc0c=;
        b=VfYXgsy1FMY1HWqok8dA/7LdvG+RsQfsDLKhPFkp9EIs0X+m6UQOnT/Oy7rPO1mC0i
         o3C4h3/F5bIjs2wN9rXSHtIjfxO4QsMVD28cSA0qsA0n9a/1BXkeNRfK/+QD3fHlMYjD
         Fo5BSv8xsbJnuk46GJz+9ILoqYSQIgg5TZcCr7tML3zuckSqnth8zi43qg0sAGmrKhgq
         xaZ4YGjnpQskXQ3k6YcCaQCaVe3Xwr5+igbX82HYTOEMpfndawReGfN4ZKEa3HQ4vqCW
         gNZ6MC62pWyXS7NiTThDaDssFwzQS5TabkyuAv7lqBXEd2PV4VXb7n+9NFfpm7NH20zE
         HwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789350605; x=1789955405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDT39FdBcImVCPVb0QHT1U8B7f8POVTcW4tGeOBDc0c=;
        b=j56gsBxbGWQqZfOuxFoF8pM0GrSTdDkkSs6+/QTmj3UYAq4IQw3mZjYrvWL/ku+T1t
         /aPiu3zd1prLxj9VC22D+kMSBWk8LGWhDvmwOjb8bza8K/jziwSywGJ0DOpJ3cZ9ozb2
         Fbgm4L7Sv02J2TRzf7wswWoOd5SKV+VoBpgcrhYDOqImcPYdS01nnr9/0yK4jw4/YcKg
         Ik8ak/wpc3yffSRBsbXD3+CWBGzHwg1QKjqPXmasMq5yWjG7Qv7mGw0MuyTww/Xkiz/0
         +cpuoE8y+znQmTzeDBPHWM4NT96P2sfdxQsQqcMCiRzhXBUfYY2BmtudAF7Z5w/z0gDW
         UMGA==
X-Forwarded-Encrypted: i=1; AKwUvBzozo7ONkhrnHNmZUx+4qIa165TM0Q0CVZCPGm63yTUwNAv3rdFgFQ77/q9SY1X32RC9QSl/C8=@vger.kernel.org
X-Gm-Message-State: AFuF++npvNpZ1AiE9bUrpkYamfvyrtUvmrA8JMXpr+EKKaLESOWOz9ir
	MG93MYp28gBEW14LmtuYAUC7k8WqJkKMAHsxJ/dImqaZC1pQwnT5fIKhu90TB2KOTEkUnoVkorP
	JLqb9pRmNWJzpehBsCPyOhHI3eDkMlig=
X-Gm-Gg: AYBFou1Kf1mMmUmxzR3s/+QCxNaxa6M+DNmZ4p0RJIbPt3QLHVWUo/3HS5uZfo46Zq9
	cyf9rWlmgPVTLZRTypDWJ1BadzGcArDwU4vUkEedadEkUhZ0eRpwy/zRBOWztnLPiQJbY7D9m4n
	VybE1ELC7Xuh/j4ybWEhjuaM/arjFuISlRT0zYaBLgshoG2GgfWLX1DxQLIgyyaV78bgCWeEME/
	K8tu6qvRH+P5xbtgwsy/Rrr642dBQ0s2pOD8bEKUFz2b9bYhtytuc56eaMDO4zakZG3TciySYBE
	DLU2uVe/DejkYszhXiq/LsQ9pwBGvQ1NdrdZDa38v/ogKPlVb9yqiMTx8kbN/bsd4PpGUNKRTHC
	sQMcH6+PNy1W4
X-Received: by 2002:a17:907:1c8b:b0:c29:44b0:1428 with SMTP id
 a640c23a62f3a-c29b87811c1mr30232866b.42.1789350605077; Sun, 13 Sep 2026
 18:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913114528.842015-3-bestswngs@gmail.com> <aqc2igMKBhpiEeSp@dread>
In-Reply-To: <aqc2igMKBhpiEeSp@dread>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 14 Sep 2026 09:49:28 +0800
X-Gm-Features: AcwNN1XJfyet9Pz86i53FrvFTYUn_UoNqnMHSeKkbBlGR2ZwQU2nrN2NaQjskbs
Message-ID: <CANgPUi2OVWU+5Gsv8hy7B5nFh3n5_B+Am3Zm3f6M9Y11oX1Ocw@mail.gmail.com>
Subject: Re: [PATCH] xfs: validate buffer log item before reordering
To: Dave Chinner <dgc@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chandan Babu R <chandanrlinux@gmail.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, 
	Xiang Mei <xmei5@asu.edu>, co+af981e62f5c7171a@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dave Chinner <dgc@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=B8=80 07:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 13, 2026 at 07:45:30PM +0800, Weiming Shi wrote:
> > Log recovery reorders transaction items before buffer item pass1 valida=
tes
> > the format of region 0.  A corrupt log can therefore supply a four-byte
> > region containing only blf_type and blf_size.  xlog_recover_buf_reorder=
()
> > then reads blf_flags immediately past the allocation:
> >
> >   BUG: KASAN: slab-out-of-bounds in xlog_recover_buf_reorder
> >   Read of size 2 at addr ffff88800e40e364 by task poc/133
> >   Call Trace:
> >    kasan_report mm/kasan/report.c:595
> >    xlog_recover_buf_reorder fs/xfs/xfs_buf_item_recover.c:164
> >    xlog_recover_reorder_trans fs/xfs/xfs_log_recover.c:1929
> >    xlog_recover_commit_trans fs/xfs/xfs_log_recover.c:2053
> >    xlog_recovery_process_trans fs/xfs/xfs_log_recover.c:2319
> >    xlog_recover_process_data fs/xfs/xfs_log_recover.c:2510
> >    xlog_do_recovery_pass fs/xfs/xfs_log_recover.c:3253
> >    xlog_do_log_recovery fs/xfs/xfs_log_recover.c:3340
> >    xlog_do_recover fs/xfs/xfs_log_recover.c:3377
> >    xlog_recover fs/xfs/xfs_log_recover.c:3502
> >    xfs_log_mount fs/xfs/xfs_log.c:617
> >    xfs_mountfs fs/xfs/xfs_mount.c:1031
> >   The buggy address is located 0 bytes to the right of
> >   allocated 4-byte region [ffff88800e40e360, ffff88800e40e364)
> >
> > Validate region 0 before inspecting the flags.  Keep a malformed item o=
n
> > the regular item list so that xlog_recover_buf_commit_pass1() reports t=
he
> > corrupt log through the existing error path.
> >
> > Fixes: 86ffa471d9ce ("xfs: refactor log recovery item sorting into a ge=
neric dispatch structure")
> > Reported-by: co+af981e62f5c7171a@bugs.sh
> > Closes: https://lore.kernel.org/all/aqZALi7GdVprcNOh@cronus.toxiclabs.c=
c/
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>
> That's pretty poor form - taking a bug reported by someone else and
> then reposting their proposed fix as if it was your own before
> they've even had a chance to respond to the maintainer's comments.
>
> And that's even before I take into account that the proposed fix is
> an extremely poor one. It basically punts the broken log item down
> the road where some future processing operation happens to catch it
> and abort journal recovery with EFSCORRUPTEDEFSCORRUPTED before bad thing=
s
> happen.
>
> i.e. you didn't review it, nor did your directions to the LLM that
> "helped" you direct it to determine if this was the right way to fix
> this issue.
>
> To compound this all, I've previously asked you directly to stop
> sending patches that add random verification checks to random parts
> of log recovery and instead spend time on actually addressing the
> root cause of these issues.  i.e. that we lack robust on-disk format
> verification of the journal contents.
>
> Last week, when someone else posted a random 'log vector is broken'
> hack, I said the same thing (yet again!) and posted the design doc I
> wrote a while back to provide robust, generic log item validation
> for the entire journal:
>
> https://lore.kernel.org/linux-xfs/ap8ucHIw-pKLhh9c@dread/
>
> I posted a link to the git repo where I've started this work further
> down that discussion:
>
> | Ok, I just posted my current WIP to the log-verification-1 branch
> | in my kernel.org repo
> | (https://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git)
>
> That's the work we need to do to get rid of -all- the journal
> corruption issues in one go; once we have that in place then almost
> all corruptions will be caught long before any of the recovery
> parsing code can trip over it....
>
> -Dave.
> --
> Dave Chinner
> dgc@kernel.org

You=E2=80=99re right. I=E2=80=99m sorry that I overlooked the ongoing effor=
t to
address these journal corruption issues systematically and instead
started from the bugs.sh patch, which merely stops this particular
crash rather than addressing the underlying problem properly.

I did analyze the crash, test the patch, and check that it handled
this reproducer; I did not send it without review or testing. However,
I understand that this does not make it a good-quality or appropriate
fix, and I=E2=80=99m sorry for submitting it.

I=E2=80=99ll follow your log-verification work and would be happy to test
whether it also addresses this issue.

Thanks,
