Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005432B130
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469526; cv=pass; b=eqji3ZNZzRMxtaL6ZIinC2f4UUlq1sG7GKEyRq+qh2u8oJ8rgCcSnreWohIoVQhqwXF3cN4DSJMolGtenE/tBIh6QLMeXvD4hp+E16bcNdSQrMSzwL3Dlnmx370OxQynBERRxpn1JZ17yrdqewV1iW0pifuhchiigF58rA99jzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469526; c=relaxed/simple;
	bh=MVvPEWx1sAupWc+/2gAl7FaQ6iY9mbJpl5EdVQZzpBM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6Jr/4qyaPzfrXQgTNBrJjx6lL1YLm9hncQ4hQD5DhGRnzgIV8TeNXUjTJncpvQI3P8GDk0aXJXkPziLF4uFYO/XIy+i239EPNm7yO92o8uTo0ZndURHXbl623bzG5qXRKiJHby+M1QiGPXVlJmtOGZCBcQi+E+zMaA76mHxyfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkfE+ko8; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkfE+ko8"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664ae043b7fso17325d50.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469523; cv=none;
        d=google.com; s=arc-20260327;
        b=EIpIsgDu6vwroxgzJ5H8aYZk8ZjDDCr5jHsbsOCGFNCuaGyR/NSKsPbsY+W9fAsQdI
         gdUVmlxfp2htI1gnh8nYfZ9JfDOKyP0k4fDKhUTegpKzseUXndTiVNNCppb7BkpTik4/
         UgvBqkjoqYpmYIGHFps3oOX0np7zWoNq6mvAGfTm9LkUjTS0Q+uZDGV6WwiU2LVLMx4B
         F3nOHJh/NmdT8xy84pOqkRHl2wO8xR1y/Rf3VzDYMUFrmA57Kzbkr5ZCRsPChffgOj+v
         rjobx/9ceyATUy2vlkm8bNPCtAmhRODfAQaO29b7FqG0+Gx2OO9/J9ZkLRbDadUsuDGh
         R/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ERRITY1hxaGEnfqUSi5n4r903VR9ma1HjxyBNbt5TxA=;
        fh=bZaafWngwcfoLTGGsQra+2ifSpJ1q3Og9c6JrrzKluA=;
        b=rAOzVkTmxWnJcov4XlQZ0QpjR635sQOTClFc6kDS46UPRAgPa3fzYHczzlujrplh4e
         kwOHPUy6N7fqF3Ehcn823QyX0LMGEgCYQS6MgNakZgmuLqjkVddRGdQTDqzlfagL36IW
         tepnvWmUYRFJpoY2e0dfnZ8Alb2OGitCPEVYVVHjQo6En0O4mMDJNQGmEW6w2I16StyD
         N5Wn1HkUKVDw2oscWYtG/nA0Y+cdp6gPMU/SijOjOstLJ0oftHU/C27CIjgGjhQ2hq+d
         aqxfpVIuyw4TMBB9yeQ5d7N03OAX2VGfNvdd41gI6I5Qy12wo4bLz8nxU+Xbha5YdZ4R
         CGeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469523; x=1787074323; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ERRITY1hxaGEnfqUSi5n4r903VR9ma1HjxyBNbt5TxA=;
        b=WkfE+ko8am+AB/6a3Dx6CAvmsGj974it9U0pSY7FYzoMH/AyiLCCaniQDUcnKOBgBt
         2Jig15A+xVtFejUVqX7COyWW3LWPkzkOEfwZ1Y4DBR2paVJVFz4UP53dHvGPk7aNuDyj
         407XulIPnwL5uZN0JSLpLlcTnHyRzwYo23Nj3+1j31PqVaz4GW2SL+BV9ZeHPQOCSlzM
         K3j97o/wHbG8JP2dvZiS6WMK7tAEOZHL7V7I2EPJ/PVtqx3cKhrodheHyM9pVxZ56oJU
         YKUADmyFk4bPsXKUGpov/oRSdPVyLILbNRhQj4BWf9fNddhYs1hZnXiXHu8sC9pCRsLy
         doAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469523; x=1787074323;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERRITY1hxaGEnfqUSi5n4r903VR9ma1HjxyBNbt5TxA=;
        b=gHzn+bpE2lMWVBWwOAnRP4BYXYfO5ASs8xWUH8gLOWB6GsQN8o6WO19nC06Y1z22WG
         3ZJCbJPMDNJmiKYEwSd23KfWnldxTYxF1UXMXwr1l1xsTI56BUMxoVIklPoquMLLZTp1
         1wFT5Se8NqDvJFPlWeL7PTGgRFeGGC2clZ3CJi9pSWqX/WZuDXP1z6Ay9iu3vKE3ULre
         fidBWlTySHBXtnvnxh+60mOjLBQ+0OGpUNyfMD1YbchN7nen3E0f6nPcShOzmvF6jfgA
         0+tKC9ZqhcTQs1hlCOQ238YzaTV2BfjEzh2L690/0uSxukmVdS9CC38vSCdHLcz7jI3s
         aCeg==
