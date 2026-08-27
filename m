Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BD383993;
	Thu, 27 Aug 2026 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797606; cv=none; b=mOD/RVg3pPoSOmhpobpiFQiUkRSRIlp8n6N2FUTE2NMSjuY1Q5unymNcqCgnP/OdK8jpwRGaeVGSBPz7ZbHBdicA1nsr5WeuB7yY9J9cLywaaofNWMCH3DFDwQqpJhmo5UJHPXs18b9ZP6dleqcWyirHpUWXd83XRzPXFJp3Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797606; c=relaxed/simple;
	bh=/9OWLxuUHxdkQHuoIuL5Wxp2c62Zch87SWkdGBvLMKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JP3m8eFA1oZ+JlbXLM2rXh2Pn1DM4+v5W35AgnpquLv6ECXxkgwj7VnlFfyren9jO0e94QVqJJJ1PfZOAM7tn3j6xIQFNTYnGbbayX1Xof9/Dq9qZMqaXIzphmyOo7uFoAPpz5SkbbdRZ3JeWswfNXi05D02EQMuuJxCS0PLkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SrGToG6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SrGToG6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FDB1F000E9;
	Thu, 27 Aug 2026 02:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787797603;
	bh=KRCoeguRNXQjKf/J1BJkLL0r/nvVajBk63KtuoCwr8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SrGToG6W0G0ii7P5TP8t46WK6UMhhyLRfGMQYo+3BynPCsSu/G5jy8oZGuAyd1J1g
	 scsANe3Hw/iwJNEEx50FiGhSv/LDUezqEXYjStUi2WJHbxv8VEn+KqXpGOyrKDQJhu
	 hQoeKqOiIgBaRhanIjyZX383vWTsESelzA2ESxwg=
Date: Wed, 26 Aug 2026 19:26:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+f12658786a4153df5113@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-Id: <20260826192642.980c3aba921bf20cef425591@linux-foundation.org>
In-Reply-To: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
References: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 08:55:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
> a faulted VMA into an unfaulted one.
> 
> It does so after the page tables have been moved to the copied VMA with
> MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
> as the page tables it had are no longer present.
> 
> However, in doing so, it violates the invariant that the anonymous page
> offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
> 
> This is because a VMA may have been faulted in, mremap()'d (causing a delta
> between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> 
> This condition is a violation of a fundamental assumption in mm, but now
> also triggers an assert in assert_sane_pgoff() which explicitly checks for
> this condition.
> 
> Correct it by resetting the VMA's page offset at the point of completing
> the MREMAP_DONTUNMAP operation.

Thanks.  I'll park this in mm-new until mm.git is all merged up
(simplifying my life..)


Unrelatedly, Sashiko thinks we're messing up locked_vm accounting with
MREMAP_DONTUNMAP on a locked VMA.
	https://sashiko.dev/#/patchset/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org


I had Sashiko write code to demonstrate this but am too lazy to test it
on a current kernel.  If someone could oblige?


#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>

/* Read VMLck (in kB) from /proc/self/status */
static long get_vmlck_kb(void) {
    FILE *f = fopen("/proc/self/status", "r");
    if (!f) {
        perror("fopen /proc/self/status");
        return -1;
    }

    char line[256];
    long vmlck = -1;
    while (fgets(line, sizeof(line), f)) {
        if (strncmp(line, "VMLck:", 6) == 0) {
            sscanf(line + 6, "%ld", &vmlck);
            break;
        }
    }
    fclose(f);
    return vmlck;
}

int main(void) {
    size_t size = 4096 * 10; // 40 kB
    long initial_vmlck, post_mlock, post_mremap, post_munmap;

    initial_vmlck = get_vmlck_kb();
    printf("[1] Initial VMLck:      %ld kB\n", initial_vmlck);

    /* 1. Allocate initial VMA */
    void *addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (addr == MAP_FAILED) {
        perror("mmap initial");
        return 1;
    }

    /* 2. Lock the VMA (increments mm->locked_vm) */
    if (mlock(addr, size) != 0) {
        perror("mlock");
        return 1;
    }
    post_mlock = get_vmlck_kb();
    printf("[2] Post-mlock VMLck:   %ld kB (+%ld kB)\n", 
           post_mlock, post_mlock - initial_vmlck);

    /* 3. mremap with MREMAP_DONTUNMAP 
     * move_vma() increments mm->locked_vm for the destination VMA,
     * while dontunmap_complete() clears VMA_LOCKED_MASK on source VMA
     * without decrementing mm->locked_vm.
     */
    void *new_addr = mremap(addr, size, size, 
                            MREMAP_MAYMOVE | MREMAP_DONTUNMAP, NULL);
    if (new_addr == MAP_FAILED) {
        perror("mremap MREMAP_DONTUNMAP");
        return 1;
    }
    post_mremap = get_vmlck_kb();
    printf("[3] Post-mremap VMLck:  %ld kB (+%ld kB from initial)\n", 
           post_mremap, post_mremap - initial_vmlck);

    /* 4. Unmap source VMA 
     * Since VMA_LOCKED_BIT was cleared on source VMA, 
     * munmap fails to decrement mm->locked_vm for this region.
     */
    munmap(addr, size);
    post_munmap = get_vmlck_kb();
    printf("[4] Post-munmap source: %ld kB\n", post_munmap);

    /* 5. Clean up destination VMA */
    munmap(new_addr, size);
    long final_vmlck = get_vmlck_kb();
    printf("[5] Final VMLck:        %ld kB\n", final_vmlck);

    /* Evaluation */
    printf("\n--- Result ---\n");
    if (final_vmlck > initial_vmlck) {
        printf("BUG DEMONSTRATED: Leaked %ld kB in mm->locked_vm counter.\n",
               final_vmlck - initial_vmlck);
    } else {
        printf("NO LEAK: mm->locked_vm returned to initial state.\n");
    }

    return 0;
}

