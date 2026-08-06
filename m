Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56D3DDAE6
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004381; cv=pass; b=SfqggY8R8EZsXyV49q8Jg0+ktRUzNvJyJbZtCJW+3WM/HB0nsfzv0c4vTHM3yhdO/PWog2wuGmERlPrZz2SOI1QnyaU7mS6XRaVBCcl9i7KK1+FSiVyhZNAb25iB6xSrymWiGZv3XnvokYuAGnxBBjcl/fZyWq4XW9Rvdwo/HPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004381; c=relaxed/simple;
	bh=MEvHivamILUPErJ+2YlMch6p8MF3vQZaLr0qsybG0Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCGTkfsO/88Vnq6SvNqwMiG7iXtH8fGN8Z6OfWwMZp07OtOOpRIMsdrE2jlXr1fPxkLieHZBAEvgZnusSgVLjverO+N+eh2gsXIJfSa8OZ22gmSt/14GCfK3uuuKlgsjR52Ks3OVLPkEWAUy2+0XPS/2zVnVVnoexVn++L7ygDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jB5hz1Vc; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jB5hz1Vc"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4569e871502so597041fac.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786004378; cv=none;
        d=google.com; s=arc-20260327;
        b=O3yfhvrl9FYmRiSp27AfliRcy+VJ+g+w9EqD+uDXtRQCY6JtA3OWs/n30N4/a5TvJ4
         R1gf8yakICf+UslUX7cIYL/z4zD5vyUxXHb4MSaABOBioLzqEOkcUkdmo6MY9pCn+HCJ
         lZp2Rx28DFqCq9ik07hbh378ZHWr8d2NMcYQQsKHGkDp9aAAvPx3XrrSeRIoVB7wkQbd
         zmA8pO/Hjm8xNl0S0Q2L7K3yn509vebcTLRV6+ocTSsj6K65mA5RyfjFFGwg0mKWjH3F
         JXldtjZqV2hRWoHkH4xKvYVRU1Y2aWoAKmePsPmYw8jFMu5yLoNxo/EeEszpZthm/4H+
         u8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hy39CtWoc0zoje5YFx3qF8VnAfrlLSpF/ux3KEcnob8=;
        fh=cgzm/P71RSEBYad2mdFaQ+m9Q6z4qNM4idEy1v67+PI=;
        b=Udq1p92TZVb+utSdkRVt0JCtoyNoGnNoa0SpzLZ6l/+i0m4CixSiDaftKezPVYbCfO
         rx8Ar8S/VxB9AqekzqSw8i43EnerW3qTAmHQIq+Fa4uQTmM49yoyJTNTT8GDK74F6lq3
         9FfLGZbTG6U5NJ1MEKgIa+OBs3YmK7UjRnjIO1P6+t+kp7rISd7YrHI7xxEfjVbq2PA4
         4ofssNZpK5VtjLSsDkb0TcmZz3GQtcrmG6LSc3sD1yzGOrI1wFapoaQGNgL+fln1h6NO
         6nTFI6IEfUOG4YBUnp3bXjPFK0qLSgJAcK/a0BkqPbus99+9zyYHKScyjss9cA4zdVh0
         TAtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786004378; x=1786609178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hy39CtWoc0zoje5YFx3qF8VnAfrlLSpF/ux3KEcnob8=;
        b=jB5hz1VcHs/cc/iyN/s+CEMBOC0ymP8Qzy7FWJf4RWENNHO51p47Cor4ByriT4W868
         CVsW+o00/oiikV85CImAl4r1tMpMLYrrO4huss/HUTdZRMxdg6SDMWHM/QDa48vUf9Ra
         1/blyoPLJZze3JMx1Woz+XAY+KZe0SmDIdgDD8+Ig/tX4JA9ypnjWIm732PKxadyEM3L
         1MVzEt/tiPfvL3OBf+/JcAI2sw/dO6mNFocOZoyvybXdECPjUjKDA8nzwOVZfdEW77JU
         rkzTI3mGqrMKZ/AGE+BjUw7NXYNZqGIvNhj/R4ahGsalG0T4CckRAR/+635PjSivGbbV
         wGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004378; x=1786609178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hy39CtWoc0zoje5YFx3qF8VnAfrlLSpF/ux3KEcnob8=;
        b=nzChfe1l5FFKbpCJ1kJaj3Ipz5lugIt7aWc+t7rk2g66pUcHklJDvX6vRuR7ETjPOq
         j5XUQ4kPqcaCGMXCt3My/gM5E04Cs5B71uu8iKd2srweFHVPN3ioqo2HTa8QmJuBAR8P
         Ki0XITJZ9BOIXwbyJ5P9xFckC+d+ZvrDINM+M5OCTpwfQO0uwSCUUIHHn/WulvVsoqzp
         RzQUSsYAIAH4jvNCE0/nmPURZ5NGyhKpaiwu0TB9gd/djhUrgqvL67iGr3lhMv3U3H/d
         GUI4Pr5mDW+sGSdWoZ3LAgMnz+johSGF76Z2SAvjt0AwLtovWSaKoLqhPgNxNIUiltHW
         bcAg==
