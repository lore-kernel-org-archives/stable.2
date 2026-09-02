Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85629B78F;
	Wed,  2 Sep 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320403; cv=none; b=taskjzRDXoCRDG0Z2JDaFMCyJM/Q079edsmehY7qi/OCvdf1pvAnQNQZV8epKjtBXUK+ePNfBRvsnZ+pSeBejNhWSODa37yno4KLKt4xEa9YdZ8surd5oK1VHcDmPp2fp20oRfWWFYEMJxbd/YsLM82YTkm9OlW2Ay5LATwQw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320403; c=relaxed/simple;
	bh=uDYnLfI9Aa5+jJvAV5ND9dJ4A0mwMALtMGM1iG4fnm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdm7rUKWbh4wouLmIJg2iA3TDN0djsrq7F0N6Ca1TN1I1e7G+P5R2qwt9/Lcj/8dn58VGepX4NksTq7SV7X4jqN/oL604B7cVorn3Bq0VsfAPc6lsyF1OVAfa8XBF+4CIYqm4snYr08SrTb6utFEnd08cjt2miyxRk1uaAR0ZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YOfzS+lY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxHf1K6a; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YOfzS+lY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxHf1K6a"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35C227A0095;
	Tue,  1 Sep 2026 23:40:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 01 Sep 2026 23:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788320400;
	 x=1788406800; bh=In5DW79fO3VDiYySeXS/i8pWpXqOI/SquxDxzES1DEE=; b=
	YOfzS+lYTlMi2RFVVaGl34gx5usshOZlqNMtsYuW2hWyjsBLAj71tDyZrUu52XmX
	133ASH2VScdrsssOoRLCmv51ugPBpIbfJAuIawXs99xFtuudAWzl6KwOr5fjQV1c
	iR5gkxDHcBxxRgftuf0mHcmhGjc/FGPFZNJpPYE9KXBOfWLKTIENIk/h37rUqkcA
	jSLkFL6pbTrZ/p0RWrhCn/jBzjCmc2XzpwVwJmR6r7Rw6nv9gePYSZGTd0XyUF3j
	c43sTiAuKrqK3AmWhZIJRWnHBAEa17/soLo3qxbI4vbXQwgsj94auFFXphRXuWa9
	IutFFaUlmJd6Rtogj3WGyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788320400; x=
	1788406800; bh=In5DW79fO3VDiYySeXS/i8pWpXqOI/SquxDxzES1DEE=; b=L
	xHf1K6aLkPQ842RbfXHzbWH+hnm3FDLzA1wl6lt/kS0GApLfSMCP1fAZtSFmFLrk
	pNMZebti6gn2SGzhQgDhDP9sNHGyEZgIc6Mm6ahagRy4IlkzL0njEHH8yX5vKj4W
	zBHhkEGvU7qpdGymPw8aBiJN6qOixT74rTaz7Fik2j6DMpdmD+Zj2SF8jFRsQRS1
	gLyPfp5hqVAY8jAGRLs/6vqBGrmkywcoU7+VBFM5AVgoP4mKneF1M4EDEJAI1UVV
	smyXL4fs5ULcCyq+CjEOkay8+IrKx1BtALYj9z4yQtfluSNLLNKCzMCRucGTrCTP
	U/vULyoLvy+52GWJRTXoQ==
X-ME-Sender: <xms:j5qXaj1s4RDioh2T-i0_Bm_7zlXG_J2jDpPHOH5jjQUJQmM6rn6Sww>
    <xme:j5qXat8yeUE0K7DW_tOKEEuVUWtvuHSEuTTgTUuZC6hMAZ6jE3R6IAbhMSTGRAA9h
    D0ohSmD7WCd7kYyi00W9vyN82gbzEgX5pW2B9XJIYVK4XHY4zdNrkQ>
X-ME-Received: <xmr:j5qXavbp9hSIY5jxOqmZVQSTwIeTDR7VxeuMmEakII256xJA2aJBbYOG-zhESIuW2X5Zo5Mp-N5tGQmKtMn4-Vgk-EAopkyY>
X-ME-Proxy-Cause: dmFkZTF1wNsmtCvWlSNdN+3WxjnlaCDK9VuqrR63ZTkwHJQiWRCqdwXSaYHjyQdVHK7e8Y
    SYlYLxr5gSTy4JUNJxqE5Ho1jfMLp6ujyl/9tmP+CH8kvVG7vHNfnNu+zuw10fFkOaqIfm
    bVBClD1g4BAmI/2SEywlYKGk9nAob42tpVnElREDOsneKG/g/XVa0rT8NobPp6Z5G3Mwa5
    X7hgwWWMYahiFgdLerKXlDqPbbekOS0lD8GYlpqyRi3cc59PDHumJ8KLUroMtoINxuwdtY
    U6VRY/HU77muts+Qwqjwgp3BApmQ+CjPO6QIBULagHkywwGn/d7yzor9XsVEASD5h0vmT0
    8WyVgsyR5tIX2s7Cho73jdAKBqHgkGp6SwgavSt3S0PTpclipbWjO35GlHGBVQR1PQWZXZ
    2HZfAbKk1GH5e8VKT/r5AtMbsErvwsJjcbJnT/1iOSa2drJigYxrRdWuZK6x4hwmWvF1QJ
    +WP7Pi58EJSKAnBRePVutY7t3s0pULH4PDxNSyz2GcSmkp6P+rxTPqL2lekB5IJyQ6Bx4B
    MFETIeX28PRkX2p4cwf0RZHSZU1NMdWvoO/RS7KhaMAd/+qJTIaIIoFSqpempsDc8mbpLE
    TmLt6rFmsUK6Mvus+zHvVmjuIqAVqvaNV1BJ3ScYEm76/KgIRcDVMW6YNmug
X-ME-Proxy: <xmx:j5qXasyLjxkyStJhpROyWirONZj8I8ydZTN2iWr8ZgVB5dw-rQ-pnA>
    <xmx:j5qXat-GMx0c_vL11bWjSfd_iZNI9uNnOur42Z24-zUMZg4AfOb7Fw>
    <xmx:j5qXaoxdDDIgMEXSFefa3ZsSjqmWcYQ4OLeqMhWvLmqaAZkB5PAtCQ>
    <xmx:j5qXaiu-KRqfmu0lidHe5Pmk4lyADvsir45uG7b55840hr42he2O5g>
    <xmx:kJqXatpemHSbVppykoKDlOGseZn9Q0AYvdF5aXoAKGGBP1jeNlljWy92>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 23:39:56 -0400 (EDT)
Message-ID: <fcf6128b-8f6c-46b7-9217-03aa1288298c@pobox.com>
Date: Tue, 1 Sep 2026 20:39:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.468089036@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260831133359.468089036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.156 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
