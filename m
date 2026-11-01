Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793511117;
	b=Jbx0m/p7QSzZdp3oQVvb7+cmgu0bsPyk3k5Qb7mtbENYec8Z3FqeVXb5VZRLMgZlffND
	 XU6KQGQQauXV432hqKoWxdQfB7hVSXLr/bNWQdL9oq/Vbvosq+ck7GlBZIF328bYbo6DK
	 neEeY21TSedUMm5lSIomBuNdyI/HNMQwNn9322LDZezX/XcHob3W476/pjHeoPfEpoct3
	 cnXT7yMmvAOmovsggn+rCCUsj7/IAgl146lZIb+m1Vl/et+EoG/kbC5rwrdPA755mzfsq
	 cJSXtJP410VM6D+fJdBkfMucLGx4TsAZ3ZbKg4uP+gRakIZVqIhVZzpNt2JL/hdOPzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793511117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=XVwPKoe9RjiKHmMO6/+ENKIpPwM8V1vN0DPm5EJ76mY=;
	b=aGbsPZijf9QyIvUHWNbDHnt5ZtUPcPPIBzwYrkUm2QYnadii3HDLcFHdyLZXPKrQ/2Gn
	 tLf5Cg7BLn2p7qWXa4K3wUgSpQ1YLwzZST9RnzY1uw092fJB5ZiyfztUgTxyDGubcAcqQ
	 F4s3oStTi1DKVSpnRMC7vio9ufrCuAhy20s9VH3s9K1ojfWdjFsurPmePduiVQfVBXH3f
	 2A6jPcb7uNgd1PSbuLkxs+AcfpldV3ywKLq2AHYrQ4KAyrAlIF46mVNWTDdWZ3XGqdTGs
	 zQwIpTuJ35YDtjeDVpHamB+ge830NJ080iFIzEdxzpX4jkH87xDq9TmZbJfW1v4Y2Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jgUlSuHf;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84592606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 05:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84592606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jgUlSuHf
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2eb0a52d605so44815ad.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793511117; x=1794115917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVwPKoe9RjiKHmMO6/+ENKIpPwM8V1vN0DPm5EJ76mY=;
        b=jgUlSuHf06M9uujyWqNHLI95zdxW32DG/F/8axwNdb1iGXk0FccdSCqQKnnEwKqotp
         R5h9wJe50JXq8pHTbJOkmAK1O7aHoXHWcK2c4ihZsbQ9exo+ZGPoJKWq4JWRVqymFvBW
         tjl7ohbXSWNMNzoz7rl4ZS+jMwjYpT4DBiyXlNqGEWinD41+cf5pp+jbjqGpRalxQshA
         YgWUb0WWkE3YMh+CIcDOanCEP4VdIYE8mGI7/RrPHVtsFTSFuCUK/s4PHsjuYfK6Ey4E
         K+FfNaSj4cTENyP4AT3Xp96Lkiv/G5fn8k8dwkaN628PAEWvfQ6uBUqx85UTTHHYRNoy
         qiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793511117; x=1794115917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XVwPKoe9RjiKHmMO6/+ENKIpPwM8V1vN0DPm5EJ76mY=;
        b=hQ7c8PdHnF2HQIVZgK5WPbrHug+ywLeOCDu2haqbPH40Ct2lbEv06GFs5q0P28PKHq
         m+9Kq8RHyaqfr0XHaKbFJiakufu2/d4nnsQqkAhgUurNfHN6Qk/wvZJ3ScU/RBm3L0c9
         vfYaWj1Ev9bqqAhYPDF01GEQLjM3LRmj0rDkP5Onshx3+TjQtBVGzJO5AlOtHX25P0un
         3BVZyK7EkTW8CwR4uxoBy2gfC9I30Td1QEE/f+qeEcO+ORvzyFlXD8QWWhyWvLpptMV4
         8Pi4UQvMGriSV7x4OaMO9WVumCD15n0oJYU09XIGvsVQYDkDSlNrC/ne1vZAnSU/Ypu5
         otAw==
X-Forwarded-Encrypted: i=1; AKwUvBzHij0KP4KoxQ8PicYQ4hppWa+mf8n/jdhKPXhtk0nQ1HAQxHL2Ca6Y96H6m9Ru3qRZqnQdND0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o2Ko1YMYN9NLCEYqHwtywIRu5L1QWFErVLWwdC+MYyt3eGW9p
	oXtaFhfKdgm9oOtFIN00JRU6W34U+kGsAn+G5VgJbdrXA9qZK0X1whs7yYbBM5m+Ug==
