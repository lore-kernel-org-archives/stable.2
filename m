Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDA3E6DFA;
	Tue, 18 Aug 2026 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033474; cv=none; b=S02DalDSpdHad8LT93WY9Z6opkdhS94U8r159PWZ8wq/6g1erS9rqDhFGq+N5d4qVdvxp6q30vrUvXgFtWXVQ+edD9ibvqbGkABD60ohYQDfhbWUEfVjG4ihZIq89zZBLo7p+uNYyYK/Fc1ah1K9orYXjzR76AdhcfxBLpKN1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033474; c=relaxed/simple;
	bh=3TYtegmQS9kZDx7zIvs7igx3g4nB4su+cTsBb4Zjthg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8+TGB0quZ0aloY0OSPlH6XEbD33NtMN8xeLJiQLphWFMg0iXCEPq9xdGxbJ9CEPGRHNTCqZfl2wXtA0sOrKtVEVu3lEjHfJ7VgD+n2/BdYfJajGgfxMKPjzIot/5T6BgZf/rsWZUc8oDKBUs9XLnsUjtBmiTtOl4wa+JeY2a2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqcpRAH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqcpRAH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B1F1F000E9;
	Tue, 18 Aug 2026 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033473;
	bh=EGMhWoNiPafztQY3G6W9AqhX/B7mJEXHMBgGbE/G1Oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RqcpRAH2c4kw2VLJMVUgWkvkLEpEBXGMFBVWJp6PG356+JPZx4/flg20q91y/uvhG
	 0/cRxJ1ti3eui1sQNr+ZCo2GfJLD0JE0dTdck19m2Aksf4lEzsHb2AiisvSAD+UhrA
	 AL9PINHb48kj2ZTfqmE1bkuK6i8wO5UzZAmqBJnlmxLdtPuLZPjW2p1cf7XuTGVoop
	 qrN76BdRI7hSf1a5Ca2ul4/EBbYL9N979gub3yTct/DcNqf5X4xGLMJgm/DJ4/7UjL
	 xCJG1ohSd9J7xu8orrBWtRCNBQRSuM6OHNa8mGhQf/EX57JNhKzbaCyEguL7Sbcvvv
	 I9orVYm8ZxJLw==
Message-ID: <da48977c-071f-4671-8f19-e22d14aa3105@kernel.org>
Date: Tue, 18 Aug 2026 08:11:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] thunderbolt: Fix tunnel reference leak when the DPRX
 work is not started
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 stable@vger.kernel.org
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>
 <20260818044232.GS893316@black.igk.intel.com>
 <b9100abf-b284-4e56-a4e7-9dfbf96734a8@kernel.org>
 <20260818060044.GT893316@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260818060044.GT893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/18/26 08:00, Mika Westerberg wrote:
> Hi,
>
> On Tue, Aug 18, 2026 at 07:44:35AM +0200, Sven Peter wrote:
>> Hi,
>>
>> On 8/18/26 06:42, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Mon, Aug 17, 2026 at 09:53:58PM +0200, Sven Peter wrote:
>>>> tb_dp_dprx_start always takes a tunnel reference which is only dropped
>>>> by dprx_work eventually. Tunnels that have no callback don't ever queue
>>>> that work and tb_dp_dprx_stop then has nothing to cancel. It however only
>>>> releases the reference if cancel_delayed_work returned true and the
>>>> reference is leaked then.
>>> Okay but we always actually pass that callback there so I guess you are
>>> hitting this because you have modified the caller in tb.c not to pass the
>>> callback, right? If that's the case then I suggest mention how you actually
>>> reproduced this whole issue.
>>>
>>> I'm thinking we should make the callback mandatory instead as we always
>>> need it for DP tunnels anyway. It should work the same also in Apple
>>> silicon (one you have the DP tunneling in place).
>> As mentioned a few lines below,
>>> ---
>>> I didn't actually hit this on hardware but found it while fixing a domain
>>> leak in the same area and that fix depends on this one.
>>> ---
> Hehe, sorry missed that one.

No worries, maybe I should've put it into the commit message and/or 
cover letter as well!
>
>> ^-- there, I didn't actually hit this. It's just that there's also a
>> tb_domain leak here (see patch 3) and when fixing that one the asymmetry
>> here just jumps out. There's nothing special my code does to tb.c , the only
>> reason DP tunnels don't work yet is because they need two separate MMIO
>> blocks (what macOS calls "DP IN PHY" and "display crossbar") and possibly
>> also the display co-processor to be up. Once that's done they should come up
>> normally.
>>
>> Tunnels discovered in tb_tunnel_discover_dp setup a DP tunnel with callback
>> = NULL but also never start the dptx_work there and I'm not familiar enough
>> with the code to know if it's possible to ever have those end up in the
>> "normal" paths which queue the dprx_work then.
>> I'm happy to also just make the callback mandatory though and just bail if
>> it's not set.
> For the discovery (happens when the boot firmware/kexec sets up the
> tunnels) DPRX negotiation is already done so we never need to do that for
> those. I think it simplifies this if we just make it mandatory.

Okay, great, I'll look into making it mandatory for v2 then.

>
> BTW, is this bringup stuff available somewhere already? I have M1 Mac here
> so perhaps I can at least help testing things (assuming setting these up is
> not super complex).

Sure, the current WIP code is in 
https://github.com/AsahiLinux/linux/commits/tbt-reset-wip/.
It's not quite in a good shape yet and I have a few improvements in my 
local tree that I can push this evening after $work. Right now only 
XDomain works since pcie, dp and usb3 tunnels need more bringup work and 
not all cables work because I'm not forwarding the information like 
Apple's NHI expects them just yet.


Best,

Sven

