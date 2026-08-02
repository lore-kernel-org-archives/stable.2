Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13B3C1D4B;
	Sun,  2 Aug 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685541; cv=none; b=Drp6l+vNZqVKdcETzgGwQAtoYFq4DwLbr5BM9BajWMAZmmAzMKYa2/+pFgF9KuFGh6tgRDKsxZ3wiTQCIQ/YBKLPqqxC3IA2qT3Iw7r/l3TA739G2frUgPMILT24tSETG4Rdz/AgU7pwufXs8t/loQILknBJboQTEApnmiMaHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685541; c=relaxed/simple;
	bh=QImCS+p0j340UNyEsPzkQBMHjKH8mVqEjJWG7cLcojA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZEofudrY+1ypQECVi0XCRKPZwaQOswqD0EakbsBC4muidE9PXhrRQXxwzxdHFaYq54qnhRZeqEhj7UNAKvBZwFbpqFgf+Av17Eko2IxdsbUz0O/Ib94onl168gwi6CB+VuNrR5q5JTr7zR9TSKMfq67B8IFXpsT+O9JIUFzmFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QaUZsMfa; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QaUZsMfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785685523; bh=Mj1YdxGS6daiJSi/4pE8tUp45dMG2WAhyhFG39wYrf4=;
	h=From:To:Cc:Subject:Date;
	b=QaUZsMfacPEp4dvfUAU1y8aR7M10nNs+gQpmBjHR6IsvvSWZebmVU67Q3rGVJKXNv
	 a9RyyEgzOnw269J5Coc5d6bBUEq1Hs8OsL6iF12Hqk4/nApikzwAYPBtGsE5bRwRz5
	 +d+io3dmN6aG+ftwuRNpsnhJC6mzbkKEddgT5XyI=
Received: from halo.lan ([240e:379:2238:cc00:262b:8ebc:c000:80a0])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id B452A86A; Sun, 02 Aug 2026 23:45:05 +0800
X-QQ-mid: xmsmtpt1785685505tjna8qgr7
Message-ID: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPNGqNQMWX1AUvsvgJ4N51RA4xQw9NkYD4ApFO7eLP7XFQzwxV9x
	 B3UQYBcflErhxRgivZ3oR8mN+4ykT8Rzdv5fHT12hU4eCPpFDV/j8JvFmcXsBUQiLiE6oFqRzdYm
	 YeAjzqMPUtX8QeIvpzW5EpO5HLq5nNkcEaDD3WoxlJYhVxO61qaKdr0Ucv6MvRI7898x+OoaitiY
	 VNVsuOp2zcvMSUNYJdU2hISJzNNrti/CHnbnD5rrt/bOuaKn9LmdrDy65bgwTyJaGDShxQhxSHTZ
	 hTupcrO2kR8wRmCpkbVHJ9JxlnMPT+56Q+dw6tPUhySiUERiqwkTZ1gB1ANbAf1q0cCEYyRzGkrK
	 xaHcP9mqmScrNGDfpjG9vfnyHjEntMDMRUW5XeyAiG53iiOngqxI08QnrVwmlcHFqDLNKkIa/sGN
	 Jp8d3CJMWXrNMnpb7Mnre1m/pTV7CVHtNLr83Q55wXQEnsgVBgF2yyNAnKHWugZL98lRBueqaIZz
	 YV1CxX9d2HaY7pyWKWFYilm8r/2Nl+wYSJrK6giABMhfuXXH1yW32GQvUMatgzCRmm8LVb2XM/9D
	 W8EWLL5bkVDKeP5dI8ks+ZyBn2DfMLHxIFOYd6KRB6cORUsnCgm+UkmcJUlvUUQZRhzZlRrhXjPa
	 DHmVmEAdU2IaD/uCDnnEHfa49Ye2ntEP/sMXL80y/PNhEE+LhoKROzESZqrXxMqY74dsV3N+/OTa
	 dKvqEQq+ijbqT0D0CZ7KUNfqxwxSbj3TY/JO/Fs9yDrcUAi2qaSDuJ5EyDkJj0iSY82ThHrt6Rvk
	 Xy8uJ6T6bj3cS2eGr8gFOlOx4Bk34PM9jBWC5NrmP/KNEpUq50MCE7NwCriIhuH9CsBzbU/nxvgm
	 xJQqtUkIQ7vwdF7p4oZOnFPWIf/IyWah0c8T+4tX/+vBe6x1c8GYjgtO3E4f1g3okqOvOWbEd4Yl
	 XW6xQnbojs6u+LhQkWBF2gb+iIIZEWDObAzBcQU2RMDIjB2B774deI4qrMt4WfxSM0iKsOgjXvmn
	 SbMu8+J9WTsNo8vrQ2kvSq7TdMg6qmBHelAxMsgejisdw6+5EgQ57puBkawNsuLLQC7PO4MPqzlG
	 Eccsa80wsq2U4sdWs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net 0/2] net: atlantic: fix two ring teardown leaks
Date: Sun,  2 Aug 2026 23:44:53 +0800
X-OQ-MSGID: <20260802154453.38032-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the two fixes from the page_pool conversion series [1],
resent against net as requested in the review of that series. The
page_pool conversion itself stays in net-next and is not part of this
posting; it depends on these fixes, but they stand on their own.

Both patches are unchanged from [1] apart from the collected
Reviewed-by tags, and each carries a Fixes tag and a Cc: stable with
the affected range (patch 1: v4.11+, patch 2: v5.2+). They apply and
were build- and runtime-tested independently of each other and of the
conversion.

Patch 1: aq_vec_deinit() drains the TX rings with a single
aq_ring_tx_clean() call, which is capped at AQ_CFG_TX_CLEAN_BUDGET
descriptors and stops at hw_head, frozen once the hardware and NAPI
have been stopped. Everything beyond that keeps its skb or xdp_frame
when the interface goes down and is lost when the buffer ring is
freed.

Patch 2: aq_ring_rx_deinit() only walks [sw_head, sw_tail). Since the
page reuse strategy was added, a cleaned RX buffer keeps its page for
reuse and refill is batched, so consumed but not yet reposted slots
accumulate in the [sw_tail, sw_head) gap and their pages and DMA
mappings are never released.

Reproduction logs for both leaks (as page_pool stalled shutdowns,
which is how they become visible) are in the notes of the respective
patches.

[1] https://lore.kernel.org/lkml/tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com/

Yangyu Chen (2):
  net: atlantic: free stranded TX buffers on ring deinit
  net: atlantic: free RX pages of consumed but not refilled buffers

 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 51 +++++++++++++++++--
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
 3 files changed, 49 insertions(+), 5 deletions(-)


base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.47.3

