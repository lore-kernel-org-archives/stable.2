Received: from outbound.qs.icloud.com (qs-2006j-snip4-1.eps.apple.com [57.103.85.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B90280CD5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287805; cv=none; b=mUjpPUbSRvNRtSO93XUv3t2qSfDixurklawuffD1sb/GBYPGbajAHhnh7kAsGy8oZgFHJOQ6tbxcpSMEiBIAye7L+AuDAQiy9ic24X4ERKN+mdlmTKc0ZU+fCCgFeSU9B8GZS8Q4nFmpLH2QbTrVo1fWpYKcW50cZqjrQVLhf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287805; c=relaxed/simple;
	bh=4fudD0vOxzrnCktBE4g5RHnI71LNOCCNZ2Qw2QgQxNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5Vj/VjB5uINbT3JLHq7ZkzDnRuqoiI0MEQv8kBJ1ooWdFKy8MIkHOPTzy5LfcswN0bvMKe1l+Ypu1P8sAuF+MCMN+CL7St4viHbPRANnCCJMWdF04Cs7NYKVp1YFeEirB+VAKy0/UthPpHDWWq4iYVwD3stomUb5OkBWMsnrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lSVxuF5E; arc=none smtp.client-ip=57.103.85.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lSVxuF5E"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id 1A43A1800158;
	Wed, 29 Jul 2026 01:16:38 +0000 (UTC)
X-ICL-RepId: 019fab71-f0c8-7816-995f-0c055faccca0
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhLBkMGWAReC0wdVRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNBGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXABJCUkCWANcHEEASQpcGlkfA1cXRBpbClkVeRFQAVgeVl5aF15TFx9LAFxFWg5bBEcU
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785287802; x=1787879802; bh=MAV+pjFqmV8C9gydzsVNdKo/A/PlqMTODjNP8Zl6DkA=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=lSVxuF5ExFBZE7zWGJkVU+sO8sgLJfxqL8SW0MdJPzY5UBHSF7lnO9Z6zDYqPtr/ulRSL1un6eJlq1IT9uYORFWePKhg1hvSxuXHesik058C1esi3oJZDAJQy/OGeq9wH1B13lpA+Ksrug2vXeNpc5jceCT5DL5kuLnIFKQE1OQEdotDoYK2gZ8XirIBmCfzsDpe54QVjdUolWj5x/EUSoqpyO4jPC5QKjiargkigEbts+UcEX9zZOFHKx7S4/jgR756zIe/XJH5zHUQ5W8DWnAi4bOG6jZxenl6g1Fcfjbz0g9df0HRTETPN9c4UHejxutV+aYkP4CHbeaYRELcqQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id 54A9F18001C2;
	Wed, 29 Jul 2026 01:16:36 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: David Heidelberg <david@ixit.cz>
Cc: netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Wed, 29 Jul 2026 03:15:47 +0200
Message-ID: <20260729011547.19191-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729011547.19191-1-snowwlake@icloud.com>
References: <20260729011547.19191-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ItYTsb/g c=1 sm=1 tr=0 ts=6a695478
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=DIMQZ1PCNJLnr07J7f4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNyBTYWx0ZWRfX1VJwCvVUI0Pd
 gOFOOoNLEofycBPQ5ZcILqjmaYzlh+kei6+BZ2zrzVCztDdXmNgab4NOWTvBKDdgGCgKCSfHi2S
 wr/56f0nNQkWhgW5RSkV4ROoKkMug5KHMxzaZ3pMXsvHjIE2xOFkznP6rz87Ca64BE9JagT4/05
 eib0GbxqqTRGkEmufDQBdobJ9pmuhdKzXOFz2qDobp7WXvKUVE+NFcvK4r/e8toNypzJjWyH18k
 7kkxxOOY78EnWz/7RagQeWJpWkmq+rrtzJmFNAQvjEUhfLU2U0+V8PTO/BT9n6ShHM3q72A1JIB
 zGiJNHMdzqeEaQ388EIiRkMJC3vMpbU4jSmSNQM1ZSFfsy6x7r48mjgM1VQBB0=
X-Proofpoint-GUID: ilytXEujGz14jq_qY2mJqY6oEbU7JqgW
X-Proofpoint-ORIG-GUID: ilytXEujGz14jq_qY2mJqY6oEbU7JqgW

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
index cac1b5487064..e836201e441e 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1252,6 +1252,11 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
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

