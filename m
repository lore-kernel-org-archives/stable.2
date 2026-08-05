Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F173C98A2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910122; cv=pass; b=FjFnvluWFyYqYZGFxsOoJgzuujrnGvZTVVtGZilfBuX6m6kRmfHOETt8TeLHeLbM7BXtFTk34lyXizCbhk/lt0l2KceOuUJJLgakEyfbhzMUJ2+1n1pmviZKbUW1HxtTqG/narm+kuW46eAQjlWb2xhyF3z+DKy2fKRBZ/pNIk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910122; c=relaxed/simple;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQQN+LuhWLA4MY3tiajA0xYCKSYnIzz2Viyuprv33m4p+ZS5rvdop046fr7alWlcDYntiGkFzxed1WvP/VxITOErUnvv1RC8tSn9AT7nGwiR6BgJSaR8gyhZkyWqx9rC24VzSb09m+wyn34mPLzq8CgTKe82ecvQL2mjgwMD5FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVN6HXQB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+y5LgfF; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVN6HXQB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+y5LgfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785910120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	b=jVN6HXQBsue3BzZxFiYMlc+FI9GLlnYL8lB3zJajioL6Ue2STN/aEJUVxytWf0wEOuUlg4
	dkBmRKuzWEDqcgai9ETubvuLP9CHZJdjYITXaT0UUKEQjGg64k/UBBcNkiKyPEPP53dX9Y
	eVvVA8QE2lD1ZQN/Ll4J0khJ7gBzKE4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-_JBIHGYmPryEYinDKXqwRw-1; Wed, 05 Aug 2026 02:08:31 -0400
X-MC-Unique: _JBIHGYmPryEYinDKXqwRw-1
X-Mimecast-MFC-AGG-ID: _JBIHGYmPryEYinDKXqwRw_1785910110
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475e540a0ffso309533f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785910110; cv=none;
        d=google.com; s=arc-20260327;
        b=OSpyniCAy+uePeBkuqpQ31Svi6LYbkzWrwzuVG+BC0QsBpQL5sQwSMKb8LV1xySGll
         IvA2FWsbLCmanF1GcnR3U8yOdLDzL92TSYtnYkoa1SWqYlMxqhBX9nMAhQG+1qex1C1H
         fAq5GbvSj5pZGBn/BY2g4Ync4LNWFLEWwqLxCKVwFlF4wYyjTqQ2AmqzL2OiVyedZXu/
         cRLicXXzCRv4PuUAm25nDnGCeCstewLG+MgT6lhdhKHtLQvoMRooci1HFO+UY6f6V52n
         wey76QI/ftJY/LNnYTpey1O6VUHWHSZaMwJjHxq8Uz0MtnjlZ7ZX51UtLGuWvO3Q6BcL
         f+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        fh=J9CSIyRG4s2iX1gAttcLUFoD8gGYuH03Sm7wxFNyadE=;
        b=Fe9kq3Qo86L8T4sYrIP+PXJOVDf0uAMG6m5XTfdcMM+tQZ4qZprqbaWFp8H2RM6btU
         g92QiuMN0tfnn7oeoNjH+N7HAIS06LkUSTf4tblPSnlbZsCe5zV3kb72ns8FzJwAFhZ6
         Ry2JdRjYNSrjpIQRIkTR9MJaGaTznkCIbxGvI2IosmrBT/clJgSDWyJqShHx6Efqzj+W
         ODog4L9SWja2cC7tCEJ8w1OX1nm5Ohm3c7C80WqW3XJxAkcvuF3DFwu9T2jCx1ykh+vj
         puOUpVd+zUPx8qVCWfY28uOks+yLmZNPs2zE792wfo1nXnVIgXu5YUIzlCWDnjsatLnO
         3jrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785910110; x=1786514910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=i+y5LgfFY/jp9p2qY1DrA/Aq5Jgf2ReSbS7NdouwIkk8bNPUozzCpHECiXVSuaVsIU
         A9zKCMSZnzsvYsYCIing134gae5QMiD/89iX1i91Lyn3wT7WUBE4SOx/UkpGRLHzFlg0
         aSHMiH95oOmJonCtFxg+j0u8aiAGUHrZlXfyNpHfbJh2BBnUPy8UCmjVZ2ZsP+1mmvF+
         xDotYXJiCaF8bFgjP2pmM8wER8RFrR+abo76NpO39d7lwMT5RqtJ4f4Ppu83VNII9krf
         xQdunnII9lWsEydnDOS30fuvQk4txoU5zwr+nbwIoJxFmInpBatGIiOw9e7QVSnAVBE6
         YOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910110; x=1786514910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=DRBW9Mj800N/iObHgQxDwaPaeAo0P/LrLFKL62implMbyA6h0Fs2ST8VN6Y1PbsZNX
         cVIIkXm5+/AFi3Fj7vcfTPGUX+k6u8IyxtAfxwKgq68BFfdc0hHimfiCWcpR5vBnx+ZK
         5xHARtivqcMUj8BD3UY0bg8hofVxqteDW8grka3e2jdl0V0GLfa5q2wY7zFqWrV4WFG1
         8l4bMFsDQtJJFaRVWT0Jo0/JGoUw4COTONgYLoVNjhVUIOcATuTj5H596IGgnTWHhOuo
         IWDTDTJcapzZbXHuXSHdxPzkgwDhbgr6bvK4m+59tAjx1UvYbEBatQn2wtGiWgp/ImcT
         rz1A==
