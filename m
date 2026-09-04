Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6441C2324
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511183; cv=none; b=KOk55GgmsIR/CvW+rdDBVhDlqk/yDzopNrmQq460A0dT44Ua5NwTb2RSqrw8XI2zJIPWHUwBVU/rHl5/reljB0wTQeYFAvmEl6V36R6mL63NkEVzucut+LxfbWA9RsN+0lLPAF5EhBXaICxMtF5Lu3ElQcDh2fldOI4dJWzlkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511183; c=relaxed/simple;
	bh=Vs4NIwy9TDjaxeNM+EQOGaHSmlMuu8xZtXIs9CM8Pf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWx4qmfmaRVBl52ADhZj1TIm5rIVbbahumXWheVdT416nlWy2/MG4sua3xHw9TswtNQE2OIjj7xMUqXv9whtZeaatcw3otpkfnLSkGY5SUvj5RVmLL+DaX+Fu4bMP5HIcv0h6IT31yund/tjavGmj3wUnCbI09Kp3QgNhywexsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49554457f71so357745e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511180; x=1789115980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BhGFRAVElnolj3stsHqURc/672S/iuF+zy9EldqClm4=;
        b=ETsRpVO+Uvfl0JG6WMj0TrYHL1oUsFZreKpkMgiz8KVTCsoLEXGoSnl1FqcuGrWvAe
         dueEXDtp1rSiFlPmqlQz98yBdm4RVkoq4Gaki7t4RYgSx6lb4driB1GXmmU+oVy7xoUE
         848oYWekVTYiIHi816dvLSMKnQbv0luCwriGTW2+H+bjIlbjDrMetV458U2rzaOlzisy
         9RlSCEasV4/4Q4eB2OP+EETdznwyGm9OTdVkWnFjCFdhy4hESs1QBaSzuDuR6RO0ABoB
         APQ1ghyp4D06IPjNQBq2g+C1dop7Bn7P+YNN7XkuQrFloreEE1u4Qrw1ee3/LI9Mt8yK
         OaAw==
X-Gm-Message-State: AFuF++kzW/VciYhVzGZmwh3ZRmyx7K4TggUd9BnNT2XZCQC31NNxrBoS
	vNqs2dCUoR/yZafAtkGTrLZmJHCCT3GNRVP/kZ3AxA2ESblNOZJstBUfmoo4uf5t
X-Gm-Gg: AYBFou1wqqCT5Fxozkrnfzi/OpdeMFTp14xl9m7uDZYWLhEiJPvMiuiyrWxZkFUv7JU
	QJdrLt8S1XBTTyFjWd1X0bhbIBe9ZNULlJEb8pUHq6t1SFor9PILEk2UG+lrH0aEH+bRnAyP5y2
	W3lEpKb1c2RJ1iar3f3f1rIChsjGjzmZN07L2cL+gf2uscDySQTfhYctd4oVbAMmejlGQwr+tb7
	jdw7xoeUQidJt4FeaRFunxXv+dE8hJjswebf9YH/m/Uc7xnoTIWAcU1LaisbWk3aua2m8pwopDw
	ReURmmfatZSB6biqXuZjCiUyM1SlKH+WUV3E0sOcU3zWAdrBO24Irh0cUQUvviNn7WxvU/xEGmP
	UyYYlH7SS1+CyPqmUDfaB6fyxXUtcRVw+drgHWJSE4zpKr4MqPZittQ3y4eZB5tQKFgUEH0KyT5
	Wf++kiEvPD15Imu7W3IhSnrnZWnJKu6mfkf9XTVJiR+p2Jy/+n250YOY2BGnbjXIr5JsfMuKWC4
	+/u7fjsimSJ0114xjyfhuzsvR3WwA==
X-Received: by 2002:a05:600c:a05:b0:49c:f501:e428 with SMTP id 5b1f17b1804b1-49cf82e5b1amr30642355e9.8.1788511180059;
        Fri, 04 Sep 2026 01:39:40 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7ac52c3sm148339335e9.4.2026.09.04.01.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:39:39 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jongmin Jang <payload.jang@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
Date: Fri,  4 Sep 2026 10:39:35 +0200
Message-ID: <20260904083936.1801336-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090309-stardom-headlamp-9e27@gregkh>
References: <2026090309-stardom-headlamp-9e27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit f66bdb1cc0fcd227a062378f8be0b5873aa5600a ]

skb_tx_error() completes the zerocopy uarg and clears
SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
shares, while the caller only owns the reference it is about to drop.
Through a clone it tells the producer its pages are free and drops
SKBFL_SHARED_FRAG for an skb that is still in flight.

Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone()
does not privatise the frags here -- skb_orphan_frags() returns early
on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
from the packet still being forwarded, and a later local ESP delivery
decrypts in place over frags it does not own privately.

Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
the zerocopy state once the last reference to the shared data goes.

Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Jongmin Jang <payload.jang@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ There was no 'if' on 5.x as there is no skb_zcopy_downgrade_managed(). ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6281cfed03bb2..83ad581b12fa9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -889,10 +889,14 @@ EXPORT_SYMBOL(skb_dump);
  *
  *	Report xmit error if a device callback is tracking this skb.
  *	skb must be freed afterwards.
+ *
+ *	Does nothing for a cloned skb: the zerocopy state lives in
+ *	skb_shinfo(), which the clones share.
  */
 void skb_tx_error(struct sk_buff *skb)
 {
-	skb_zcopy_clear(skb, true);
+	if (skb && !skb_cloned(skb))
+		skb_zcopy_clear(skb, true);
 }
 EXPORT_SYMBOL(skb_tx_error);
 
-- 
2.55.0

