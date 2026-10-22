Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664165;
	b=JGCCg0R0xqgWmqryEru0gVPxLOw1St02laWMjZdX6rGlqirSRK0UZkBINdiAzh6C9zMd
	 JT7kO0D9R5PJYM3Dk39eYc3dPKhkEgCzicXY87Dp0jvBuC0+By0gDwwfRXKW2HnnbXdcT
	 zVT8gP1eNjmB9ssn9qa9JF+zuLHkIx8RZIXewGiJb1E0Mlf/RLKZRSGXzIqAkLFrgFZ+U
	 6/gnQWESrBoItBf5Yc+biYh/3xjNq+Mxor8suhGfUWADaGrawqhxQ+IPN7Avm0FpsGPkW
	 aj5gxgg2x8454EkzR5BtFs6bG6n9f7g5R+piNc295zqy+gILvyT5MMkcqCEvKrU7m4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZX0WWzRn0FNV1W6Q0Hw3GlD6+zISKnB9+CPVO6GlfIQ=;
	b=ds4+nV/s+exMJWTk52q8Ab78e1NU+pJdVgB7huYY8wfAa0IuDXOF4eDDaOvodNYwGd8O
	 QJm82ENqvF8YPbYZhLVmHlfuOiODHZUI/LDrNddo7VeZlE4Bb37kxb/TPNU7uaW7eKEHo
	 GITMjpYC77f0/R85CqbaC/hEG1RY17U9Jyf9qSrs1V8zulN0U6EmIsSKQ35d4byXCq2n6
	 GmjvnCGECPtoLiNXEztN18l515cph1QWXl+XhL6H06OIOw6JDJFaTCNoUKYEPIih5xr4X
	 ZSs7bFPeXcXJNbcjvFw+7KY0cXc8SgffQsqclaLvtgyJVtlWLawHsmw6M+mSh5zW+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJnljwCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E52606A31A;
	Thu, 22 Oct 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJnljwCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5AD1F000C1;
	Thu, 22 Oct 2026 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664164;
	bh=ZX0WWzRn0FNV1W6Q0Hw3GlD6+zISKnB9+CPVO6GlfIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJnljwCn1dmHZXuBKhqolIuDfrXyMXQm2UCwhsR9vEtBUxe0P0goHUgXYEFmtukBk
	 F+pLPn/zaqCgpesNjDFUqog5/LgZpltRlI9b5dkO4wRgr6wi7TyzelAugfcs5S8V7S
	 khUw8tbtBBPl+v34fJg2PVODcD94LH9sqH8VgHOchadW5pW9+91nEi912/iR9sL4Bp
	 m1d3x3gwqimqLdmzzTztApkeT7Fo2ecBSkw4HnSs5SdfJRH+d2K6MCKfY2O49kO7OB
	 fJCrAA3dHiywiaGZOajLDb6J/9r7/viFNk8SnitD6fsgqaA3/mttZ7IG4EL+zGNKQf
	 AWyYPz6bfKT9g==
Date: Thu, 22 Oct 2026 11:15:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	shaos <shawnq1@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: avoid broken uffd merge on mremap
Message-ID: <atniL5lYyE28HSTm@gremlin>
References: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
 <179266301162.763593.1501773594946042790.b4-review@b4>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179266301162.763593.1501773594946042790.b4-review@b4>

On Thu, Oct 22, 2026 at 05:56:51PM +0800, Xueyuan Chen wrote:

> > diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
> > index be8f5161f92a..f786a585caf0 100644
> > --- a/tools/testing/vma/include/stubs.h
> > +++ b/tools/testing/vma/include/stubs.h

> > +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> > +{
> > +	return false;
> > +}
> > +
>
> Would it make sense to have the stub in tools/testing/vma/include/stubs.h
> return a configurable bool, e.g. uffd_without_event_remap, and add a test
> for the true case? The existing tests would continue to cover the false case.

No, stubs.h are for simple stubs.

Changes like that would be only be made if needed.

>
> Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Thanks!

--
Cheers, Lorenzo
