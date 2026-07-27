Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BE433BCC
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176354; cv=none; b=PdJsh+/HTnRlhWMGfWrk5YTWsfHaot/WrR54e+R3B2tKosVslArpeNJNhTdy3sKgBsthXBhadgb5YydcezF2ZM9FQPKTV56tm+nD26qDSHLqATvy5/7fjKRgM95DzSuaRQ32Y6Jt7I6HxS+06bgBVdthRFIUds9a/pk1SmYcskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176354; c=relaxed/simple;
	bh=SXJDYsUmv5JMg6/c+xr1owdcCtCJpBAOMTufeVNb10E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBs4hHOxZnC4HwNoS44Qcu0mWaRFFneyfhzsIGBuDEC7HCCT7ed+YazAUP7KMPi5A/Fghc6XKgaMcLcSL35Of7yEKYTI5K1dW210tAUqJNtgAJD3SMQeDnF9BLX8Kg1UmllXXqrnAQg7gdNPCFaJxEf6EL1/9Z4CclnVlKtDMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1602062f8f.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 11:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176348; x=1785781148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PD3b+WprHse+odXNf+PGGAc9NxDJ0EKmW2InjOb5Vco=;
        b=os6110u2I3pHh9dwwUq7U0L47bw7nCyrHu5R1BdpaM1/LVrDLopdEaViwJCc+4Y1X6
         Kf/0HqajUolKxqID++Z/YjVybZxODVVQeNPCHbsMyyqVhHSKNZ55yATkHZLNXnKzjBq9
         b/wvTn2uGDKqBBzFFj0KZzKI+cjKN75GJhQHHpmC/t6fbVJE7Y+NGF5Hnx8NYBEZ+hJY
         X/lwhpcGwoyqosqLD91TG/l8gBDbhz40Tzt8zcsI8R/gm5K/oY352UZD9cr7xhGiJ923
         5Da2ClNuBJxo366WbZ67TthHsj5pgO1suO+hc5T/JHO14jQZyUEoGg6Hqdxm7ul5TqRW
         vtTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrytTQbUEQ7pF/vaudgj60DnfVzNZEK1MXLXCHHht1Cojb7HrmoQTzM/bPhMCjFP7ZW1ggSdPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPplGWBjGZIgvosP4noF1pPmr63YGDo7PfNkzLsDPavDjg0hiK
	L8ilc8L+ZjvzDqVUHCS2XpFfF7KLFBKC7IAYK2iclzxgLXeFA0ZJ99qm
X-Gm-Gg: AR+sD12ezjNEuuHBocD4Un863PuRfiB9WVC1OYGVxoNngedRXyqrauK8o9KIDwtaHGr
	FSwtLstFc0Xv/vu9mSJnXGBqDM16zaGs5qnQmy6Hsi2YSmMf5UR7V8sqnOGVkHHvx1DLh2dcqzo
	Uj8QrevBdlb5hvXIeLBuAq3YARYCpg3Ax0rHCHBe1N/SQckon7QB5MyNk/b3gFrCPpzjARnD9Ib
	nXBOfM47MgL8WICSgyg1MEmcJwoDO9sTkqFU8vUtudWiG0f624p0eXLBxJgrWGpRDXtYIgesX1l
	1dI53CFWjqaObxV3xGByH8eP4T/1+iFsf5a0+u/DCQFk8lqnzKxM1ZuBQ2gznsUzpkYl924Ln6V
	VE1FQZDvkPjxMzyY0D7rF+1x4JXUyHeZTjjmdZukPrzkO5MtjPo0GFnjklE1mvOVNAc0Z6jfp0F
	hNZEGo1urEqjy7r4Lsz6nDEX4+uMm8aKmSor5ynpNHDTc=
X-Received: by 2002:a05:6000:4b13:b0:47f:9629:b897 with SMTP id ffacd0b85a97d-47fafa7895dmr293725f8f.49.1785176348234;
        Mon, 27 Jul 2026 11:19:08 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm51042855f8f.23.2026.07.27.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:19:07 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: openvswitch: fix skb leak on flow key update failure during ct
Date: Mon, 27 Jul 2026 20:18:31 +0200
Message-ID: <20260727181851.306076-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181851.306076-1-i.maximets@ovn.org>
References: <20260727181851.306076-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_ct_execute() always steals or frees the skb on failure while
ovs_flow_key_update() does not.  So, if it fails and we return right
away, the skb ends up leaked.

Fix that by breaking instead and letting the common error handling
code at the bottom of the loop to free the skb properly.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: ec0d043d05e6 ("openvswitch: Ensure flow is valid before executing ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 5653b6642e10..0500939cc8d8 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1380,7 +1380,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			if (!is_flow_key_valid(key)) {
 				err = ovs_flow_key_update(skb, key);
 				if (err)
-					return err;
+					break;
 			}
 
 			err = ovs_ct_execute(ovs_dp_get_net(dp), skb, key,
-- 
2.55.0