X-Gm-Gg: AYBFou2xXspFy+/JbKMf1HhTPmQwI0HXsjWi9RbgxYl2h/Mzxa1Erwzso/htVkVXnfJ
	aFDyLU+PlrIMDVGNHBuAFfS7A15C0DSIJlBLYHtOMxc0ETkOBFEtylwM629xsZFX4ZmyFYIwJ0H
	5oT1GTyhbod3yJLmHRwsZKB27z5No7pWmkV6wh8iTLKpC/dpyjP46kc4HDRvkQT4RPvUwA2hz2Q
	OMDsSgW3aU2A5+EpV2Jw1PEoxbZAQFQZIkiCp7Jj9ndh8bi6xcJxTqTI2p06k3seazqylxS38Ia
	vY24h+wDePhh+w98aPsXiXjM5wWSICkC0X+laBXm8hZuRNYnV0orBGpLL8l0UE6So+GMI5kcdbt
	Jl9uQp2HmYga3S2QVIjwMgiDmz7nn6y/TKPSgJ3qO4CwKl2WMo9XgdNmDbVQ+4eMhJ32R5ap9Tw
	tn0y1JJOz6KcsEYMkol7elLoAYW2uyaoCOK2479pZDXEOiMYhAaL3GlRKF5ubyJGXdeKrhFLMK5
	wMR58e5APkpAdRQ6fHqVcD5Le4eUkgv2ad6VEt/FGHQn4DS4FlWcjS0lOZdYVLVjOBd/poMhF12
	ykiGyluTz40s0tKIA4avDgWOK/3heT4K59XfodGi+U/904fJsaXCqV6jpE9+2JBbjCPQaxv7RJL
	RVpcmONPK6BGZGf1/HN8a
X-Received: by 2002:a17:902:f541:b0:2df:42af:2f9f with SMTP id d9443c01a7336-2eb1ec33fd5mr15542125ad.1.1793511116342;
        Sat, 31 Oct 2026 22:31:56 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09614e4bsm1987052a12.4.2026.10.31.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 22:31:54 -0700 (PDT)
Date: Sun, 1 Nov 2026 05:31:50 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in
 memfd_pin_folios()
Message-ID: <aubLkqA-aWrcklwS@google.com>
References: <20261031203540.2282507-1-skhawaja@google.com>
 <20261031194058.d3bd25ed950e5340ab595f07@linux-foundation.org>
 <CALCETrU76ThzLDbUfpoota5=xcoOS4aZrwgK2B3ELkYcFOjGJQ@mail.gmail.com>
 <20261031212507.31609e7ed27de35253b226c3@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261031212507.31609e7ed27de35253b226c3@linux-foundation.org>

On Sat, Oct 31, 2026 at 09:25:07PM -0700, Andrew Morton wrote:
>On Sat, 31 Oct 2026 20:20:03 -0700 Andy Lutomirski <luto@amacapital.net> wrote:
>
>> On Sat, Oct 31, 2026 at 7:40 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> >
>> > On Sat, 31 Oct 2026 20:35:40 +0000 Samiullah Khawaja <skhawaja@google.com> wrote:
>> >
>> > > memfd_pin_folios() pins folios from the page cache without taking the
>> > > folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
>> > > its refcount check while memfd_pin_folios() still pins the old folio,
>> > > and the caller ends up with a folio that is no longer part of the memfd.
>> > >
>> > > Lock the folio and recheck folio->mapping before pinning it, like other
>> > > page cache users do. If the folio was removed, retry the folio lookup
>> > > from the index that was removed.
>> >
>> > Can we please include a clear description of the userspace-visible
>> > runtime effects of the bug?
>>
>> It's straight-up data corruption if you manage to trigger it, no?  If
>> you manage to race a memfd_pin_folios() against collapse,
>> memfd_pin_folios() will pin the wrong folio.
>>
>> Fortunately, there are a whopping three callers in the whole tree.
>> You can hit it from udmabuf or iommufd or memfd LUO.
>>
>> The former two will direct DMA to the wrong folio.  Fortunately it's
>> not UAF as the DMA will be directed to a folio that is still pinned,
>> but it's the wrong one.  DMA reads will read potentially stale data
>> and DMA writes will overwrite that stale data but not update the live
>> copy.  (The DMA will not be directed to some other application's
>> memory, just to a leftover copy of the calling application's memory.)
>>
>> As far as I know, the effect with LUO would be for stale data to
>> reappear in the memfd after handover.  With the patchset that started
>> this whole discussion applied, I think it might result in misdirected
>> DMA to freed memory (I do not stand by that claim at all), but that
>> patchset is not applied.
>
>Thanks.  How's this for a changelog?
>
>: memfd_pin_folios() pins folios from the page cache without taking the
>: folio lock. khugepaged or MADV_COLLAPSE can therefore replace a folio
>: after checking its refcount while memfd_pin_folios() still pins the old
>: folio. The caller then receives a folio which is no longer part of the
>: memfd.
>:
>: For udmabuf and iommufd, this can cause data corruption: DMA accesses
>: the detached folio rather than the live memfd contents. DMA reads can
>: return stale data, while DMA writes update the detached copy and are
>: lost from the live memfd. The detached folio remains pinned, so these
>: accesses do not constitute a use-after-free or target another
>: application's memory. For memfd live update, the stale contents can
>: reappear in the memfd after handover.
>:
>: Lock the folio and recheck folio->mapping before pinning it, like other
>: page cache users do. If the folio was removed, retry the folio lookup
>: from the index that was removed.

This explanation sounds good to me.

Please let me know if you want me to send a v2 with this changelog.

Thanks,
Sami
