Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487D3BBFD3
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905568; cv=none; b=J3OEBLWbVkT8OcJT9JUHKYKlrg9yAn9BeGE65PzKkfvQ6It53+O0ukOhBlN+vhNPJflC52pTWrm57VROW382kRt0FZhsALOH74/hkiuC+++QNRBAF24GhjnKETXVA3PnGVu7kgQSjcSSiMM+nvetrudGdbWYDVMb0rVG0Q/cMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905568; c=relaxed/simple;
	bh=9vvFhf7L87Mua5XxUTwM8H1VweoULNF8Iy1tWAzHRSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7si63MwlXkiwUWTm/NHOVi2LP0JQYg4WF+n5B5ntpaYMVOuS6aGne+DoAAp5zfQVXC5X+RbztSjnQxNmtV68c4AMZHNxzn/DnyMA7aLT17Nnzc8HZAFy2MooHm1eGEfCmUH0OE0BItK628qHpxITTEBreo+ZL9NNCIY7bxDxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS6hECGr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS6hECGr"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so615571a12.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787905566; x=1788510366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57gbJ6PuWdyL+kyJ8Dp9UoiQ0ikR2cC7cGndc/5JOIA=;
        b=QS6hECGrqlocQF7FLE8R3e4lrmhfiKBLV3aOic+tc4iUQ3E7wBYhL5Yce7PetURnOo
         MumZ3EQDi1B46ECuxaiIy76811E4d5yE/09cVzXt4U7ypIwItDkz4MhWek/Jp2hhGKxP
         SQ247IbxOJxgXfJyeJm4hDfW3109l3Zfak8vl0nsr3edtXvTlZTojfTtcrNirsRmNtZ7
         Z2YXG5gq0u1hWcWIce9sDEbJtfKv2dtnnvAK3aIagfPnPHgxbojwz303ad+dB51BydWj
         DLkqrCtHMyQCbxfzn+x2KSyznlpEV54aGAOKD6n91LZGoD8txQBly60dWzW75p7Qr3zh
         USyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905566; x=1788510366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=57gbJ6PuWdyL+kyJ8Dp9UoiQ0ikR2cC7cGndc/5JOIA=;
        b=YnW6+vGSULQ1OLUw/uPkjjKyXttCTOy0nxdxxSOFAhDTD0byee6kvXnwHt2NVlH9tS
         6Md9/wEfK65Ocu4SJpW9OhJSbT/KMD3W7QYTzDf+2z+TSs3ZyUk8wfvCFSZrKxetbLmF
         OxdpASPGZpmT5FAYGmz0bTwtTbdDwpGJteHenElQ/Twf5Q9Wm46AE0EmhoDUNeIztxH1
         gqeFduUcQ4c7BVeM/gLe13yTgszXSjIIGfbQOn4dRBNCxlaf646hc0uqaBHNzbmaogIS
         YGTqew0o+nkKm55w2LsL55BfTwmGkXaVleURdMWhUBEDfTZANdh0yw+CX99cMeIWTnxq
         0/IA==
X-Forwarded-Encrypted: i=1; AHgh+Rrlf6IYil9dZZsp1pvPhPxeFrFUmVyarpjuXqScTw9Qzw2RaqxM2gZQeckfLh/hoHn+i6LiDVs=@vger.kernel.org
X-Gm-Message-State: AFuF++mU+WRh7DePtA4WQTble635Qi128uKiqyNeqXaigygqm3OsdhO/
	2h7Jj8LZtYP+ZDE3dRuGLLR9B18G6dVQ4Oj7VQj5ll0UX7r3gPq0l49m
X-Gm-Gg: AR+sD12D65+uFJHvlXNccTzZPL8Pk07i8AHNUUQxggVthYkJdeTTHbPbEI2rAUjNKDB
	r2U8ljvk1FfyquK+cnMh94pIk1clsX+jGiewBUelnfJzRGy8knHcoun3tj0rM7U5F6bQwqLQeCW
	XYDa0MIhoKwGG1QUNVq13lazHgDOjwvOT9/mGcW5/2SUglAeVgBi+XgfpP9t5OUiGqmHW017Wyb
	htg1C3cJkO1+K/RnX+bwHcl3CPQ0kLo9YbyELrTm13Lne0JRk21qWD59GoS1AMckcsMeraFsDWB
	s3ZWWcw7rY8xDUXD9duwSnY95hfOUL5QtAoZLXz/QDDZGSo873QQOjs+0UHkruZiKq48OPQz9iQ
	ATp/AAvR9CMwzSP9czuHKjd0f0JVrZRXg5gIYsARbD+jtR1JLVCfODu+fUkL6FC8jGvMNoXAF0D
	RIbIaiBwbYSWcjGG1/NBxIZK1wGehtrjiAX4OwdItQBXJb1Hm79tHPrBY/1JW1CZ9THTQDNKtfp
	u7SR+rn2uqVhoY+dQ==
X-Received: by 2002:a05:6a21:496:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3d26765e5f3mr12417876637.7.1787905565243;
        Fri, 28 Aug 2026 01:26:05 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36dc602sm310894a12.24.2026.08.28.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:26:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Li Xinhai <lixinhai.lxh@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Fri, 28 Aug 2026 16:25:39 +0800
