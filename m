Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B640D58B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224204; cv=none; b=ZlnqgvAWm7tQjk2Ftq5DMFRPK/mDuiqbqay0lIbDcLjd9OrarNQf+ve9/uFF6cfbw1TPSOGh0abrsHpON/RzFUXfljo8+ADycAL6m9VnsqqTnqDRe0ItnOo/4agdUMzS1SuyhiI/MsYVuW7I6/3AXV+i8JVobW3AfCPLo0tj+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224204; c=relaxed/simple;
	bh=zxcAEsXpAFIMud6rEKDnszVIcn4z550JU4YT1RfBj4M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VCD+9o2ftcD4x8zqE2JzDUTW7gDzNUA3aFHSnSttjYDMSiGtDBAd/ZsGxUP9VUW14gCw91Df1sk24Lb30PUqSad1xODkUWt7ymPTT3wqZT73ikfcqQZ8e0ByVbSsUbrOrB3XmqjHnjZSIeZlIFRHy/lJGiTKqaToN48c6uMjN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gCIaZFUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gCIaZFUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B731F000E9;
	Thu, 20 Aug 2026 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224202;
	bh=X4jFQyG6W+qHvx5p24ZnXQQZH+Io+2CWGNUo4C7KKOE=;
	h=Subject:To:Cc:From:Date;
	b=gCIaZFUVrqtb9BIbZGdZj9X/EIH+cubHVwP9H2m+xwC5Igzzv/q8QSdv6Oh2EyzUS
	 pb30hDi0Nsi4CrdlpNgwBRysChF0NaNp+/J0oVVqLudzz1CU5ut/U4//TnPFIK7/XI
	 aZNIwDQ4Ekm6nidMa9vuPUCDvCE+pRm11SfzaZg8=
Subject: FAILED: patch "[PATCH] gve: fix zero-length skb frag with header-split" failed to apply to 6.12-stable tree
To: jordanrhee@google.com,hramamurthy@google.com,kuba@kernel.org,pkaligineedi@google.com,ziweixiao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:09:58 +0200
Message-ID: <2026082058-encrypt-lividly-0296@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6bf14575c65569dcded90ef78afb8a6d57323f04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082058-encrypt-lividly-0296@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bf14575c65569dcded90ef78afb8a6d57323f04 Mon Sep 17 00:00:00 2001
From: Jordan Rhee <jordanrhee@google.com>
Date: Fri, 7 Aug 2026 22:43:14 +0000
Subject: [PATCH] gve: fix zero-length skb frag with header-split

When header split is enabled and a header-only packet is
received such as a pure TCP ACK, GVE will indicate an
RX SKB with a zero-length fragment. If this SKB is then
hairpinned and sent back out, the GVE TX path will emit
a zero-length descriptor. Hardware considers this
an illegal descriptor and stops the queue, causing a
TX timeout and interface reset.

Fix it by not adding the zero-length skb frag.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20260807224315.234152-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8271f731a91f..0ece2f6fdffb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -886,6 +886,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_free_buffer(rx, buf_state);
+			return 0;
+		}
 	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
 		   netmem_is_net_iov(buf_state->page_info.netmem)) {
 		/* when header split is disabled, the header went to the packet

