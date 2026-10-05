Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2D4ACC74
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217719; cv=none; b=gx5OV0G8o0uxGRaPa/Mc01eDR4uHiOSR5kjhjH7GsTMnhJpxNzKEoKtn6axcfqiOxIPibrkTg3ssS1wvtJrlk1o7t1HrN+gUTbywEaiCxtxfilXvN2kN+CJp11I8E37n6cmEKi9cDLQXFfUe2TYm1aSPt9BKzNkqrRhgdxA1XV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217719; c=relaxed/simple;
	bh=Wabayo0A+V23nlqdPGZeinMxOUQ0mLM1x80wsm/ar9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPMzQaAIswRJYiAAwj87BJEMFp9ysdKENnZZvUbJlWpEDHK9XkdoB/7PA019HadKo7D7qiuaOieSPWMWiw7RCcR919p1kCgkXrHaDYgfvWIdHmhns1iJiX3nwvuluAlBllTbY+wGsLB5IE3VTiPF0q2yZJBezPwU943QhZANQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSLhh5iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSLhh5iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010B1F000FF;
	Mon,  5 Oct 2026 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217718;
	bh=ye3OHwF0ew+/sfyZ+eVs0TCL3I3M4sw8/KP12aRH4zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WSLhh5iveHDv5Up3RnHQJiYYXckafHLOeR92FON+kwkzrd42NC5HDB7yv937awEHo
	 TLY1XFAja5JJIDWQjywn2G0EIv2KRg1k+mEtscs/zC2PsSwdR+2q/i0tS86ziYCqZC
	 MLcKkIoii+/ZN8kNxqh2ZmnSmFi07rVum2TLtEVO+JMs19Mryy1pGXbG2YysL87jdQ
	 vMVdwbsnRNTZW2sXOgqBjiaK7miA2wJ9/MZCtZfcEksBp6rGq1bw3Wy8D73I906qfA
	 CVLgQfWCN2+u8ZEuVq34zVXecoAYbBIoxmunrEcq1v4z4NtjtInDXUJRvpnvBMNFkJ
	 OP7vzeU/LHwJQ==
Date: Mon, 5 Oct 2026 12:28:35 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] mptcp: prevent race between disconnect() and
 rtx
Message-ID: <asPQM7yBMxN3K6Jg@laps>
References: <2026091621-borough-happiness-9e59@gregkh>
 <20260917124903.223926-1-sashal@kernel.org>
 <20260917124903.223926-2-sashal@kernel.org>
 <83ad680c-9f5e-4328-b87f-ad0f14de9ed6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83ad680c-9f5e-4328-b87f-ad0f14de9ed6@kernel.org>

On Mon, Oct 05, 2026 at 06:23:00PM +0200, Matthieu Baerts wrote:
>On 17/09/2026 14:49, Sasha Levin wrote:
>> +	msk->timer_ival = icsk->icsk_rto_min;
>
>Because commit ea4eb2adb0d3 ("mptcp: honour configured min/max RTO in
>retransmit paths") is not in this version, this line should be adapted to:
>
>  msk->timer_ival = TCP_RTO_MIN;
>
>(Before commit ea4eb2adb0d3, icsk->icsk_rto_min is not initialised)
>
>Just to avoid a deadlock, do you plan to send a v2 for that, or do you
>prefer someone else doing so?

I can fix it up and queue it.

>I can send a patch to fix v6.18 and v7.2. The patch has been dropped
>from the v6.12 queue. I can send a fixed version for that one too.
>
>Also, a more general question, when you resolve these conflicts, do you
>expect an explicit Acked-by? I tend not to send them on backports, I
>only react when I think something is wrong, but maybe that's not what
>the stable team is expecting?

An explicit ack helps, but not necessary (since most people don't bother :) ).
I am letting these backports sit on the mailing list for at least a day, and
then pull them in if no one complained.

-- 
Thanks,
Sasha
