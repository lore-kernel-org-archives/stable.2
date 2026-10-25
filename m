Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922790;
	b=gTY7VRU9wzM7eCrJIg5+8gtgaYWsG51dFaKw6aRlv0L44dOVJQoY1L1QP8vYxDwYMysE
	 ghKFXzJH5FskOKoii7p8ZfsOU6TAp+f8bpgsjCbKWwSYx+Mp2vU67BanBaSX7I/KNoR4l
	 nkRwGJYe+gQ9fWqNyymShdAcMx/hBH+1oUgco5W74P+1pZCtaBPWj92GHo0yChBGsEB69
	 q90AxJk2kOGcTAnuId6+1zU/+g+4Ln2lcfalGD143xsvNYrHBc0usQt9UlDUkuiDOooKA
	 bRmdOWA+30resbHSvq4gCsn7ACGuU6gwV6M4wG61sNRey61uGDjbcZywlS+OqqKIByw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922790;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=5souycdnBZ9IV2vplJ3bvYy32huqmL1ipFvgvvIj55U=;
	b=2B3X3/VokozVyJQPc7j/zbtuik80JJch/gM6sl+zGsh5UL9jZHHbJXbnC0PA9LtBUu+s
	 RGbSLHGqFp6DrDX6cg8MaF1sRiNpiO69VTnmuO1uxWz46X0tNW7fhWWo2pqEfl5IpHG0H
	 eUqN5mbhStcYfT17BX01hpdPqpA2mAHmJ40wMSap0AYfa20mFDx+Z8cVEVrvAVEZ6auxw
	 S/MW1p5gkW/tV/IfXJNW6fPQy89F3SnWu4SZoWPedHzGjWvVFXJyNLN4zTKqW8rBNNeGs
	 ATSGsNbMYMzP7mHdtIVFcKbJcmrmcVqKtfnVecwOkK3MMOVwdAxUKoJXegaD3hnk/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	arc=none smtp.remote-ip=188.68.63.166
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E48606A31D;
	Sun, 25 Oct 2026 10:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jCC895c6cz4MN9;
	Sun, 25 Oct 2026 11:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792922777;
	bh=3aQ12F0IFj9FckHCR7dd+o88DcnN4eUS2qsUv25bOyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eO63OWKdux1MfF7RYROATQ0e/h4rLj7u0P62fuI7gnfw2tNzLDI5AIpj8caHblLTZ
	 ZWMxC/AaAUOSIpMh2ngXekE5NmbjTyyxOrKLAv4CSzzCrl8bK1rpXiotAp+QlmcCwb
	 jPHtKZuyrGlL1hH7aCmncCdcE68D3ri3pZlwBvkQv7LUrZhsHFdAznjqap9h+Y9Rmy
	 rSWG7uLyn8WvsD3sz/Q+MlD7v29mX1F/R+IoiEdJkHgQBa13vI86bbv5GXYbwiMttA
	 mPIw3VtNsSfZTxnzDluV2RycoWoehK7toyNYhgejUrjvVXFYukJ61+kKTUTB4ODRR9
	 lXYiNn7sAHmOQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jCC894wLYz4Lhj;
	Sun, 25 Oct 2026 11:06:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jCC8857qXz8tkf;
	Sun, 25 Oct 2026 11:06:16 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D2E775F9FD;
	Sun, 25 Oct 2026 11:06:11 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <be2e5dc3-d41a-4277-b881-1591cc89d026@leemhuis.info>
Date: Sun, 25 Oct 2026 11:06:11 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mac80211_hwsim: CCMP frames dropped on fast-xmit
 (WARNING in ccmp_encrypt_skb, net/mac80211/wpa.c:462)
To: =?UTF-8?Q?Lo=C3=AFc_KASSEL?= <loic.kassel@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>,
 Rohan Dutta <quic_drohan@quicinc.com>, linux-wireless@vger.kernel.org,
 regressions@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
 stable@vger.kernel.org
References: 
 <CAAzpgGfrHpQZQ8iaH5fqZHzk5tTx39+jGvGkVXxhYFkp-A_bQg@mail.gmail.com>
 <CAAzpgGeAaOjPdiVOmeY7xZqEymyh4BfhESwAvTzczvqj+YuNHw@mail.gmail.com>
 <CAAzpgGddO8H3EVb-WhXEeiCeoV97NuV0G22UZcHmyi0QZLwcMg@mail.gmail.com>
 <c49badd916f72b505cce70ff68df6ab2e776654c.camel@sipsolutions.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <c49badd916f72b505cce70ff68df6ab2e776654c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179292277230.1432116.12511863575846824075@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D2E775F9FD
X-NC-CID: vYbI2wax3aYOA5cr5Bvjs9lD9Hkqen/7GW5ob5aWpm0NvVlY/lw=

On 10/23/26 20:10, Johannes Berg wrote:
> On Fri, 2026-10-23 at 20:08 +0200, Loïc KASSEL wrote:
>>
>> 6832075ed4ef has no Fixes: tag, so as far as I can tell it will not be
>> picked up for stable. The problem was introduced in 7.1 by a536be923191
>> ("wifi: mac80211: Fix AAD/Nonce computation for management frames with
>> MLO"), which made mac80211_hwsim encrypt CCMP/GCMP frames itself, so
>> 7.1, 7.2 and 7.3 are affected. Could it be considered for stable ?
> 
> It's hwsim only, I'm not considering that for stable at all.
Loïc: you could ask the stable team to pick this up for 7.3.y if it's
important for you (7.2 is soon EOL, so unlikely to be worth it); just
ensure it's obvious you tested it; if problems arise you might be asked
to fix them though, unless they happen in mainline, too.

https://docs.kernel.org/process/stable-kernel-rules.html

Ciao, Thorsten

