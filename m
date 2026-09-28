Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70A346ACE
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557727; cv=none; b=LphuLsYp6aINmFk3QAWHcR8g5YeQ8wQr0VojsaY1S5HejoTfQlUo3HZh5/nqXO2Tia5Aj+VCKcUc6xLMg/hzJskt+fPiJP7yBK7DLVIi8Xz/jAU9zRko5MNa9L8q+Bt+T2cMdtxErmTDYw8j3yNXmoQIIeV/7DoCTyyTd315ZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557727; c=relaxed/simple;
	bh=cCng7KpHB8XUHBobAWoNKxFVYmCnEd85zIsuvav0mls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6edXL0P5uViZqsNOMvO4Jy8f9AKnKe92mJilQgpkxn2gkyoGm1PMn7+Y+XHYCll9nT9rs+fg0ptrUWTl7Y4wJDZa6uWnrM1wOi6uz76lpa8fvBQyd7pvwA8N3iz1JeLHQMdre5ejuKo0ICp1ax/e5lPFEZfJtFHxethnd0Nad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wq89XQMr; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wq89XQMr"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cCng7KpHB8XUHBobAWoNKxFVYmCnEd85zIsuvav0mls=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790557723; v=1; x=1791162523;
 b=wq89XQMrfdXXbmDB0iTekAfCvB5yKfZ6PU/iWuwy4GByizw/lrhu/HiGq8ToAqspp6gTzFdk
 o6/ZhANhPO2LgBisry2VNJHrGmA5rHvtwy5tt6O3MZ7SnwbTqzTFukjiUeGofYcd1XctMpzrYq7
 HMGZcGk80UqH69xPS4NsR2cs=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id cda8e86f05856a5a;
	Mon, 28 Sep 2026 01:08:42 +0000
X-Mizu-Trace-ID: cda8e86f05856a5a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:08:37 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Hui Peng <benquike@gmail.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, leitao@debian.org
Subject: Re: [PATCH net v4] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-ID: <arm-FZQRDwkzas79@fedora>
References: <20260924093610.3286959-1-benquike@gmail.com>
 <20260924180016.f1a9947223549a9a88c9a2fe@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924180016.f1a9947223549a9a88c9a2fe@uniroma2.it>

Hi Andrea,
On Thu, Sep 24, 2026 at 06:00:16PM +0200, Andrea Mayer wrote:
> On Thu, 24 Sep 2026 09:36:10 +0000
> Hui Peng <benquike@gmail.com> wrote:
> 
> > In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> > .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> > maximum payload length and permits shorter payloads (e.g., 0 bytes).
> > When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> > kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> > triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> > skb->head memory, which is stored in sdata->tun_src and leaked back to
> > userspace via SEG6_CMD_GET_TUNSRC.
> > 
> > Switch SEG6_ATTR_DST in seg6_genl_policy to
> > NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> > validation rejects any attribute whose length is not exactly
> > sizeof(struct in6_addr) with -ERANGE.
> > 
> > Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> > Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> > by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> > succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> > uninitialized kernel heap memory; with this patch applied,
> > SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> > -ERANGE (-34) and tun_src remains zeroed.
> > 
> > Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > Reviewed-by: Hangbin Liu <hangbin.liu@linux.dev>
> > Reviewed-by: Breno Leitao <leitao@debian.org>
> > Assisted-by: LLM
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > ---
> > Changes in v4:
> > - Drop raw hex memory dump string from commit message as suggested by Breno
> >   Leitao.
> > - Add Reviewed-by tag from Breno Leitao.
> > 
> > Changes in v3:
> > - Add Reviewed-by tag from Andrea Mayer.
> > - Send as a fresh standalone thread (no In-Reply-To header) as requested by
> >   Jakub Kicinski.
> > 
> > Changes in v2:
> > - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
> >   sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
> >   NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
> >   length, as pointed out by Hangbin Liu.
> > 
> >  net/ipv6/seg6.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> The v2 was applied to netdev/net.git (main) as commit 2d959c75c27f
> ("ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST"):
> 
> https://git.kernel.org/netdev/net/c/2d959c75c27f90e9ec489d18ce5ee6b852ad4741
> 
> One general note for your future postings, not about this patch which is
> already applied: please do not repost a patch less than 24 hours after
> the previous posting. See the "Resending after review" section of
> Documentation/process/maintainer-netdev.rst:
> 
> https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

It looks like this is a bot sending the patches. It never replies to comments.
When you suggest changes, it just posts a new version directly. For that
reason, I've stopped reviewing its patches.

Thanks
Hangbin