X-Forwarded-Encrypted: i=1; AHgh+RryVn4eLzPS/qZpGCyji74rmhSHbim7gW+FeCI1BskTJZvP75CQySlhKICdwyuj6H8Uc5ubG8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl28Ro0QWYezFa1GBwJJIAxftTptGajQhxe5aKig9t1Ny9ubFz
	x+vgzJtHzPn2bBsBdPVAPaeegOXsJq4jTbyh/s7raQIgZAO//AuajQ44DA6Xho2nf162GeOjq8o
	RuIg/SRcR6PjvYjqapWZRXAv1ghjqIe2NQQU8x0V/+w==
X-Gm-Gg: AR+sD11a8H4N5yv3pWwtE+YYifhP9VC9hkFVjNq/YN0sxGGHA3dL9J2/bagNi8IMjZJ
	/DBlpNU4rfUTEHoN5eWlqbZ5MMXdUHrzV3hRgJkgpXepSM4CL1d4u6TEHnM/Rru+XGFTLD6sQ7P
	pJL6cJnW0VSvbu3US/KBr+XVywNqo+Emqg2gE8PlP0XjSaUdVHOCgr8s+odX8sbGPUriO0LZ25S
	feg4QTFtNmwjhxK0sEFSWJJ2ScDrQgoHNewsrNro7chRyWRmjt0OpX8aQzcHyhDFedmRYXIB4a9
	hjCv6jWYHN965oYi3qIRU8KtsmZtlrDfpQY+9OW7PVlvP3Q=
X-Received: by 2002:a05:6870:7196:b0:456:cdf2:ae66 with SMTP id
 586e51a60fabf-4599f106966mr6769705fac.20.1786004378386; Thu, 06 Aug 2026
 01:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806055501.56761-1-cuiyunhui@bytedance.com> <20260805232941.e89e96269472ce5106967bda@linux-foundation.org>
In-Reply-To: <20260805232941.e89e96269472ce5106967bda@linux-foundation.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 6 Aug 2026 16:19:26 +0800
X-Gm-Features: AUfX_mwGgNJoKFTBh_OuUz7py1XbYGaSQo8O6U35_XIAe-5lSBoXE9Jh7Dvpc8Y
Message-ID: <CAEEQ3wngAf7Wse8=zfByvzuuZvvy3kD7gD+HJZjvHTOf1UBiiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/madvise: avoid skipping pages after
 splitting large folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: liam@infradead.org, ljs@kernel.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, 00moses.alexander00@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Aug 6, 2026 at 2:29=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  6 Aug 2026 13:55:01 +0800 Yunhui Cui <cuiyunhui@bytedance.com> w=
rote:
>
> > madvise_inject_error() advances through the requested range using the
> > size of the page returned by get_user_pages_fast(). Saving the size
> > before error injection is required for hugetlb pages because successful
> > soft offlining can dissolve the source huge page.
> >
> > That stride is incorrect for non-hugetlb large folios in system memory.
> > The memory failure handlers split such a folio and handle only the base
> > page for the supplied PFN. Advancing by the pre-split folio size then
> > skips the remaining pages in the requested range while madvise() still
> > reports success.
> >
> > Advance by PAGE_SIZE for non-hugetlb folios in system memory. Retain
> > folio_size() for hugetlb and ZONE_DEVICE folios, as compound Device DAX
> > folios are handled as a whole.
>
> Thanks.
>
> > Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page ord=
er before page migration")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Should there be an Assisted-by: here?
>
> When fixing a bug, please always describe the userspace-visible runtime
> effects of that bug.  Especially when proposing a -stable backport.
>
>
> I asked Gemini this question and then pasted in your email.  It told me
> stuff, but I don't know if it's correct.  In this case it would be good
> to hear that description in your own words, please.
>
> And perhaps a means of reproducing the bug - clearly our selftests/
> coverage here is poor.

The issue can be reproduced with the softoffline helper from
avocado-misc-tests. With 64K mTHP enabled:
./softoffline -m private -n 50
the test consistently failed with:
pfn matches, softoffline failed at 10

After temporarily disabling 64K mTHP:
echo never > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
./softoffline -m private -n 50
the test passed in five consecutive runs:
Softoffline succeeded!

Thanks,
Yunhui
