Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055533D47A0;
	Tue, 18 Aug 2026 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031882; cv=none; b=OzskuW1virAJk3PfHEyjcu9FNmGhuDkOQRAt0TX896YbjqWkAWwLXQYeDZJWrCFXGwrnkHU+i61kRR2VfgWRnJSFgetQtc0vlhYOiQ6ASqHXRY7VZyDobpgQ9nMKIS3VitDh+LyNSxEllie0aJSbDclq9alPeY5ade5mg68rYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031882; c=relaxed/simple;
	bh=C8IxF2R7EGMlmY+ZgnxS5Lyp9Ml4zlXF/L1MV1hnkIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmPRMP2byYPL6NZkQum8A1mRIMvBWRioFz1UXws1IKwcV1EvPgSLUGq4mpnhpSNYElSKfB5S7d5lbiz4TgW5B7jVkHxIjvhvbNCn2/mHSEhyorwbXw1oCRKUov2+7ACcNzOqu4xRPVqDXKjKEY03fN+AuX57gwV0FtnRtOY69aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xot1rQbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xot1rQbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A031F00A3E;
	Tue, 18 Aug 2026 05:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031879;
	bh=BOgvYvlcgjHt6MnMGIk91KBXtEgAHIFEjE4TIcZj8KQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xot1rQbjJlCSBFmEdo1NSPYDHP4kcrYh+x72c45odoHi6INZZn6nDnyH99ljAD/xQ
	 FoHxPDU3LqPBMO+XTwSKl8y8KIiaC4xP+76fd0GMNMiG7VYuDSp9lWCbQk9FU3PrKD
	 AaFVtMV83oh07eZLoyGi0RkNkI2vAKI7Lr1vfxbH3qSO7nEnsxHqeUR+5YLtFkd0A6
	 sFQXtbAYlrQY4n4uMGAmvi2COJt2yNfmof/gm/VD+saHonTL89ykg4CIsrKlk5U/65
	 Hjge5JLrtW0ZY1dALd6aACq9yHKAo3TkLXPKYXu3jTRde2RL/WRu3sKuFFfysJu1iT
	 94+ITzkUnaz8w==
Message-ID: <b9100abf-b284-4e56-a4e7-9dfbf96734a8@kernel.org>
Date: Tue, 18 Aug 2026 07:44:35 +0200
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
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260818044232.GS893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 8/18/26 06:42, Mika Westerberg wrote:
> Hi,
>
> On Mon, Aug 17, 2026 at 09:53:58PM +0200, Sven Peter wrote:
>> tb_dp_dprx_start always takes a tunnel reference which is only dropped
>> by dprx_work eventually. Tunnels that have no callback don't ever queue
>> that work and tb_dp_dprx_stop then has nothing to cancel. It however only
>> releases the reference if cancel_delayed_work returned true and the
>> reference is leaked then.
> Okay but we always actually pass that callback there so I guess you are
> hitting this because you have modified the caller in tb.c not to pass the
> callback, right? If that's the case then I suggest mention how you actually
> reproduced this whole issue.
>
> I'm thinking we should make the callback mandatory instead as we always
> need it for DP tunnels anyway. It should work the same also in Apple
> silicon (one you have the DP tunneling in place).

As mentioned a few lines below,
> ---
> I didn't actually hit this on hardware but found it while fixing a domain
> leak in the same area and that fix depends on this one.
> ---

^-- there, I didn't actually hit this. It's just that there's also a 
tb_domain leak here (see patch 3) and when fixing that one the asymmetry 
here just jumps out. There's nothing special my code does to tb.c , the 
only reason DP tunnels don't work yet is because they need two separate 
MMIO blocks (what macOS calls "DP IN PHY" and "display crossbar") and 
possibly also the display co-processor to be up. Once that's done they 
should come up normally.

Tunnels discovered in tb_tunnel_discover_dp setup a DP tunnel with 
callback = NULL but also never start the dptx_work there and I'm not 
familiar enough with the code to know if it's possible to ever have 
those end up in the "normal" paths which queue the dprx_work then.
I'm happy to also just make the callback mandatory though and just bail 
if it's not set.


Sven





