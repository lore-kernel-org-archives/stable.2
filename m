Received: from outbound.ms.icloud.com (ms-2002f-snip4-11.eps.apple.com [57.103.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2079395276
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234343; cv=none; b=RgXSWCuRTWeszWRV5JLjriCJMHyU2dh/KbZVBA3ZT0eQmFXuMLU4uyGKL8ZNZrj+B/UJm5bw+OU+k52Udq8iGNZj2uJXVjPD4zXlm/DSoo0X1rE6z4HRyGUicRXUh8l2nj0sClfEnsRgjH12xbP7pBO09n0aT7ZprT0fZlF93ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234343; c=relaxed/simple;
	bh=ZXMj7j4SvtIlooZw6oHTX4T2Cfd9sibX4rMOUWsya6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW9mzAp2zgfWsrI+mu9IY+2HmoAfIr5uK8q28nKP5EDv8MkngYEXCuRCpjohn/6rKjnvqJIR5zoLmXO7bbRot+RQX0RPst5pXys1ORqwPqhikfgfARlQZmueZVjoeWjtpq9kFWeOylA8/mca/eGyOMC5K00tLa2B8W5pNSruZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LA00K0kC; arc=none smtp.client-ip=57.103.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LA00K0kC"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 8274918000A3;
	Thu, 16 Jul 2026 20:38:59 +0000 (UTC)
X-ICL-RepId: 019f6ca7-6ca6-789f-a1a7-2cc13234eca1
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQBEF0kDXRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNCGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXANGC0gAWAdcHEcKSgtAA0ZBHlYPRAFWAFcwUBtfAkIPHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784234341; x=1786826341; bh=8OvF2t9Knv6wVrLJXD0bfcxWgVoFxiuNJpZwphKMgxk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=LA00K0kCZZU3j7s7oXN9SqSHqRsbGnESO8mU63WkUzZaoiAMIlzEteuh9WkYnreCHuYO/5na9CoavgTE51OMHnDez0MZ+vGW0KrDO8DE6igiP3IguVm6dWjPjiSvcOW6pBbRBD4WXlz0dTpMg1SLSe0AwxhsIXV81rYWU2DKoiVFPy+uZFKeInjo01Mo5p4HFtM75W0VOJ8Js9GFtJdP8nKuQdCl8+wXC9Jk3361M4dC1a2tcXB0yYlc4hbmHMQKnxl0w/eQLdwiffPrjH1rvmBwGRBkFX6vHiTu4zqooG7JlFadRTOwl1C2rrYoHv4ReIBcJVagcEC3gANgXe8rug==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id C45711800119;
	Thu, 16 Jul 2026 20:38:56 +0000 (UTC)
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
Subject: [PATCH net v5 3/3] nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn
Date: Thu, 16 Jul 2026 22:35:07 +0200
Message-ID: <20260716203507.7328-4-snowwlake@icloud.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX7T+Q3WICJ8V6
 4XRoFM3eVJLn/uagEU399T5uEyNkhcRK9hsAq8AnE9tZFaE3+TVnk1TjKRvCYNJ+5uwaMrdVMJ3
 5RpK5jqAOu+xNmmOuGt/FUVsmKu+/RYg2wMypRkO9QV1vM4oo2L3j+8mHH+bg3lk7WBVENBT675
 J8V/vzCey9SuESHr0C9nwik3VdOH8ezkNQBxD+FbUqAB0ysJJ0jgAF6/+lU0JKMjk08jgpMS9+8
 wLI8OqiW+juUSvfD0cLw6Ik7RJ2oMGMpL5MNmMKDc9SAOxelxi8Xn3humvm5rEOPr52prDAv8Y9
 967Aw8/2OY9GcmuNiqI
X-Proofpoint-ORIG-GUID: eBNGzKzhwQtf2IeBD0CHpOj0Qd_wqYC4
X-Proofpoint-GUID: eBNGzKzhwQtf2IeBD0CHpOj0Qd_wqYC4

nfc_llcp_connect_sn() walks the TLV array of an LLCP CONNECT PDU
looking for the Service Name TLV, but shares the same class of bugs
as nfc_llcp_recv_snl() / nfc_llcp_parse_gb_tlv():

 1. tlv_array_len = skb->len - LLCP_HEADER_SIZE wraps when skb->len
    is 0 or 1.  The subsequent loop then runs far past the buffer.

 2. The per-iteration guard `offset < tlv_array_len` only proves one
    byte is available, but the body reads both tlv[0] (type) and
    tlv[1] (length).

 3. The peer-supplied `length` field is used to advance `tlv` without
    being checked against the remaining array space, so a crafted
    length walks `tlv` past the buffer.  On the following iteration
    tlv[0]/tlv[1] are read from adjacent memory.

 4. When an LLCP_TLV_SN is found, the function returns &tlv[2] with
    *sn_len = length but without verifying that `length` bytes at
    tlv[2..] are still inside the TLV array.  The caller in
    nfc_llcp_recv_connect() then uses this (pointer, length) pair as
    a service name, so it may read past the PDU.

Fix: reject frames smaller than LLCP_HEADER_SIZE up front; add TLV
header and TLV value guards at the top of each iteration.  The value
guard also ensures that the (&tlv[2], length) pair returned on
LLCP_TLV_SN lies fully inside the TLV array.

Also use LLCP_HEADER_SIZE instead of the magic literal `2` to match
the style of neighbouring LLCP receive paths.

Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20260417160438.GH31784@horms.kernel.org/
Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index edec2fd83f79..c4dda8e7cfcf 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -849,12 +849,22 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv;
+	size_t tlv_array_len, offset = 0;
+
+	if (skb->len < LLCP_HEADER_SIZE)
+		return NULL;
+
+	tlv = &skb->data[LLCP_HEADER_SIZE];
+	tlv_array_len = skb->len - LLCP_HEADER_SIZE;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			break;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			break;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
-- 
2.51.0

