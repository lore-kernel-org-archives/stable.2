Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8396432E97
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176350; cv=none; b=TkDXb+rs5sKqYirBmExV8iySlSrANjv9URr1A+x1cSmMUAMp1Mwsn4gkG9eSIYYdlY8E6W7dKnF6IYWcaBV9HSWdnLhZYU3Nrj2U68RhBFrf+uOtLw4Vxj28MnvdKyLw2I62GaojPifG68K6e3oJLNfdHbYSkYRG9Cebv1c17mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176350; c=relaxed/simple;
	bh=LCFB12z6scQ+ae2dL7dad5g7aifAW8FuFUG06zQCfWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCcUUWX23rsN2RiTM9i+QEvin1snIbhP4l2dPiuCYWyfodjI/bz0Yx/iFNGME3uicRKEf44OLar9OjpBvOWZIZ3PlbrdRh3Rrk77VH8DVTCBuqbg4iQdRuybQX3O9EpTSZUqpaUJX7ZhemXl+tDDpUiFmIsoUgo8joN68caI/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-47de008b020so133605f8f.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176346; x=1785781146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fi0WlZV11A3w9tLPVBtDdauyjxFE6/gukfGCcACwmM=;
        b=CYGi5WmICLfItUhiIBuMNuf0cSraKx5ZJvEB8FEh4iSB053cL1bDq89bFh/PItyihj
         MM5wUGjyVT0luUIr6ugXY6rcvHhN23j6dENc8VyeH/zJexDJ3VhmKCnlZEwPDWtTJBqM
         fIeHMeraqQHWK/6cgNGc8JZkZYiJEWhZ5Z6dDpi/+X3GCrr3BKjHduQs8ru4IsSFKgWu
         +wYs8f/QRJMp1OevQn0qg1Ck1JUz/E5puOAfonMJ3ndyFmP8+OR+T/ywvuPVBV88bDyp
         fUzBpShhUtTnm9ndX+tOy7qEysWaA2yNddOAjOk0gsbQv0PkyE352cDaUuIpz3H1qewR
         /+QA==
X-Forwarded-Encrypted: i=1; AHgh+RrENsTBUC13cW1l5eXwKdhCVRJ2CGsPygcpSLbDaD0V3ICvi2dSl4a0OeeAa3XCSKGrdbB3eoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4H1+yxG50N8+I/gEWYDd05UIoQyTFOYxUCf9DcxnRwONaaEz1
	0UfYEtvZs99dEj/9782iStenkFqwKRnawwlIirnlUFamccZKvF/GA9sH
X-Gm-Gg: AR+sD11jrWniC+f3UstZK9oUkQY8pS/VkgHrXFZ0GaP530KL5/vBH5P8meej6zoQH3n
	cLbBppa+csxOsSTStqbA4PHnthlOY56r6iQ17/0sxsa4IVQAe7FpoPk2zlaU8basnzQi4OrrNRM
	JmqlrLuIdIb8V35tJzfAU9XaxRdu1M8SS3hIb5I7VGjdAWjjdlT9ClpRtP3+J9CJTER6tKTfNOT
	CJardfLy5Ajv689+AqG/DTTIVCfxYTAxgalEd0G7DZq9AD15Jye76bsQ4SJbpbfIY2E7xfao8eu
	OuJuSl5qGdKPOmlhslfVdE81OSScLEFaVkNCm65Kg3rcyR+NZec+O3U55CQa8RyrG9bMiyv61v5
	QYis/GvavYIFGIF2SeyXqvrjk1sGW6sRSuleyclx5EAe9UkDk2ybAIrygJJ2RtumzUnqkTdAj48
	ZAFxjvsc6a1gDCBV5x9/CEwopNKitmRruXmEiU1vmubl8=
X-Received: by 2002:a05:6000:2c0f:b0:47f:9275:b20b with SMTP id ffacd0b85a97d-47faf5b4abcmr684092f8f.26.1785176346147;
        Mon, 27 Jul 2026 11:19:06 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm51042855f8f.23.2026.07.27.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:19:05 -0700 (PDT)
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
Subject: [PATCH net 1/2] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Mon, 27 Jul 2026 20:18:30 +0200
Message-ID: <20260727181851.306076-2-i.maximets@ovn.org>
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
---
 net/openvswitch/actions.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 513fca6a8e8a..5653b6642e10 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1108,6 +1108,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1118,8 +1122,12 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				ovs_kfree_skb_reason(skb,
+						     OVS_DROP_ACTION_ERROR);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 
-- 
2.55.0

