Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256753;
	b=Y7rCgmefFZvKlZCY4va7KME+xdfqju3ifzAU+gk5gcX1KgDu9bwpQuq1z7NcCkmtHIf5
	 Lrv599B+UJJbzB9ZiFLUYmxelJ6Y/72wfr2/8bUwp17RILdvud5bAAa3A4kDPx2BAmAeB
	 CmtSnlzmDZ9HR+C0MwADN5FMRt0Xcr8Y/xR9JKeoysvC8h+b02b3E8fnUOP/9Xs6EfLO0
	 zlRohEtdVvitCM8FxaMDB7D3Rv+xPP1MTyHGBKKDis+/sLv37h2rq8GI/YOuflTuOdBrY
	 otDdopDNBrm7S5ba4a7/qSOmBSdOv/uU7ZR0j7BwpDtHcm1xryOSCg/qkpTP4Wvgp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256753;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vcihILDAFgcDCuhSue5WNeTEF7sScUqqUKJXvqpr+l0=;
	b=t5LLKJlu9nLGbPNfADNbOwU0XSD0hNN4jo1mQbUG15AhQ3jbQNkA8tBEaJZLV2GWIrYq
	 j5/FuLYQeYBEdG/dZBmtVm42B3wu6h1lC9jWQOKQnWNfxMtlNwHZ+nh4/nn2KW3h9MSAG
	 TWGVzDdomMEGzhlQzOuw9CoLyfKIByuvXMQq/8UF0rA7P3KlVq8qaCtgpQHdoBr1K2nu2
	 cscubXbsxBpIHEZw3tHCsRY4UgOsX+z58haMMGM7e05nA6xQXFF30mZVAymOHdmi4KNKP
	 /vgMXcpaXSlu0mMO6od8L/hfE0AK/BXUiYEya7FdapU7TvHohyu/QYdUd3zgZ05HVzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.48
Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9281606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9281606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vcihILDAFgcDCuhSue5WNeTEF7sScUqqUKJXvqpr+l0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793256739; v=1; x=1793861539;
 b=R19KnPYsPw8jj2qkg7t/SdlQ13ULp2eovF41diFFKQbTOE0Sp7/3EhRa8Ix1SFur98mfHZ+S
 /gKYr2BMudxHm1i8HJn9beb9g5MCrXC+hCvBksteMuoP/R/ESPs2zt1aHmgjbfRDQSNLKPZmF+M
 c/nL75x7cU2eP0ThiS0WZfLM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63eb0333a2af5555;
	Thu, 29 Oct 2026 06:52:19 +0000
X-Mizu-Trace-ID: 63eb0333a2af5555
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ae8a59a-93a1-4b51-85a6-17ccc07eda11@linux.dev>
Date: Thu, 29 Oct 2026 14:52:08 +0800
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
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Ren Wei <n05ec@lzu.edu.cn>
References: <20261028160226.2170244-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/29/26 12:02 AM, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
>
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
>
> In that case the extra-data requirement becomes zero. A write queue
> with probe_size - 1 data bytes and a FIN satisfies the sequence-space
> check. The coalescing walk can pass the queue head to
> tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
> whose advertised payload exceeds the data in its fragments. Local
> delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
> fragment array. KASAN reports a slab-out-of-bounds read in
> can_map_frag().
>
> Cast reordering before incrementing it so the arithmetic handles the
> entire u32 metric range. For U32_MAX, the required size exceeds the
> 32-bit queue and window limits, so the existing checks skip the probe.
> The calculation is unchanged for all other reordering values.
>
> Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes")
> Cc: stable@vger.kernel.org
> Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
> Cc: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


