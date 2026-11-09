Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241223;
	b=2dV1llkamhKxOcz+zvobGscR/uw8Pmysvv/WPhCVN4CVwQCTMWRGKm8JDQTOo1k8i0vT
	 7WxyI4MOVr2t6mEHhZlXJuSSYz7kuHwKBJyVkX1aBOKU9Lv19gNna/P4sjAtnApUU9XMe
	 Ynve/SXysM7X5zwT6jjR6cqCvAy/vzICy0sQCydY3Olth6FT5WP7UKYHWkFEHSSv4RKZA
	 cDLu7F9db2XrXB9w7kMN/5sCWXRS1o/AQTSJ4tJKTeYXNpvkCa1vIPKA17J7juQx/FE5M
	 pMCXXPY3/HcY4esG8wJQkUbVoWrJzY3iB3YQbC7uT9VIGQjAv+Zl8lfVJqyzuyRU5Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lEhO3zAePXatssuxw4iweIsDZBb7ewU1Gz6USVWcZ8k=;
	b=NLd3du+NzvNyiF0B+VjMAlwEtCV2xRNrxy3dWn076k3QWhz2WBQeRdU8W4oZY+mRnvIx
	 K8i+HioOJgd5nvtP8hhrdTJ2Mici6ylHet5lNG23jQ0HiiWe3muGpf+2WdRv2PNyhMIZJ
	 +XKG0f4sxFVs+D9xtJguE4rEj7dkke1aQo0HaRjqBluPUCYyBrcdWv54+xjWYNNvaVycB
	 X/f1XJxwlFe8B1eRxgCV7Xj0OGK4b3+pNnq9dmykFTjfhOYVdGMhcz7LBJd5Ljei9GxxZ
	 a9X7/LScXGXkimSXha6wk+Y+QYk4uxjLZzO/Rpo5wYTp6GvhjJNotxUWm7Tm6+ksKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQB92kCB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD7606A331;
	Mon,  9 Nov 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQB92kCB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5521F0089F;
	Mon,  9 Nov 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241222;
	bh=lEhO3zAePXatssuxw4iweIsDZBb7ewU1Gz6USVWcZ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQB92kCBXaxQfnGHPbMj1/jB72ewt8hGecEvv/jIniE1JV/h8zbfwQQKkRS6kI5lX
	 nvu9+KwGBm9MTJbEtuhgbBpsgJOKHMp4tz7DXOAhTkz5ZSEHubNAlE6GI+Tb9UHHGZ
	 /sLooxpIExxaO9e98PNO854bTdlyYpobJ5V3oytf3S7xWKNnYTljqq94xv2nC4n/by
	 awdLDWn/jsgEGzuBgUSiWj9YATEFf/OujGDh+K03hY/QyB+dXOZBT1OPRp3y8qe2rS
	 gTSHTAOtIOoorz8sM880ohzTse83lxVvrAUuatYzngZtIUPMRAp/UWLxGfKnMB/VWQ
	 C8DpP/6xt2cGw==
Date: Mon, 9 Nov 2026 16:20:18 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: Re: [PATCH net v3 1/4] net/sched: act_ife: encode configured zero
 metadata values
Message-ID: <20261109162018.GM18859@horms.kernel.org>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
 <SER-NSBD.v3.r0.20261103064310-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SER-NSBD.v3.r0.20261103064310-1@mojatatu.com>

On Tue, Nov 03, 2026 at 06:50:29AM -0500, Jamal Hadi Salim wrote:
> Reported by shaos <shawnq1@163.com> with a reproducer for the 32-bit
> case, which was reproduced and verified in our test environment.
> 
> The issue:
> ife_check_meta_u32() and ife_check_meta_u16() both reserve eight bytes
> of metadata for a configured value even when that value is zero, but the
> matching encoder returns without calling ife_tlv_meta_encode(). The
> encoder therefore writes neither the TLV header nor its value, while the
> enclosing IFE length still includes the reserved bytes, exposing stale
> skb headroom contents to the peer.
> 
> The 32-bit helper has been present since the IFE action was introduced
> (v4.6); the 16-bit helper was added with the 16-bit metadata helpers used
> by the skbtcindex callback (v4.9). Both defects predate the oldest
> supported stable kernel (5.10), so they are fixed together in this patch.
> Each hunk keeps its own Fixes: tag for provenance.
> 
> The fix:
> Encode any configured value, including zero; skip the TLV only when
> there is neither a configured nor a runtime value. The runtime fallback
> is unchanged.
> 
> A raw TCA_IFE_METALST netlink request is needed to express the
> configured zero: the IFE_META_SKBMARK attribute carries four zero
> payload bytes for the u32 helper, and IFE_META_TCINDEX two zero payload
> bytes for the 16-bit helper (not an absent or zero-length attribute).
> Stock tc cannot build these requests; "use mark 0x0" emits no mark
> attribute and "allow mark" emits a zero-length one.
> 
> Conditions to recreate the bug:
> CONFIG_NET_ACT_IFE=y, CONFIG_NET_IFE_SKBMARK=y,
> CONFIG_NET_IFE_SKBTCINDEX=y, CONFIG_NET_CLS_MATCHALL=y,
> CONFIG_NET_SCH_INGRESS=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y,
> CONFIG_VETH=y. In a fresh user and network namespace create a veth pair
> and attach clsact to the egress side. Install a matchall filter whose
> ife encode action carries a zero skb mark (or a zero tcindex) in
> TCA_IFE_METALST. Send a frame through the veth and inspect the IFE
> metadata in the received frame. The metadata region is eight bytes but
> holds neither a valid TLV header nor a value; it exposes prior headroom
> contents. Setting the value to a nonzero one does not trigger the leak.
> The namespace needs CAP_NET_ADMIN; no additional privilege is required.
> With the fix the zero TLVs are 0001000800000000 (u32) and
> 0005000600000000 (u16).
> 
> Fixes: ef6980b6becb ("introduce IFE action")
> Fixes: 6a5d58b67e20 ("net sched ife action: add 16 bit helpers")
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/netdev/20261022144739.61342-1-shawnq1@163.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

