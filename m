Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA744998D
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623505; cv=none; b=ilJ+BqQH2FVEEpmQLewRiwWlhRynHNYgqS96lIW0DeEiaBMNEr45vVdlc2r2BZyMefEgIJcrMhHROaTJjQ05PPSOPpKuu6A8m8KDVD4vkzXZgzyUsXEPUbM2JlJupTRGJ+BnlxRE9yRYCj0AjqaQO6ZDcBIbIcWG3tU+1VRPISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623505; c=relaxed/simple;
	bh=l0bfIeSSjXxqCjA6gzU+5J92YPTfUTFH8DW2JDXuTrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCRoEvbt8CJy15/a9zX7jHAy6uwkDK2oA81o44xp/GYqM45cUzPgivNZ2Gk6yAWjDVEtQXxhMBQ0VwseyeWJ4ta79/WArVK30yOxOMJ78RO+zl5tnGOQdiEK/giZgsZHgCOK0P8KByrlnplfkeciqxgNloucPj7oNE9KxBw0g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPJKT1FB; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPJKT1FB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9d7464b71so103758a34.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623503; x=1784228303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7H//saN3HUHN+i+S3SULFCinOHrdn1xh7S62KvKH1s=;
        b=gPJKT1FBKGhk7Nz4CN/yhEKcZxhSyjs1IwoRRoVjnTQ8C0NTEzEBPyD72hfI2eZyme
         LPqf7r0h/L9dfIvW90baZadsEMnloGaCF3UfUkGjegQlv/7XmB056dPDTeRLdNiwFpzl
         CcdzKGeSmF+pv3qLybCOerGnmIp63ZdLMTPcPg0Up/egvKIWEhbtX7VBTbqC6Jye3kQr
         Lt2a32nZBYLaloshw+puZPgtCAmT8FFeoXA54XOtwHEQmAlkyNiM4GYQF8CW5A6U5hru
         MQXXSgm8VaBNMen0bzAyxSN7Seqw6YJ3YKOm23kJVHW1pv8M3HPwXyvbxXZk8OGapbhE
         qPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623503; x=1784228303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7H//saN3HUHN+i+S3SULFCinOHrdn1xh7S62KvKH1s=;
        b=eF38QLdvfMD2hJg4t6IL8HAlEcLIMZEeqrSFRyFUU4JHS5U2tz28vXntQ+qLKaNNem
         N2vLg0vierLy39/mZFWlVtS/U3oVP8pX5NRwsSDvZ0/NsaHRAEbyWGOR3M/bH4g23CPs
         N/f5E9EtefO8DvKf7BQC7vhBPtWDAuIR35arChraoDPzBJLYgKSN3GTuCbmW4dWncHar
         edMUDVKywkBYkmtCFX2ftdWEMvgHqdWyZCO2KSn42YXaiGNgz9rbRazRaNRso0rkBxmE
         WfqfugJh1HUXj5rl1Hk0UEhNYgXF+ATV/2uMiyx2eH0lw0FCAIaQR/ZN+5Vb1j5qtb7y
         XsSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9G75yYf+j0fsc8tmaBxtVkCFGvd6sTESKrDdZa2TvK5E+eRSb/eKHqNmSh0fAZ4TgU43gICa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRf0OeS0wEpw0xlbe5Uwoug9beURhsnvSqKj/wzO/y3A8EgNJl
	soy0eVSWxSEPHFPwl3eNt4njQravNVWLK9oIHsySG51dvLfCVnpSf4XX
X-Gm-Gg: AfdE7ckUEah3O4SO79+zKEyF/Z3qyHNfaFPmvUMreX3G37fKE0IZMsW863AjUmKvOA3
	lbJFQ7qnSFpnhRez3uYOLoUam5CONP2SSZci+zRwJS3Yxb+I1whyirq4DYAFEjtYq8THWtVHbZs
	wft+Esz9NxMLnWZdj19zOyBJdeEqibSHHcKPFRgYm0XXeESmk2Pnrbgu+iqOatvncJt2i1w+4Fx
	J7vYnJLr8gr6eonMa4O4VHqgIKvhvlUxJYPpmgkFLzCIl2brKAq75LPdN1o8eOJh8Owv9E+S0s6
	wvnS/HXu2lGd18iOFeog3lE3QuBNsZVPwX+EBQttpTmOukdJSnJ2M3fmR3R2K9+24jOQidxLThB
	grjSsFWPWD3dcsRCM4Ul4jLvKdpdYyvkXJFYYBs/ZBJh172ldq524sHwwLnLOlW1Ug5fm5kWet2
	uJ9H+uUOvcIKIjyNtShcE5tmJJqypBQy0uGkj/GgUL0rMRoNEJ47RRMA==
