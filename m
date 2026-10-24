Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857664;
	b=CVsajrYH7AmUFUq+YwwCCTrDMIzzusUT7hYtl5NEVsaR2bxVeySj9Mn7zsCq6cwFdOzq
	 WV+sp/iM0nFND/KSKSPDQQz/TMBPvDp9uV849HhykqFb/kRZV9bvVvv4XI7y4oWcFGBVA
	 Er0QEpmH1ABv0eNwpO6xJXPT4okZwWNZNxj72gBNXGyxCGVejuVAm8SXmEZimBxeR1foH
	 RRDS0nEc4NQbEn3UTPmIkkwtTJxHMUTTavT8g5y2a2/J7XcfiYq0BUrBMw/n98V0UW89y
	 mPt5jhZ8dx+YDbIjROnPy04tVtaksQBfYUzcNOYINw30bpL2UzgpNFHAUvmh7ILM6Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857664;
	h=DMARC-Filter:DKIM-Signature:Message-Id:In-Reply-To:Subject:Date:
	 Content-Transfer-Encoding:Content-Type:User-Agent:To:
	 X-Lms-Return-Path:References:Cc:Mime-Version:X-Original-From:From;
	bh=vSkKqqPrcRVk3BVNulEaeACxkD/BbD3EQ9kOWBnKbIk=;
	b=I9VG+HtP0JDExIZypf9x+BAkfP+oIgvh8isVxW9NcYI2N3DBUZwnEPWKIQRybREEcujE
	 2scu3/auGWyHQY2Wf1QjNTkHybQvXgqlItpJI1NVPmG6vkLL1r328HpybitwWQYcqWukB
	 rxqQXn6YtrIGTFCa+6il9pacJ8uERLdYMOrQJK7I4d1YMPc9i5vjqdIKPixKiLk35w8Ix
	 2PLqO4jnPtbPBb9Xh4YnIF+dtmQOtsEZ/+5+o87fAGdY3T5aiYC6DofgHf7Ja7ZsFTsEa
	 ez3+PXbpS8ru5OuC+95BL6cVKVUjSu1cHQjCqSC4tL4RUkJaFudvGLxpHKOO/l0OMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=Y8nqlMG6;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AF606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE1AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=Y8nqlMG6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792857657; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vSkKqqPrcRVk3BVNulEaeACxkD/BbD3EQ9kOWBnKbIk=;
 b=Y8nqlMG6xNk4CE50/o38uj+s9sIqVf8QCKM01PwMWpWmoxt9f3f48NdTZ8IhCJaMhNe0yI
 Degyuq0fWnZ+aqXwVdYnczcV/8uG34ZMqBkG7uLfASajhr2bQEvwkS9XRyp0Crpnnki6fq
 zXYlmXEDd9+zSfLSQ7X36bf3kBOk1CNP6agH4tIF0NPwBslNf1wpC22S2ySwuHDBmv7NTv
 KCkkEWXtHtomxwyFrZonIdeTUH2gVaD7AMmrED3Jl+Pn1Yoe397kVdoFYXfRTSEy96L4o+
 k2/SRf5q5nIew3oI1ciQp3CGUYNJ9AYgrx0JLQK5XWc1KYZq+IT/BBtaffFS5Q==
Message-Id: <3b57c214-6a43-4fc7-a531-fb5eac196465@bytedance.com>
In-Reply-To: <cc2e3af6-bb56-41b1-9cde-151797c3068d@kernel.org>
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Date: Sun, 25 Oct 2026 00:00:33 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
To: "David Hildenbrand (Arm)" <david@kernel.org>, <catalin.marinas@arm.com>, 
	<will@kernel.org>, "Ryan Roberts" <Ryan.Roberts@arm.com>
X-Lms-Return-Path: <lba+26adcd637+d0c240+vger.kernel.org+zhaogongyi@bytedance.com>
References: <20261013093600.54995-1-zhaogongyi@bytedance.com> <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org> <e0f60526-bb95-4d39-9a7a-72cdf32ca5b6@bytedance.com> <cc2e3af6-bb56-41b1-9cde-151797c3068d@kernel.org>
Cc: <dev.jain@arm.com>, <baolin.wang@linux.alibaba.com>, 
	<lance.yang@linux.dev>, <mark.rutland@arm.com>, 
	<akpm@linux-foundation.org>, <ljs@kernel.org>, <liam@infradead.org>, 
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>, 
	<mhocko@suse.com>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>

On 10/24/26 4:55 AM, David Hildenbrand (Arm) wrote:
> 
> Hi,
> 
> sorry for the late reply.
> 
> If we have the spare PTE bit, why shouldn't we just use it?
> 
> It will make batching over PTEs faster. And we care about that for present PTEs.
> 
> So I don't quite see why the stable fix couldn't just do it right away? Do you
> have a prototype that shows that it would require significant code changes?
> 

Hi David,

I tried a small prototype that keeps PTE_CONT on present-invalid PTEs.
It leaves contpte_set_ptes() unchanged and makes contpte_try_unfold()
recognize pte_present(pte) && pte_cont(pte), instead of checking only
pte_valid_cont(pte).

With this change, the guard-marker reproducer passed 100 iterations
in an arm64 QEMU/KVM guest running a KASAN-enabled kernel. The fork
and PMD-split probes passed five runs each, with no warnings or KASAN
reports. In the earlier A/B test, the unmodified kernel failed on the
first guard-marker iteration.

The prototype makes the reported reproducer pass with a small change
while retaining PTE_CONT. I therefore cannot point to evidence that
fixing this failure requires significant code changes.

Thanks,
Gongyi
