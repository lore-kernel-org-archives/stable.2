Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B003033FD
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929340; cv=none; b=Tys73nSar34NuQ3F+BsH+LuiLSAgZDiygg5YCLJPbfp0AheQ4MLDSKQRTEn68MnUlpymg6vUO6I6u1VdzSWc67Nju/x48QYt0OqQ9l2KS1g7EIvfX80c87RadRjhY1HxEpstk+oFKiFjG3DMgY+cBY3kjikCVBpmb3b4SuwgLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929340; c=relaxed/simple;
	bh=XPe3xPXuymG8yc+qbSUjt54EDmlasBnE2atRLGPrksU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSt5XHwepA++VTQlk4+d5DUcfcChCpma8dfln6UtfETGjuUYVwPk3TszAQFdiYZPDpYcPSyshtu2dCvIEc43GxzsOXWnIcVLY2UvWy4jTiNeB03ThOE4GIBYpNTtsbT9HPZyoYHmcd1/9d+9r/Q+Dg/uUIl8b+DkKDZLovSHkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=LZdMqK3Q; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="LZdMqK3Q"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 418611D4A2;
	Mon, 13 Jul 2026 07:55:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 418611D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1783929337; bh=XPe3xPXuymG8yc+qbSUjt54EDmlasBnE2atRLGPrksU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LZdMqK3Q/SmmUEAHihTnuxaofJevm2kSwkXZyvj0aiBAikoXzpkjxSJNEtsX6MJvp
	 44I/talInE8G+iubAYE/K+KiiXHutXZgrWkl4pmVLKv1+u3qFgY0NgXcGfmcfwa+Ds
	 Bot7HFWh9ruq7h4XsjJc7792BLidpi6cRbyQZ6oQ=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id dDg8OveZVGpIxwIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 13 Jul 2026 07:55:36 +0000
Message-ID: <59343a70-1d74-4f37-a6a8-5a65fd585b90@dev.snart.me>
Date: Mon, 13 Jul 2026 16:55:34 +0900
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
In-Reply-To: <2026071352-bunkmate-anymore-0962@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GKH,

Just a quick question: the
handbook(Documentation/process/stable-kernel-rules.rst) really insists
on putting an upstream commit, but this is an interesting issue that
goes away with the iomap patchset set for release in v7.2. There isn't
really an upstream that explicitly fixes it. I don't think it falls
under any of Options 1, 2 or 3. Should I just remove that line?

Also, in the last patch I submitted to you(SEEK_DATA/SEEK_HOLE on
/dev/null), you were against the idea of using switch...case for
inaction rather than action on a value. If you ACK, should I just use an
if statement like so?

+ if (ret < 0 && ret != -ENOSPC && ret != -EINTR)  {

Davo

On 7/13/26 15:53, Greg KH wrote:
> On Mon, Jul 13, 2026 at 03:19:54PM +0900, David Timber wrote:
>> commit 82a81a7352bcf5f2756ac33d47ee0582737e9a85 upstream.
> No this is not :(
>
> confused,
>
> gre gk-h

