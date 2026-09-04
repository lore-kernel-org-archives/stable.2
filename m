Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7963B2FF9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512737; cv=none; b=WfDVhz/q06BQU5laNfu8mvuIDcKCHhwxbIfu4vbRse14/UlyPxY2hFVBkZYwmsUwr3uAJCiwSyI8BZGlYVwqV58AeePt+bwwWv3ZdKB/1RBEu/4lZsNOaSBAZ9lTrcs87LxZEftefBHwvXPLxeYmwwic60ayeSrUDo5x84+NLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512737; c=relaxed/simple;
	bh=tyiKsnKP2Q1B8vzdYLwG+d91t4hoWOMCZzutfInZDTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUPk7lUi9mm1MEvCtyI2e03hVCZFLkP1OEzzbafyd2En3h6wXQ2XpIZWljKbzMIEJHzufc9GsUDg9KXQYmkiUwZXwyntzsrnr0BqHbAhYkp86/yIGrpEQzdBnuIu/Q6P4ErWs/QqSj5Mwhr4CjMayGQkT4OeeBb6aPG+2u2miYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso3363205e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512734; x=1789117534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2ZdDQmTsmtCFNwtAuH5zqDc70iCn2MM2/S3cYlW+rI=;
        b=IXvb+X8h9KbMJ2nMsaJv4cmN+nbPPrBcUU/TE2rUJIRCy6HIoyoKmIK5Y2qB+TRBgO
         8Ib40kWq2lVroBUALabCXpRfjtyhwQmqUG4lB5qnRotVJFH0lSufD2twemVhIw/clvIP
         cU17+iWweFy5oPVikcJP5UZWnbpMPuk8v+SoKoXsPKQ2ncHi+nLOVanlO6iBrluxn6mr
         oKnmlaRveN5xgsOKHU1QouGnDKDIORKqGOJUNdWm7AyHfzq1A0/66HpuoyuC6X3RrHKB
         8MdamuMdZ23+nU+6IAkjxGFAXXnYkgYmLhzxN25PmE+QiQNd81S089IwXyFp/c6y3WaH
         teyg==
X-Gm-Message-State: AFuF++kf0pAMQWd1lLg4U98TEwyuPlLsvNLVsIoV84yvVopBFhLnjeRU
	b8nd/yhsVc/XS14E44T3G55xwv5c9FrtP2viqQDFIvRyTZZ7RQ8tICrywaKiixfN
X-Gm-Gg: AYBFou3sLeK85Hhl/dKmejLXmOPTm7XCkdqKMHefOiscbyUFzBDoCh9Z1so/BBNwQ2d
	BXFz02OHXJPaAgUiTSU//m41451ngOslnsBteNNiuDccY+9Z+O2QN94jTeLAzuV0j6lZ+cjYxxj
	NPkhy5ajvVg60fDh7SZO0jN5Q1iU1vQGROmiK/Z4UQMFbrSlyZ5qRb5n2WV5lKsbQxvheaoY0Kk
	yZzTLvTMqqVhNQBsFYAcGGl+Ha6jyrIp5pGUx1VRF3JPBkFsxC6mu5+7RrwmaZEoKsRGFXvijQI
	9y71Q5AuaxnEczToiOCr1Qgs8Vcw8K1tU+snje0Roz7KLP6pplnTx85LDhwXUyJpElk6JcSv05G
	Rxa4j6c84iRIsh3Kq1Hd6MDbYcNGA0LYNjB4ZNihuetg2sfVXO1bjOjZh72Fks+IM3WvMdmssi+
	YuXCJrmAfJRUGPMv0AuGvwq0kaAwHQLqwiuN+48ft+PNMlQstPgEuJjh1CPOHRutYtIyLYOJfSG
	FIL17bL5iGhE0feH/nq+PUnsEkByg==
X-Received: by 2002:a05:600c:4685:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49cf7f32214mr49124725e9.0.1788512732575;
        Fri, 04 Sep 2026 02:05:32 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm153972615e9.13.2026.09.04.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:05:32 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 11:05:28 +0200
Message-ID: <20260904090529.1808224-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090320-disfigure-stony-5e76@gregkh>
References: <2026090320-disfigure-stony-5e76@gregkh>
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
index 6575a76a312e1..455fa9f83ec00 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3353,10 +3353,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 
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

