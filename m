Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE9426429
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512853; cv=none; b=NixAVOHSgXvFjiIIcDDenNEEdAL5O3yprBPdM4kb7WyHrzo1iYi7OYxAQYd6SazDFbdbBy6jky8ZGo6LUa7Cn21HFPh/E0trnIfa866CC7ct0bwF39Klg2gEYlLA9er7lek1xLreOkPg/bdVdGfuZqu2eKOmcNdnF5PONLjWZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512853; c=relaxed/simple;
	bh=4cKNJUwL9aLmZxuhqWe67AeCwxD+/uMhiTWlmOnvUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/3CRjcbERQA1n7mm38I7ujzsl45mjjOE6Zzy2SdvFRKyxR2zYPyeQrDDQhi1946G2bFryfchIVa92YHTsuB7/z26WyfkgbeIVzQU7wtMqkq5cvBiVrHi37i/pmGqr7S0LHih8+i/nfFE3Ub2BQv+iu/aKxxrh1YTLWX7bfkgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so1572535e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512850; x=1789117650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F5k7JkWBuo3+eR3CH+IYuOTUgLQO1cVd2Um1pcilyqk=;
        b=YJx9rmIhznMd56/CGRXsk6r2EMneegsIVGKBrOennRGF4S9G4zlvwetyKTNFpDs1FM
         ATo7FUL8mxPl9GuNYNNdWfY7HEOp/pchxfUZDjpI7yR14SdKuBV5fAbNl4w00zRf+tID
         EJFXb71L9uF4Hc/KePVf/hs+qg8M82BkCi3iAQlehiTIOxHJIiPb4EYBBNEwPp8yg5Hq
         12Z4HyV+kYdDVtuFgw3FzT9FNiwpMwSp2YD/zh4a/GJFvZ5Z+5kNtxwop6H7OkNKq0u3
         UChN9Olhild9edpkFxq9Rpool2ZjvK512YdQFbvHHxYTTUjs4zoKy5Ama6g46gF0atgn
         wTwA==
X-Gm-Message-State: AFuF++kUFrNXJYwCoSorEXjhsxPIlCv81Rv0dWRLSgWFS8MUWj3hxr/Y
	GtU5TnwiD87GS63anQ/COj/0Ic3wSv0oFgGDzn1fpro2Y7vH/f5R+QupbCepEAO6
X-Gm-Gg: AYBFou0NUXdTuCnyENSg5/84YH0m9osIiUPrHb0YtxMXLy1M2YhDJHXjzSUUO9LZajb
	hdIzGJd4icOC6cCaizDv/4bVNg+Ff7KmmzU6YpUsVOmEZ2JVTkYUG0j3frFig3DTcpnT3oZXauB
	wcRxmH1eYPVTU6K9BemJqwiSt090zT9+XOKNJGwg92ZibAgTrAmPkzg/gaCAeF2LiVc50asCFy0
	2clmwYVn5Q7r3XewQdFOxa24r6kbr56vA0lLe8bN2K6fpYxqOyojbEa8NnY33pq/4mTmXjEW7Za
	dWKk8yZAxRfBmAVFxmeRekt4qcGi7mKDMM/oPzdSI91eL5E/gHh7t6jgf7DyNLYn+m8sIfPVHvH
	3kDQJl0kN4LxrbOw8SqnHX3WF1afvLl1WJO3akrCKsR0tNHMR66znuMtqLxDBX5jCLL+fhxZ0QO
	7z/2+3jr8MAx3WjtFJOD7jyRSOnAxDwp19JZN7k2NUk5xFcZ+QfoFwvvFONNl7Y43u42SxQHgae
	IX6seg5yKMYY9vYoQcza4JrSnQOPw==
X-Received: by 2002:a05:600c:6214:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49cf825115bmr79388255e9.13.1788512849773;
        Fri, 04 Sep 2026 02:07:29 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm169702405e9.9.2026.09.04.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:07:29 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 11:07:25 +0200
Message-ID: <20260904090726.1808822-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090321-bagpipe-overripe-485d@gregkh>
References: <2026090321-bagpipe-overripe-485d@gregkh>
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
index 6281cfed03bb2..952444595bf14 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3217,10 +3217,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	to->len += len + plen;
 	to->data_len += len + plen;
 
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

