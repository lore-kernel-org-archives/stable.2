Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050657;
	b=oXhY1Am4QgcIdYlWef/0Vpldr3hzo5Dew+33rmmpFlpjea1fAd3TSknx4oZYtF7a5fhg
	 RpxLxjWJEBdPmSj0zRgGiG4TXQFqyLf9EIza+W57ZjhoBAPURO1UZ+95lAFYRhlxz6xUT
	 aH70mOBkjY9E7h3b3fN4PT3ffDGpfKyy0wpHcwo2KeztFdTuM9N8/ql+Kq4Cjqfz2AshM
	 VoURLxuz7/5QxrT1Lrf/0O9M35j+7BUKXBF+F4evjrHUPGGbZ3PO/pwEv2DDgM2zJh/gE
	 e4XyDUi+tEZW2XF+Zjcqg4F4dSromHK9ZxVQWc2i52DFCE9NUDBkigDv+FwA5TtIjBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qrZ28hfDhtV3uq+0rLB8VoK/uAQReYKbJ2JeOlyUT5w=;
	b=QmDiZsMJDnhXp8gucqOqr/NeN6xbqWxPQrfsanF6zexc7VXHfmjUvr4gePmNGeC6wDbz
	 cKiAMU2z/CepQ0UlbPAlf091ElGglEDS65LavtblWkt1udmTAq7KYd+50S7xTVUYcmsOc
	 e99UsiVSBV6N5UPZHFnVuMYjVmNdv2iQ0+qrC6OKWJwHHjqWjNpQa+ea1/YtffHeI1Bpc
	 1HWRmHTXltTW+iImYfSX3Fu0Velli7ufxgk/qXrD0b9OnYavq81iaFYzOmiyr4iXieQnU
	 ri05gLlKtth2rpr7Weq/3HEp/zVHBowCTsxqsIntP10PjZek2LCT0rTJGfvjo8oAZ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpYBq8ht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpYBq8ht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337E41F0089F;
	Sat,  7 Nov 2026 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050656;
	bh=qrZ28hfDhtV3uq+0rLB8VoK/uAQReYKbJ2JeOlyUT5w=;
	h=From:To:Cc:Subject:Date;
	b=BpYBq8htGDjP1dUGe9u8DTRrAx3gfQpEWWyJE27edQWVX7KdlHPImiRuc2CUF8kMJ
	 djCbGPbwxmT6T81F622ra/AKTT3la39aLLavHLtyg0q2clqaT3iA2+akurlC/yMoeO
	 Lbzq90ez+YQXYUeQbGtxLhpW/4e8VGL+FbmQyEj2v8aQPvlWF8EMWg1bnBfO23rN78
	 QkKBZZqv8jnHBP2WUuJM3kaoAIN7psY9iWfmLwRDM4q+l9uWPLuSEx99CIocRKOxi/
	 BIAjUwvGBvq04yCpdZLH3xsbLvFaw8y1+eQXcdxuC52IT8PXrhx0O+keq+upk3FH5N
	 n32KihL1x54qg==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:15 -0500
Message-ID: <20261107062414-failed-5.10-56453199d28f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 56453199d28f0072a8196fba14b2d702632e2219
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062414-failed-5.10-56453199d28f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 56453199d28f0072a8196fba14b2d702632e2219 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 7 Oct 2026 17:36:04 +0000
Subject: [PATCH] net: skbuff: don't BUG() on a bad csum_start in
 skb_copy_and_csum_dev()

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
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 536e0bb934f29..7f5eecfeddd78 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3981,7 +3981,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
-	BUG_ON(csstart > skb_headlen(skb));
+	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     (skb->ip_summed == CHECKSUM_PARTIAL &&
+		      csstart + skb->csum_offset + sizeof(__sum16) >
+		      skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
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