X-Forwarded-Encrypted: i=1; AHgh+Rqh4nFkXnT4lsOoyIhaTQi8xfhE8cXIZECZ/pJQ8XkFlTIYDk+SOaWUe6ubFcpzcErcbuuZHws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbZrE1iIN88EH+y7NSgdsOkSG/z5Tf7dmxPuYtr2F3cwKaLoN
	F5+X2X3ie0yN+iSPvYeiEwnlPcCFRPiwqOgA3Z8vGecmApz2Mca9pEv7i0QIQR7tXUX2JwFNtXr
	y5RX023uG0LrhmaFqF1rq4ghRWDytgCs=
X-Gm-Gg: AR+sD103x0fY/Pk9iaorwplttqFGebv2q61kTV8fiqY8E8aQee3BNkV8uki1ucAOQfc
	+lEYep7pwc9h9AQlivvxyeZwgYvr0Oc9eirZN4mNyMHUlZAE5fK5fJKnWHmdkFT+fwMDuf4dyZV
	X5t6yN4Kz/KlzUjtaXpZT4O8xGu9dMA6uuPesrg0a5c/5haEmUgJfHauSgzGPTDRVDdVRzzGf5Y
	kkQemK/SnwUNDdM7aLcSo0Hvc/+Ha53ml+reWfQHc7flfGOM8lJWrLiLMPhruiROHBwnt7dclh1
	pdpJkQsHzubooUa/phEGyGyY4Eh/ZaLXL8wg5F7LYgm8fvg=
X-Received: by 2002:a05:690e:4889:20b0:664:bc5b:79d1 with SMTP id
 956f58d0204a3-66b22e451b0mr2180056d50.3.1786469523393; Tue, 11 Aug 2026
 10:32:03 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 10:32:02 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 10:32:02 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20260808031459.3032812-1-sh_def@163.com>
References: <20260808031459.3032812-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 10:32:02 -0700
X-Gm-Features: AUfX_mwrhilf5EkQAmh6qiDNdpRXB0bQkc0hgqQsNdzth8bGhV9f0aBTbfanMTc
Message-ID: <CAPAsAGxBpKDLNRoFCzX2+Wm5HC07c0uaoRsTtSOHhFsB4Bx-1w@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix cache shrink race with CPU hotplug
To: Hui Su <sh_def@163.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Zqiang <qiang1.zhang@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hui Su <sh_def@163.com> writes:

