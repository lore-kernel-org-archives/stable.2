Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E13659FD
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813020; cv=none; b=maQGoNPmbEkVR0C+uatLBl0gmWU0nuj5wC+ZmdMGacZEpjtzR4Jm3vC8QrHgMxhQUXa+iht7P4gmsXhkDJrIL4GaBclDdvsVio1niKu0c09yQTFwkZ9Pp8cPvfI4Lf18BaQPE+qh5FH23mZNIpZuFmU9T5+RdVnafIu9LJ2Xzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813020; c=relaxed/simple;
	bh=JTM/Jus6z5uYmMFbUiIheDkKI8eus1V3SOBpLdR9odI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpBSCP1mp7I+vM4Pp0QqUl8ECOdraKthcl4nSmyuhnAFWcavC+VHBOrqZ74U8UExzK3gp9mNW6sV+aDGZFAGBTT80kDDjLGvlOa40ECxj6Gcs3TIq9pmgTB1i8eDbL3Ob7xIsqNhZZRz4N501Nnzr2VIxaf/giCesmMXKot9+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uscXzxiu; arc=none smtp.client-ip=91.218.175.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uscXzxiu"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JTM/Jus6z5uYmMFbUiIheDkKI8eus1V3SOBpLdR9odI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787813016; v=1; x=1788417816;
 b=uscXzxiuYY4X7ghTXzUs4FfZ42a7jOcobUxtfPaPOXYqrslkDRot81zDz8TQ8Cq2GzOwVJxJ
 QVf3C9EnHedwGhjRAg/94rBnf5v0MhfuqHEiXaepfjM3SZ3KcCuVhhAkBlxIDw8+rZmDqouUwjr
 OYRREM8tdT+y56oDOKj6HV9E=
X-Envelope-To: stable@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id a39bbff7cec06163;
	Thu, 27 Aug 2026 06:43:36 +0000
X-Mizu-Trace-ID: a39bbff7cec06163
X-Migadu-Flow: FLOW_OUT
Message-ID: <ba8e71ce-42e2-4c92-b7c8-dd6ce900a5d4@linux.dev>
Date: Thu, 27 Aug 2026 14:43:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] ptp: fix NULL deref when adjtime/adjfine are
 missing
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, arnd@arndb.de,
 john.stultz@linaro.org, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
 <e9c97286-d121-40ca-b6f1-4c63641e7283@linux.dev>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <e9c97286-d121-40ca-b6f1-4c63641e7283@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vadim

在 2026/8/26 20:24, Vadim Fedorenko 写道:
> On 26/08/2026 11:10, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> ptp_clock_adjtime() invokes ->adjtime and ->adjfine unconditionally,
>> but both callbacks are optional. 
>
> Could you please link to the source of this statement?
>
Ah, I noticed that ops->adjphase is checked for NULL, while
ops->adjtime and ops->adjfine are not. I then found that the iavf
driver does not register either callback, making the NULL-dereference
paths reachable. This led me to believe that these callbacks were
optional.

However, the PTP hardware clock documentation explicitly states:
     Clock drivers must implement all of the functions in the interface. If
     a clock does not offer a particular ancillary feature, then the driver
     should just return -EOPNOTSUPP from those functions.

Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers

Therefore, iavf does not comply with this requirement, and fixing the
issue in the iavf driver is more appropriate.

Thank you for pointing this out, Vadim.

> clock_adjtime() with ADJ_SETOFFSET
>> or ADJ_FREQUENCY therefore oopses on a PHC that implements neither.
>>
>> iavf registers such a read-only clock: no adjtime/adjfine, and
>> max_adj left at 0. ADJ_SETOFFSET hits the NULL ->adjtime after the
>> offset is validated. ADJ_FREQUENCY with freq 0 converts to 0 ppb,
>> passes the max_adj check, and hits the NULL ->adjfine.
>>
>> Return -EOPNOTSUPP when the requested callback is missing, as the
>> adjphase path already does, rather than adding driver stubs.
>
> If PHC does not implement adjtime/adjfine/adjphase then it is a free-
> running clock. ptp_clock_adjtime() has the check for such clocks.
> To properly fix core part we have to extend ptp_clock and/or
> ptp_clock_info to properly signal that registered clock is
> free-running/read-only.

I understand your suggestion. However, I plan to fix the iavf driver
by providing the missing callbacks and returning -EOPNOTSUPP, as
required by the PTP documentation.

An explicit free-running/read-only state would only cover PHCs with no
adjustment callbacks at all. It would not cover PHCs that implement only
a subset of the adjustment callbacks. Marking those clocks as
free-running would also incorrectly reject operations that they do
support.

Therefore, I think a driver-side fix is more appropriate for this case.
I will revise the patch to fix iavf accordingly.

Thank you very much for your comments!

BRs,
Xuanqiang

