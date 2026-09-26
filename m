Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8C35C6A4
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790446479; cv=none; b=tUQRZLTiMiL/dbYifEsGqUQScwbiSAIXx+BoO2kk7DuDkDNipFI94Cwgp7/kno1XjF0jLhmBMKt3mEUKwVs1jmwcLW8iaC9wBaluu7XBBwMghK3lCsE03k1BPlMcEugk8XQoJqwgImlXgr0EJLlEFet0XCZkWeGnxbvEqitjzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790446479; c=relaxed/simple;
	bh=PKAmzdVbyaF31KV/p+hs0qg3JKH38sTcP725YVbI91g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+CCNmvKiO0bha78fLocVdpX8p5rE9FK4cprMLoKMbgnOhjg3Y38/eVHHrAtUifGR0dIPwlvottvQ3sBm+/VTHxwSPvRQDNuS2ahHaeq06z5UqQoO4WbFtSOkHOnp5mUnnXYwFRU5EabIk3PZ3ro3ts4NLueYfkxtwEDRJ/FuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=mAUDJpo2; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="mAUDJpo2"
Received: from NEET ([104.28.193.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68QHLFGj099249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 27 Sep 2026 02:21:15 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=komxAsBAeKVWiVU9cEuuT6C8YxdblA0qxPXmNE/d9VQ=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790443275; v=1;
        b=mAUDJpo2z87DwYwujDD6ONIoBCctJCrf+3xZrGX7g+j5JNVAjM1tM+3cpp7hu+wG
         7OJpiMgaFApIjyX+Dwto/qdOJjaiCnq+lEPknO5dFLFsuB/iyTsZwBVCXPnH2tuW
         lqHEvd6Q89Ut5IojLvyIvvUV/uJEhhdUS2tjA+fCssihsowK4aPIi7cLTQGukcRQ
         +540fw1+kQ1WBsGgnpJcgNWcBxwU+CZu2QNRKMLYV+bNIv618Ti738CY2L8JIIxL
         UdyMoJe2LtGJpmCseA0X1hmlYGfKo8XVhKuomi+hBpkCJrw8fp8kNQZT9HmeI1YS
         e2ZM4NdF5KBRBW0ZpACkQw==
Message-ID: <b2be67b6-137f-4381-86fb-0d7bc74dbd3f@mgml.me>
Date: Sun, 27 Sep 2026 02:21:15 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y v3 3/7] KVM: x86/mmu: Derive shadow MMU page role
 from parent
To: Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>
References: <20260913155523.7423-4-k@mgml.me>
 <daily-reply-0006-re-kvm-mmu-derive-child-role-5-15@kernel.org>
 <arVZfjUskXC54OKZ@google.com>
 <2026-09-25-daily-reply-0014-re-kvm-mmu-role-prereqs-5-15@kernel.org>
Content-Language: en-US
From: Kenta Akagi <k@mgml.me>
In-Reply-To: <2026-09-25-daily-reply-0014-re-kvm-mmu-role-prereqs-5-15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/09/26 3:48, Sasha Levin wrote:
>> I vote to backport the relevant upstream commits.  Reviewing this without those
>> commits is a pain.  I think it's these, to get fairly clean cherry-picks?
>>
>>   dc1ce45575b3401102568dd60ba8894849d1d64b KVM: MMU: update comment on the number of page role combinations
>>   41e35604eaff2266ba8523787ebe99c5ca4c4045 KVM: X86: Remove useless code to set role.gpte_is_8_bytes when role.direct
>>   b46a13cb7ea1137b2e01dfaafcacd5cd79db8390 KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
>>   bb3b394d35e80d7a58ce015191e4960a13f54ba5 KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the direction
> 
> Agreed. Those four apply to 5.15 in that order without conflicts.
> 
> Kenta, could you send a v4 that starts with them and then carries 3/7 and
> 4/7 in their upstream has_4_byte_gpte form? 3/7 doesn't apply on top of
> them as it is now.
Hi Sasha, Sean,

Thank you for the review and suggestion. 
Understood, I'll test and send v4.

Thanks,
Akagi
