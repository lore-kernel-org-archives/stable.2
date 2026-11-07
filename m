Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046358;
	b=vDx+M5EnS099rg3AR8GTrMlxZp9/0IYZgMMMi2wB/AKAc+GEurGjRd3dZntbm/A5DhEM
	 2DkD9DJN6ri9JUEiVf5/i1S3YNnojIQa8qmWv6I349NcrahymrMjMpzXwxIdf/bs3U1gB
	 SejdYSoXMNvIcyqxiWNCyjCdCQopNlbwTXXYpi9EW/4q+XbCUQWSWtwoLH89HY57jv6FD
	 AGtzHfEsHtmUjnIsjt4xJ1WZcimE/W/cg5Z1pdRw25h4FvBr6vlAEalqXtraHXV357fA0
	 Yf/RmHJuRb/Kcuh0Yej/qX2vC3Z8tud003GbIQ9Lpm7jyfCNv1tQtPZN52xM+Db2qHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UpC9Bjc+Bz798R77f0RwNLoVDF/d0NNMIK5sOZ9Qphs=;
	b=vxT9WtYeA5if8lwE69uB5Ehr7W4WbH7q7ysy23qCYxyvb/i9bbAOy5an/TqngJNHzGbU
	 90t15icpvW0UEMvU+zJfN2d7D2jqn8NBPuQvD0ZERW6mOktxF7gpgZtZOfesphgGsjy6X
	 E/n6W4xMOu0nJHYeXolCDusMT/shJmI3WJi4YcUfkX5cn/0uuCkfCpbWykwQSVySNZ92M
	 rlHgdPvB4MUiaF3fP59jiz8wyBnbetp6IxMpI2fexfnxd/1HIU3W6qg2q/zxB5JQVHdEG
	 eFJnQVAEC9mn81zlSZXOhR7Yj/c2iHu8ICUMqi0J28ZEEabxLApROEf/oHJHTxDCQpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDHpADVR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDHpADVR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D91F0089F;
	Sat,  7 Nov 2026 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046357;
	bh=UpC9Bjc+Bz798R77f0RwNLoVDF/d0NNMIK5sOZ9Qphs=;
	h=From:To:Cc:Subject:Date;
	b=iDHpADVRwJHh+IcKlwN/6PqepkzvWMOdcz4fTmMLzP+UOWupiqCugG4+YfoGKryZv
	 m9N6mE8LvCsvb+MTh/EgCsM5Jx/mKNHQPho5WnUEMOMtStcISi+2PbcHMYMGqCca1b
	 euPbcmrOlmPly6+NnhULl3tZgIbcJgS0t20f3Vq7T2AYqM7lt+y0KVHqO6BEIU1Qzf
	 BN4p10NXBM1iWsLwaVNIQaYxvn5tLrheU988HnKn8nmjiyZsRG79lq7djfKFfRdQqA
	 zjp02aAq8cd9zeerl61cYmvMAnnBxGZWnASuvURJ1ZkauhqzBF9Ef3lXnKJow//Gyc
	 s7hyALBw8nhYw==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:36 -0500
Message-ID: <20261107051236-failed-6.18-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051236-failed-6.18-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd37ab22a74e05aae5c16c67295cbf5188b16268 Mon Sep 17 00:00:00 2001
From: Liu Chao <liuc63@xiaopeng.com>
Date: Mon, 19 Oct 2026 15:56:26 +0800
Subject: [PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple
 filter

ctnetlink_filter_match_tuple() returns 0 (no match) when the IPv6
source or destination address differs from the filter, because the
!ipv6_addr_cmp() test is inverted.  ipv6_addr_cmp() returns 0 when
the addresses are equal, so the negation makes the branch trigger on
a match instead of a mismatch, which is the opposite of the IPv4
path above.

Drop the '!' so the IPv6 branch returns 0 only when the addresses
differ, matching the IPv4 semantics and the caller's expectation.

Fixes: cb8aa9a3affb ("netfilter: ctnetlink: add kernel side filtering for dump")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4e5d7c7014368..cc8695d5356d2 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1098,13 +1098,13 @@ static int ctnetlink_filter_match_tuple(struct nf_conntrack_tuple *filter_tuple,
 		break;
 	case NFPROTO_IPV6:
 		if ((flags & CTA_FILTER_FLAG(CTA_IP_SRC)) &&
-		    !ipv6_addr_cmp(&filter_tuple->src.u3.in6,
-				   &ct_tuple->src.u3.in6))
+		    ipv6_addr_cmp(&filter_tuple->src.u3.in6,
+				  &ct_tuple->src.u3.in6))
 			return 0;
 
 		if ((flags & CTA_FILTER_FLAG(CTA_IP_DST)) &&
-		    !ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
-				   &ct_tuple->dst.u3.in6))
+		    ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
+				  &ct_tuple->dst.u3.in6))
 			return 0;
 		break;
 	}
-- 
2.53.0




