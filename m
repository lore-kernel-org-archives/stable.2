Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339179;
	b=AZ5CmT1mupf4QKb6noDVm1xqL8bKG7zTlfedKcIWaJTLa36BxLjqg3SIff5JFYWcdIjz
	 PJf34pk0EpqqH6wLc9bJgOCPPd6mvNBV/j+8wJ9MldAKOnm/+bc15ytrzJADJXj/3aDKW
	 4D8dBgoPNli2abLcNHlxrbdA2dIjqwu1p8RETOkDt2OLWcjX9GCo6eG8fjOVVHS/5bEYm
	 9ZxhEMV/eu99/CYx1fQQS9ayWBA6/fPqW6Ubmx1e/4VgccVShgZNfs3qnEn1vaQ4Slm+B
	 Ia8680WXwUH7nC40yKMQ0vMNnZE4zn+fAdeD6ycF8A6t3zPoW7Iz8dKgtCZSM/ftdng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339179;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BLi6FJ3YBdze32J1P5e4SyztLeVBldzrE4m0g/yjef8=;
	b=CbfSebqlyc25SUp2gHXs/6yITZSpU7hkpLGcg9qpsKCIC2TWYdu6VQNcvJKOWl3d17T8
	 M/2AFpJDvRPFL8kL9UlvelaYkM4jysLcCswE2A21eMMixf6VqPYjB0Qd/T/x/NAzPAkvu
	 u9dUTXywS5o5v0tzKdWUDvd+AcGCJ2cBMpMSgRT7GvSU10kQ6nvnd4aXdI+U83apa6fGt
	 aC29nI4GFck68quvkPmkorE4+QfdPM+InJifZV+so+dbg6RwyEZp0NOrBM7A+7CIhjvo7
	 CcsFDeutlo6CMUxj9WIiwroPgijsIaeWYiJoJ/jVMI1//RjKnezOmku4XK3RJ7I57sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMz0e8MK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07126606A33C;
	Sun, 22 Nov 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMz0e8MK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A662A1F000C0;
	Sun, 22 Nov 2026 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339178;
	bh=BLi6FJ3YBdze32J1P5e4SyztLeVBldzrE4m0g/yjef8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EMz0e8MKeNv4rhcUPdw8SVX2ubd16Ms9Or8bDnmla+NICnuP9k8nsgLIN9WHn13RR
	 UdUwl4QgvKX8JrP+YE1sXfgoox3UAEwF7ihCJEhWGuz3MjFhEZZzHihiEX9sNTeINi
	 4fthJLsn/DTFai9w+s/NaR4Zs654C4eLHS7vW/8kTaUL/Nem9t7/FwhPbcYGCCrCYy
	 OZbBt1h5c4CfW76b+YAV+YTzxL2i+vJE+vrlhn0Lgci33sApB0Fa1UspuGJRPhtTod
	 zlQiDq62XWHwaS4YZ8VJqaJ2kUsdu2qwpbJ9M679nAsTk1+S280TEHX5QqUNtS3rZ0
	 x9BS7BLfwH9WQ==
Subject: Re: [PATCH net 2/4] net: skbuff: limit folio refcount when
 rearranging skb frags
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Sun, 22 Nov 2026 09:19:37 +0000
Message-ID: <179533917726.3135.13005025144396516237@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-2-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-2-5551b4954c3f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message explains why skb_split() keeps its
  unconditional skb_frag_ref() by saying that "each split also allocates…

--

net: skbuff: limit folio refcount when rearranging skb frags

This patch replaces unconditional skb_frag_ref() calls with
skb_frag_try_ref() and skb_frags_try_ref() in skb_segment(),
skb_try_coalesce(), skb_shift() and tcp_clone_payload(). The goal is to
stop skbs from multiplying folio references until the folio refcount limit
is exceeded. skb_split() is deliberately left alone.

> skb_split() can still add one reference when splitting a frag. But each
> split also allocates a new skb that is charged to the socket, reaching
> the refcount limit that way would require a lot of socket memory, and the
> references go away once the data was acked, so it's not that relevant in
> practice. Making skb_split() fail is more involved, so let's leave it alone
> for now.

[Severity: Low]
Is this reasoning true for all skb_split() callers?

Socket charging and dropping the references on ACK both describe the TCP
callers, tcp_fragment() and tso_fragment() in net/ipv4/tcp_output.c.

skb_split() also has a non-TCP caller in batadv_frag_create() in
net/batman-adv/fragmentation.c:

net/batman-adv/fragmentation.c:batadv_frag_create() {
    ...
	skb_fragment = dev_alloc_skb(ll_reserved + mtu + tailroom);
    ...
	skb_split(skb, skb_fragment, skb->len - fragment_size);
    ...
}

The fragment skb there comes from dev_alloc_skb(), so it is not charged to
any socket. The data is not acked either.

The path is batadv_frag_send_packet()->batadv_frag_create()->skb_split()->
skb_split_no_header(). skb_split_no_header() still calls
skb_frag_ref(skb1, k) unconditionally whenever the split point falls inside
a frag.

The KUnit tests in net/core/net_test.c also call skb_split() on skbs that
have no socket.

The conclusion probably still holds for batman-adv. A packet is limited to
BATADV_FRAG_MAX_FRAGMENTS fragments, and the fragments are transmitted and
freed. Only the stated reason is TCP-specific.

Could the commit message say that the socket memory argument covers only
the TCP callers, and mention why the batman-adv path is also bounded?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-skb_refcount_overflow-v1-0-5551b4954c3f%40kernel.org
