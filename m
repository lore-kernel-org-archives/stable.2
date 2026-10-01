Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E723BCED
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857197; cv=none; b=Ug42jD3Ssb+GfbgsOeytmytPkckAzBFKaxupNxQBALRpz1NowboqJgvAnYgiFsBELQS7EjdIReTz9pboh2jJAO6tPd7ZGI7ZP9jlNTXj9q9ayY4Df2xNq5JFynv2gowoSdAgyQ9qniPWNHWWGpqtuu3OImB7ltMUcRKic2d6wI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857197; c=relaxed/simple;
	bh=nRbfMwngHUKsiqlMccbHxJzWFiHdULg4qLygabHKz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmaCP2wxp3i+FddbZgdobC963KYtRKi5OFEOpxk3oaTNuQkvaflVr4Gv9pGNHsdtYJqsk3lmteSBXa1DPHp5hwEwdtm768jymH+kAmOd772NM3gWARPzCKP3mgLuTVXyWds3Mt9cBX/OpGg+Sn/R7YF5r5q1vDKdJkcO8sr8lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FssrDfft; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FssrDfft"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so876307f8f.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790857194; x=1791461994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqJs1lu9yYEnrWjWAn/NSnJmVPwl6cd9S/MSijAAG84=;
        b=FssrDfftmVycbPoCtmvGbdHXG4hyJu2I936FwJ47OhkXC2ycAYG9xb10wsp5Nukbde
         s9vbGWSId7hNsjJs09tbC433CZy94XpDmXJWJW+qm3nY+h+/b2OdxJNFtrvOKeHdaPrl
         3bekCkKDkUimH9GalBB4DzZnjEeC702R1LalEob7bgm0z3PhtxRpM4DRXsVoCrb4BRH1
         sQI3jMlOzuUnvMl9ni7uU2xGv8PmXPIc0XeMwNwAZveMgyWCViejB7kLMeBNjh23sV0W
         ztf7qkM4sFbAAJvGHc80S7GfqLa/f5FAmaJ+FHkgbgLhMGy3NHa1e+ePRfAXCibPRwvP
         XkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857194; x=1791461994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqJs1lu9yYEnrWjWAn/NSnJmVPwl6cd9S/MSijAAG84=;
        b=ErfDVoGciXt2wHcyvYeSLeZz0rtdayTClLRYLLNetM+SvAKRjlguhe8nBMTCD4zbVn
         oefD/vuuzmn96kW5ItelVPRAWl+36VToy7b3Kxg6IYFdfh5eduF1JEtmSq/HcymHu+m/
         cJbox2fKMhd/H8uUPJBr01Cr4a+ui6aa1n81hUNpS5gAl3VsW9vqtZ3jBCLCvcOYPVDS
         e3NIIqNBLBik1fGe78MJDdDod4mNurfybecCJGVgaw0B53sShTodCbQwyKLSuNXHF3vl
         5eF9RZ3yWfLVkiysZDZSaCzWSVeuewD2ueB6tF9xUHgltUj2l31wQAsMMq7jXlMxA0ft
         +J9w==
X-Forwarded-Encrypted: i=1; AKwUvBxgSoAd7aZGUGynlQopi6cNE7Iz0b7p7Kkst7iWRgZQGQqNWnQ5qs46RISVYdEApmOH7AkWjg4=@vger.kernel.org
X-Gm-Message-State: AFuF++k6gbuaw7UVFiSZaIl94j8UkQEDJvY7tNTjlX58uGlMlaO/72qV
	TV8XkaehWz83ft1LFT0zJ9R9fEjG0lHvuzEsdLGQzwyxbhc0efC8bYqD
X-Gm-Gg: AYBFou2QUXnH2xs1uVaBAwrbmPEoA10LpLOZ2QxKv0vjKJlGtWQoq+ORjjOaM1b/6Z9
	XSZuE6y6ibCexcYfpxLcrt4YHYk3FW4ozcKsYQ8ZPhvvEHuobx9KR/efMd3xSwF76CBLZbOFbZx
	OPuFrFHhlbYdppnj8RBxkzQWRDRGNRKKL3lRyAdUmhKmoPCxjyw/q7CamxJv2sgg5L7fUpb8s8q
	yerepQUW+erS0OrdnPPtyZLCHR7BNw8W/6peAHU8ofFN80k6O0WVl2aK9OGKvONfLpdVJp/7KV/
	y8w2qN1Vl8aCKDfOB5icI5fMJhiSOYsS3X/xNwWkDpU4XVmixZWLuDzNKlr9wdwlI+eOVd7ybYq
	nvmeIwR6fdJIjtX8y6YchsiaEBVC54UdAxZsipaimLoq3LxooQQkI5Y1tSzZYBUbl6ZyBlw02vM
	Owjz/brjwNdgAKRugKmwLy9V6dpOPP8FVGzUas9KnIFG3bWzXyf+YDQED68Yhz02RSY4As1j+3i
	a26AjKEuko7KfD/Y+N/XQLOROUZORQDZhzQxv9F6dwFoMW6
X-Received: by 2002:a05:600c:859c:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-4a01eaf5b37mr37503985e9.4.1790857193367;
        Thu, 01 Oct 2026 05:19:53 -0700 (PDT)
Received: from andreayoga.localdomain ([151.43.138.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f923320sm69506935e9.7.2026.10.01.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:19:52 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Thu,  1 Oct 2026 14:19:34 +0200
Message-ID: <20261001121941.31364-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179084999520.434549.4764913674478855382@kernel.org>
References: <20260928161830.351199-1-parri.andrea@gmail.com> <179084999520.434549.4764913674478855382@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 10:19:55AM +0000, netdev-bot+sashiko@kernel.org wrote:
> For an untagged packet this helper saves vlan_proto = 0. The consumer only
> ever sets a tag and never clears one:
[...]
> So would fragments 2..N reach br_nf_push_frag_xmit()->br_dev_queue_push_xmit()
> with their ingress 802.1Q/802.1ad tag still set, while the first fragment
> goes out untagged?

Yes. Conntrack defrag keeps the original fragments on frag_list for both
IPv6 and IPv4 here (ip_frag_coalesce_ok() is true only for local
delivery), each with its ingress tag, and br_handle_vlan() clears the
tag of the head skb only. On the fast path those skbs are sent as the
fragments.

I extended my reproducer with a port that is untagged in VLAN 10 and a
static FDB entry, so the packet is not cloned. With this patch applied,
6/9 IPv6 and 6/9 IPv4 fragments left that port with "vlan 10"; only the
first fragment of each packet was untagged. This is not introduced by
this patch, but it means the changelog claim was too broad.

v2 will add a second patch that clears the tag in br_nf_push_frag_xmit()
when none was saved, as nf_ct_bridge_frag_restore() does, and narrow the
changelog of this one to the fragments ip6_fragment() builds.

The BR_VLAN_TUNNEL case does not reach the refragmentation code:
br_handle_egress_vlan_tunnel() attaches a metadata dst, so
br_nf_dev_queue_xmit() drops the packet at the !skb_valid_dst() check.

> Also, the comment "Fragments may not inherit the MAC header or VLAN tag"
> does not seem accurate for reused frag_list skbs, which keep their own tag.

Agreed, v2 rewords it.

pw-bot: cr

Thanks,
  Andrea