X-Received: by 2002:a05:6830:8388:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7ebcfe5414bmr6526626a34.6.1783623503381;
        Thu, 09 Jul 2026 11:58:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm4885829a34.5.2026.07.09.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:58:23 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	fvdl@google.com,
	rientjes@google.com,
	jthoughton@google.com,
	vannapurve@google.com,
	erdemaktas@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: hugetlb: Fix folio refcount mismatch on memcg charge failure
Date: Thu,  9 Jul 2026 11:58:21 -0700
Message-ID: <20260709185821.1893061-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709185456.1854151-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  9 Jul 2026 11:54:55 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Wed, 08 Jul 2026 15:12:51 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
> 
> Hi Ackerley, 
> 
> Thanks again for the fix. Thank you also for adding the reproducers,
> they made testing this really easy for me! : -D
> 
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
> > its refcount set to 1 via folio_ref_unfreeze(folio, 1).
> > 
> > The error path calls free_huge_folio(folio) directly, which expects a
> > refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
> > triggered.
> 
> So yeah, I built mm-new (with your hugetlb open code series) and ran
> reproducer #3, and got the following output:
> 
> ...
> [   23.855813] Call Trace:
> [   23.855838]  <TASK>
> [   23.855877]  hugetlb_alloc_folio+0x190/0x360
> [   23.855930]  alloc_hugetlb_folio+0xf9/0x310
> [   23.855972]  hugetlb_no_page+0x590/0xa00
> [   23.856016]  hugetlb_fault+0x194/0x770
> [   23.856060]  handle_mm_fault+0x29b/0x2c0
> [   23.856103]  do_user_addr_fault+0x208/0x6e0
> [   23.856146]  exc_page_fault+0x67/0x140
> [   23.856191]  asm_exc_page_fault+0x22/0x30
> [   23.856234] RIP: 0033:0x401734
> ...
> 
> Running it with your fix, I don't get a kernel crash. So this change
> looks good to me, please feel free to add:
> 
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> But.....
> 
> It seems like fixing this bug actually surfaces a different bug.
> I don't see a kernel crash anymore, but my kernel gets stuck in a 
> different loop:
> 
> ...
> [   42.526726] pagefault_out_of_memory: 120780 callbacks suppressed
> [   42.526732] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.526955] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.527084] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.527192] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.527288] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.527382] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [   42.527476] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> ...
> 
> mem_cgroup_charge_hugetlb() fails
> --> hugetlb_alloc_folio() returns ERR_PTR(-ENOMEM)
> --> propagated to alloc_hugetlb_folio()
> --> hugetlb_no_page converts it to vmf_error(PTR_ERROR(folio))
> --> propagates up to the pagefault handler..
> 
> But there's no OOM handler to resolve, I think. So it just keeps retrying
> the fault and cycling over and over and over again... I think we need
> to be returning ENOSPC instead of ENOMEM like the other failure paths
> in alloc_hugetlb_folio (or hugetlb_alloc_folio... I think we should
> change this name, it's a bit confusing).
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 288535838a48b..05214b1cd491a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2903,7 +2903,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
>                  * were committed to the folio and freeing the folio
>                  * would have cleared those up.
>                  */
> -               return ERR_PTR(ret);
> +               return ERR_PTR(-ENOSPC);
>         }
> 
>         return folio;

Ah, immediately as I sent this out and went to 4/5 to review it, I
see that this is the exact change you have... oops, please disregard
the message : -) I do think we should 3/5 and 4/5 together for
bisectability purposes.

Thanks again. Sorry for the noise!
Joshua
