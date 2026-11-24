Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795546526;
	b=R/4uJoDRidLNbR+bCoTq02ULoMWktzuE9Qb9gOaKxisRQ+MTMuTxP1NiXxHF2n/1CFqw
	 22hQ9bIDbowfL/lrIVK9ua2eh2ycTMibBN0YIBChBzf8D/HvJ5YPIQbOz/5aotJ1x0v+Y
	 LTuhL+kR2YFhQGZ2qHY9xGiaSPQ7nKU7TMCQNjZeQOeHeOzvj69cOiTMjr8OXFxsygzdh
	 KXh3GCcTIQv+pb6Qbx6xWbW5xM8zBFOYlp44lldgf0U8qi5T8OgMt5+KILjRzyaLEY2e1
	 h3u+xL6fyXnqC8Bj93KC3QxAPIqBUc5UUor+9MfeS0MqgLAyvejNI1SKhBN9+EnUduw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1u8Dtdr50GkWxwr/o6Art46QnZZWoGSZDLZvedZdu3g=;
	b=IpGUWn0ocAbtpcuM4+7Fw+9x6R1Wl/E2nafJgILIu3QfosEsMd7c/PvWe/QLxy9Q2uyq
	 FhSGH1eNnCjTi8NIi/+PaQLODFDVKRgYY/q3L/TG/JA3vQVyFjx6xhKOn/QYwhauQS6bS
	 Zjo1HN0JzCgam15tXCNFXxuupfiSiRQVLJe0IZnjupWtgo+jGVRc60m9uoCz0UMTFCLyP
	 0u4lQg1zq1HqCI3EAJb4AF+zxInHAeTm3ZBrHB1st0PxSzAwQ06prxUh1x0CtoLtSrLzk
	 apTbSPrEFZ+O0bjvkneRM5UZpYvr1WLpB8WwBwFLdTbg/jCopjhWZ2Cq1e8pt0O8E8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vz+5HP28;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE6606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EAE6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vz+5HP28
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso127205e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795546524; cv=none;
        d=google.com; s=arc-20260327;
        b=TLb0e+Six/9eK+SeI/glPGyvsSdySRzTCDUdTmskAPJ3Eg2/pvosxm/PcIxNewJtsz
         oF/cz4NX2lVkwSzrx1iXsEeFv9oSWzpd0WG8IGCOfr6bHHhVuetwPywbqATrwU4yY+P2
         57rzgr1fM06J6XX5Bln1wMgUWZPdVVCm3n/9InqsqzFoyjp7+CmJxyW2bLssfNWXs07R
         AnskqVsvQ62lW9jIQs6j82V+q0FG6jqjzG7l0Fkd8krUhVrp5mJtlIEvx7kP84BqBMRz
         TGtivzNb7f0g6yN19PCyzHG1/0/rKucJld+jcTnG5VghWgiJ6T0xxrV2+9IH9lW9nPgc
         5QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1u8Dtdr50GkWxwr/o6Art46QnZZWoGSZDLZvedZdu3g=;
        fh=6uTIcqOv2oY8dXOTLa/43bnEgG/h46TXq7HWhdhl5YY=;
        b=hemOL4RSaD1TosEwV4COxaBNQSJWnfbA8sDTxmCZRQ79pkmKnpGgWRcX5yWiYlc9Py
         M5Ht/jb0Krb3mrwt6P541WezA9CsXuPuYRPhtB7NVb/mZYJMWwzzCWMb7HdejNCTVHEl
         0f2snZ8MXsfk+rFii5Bsyxw+rpON/5xUlqC29eiI2BsTWkVIrBiYNCLnHjxEElndNW/p
         hxe86Wmv/RXeJr5jpGxHtxyH9HtjziMmHrji55WWF9AOQaQFYyEmvDRklYsEO77PDvuD
         qnP3fTYkSAks1kiirPDxckvAZbQUCCJTVdFY86pmovcoAYcgiRCaJ9AXOkeliaPDi20E
         cdBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546524; x=1796151324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1u8Dtdr50GkWxwr/o6Art46QnZZWoGSZDLZvedZdu3g=;
        b=Vz+5HP2869Z5ONW8Y9OVdf/1LqgOzZK2Y2POGAE2IeSEJXBWuGcBsTqNnhD7kYfpK3
         rSw+ii//1wdSuglD1QviPlArcxERzzQ3x3TZ/cVQRm/xf9GAJvcBPYvP7rkPTY4dBAn0
         DNOANmiVCizIcZjr89te8FclDZEEQAGW+kvy6QXEhnEQuZrkBf8rUMj0cSAdNHpFX52g
         fwdXfpWeuPjibt+/J4buOzFwtc0ZorwGu6cQAkLxDQ+XwGJQoedHLGtSKh5elSWf2vfA
         KBmdqtzhJFh/ydpeLFJdf4tf+Qbwrvtdjfs9UBtaMvsRfUhB17OS+klyMr4j93nZ9eWM
         5SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546524; x=1796151324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1u8Dtdr50GkWxwr/o6Art46QnZZWoGSZDLZvedZdu3g=;
        b=x4hxl2ijA9I9sI6/PaGCyV+v+FPzw2mV0C7yscj1icQt438/KXDGOXZXfnyn6TnsJu
         iLMibbxHoqFTTLPfS/+DifdBnK6jmwI0GNLU3yGMgxYaidMqQET0gwpsuhA1DNfGSyrj
         jsPqRtF4JXwkPvbriuXcnVWcR9kbMYOwRXnt8FYGthPJfzYFUpme2Qe8HmRJx3e9AI7w
         7Ky+yOyVNW46XfXJibuyQrxUg3GLMxgMKvc4EnPojNcyUCdT6XypjwfRvCccFdaeKW23
         CJ6xBMVHTei9Rsz4ffiVgPlt0DAxUiaTjZ9+ZOyFjiqqaekO2lBNrKVzFCWlf+fYJrza
         1BNQ==
