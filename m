Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CF499F35;
	Tue,  6 Oct 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304078; cv=none; b=h1EO509AeMq4d3iB1XC5jEii9PWHTa5rhp5hQa2WKDdd8qlPYiI+fc3jc3638ih0vwVQHvPLg1BRbxB52GQXxIx2SczrFQb0pw/ydXjlJnGs5favzdI0FkndV1fY6jgO93Jbg3TnIxS1Bxq6Kk9w0uggYiSiazvWbw34r9joV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304078; c=relaxed/simple;
	bh=einZpVySWHR7THz/woUWSFbPbcaKQ1JxeslA9nIItWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtS+zQL6bU08d14QasjbxBQPFHseDMUSjm5+gfruQaygXZDrmqHeS41qjcCGUSNezNNjy6yTUrbcLwoI18SkKGDQ/cssviYDzXEyr4hw+M117jBZ36xjrRCO84kxfnJe3+CrMHiaQ9Hh+zeixMyIYoIg44RLRlQ330fjWlVTaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH4Cr+MS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH4Cr+MS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49D91F0089B;
	Tue,  6 Oct 2026 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304077;
	bh=oAdk92A+HQ3nvb4p8Km296vmXq5e9pwl0DRvbbfWM8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JH4Cr+MSu9bsoMSxpDlIA4FxF1DlalnJhCgyNtBA1IvTi09NIrKW1CJipKUuFvfWV
	 yP8Qg7CFPZm1tiHH/IaUi84lTtdKwY/iu1uJIyowqpGUmgpkG/2vkGM25CEsgNKuK8
	 xYo262SsdCC9bSeJCJbhD1vrkdUObQdkOHTbvPMa5/LLWeDDZk9DJYSFtPh2wYHi2p
	 xLIAlm5eig2muBn2rP/l3QnRCegK1IjzQ/P9CHtZLdQeyc5Smb/q7SzFmsYuvnXXIg
	 7FIzjBOdhh6e6+5/WdqETQthQHYt2KIgJ29PF+haMES6OYUPi7/L03PmJOS8rq+Jo+
	 90ljtzIiXaXIA==
Message-ID: <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org>
Date: Tue, 6 Oct 2026 18:27:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com,
 Sasha Levin <sashal@kernel.org>, edumazet@kernel.org
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/26 13:45, Jan Čermák wrote:
> Hi,
> 
> the Home Assistant OS recently shipped kernel update from 6.18.39 to
> 6.18.52 which was followed by a bunch of community reports about fatal
> network breakages [1] which had one thing in common - r8169 driver and
> configured VLANs. This manifested as network stall early in the setup
> of the system with dmesg events like this:
> 
>> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 timed out 6125 ms
>> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).
> 
> As there was no change in the r8169 driver itself, I focused on the
> vlan subsystem, where AI pointed me shortly to this suspect commit in
> the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
> skb_under_panic and races when toggling HW VLAN offload"), added in
> 6.18.51. I'm not referring to the mainline counterpart below for
> regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
> there as well. FWIW there was another issue [2] with a similar
> combination recently in the regressions ML but that one seems
> unrelated, as disabling EEE fixed that issue, and it doesn't fix it
> here.
> 
> I don't have the hardware myself, I asked for testing with this commit
> reverted, which confirmed that this change indeed started to cause
> trouble. However, it's obvious that the change itself is not bad, as
> it fixes another issue and the regression is scoped to very specific
> hardware/setup combo.
> 
> Besides the revert, following workarounds were reported to fix the
> issue as well:
> - Disabling TX checksum offload with `ethtool.feature-tx off` in
> NetworkManager for the connection (HAOS doesn't have ethtool binary,
> hence this option instead of direct ethtool command)
> - Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_hdr on`
> 
> Clearly, this needs rather esoteric setup to trigger the bug - I guess
> most systems set the REORDER_HDR flag by default, however, due to some
> legacy in the DBus interface that HAOS stack uses to configure the
> network [3], it was disabled. Anyway, I think that disabling it should
> not lead to driver breakage as we're seeing.
> 
> So far it appears that this only affects RTL8168h/8111h, XID 541 -
> there isn't any report of another chip/XID combination yet.
> Unfortunately, as I said above, I don't have the hardware available
> for testing but I believe I'll find some community members who'll be
> willing to test a proposed fix for the issue if needed.
> 
> [1] https://github.com/home-assistant/operating-system/issues/5019
> [2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@mail.yahoo.com/
> [3] https://github.com/home-assistant/supervisor/issues/7248
> 
> #regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
> #regzbot link: https://github.com/home-assistant/operating-system/issues/5019
> 
> Cheers,
> Jan

Ok this NIC can not perform tx csum offloads with vlans.

opts[1] only takes TD1_IPv4_CS and TCPHO (Transport Header Offset).

There is no IP header offset field in the descriptor. The MAC assumes 
the IP header starts immediately at byte 14.

So we need to change vlan_dev_hard_header() to take into account
vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)

Can you test the following patch?

Thanks!

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 
cb8f3cdbf1f732c55a8a3d69ab5445988c953205..3a518ff064465e8ab978c66a28bf7df579931256 
100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -54,7 +54,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, 
struct net_device *dev,
         u16 vlan_tci = 0;
         int rc;

-       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
+       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR) &&
+           !vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features),
+                                    vlan->vlan_proto)) {
                 unsigned int hlen = READ_ONCE(dev->hard_header_len) +
                                     READ_ONCE(dev->needed_headroom);


