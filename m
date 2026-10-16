Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C003CC313
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139692; cv=none; b=aouCo0ygM9fupYxYAqOdggDWC6yiBDvnp8x0yRh0BBQQTsgxTDAJbVAimFHQlW0UmIDM3CpDUFGFPnqArzRYEDZcVQlQstxhoDUcT0hkjS4yReBR7ED+5v4iI/TV5+KIoMvzWcGiXpyPX+iaU5yqSz0cL/XWsL4ZzQbnyZI6o28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139692; c=relaxed/simple;
	bh=SSuj8LFNZYXIFKUXZ+/sSEiSbuuweVosXf8LwS8ZC/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2TGUiZ6bwzcXdiN/3BrNOQrLwkqDvzDI7b5LZr7swurOPW9iMOFILH94NS+zjJhjgBBAmQUsRwoc4s8g85WdtoJnPTHVrhlK7RQgIrABEVdXQQ1m3jbkAnVP/QpSKvrpWxKYERkAaEzDQDTRsIxC66qj7gy3EcYJqbEY6wtck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz1tlsBk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz1tlsBk"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1082895f8f.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792139685; x=1792744485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wp1mQzm08hLd1tOFds5YVaqYtr/CBX6Juw0wzqMGF6M=;
        b=bz1tlsBkVICkne6Lr9EjstwCvfK9avY+wyF8HoAEY4m1WjaNY/V+4ftyNu/BS8mYxa
         XsC1g3WhgVS3Ui6p/odIHOkJkSymZ9rm/EyZ5R1AI+EMVAH1RRz8HqWkb2whZggXuJmE
         zx+VZTlE3TMsPtAc4cqKawSQR3Z2PfSYlFgvb4/l4db2kt+l/Qz8BY+k4o/ms1CKo/WC
         YbPjIa12wYjd+9wZaIHApjYnHNes62dIAGhVk2Sb6jppdi6VTRmALVbrm2Wh0QzdWSnk
         EPA7d0qy5KRItOH7JqiWD48Qm4iVQIxJS3zWzurcTvijwbVq8g1c9OwcKOkeTsF8ga8A
         NpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139685; x=1792744485;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wp1mQzm08hLd1tOFds5YVaqYtr/CBX6Juw0wzqMGF6M=;
        b=aXNHMx1TL7/koSXABrHaQ2uyIC18rhTsRQ+YyDc+BUXMrjqbXKLtx/wQEQmNSXZBC/
         dId+mONc3eLFKbGYCJ5Xo/MOoCYFvlPmde2LyXtIxI1747069yZAuGrd03hWRj/Zx8//
         RMkUOq+9M4M8E6ZRgUR9O4mymZkSimexmeXrF0NrWYrfnpGHGMDcvIC6nA6F7Mppx5Qv
         6Up8thD2OECVIIgoQMmVnMcb6fuHEuvohcJ8SlahZ5EQ4qcQ2h+Oqr19LijU31UynnZs
         AdreoVQhCR23WIPc/qfl5SbTMFm9LpUxSaDq04fBWX4Pmb3HB2hdGxsi686yvsdgOBZF
         mfAQ==
X-Forwarded-Encrypted: i=1; AKwUvByTq1ggnw7npqaPPwXyV4Tnf2UTmmEyneEYBTmV4t7IHqdxoBZ4xiF0Bb0QNU/H38+bjNj6pKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlHxLFVyADUFvyGmUmJG80Myexyjvs7fxVsTBa/tHR6yGyL5lE
	+ax9yTPIeTO7FT0Fs1xiUF8aTOfu0tKNwUMKSw9bSklxXCH1insESyT9
X-Gm-Gg: AYBFou23rh0rk+aXlV3k7HbugOXImMXg0dgKERauL7WCVM0guFAZRPhkuijvTg4ZYds
	IfBpScQSF/cAVbDg0u6sTNQKv5L8oEo5VjkhNnQq534Q6t8FVQoak14DcKWHflZdBv1+OO15pq+
	c8mRX1nPWNpbJeVX/Q3QWV5RNt0uhTRDb2HAdIVn/R2GphuXk5LnjFiUREMWh4ZC7dPM/noCOZe
	vHYWndbscJ2+/vZpCeeL+FIPqa5fHVzq4Bc3wafhWlpnvTGvBT5iqOvmUZgYKYoslaeGqse/keo
	8WvCj+JOTMhyxQFEbICgMM7M77m92QCktixtwC54BHXaTnUzsy6NnAPxnadjLhGSSxmp0oFf7I8
	wYYuEYKytWZj9B5hqI+7AM8NmtuN9frT3mbQaOpQ8ESAhG532NYHGXOZ7YsRLuGruBsUuzUV4lo
	xdPTdf5YCDbCNXYVH7iRG7DoWUxLBRCfVpEuR9/0LJnl+Sisd3yZyCxFQH/H/lRIMTWg==
X-Received: by 2002:a5d:5590:0:b0:48c:6cdd:ba89 with SMTP id ffacd0b85a97d-48dbaaefa6emr31965430f8f.36.1792139685280;
        Fri, 16 Oct 2026 01:34:45 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm3422534f8f.42.2026.10.16.01.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 01:34:44 -0700 (PDT)
Message-ID: <80ce78ca-d971-4530-afa7-43b0b4a175d1@gmail.com>
Date: Fri, 16 Oct 2026 10:34:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/vma: don't leak the commit charge on mmap
 failure
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 6:07 PM, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When an accountable mapping replaces existing mappings (MAP_FIXED),
> __mmap_setup() only charges the difference between the size of the new
> mapping and the VM_ACCOUNT pages it replaces. It then zeroes
> vms->nr_accounted so that unmapping the old VMAs does not return their
> charge, which now backs the new mapping.
> 
> If the operation fails after that point, the error path returns
> map->charged, i.e. only the difference. By then vms_clean_up_area() has
> zapped the page tables and closed the old VMAs, so
> vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
> finishes the unmap with vms_complete_munmap_vmas(), which uncharges
> vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
> never created, and the charge of the old ones is never returned, not
> even when the process exits.
> 
> No privilege is needed to hit this, only a file whose mmap hook fails,
> for example a socket (sock_no_mmap() returns -ENODEV):
> 
> 	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
> 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
> 	     socket_fd, 0);
> 
> Every iteration adds len to Committed_AS for good. With
> vm.overcommit_memory=2 this lets any user make all further accountable
> allocations in the system fail with -ENOMEM.
> 
> Once the new mapping has taken over the charge of the mappings it
> replaces, it owns the charge for all of its pages. Record that in
> map->charged, so that the error path returns all of it.
> 
> A failure in __mmap_setup() itself is not affected: it happens before
> the charge is taken over and the old VMAs are reattached with their
> charge intact.
> 
> Original fix generated by an LLM and sent in private by Josef.
> 
> Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: call variable "uncharged" and make it const, adjust/simplify comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

this LGTM.

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
