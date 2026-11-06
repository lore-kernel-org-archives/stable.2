Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995183;
	b=d0ytiAKUPll4nKyPNFuwK6sBRLAC2q4oOw5zlg1z9heg1GNZAfRIXkmXxmdrCilBxNRR
	 IZD0RqG2p6AERAnt/O151WfElvH4lN3GvN26U/gxM6Am7ZtTbgyp1XkwkiLYbuRh0aD+G
	 aOyX/SCpOv8pHQnyoTwxCPgvp3t0UoRYBlyLk0/kPyQzFZluLPfvJ89KZwmwpu8HPdfmH
	 k7bGHgExRlE0lBmi/+Goq3a11nldMTWb7B4ygbJn4YOMM++SKqZvkkHTm945HoNKGS2RG
	 hF3zdkdwcOGpuGWmdpr1UPQpxk76Qf/bqg5lyO5LVaNNuGukaz1JuVw0tJ7jeEhrjjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4IjryWNxdORCjNaHoK0nCSyu8CfUlBnhe9uOpGWyC/k=;
	b=xoCKtYTwgCHPTc5qmPQsK5I64klpZbGeQBPqRc8fHI8xZCiMJZZr3DC1tUMBCI2M2yEN
	 RybKCwto4y9F8HX7zJlyi6s+mXIg+0vlJO8mrcQFIbZt2MDQiElxiVQgSDmOyw6uW1lu1
	 sBarFHrDeDgw1cXqay2LZPXxzakGT/MGU1VjTzhTqZxO0c4sVYKUr4OK7vzcOhGJ6yvlu
	 JcShORI8nBOVlISPynD+tGh6mtzVPNXRHuKtn4gqN01DoNqCzGjkk8tk9gSDUl6lWg4Nf
	 H2sdCf/yHKS013hBECWLT0rGMoiSQ1OpsHqe4NKX9gf0AEAr3KiVt9h5cl7zWiE688w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3Q+3In8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012F606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3012F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3Q+3In8
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so12118455e9.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995182; cv=none;
        d=google.com; s=arc-20260327;
        b=cSdvYloVxGZ9+oxnZykaH6qjkA38sx5+N2pgCZW/cjnnz6uY/CukXZhzilmYNDnTUN
         taVuirrgjIwJD1ht64pOLNIJzTv91RuLkH7mD0QJJMTtp8zI7hvBMQz0LWOWHMClm0at
         j18dtGRqteHc27Z4TCqveNcwcQSMmKieeiIepNdIpTwgTrElm4pDiqrCmHX8vUk3EwIp
         zpEx0r1Imwht9Tr8AxwNIK1m2Nzcp8xBXW5LVidvrHUcgqCX2U+sA5dfq+8yzz2SShSb
         M0zc9GRmsC1Od/vZSDiK3bOWnPvOCO6MuEgsymRPEO61lrSu7T/4HqncXEmWBepyXJmp
         257g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IjryWNxdORCjNaHoK0nCSyu8CfUlBnhe9uOpGWyC/k=;
        fh=u422dgagqtW+wwzV8B/cuwJ22PhiTvFBtarLUYn3eaU=;
        b=GZAkXGtwJYrzl6FQ/VgXJaHvNAG0DLUpm7xHtzmOkwOuP6CyiSy4qrHr32gH1hQVhS
         v4d3UtktDbYiVeXUvd5AuK3y8+xFn7XS33UQER2OyNZuHIxOaZlpdXRdkcKELvYKkV3h
         8VmCV3priuDnAQPbEbRNrIWgaMmxM1p0w2yC+8CmEnS+twHQnjm7BDTF+hitJP2aPu8r
         QSrQtVL5sheAvyKf13H/UmPbY0xJpNkj7kyfARxNgZXUBlqukNMfVmp8mBliHHWAXeGj
         0YpG9KauC+VqUuZRAl1GuviNoyKhM94Nqo2aWuJHQ9qsbhkgjhoG76nhRbwYqzT5LAd3
         qkvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995182; x=1794599982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4IjryWNxdORCjNaHoK0nCSyu8CfUlBnhe9uOpGWyC/k=;
        b=t3Q+3In8uQM7jXczqcckVxmrD9TlsK4Wt9CHC6V4Ium4ZBrwEBAvd1gnQO1BxUTABB
         BuYFie7PmRD8o/IgMRtW+KEiHdutxS/qVLj4qc+c74wKlvIXAOy2kTBDjQjMb2uBQoia
         0CqS7gmDZAc2fVlsVrzvf0QMc+CxoTz2Vtn5lSihnzwjb0KsHa16vmauZIigR4+FCC57
         +3gaBozTHvKeZEK7JXP6vd23c05OPd/WBKmRbZlp/WOHw8zxnIClBZrlObjlspa1NFWU
         i4ippmbLxYcHau472r97/GhqdFN8d8zYruBm0ZDMgeRtuKtpnpAVrwrFwmM1slY21kmP
         Anog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995182; x=1794599982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IjryWNxdORCjNaHoK0nCSyu8CfUlBnhe9uOpGWyC/k=;
        b=GT7C6HlniUkYWWLGqWHx8iUcJt/uq+mFQqshBsUPUC/ZxpqlD76m5ub82DScOCOGRJ
         xQic6Y6Sjbz/KEJqL4Z6MgfJ16/SvXewYgcgqGLw1VAuixVDXZZcgj9Utlv3WfUApC/T
         FEl6dA5V8RPFDBRF9aqLJFx87ITVyhTlc5GKgGOYjOi337JcVdz0KgwHp9tPwcJzS5W4
         2UdgK4MyoWTWp8jpdMGwZb6Zv0Rxy2nHC3Iidl9iI2QBX+zFU6EVkvIig5CcTWk8AqT1
         Alm05hB0qQW57LtUUWzUlmnGhjwliInPEXbDYf/I92W5/Dsa1HT6IHw7+z24yG0jA/ia
         UySw==
