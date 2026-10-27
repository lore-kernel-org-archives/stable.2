Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101877;
	b=uZU2v8E8LCLnz8JkfCsKZCxhpaIxQ7e6Q4xzwHk94mMhGjnWTl3Q/cgcbjNSZHYlpAdh
	 oj24KCPyGeeDPSKYWqViRsuUaeGMjCcpSfXdIyD9yiKFIknXEqfTr/3nheyA7Hdf2vvmk
	 uHZgGbtjY1NJc76P1PcOlyWUln7+PfIIIV8pF5760s2wWWRVl7oY3ysCovHB/UTjMbkK1
	 GKinG63T1ZF3oWco/RkLfI2qgJbbuVCdpiIuunSTs6ebbFYLRJrS0M9tedfJxqaMSpYQG
	 mNR0OhPjBVDXHYLQdNDyScw4VBdTtLtGBeVtFhH18F1reCp7+I9lbvRHd3RFcEVmvDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bUmrBECpx6IYHNhYlc5fazHVSIOYBwywuUSfjizohv8=;
	b=KcE8D4YcA39hRHIvx0h9BZLhr4uqxRGVC3abRa7vYE3eIYR0Dry2DddLofIsxrTgGyZZ
	 CF8JD349fPZUuxZRKEr7SJsMzep4+uAl5shVCJzHmGoIjVoBGDJx5W7gVjgGWLhtmLqAx
	 nlU5HN2hDGhckhuvknYSkhPd/Dq0MX85xJAe7C+Rx9sTSJb+fkEdrmvY5O/guxOZ5ioZZ
	 5oe/g83AYfizEOMD/OZYFP6RgbMUn3KIiucB4OUGnmlF1xz7012u3X9d+wzSrX8a2wg42
	 RwceKNxdiO+/jwokg/Ily/rY7bQlmklg2kxGmmFGtG7RrAZfwug//89f6n1s6hLxNqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQ6r7idL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CD606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 717CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQ6r7idL
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05b210703so1619308b3a.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101877; cv=none;
        d=google.com; s=arc-20260327;
        b=InwcQEKfqFCrEI8QATkFrLDAEdSj7R4H1H4/LY56ShjOBU/czREygRu6NK4vW5MyyC
         8E03dSG1wqIz+8swkeXsWr04Xpp4pOfJuuz33biy0DyrXQukuVmRw8VEjUCEhyB7UlnX
         mvJS+UiynU2O0lWGFz8K0q32xA0msWSfb9zihgvYfSy2NWQoLAgxS2S4J3k7zehiqU3j
         i0FFZIL8s69oqJ6uboyPOh6qSu1CMH461SRj2qDckGzJJMnCt1A3wEM8JHmRsoBKnGxo
         xF0fI18D7eNjRqkluKldUMV+7kwmfXzyqy+5F/nyHqFZ2aEAf6wrkI7NJIqx93KU2RHW
         pBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUmrBECpx6IYHNhYlc5fazHVSIOYBwywuUSfjizohv8=;
        fh=F4ZbcI/KCo6jR7a1Hkgb3RqCM6DRrraAQfTRsBcZfps=;
        b=O+vOjzQG2OXCeq0BM1aYmZTx6zcC9v8XlmcQwT8O+A/CYnu19eHkUtVrSSLYvgyR2R
         N8XdSCScXZ/ZUfh92emIVzGeF9dUYOAWBshgZ/O+nYgZlluy0mz50gDheKLII3SVdTJA
         iTEz8nvmmzoWtXsxkBt/+iRf5ERXtXXY0+UF1VnYhxDfF4hD+LX9tTNEEzYnHGImsBuH
         Lt9TYUuITG3xvG7zR3/OKWzT1Co6lGjmHCIlbBGzoiwWtwgUKbthfsrrtrOF/bN67Kz3
         zUuapachgSxLsZ5JIHqPF+XR/E6i7KD/r0885hLs0TtSJdisQR9yDLFisZjCPDVQ/KuF
         hXSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793101877; x=1793706677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUmrBECpx6IYHNhYlc5fazHVSIOYBwywuUSfjizohv8=;
        b=JQ6r7idLn9Z50qkJMn09+UDiGQzmbW9+4RZq4mzsCoUk9Xbc3yFQvizx+Un6PkNLWO
         kGqnSyBPImUxRi2caWb9IpN8Q1SmVPssMpllOWku5yHR0s32vfXh1STFUlr+qUeUiq2a
         akdnnxd98YS38qFxDWGFalP4HIpfOZxqhXVyHRwfzrGzh55mNfVFxSb0+/jPxGu9FSao
         Y0UzeJa153BZCE5p7Xgln+2HLlYI6CfP6Pze1/2vIfsuPORRFWfS3UFR2NPa78zjGzkV
         JxDGws6lWrvo9FFLJxJRTHNbGi7/mPFmBACeN7Z2SyB+I5TMgmhTd2416HzwOSRHU1sa
         C46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101877; x=1793706677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUmrBECpx6IYHNhYlc5fazHVSIOYBwywuUSfjizohv8=;
        b=rUz9xHzuzawYLPcwgyYmjJe7wcpScFQM6NVEHhAcQrbDiOFuw2wV9koYtyY9SbDota
         jNeYXk65JCYGk2/bC+R1dveATr1AqHQY/tMO+UZfR5RJfWGh4DZ1jhPI3+4fDAMyiscI
         ABKika9j9G6UodH1aBESDl+bbHMIZFLVQWUlo0akfh0Ga1KZyFsqLj+OUNQT46wPHgze
         cFuP32jdZ/Er8reQ1eRuVpYfdOWWeCh5c/e2yABP4nlG/bVU+TgtLvyQ9eeL57mmA99u
         gNZkJqqeSUSQNaRmLbyG4B2IoPp0B+zflq0kCoptD95QQ/ARqVA2oIA8SbTOmQENVW/U
         bgEw==
