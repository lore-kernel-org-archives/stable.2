Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846731;
	b=luDMci3aRng9i+qqrHkkxLq/tvmr8W5eUfI1KlEhZLhwgsm5wdxFrEoezlih7a6sWZVh
	 +7ISnEnSzhNJDm2Kn1DaBNjqRYrtDT+T7D/KQUO7IY7vt5lhG1VflAjTJStCvGLCGs+jM
	 wOJB+F+b19pf3H8BqgtVJM8leNQhI53iR5dzdle65sjsehNrhmJwodqlPpGXhvng7IcX6
	 oAc3s9vA8b4I6Uqu3J9SZUmJAT2QDM4I5c92QGXZ2b8vSU4DNkcgChMHmD8elLbJhkbAi
	 DdZE2omPjxSkE9Kb4rn4TvwjlsbjT72bnl3Q1JbuZJuP2f6ID5FpvrcfXCqoEAD6G3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846731;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=iLvTJCtYC83RMfQVto512FgaIcx5aJLsN+8MNc0ys8k=;
	b=kC7IJLz8ll88ixzU4jOfweiRUbcfh8IT4MihNn70qvwDtK4+rlI97zO06SCQidzdfNpm
	 dp67mu6VJxq1fpb1A98pvD7s4yb0jGw2k6EM2Bpr2c3ag2q5CcYsY29N62kjkExX9VeAP
	 /zz7NbjMiMDSsjxW84F98jL//26oZygz+WZVbeukxLnxRrXSm5DfLX783N8UeikEf3/2O
	 /z0V/wemr0MqBchulxTB8dh/dVI66PsuIj75ALV1J3LrZePAonIkzoePSqGiRHZKVE5IH
	 MHrpm5zzJ7+0k+ZtlkQAQddAG2KlzhcrN4R6mYPw4QroUzCYdCP4i3O3EEjcHzdE05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eyHJSWU3;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A3606A31C;
	Mon, 16 Nov 2026 16:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eyHJSWU3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iL
	vTJCtYC83RMfQVto512FgaIcx5aJLsN+8MNc0ys8k=; b=eyHJSWU3ehgF9umXuD
	kFZtl3Ghjkk9u2Vy78f5mrdINjylH6w2Ml435X1Vf24RAyOnnQI0Z9MSHfSVhEar
	5MJfSmCKx4DhTBpaHphdVD1FM2MtbE9msNMGcszsuEyYLjPr0CecGz5qqX7kgcuE
	63j/nK6RtmgyhQU3N4c7nryDM=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX_7zcL_tq2SpqHg--.31791S2;
	Tue, 17 Nov 2026 00:31:25 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qed: fix dead NULL check on the MPA buffer list
Date: Tue, 17 Nov 2026 00:31:24 +0800
Message-ID: <20261116163124.1684517-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179484607270.3136.35330548202236483@kernel.org>
References: <20261115161815.941090-1-zihengw03@163.com> <179484607270.3136.35330548202236483@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_7zcL_tq2SpqHg--.31791S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1UGr4DCw4DXFyrJFyrJFb_yoWDCrcE9r
	Z5Z397G3s0yan7tr17tr4ktrZFgw4kJr18Wr93KrW7ZryrtayrZa9akr9aya47C3ZxW3ZF
	yr93Wryrtr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8x-BtUUUUU==
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7h2c7Gr7L93sfwAA3z

On Mon, 16 Nov 2026 16:21:12 +0000, netdev-bot+sashiko@kernel.org wrote:
> rx_num_desc sizes both pools. Doesn't that make the "No free mpa buf"
> path unreachable, whatever the traffic or the value of rx_num_desc?

Yes, I agree. Every mpa_buf held on the pending list still owns an RX
buffer that has not been reposted, so a new completion can never find
mpa_buf_list empty. The "depends on traffic" sentence in the changelog
is wrong, and the only evidence was a test module that empties the
list by hand.

> If that path ever ran, it would repost the RX buffer and drop a TCP
> segment that firmware already sent to the unaligned MPA path.

Agreed as well, so making the error path reachable is not even an
obviously better behaviour than the current code.

> Is this an accurate description of fbb8bc408027?

No, it only touched qed_ooo.c. Sorry for the inaccurate description.

Please drop this patch. The Fixes: and stable tags do not fit, and I
don't think a hardening-only respin is worth it for an unreachable
path.

pw-bot: cr

