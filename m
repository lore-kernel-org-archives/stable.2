Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814510;
	b=1pfH9gBeHEBSiHTF9SJ4FfN7TOIbbOgEppSRAt7dZzaU4oUf5S6t+v18+BJC3br1Dfx7
	 wXgl+cPejS5+IXqOIlOFUS8PPA1VXo3642fPHrTCPJAJOtFKu5N8ezU1CagEvytHcgoE1
	 D6SInQpfAV6svfhZGWM1Jdgi3EAGN+7FLWW4OouXcqvHOIx/xL9J/Vn9aJZsxP+1LORvi
	 Tr4W+rbgcjm38cz5f8zcVGooCZDT3FK6irtSuP1th2vb7lBK1J1dg0Al7dSgU/FjzVNHc
	 zQjRo+IDAm4rX4PVe20nK+5JUyMxb32iIcAaL0i5QgpIr8pr/zm8AfKbjTq2Gb6elXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814510;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wctQaa4+oug07SAylojzJ054zlJWMzb1RewZ5KzRtMM=;
	b=niojBkin54vIMAVLDp2p/xI76JX7M2pHChat0xsAtQTvV8ymyF8dAr9yGGS9vgqZjoUp
	 GARV2+DErQkAP5YTl2Tcp0jbMoVkvWA++E/2lgFr0tfZsjLzDvXUm80zcRHJWiLRl4xjf
	 5IqrFtHtxOnZd8D2TF7N0o4cKrvLHbZ+Gs2gL3a6Vb+htOhRu1eIwrGCF0lqJgEuqbXmS
	 ZP8Dc9IYsSrTktkgdJGOQ99gz/FJ7dMSmSStA2nDesJC2D82k+DJwq7JtAIhpzhsCc0X8
	 DusiWtbzE7/4bqAHAOFlMjL3eyeC6k352IVYmtCXJj7r/AYhRV/eWo29WkWVqW0hKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRXebOuc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04D606A31C;
	Fri, 27 Nov 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRXebOuc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C866E1F000C1;
	Fri, 27 Nov 2026 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795814510;
	bh=wctQaa4+oug07SAylojzJ054zlJWMzb1RewZ5KzRtMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hRXebOucKI08nPo50le2NMBN0BGP0AOzDoAaNNdAVq/25QRPg/rw23aHbEoViCREm
	 /NZCQ3uhllGjJK+ZRwnDUjC/ZtK9mMiih/hHP5rRAOzgkgmkhFg3T/EC5lVCo8Qo0W
	 pq630FIjzLNkW2UHfHSC6rFXS8cmRUtgYXJU5Yehn0kLMV7MuZjmpr78JT6ZHJvSDp
	 o0FXXLVX9qDdZ6neEI4fd/tDmEMuQ7NTkJb2D0BIxO56sKN8QZB0/ECB0C1+LRI8MC
	 zU5zv1o103+rmQt5IHgcE7paB8sUha2P4oLZiLf5h06eDI/pfATOxWHJGVgC2U3fvD
	 0OWuxDUgrGFiA==
Subject: Re: [PATCH net v2 1/4] net: skbuff: limit folio refcount when copying
 skb frag references
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, sdf.kernel@gmail.com, willemb@google.com, horms@kernel.org,
 akpm@linux-foundation.org, kas@kernel.org, songliubraving@fb.com,
 hannes@cmpxchg.org, riel@surriel.com, willy@infradead.org,
 ncardwell@google.com, kuniyu@google.com, pfalcato@suse.de, cel@kernel.org,
 jlayton@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 21:21:48 +0000
Message-ID: <179581450836.3135.326843222571201832@kernel.org>
In-Reply-To: <20261126-skb_refcount_overflow-v2-1-a6f600a5634a@kernel.org>
References: <20261126-skb_refcount_overflow-v2-1-a6f600a5634a@kernel.org>
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

- [Low] Concern: this commit converts only pskb_expand_head(),
  __pskb_copy_fclone(), skb_zerocopy() and pskb_carve_inside_*() to the…

--

net: skbuff: limit folio refcount when copying skb frag references

This commit adds skb_frag_try_ref() and skb_frags_try_ref(). Both take
frag page references with try_get_page(), so they refuse a new reference
when the folio refcount is at its limit. The commit converts
pskb_expand_head(), __pskb_copy_fclone(), skb_zerocopy() and
pskb_carve_inside_*() to these helpers, and those functions now fail when
a reference can't be taken.

> Let's introduce skb_frag_try_ref() and skb_frags_try_ref(), which use
> try_get_page(), and use them in pskb_expand_head(), __pskb_copy_fclone(),
> skb_zerocopy() and pskb_carve_inside_*(). All of these can already fail,
> and their callers handle that.

[Severity: Low]
This isn't a bug, but could the commit message mention the frag reference
sites that still use plain skb_frag_ref() at this point in the series?

In net/core/skbuff.c, these still take unchecked references:

skb_segment():
    skb_frag_ref(nskb, skb_shinfo(nskb)->nr_frags);

skb_try_coalesce():
    skb_frag_ref(from, i);

skb_shift():
    skb_frag_ref(tgt, to);

skb_split_no_header():
    skb_frag_ref(skb1, k);

Outside skbuff.c, the same applies to tcp_clone_payload() in
net/ipv4/tcp_output.c, and to iptfs_skb_add_frags() and
iptfs_consume_frags() in net/xfrm/xfrm_iptfs.c.

The next patch in the series, "net: skbuff: limit folio refcount when
rearranging skb frags", converts skb_segment(), skb_try_coalesce(),
skb_shift() and tcp_clone_payload().

That patch also explains why skb_split() is left unchanged. Each split
allocates a new skb that is charged to the socket, and the references are
dropped once the data is acked.

The cover letter (merge 25f5c92e1ac0) leaves IP-TFS reassembly out on
purpose, because it needs one new inner skb per additional reference.

Would a short note saying that the remaining callers are converted, or
skipped on purpose, in the follow-up patch be worth adding here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-skb_refcount_overflow-v2-0-a6f600a5634a%40kernel.org
