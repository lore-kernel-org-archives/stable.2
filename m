Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0283D2FE1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512388; cv=none; b=Bwl+XcQtLrE+j0aE5bm8fquYfLoAz9XKP56PZUWld/VkcgzbzgDrLJuNPW1FdcgGb2SpGTlbHNGF+E5TEW3nJ+KiHKJwTqUAV1sznYq8GJt7BWBiZr02ooQcbpAzsGa+guh4jvTro38b813MNcD7NnXJCsWO+T+NvoF9BypmhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512388; c=relaxed/simple;
	bh=YlNjyVAtYi5kB2kGJVxI+wuzYU3qGNleCoKDQseGhmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9v874++WP6LCXyoj5WNe6Rsem+V/ST7sBhRN3VIEy50tD3IlvSa1rLLJY2y3Y2ZMbWZ7xfYeG8+mNTByRP9wP/KfoqOFnvwjQop5F+CjE78upIkNCU9ok50V715xU8Fdm02bIT1b4uMouIEnZJfBKQxMBleYinIdHZOJPoUUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso1807905e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512385; x=1789117185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAxLF3rWTCcSM9eL9fn8arDhVYjVJZtO1+a3N0N3bKI=;
        b=eh97ppp8PkKUgSoJF0O21CeU4+GFAxCLj8JkKBd1aOMe3P2lDLAAAOl9cBW+CDY+Uv
         RAX81oz3Fggp97gzG8s6cAXm40oEaTbVWc5RSs3nB5Su5gDPRSoYQeVYKa4fjXOrzsNu
         6ezK7fKQuZ1hxhr7VB3/VSDWPga2FfdZYNBPmVe+ACt9uHjFjuJOOpGiW6CsYeM7hfsP
         n4pASFwO3U4I7kkGP6lMbhPX9HKj418A+W+zW9PqnIztKNB5KhPqVmOfWIeFhZGtZxXF
         VXZ/gFGou3+okJlPPiR60gMWe0L77+iSvfPtc0fW+stvSkJBukoINQtv6yw1Ah+4SqD5
         DQsg==
X-Gm-Message-State: AFuF++nvUAlpDGxrSFFrG+uN5CnCFZxYU5/nTIrJmQqsgGMdOiv6Uzx0
	1pau3QeI6eUZ0VyENSkBnaJL1R5CY555sHAdfeq1UJOMKakJKP6WXrWwc4Gb9wFY
X-Gm-Gg: AYBFou1WfMtkty5JhLvOflixv3zxQ4NQsv52mWRPzyrWP0ljUoWs2uBUGv3YTYHF4TH
	LNXIkb83WZnwfv3dIeV0of8XYm8gUh32InpW3UPTnUdp679d4Y5uR8HJSfgSgtvuT0RI/Q7uu50
	DOZ54yh0WuvfgsjGuq1hNCWuglvLDGMDBTju8p90OGNO38sU3AkIi9rbvJvXr6boU84bhGq+/Rj
	DyJ4HcYEV7P8hxFomov7uaoYG86lyehfsECODHw1pFCRpiwjWAknOtqsZPvbX4hb7u3EJwiuU+q
	zrdSx8q6qewC1kuToCetY8G0/5vMCAHx8tprfUugLtt3Ipj6y7TN3qyeFAtoJIF9tmMMEeBVe1/
	sz46s+KTZxhtUsqBEDLwQBl4t1HAPrPOwhs94LR1urs+fYl9V9YskW7orqgYLQ/DvnVlyk+yhYT
	SKmLqlShtuzvD3bn960nGi37gVKSIxMigtqSLAs7g9n9l4uf6Uqzb0akONKPihHQueGuFNUksp7
	QEcBdErToUtI9UE2cg=
X-Received: by 2002:a05:600c:8b05:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49cf82787camr44064135e9.15.1788512384803;
        Fri, 04 Sep 2026 01:59:44 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm127654275e9.3.2026.09.04.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:59:44 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 10:59:39 +0200
Message-ID: <20260904085941.1806194-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090319-gonad-edge-05ea@gregkh>
References: <2026090319-gonad-edge-05ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit 8ece906150128d5ec2462aabcc978c568433eca4 ]

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ 7.2 and earlier do not have the put_page() call on the error path ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e75baa72a22e3..133cd56f7b5e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3856,10 +3856,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 
 	skb_len_add(to, len + plen);
 
-	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
+	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC)))
 		return -ENOMEM;
-	}
+
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
 
 	for (i = 0; i < skb_shinfo(from)->nr_frags; i++) {
-- 
2.55.0

