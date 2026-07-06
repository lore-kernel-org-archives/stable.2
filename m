Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E583BE65F
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317615; cv=pass; b=BfCn9aMMST4V7R/5wrwGCF3XmkkQN8Kufvx0me9nS/e7VqUl+FRIWgLzWmIgwXzUItTfUcaY5Qs4yrWiq4GUTBxwBf6U4O6dX2vxUgKvjigHybvmFmEFa79h8KRYiKxmRPPwF3GYiyPPUWYxhbgtQQJs8Zr/pV32PbZpurK+pGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317615; c=relaxed/simple;
	bh=mrGgV3Ki6iMfxZeJPB9zF9sxL9/CQFbESY1EczbAqsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub5/0Hb4VA3bpds7YqJDGwv/MJVJnSZQ6kDgaLrKmgVxdxWvCel2/r+LlA7SlZjIF4NQsHm1cx1JpGIzGGhkPdCwjK9IM4w7cPm18esKZ2UrWa3Ik8PAUNsICtRhZmliifCh7dNII1OwFNbar9RJie3gm1+o4RIoSPAqkK42irM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/YtxncO; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/YtxncO"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so4468192a12.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 23:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783317611; cv=none;
        d=google.com; s=arc-20260327;
        b=JYr4Jn7xp8EbHOpIqtOpP9m3QJykqExAvxekEXPVZ64d3Flkn3XAtsKZif+mPG5u9Z
         g4PKHOKjdJr693b0us6VmGV6pH3ryR3gWqCaTG/iplQ+/+il5DDiBEDnI1mU0OahXfNN
         I6FIqUIuot97Ysgw+hzoArBqP6y9MPYeD6jX6lFbFp3tBavGOtUouL1XmpcZVyvV1kAL
         B+Rj3ABjP3srDaQVhicqZQVQ57UJTIounJ3onfJgAk7OdEP3iApiD6/rJkUrb/SuV5Gk
         0gkcWTZh3NEY7hwttgjxKYZjxEQEWu17Dp3d6+5E5yF16HWF/LzOrGL6TKCKjUIBwP8p
         NU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Md2Swp5Fs6VEhfUnYJXkmbFWYzZQ1C9WWb9GsSoCCA=;
        fh=3seaudq0a909lAHBkXG8hm96RYIjf190cnAPEUxvET4=;
        b=Tdo2BNKMUMk0B+/FS34lMfP+xZEBR5PLomsERGvDFI23DTqBSLCVG3scMXLIB2v9Dy
         MAa4sAMGk1sSYm09piQHxNzgG6wGeLLPJ7fS8/9/Uh20miIXvmO4sv7fRAHPC2nCPbDr
         uR3EtmaVI3AHVzWgiNazObA8Kl45F+4j6nbtkjcFWZedXCaFRIspwUUG09GchWHMly7S
         ynVGJTNrL83rGU/oLFGUvUGnxx/TF6dmpyRke3Yo2CK5PVBMBdjO+uZeI8JTSGQNTpNB
         emk6cxdDJEHU2Y8l387D9lSQZm6en+XRCteNr0vTh4rcvwv+TZ9n3Ch1w2TBopmWReV7
         x+4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783317611; x=1783922411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Md2Swp5Fs6VEhfUnYJXkmbFWYzZQ1C9WWb9GsSoCCA=;
        b=l/YtxncOwnOQGS3jNHJWzU8XWgeVQqnqsgsGW0e3BbL2lMPh+ZI934yK9pyRsL6A7F
         c6N7n9HVcgvWkseijICaIXfMJmqlvHO3ey/UnbA9n24094ISBec/1ByBE/C0a0RAKdj1
         FShb8cpHUKqZ2ieFs10pb/J/Y5auG2yVlogS0bH/tS364n1HcwI717ZAigWLqoC47J2c
         nyin+Aqmvkgjv6tHJyFZ63BXn9B9jrWz1I1Ygtrcfz61Sbve/VZMHBueu7k/79x1Br6y
         BzrUkSz1qWfl49zLXfvig66qfley7QEfLLwgOZuAomB14atXd9NvZvID/Zwn1BvSSsHf
         NbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783317611; x=1783922411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Md2Swp5Fs6VEhfUnYJXkmbFWYzZQ1C9WWb9GsSoCCA=;
        b=rPW4nDH54ZfnnitSdqS5KbxosEA46qklKTXStCYv6DdKZWfPN2am2rT67MxkxTR9Jy
         f7IKNfiLOTTkuWfeCrP/JoTvTrhW11MoolsDOS3V7DzK/Wv/WBZgWQfMTkin4LqpI+Yr
         GVt9hyHaYyasnGtJVJgdyR4WKOXpD07evzy+Zu4nXEyAzdLEKp5BYW92QnipY+k4XSx6
         MaW3wfSidNAven6j2QHWx05ULB/OzPlcObYdr/Fky+iXdem2Xhfe3ecmLPYaFXvoYLzV
         +qJvvRvffOQeYQTgov5cxLo2qUsBDQ0ju0dPXrQjPl6xAn6UQC1MXeIU2b8qlUuMGhCZ
         reow==
