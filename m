Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DC1F4C96
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991278; cv=none; b=pPVlpVXzBtfdSJbAFSLNeketNVww52ZjKUKe/LNeLONi1CZ2UukFAGv73RWVG+zUr+1IwM3/HdgA85fh2bPaH0oWeq9as9I2WfJC7OFuj8HMairq56CJ48k1Fe6xZ+uZimJDhZ2Yd8Dni7qsLa3f5SFWvOpZNF/3vEdExh5cPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991278; c=relaxed/simple;
	bh=qhdz2d29ZCzKc1L7vfhoe86N9GWBB/y9R8IouJ0S0og=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ALPFgZPvY5KpYlwm/12K9F02lt4JtI1PAu58N0WOz/jIKgIPRcbU1mUF0wklJvr/Ky7zBFVIhEbTjzP7pLcRuExvNTIJrG7lsamX+9B3W1/mxLnqI81BMRvuuNkCGs4MEjFpFmMv10WW4bwJuQ+UU1e5TxGKo0o1nMllDpQgn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=i5q+8n1Q; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="i5q+8n1Q"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h6nv72r4CztGd
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 16:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1784991267;
	bh=G+X3gJfLzwpJLA0G0Ugf9Wbj+jHXFkOO/gbfBZokizI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=i5q+8n1Q5OTro0gEWOl2BtRo7MPtwTK81lVYo5hKbj6Sw5jz5xZkwF0wrPUk3tkTm
	 jpwFD63TpmocSGYSi0TM4Ak/lJQIWBjpuPErUQnAiUhZ4SUVYbNUECWc1+whHl6551
	 s0TIVT5EwEnoY50avodjm8dLQlcui6vUEMM8gzpasFosaIykt+F6zvqTo3kWqEcEcA
	 KMj+tOhiYCscFWrS1C+UR2HXCmkPIZoJOFqQjZvcAH0LFSxhlBlOeKrG8Lwe5/JUb0
	 7At0T54a9gWNNo48C0C0DR0XBO20w/74AqTEXV3pZXClbccp7xu5UbUgWu/Y7gbqKt
	 VNNvLv7R5CYZw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h6nv660Kzz929;
	Sat, 25 Jul 2026 16:54:26 +0200 (CEST)
Message-ID: <33bdf705-1044-49ba-a641-ac9f285a611a@gibson.sh>
Date: Sat, 25 Jul 2026 16:54:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amd_pmc: Backport additional delay_suspend patches
 for linux-6.6.y
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20260722165402.3199573-1-daniel@gibson.sh>
 <20260724105500.stable-0009@kernel.org>
Content-Language: de-DE, en-GB
From: Daniel Gibson <daniel@gibson.sh>
In-Reply-To: <20260724105500.stable-0009@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha

On 24.07.26 13:22, Sasha Levin wrote:
>> Daniel Gibson (2):
>>   platform/x86/amd/pmc: Don't log during intermediate wakeups
>>   platform/x86/amd/pmc: Avoid logging "(null)" for DMI values
> 
> Queued the series for 6.6, thanks.
> 

Thank you very much! :)

Cheers,
Daniel
