Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADD431A22
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512962; cv=none; b=L3MCSL8KprwlKyIN0oCWIRAeYapESbl9zkkNBBsyH95xSn0h7WU8Z4g8oTFMx0Li83rRBSQg16svsKL9e6U0VSCipfRzVN3xjh8p2TO1FA9FR9h5nQ30OdREbAJHULLnRC5bYxe41EF/oP389m8sH3O3Mi3qUW1CkxrJj3xT/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512962; c=relaxed/simple;
	bh=rDTgsRN52wSJ/B62wTDWLN7F4IY1+DqgYKqUZgBegoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRlxbVnqvgV7VqS7K8OEkrzuG6k8NbzWhsRMtBK4427YdB/tuBkPKSYzLkrYeK9fjHhGhNAF2KS1lKEWkkA6dBugo/k7Vl0rGyfie+lp8J7EiikoC+1tprqHcskG4FUFeQs6al0ZvfIRldurn6Pxv9EqgoKODsaSmnLFLXKSmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so2433055e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512956; x=1789117756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VGNcHfDWPptv2ciMqnVCn3un0FCRB7HyZhJvpH0U8i4=;
        b=b/vUFekFva3lRlixc0jmf1zPCBnJ2C3nhHr9+kIAeBZLaEF4lRNZwPzVx5jnH2HsaQ
         nx4A6rDqhlv3OC7dlDuJZM70uy6M1Q+p6g4us6h/09mRwVOEvKaJBYt6xncsHPOg4ko9
         xN2Rmt26uszIiEtmlDHqACe3e6wOl9MxdHDnOcydYYbWP7j1gja+12DhH9zAhbwIYhkp
         FpAY8TPLpF7VFfT593U5wOd7x46WXJ/CCdHp8ZvHilsfS4Lv590uOWU6WGCAEiK6Fxuz
         ZkUvez1py6YhZeynDr1CA0jgpGyMugeVuSpm3VzkkJzJNWps/D8I4w6H828kPDZjNf5q
         MwZA==
X-Gm-Message-State: AFuF++livusV/4Jo1dc6JiceAe3NiHoSUPEBTzkWh8YIYuZ0GM9o7hVy
	2AGU9eNE6or8gn+bBxJwkbKKz/o6GEKpkYCpMBi8BTcslyKozr2RkviktCuJqKvx
X-Gm-Gg: AYBFou0/VzAC7AmBS00PPenukkGw+c74SZXPdUWbBo1hPlGMrC/7ZUwfTtrDQcj2xZY
	y7kqyqKRSNARrg7X9RphRU+Q7MFhHJuRoESZckT5I8c019qvlJnN90PqL1GXvI733W/8porfW1Z
	W7rosg5VzqtylQUhycUy32gB5ZHOnfiXGJ+ERfi7E6BM6jq0lxBLdun+HrDiDPYRa6x2HUGbck1
	kLf8FcWBzhGGhE7vfWEN6kYEmS/4mERcwWUVOYk/xLFiyduC4hYVR3XSypGTyk0LywBrBYxnUFo
	T9SYN9ANNOCP6v3F/f93h9oQ/PnbcLYXCbA2BMEE5d7ETncseuv0ZzmqF+ZisnVzHKesuzpPsAA
	3HKjuB7bwuXbSy8NF2z7KO2uHsJONQu/0Vtj7Pw9PB+BC4icBfDbAnfiNeAj6kQfDWukIpMtotJ
	jR1lU+AuALdTtybFP7fUuN2SaStaRYQGL+Rs39HDiJEQFmjrFyqhgwyq7Eyu2SY/T838+Vsioy7
	MVSvY6L0WPh4mNhAe6aPypdvo2/uyE=
X-Received: by 2002:a05:600c:698c:b0:49c:fc6e:a3df with SMTP id 5b1f17b1804b1-49cfc6ea7camr22664155e9.30.1788512955984;
        Fri, 04 Sep 2026 02:09:15 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm143000635e9.6.2026.09.04.02.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:09:15 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Fri,  4 Sep 2026 11:09:11 +0200
Message-ID: <20260904090912.1809399-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090321-rockiness-marbling-ad13@gregkh>
References: <2026090321-rockiness-marbling-ad13@gregkh>
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
index 793b58979e5ca..44e1547d88d62 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3080,10 +3080,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
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

