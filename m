Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E03438034;
	Mon, 24 Aug 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580829; cv=none; b=h5m3VM106ub6SzcCXWmfc7epXaTDvSHAzVqRjL80t3NR2tQJNKGuQQAW/56T4wIsqG7KBrxZ+x8i5RAttbGLEUVrMe2o4yAC1V1g5l/MM3Ko5i+kBwsj14f27AJ8wP0c5K5sOr0IVOsakK/QiNnDskzj5jQkDoJ42Sgs6Lk3Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580829; c=relaxed/simple;
	bh=/QskKS6MjCp216FH1IJ1L28MiOIGz6sp5k0gybneMng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV9/YHHrjjnDLDW18cDrqnr42uCvlYsRMxjJayvaTC1c1RKmXGe3LipuHm+uzklfHYhRS3EoypnbAMhxR4mJznSESYuWB/DeoHnC/6zol7V0TzUlmcufuRJ/SY8HoVmupvB77Z64flmP1WIyG1g9a8XCh5GMY3WELVNChmUrycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJcFO4ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJcFO4ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81751F000E9;
	Mon, 24 Aug 2026 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580827;
	bh=XqRGZUwWZm3USp2izXfh+KeicXJvzanQzOa9UHk69Qw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GJcFO4ax3+t5BTyG+XWmAJkIYMdJI2IVc/wWOg6h14/XfLgp2ZnTI40IPV4/3EPp+
	 56H1HEimibhIZ0yoRowNL3NnKy0DiitQ4Tg+LFaG2bp23V3VI3JMleKXM8Qeg9LX7p
	 7ZfZfZdPxnVtZeqIPqqDtPmU06tPPbSqrEIhnlWIbHu+J9aL1BvO2Cv3pvHhYcyPSE
	 u+fQ8l+Ikj/PjZPKmq2ZXJm12JGqwAXMb8bhQygWms7TtW244CYwRqtr2ISyz7oiKv
	 8DmyUBgMcQwj1zmSgrYkcm4qv9MZqEC4TzvX9etT/Oosfoi7wJik95M2BtHaE60pAu
	 dz7RXlfyyeLug==
Message-ID: <b15f514d-d7de-46b7-8b78-fa21515f1fe2@kernel.org>
Date: Mon, 24 Aug 2026 16:13:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] thunderbolt: Make the DP tunnel activation
 callback mandatory
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>,
 asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-2-26a18a426c9f@kernel.org>
 <20260824104546.GG893316@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260824104546.GG893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/26 12:45, Mika Westerberg wrote:
> On Sun, Aug 23, 2026 at 06:09:15PM +0200, Sven Peter wrote:
>> tb_tunnel_alloc_dp() takes an optional callback which is run from
>> dprx_work once the DPRX capabilities read has completed. Without that
>> callback tb_dp_dprx_start() reads the capabilities synchronously and
>> never queues the work. It however always takes a tunnel reference which
>> is only dropped by dprx_work itself or by tb_dp_dprx_stop() when
>> cancel_delayed_work() actually canceled that work. That reference is
>> thus leaked for every tunnel without a callback.
>>
>> The only tunnels without one are those from tb_tunnel_discover_dp(),
>> which are activated again when restoring from hibernation.
>> Pass the callback to tb_tunnel_discover_dp() as well and drop the
>> synchronous path such that the DPRX capabilities are always read from
>> dprx_work. Hibernation restore then also no longer blocks for up to 12
>> seconds while waiting for that read to complete.
>>
>> Also fix up the KUnit tests.
>>
>> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   drivers/thunderbolt/tb.c     |  4 +++-
>>   drivers/thunderbolt/test.c   | 37 +++++++++++++++++++++++-----------
>>   drivers/thunderbolt/tunnel.c | 47 ++++++++++++++++++++++++--------------------
>>   drivers/thunderbolt/tunnel.h |  8 +++++---
>>   4 files changed, 60 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>> index f43f2d952372..29b9879c40d8 100644
>> --- a/drivers/thunderbolt/tb.c
>> +++ b/drivers/thunderbolt/tb.c
>> @@ -89,6 +89,7 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
>>   				       const char *reason);
>>   static void tb_queue_dp_bandwidth_request(struct tb *tb, u64 route, u8 port,
>>   					  int retry, unsigned long delay);
>> +static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data);
> If possible move the whole function here instead of forward declaration.

It calls a bunch of helpers that are only defined further down and I'd 
have to move all of them as well (or forward declare them which defeats 
the purpose of doing that)


Sven

