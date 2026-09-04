Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F33B2FF9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512643; cv=none; b=uwG2vBWoAuAZj64/TblPJLaNrU7oq804wZPWVe+M05BP+Qg9BPD3AZ6IMAgbJ2SSRHv1q36cQMOiUAR21h/M9crr6ASz9dKDScqcoX5xypq4cGvPUhxFg5JshT32w4wYv5uNfIMx9Z5S2q+NmbjJNRPmJuDR0ZJ12cM9rwIyq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512643; c=relaxed/simple;
	bh=1D+3eClQRH0xz7aWP1UEe6CybsXw35PjDghXgtmmdKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fevTKwswKc4JeCvNVhIZhqCj657/YhaarewDkYVQ82X0xlSAQ/KTWx4fS2ORhd/q2jpguU8LFy6kjghqnOtv/NHOf3KvbHrqyxvzGqqXVSfABrSxrZhVTi7s7vjins/qV28ETlSGhQrjWEXc8YdhpDW6Z6VB4oac/3HCpFPLU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13573405e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512640; x=1789117440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7UtRKE3U0Ks23n/1GxFei94Hynj6k8csNy/A05njHA=;
        b=b9lW6UhFvtD9PAr25oKLOihy4D4c31Bc0TVSkYuT7p705rRBCC/jily13HsoTOgDgb
         dsdJ+P+IUVmEPq+Gc/HqZq3lPmP6YMnJFbMiWHFyaGyWVyTtg2ISzOEO4Y9QiZ8gy1fB
         bb9uzjN/TX/VQB7Q5JRW7RDZbsu35k9ft5NMPdNWuClKTeRd++xLpq6KsBBNVtmvlbeh
         Q4UQZyyapMVkUzYS2TGwK/KiwDfY0XAxcyNccyHS6jcTD4p3a5xdrvC8bTPS6IemU1sp
         Pwzn7j5WIWu25QvhlEnYideyRDchIiRz8UKYP6a6xozK8+ZnyY2gfA/qvo1xpzPEeRjY
         Y9bw==
X-Gm-Message-State: AFuF++kfQyiaJI9T4UbH1VMJzmWYKtKXx3vpxCnqhE/y/IcXtA9SmURQ
	JrsB43/epc+UAvTOvxt0GLFuM6liTWMIlPOdKeea8QlJvQ4oMaqEzWdcsj3Iwhoe
X-Gm-Gg: AYBFou3eXRrLGKIYEabaZs1cRyKil7Xx2dIwBxUpgVpDEO/Y9gOFKd2wEkShhW72wl+
	0zTEbAgpdG2iZ+3TpXyHsS92/73mhbF9Qr4K1beQZq8t2zRR/7kTrT+3KHlw30azuxa826bLk84
	trxMtUY6X0Eng2iUh2I2MFLzszMu7kMJFaYjrPfWumwX5v19UZMDaa1LmR97wSdLk729sgRl0tE
	ckHF8oHFVlJA11iTxnEfbpOK/n7wH9R66mhhCXUVe5LNOsNzjVGKlqr7hcnBhV65l+BzL+slXxs
	gzImN2JcA5mZb6sr7DnezMfxbe0Z3K39fZvDEGZKDVxmBfvUD0avFQ2jdEbDXjdWui2+CbNwZU7
	Hfdp99CvcVUCMjf2GkYZIqOtSqZ8r6j2JO+X36DG+b/7vqwAdjkkqQoC+o5aTZK0tg+ENPrAZG1
	tX8IS8gOK7NYqusuquUHIfRaCFj3Tv006maduV6ZqjT27YsU886bf/EpNySk3IsNeltuXU0lH5p
	TjqfKHLB+BmB0uQruI=
X-Received: by 2002:a05:600c:a41a:b0:49c:f13d:ffe9 with SMTP id 5b1f17b1804b1-49cf13e05b7mr69026535e9.13.1788512638756;
        Fri, 04 Sep 2026 02:03:58 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm5056686f8f.1.2026.09.04.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:03:58 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 11:03:47 +0200
Message-ID: <20260904090356.1807583-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090320-magazine-dripping-c3d8@gregkh>
References: <2026090320-magazine-dripping-c3d8@gregkh>
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
index 732204d99822a..73a987081dec8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3626,10 +3626,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 
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

