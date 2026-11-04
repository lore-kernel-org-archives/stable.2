Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793115;
	b=enxbi93Ex4nBkU6fZG6KTDidqiSTNs4pjYNLJtpOZfTfSKrZLoAR8r2tWc1Qz/+ZI6uh
	 K6IJGYycDkbFtXDTZe8N22rg7GvDaNs6tUCLrx5VAniPOh1DVL6To8XGsRM3gfzW68d8T
	 12yRBftfhnLRTDe0EG99GJ3rRAYy8fqRvZRkE9lk6Y2kG1VeL7v/9VX64azbBtB1mh6TV
	 v6+vbMWViciwBePYBd7W2NQYmWKddsM4nK7zgOPilWOa2ha2E9UQBvDRYIyJDLHAkbrfD
	 ppiGTWxpA8fBxhcSa2PqN/uNpof+De1fLyiVsm4RWJQZnFR25VlyAECpkjNffveTNJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793115;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=zsg/Tuw5ykLr85sjQ3oygFcc3TuJZtx8QYCDP8TXqFI=;
	b=i6DdsJyq7oQZ20J+2ZjCya5A90h8Rh1ZkdLrfdvr82Ir5XoD42Q369OZwga27az/LZeJ
	 Dpk5fWiZf5j/lKLlqLjmgE8A8bKxi73cGpAIt+Zg1Dfa/NDgQopKvAv/S1gsdo730PMh4
	 tCdmX7HA2sgwX4Qi/zieoDI465tkGtB6MPPE0E8yCH1B81dkCcP6R5FwGD0rgD0JlFe4V
	 cQWAsY5Aa+KdM5nT6otYMwrQtmekhVHixBALYza/UANi+jZZH2kWgGGj5VWh7warAHLJQ
	 v5B02BDi8qDiRz+bA9YXhKvOlOAiMVFlzm7axEq/qTtWoQOYYuoFmkFCmyEp2OJjnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAC606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BAC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0BAFD60218; Wed, 04 Nov 2026 12:51:51 +0100 (CET)
Date: Wed, 4 Nov 2026 12:51:49 +0100
From: Florian Westphal <fw@strlen.de>
To: stable@vger.kernel.org
Cc: Sam Dlinn <sledge@meta.com>, edumazet@kernel.org, pablo@netfilter.org
Subject: [6.18.y request] netfilter: restrict payload mangling
Message-ID: <auscVa1zQMqoTxhq@strlen.de>
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

Hi Sasha, Greg,

Could you please pick up following commits for 6.18.x kernel?

Sam Dlinn reports just another heap OOB + container escape.
Root cause is that many parts of network stack rely on network/transport
headers not changing after their validation.

One way to alter them post-validation is via netfilter: userspace
queueing and payload rewrite via nf_tables.

These patches:
1. Disable nfqueue and nft payload rewrites in user namespaces
2. Restrict rewrites to header fields deemed safe, e.g.
stateless NAT / ip address rewrites are still possible in normal
network namespaces.

None of these patches had Cc stable because they intentionally
break existing features.

I checked:

1. they apply cleanly in this order to 6.18.x stable
2. netfilter kselftests still pass
3. nftables.git shell tests pass (minus one unrelated error that
   is also there without them).

968cc2c96390 ("netfilter: disable payload mangling in userns")
3744b0964d52 ("ipv6: Implement limits on extension header parsing") [1]
54f34607d184 ("netfilter: nfnetlink_queue: restrict writes to network header")
3785091c6c16 ("netfilter: nft_meta: add double-tagged vlan and pppoe support") [2]
df07998dfd40 ("netfilter: nftables: restrict linklayer and network header writes")
c3716a3c4346 ("netfilter: nftables: restrict checkum update offset")
112e447d17f7 ("netfilter: validate L4 headers after userspace packet writes")
c2226f0c7fe9 ("netfilter: nft_payload: restrict checksum offsets to known values")
63bac0278603 ("netfilter: nf_tables: fix netdev hook allocation memleak with dormant tables") [3]

[1] Is a dependency, it adds the IP6_MAX_EXT_HDRS_CNT define used
    in 'netfilter: nfnetlink_queue: restrict writes to network header'.

[2] Is a dependency, it adds the 'ethertype' field used in the patch
    coming afterwards.  If you don't like that, I can try to mangle
    the 'linklayer and network header writes' patch to use
    skb->protocol instead.

[3] is unrelated, while running the nftables tests kmemleak reported
    a splat that is fixed by that patch.
