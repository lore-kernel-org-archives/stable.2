Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F63BCD05
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968470; cv=none; b=QtkQhlB4L8kf2XHiYZMFTOA8UXQgD7CPjlfaoDQBU5R1NAo+BzTZoVPPF0Sx9GreHt9LV06ad1oWFDgHoWwn6Ktc4KQQyM9r0sQqzYFLpcF33nFzF+krgOOQMhc3nTnKffSPj4vhJntbkUD43y4RYALAouG6ItLMHN2PTdxV8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968470; c=relaxed/simple;
	bh=Ntq5tvZ6F6IcSr4ehQ7e4qSobLvcVb9zIJny3ir1jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1Iea0N3dxq3hakZ91NoEYQzcqryJHQCFyNnliMnEMTYwfEX+OabC2v1jSzGrBNCUFo8oY/QK+gU1UZ+BMI6SpYCy0DvMMFk8VQY6eGBqjEaILvIVR+LGaz6pHxIEDXJIf1QTwJdl8VHfDv4wPSARYI8ja2wEliTn7+JKdWtJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so3524005e9.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 15:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968467; x=1786573267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XlmZSBYyHMBmbNtLNSZH7hvTcw7J9o7gZKr089qG8Gw=;
        b=STow2YmHtKWhJifIxDyMLLIwFROjJ74Z0UWMWG3e59fsXSIffxeLTCl5n9f/koP489
         OrwweymBLsMxZtSViTgo1G6NEzHZZKHUmARwJpXZR49iHuLV1+Tp30lwAfKEU5Fib8Je
         3lljZRenrAvTbQlngXzh9QC3O/eX9D6rjrIBQM869qG+wfGZMg+59D3dNlfIlnE6030G
         hef1FnR7nm7Q7wDlfri73tREj3tVquNKop7vx26dlMXgMTkw9ZcjD58QZA+BSsyR/XPO
         3XRG/Nc1qTBV0S9DgT9+YTyMW6ZKjn1WlePbxYaqzujmOQzXTOZ1S3iu6K/TfQddUWrl
         /CYQ==
X-Gm-Message-State: AOJu0YxRULjJtqf3JBhhC690FsicA8e085GQdku0kBUlmknIzuA2NgT1
	+BjqM/bBVHPDmmuIdYMNpQGjB9p/72LgOzIO6+X9p8Zw16mf9u0p1ec1TdJAPqji5NY=
X-Gm-Gg: AR+sD11eQx7UsBGtKp0iqpB1ukv9qRTidP2EySX0sAxIZUi2DyjlpviqVY8P/eWCpT6
	EzimNMT3Ysuc8+vxfNRQB55sZ4QAf0GdVep96/0YIhql52BQJCvtOjJzvJrpnpvFOL63h7b+tKy
	JImbEyXuhjiyxGYEZjeauDzfDK+y3hx+O9cH4941vvQLzQYEUftNkdVhEEr/3jLMTSnhwLiYUgT
	7+aOHvncBzpONLo6IUTxAlxCqNzPlBtJN+W2doFBWayvU3IfSM3WpDFFqrWrjN31+MATZi8aMuI
	2lIBW6P+zjfGnWCyW6PeBtJdRwUzdXhs1DCB7DqgLTF9K0qOh5YGTrcxrGllWSXP+lAi6fffk5k
	tRFf05DzL+7b6bIXKBT3eYH3ysR5yX+XyKcAWgsSvoruRH98nthyxZTftePcXQsX+0meKk1kcAz
	uaSHJlTYkSil56xfEBv2CRr4re63q0D/GVyRzLZgtLELTIMGXYBSIQacd20OwXMBaBmk0RSu4xV
	o3dWGWeNP7Qtq6/2AG+hQ==
X-Received: by 2002:a05:600c:a47:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4994e7c0c62mr122055655e9.12.1785968467162;
        Wed, 05 Aug 2026 15:21:07 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420cb4esm12160735e9.2.2026.08.05.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:21:06 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 00:21:01 +0200
Message-ID: <20260805222104.2820621-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080538-gutless-facebook-638b@gregkh>
References: <2026080538-gutless-facebook-638b@gregkh>
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
[OVS drop reasons are not available in 5.10, hence plain kfree_skb()]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 3b3cc6ea274f..5f9994839bed 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1104,6 +1104,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1114,8 +1118,11 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
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

