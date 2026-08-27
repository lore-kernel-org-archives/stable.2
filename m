Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5F35E1B0
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812024; cv=none; b=RFq2mJhIm7Jakec04Ejw24wtUwYsR+z+eeOzvHvZMR08TrR6k3Gr8hOTBF7k+vF7sLMIEmdiAkbMLfWtl2bjX8q7FgOH5oh3H7FNMtvNpt9aNLRr05w10mdvfP+YZSGTLLIsk2cU72l0VUb+mHKo+CYKZVknqOWl5NYNi3N/YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812024; c=relaxed/simple;
	bh=6Me5f9cNIiPxbreEnMrL7joFMQ/5JO/iEbrg5VgeQ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrqbzfXhsuG9aFiv+Mvv/rrOBlsgporvuDvpSCnjdnzOQoQKqf/W1zMf0Q/oZPFNDN979pNLVuYCidnHbcPRdPDrsMfPKlywY9WmHdGZSGyLWY/F6WK93du5ChfoyXsUNMHifoe+wy9nwMEYBLvon9+VDE8mUyOQXnLGZmqwDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2VJ08Nt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2VJ08Nt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1904944b3a.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787812023; x=1788416823; darn=vger.kernel.org;
        h=content-transfer-encoding:andrewto:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZKMvnBcPJlEjiIGIjUEHCR8FjCIhDtcMqGhHVLCc0JE=;
        b=q2VJ08Nt2z7XELYd6iYg4IK8YLbDiUH7Cq/1WB96DICi3+sEwAEuZtrKTm4IYrfgJO
         4P0MrIrtV8xuuMmRsVfmy6uNFEyE3Pb/fTL/7Q3coVYVZKI/eaeiRAQV5OzGBzA/VXRn
         tUepFC8ToToAt6+YC2nw1beuysaBKauzCZWtYI1xPkoYuTTutEzVKIweuCcSSIaqK1G9
         XQpJcCFl4KSr7nJOxK1yEghr4JFQJYl2gsxVSPhy3mgfisuS+Rlf3keVEI8aauO4LxUp
         dgxTVmYOU4wxJy8ZHwHon/7KFEvtn0GFSp8MwSkIMKDoKj+sg83LVrifA74BLdVGoQm3
         VeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787812023; x=1788416823;
        h=content-transfer-encoding:andrewto:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKMvnBcPJlEjiIGIjUEHCR8FjCIhDtcMqGhHVLCc0JE=;
        b=Gca7O55noKiVde//+5zuJB3xbk4I7jgax7FdFKw7NyvtwI/oxiZSdCY2VA9cV2z86G
         4ECiqr1SCueBltdeZ6u6I9gNV0xizbqwEZ0k809/zBC9+5J6aOvJvtnU4AgBxjdJ21lu
         /0FYmytJoYN6/DmmOpan25vsiSDordv0JR1Y5ag/yqAWfDaToOmF4JWsJhnYFCOyWwjK
         Kio3hbNNroEoxVexBFZG35Agc1wN30REkjmqC7/ZtF+zCmJcV/S3nksPu73xdyemQWSl
         Sv7MHxSCAnyLQkmiq8OBDV7imoHY5dDAaiLGQED9UKoI/f4n/6R/rmvO/GP8E2PrNO0I
         h2PA==
X-Forwarded-Encrypted: i=1; AHgh+RqJxmJLXfG31IWLVjaXWZt3jOEp7EATADIfYk/l1grqdWFlEPT+I5qRcOaQKpHADMlK071VKXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kSrfOynR8oc7gtkrJdLPwuZtlrMYPIygeRT1TcWY0WmLMUtX4G
	aYloCSUZgkjoqOdzd93mGycz2iMyw8tb4TsZfIonwOwlghJldjfSjQPv
X-Gm-Gg: AR+sD13GwL2MR+5uo+gRhVPP/7I9bbBaQ1EKX3jvG2CklGzRVeggQVLds0tF8xktwzq
	C210zCLhGAF1gYM2cu/zQt+JWq8X8e05pU3VcLrFwNuo3rihl71jItCnenqJNtTUV4vrnJWaop6
	NgnwpjmeoAZZo6NmYpZ3K3sKTB12O+ZynffWKvtNaFO3c4+EhLCFGYkkTXznr732pQottTirex3
	a4KH6Oyk5whiUMjPsRxEd0KLLu0/Rh9Nil0YEurQVWIWzaRxZxMMLvQvShn4CCZsmHNGxVMJWSn
	qGz6gBwqAgrIiu3HV0NDHdrin5lL1/1kLzZ+/f72Gf369oGbtl5GlqRCRDhLC/OGsjc18imh+5a
	LHR8saralBX89WUH0Dd9gg02D/jA4W602BGApcox0PcrZKqnaZReDqjPDZdGTukDPzPV00ptUJq
	iui1YbV2u/nq7GSFWwLx/jWSDoUJVcuptf9v8+wZV/pi2s5C0mM/M1lLDTdSNogNKF4wzf7j2Yk
	3XLe8k=
X-Received: by 2002:a05:6a00:181f:b0:84a:646f:193 with SMTP id d2e1a72fcca58-8536ea1f46fmr21211018b3a.0.1787812022167;
        Wed, 26 Aug 2026 23:27:02 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc03b0sm1615408b3a.30.2026.08.26.23.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 23:27:01 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: 
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
Date: Thu, 27 Aug 2026 14:26:50 +0800
Message-ID: <20260827062652.305611-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826192642.980c3aba921bf20cef425591@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
AndrewTo: Andrew Morton <akpm@linux-foundation.org>
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
> I had Sashiko write code to demonstrate this but am too lazy to test it
> on a current kernel.  If someone could oblige?

Hi Andrew,

I'll test the reproducer on a current kernel and check the mm->locked_vm 
accounting before and after MREMAP_DONTUNMAP.


Thanks,
Kunwu


> 
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