X-Forwarded-Encrypted: i=1; AHgh+RqKgidBeqNp406qvMYpOApxezXf9/tX8HsCqWoSDhgQJjIJKDe7AgbR8G1F0ZRsCgRw5/ohvNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3wAu84jA+DIC8QfaRkPXa6d3wGJscBMx7VXkWjErzJyFQQHf
	8P/bwY13HzoIb+yGUR8UwMcPs3KlXTemrhJbS0wzDdY57tI/Od2CLE3PcAKUvTCbBCRnZ86wfOv
	KuU98INQRXLxcru8VJTzAEHY9aeAiWQ2qmpYLk4NqJIFjgwQ24wlUUKhop5u56M4Q/M+U9stvti
	OwnWL4pg4eGdyV0nnNkbyB91N4VAbuw5Uy
X-Gm-Gg: AR+sD11gLmmXabUvzfuMSAQiBTCHNyh30WVYsf6p/dnDhdr+iZC/PccBMSYMPSaRW/E
	sVDRiX3aVVZV4R5oE0CjJ3MUN+stTVv8eGltfr0/dARyEilHSILY6mARP3NGuIMRZ4CDcemxaAs
	tCu2Hnjl0XUJM4jChaC7ZeQmmsuS//CRHg+BrZY4I4RcpbMxDyyEjF2zKgyXPvztOMPP7Q3hyCw
	Ox52pKp5AJl4M/vweyNHsBAG/nmtTm7nkhd3C4janNAQXgTszA8nd+Rlb8=
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id ffacd0b85a97d-47fec4e888cmr5402582f8f.6.1785910109870;
        Tue, 04 Aug 2026 23:08:29 -0700 (PDT)
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id
 ffacd0b85a97d-47fec4e888cmr5402532f8f.6.1785910109519; Tue, 04 Aug 2026
 23:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
 <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com> <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <20260804164206.655874ce@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Aug 2026 08:08:17 +0200
X-Gm-Features: AUfX_mzo9t9ubVXz5xpYzVx4R9t4U8bdls__QKfQW65v6eCkMtC4FUkJ5hgXDI8
Message-ID: <CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Christian Koenig <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:42=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> Okay, I thought I'd ask to be sure, because of all the implementations
> of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
> kernel/events/core.c do that.

Also the vmwgfx one in patch 3; and for the !DAX case ext4 and XFS too
(e.g. xfs_filemap_pfn_mkwrite gets to iomap_page_mkwrite, not to
filemap_fault).

> The rest have their "generic" fault
> handler (by generic I mean a fault handler helper that covers all the
> order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
> non-zero vm_fault_t.

I see; I think you can do that, it is handled at
https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L2681 and
indeed it returns VM_FAULT_NOPAGE. But it's more or work for no real
reason. Your .pfn_mkwrite is a single line of code and it is clearer
IMO if you can see that try_insert_pfn() is calling the same helper as
.pfn_mkwrite().

Paolo