X-Gm-Message-State: APuU4Z/j8HUpSpWTcrDzHa3Z/jefozGyFCP5+1KJ9K1CO1QrpdgG4ykO
	osrNrW+7gHHKly7epOkdowSO5rxUsyYv2ioNuczfeKSEBGAPB3PFOfrq9THF3vlza7Hs2MxafhT
	oDenyoLdSzrCWoOuD3peuRAmiTk7rAWA=
X-Gm-Gg: AYBFou2oX6f7gFvlCShpL1LlCPfEfeeV5Ueq65P11oV8vYIGiWYv6noqU02llLWT+iB
	GZugzLzmUhWUI9eQ5ifDYidPklFeCgLXDmaimRs+Qp4DVowUf0N1ldlkMaNEmUn4DVrEYn/+jsA
	z7MB6FVAQtkYRJ8HQtt3HQvwObjTMoKNz/UL4UbH3wr0gy1KnGFOMv9s9qOy0kE1zLAISEWFx2U
	TkF3tH+GlBohj9gxLCe1mc+gLzzd2Zf6/hP2b57RYQRO188/N6ydxYPHuErrhaIqdpd2UqDAiLJ
	qnJWWSaHbYceGFGE5e8fIMsBUEz2iJPVgtXLk2HzrCOPCErIpk/k1lu1UaLAE5gWAM9lM+53Fbi
	olsqPsUfpksTzkGZ3Ge1wYCbWSoPOpdkHF3i9fDY/zgG7wBRaCffVSHvR/5ftqvDYIBSZTValO4
	ATZXURtahCgHLAlTq6rNTmMJnbFTndEG1fZzdXbrvcVbD1bM/UydxM
X-Received: by 2002:a05:600c:818e:b0:4b3:9540:47a6 with SMTP id
 5b1f17b1804b1-4b6dff86e38mr59681805e9.28.1793995181368; Fri, 06 Nov 2026
 11:59:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106160432.2552507-1-nphamcs@gmail.com> <20261106160432.2552507-3-nphamcs@gmail.com>
In-Reply-To: <20261106160432.2552507-3-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 6 Nov 2026 12:59:29 -0700
X-Gm-Features: AclHuK-x2stv42uMBHd5li29XslCAB0_-6f7YisoUMr7LicPx45if_utjKD95Yc
Message-ID: <CAKEwX=PiM8vc27jOVdinOGO9AdCOpbKozu=Hj_b55y10-ynFyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/swap: publish cluster tables after reacquiring
 allocator locks
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, brauner@kernel.org, 
	chrisl@kernel.org, david@kernel.org, hannes@cmpxchg.org, kasong@tencent.com, 
	ljs@kernel.org, mhocko@kernel.org, nphamcs@gmail.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, weixugc@google.com, 
	willy@infradead.org, youngjun.park@lge.com, yuanchu@google.com
Cc: stable@vger.kernel.org, ryncsn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:04=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Under memory pressure, swap_cluster_populate() can publish a table
> while its locks are dropped for a sleeping allocation. A cached
> allocator can consume and free that table before the populating
> allocator resumes, leaving the resumed scan with a NULL table.
>
>     CPU0                           CPU1
>     swap_cluster_populate()
>       drop local/global/ci locks
>       allocate and publish table
>                                    swap_alloc_fast()
>                                      consume the table
>                                    charge failure cleanup
>                                      free the table
>       reacquire local/global/ci
>       return ci
>     alloc_swap_scan_cluster()
>       read the missing table
>
> Keep the count table, cgroup table and zero bitmap private until
> swap_cluster_alloc_table() restores all allocator locks. Install them
> under the cluster lock and retain it through the scan. Initial bad-slot
> setup takes only the cluster lock because the device is unpublished.
>
> A stale reclaimer can return the isolated cluster to allocation while
> its locks are dropped. Abandon installation if the list state changes or
> a table appears, freeing only private allocations. Restore locks on
> allocation failure too, so the caller can return a still-isolated
> cluster to its free list.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
> Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
> Co-developed-by: Kairui Song <ryncsn@gmail.com>

I think I need a

Signed-off-by: Kairui Song <ryncsn@gmail.com>

here as well...

(Kairui - up to you if you feel like Co-developed-by + Signed-off-by
or Suggested-by + Acked-by is more appropriate here. I just filled in
the sketch you gave me.)
