Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C24219E9
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136494; cv=none; b=HWatWtaH7azvxZ2x1PvGR7JIahgDlN2R3r9ASd45cHH44y+ZWmh8mhRt7CPb/alDe8sJZtJKoNOUmyeM9aNgKbTkVXkyuJ/aKy629dt+20rDgBsRTvuM0ziVwGwox9vutpaMwGAfdYS+sOTS5wQPmmlrKYMIH4S22dROYKjXqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136494; c=relaxed/simple;
	bh=kPWxjPPGP6jtCzLfvrCUv5Tgos0ZJM+YpPBR+U1ld3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVzv87FdQqiuRfXhqdYW/pqI6fpnIJbz9f6l96wr+DOajbtaJft9rHEk2pNjVHlwwmpbFPU9wdSH15DJVXjBCtvJe9Ysc/6edeNwtuIUvAkC0QodRbIXnkZoi6mDyrw6iShbunDYtNYbPrrevwcKsT1nvtOyU4nxoJ4s62BnV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1rnitbR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1rnitbR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48de72fc832so944890f8f.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792136491; x=1792741291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOTRRbTqkUt5QQM9REwuEs6V4HIikB0VLV6DTKCbGLE=;
        b=q1rnitbRaE98pF2VdWAg2pjRgF6e2LmA6favMjYHCAxzmstcG1l7dpjpqfmh4LNGOT
         mxNYPixaPt5l7oJKEar8oVUVFFbdGHLy7LbwVpU6XeZIavWgVEfH4Zmdwtq9AuXe+u5p
         CoWT93CeYbEtVC+jp4Msip4mseIjvpepGHQyVsEHRfVI0P57+KTtKza7URwALH5qFbU2
         XtxPc4S+XI2wF+SrM8EqCpUTg2gAHPchhhNpXh3UFfCXreIT5+3o3l5xmS5M2FUacqpQ
         sngDv/M5vpT9i5RsuU+pH5/QUZLvYZRwNDKlQK01P4/4ll23OP5xE/O6tnlz0JPERvRT
         upSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136491; x=1792741291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOTRRbTqkUt5QQM9REwuEs6V4HIikB0VLV6DTKCbGLE=;
        b=nbKR/dhl+5r6Ps01dZNyLTo8tGW4mzZBKrlYoFIISBiNvohBpDeiRGAmu1W2vM1E3s
         6ngcdkD1GvezZeUpGR5J35EERHm/8gt9l6UXzks27JZGC1HL31gOXB15UEggzu+6fdTa
         jEdGqWkutRJlwxRSHnSi9naCAqOWo1eOtmsJsC9+hT4r6TZgLLr+PYoo9BWdcLQ3+A5U
         PPh/4vnI2ZywWUtw3hclwd1NNq4H1bzKGuc1fahzpY52HLE0t6AHQX/vrU6cISqDnz2s
         riq8KlLNZUXPs6EV/+SLQNvQCDAmVX9hCbfYiThy2Moqy9SDoniCQT8+QENV5be34qwJ
         K1og==
X-Forwarded-Encrypted: i=1; AKwUvBxF8Myaz/rmN33uicxhSg/V6akdtNifRPPbRxMfKEXa+Y3Z3TEbSNHpImY/bd+grt395IyR9zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFN6diaxtoRbfW+LNNoobINFtuMXMvr9ZlPTnDkbeRkR6xZDc1
	3UPZM9EycFYsVXfIlzontJkZ7WuTp+vfnxfod6cJB5Dtx3VqXpPYRp7n
X-Gm-Gg: AYBFou2LAxLmt6MP+ZhItn/eCBeC8xr9g15OxXqMOtt0JuMKw4qMtxlAt112qT9KiDM
	h3Y2uGmNnkGl62XkJ5fYiZPqtAuFHw6yrSs1RmcNnAH+DUtz4qh4ikpubEOJVh9YLxtNZnsxK1Y
	LPgPHB71i87tlvV4mOfDUdCy8e/oyTS2whOi9lB7mXdFFI9bmQ6/yZxes589Qcy7vt8n4+CwpdX
	UYJkuKbXzDCL5HeLro/yDX8OWLOzLYVmRhaTA8o0z0/WXqZPXJj+PQuq94aWVq90DQvDMW5mV8n
	uW4SEoPIjwa2RDS5H0RRnsqaSfjlfLuQbG+9YbazIsUcPUaU3J+IrCX4Kf24uFEzv6ZYj8msR8m
	KvsYWbm52mq7H837DRHLyEcXuzHfOMBwvqt+JLurjPIeL2WtHjhzyIqv89UxSc1iWUf/LDyvd0N
	Xm6yACmzy/tqawIsiVaT3RXahIcy6jcHLT/RveZLbx9BcXaGfYF6Zc05z17l+IcfAI5zO9Tf/4K
	P93BGMOgaTaR1HaHw5qVbUwDUzpGSNjNSpXByHXQmaI7hqcQ1E=
X-Received: by 2002:a05:6000:178a:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48dfd4d8272mr3048376f8f.4.1792136490979;
        Fri, 16 Oct 2026 00:41:30 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a35sm2822036f8f.7.2026.10.16.00.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 00:41:30 -0700 (PDT)
Message-ID: <f5548d05-5aec-42d0-b9d9-c14fb575dec9@gmail.com>
Date: Fri, 16 Oct 2026 09:41:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: avoid spurious write locks when mm->mm_lock_seq
 overflows
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>,
 stable@vger.kernel.org
References: <20261015-fix-vma-lock-overflow-v1-1-01beb245d9da@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261015-fix-vma-lock-overflow-v1-1-01beb245d9da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 10:31 PM, Lorenzo Stoakes (ARM) wrote:
[snip]

> The reset, performed in reset_vma_seqcounts(), only needs to WRITE_ONCE()
> the value. The stores follow the smp_wmb() in do_raw_write_seqcount_end(),
> so a reader observing a reset value also observes the VMA modifications
> made under the write lock.

the writer side looks fine, but what orders it on the reader side?
raw_read_seqcount() is just an smp_load_acquire() since d0dd066a0fa2,
not the smp_rmb() the comment mentions, so the earlier
READ_ONCE(vma->vm_lock_seq) isn't ordered against the later vma reads.
couldn't a reader on arm64 see the reset 0 with the old odd
mm_lock_seq, pass the parity check and read stale vma fields? would
smp_load_acquire(&vma->vm_lock_seq) be enough?

[snip]

> Cc: stable@vger.kernel.org

the parity check relies on e5e7fb278e59. before that, mm_lock_seq only
increments on unlock, so locked values can be odd or even. should this
be limited to 6.14+, with a note that older trees need a different fix?
a straight backport of the odd check would ignore write locks taken on
even cycles.

[snip]

> +	/*
> +	 * The VMA seqcount is always odd if locked. An even value can only be
> +	 * the zero stored by reset_vma_seqcounts(), never a write lock.
> +	 */

vma_lock_init() now stores 0 too, so this isn't quite true, is it?

[snip]

> -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> -						    struct vm_area_struct *vma)
> +static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> +					     struct vm_area_struct *vma)

is dropping the inline intended?

[snip]

> +EXPORT_SYMBOL(reset_vma_seqcounts);

since it has to be exported for the inline mmap_write_unlock(), would a
__ prefix make sense, so nobody calls it outside vma_end_write_all()?

I tested it on x86 in qemu with KASAN, lockdep and DEBUG_VM on top of
mm-unstable and saw no issues, but I'm hesitant about the points above.
happy to give a Tested-by on the next version :)

-- 
cheers,
jose a. p-a
