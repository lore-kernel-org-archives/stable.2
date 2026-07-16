Received: from outbound.ms.icloud.com (ms-2001c-snip4-11.eps.apple.com [57.103.73.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F13955CD
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234341; cv=none; b=m7swSegQ6PbeUpCKddxOOXGe0F/ywFZ6+vsCeegiTC3R7OITKIgBtD1MEpPpxEpI/mgtYzDHzc+jp2tqze3y9LFVVCcQfrTo8jNhYU4TrHehyKayJsCMTFIQqdN6zMk7FKtRmUwyueBAW333T1X5ZLy658N7sYX77q1zGXApoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234341; c=relaxed/simple;
	bh=2YpoC1w8MymEsGC3f2EZcl+ONyE/KISvMawo7ICTvC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhgWpIQPIdyc6hzk5HE28lS55C21/6BUvnrrNKOT69M0WB7K3+kr/P74nypdkWNenaELGbRC0ujbaK+cSsOqzrVjKtbrZi4y7WW4QSS89QN8FGEGwkJF0GBamAi6/cT6Zj315GNQ3ZP9VogQQJxaphM1n8mr4bEqc7Qwep4iS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q9Z3m1Qb; arc=none smtp.client-ip=57.103.73.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q9Z3m1Qb"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id BEA3F180011D;
	Thu, 16 Jul 2026 20:38:55 +0000 (UTC)
X-ICL-RepId: 019f6ca7-5df2-7834-a6ca-664ee7da700c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQBEF0kDXRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNCGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXANGC0gAWAdcHEcKSgtABEZBHlYPRAFWAFcwUBtfAkIPHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784234338; x=1786826338; bh=iNQl4aDXhtd+3bP/dWxWG09zS+iaWusBho5sejLPMD8=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Q9Z3m1QbMtr9SPY7htMAMO5BaHxXtZnbskhUgwyxO3syHM4OuZI2pmOsAJk7OK9Hc+KFWZzrBhLuXXlmWBGRu3QlF0GLuCmTi+pOH2Oy8OnTKcmKWSDbfMlz17/adonWRym1jnYdV7wVKob/6Y2E54UNiU8ecqeW8jQ2RMByBU6OwO9a4hTSScPugGCv1Zgx/+bMXginq4saJQTCEGXT4CfW5Z14Dif7fWi+7IQXTa6HOpKe2t/Agc1qnyaXRl2fqtzqc6GmbcvBC++UlPjoKtjd2+XjUc6oWWO4ksGopia+87Vu+ssajXXh1hJZbJZmBsMrr5gkdM9fz3kRWIUxow==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id E5EAA180026F;
	Thu, 16 Jul 2026 20:38:52 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	krzk@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5 2/3] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Thu, 16 Jul 2026 22:35:06 +0200
Message-ID: <20260716203507.7328-3-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260716203507.7328-1-snowwlake@icloud.com>
References: <20260716203507.7328-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX2VpzkD8xyBLi
 EB5cdnDchC0l4/0vWU0BgU0BYkE0QhI5K3bt69bS+Db+rlORNvHsperNF3WBwiPARXaNB3tV9vX
 qhsNKXGviGDnYeDG+BsiQXFKXopUx4Slbbvb6hhmpF2GsWHIekrnfxB243iKf3lILuKQXkHOzjz
 c02n7k1sqsfAltDZybiKgd0b5hQnK8M2RXVcSfAq6eRRwG57VbId14F5rza6j+sznFo93G32gfh
 dcY1rHTmkAtBOaaxbY8l9OeWQDbaex6ZjtZskbcOAtaWl1EiyAySwrmXNnO5dGagKFXWqWnpcAf
 i4cRvC5Y6q+alfycl9N
X-Proofpoint-GUID: tk1yGV0NFMV-I3jbj_E8ekG7X5Dw66MN
X-Proofpoint-ORIG-GUID: tk1yGV0NFMV-I3jbj_E8ekG7X5Dw66MN

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
first verifying that skb->len is at least LLCP_HEADER_SIZE + 1.  A DM
PDU carrying only the 2-byte LLCP header from a rogue peer therefore
triggers a 1-byte OOB read.

Add the minimum-length guard at function entry, matching the pattern
used by nfc_llcp_recv_snl() and nfc_llcp_recv_agf().

Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..edec2fd83f79 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1250,6 +1250,11 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct sock *sk;
 	u8 dsap, ssap, reason;
 
+	if (skb->len < LLCP_HEADER_SIZE + 1) {
+		pr_err("Malformed DM PDU\n");
+		return;
+	}
+
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
 	reason = skb->data[2];
-- 
2.51.0

