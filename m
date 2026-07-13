Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC33F6C48
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944896; cv=none; b=YZhKh8SjvP/RaqYwB3KXCZQw/6xNtc6lmvNc9Z096AJzHbkULWzILmbbEzskZ9CIQNo3uWzbCdR3TmdK2jnFKiV+P2UMzeGb6p4M6Cu5AVjn//NQmrv28rpQNN+l/eqaIy7aDhhP7QNNKjJa/j2NdT2n4R4FmUyIowv97JNQAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944896; c=relaxed/simple;
	bh=nPaLY3QMyRaPQCezeOiN+8/kbKikZVYjSkYg6n+Dga8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOD2nV0uZPyHKmaButbYZoIJVvaLFnoKN59uXuqMTALfKKzj2o5yyChknAAWUHaTeM3rrvsos8RaE42IR0Sj3y6KCAixdTG0QQcF2mmbvS0BZCWvSECBwyUwLkmIe3LoN5MNAw9XT7XkM28g8PdGPCROvnMTeeVesR1mp6hym2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=SO2eAqa0; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="SO2eAqa0"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id F2A3B1D4A2;
	Mon, 13 Jul 2026 12:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me F2A3B1D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1783944893; bh=nPaLY3QMyRaPQCezeOiN+8/kbKikZVYjSkYg6n+Dga8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SO2eAqa0MIalZC76JlW4Cl9/IQcblY9Rt9DI6zvXP1NTcvB8I6C5Ow99f+dPTaZdD
	 mYpSrxC8We02iErItU0SKW86CIqSnhUNsUCEujRSETpBpJYNkay4S1eWlsEkhv1MsC
	 a+Y3h4nEXevZBj6g5zPMizlJoCkR58/5W/5f4LHI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id U4q9KLvWVGrT1gIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 13 Jul 2026 12:14:51 +0000
Message-ID: <1c735c1b-a34e-4c0e-ba11-df3f69ee895d@dev.snart.me>
Date: Mon, 13 Jul 2026 21:14:50 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] exfat: bail prematurely from exfat_extend_valid_size()
 upon fatal signal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Andy Wu <Andy.Wu@sony.com>, Aoyama Wataru <wataru.aoyama@sony.com>,
 stable@vger.kernel.org
References: <20260713061954.19557-1-dxdt@dev.snart.me>
 <2026071352-bunkmate-anymore-0962@gregkh>
 <59343a70-1d74-4f37-a6a8-5a65fd585b90@dev.snart.me>
 <2026071359-overstep-gambling-73b9@gregkh>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <2026071359-overstep-gambling-73b9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 21:05, Greg KH wrote:
> On Mon, Jul 13, 2026 at 04:55:34PM +0900, David Timber wrote:
>> GKH,
> Please don't top-post.
>
>> Just a quick question: the
>> handbook(Documentation/process/stable-kernel-rules.rst) really insists
>> on putting an upstream commit, but this is an interesting issue that
>> goes away with the iomap patchset set for release in v7.2. There isn't
>> really an upstream that explicitly fixes it. I don't think it falls
>> under any of Options 1, 2 or 3. Should I just remove that line?
> If this is not a problem in Linus's tree, and this needs to be fixed in
> a stable kernel, you need to document it really really really well why
> we can't just take the same commits that are in Linus's tree for the
> issue.
>
> And even then I'll push back hard for why this is needed.  Be warned :)
Alrighty! Won't bother you anymore. I tried :)

Davo