X-Forwarded-Encrypted: i=1; AKwUvBz1sU1OmIc1hqp4Bk9JKLv1QQXksNOJfeJsLgkPH7LLHLSDaPVOJ15PNyXeHQOu0L1GoDQMSlQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSP2rx5+a2B5LTjXj16UQGasmUsg26BtD18YEnxO0y9EgUYxfY
	jenZbstXJdoQi/1cMmhShe2FTpEb/IS2j7o+lqutqQRmIQ7TTRGmnCKpmMgedTIZ/Ntoj2s3y5Z
	hhNXNOQEXjjb82VqElwVUZyLHRJ3V1/I=
X-Gm-Gg: AYBFou0cCb4gTxdRuO+9j8iUe2VLES+0c1ywyy/YfBsxbnrSYp6zncowl1XztcxFPhj
	njIJvyMPY6YZUMTqcNiy/wzz348o3076RSQYGeFFEJnmTXb9jBEfVU5n9z0kzhGI0dMXRzrObyd
	cOrCo9D8dG3f1RWIeAMLFBgZqTk019jzEC5EnznAKiEUanztzASfC4/LEq5A0sGSPn1OqCwM/un
	pzIa7MplkStj8n6yLLCxufuYzfryAq7gRYVUK+9LGI0LUxZPgA79oM+ttH+S+U6R3tghG7PsfeR
	+keONh859zcsvVs+syI9OtlERUmpEoTJonUVUS5JC1sgDkMkpNOOXtHZvb+XDvEQ/YM8u93ZNk/
	Mvj1ev8O45riN8vcIDXtUdUhgehL6EOmERlOjyRRGkLrrLv/VBg9Z4SNc3+o4yJr+qg8V2A==
X-Received: by 2002:a05:6a00:3a1c:b0:8a2:753f:678c with SMTP id
 d2e1a72fcca58-8a367a36c76mr7405483b3a.16.1793101876780; Tue, 27 Oct 2026
 04:51:16 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ar2YlFYjYUZ49ZA5@chrisdown.name> <at9kJwdGkHPsWwgG@chrisdown.name>
