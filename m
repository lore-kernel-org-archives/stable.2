Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996F361956
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512272; cv=none; b=HZNZiL2QUMt+il6clc6ZRZn6aCisVo5geBmwweDn9k6ubwWDL9IXR9TH7gS03FI/CpQ7596EgX9byk7DuMZjTAhEZBuC1M5bmxXoTCd2C9e/Lj8yT3Hgcw7fUJJyNhVaVaI1m2qbKzD3+SIIwdIB3mG2vw9uXuYka54lakkmqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512272; c=relaxed/simple;
	bh=3bkHrGYCkCWpURiygN+y8xXd+yYzZiv7kCJzkffLtyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfTa6fJ19C8u1w0r7/pdp818IUTLzaPcTSxJxpQ0pEcM8UmUDF5wbPWSuKba24egsVyYWYkDmwc3JAG9h1LZW1g15xOGviCTs9llzq7HllemWHNPnUqvEGSxfEhQt5pmDnsOXzuPgbnlyDpxpJNiZqtJgTqyhkVvyenm12qoFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso3553055e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512269; x=1789117069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TwgGISgpL2JEqESrBHZjonM9VuicXVmFjYty4h1Kxjo=;
        b=Z7eJXepaCwpMVfOhDqe6s2tbbS/IXJCiPfeA7AU++Ij7A4kM1co/FMIKcVFZ3UDyT0
         XMGYLX/xiVCgiERIh395vqyej85IKG+Epy9OshKLme5vJ0Ds6zK+KyiRho1Iga9AP6mY
         wNBwiAHi0ELhrumE9uLXuaGTRqiZ9mmo3xA1j9b7ZhlPz7pwEYqlp6k0zjsW0mTlylur
         pbmVbcWiKHAC8E4t0NqxQse8Lmdr7b3B5nkyygsvmDoAa+GYds1oUZ24Qhe8sdSQEEFl
         KpIHNpobDRnf2VCCUgTHgAEI7KzXG4l1QdYw6sQ6VG9vTaD9lehlWAkyp+i+DbiSMMFf
         Oa5w==
X-Gm-Message-State: AFuF++nFMWJBCwOZieFrleoVAe915PQdpN9/zyggaT0dziMCqgw4npHL
	ehPo3MsNTEkSCRj/UxnPEEKsvG/u8iUM/TtSeD2HiLc2Y0Ty04Rw1SavuLFJMfRr
X-Gm-Gg: AYBFou3cEGbjOIQXfhq11fC5ii3MODp8ziTtdtnb7i2/aLHinKL/8DmMlHiJ3nrPwuY
	AjNmipbzYj6qgpwb5h4CNDO3QAXaw1bB3O8ZL44DyDgJ8Hcb12vnmVyMjkaizYG0aTcs7Katv1u
	ri1yY0l4pJ9KlDqK6Yk2GF887Z6VYeGtGaI+JQ+znD+/985UEiFMlDADosW/agx2fSCKSrXRDnj
	SOtTeisRod01vOXtUkN45ceDbDoUSWf+TjuS50gpNxV55uOouu4KPXa4A1UYjDzwdTUBbd8hBi4
	L1GZ31mdBbctFlaiy0eT+1ZnP2Yw0ombbweYFmSvhx1kgdytGGoQNTtFZ+BW5ywnmXrDHc0ZEnh
	0lMO7l5c4InRrq8x+DaExSbmyZRBZ/msfVoYJNkgPshkj/e57hjocORs7lmqF1VCyhmRfMJfmG8
	DoNbDwbyg7wK/YdiSAEnpolhkahwFeS32mSH49jEC1ljIlFnJlhMIv32biX3XqFpHWEcc5AJoRz
	IM/V8QoULKlxUgQY6w=
X-Received: by 2002:a05:600c:4f4b:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49cf823f53emr71205905e9.9.1788512268788;
        Fri, 04 Sep 2026 01:57:48 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740af2sm53940155e9.14.2026.09.04.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:57:48 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 7.2.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 10:57:44 +0200
Message-ID: <20260904085746.1805525-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090318-partner-village-a261@gregkh>
References: <2026090318-partner-village-a261@gregkh>
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
index ba3dbac80fb49..db62ed6e04b93 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3907,10 +3907,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 
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

