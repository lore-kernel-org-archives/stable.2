Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330767;
	b=Yr6xduoubP5eLRxVOOJ1m2GxgGNJtG1o0mMrZSfctBeVM/jCrZbMo8GcGYcYLgEwiNIc
	 hfKljp+Rhh5ahBbmFXLIFYQqGtNM1ctXhyQL/PFGFCcJuqrTmReGS0DNeaA3Gi5H0T9ei
	 KhmZPZTK1Nxco1QHIrOKH6yLe4QEVB1m0M30Qm7AxVSpfG57f6PVow1L8VR5l7Fff/m8C
	 QSjIGrUO0hAzOK6GhiSvKItlankyrp/vel0yv5XdZpwVY0DesC5KuHgILb99RbZPDAWOI
	 /lel1yiXwlkD3VD91gH27hP1cjotRmP1PpNJcLg7/uG88vpj9e6JPCjrDSldQra3rgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dbok5+LKtP0AVPkY0+AsNJyGkhE/WywiueaDIZIL2+g=;
	b=J/m2z3PrvSgqi+48lVxU9UHBQuVRaUSYEhN+dw5vLne55Rjd5L1Wzp83Ncy20GDUhecf
	 aI/vQRnHP9k09PTrOWZyprBWoWhSMOvg0xcve4wnhJB6MebqxtU97vjFSHI7l4uK7IfAm
	 He4Mq9OHKfrCiTKGrvJ5VTRUa+5XixEuLIPoWOwdSFn0j2OyrVhDNS2pdhVKVK1nK/z1F
	 c+jQOl5MfJfjs8AkBKlZEW1z6y44HziE1KOEVrMxpdm7q5YupLqsYvHYk9/FaKoMJnp5H
	 ViFoVEF291lA0Tkg8wCeObuj0OYUNVKcmoGOEQ/K+3o1xp7rRK/Ymf2vGNIenzLeNmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nsi/8y1j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58D606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsi/8y1j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D46B1F0089F;
	Tue, 10 Nov 2026 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330767;
	bh=Dbok5+LKtP0AVPkY0+AsNJyGkhE/WywiueaDIZIL2+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nsi/8y1jPEuszZ5U4+kNfuF5xa3RllDJ4lR3QVFKGR0uTauIVmP+a41ntvAh44nCT
	 rssRbHhHNpRs21k5MRihnsftSe/W7DsobAvl2r7vJSyo9+fbnSNaOiyNUzoQ6m0pLe
	 xh3LlOeANodbre2YR8BDU+0DoPXF5ggI0cDeU/BbxahBvOJUNn8kOUbfCiaKWhjp64
	 oNNOWsbU2/U6vEdxylPtBHE+WZw0I9By7WPnDf2chdnc2rvZHSzDa8UsaoswxtYGAn
	 f1H+h38VZKK997989AmzaMu+0c1fj57K7V94zKsyUAy4ZejsiRHe5Wc/AngDMXo5Lt
	 wCWdDoMtI+oYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
Date: Tue, 10 Nov 2026 12:12:41 -0500
Message-ID: <20261110171139.2520111-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171139.2520111-1-sashal@kernel.org>
References: <20261107060713-failed-5.15-56453199d28f@kernel.org>
 <20261110171139.2520111-1-sashal@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 56453199d28f0072a8196fba14b2d702632e2219 ]

skb_copy_and_csum_dev() copies everything up to the checksum start out
of the linear area, and BUG()s if the checksum start is past the end of
the linear area.  It misses the other direction: a CHECKSUM_PARTIAL skb
that has been pulled past its csum_start gives a negative offset, which
gets past the check and becomes a ~4GB copy.  It also trusts
csum_offset when it stores the folded checksum.  So far
skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
but once it returns instead, a bad csum_offset would write past the end
of the caller's buffer.

The function returns void and its callers are drivers copying a frame
into a bounce buffer just before handing it to the hardware.  There's
nothing for them to back out of, so check both ends of csum_start and
that the checksum field fits in the frame, and if not, copy the whole
frame with skb_copy_bits() without filling in the checksum, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.  The frame
goes out with a bad checksum and is dropped by the receiver.  If even
that copy fails, zero the buffer so the driver doesn't send stale bytes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable? The trailers only have Assisted-by: and Signed-off-by:. No
Link: https://patch.msgid.link/20261007-b4-skbuff-bug-on-v2-5-b9a5f732895b@toxicpanda.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Replaced unavailable DEBUG_NET_WARN_ON_ONCE(1) with WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_NET)). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a1aaed462645..5867fcac3f05b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3257,7 +3257,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
-	BUG_ON(csstart > skb_headlen(skb));
+	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     (skb->ip_summed == CHECKSUM_PARTIAL &&
+		      csstart + skb->csum_offset + sizeof(__sum16) >
+		      skb->len))) {
+		WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_NET));
+		/* Send the frame without the checksum filled in, or send
+		 * zeroes if we can't even copy it.
+		 */
+		if (skb_copy_bits(skb, 0, to, skb->len))
+			memset(to, 0, skb->len);
+		return;
+	}
 
 	skb_copy_from_linear_data(skb, to, csstart);
 
-- 
2.53.0