> kasan_quarantine_remove_cache() first invokes per_cpu_remove_cache() on
> all online CPUs. Each callback moves objects belonging to the cache from
> cpu_quarantine to the CPU's shrink_qlist, where they can later be freed
> from task context.
>
> kmem_cache_destroy() invokes the quarantine removal path while holding
> cpus_read_lock(), but kmem_cache_shrink() does not. The latter can
> therefore race with CPU offlining as follows:
>
>   kmem_cache_shrink()             CPU hotplug
>   -------------------             -----------
>   on_each_cpu()
>     CPU1 moves objects to
>     CPU1's shrink_qlist
>   on_each_cpu() returns
>                                   CPU1 goes offline
>                                   kasan_cpu_offline()
>                                     drains cpu_quarantine
>                                     leaves shrink_qlist untouched
>   for_each_online_cpu()
>     skips CPU1
>
> The objects left on CPU1's shrink_qlist are not returned to the slab
> allocator. This may prevent kmem_cache_shrink() from releasing slabs
> that would otherwise become empty. If CPU1 remains offline, a later
> kmem_cache_destroy() also skips the list and can report that the cache
> still contains objects.
>
> An intermittent occurrence was observed with a virtio-9p filesystem.
> The mount and umount commands both returned 0, but the kernel logged
> the following during the userspace-triggered teardown:
>
>   [  2994.380134][  T111] BUG 9p-fcall-cache-1 (Tainted: G    B              ): Objects remaining on __kmem_cache_shutdown()
>   [  2994.381140][  T111] Object 0xff11000004361118 @offset=4376
>   [  2994.381607][  T111] Allocated in p9_fcall_init+0x201/0x400 age=19564 cpu=1 pid=104
>   [  2994.382591][  T111]  p9_fcall_init+0x201/0x400
>   [  2994.382810][  T111]  p9_tag_alloc+0x12f/0x700
>   [  2994.382982][  T111]  p9_client_prepare_req+0x102/0x3e0
>   [  2994.383165][  T111]  p9_client_rpc+0x1ab/0xa50
>   [  2994.383334][  T111]  p9_client_getattr_dotl+0xb0/0x1a0
>   [  2994.383515][  T111]  v9fs_vfs_getattr_dotl+0x115/0x360
>   [  2994.383719][  T111]  vfs_getattr_nosec+0x22c/0x3a0
>   [  2994.383910][  T111]  vfs_statx+0xd7/0x170
>   [  2994.384062][  T111]  vfs_fstatat+0x45/0x80
>   [  2994.384215][  T111]  __do_sys_newfstatat+0x84/0xe0
>   [  2994.384386][  T111]  do_syscall_64+0x115/0x6a0
>   [  2994.384566][  T111]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   [  2994.399720][  T111] WARNING: mm/slub.c:1244 at __kmem_cache_shutdown+0x363/0x500, CPU#0: busybox/111
>   [  2994.405655][  T111] Call Trace:
>   [  2994.406325][  T111]  kmem_cache_destroy+0x73/0x1b0
>   [  2994.406630][  T111]  p9_client_destroy+0x271/0x3c0
>   [  2994.407210][  T111]  v9fs_session_close+0x3c/0x260
>   [  2994.407409][  T111]  v9fs_kill_super+0x48/0x90
>   [  2994.407584][  T111]  deactivate_locked_super+0xa3/0x160
>   [  2994.407778][  T111]  cleanup_mnt+0x1dd/0x3e0
>
> Thus, a successful umount left objects in the 9p fcall cache and
> prevented the cache from being destroyed cleanly.
>
> Per-CPU shrink_qlist storage exists for every possible CPU, and each
> list is protected by its own raw spinlock. Iterate over possible CPUs
> so that a list populated before its CPU went offline is drained as well.
>
> for_each_possible_cpu() can do more work than for_each_online_cpu(), but
> this change only affects CONFIG_KASAN_GENERIC kernels. The extra work is
> limited to cache shrink and cache destruction paths and does not affect
> the normal allocation/free fast path. It adds one raw-spinlock-protected
> scan of each possible CPU's shrink list. These lists are normally empty;
> a non-empty list is traversed to remove objects belonging to the cache
> being shrunk or destroyed.
>
> Fixes: 07d067e4f2ce ("kasan: fix sleeping function called from invalid context on RT kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
