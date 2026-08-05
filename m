Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F683DEAC4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968368; cv=none; b=buoVM50aqctKTYbyOEvFUapF/W8PBqOa7oFvlNff4QLuYC3I+OW8Bd5zJpGiJ/a3iintbHuJbVMemz8ap6MFNiWTgMSReruuG20L7O7Z6tGGKsvrjcX+83xxqWg+v8V0NeYznf1QkXYXfZZVV8xDQyzjG+cD56pTug8JgW0qFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968368; c=relaxed/simple;
	bh=Ymxk42+nJuUH/T5EPJ/BRVz2PVYPRqY2vob+fMPp2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKiheRs8bFdsLXYa57UUZBNv5iii9AdPB4IPzJjslGiOIQl4d1s4wbzqyUisg5AiX/VsPXm/s1aZO8EJN+f/iuprQfIcZ3SDTMJ/V7+qNVpZJXyiJJ/wwDNfixHJDagtjQBwIBGvrD6ELwAiv3easGJZBMkTl0eoC8YzN6o/Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fad256d40so553652f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 15:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968364; x=1786573164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQfZzkTDQS3nrsIaPaEEx3fLiEXiOBaVz6nwxv/6Si8=;
        b=DVjApGuMotB50D/VIbuFdsu4PqAK2/ImYxyMgLaZCIR/CwM5ghos5vxiwf8VQjRZ84
         hiw0oXg0KeBcQItJmacbSKw/k4kEqA8yYu3pXIXw2eP3aiFaZ/RTSuIzkZuB1fhlFsEi
         nnr2ErzmgYJkqwrdaKJ4DXP9NqAz4V6i/3N4moEonCRBVrPA3lYzAZC1iSJzarHcUP+w
         3ftncdAPDSvcgGVtRQbPBTTncSr1oNFP+Xmp/CqBIZe8M3XXgLAVkCTU2bKq0Ps5Lxo8
         S45woC22yuivoaisgv72krsOj6GweBOCsbL0iMRn9jAOpIdMOvCHh9nYQWQL+T4Yrq0B
         aFeQ==
X-Gm-Message-State: AOJu0Yx1LYpMMM7oygrRdWcp7uNnVkKkwR142euOYTxLqX6nAz922lqr
	qw1lONY4nHukM+V2pDXifX6iyMOCtQlvkbfvOACe4vts7E7mWq+cjlVp2iFHGwnMtNU=
X-Gm-Gg: AR+sD12/MsP5wh0GgVUVusbdTZh/PkAwhOR+LafW3MUbXwipKnDc1S9vNN0i4gX3oJn
	senfo3q5mabF+jUoCoMP0yGji7ARCUPPJ2Hv4Hh0azZEq2JWmxEYC8XfxFbvMHJtSFPWWheGHVR
	fTKBTd+jvktyCUYov32Pa9BuyaLv9v5+3WvY6zoNIf2D6V/O5ytiIdtFj4RIJnIuHtxzriYhU4x
	AFcp+Q+VfIBymhxL6c8mzvwygIbo0DgXEmcS/ahYU+T/x0aFTd4AOJePdA8N//bQvEF0jSo7IrF
	clVbYnqSKUVHgNFIGnC6iDHMZOcW/3Y22Kns7Vb6Gfe9sDnYLTKpPTeN4UK6JUaakrgmkgExXW2
	jmn+m8M/2hGanhAoqAI2kWs8zlE6U6wfOxBgqODb211d+PlNzA2GWiy74vXHGJ9Bl0noZjtkXLm
	cHC34a5Lrrb9peI3Qi+xv/wB2FKBkFr25Q9hTvfKqX9O62GLiWgO0gCvSU7UG32V7bhZb8aPBp8
	Cdrx0wFRSw3A9ElgrN1SQ==
X-Received: by 2002:a05:6000:e05:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-47fec5051b5mr13640235f8f.13.1785968363949;
        Wed, 05 Aug 2026 15:19:23 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b819dsm721695f8f.16.2026.08.05.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:19:23 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 00:19:18 +0200
Message-ID: <20260805221920.2820141-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080537-savage-rarity-dbdb@gregkh>
References: <2026080537-savage-rarity-dbdb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit e1cf066244dad576221b7123a0e5005967f25a20 ]

do_execute_actions() returns right away when execute_recirc() fails on
the last action as it assumes this function always takes ownership of
the skb when 'last' is true.  But when the flow key update fails, the
function doesn't free the skb and it ends up leaked.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: 971427f353f3 ("openvswitch: Add recirc and hash action.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260727181851.306076-2-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[OVS drop reasons are not available in 6.1, hence plain kfree_skb()]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index f7cc87e67d3c..845f275999c2 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1111,6 +1111,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1121,8 +1125,11 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				kfree_skb(skb);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 
-- 
2.55.0

