Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EA3C276E;
	Mon, 20 Jul 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579303; cv=none; b=SircykJEtyvIqDQqmyfR7i9QM/q26Yvn9vDKWbqNGABi05KDh7+Vb2Rl6dkk6IMKCX7KaaUCb03f8cWUNoDWDY8NE0vpu/yVkCgJDV0rVwh4IbdEheGI2V8NqJhQ4vvUhDZxLdeBJCvmUYsZIwB2gGUF1zTXzz27VExWt6sezbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579303; c=relaxed/simple;
	bh=gkKl3uTPSay0E7CpnnTKxHacM5gY3GAa8Yoylx8S2bI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uw7L5gADsg3xODel2YLO2BhoAEO1tSVKAl9DSPJ3pku20Cf++EffuTitNZw0cHZlslXyPx4NtccTJxtpb3704AFVxIjNnAOjC7QAyZFro0+ZLPKGNtJN+cAYJ4KZSqEjan1bg4vtPmEfQ2u00HD/sCHa1KhznEIVptewLJSY6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
Date: Mon, 20 Jul 2026 22:28:04 +0200
From: =?ISO-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
To: Matt Fleming <matt@readmodwrite.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
In-Reply-To: <20260720140545.461747-1-matt@readmodwrite.com>
References: <20260720140545.461747-1-matt@readmodwrite.com>
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <065FA849-C184-490F-B250-AD095219F5B5@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 July 2026 16=2E05=2E45 CEST, Matt Fleming <matt@readmodwrite=2Ecom> =
wrote:
>From: Matt Fleming <mfleming@cloudflare=2Ecom>
>
>A frag_list skb can reach veth with data_len set but nr_frags zero=2E
>veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
>locked, have frags[], or do not have enough headroom=2E It later uses
>skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
>xdp_frags_size=2E
>
>That exposes frag_list data to XDP as if it were stored in frags[], but
>frags[] is empty=2E AF_XDP copy mode can then trust the bogus XDP fragmen=
t
>metadata, walk an empty fragment entry, and crash in memcpy() from
>__xsk_rcv()=2E
>
>Route non-linear skbs through skb_pp_cow_data() before exposing them to
>XDP, and only advertise XDP frags when the resulting skb has frags[]=2E
>skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
>builds frags[] output with skb_add_rx_frag(), which is the
>representation XDP multi-buffer expects=2E
>
>Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept no=
n-linear skb")
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Matt Fleming <mfleming@cloudflare=2Ecom>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke=2Edk>