In-Reply-To: <at9kJwdGkHPsWwgG@chrisdown.name>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 19:50:37 +0800
X-Gm-Features: AclHuK9w3cu477cLAvN2jZ5u1J4X0qRFiJaPiVLgSpXQ2zVF3SsFLR12fIJNRmM
Message-ID: <CAMgjq7BG-hM84bS4yRs1Bpo8=vhq1yoJPxkNpkvUhX7xCit5Pw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Make swapoff interruptible when unusing mms/shmem
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Kelley Nielsen <kelleynnn@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:35=E2=80=AFPM Chris Down <chris@chrisdown.name> =
wrote:
>
> try_to_unuse() only checks for a pending signal between mms, and
> shmem_unuse() doesn't check at all. That means that once swapoff gets to
> a process or a shmem file with a lot swapped out, nothing can interrupt
> it until every last page of it has been read back in.
>
> Just as one example of where this can concretely show up, freezing tasks
> for suspend or hibernation has to wait for swapoff to notice the
> freezer's fake signal, and gives up after freeze_timeout_msecs (20
> seconds by default).
>
> Here's a facetious example where one swaps out 2GiB of one process to a
> swap file on ext4, starts swapoff, and half a second later tries to
> freeze with pm_test=3Dfreezer. Writing to /sys/power/state then fails wit=
h
> EBUSY and this in dmesg:
>
>     Freezing user space processes failed after 20.003 seconds (1 tasks re=
fusing to freeze, wq_busy=3D0):
>     task:swapoff         state:D stack:0     pid:3175  tgid:3175  ppid:29=
55   task_flags:0x400100 flags:0x00000419
>     Call trace:
>      [...]
>      io_schedule+0x44/0x70
>      folio_wait_bit_common+0x1ec/0x3d0
>      __folio_lock+0x24/0x40
>      unuse_pte_range+0x2d0/0x348
>      unuse_vma+0x158/0x248
>      unuse_mm+0xfc/0x150
>      try_to_unuse+0x104/0x3f8
>      __do_sys_swapoff+0x220/0x5d8
>      [...]
>
> The same goes for anything else that wants swapoff to stop, like an
> admin hitting ^C in a panic, of course.
>
> Prior to commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
> try_to_unuse() was driven by find_next_to_unuse() which checks for a
> signal before every entry, so let's restore that behaviour.
>
> Just as an example of the improvements, here's how long freezing takes
> in the same test while swapoff is happening on my computer:
>
>                       before                  after
>     400MiB anon       8.925s                  0.028s
>     400MiB shmem      1.639s                  0.003s
>     2GiB anon         failed after 20.003s    0.011s
>
> Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
> Cc: stable@vger.kernel.org
> Acked-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
> Changes in v2:
> - Return -ERESTARTSYS at both new signal checks and at the existing
>   try_to_unuse() signal exit (Baolin).
> - Request stable backporting with Cc: stable@vger.kernel.org (Andrew).
>
>  mm/shmem.c    | 4 ++++
>  mm/swapfile.c | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fadf23f9e21e..13e0786436cd 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1742,6 +1742,10 @@ static int shmem_unuse_inode(struct inode *inode, =
unsigned int type)
>                 if (ret < 0)
>                         break;
>
> +               if (signal_pending(current)) {
> +                       ret =3D -ERESTARTSYS;
> +                       break;
> +               }
>                 start =3D indices[folio_batch_count(&fbatch) - 1];
>         } while (true);
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 254ce86fa923..0f72a5b23a3a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2689,6 +2689,8 @@ static inline int unuse_pmd_range(struct vm_area_st=
ruct *vma, pud_t *pud,
>         pmd =3D pmd_offset(pud, addr);
>         do {
>                 cond_resched();
> +               if (signal_pending(current))
> +                       return -ERESTARTSYS;
>                 next =3D pmd_addr_end(addr, end);
>                 ret =3D unuse_pte_range(vma, pmd, addr, next, type);
>                 if (ret)
> @@ -2922,7 +2924,7 @@ static int try_to_unuse(unsigned int type)
>         if (swap_usage_in_pages(si)) {
>                 if (!signal_pending(current))
>                         goto retry;
> -               return -EINTR;
> +               return -ERESTARTSYS;
>         }

Reviewed-by: Kairui Song <kasong@tencent.com>