X-Forwarded-Encrypted: i=1; AL+hErF80MULDWfPq8ZQ4YSUsR9clmm9Ld5LeIWLikyrFvQ7WDOLsaRh5EbvbmIOOb363WDPgvKvpYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cuBAftVW2mL8BSjiex5exXN7b3vFG8nwZYQYQ8IS9n7G5Iepm
	qm3ecgPIpYi4sgotlvFdF7+49U12NbiS4fohjFmgYcW+/V5szPG1cX5oQPpop8067NM1NZTPa8X
	+buzFnFGll+StevHC0nqT5qTrDvLpXaHXN+iL2o2d
X-Gm-Gg: AZFdTZcsKi3RGXKtbxIW7o0GeI62v+XGR0nZrWIT2Np7VD5amO3r8Rar05k7lb2Y1A3
	TbOngw7Al3Df0TIh8qr8aCGIJM+XdZQj14PoqSIcFHKETRCNLZAlL07MiM87YRqTK2pIT+MDwqF
	kT4XN/hs8JZfTgor7lacXcLfryZ0oEOZSZJ+/jse9EnMAVVN3WWYIVk1GEcNyveFtfWV4sVOkNf
	wy1ke9mW7+FEbYxMp0msdsEVa8C7/Wzf0j/4APFBd+oFWnjF0qGnGsqkqmpeIqNKvS8SBbbOC6E
	PRUq4ELoLyoHf28q0MbHTN88PatsyGmEYVmHIfm76YydUHTU/aiVJBKY/J7vRWuKhmBwH560b2w
	xmvMjOYyJnrbP/AkrHyJOXznwNvbWjG0xdXLBJTqAzfxEnqbhpMQWbGjawfFzQdrQ9cPQf8QNHu
	i18XoRWjvPbBibXThJfeo8o470
X-Received: by 2002:a05:600c:608e:b0:4a1:e7fc:fed3 with SMTP id
 5b1f17b1804b1-4bb916aef09mr3131205e9.13.1795546523926; Tue, 24 Nov 2026
 10:55:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org> <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 10:55:11 -0800
X-Gm-Features: Aa3M54rcD7lAjqTBZlWobdm479k0AAUvm_iZ5SlmrfOCMEFaBN5uZR2IYPu5xbA
Message-ID: <CABdmKX3Cfv9wO3SuzYOg-+UXC=BOSAAPRfMQUAep6JStd0DjUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm/memory: do not report OOM if insert_pfn() races
 a huge fault
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
	Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
>
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
>
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return valu=
e
> as an allocation failure, returning VM_FAULT_OOM.
>
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
>
> This can result in VM_FAULT_OOM being reported incorrectly.
>
> Fix this by introducing and using __get_locked_pte() which returns -ENOME=
M
> if a page table allocation fails or -EFAULT if raced.
>
> This allows insert_pfn() to return VM_FAULT_OOM only when an allocation
> fails and VM_FAULT_NOPAGE otherwise so the fault is retried.
>
> The same change is applied to insert_page(), which only impacts DAX (whic=
h
> has its own locking).
>
> This means that insert_page() now propagates the returned error, so -EFAU=
LT
> in the case of a race. It's not possible currently, but guards against th=
at
> changing in future.
>
> Similarly, update walk_to_pmd() to return -EFAULT if it encounters a huge
> PUD leaf.
>
> Target the commit introducing the first driver able to do this.
>
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon=
.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
