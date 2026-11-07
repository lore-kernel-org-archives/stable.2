Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049635;
	b=eizbYwFe4k3729FGNCHj+Qios5toNhnB49TLCIrzsoOVJU0A4Cc2ilHJLXIO+UqobuGe
	 QW9WQZNdo6Ry6V4l5E/8yp0kAFavsqTnyxvf2r+TttwmSOt/NSzSqFP8F4N4K4Rf0UPP2
	 2fg+UXax2Vwd2mmHNDg3eAyCw5JzFjAHnmkLPP4GthJf3rGLX+4h/A0nredTA3OsrZ7Vn
	 zi4y8c32i1Et71HsveIbrBA+gXluGkZxTlWQlikJc++PCrikVp0Dlow9g8DYZ/5nB1Vst
	 B9kaWSgGGyOD7kxKK5O/BEL7vsqJ66fXDJU28SHXwo6yyVUvR87P/piXwtAQWzEmm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hi7rDE8LKEuBOxIJMXpoKMSunKzAp5IuaR1gQssQH8M=;
	b=vplY5mGaQMOMSMz+PO0sCnwqB1K33ie7VAnbq5naSvU3bbq5sG84o5/LBjXkSPq11aAp
	 bGK453KzblRwPdZjmfpCWAvLsVrhy3q41r+3eZN0XQ9/Ya5zTTB9mlndmrZ8PaoEade8U
	 lNI1/FzdZFUMwTPnoVJOGza91DESc8+NT/3C6gSCWTzfrcka0s1hXraYGe6XsK+DOITO4
	 qErAB48GDygKOJKZjcYxiyPP5r/Z4BOuEHTpR/xGn+De/KmNFq69jw95jFn8I3zuQw5Xp
	 s+r+kowzHJMSBn6lS1usdDgYsGrTZ0gyzgW2vw+VdHyY+tbdo8V4xKh3q1qMJ5RFdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L8vLB/VJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D8606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8vLB/VJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E7B1F0089F;
	Sat,  7 Nov 2026 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049635;
	bh=hi7rDE8LKEuBOxIJMXpoKMSunKzAp5IuaR1gQssQH8M=;
	h=From:To:Cc:Subject:Date;
	b=L8vLB/VJn6KbHnzr4RKS9QKSkcUdzq/DXspbqmx3dUVan/4oFAxUrhtjgDcNCd0xu
	 2Z+49zorxlRr1mA9vCqvslSumf5Hn8auAlde6ZyGRIV5eNvEMAC/Fig9pXCcwTaHYp
	 ra7zN3GLhnlcTXGrGp8m23WsMKvxcGHZ/d2iIurPeS3Cu3ivcf+x46UrCRwRihaxhz
	 H0myvdnE9Zm3aUJJ+wUV1FSq5c6AK6aMXbyW/ZAaXMGcikyhj8iI2LJC/tmpYG4m2g
	 Z5jqFWdVj0szVrVadS1og956YJiIri718IkoMPbd6smWUGOoKJBYssgjjuGRK9El9b
	 Eub4/T2rBH+ng==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:13 -0500
Message-ID: <20261107060713-failed-5.15-56453199d28f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 56453199d28f0072a8196fba14b2d702632e2219
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060713-failed-5.15-56453199d28f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




