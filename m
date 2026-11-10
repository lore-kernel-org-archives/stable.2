Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331588;
	b=NnIgWKt9aiukEUS0v5fws2IO726sFadwzfAh5R8D5xksfQ0hKJgfsuY+OX1CWuKzu8xo
	 U5mYKvgBZP6ylwITMC7J1p3XjUpSVPe4+Io7k6iltcoP11+IzlngT1Ut7ivsktgv+S+1G
	 7k7wzdvehK3veAySxccpkezYcmz6pvzZcIv+0qcyyRtZW3uLc0hcGUu4vH48APINTzn/k
	 heA0QIV7S3QUyqB7QGjouPFz25GtrM0fo11a9UksGfg+QUUNzoe8MKTJmsCzRhe244Smq
	 /NkZiWlnj0KZvbG1NzytymEwL8TnRi50GRGqFIio6TqvhsREShOCONIyzWzK+O/oBQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GXjgNNX+v8W7SSL6EObie3si22fGdNCC4Fq9X3e5m9Q=;
	b=LGyXQK8DXtlsel1bBMJzfT8TlbpK4rtNd5UEQns1JnaLmI+eewszWqXlU0B+p3s2szIt
	 brlMowaHQOtF6MjDfWD3eX+o32Lv8TL2vXx2c72l5KDDUe4N6b0J7jorjuiPWuVSGnEb4
	 b7oCM50s40DqzQeHX0Qj+DNeVBxGnfiJa41BiXEU6kOfkfF1f79CBljSkWzVaoe1VRDp5
	 7UXMLSZAOvWB77Z00enbWHR42hwyPzlZiotJ9DJ2rrJEMdl1vZAbhSLruT81khgI+Qabk
	 gGGPCK1g1nW2oxrS5rSXg03MwNKBiIMrFZ4yMf5r4LcQASl/dMGHWMRm+Zhm5DFNFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUp1QM3c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92C606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUp1QM3c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9801F0089F;
	Tue, 10 Nov 2026 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331587;
	bh=GXjgNNX+v8W7SSL6EObie3si22fGdNCC4Fq9X3e5m9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUp1QM3c/qmksmFIulBGKs3tXOqwTOwucaccdp6spWeJIu3fH6XtQobFm89T7TNr8
	 yWYmvmJPwC+KW23sITFhASsJGuP/UwAnxtAHy+4S691dK5jMBBnaNNsIfb5cN7x1kS
	 GCdLiF5iqeEr16MhlZYUKQz03oysNRZgFK3fPqRjy9O9EFqV/I7uim7RNiT/F+hzpX
	 Of96OvOVWU+Nn2NTOkBOo5CPWvn1R/7uC6g73C6vTtamsNHzcrKZFnGjXmQNb+jllt
	 NJbRIVruKML/HXLn8yrDSPuwuuHmXmsOWx5OwK2Hdjm9PJgD7AbzakdzWhR+A+0MkY
	 o22kxEYvUubLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
Date: Tue, 10 Nov 2026 12:26:24 -0500
Message-ID: <20261110172536.2769260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062414-failed-5.10-56453199d28f@kernel.org>
References: <20261107062414-failed-5.10-56453199d28f@kernel.org>
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
index 224348001368c..394eef0c7c4a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3149,7 +3149,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
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

