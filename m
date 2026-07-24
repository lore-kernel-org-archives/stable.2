Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B32376A0C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889790; cv=pass; b=dqxNtZX/Mt3XNdGT4SSYT7aDgeQV15ntXQKiK663svu9RQVzuLmMQpIZxPAVtQ4uwH4uYmatf+yp7v9T1JbIkqfNppZn8EdTOkQY62+J0a6L+EUnZosVEcKJE9NfHk0PRCPvC4+so24KN50/9S39MrW+RCVWyedL92uBGUxV0/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889790; c=relaxed/simple;
	bh=cnSmtPTQipAao77+x5iYYAZnshwrOzGbGhen4VhtXD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHHYXJDImHEvTUUSG3za1GghlPpKgQmlHPtFCAnH9/yWjFiantar1X20y1UNN7LQ0M9Bn9mJJ4hYooT3TRpJJBI6Fj93S04dxxlv4ontLk8q335cF5R8GSKl2eowOTh4KxsIqvzOT0JxF7N0V0IfoIQBiZDTlsJbrh+FsadfdZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MYsVyM6K; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UOexWYUs; arc=pass smtp.client-ip=85.215.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MYsVyM6K";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UOexWYUs"
ARC-Seal: i=1; a=rsa-sha256; t=1784889785; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W+QFJRW5S6BeeYyyi2VDY4EFKGxdbvOEKGzeWDr5q9bQ7cEat6JJmjLc3BWusX5HL6
    gHqT7sX/i6KS/P7KMNmYhq/xQfOifIPwwhnCc7pA/W9fji/UvLqyhpPscy4ybJmE9sWF
    UJLHOF57FYW3SqfS28+p6NKAUpYl7xhxllOzxUXV6JOujjnSdE8SUK2texomoGKW6wtV
    X9qTLbijnoLwdae/URY5ishm5kwt/58oIwL4VhoF0vY5fsuu3x40fKcXJGwg6HQnRbD9
    mIuj5QOxoy0gWFiugszNI5hhEb7IDtpXhIBOj0HudDC9C7A1i/NemrkvJo8i7JJ7FX6W
    gN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889785;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aFmx3O/x2BrE2DYisXz23QelVSLDjGsp2RbQbx7KveE=;
    b=HR36W1RGbrjY2KysubnCJHbmYQwcXCPECwMMEQB3Htdrfpu0qSiK+DgQaeGdzsks44
    6O6IcGzOHO/afTUnvj50JlZ2CzR7lRpsqofMtgsseSHlKLK7/fONhDAeEkFQYitj+EYp
    K54CKiOSv7iEFdpAQt2MAqQPeMqWJWRX5zs3dZVWzIP6y0WWVjiGwCUdzlD+/6F/gjK3
    88TfinxzEOpfrqzJZXxC9pzyTXoghX+YL/AWi2NVj17AgQpA1UxN0GHnxmdOZhH46xsw
    tc2PlSzshS/TGS47YxTAkt2BAKYfaR8m60onKu+NrLLQ+NFMy5FazV6s93PV+GmvorPy
    1rqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889785;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aFmx3O/x2BrE2DYisXz23QelVSLDjGsp2RbQbx7KveE=;
    b=MYsVyM6Ksm8k85yBMHry93FwbyWcXwTjClqMRhF9JJy2jxZAwf7tMOpwnCtRgYFaYS
    llpLfm/Ydn5uPRBhsq6gHR4sDWFHXD5Ex/QB+JnCTfbORmGNdZagD4d/1pFKH1QpyzHo
    T703Ei1tg+FhNJyPU0i4SQ7eGRuZ0+TizLhC9R6YAmqE08UKCY6HqPJQ1ou4ZIEDYYkj
    ztMGS03QtyIvVWGHQw71RUTYGD96lO+YAE9covicySTN8zzYldE+gyXX3Cchn/D3yKn1
    ao8DNpOrawkVneNsrnN9a1O0C4+FId9WAkHA+HfJ5J+dS8EWATI/6wA5rUaJeY5gEbur
    FxYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784889785;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aFmx3O/x2BrE2DYisXz23QelVSLDjGsp2RbQbx7KveE=;
    b=UOexWYUsKqdzd+LV6KvCg1eQ3ZSzLt0eyFDd7rUWkTBdEjJSGLUuZKdHKpzCfSsPWO
    D+ZHO25uDutPLs3XX/AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.219]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAh5tPA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:43:05 +0200 (CEST)
Message-ID: <e7720ba5-0c7f-4007-addf-b1820606e633@hartkopp.net>
Date: Fri, 24 Jul 2026 12:43:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/9] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2026072037-bagginess-bluish-c081@gregkh>
 <20260724101342.16000-1-socketcan@hartkopp.net>
 <2026072445-impaired-award-faa2@gregkh>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026072445-impaired-award-faa2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.07.26 12:38, Greg KH wrote:
> On Fri, Jul 24, 2026 at 12:13:34PM +0200, Oliver Hartkopp wrote:
>> From: Lee Jones <lee@kernel.org>
>>
>> commit 68973f9db76144825e4f35dfdc80fb8279eb2d57 upstream.
> 
> <snip>
> 
> Much nicer, thanks!  I'll process these after the next round of kernels
> goes out.

Many thanks and sorry for all the noise. I never had to prepare complete 
series for multiple stable trees so far. Will take a look at other 
examples on the stable ML next time.

Best regards,
Oliver