X-Forwarded-Encrypted: i=1; AHgh+RqDa9I2a8jwb3mt1UQs3u8J0ZizdA5DnQ5qHKhagcNYeQhjfZvXtn2FJOt45qGIdnhMForf6W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYR2MGr2ekHCD4Eo0vEIRKXmkdC5hPRalDs8mErZTpVuYSAO5G
	oQi5V1L8mPvwh1Z2Tqolum8jwQeengpLxuJS6JzpifaOqJ4seXfu+uWWQ+qB2v3ex2LtyveNtLr
	3DSNncvuUaZU+HY6lXKOsrxCjPfqBsqI=
X-Gm-Gg: AfdE7cm4Z1z1CoePATq9h7nmihw2NOrqqN/s+m0y5sYrzEFxSw9Mh6ADvZItacVUsGV
	/wRe3DAWUljPz7Wv6KilFZH/ZLDhPa6VLdVjdzkO9YdAcZPSw37CPJfxwdcofVFa0ZSXtl/fv4Y
	HHlNiUiF6NHq99Rybi1nWQgkeb6eXQ1qNaPolLa7Ar48MDOIbw1ojynfi+cDKy5bIycxaeyoyNn
	+zDRrudS1LZ1mtwbF+7+LsJOmVpiIaecOPScJa14h62UCPF9yF3Nn5w+3GIcJX9lIzbsvADROE5
	5etm8F+AnNWGd+nDSFgvazsVIKnq
X-Received: by 2002:a17:906:6290:b0:c12:e178:9e84 with SMTP id
 a640c23a62f3a-c12e6c5ece8mr301352066b.49.1783317611266; Sun, 05 Jul 2026
 23:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 6 Jul 2026 13:59:34 +0800
X-Gm-Features: AVVi8CeDS7jwf4J3Nj3CLOia27um2hs0j7p6dhEkBGx6Lck3Udi6yttVyiSYd9k
Message-ID: <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem
 direct swapin
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, stable@vger.kernel.org, 
	baohua@kernel.org, machao26@xiaomi.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:25=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> When skipping swapcache for synchronous IO swap devices, swapcache_prepar=
e()
> is used to prevent parallel swapin from proceeding with the swap cache fl=
ag.
> However, on PREEMPT kernels this can lead to a livelock, as reported by C=
hao[1]:
>
> Thread A starts direct swapin of a shmem folio and calls swapcache_prepar=
e()
> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault=
().
> Meanwhile, a higher priority thread B also attempts direct swapin of the =
same
> shmem swap entry. Since swapcache_prepare() already marks the entry, thre=
ad B
> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. Bu=
t as
> thread B runs at higher priority, thread A cannot preempt it, resulting i=
n
> starvation and a livelock.
>
> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
> swapcache_prepare() fails, following the same approach used in commits
> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>
> Note that mainline does not have this potential issue, which has already =
been
> resolved by Kairui's swap refactoring work[2].
>
> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.c=
om/
> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@=
tencent.com/
> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous=
 swap device")
> Reported-by: Ma Chao <machao26@xiaomi.com>
> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiao=
mi.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Hi Chao, could you try this patch to check if it fixes your issue? Thanks=
.
> ---
>  mm/shmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 94c5b0d78ac3..d4cb57b3b0ef 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(struct =
inode *inode,
>         if (swapcache_prepare(entry, nr_pages)) {
>                 folio_put(new);
>                 new =3D ERR_PTR(-EEXIST);
> +               /* Relax a bit to prevent rapid repeated page faults */
> +               schedule_timeout_uninterruptible(1);
>                 /* Try smaller folio to avoid cache conflict */
>                 goto fallback;
>         }
> --
> 2.47.3
>

Thanks! That's much more simpler than I expected. Do we need a wakeup
queue like the one in commit 01626a1823024? Perhaps the reporter can
help confirm and test? I personally prefer to keep it simple if shmem
users aren't as sensitive as anon users.
