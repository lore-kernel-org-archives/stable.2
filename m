Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AA49B21E;
	Thu, 15 Oct 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054168; cv=none; b=unu9SX+OI8UqtxINJ3m3T3qP+K/4xoDE97bn5rVKtUv/x26gnKAeNULtlWQa6uLK98sOadZB2perKejuV3wS7bIMpPN5zQkiVsrTV2W48Rh+mTUooput2yvJvhxifVKQWubZjHq/FCTJ3MGzl8ZFj3jrYrEWy6T6BEis0o4SNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054168; c=relaxed/simple;
	bh=lBuHq37hzdxaeJOyGRjkqIxcxRhXWPGNB72dentm3TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP7edquTAD3AqvjWjHILElX9jaUoQtJHKmmFQo9NDVZ00rsmUQNAgrvqGbv0O7/Kpk8nOqGV+9SUUNyCImVjNJuJuv+A1pi3CY4LQedKCBcDCw/YLs/iDgpSL1Cu0h1QK7Et1TI7EUVydBAno5ZiZyKDef1hkbKle7dtEzomMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Q8S6FMFU; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Q8S6FMFU"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4j51vn6j4Qz4Qj3;
	Thu, 15 Oct 2026 10:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792054149;
	bh=lBuHq37hzdxaeJOyGRjkqIxcxRhXWPGNB72dentm3TA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8S6FMFUnftWwFf9EDGHOA7CNo3L76rLbTJzQd2VGO4+HAiLSOxjFY5/m5eIJHKrh
	 AK/Jt0ulIG6rNTG/WE53bufMrqqsSFFoUKl25vWrSFg93ACtUqoxYpgmWa6/M2zSFi
	 rrTBBiskqY5780UHeO7IrfI5kF4Bi2DmhFd4H/nCuCJy+ZEXRsEuhPEdxG/l/lRvAD
	 uK1aa6Aun5c6AIFRb1aJcb3r2jeOjHir/3b4eOMFYWAu/xjjDUhG/OlGYMgi4WfBvN
	 +YpYGgo80jBwQTRoIx/eM7g+ov1BErLfGmy5t5EgOV7rQmxX+7M+nK5dd+vc7y518g
	 0V/oFvTTAmf/A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4j51vn5ztJz7xmm;
	Thu, 15 Oct 2026 10:49:09 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j51vn2MDMz8tHp;
	Thu, 15 Oct 2026 10:49:09 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 31FB45FB40;
	Thu, 15 Oct 2026 10:49:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <25d12ba4-11a1-4f39-bca5-b3a53c479178@leemhuis.info>
Date: Thu, 15 Oct 2026 10:49:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL"
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Birk Skyum <birk.skyum@pm.me>, Andi Shyti <andi.shyti@kernel.org>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Daniel J Blueman <daniel@quora.org>, Sasha Levin <sashal@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
References: <20261014130805.48840-1-birk.skyum@pm.me>
 <230a39d3-6957-4203-a54b-88c871092e08@oss.qualcomm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <230a39d3-6957-4203-a54b-88c871092e08@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179205414479.3417080.12348267559968309700@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 31FB45FB40
X-NC-CID: E9wWJ5opTNcNsnu8ZcGkvKd91gC7Oen5jzscIarBKYcxfog7po8=

On 10/14/26 15:17, Konrad Dybcio wrote:
> On 10/14/26 3:08 PM, Birk Skyum wrote:
>> This reverts commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604.

Andi Shyti: do you plan to pick this up and send this to Linus for 7.3?
Or should be ask him to pull this straight from here? In the latter case
it would be good to have an ACK from you.

>> With that commit the keyboard and touchpad of the Lenovo Yoga Slim 7x
>> (x1e80100) are dead, also at the disk passphrase prompt, on 7.2.9 and on
>> v7.3-rc7. The first transfer on their bus fails.
>>
>>   geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
>>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
>>
>> With the commit the I2C serial engine clocks read 32 MHz, without it
>> 19.2 MHz. A fix for the 32 MHz fast-mode timing is still being
>> discussed, so go back to the previous behaviour for 7.3. This brings
>> back the hardcoded index 0 in SE_GENI_CLK_SEL.
>>
>> On v7.3-rc7 with only i2c-qcom-geni.ko swapped, the keyboard is dead
>> without this revert and works with it.
>>
>> Fixes: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
>> Reported-by: Birk Skyum <birk.skyum@pm.me>
> 
> (this looks funny because you're the author of the revert but
> it's fine I suppose)

FWIW, some subsystem maintainers don't like it. And YMMV, but I think
it's a good thing to have the extra Reported-by, as that allows to make
a distinction between "a developer found and fixed some random problem
that might or not cause issues for users" and "someone ran into a
regression and helped themselves and everybody else by directly
providing a patch"

Ciao, Thorsten

>> Closes: https://lore.kernel.org/r/179173732257.29426.7905170638383807320@pm.me
>> Link: https://lore.kernel.org/r/ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qualcomm.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
