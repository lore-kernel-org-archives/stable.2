Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABD18EB0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613217; cv=none; b=gzKYFZWI8wpDoVRbZZyJN1D+3kRZ+Hm48guEKWcpWr8KOCadvRJH1OIbFBUaFXFpgJSWNgHbXTQrauWVWslf077EszJNTlyIaWdn7Q7Okqsu22jm/LXhFx/NUz0mmK2s64z4xh0dkhJ0UyYAag+c0fAVfNQWzhFolkKkyysgsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613217; c=relaxed/simple;
	bh=pP/6N83U74VjqkF4C5mfZhgqsr2GfrlZ9A/Wx1S1qSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7dbYnDhvYqdqX3Emmr6u1HG+4r3bd3AD1FUODC0ZQ/p1yitgUxKx9yVc8xFBJk0MZboDB6gYQibTIZMKH/lTYS50W4cpn4LxvkrFsczmRhiByrraB0SPgJ2rq+ebDyQo4u9otR1lGER6GgJEBRD0BEWkE5pKmKe3+rBfQwdwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfihxwc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfihxwc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46211F000E9;
	Tue, 16 Jun 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613216;
	bh=Id9yBHu3CT8/NqxH8Dpt0XSrySuOcaeUeQN3N5/9EPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfihxwc1hlWeiFclq+ycdIvmoyvLmeoOwMJG0vMV8xYC5VJhDfxEnK+S8blApelPB
	 65Yr/Qd2gEJB2rhY3E7GK17EK/SCRE3VReCsAnDmIZMk+ZCn+yM5WqoWZ54QGM9Sht
	 wCcA9qx+ky+MBrQO6gORI5Yhz4g5fe9gwZa/i4ZuB2Rqddv0e+qY/7SQQIQg5pQ+Ro
	 tTRaALLRIAvl0+JRreaO0CxyP55plozBLVsrD8rHqWb/c3oLnD+RIl1M14Vd6u1u9X
	 Oob1+hCq82l2ak4K6/muiGCYp3XAByUUYoBry9CX+IaZUzyqkN/aZJdTwAZ1/KmI0X
	 yMmmm3c7lPfAg==
Date: Tue, 16 Jun 2026 08:33:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] mptcp: fix missing wakeups in edge scenarios
Message-ID: <ajFCnqgA-0upNshY@laps>
References: <2026061533-ninja-scrabble-539d@gregkh>
 <20260616001959.2587348-1-sashal@kernel.org>
 <a511d4e7-3b0c-41f3-830e-b32e27f9fe5a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a511d4e7-3b0c-41f3-830e-b32e27f9fe5a@kernel.org>

On Tue, Jun 16, 2026 at 01:01:34PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 16/06/2026 02:19, Sasha Levin wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> [ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]
>>
>> The mptcp_recvmsg() can fill MPTCP socket receive queue via
>> mptcp_move_skbs(), but currently does not try to wakeup any listener,
>> because the same process is going to check the receive queue soon.
>>
>> When multiple threads are reading from the same fd, the above can
>> cause stall. Add the missing wakeup.
>>
>> Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Thank you for this patch. The subject shows "1/2", suggesting a 2nd
>patch is expected, but I don't see any, and it looks like no 2nd patch
>is needed here to resolve conflicts.
>
>So just to be sure: no patch 2/2 expected, right?

Yes, sorry, human error...

-- 
Thanks,
Sasha
