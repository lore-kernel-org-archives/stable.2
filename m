Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366511;
	b=VLl8XqscjslklQomya3Vyb6AVBhUtxVaAc52RAQe7MAaac6nWo5gYiBC/PkL+1I7pyfk
	 pDLttsCV0MxttwafUL04Y8SiMw4IDoHDRmfdX4q5NcQY4OVCRu+dSkXjmWhgG86p67p/9
	 KXP+QsrA2VNMJLbQ8JMucED8GwXkw8eJIS2F4Zk8xVl4FPNibN8i1Fn3NazChPwvd0/ys
	 VHWjY719K4Wyg9f7WoSrMX8/xe8cie8N7R3s/Mv1lDsL19aa8IgY58jjF428B0im28KSO
	 UlwukEV/VrD4/YgRNEsxWads71AM2S28+FVHuxrbXjmNPeL/691KkOosylxj37tZkkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366511;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9ufpfF0exPuwxlva2WzizC+kysBLY6jXA9A/YWNdq9k=;
	b=iD9nEU0yk5BNpz3VPLoMxN2Vzc0kZfr4jwKCnfiueYqbx7xQ+Q34bRncOkCjFOu1iWxq
	 K3Fb6gn28D0ipZLKANrU65l2yubpP1QCNyF/L65SaoT0u3CnJ6qOl4NYsHsLtDlXtIJZj
	 /bmWzQv2OUrjJewaQYqXBFsumFrhVZrX0lyyFZuosDvYNBkwbFAuc9e07vS54yWkc78PF
	 JSEhYuLuyTjFx8d9jXaeouUAbiNfqFft/WLYZ+YwGNaKkXT2gIipQpdFOBtX8Kec7UxLV
	 RkEtKLgWCfX7f8ZpKIGYIPFAxQwsAB0awfuSx+AvGUG+jVyHho/q0k+7Q4pgGSDJPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gSQuO/tr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EF606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSQuO/tr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097821F000C1;
	Fri, 30 Oct 2026 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793366510;
	bh=9ufpfF0exPuwxlva2WzizC+kysBLY6jXA9A/YWNdq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSQuO/trg3l+oiPEmbmviJ4hktIms6TXfYTofD0fPUhYj5tHjrjZrJx0YFEkLUTuM
	 tZyjF3wIW/kJkJxBPbsfd2SjQZOAPnGxeXYo80N6ihuhO5KQYK2vaVlM8HN5Z4Bynx
	 JL9qD7pO8+pAzdTZyP3dE6qo6ueetktppS4JswCKvTRukmTsQlOobMlvpK3mI2IgbO
	 yf4D6OV0LbqQAbCWoefczxaZpNBrFuiQXC/MGi2vU71fWoKiDorXmxtglhhNyYhg8a
	 NvZD+yQoU4MSWVsBpqfw+Tg4cV3fcqPQZwaqmW4br30L5839XFuNhvprYqWK1BtRdV
	 jTpVTeIekbyvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zizhen Liu <pointerliu@126.com>,
	stable@kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: skbuff: propagate shared-frag marker in skb_zerocopy()
Date: Fri, 30 Oct 2026 09:21:48 -0400
Message-ID: <20261030132127.3663989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026103055-chastise-denial-90ef@gregkh>
References: <2026103055-chastise-denial-90ef@gregkh>
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

From: Zizhen Liu <pointerliu@126.com>

[ Upstream commit 79dc34beb1fdb3da79753e51e15c68591a2561fe ]

skb_zerocopy() moves frag descriptors from @from into @to and takes a
reference on each frag, but it does not copy skb_shinfo(from)->flags into
skb_shinfo(to)->flags.  A destination skb holding the same page-cache
backed frags as the source therefore reports skb_has_shared_frag() as
false.

That breaks the invariant relied on by later in-place writers.  ESP input
checks skb_has_shared_frag() before deciding whether an uncloned
nonlinear skb can skip skb_cow_data(); with the marker lost, an skb that
skb_zerocopy() built for nfnetlink_queue or for an openvswitch upcall is
decrypted in place, letting an unprivileged user write into the page
cache of a root-owned read-only file.

Propagate SKBFL_SHARED_FRAG when frag descriptors are copied, as done for
the other frag-transfer helpers.

Fixes: af2806f8f90a ("net: Export skb_zerocopy() to zerocopy from one skb to another")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Cc: stable@kernel.org
Signed-off-by: Zizhen Liu <pointerliu@126.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261022104217.1852191-1-pointerliu@126.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted context in skb_zerocopy() due to missing from->unreadable propagation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cdce2f72fbeaf..1808bed195af1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3883,6 +3883,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	skb_shinfo(to)->flags |= skb_shinfo(from)->flags & SKBFL_SHARED_FRAG;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy);
-- 
2.53.0

