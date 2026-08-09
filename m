Received: from mout.freenet.de (mout.freenet.de [194.97.212.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1446238159
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.212.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786293566; cv=none; b=JW40w7mpu2N4tpO4gQntv+wrmCaSED7/nGT+ehUXzBqmJmXpf9pUL0fqvkRFAY8LPjJdWf4xdpM8xPd1Lq706jwHf+GpyuCZi1gbJEBVbLvcHZswt26ptv57mybHcfH65k+KP0CDMDXl5yZfVlQfxE6KyUUVyshJyYgGp22Ypyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786293566; c=relaxed/simple;
	bh=F8voDrvO10NPSHOsZI5cXqnrQA/bShE0uEcfvqCvpUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9e1jbAsAvsK1brASDuaM1c69nFGKVy0l9NWrzJRNuYyC2nTdoSlozAfedoQkFYa04W7h+Bhee913ysTk9pzlr9aTqEdsNLCO3wlmdvUXEXUu2RjRVdFbQHtSoy3hTryIxJM6T8h6ERj0P2K3162f9zNnww3z+21+LUk1WmS2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=ctrh+es/; arc=none smtp.client-ip=194.97.212.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="ctrh+es/"
Received: from [2001:748:400:3319::4] (helo=sub6.mail.fnrz.de)
	by mout6.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1wt6TK-00000002osq-39wF;
	Sun, 09 Aug 2026 18:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z5h+HN1ZV/0opE4wmzcoMKs6JYkhPMuo4GSsSroU194=; b=ctrh+es/+InlfnA0/5DTEYta5i
	uu5WylZKvV/OBTR+j7OYoMK4dIf8aG2sbUO9jiba1gr7l2C2YlhxnN/lmkoMVb2jDl/fTH4jqFeN7
	ihPby7YBTo65KNaFp0vYlvRlll7WPZ1QzVA3mFnVXuZQTNdsXJBDWpthyxb/KEOlPJhjbu+EPL43p
	l8O2mA1wnoowRmzlK9jt50/QqBnefvw+Cp6NdykDtryXTOCRRAbo/NqunII9uxZa5MeRmawnpVnoi
	Z9N5F1U4h4fZNCS5wQWIl8o0MxmtqoaDhOWga63j83U+NrhqkWx2dKku7FFiNtP++9fVACyDTNqX5
	cxTmbpPQ==;
Authentication-Results: freenet.de;
	iprev=fail smtp.remote-ip=2a02:8071:a85:f020:34ee:f5fe:6d2d:7961;
	auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:34ee:f5fe:6d2d:7961] (port=58466 helo=[127.0.0.1])
	by sub6.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.98.2 #2)
	id 1wt6TK-0000000D53p-2R78;
	Sun, 09 Aug 2026 18:34:02 +0200
Message-ID: <608ed117-5fa2-43df-b10e-738cf3b5c2d2@freenet.de>
Date: Sun, 9 Aug 2026 18:33:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drop "drm/amd/display: Add AV mute wait frames to
 dce110_set_avmute" from stable queues
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Wayne Lin <wayne.lin@amd.com>,
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 daniel.wheeler@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <a464c560-8f7b-4609-8bbe-b7048f603d26@freenet.de>
 <2026080756-garage-series-d50e@gregkh>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <2026080756-garage-series-d50e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1786293242CCF17FA0BE3CO
X-Scan-TS: Sun, 09 Aug 2026 18:34:02 +0200

On 8/7/26 15:13, Greg Kroah-Hartman wrote:
> On Thu, Aug 06, 2026 at 10:10:00PM +0200, Viktor Jägersküpper wrote:
>> Hi Greg and Sasha,
>>
>> I noticed that the following patch is in the queues for the 7.1, 6.18 and 6.12
>> stable trees:
>>
>> >From 443290d70b01e9c35830c300e3247c06581b594c Mon Sep 17 00:00:00 2001
>> From: Ray Wu <ray.wu@amd.com>
>> Date: Mon, 13 Jul 2026 22:23:34 +0800
>> Subject: drm/amd/display: Add AV mute wait frames to dce110_set_avmute
>>
>> From: Ray Wu <ray.wu@amd.com>
>>
>> commit 443290d70b01e9c35830c300e3247c06581b594c upstream.
>>
>> Port the three-frame wait logic from dcn30_set_avmute to
>> dce110_set_avmute so that older DCN versions (1.0, 2.0) also
>> wait for GCP packets to be sent out before proceeding.
>>
>> This ensures HDMI sinks properly process the mute state,
>> preventing garbled display after link re-establishment.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5167
>> Reviewed-by: Wayne Lin <wayne.lin@amd.com>
>> Signed-off-by: Ray Wu <ray.wu@amd.com>
>> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
>> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit 414da24137ace80d8c59fefd43ba3ec9f5f854ba)
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---

(...)

>> Please drop this patch because it leads to a regression which I reported for the
>> mainline kernel here:
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/5557
>>
>> A fix for the regression is already available, but it hasn't landed in the
>> mainline tree yet. Since the patch above fixes an annoying issue, I propose to
>> postpone it until the mainline tree has the fix so that both patches can be
>> applied to the stable trees in the same release. I will notify you when that
>> can be done.
> 
> Now dropped from all queues, thanks.
> 
> greg k-h

The fix for the regression has landed in the mainline tree, so you can
now backport

443290d70b01e9c35830c300e3247c06581b594c
drm/amd/display: Add AV mute wait frames to dce110_set_avmute

and

3141e3d61469bba2624a91c5e2407f110b33b29e
drm/amd/display: Check for tg ops in dce110_set_avmute

to the stable kernels (7.1, 6.18 and 6.12), both have 'Cc: stable'. Note
that the 'Fixes' tag in the second commit refers to a commit on the
drm-next branch and not the corresponding commit from the drm-fixes
branch, which might be confusing.

Thanks,
Viktor
