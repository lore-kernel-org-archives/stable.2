Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02744485518
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872802; cv=none; b=CZvXRGK96Dk7G4sTr942aOjgDeb5Pgnxczd1fjWEZX2rnLZnGARGMqSQ1+zEqcNz7ycY2Tv6pp9R9SsQeL4DUfsvBLUtaPSvbj6BQstS+FfUBG9j7ldYpKkd2IDtuBdBxPb32BNXUHT3qCAqwEVzyKglgDHgsWjU8M905UAOODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872802; c=relaxed/simple;
	bh=ijzhhCvBzPeAT3SqmYXHx89D90VBI7qukSZjs8T278I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SaaQLCYvopJJrHGwhEUeOVK9gXP8NgyiYARyfWqUfwc31SMWWK9PlwEPglZh4hzAHyQrGleJ10RaN+XTNJ4jOyfRJ1TagCtQXMjWoadgi4RV8L221prFL4GYG7AE/6+BzYYj2EeT7o40NoXjNxKXQhkMb5Gxe7jVby9SjhRYX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u9i9HxGs; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u9i9HxGs"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ijzhhCvBzPeAT3SqmYXHx89D90VBI7qukSZjs8T278I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791872798; v=1; x=1792477598;
 b=u9i9HxGsO3x2RvdZiMo1y0Po1scVIFQibDJHRCRougUnPXM9w7PcUAd1D5oZEM5Q58NsF8KY
 CTMpA5sg+FfSAq+7QglTMJahRbZKRUojynG++lked1XiHGWAQoySDRDBtF72CCpb/hM08/hxCum
 JrAENks08xw5/XfDhdt0Xc38=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id afbacc7007ea9f8d;
	Tue, 13 Oct 2026 06:26:38 +0000
X-Mizu-Trace-ID: afbacc7007ea9f8d
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261012202532.f059fd5ab947510a21d34cd1@linux-foundation.org>
Date: Tue, 13 Oct 2026 14:26:15 +0800
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Dave Hansen <dave.hansen@intel.com>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org,
 linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F709D85-8F18-4237-BA0B-BE8442DD221C@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
 <asy-b7_C3SjnmSaS@gmail.com> <145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
 <20261012193114.77147e0a43affa8ee1ae896c@linux-foundation.org>
 <200A83B9-233C-44C7-B4AF-0900BA1E09DF@linux.dev>
 <20261012202532.f059fd5ab947510a21d34cd1@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 13, 2026, at 11:25, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue, 13 Oct 2026 10:50:21 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>>>> The correct trailer is:
>>>>=20
>>>> Cc: <stable@vger.kernel.org> # 6.16-6.18: bf9e4e30f353: x86/mm: use =
pagetable_free()
>>>>=20
>>>> Andrew, would you be able to update the trailer in the patch when =
you
>>>> pick it up? If there are further review comments that require code
>>>> changes, I'll fix this trailer as part of the v3 respin. Thanks a =
lot!
>>>=20
>>> I don't know if/how the -stable maintainers handle a comment like =
that.
>>> I expect it's more reliable to do this via Fixes:.  Possible?
>>>=20
>>=20
>> Thanks. I used this format because it is explicitly documented by the
>> stable kernel rules.
>>=20
>> The shell-style comment is the format documented in
>> Documentation/process/stable-kernel-rules.rst for specifying =
additional
>> patch prerequisites:
>>=20
>>  Cc: <stable@vger.kernel.org> # 3.3.x: <commit>: <subject>
>>  Cc: <stable@vger.kernel.org> # 3.3.x
>>=20
>> See:
>>=20
>>  https://docs.kernel.org/process/stable-kernel-rules.html#option-1
>=20
> Oh.  Consider me educated.  Edited.
>=20
>> A Fixes tag alone cannot express this dependency. It does not specify
>> an additional commit that must be cherry-picked first. The documented
>> Cc comment provides both the prerequisite and the required =
cherry-pick
>> order.
>>=20
>> Would this be sufficient for the stable team to pick up the =
prerequisite?
>=20
> Hopefully.  I suggest you double-check when you get the emails as =
these
> are applied to the various stable trees.

OK. I'll keep an eye on it.

Thanks.

