Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016220;
	b=Bzn0IsRn2X8+NH9bI0Hk1vDUd+d2jB7ck3PM+NcYu66ahgSBuHAEtMATsSo9yJXK0yVn
	 2/RASo8zLILNVL4Igoj093PxpZDFN0AM8zjuLqeKC7ENOyeDJmQwBQe25UCrdp0yxmY9g
	 f/Ve6vS02JpC2topGDu/kYvtzbHUd/FZaEIssvWVRkPQMFLHPYo4x+x0bchoP8XBhyaYK
	 uDi3EwqFkzlFw1VKkDGKx2VxvpWzuft7ODRFkfbahK44UMEBG8SbQrmxU1b0iCbm0yXok
	 p+t073Elc8/DhaIL4YyetCPtrZNbdhyoCqTAXXWpjShaZRTGzm5YbLYn7ghNtdY5ltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016220;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=RgWtSxLmAhtYhLG2BvNwj3rhsazutaU7Zjd615Xs2tU=;
	b=Lv0VcbMAXNolJGttkWGIQZTvYCUCACSOpVYIVXlGUjqQHSYH1mGdaSCwjwwTfTbss5Sd
	 t5/Pq4J4dvBgtujxF6/yXI2Oe5UjOQc5+9s061T147MqAvG8ojs7UxQTMtUvjU6bD2Qz8
	 K+0qLsF34Lw+fvWsEgEcAlL4j7renoF1v5eUtKz8LUWmQEQmJVi1dWhFa8H74QbByt2Pq
	 SJCB/JopzGKiey0tO4BKCMRssLkDX0bG/UdYgAWyOLdOxQIVC/b8YoD0j+Henr14fhAa7
	 Zk7KH8UTIk7I6C78g5gb7/CvRAYOTBTGljw+xYxOjcvaLdv3f+rbfA50u4E1fQqud3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="Y0E/Bo1F";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7E606A320;
	Wed, 18 Nov 2026 15:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF7E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Y0E/Bo1F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RgWtSxLmAhtYhLG2BvNwj3rhsazutaU7Zjd615Xs2tU=; b=Y0E/Bo1FwWCrAQ8ELPOv3Z76JB
	mYA/1ubdl0gmNA6CdqfKAG3CJdLN2G6EObpOZUST+sEc0LBPzw1lyyg+zIdqd6QxNKEQ3MuFm5DMS
	4REYs2mXLcLS0nviJSb70VKrebdOdg/nhvYGaDdrRzqgWXJD0Zq/HRrn5MymtUJ1NvLoqpxbCAaab
	4TNEAuH069jyZrewelGQoAFMpCsE0mFuv7HIXRUgCIEVjapT392zOD0ndmydGDpMozEvsepjgIlvd
	ZLcE2LCLQUEw2afJM1dsHhhSA+KLWIXCu4Z6vMdEuGf3GdLh/ICbQuWW62feoU5yqRnCqOjIpMdZ+
	S4E5K2gA==;
Received: from [::1] (port=57880 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xThiQ-0000000EZro-0eDB;
	Wed, 18 Nov 2026 16:36:51 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 16:36:50 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
In-Reply-To: <20261118153221.GG860048@horms.kernel.org>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179478310543.3136.4977357785981182737@kernel.org>
 <20261118153221.GG860048@horms.kernel.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <1d7deb845ffc57994cfc86c317d9958d@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-18 16:32, Simon Horman wrote:
> On Sun, Nov 15, 2026 at 10:51:45PM +0000, netdev-bot+sashiko@kernel.org 
> wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential
>> issue(s) to consider.
>> 
>> Critical: 0 · High: 1 · Medium: 2 · Low: 1
>> 
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply
>> (one such reply per series is enough).
>> 
>> - [High] The fix still lets receive and completion use different 
>> tunnel
>>   parsers on the same packet, so the out-of-bounds write the commit…
>> - [Medium] udp_tunnel_gro_count only describes how the head skb of a 
>> GRO
>>   entry was parsed, not the packets merged into it, so packets in the…
>> - [Medium] The Fixes: tag blames only 5d7f5b2f6b93 ("udp_tunnel: use
>>   static call for GRO hooks when possible", v6.16), but part of what 
>> the…
>> - [Low] The new synchronize_net() in udp_tunnel_update_gro_rcv()
>>   (net/ipv4/udp_offload.c:139) runs with the global…
>> 
> 
> Hi Jérémy,
> 
> I would appreciate it if you could provide feedback on
> the concerns raised in this AI-generated review.

Hello,

I intend to do this at some point, but I have been busy with other
non kernel things recently. I hope to get back to this at some point 
when
I find time.

Regards,
Jérémy
