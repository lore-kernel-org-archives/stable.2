Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351703;
	b=5sIxTroAFGxls0xBlX92Ke3yfgJiBODcJJsjEBvC/CM1zEfd1rFBZFvsf9s50pAcMW2y
	 CqS45dt24kao6kObUI2R3DLsnqYzIAi2d+s3b/8Qfu8iLp/jY0dufWZWqf/Tp3cldpsuC
	 /M88xohoGHQIPexTDHsDZV2PbMXQ5qYutl4LCeMGKLLCiah8VrsrzMC7JBRSI5bdBny7G
	 KhUFQwK6G1pKNLma8j5kZQuLFh2D+XN4sOHsn1Qesrt09IU51InV3NIIK2pyR+iYF/Uo5
	 LId6oSVVyyI+zaJCz4g3D1/KcQZZrx/YBNCmttuqQmoqg/JQIqE5wHwFAuVrIRTiRxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351703;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WYWaYBNtufSJa/UG1/SFqHGRJnP7udoeOeCcl4gVeUc=;
	b=gCc52tBKu/d6eSP+rVVAH9f307h0jQO2kxVOlWHuEwhpuryNDhiQHxvAwMvkaph6cLjB
	 4YqH9HUI2AhepGcirWHY3lRyJGvGv+J97GKt57XQNqRL8nZXoAXJiY+ADiWV2kzHzSsy3
	 pHtGmCIedZuJi1Yd/H679iulBbYu6Deng/q6gCDYfrrOY/oGamuqBpzlV6x+DTJPwsA/h
	 upQvZZXhDX9oVcjkaidmV0G1chx/uQXS0VUFR9ldtHjFQhpTvf6Wm2CYeHVn5Op/k1ZSJ
	 6VFirUd5MXOxmjS+X8fyM8U4AQb8fiy1uTZH3NgkkeCruJxslUj5wpc5rNK4YgDv/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQY07Bxk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED7606A320;
	Sun, 22 Nov 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQY07Bxk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8601A1F000C0;
	Sun, 22 Nov 2026 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351702;
	bh=WYWaYBNtufSJa/UG1/SFqHGRJnP7udoeOeCcl4gVeUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GQY07Bxk97fqzjBwqZoIfonKj9WndWOr5euSKR55AAtV+p8SeMXk014AYRuBJz0ta
	 x60pIAz3ouR2QZVBdY1VjnItjkHn2UVlzI3dwQCe1GsDRL6nEKNW0Bhq0LR50i03Rt
	 SUSU/8Srh84td+seq39GDtLX+WosIH+pAEHo1MCtwuqd4pYzDBG/KiCa0rEoDCNsq8
	 Wacjew11ESU55kDUSNmkp86O7QJLmmbP3Byv4kYFsTnt407DZGHqAcBqzUJepOABJ8
	 blrEEUH+UPBufXFFiKZMWx0xoIPkVPYXGINISX19NIpYL2lUla6D+Q4p1C786WhWEd
	 /Ti5Vfkj3mv0w==
Message-ID: <7641a736-bf40-42c1-b169-9d21a8606638@kernel.org>
Date: Sun, 22 Nov 2026 13:48:15 +0100
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
Subject: Re: [PATCH net 2/4] net: skbuff: limit folio refcount when
 rearranging skb frags
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-2-5551b4954c3f@kernel.org>
 <179533917726.3135.13005025144396516237@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <179533917726.3135.13005025144396516237@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/26 10:19, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message explains why skb_split() keeps its
>   unconditional skb_frag_ref() by saying that "each split also allocates…
> 
> --
> 
> net: skbuff: limit folio refcount when rearranging skb frags
> 
> This patch replaces unconditional skb_frag_ref() calls with
> skb_frag_try_ref() and skb_frags_try_ref() in skb_segment(),
> skb_try_coalesce(), skb_shift() and tcp_clone_payload(). The goal is to
> stop skbs from multiplying folio references until the folio refcount limit
> is exceeded. skb_split() is deliberately left alone.
> 
>> skb_split() can still add one reference when splitting a frag. But each
>> split also allocates a new skb that is charged to the socket, reaching
>> the refcount limit that way would require a lot of socket memory, and the
>> references go away once the data was acked, so it's not that relevant in
>> practice. Making skb_split() fail is more involved, so let's leave it alone
>> for now.
> 
> [Severity: Low]
> Is this reasoning true for all skb_split() callers?
> 
> Socket charging and dropping the references on ACK both describe the TCP
> callers, tcp_fragment() and tso_fragment() in net/ipv4/tcp_output.c.
> 
> skb_split() also has a non-TCP caller in batadv_frag_create() in
> net/batman-adv/fragmentation.c:
> 
> net/batman-adv/fragmentation.c:batadv_frag_create() {
>     ...
> 	skb_fragment = dev_alloc_skb(ll_reserved + mtu + tailroom);
>     ...
> 	skb_split(skb, skb_fragment, skb->len - fragment_size);
>     ...
> }
> 
> The fragment skb there comes from dev_alloc_skb(), so it is not charged to
> any socket. The data is not acked either.
> 
> The path is batadv_frag_send_packet()->batadv_frag_create()->skb_split()->
> skb_split_no_header(). skb_split_no_header() still calls
> skb_frag_ref(skb1, k) unconditionally whenever the split point falls inside
> a frag.
> 
> The KUnit tests in net/core/net_test.c also call skb_split() on skbs that
> have no socket.
> 
> The conclusion probably still holds for batman-adv. A packet is limited to
> BATADV_FRAG_MAX_FRAGMENTS fragments, and the fragments are transmitted and
> freed. Only the stated reason is TCP-specific.
> 
> Could the commit message say that the socket memory argument covers only
> the TCP callers, and mention why the batman-adv path is also bounded?

I have no idea what AI is talking about and also I don't care. I have more
important things (on a Sunday!) than to do that think about such silly nitpicks.

What a waste of time.

-- 
Cheers,

David