Message-ID: <20260828082540.584610-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826192642.980c3aba921bf20cef425591@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 19:26:42 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 25 Aug 2026 08:55:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> 
> > Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
> > a faulted VMA into an unfaulted one.
> > 
> > It does so after the page tables have been moved to the copied VMA with
> > MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
> > as the page tables it had are no longer present.
> > 
> > However, in doing so, it violates the invariant that the anonymous page
> > offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
> > 
> > This is because a VMA may have been faulted in, mremap()'d (causing a delta
> > between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> > mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> > 
> > This condition is a violation of a fundamental assumption in mm, but now
> > also triggers an assert in assert_sane_pgoff() which explicitly checks for
> > this condition.
> > 
> > Correct it by resetting the VMA's page offset at the point of completing
> > the MREMAP_DONTUNMAP operation.
> 
> Thanks.  I'll park this in mm-new until mm.git is all merged up
> (simplifying my life..)
> 
> 
> Unrelatedly, Sashiko thinks we're messing up locked_vm accounting with
> MREMAP_DONTUNMAP on a locked VMA.
> 	https://sashiko.dev/#/patchset/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
> 
> 

Hi Andrew,

> I had Sashiko write code to demonstrate this but am too lazy to test it
> on a current kernel.  If someone could oblige?
> 

I tested Sashiko's reproducer on mm-new (7.2.0-rc5) and confirmed the
locked_vm accounting issue. There is a minor typo in the reproducer:
VMLck should be VmLck to match /proc/self/status.

On the mm-new baseline, I get:
[1] Initial VmLck:      0 kB
[2] Post-mlock VmLck:   40 kB (+40 kB)
[3] Post-mremap VmLck:  80 kB (+80 kB from initial)
[4] Post-munmap source: 80 kB
[5] Final VmLck:        40 kB

--- Result ---
BUG DEMONSTRATED: Leaked 40 kB in mm->locked_vm counter.

With Lorenzo's pgoff fix applied on top, the results are
unchanged, so the locked_vm issue is independent of that fix.

The issue is that vrm_stat_account() increments mm->locked_vm while
the source VMA is still VM_LOCKED. With MREMAP_DONTUNMAP, the source
VMA is left in place and dontunmap_complete() clears
VMA_LOCKED_MASK, so the later munmap of the source VMA cannot undo
that increment.

I have prepared a separate fix which undoes this accounting in
dontunmap_complete() before clearing VMA_LOCKED_MASK.

I will send the fix separately after completing the testing.

Thanks,
KunWu

> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <fcntl.h>
> 
> /* Read VMLck (in kB) from /proc/self/status */
> static long get_vmlck_kb(void) {
>     FILE *f = fopen("/proc/self/status", "r");
>     if (!f) {
>         perror("fopen /proc/self/status");
>         return -1;
>     }
> 
>     char line[256];
>     long vmlck = -1;
>     while (fgets(line, sizeof(line), f)) {
>         if (strncmp(line, "VMLck:", 6) == 0) {
>             sscanf(line + 6, "%ld", &vmlck);
>             break;
>         }
>     }
>     fclose(f);
>     return vmlck;
> }
> 
> int main(void) {
>     size_t size = 4096 * 10; // 40 kB
>     long initial_vmlck, post_mlock, post_mremap, post_munmap;
> 
>     initial_vmlck = get_vmlck_kb();
>     printf("[1] Initial VMLck:      %ld kB\n", initial_vmlck);
> 
>     /* 1. Allocate initial VMA */
>     void *addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>     if (addr == MAP_FAILED) {
>         perror("mmap initial");
>         return 1;
>     }
> 
>     /* 2. Lock the VMA (increments mm->locked_vm) */
>     if (mlock(addr, size) != 0) {
>         perror("mlock");
>         return 1;
>     }
>     post_mlock = get_vmlck_kb();
>     printf("[2] Post-mlock VMLck:   %ld kB (+%ld kB)\n", 
>            post_mlock, post_mlock - initial_vmlck);
> 
>     /* 3. mremap with MREMAP_DONTUNMAP 
>      * move_vma() increments mm->locked_vm for the destination VMA,
>      * while dontunmap_complete() clears VMA_LOCKED_MASK on source VMA
>      * without decrementing mm->locked_vm.
>      */
>     void *new_addr = mremap(addr, size, size, 
>                             MREMAP_MAYMOVE | MREMAP_DONTUNMAP, NULL);
>     if (new_addr == MAP_FAILED) {
>         perror("mremap MREMAP_DONTUNMAP");
>         return 1;
>     }
>     post_mremap = get_vmlck_kb();
>     printf("[3] Post-mremap VMLck:  %ld kB (+%ld kB from initial)\n", 
>            post_mremap, post_mremap - initial_vmlck);
> 
>     /* 4. Unmap source VMA 
>      * Since VMA_LOCKED_BIT was cleared on source VMA, 
>      * munmap fails to decrement mm->locked_vm for this region.
>      */
>     munmap(addr, size);
>     post_munmap = get_vmlck_kb();
>     printf("[4] Post-munmap source: %ld kB\n", post_munmap);
> 
>     /* 5. Clean up destination VMA */
>     munmap(new_addr, size);
>     long final_vmlck = get_vmlck_kb();
>     printf("[5] Final VMLck:        %ld kB\n", final_vmlck);
> 
>     /* Evaluation */
>     printf("\n--- Result ---\n");
>     if (final_vmlck > initial_vmlck) {
>         printf("BUG DEMONSTRATED: Leaked %ld kB in mm->locked_vm counter.\n",
>                final_vmlck - initial_vmlck);
>     } else {
>         printf("NO LEAK: mm->locked_vm returned to initial state.\n");
>     }
> 
>     return 0;
> }
> 
> 

