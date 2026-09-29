Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074093D9027
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701502; cv=none; b=p41+n2TpsYtF1Zf9lxcZyY/gbdUG4NFJr5xNXHFORlYVmgnBK5JDVY0wKheaymUDiXLeDrwCMtMh7QGMsU2mwq1bPfGyiv2GEFEvgwy4gktiuR8Y1ov10XwCud64pWTj04U5GJFStRwLgG4iM6D9g2a1Rzg9vcThWsYDJQ51EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701502; c=relaxed/simple;
	bh=lSKhCVe2e9y67BQZBB8N5b0lo4u2NoSTarkPLG+MNOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRAjddsx0sBWIWPxOFIxHj0va8XCl/ck7RX0ZHIVhRR89UnVr7PeCJNVXRXzfllpVFf+CRJDb3pC4iM3JWrB1fcGHhJsptbN9/fMtHsIsa4P3myW1iDnlWeQ1uLBIjCdQR+i/ut+FxRYqF/QiLlvuy5Bo1nKwFGCOxzLoCzQA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndru4r+4; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndru4r+4"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so64429f8f.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790701498; x=1791306298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYlY+0VQmviH8AJ9O1JXprZTbqCcvurlza+Wbwy3a28=;
        b=ndru4r+45UlLvkt9Jo7mAfA/iJ8v4WnZjZ2imhAPMsweaAyPPZ86ESzXx/y/VZ/SZf
         eohcQnK1yuWRO7NqWW3sDAXmXDbXSTDfc0/RUjgIz/ZLRRawGplibykllKekjkniJQVJ
         jqkUe7DBa0wJNANEvipMCBx0kHIJ3FCTtPjFzeilJVc5sJ3HQDUnvyQmIv9C2nRbgb61
         wTqXFKnPPq+GIdJAHbQA02EeGfsJLQ95Ar+iMTG3QHl6FRWYivG59GP3LNY+o2WVlHEI
         3dJRcUONzTPSGEocddVslU2FhQgobnlJBn9TBtQRgFG2pECH3tT6VYBFIJI4i3HEIPpu
         VhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701498; x=1791306298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYlY+0VQmviH8AJ9O1JXprZTbqCcvurlza+Wbwy3a28=;
        b=tXLv9bzfPFE0TKsJYKxcbmQUVZsx/AaLWEd1dX+UqFBwaxkDhshJ3SW22bL/OMhhkc
         OWsnQX5Ys85PtKWo9I/b7yMa5dArQRiReHl4SBhwk9eRpRB/7WS8938Hg+QvSOvVGfUH
         CD4KO44EOuNLjh0XEtFJuxMNQ2RAIX6SbhJH3OAELP1WZ34AAxK23CdCPLnHkVawGOSd
         da+gpbZt6/T/qSVYrRh+ebXuEMdAh6rXbNf2ipA6WhXLIYiCV77t41zzf0SJvMDGFXQ+
         r6GJBDRHHINs3cpT9gx3egnpIZRmv1sK1L3khqID20pE6UXx2fCFJljt0WS9L6Qca7ji
         zCBw==
X-Forwarded-Encrypted: i=1; AKwUvBzRgHibPQQtSQsEqaB5oAQ4SrawkvFfvtCbjpCccXQc7D8pUDCsrblfRNYeYfoLVsX7hwNEOeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe2iSkHBlFTrJORqybwFLG5zlg39F85nRmUYZSI9aA6c1/Zlq9
	iD0mCN+qa+5tgGj1UhfEs57/APZdu9tNstE53ITwECdJycmicR7OlY88
X-Gm-Gg: AYBFou0AaYdLIzpOD2Nb2lfynFgA94SDtoc/+Ofolo75Ns9txxVZ0vubLrSmOroYiXN
	jrMNhwTLFMv+lmaKZyqWlUTdWfhYlf5V8lQPOvGca+khrE2a9JleHTlEhNkLD6vRuZmmBycMF3M
	gMmSkUHq8skNF08ije0lFhehMxB/7upNww+p0yahsXlEefwsWxzhPwhQctUNlKtI7CqEbOqglsA
	flTBBwnKCIsbuSYRiuf/O4X0ROJ5RwSnrl0RSPJKRGkx5zknnWUNO05j64QCqH+Y7kZyhkwj73k
	GjfeeAEEf8YAGrddjY14dzHCR5mnXQHeuYc7MZZCmZMEN3GjOho1Ox2HSZ+0pNobCVzD8ssrfO9
	PKM4pwn/MkBfNkYpEuCwsDjmUd6bdRiGQFaUF++ZWIzgrmYekgI4EGryVt6eCLywn+1os5yQZTX
	RhQxKJJrSDzxO33Vdypyu4OFmL3ZytODlktcw/vy7vk29MA7meUcsZ0Qj6fldo6Dfr69AiPD4NZ
	3nUFn4Z0xWjaQoEL8Z/tbguCvKPTex9enG68zT/2SuakWz3SFkorP8=
X-Received: by 2002:a05:6000:2204:b0:487:27f6:a4e5 with SMTP id ffacd0b85a97d-488716bd7ecmr33864013f8f.53.1790701498062;
        Tue, 29 Sep 2026 10:04:58 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe698525sm3243f8f.20.2026.09.29.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:04:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] rtnetlink: wait for RCU readers in rtnl_link_unregister()
Date: Tue, 29 Sep 2026 19:04:42 +0200
Message-ID: <20260929170444.218093-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
synchronize_srcu() and cleanup_srcu_struct() without first waiting for
RCU readers. A reader that found ops before list_del_rcu() and has not yet
taken ops->srcu is not waited for.

Such a reader then locks a cleaned-up srcu_struct and keeps using ops
after the module that owns it is gone. rtnl_newlink() and
rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
user that dumps links filtered by kind.

With delays added between the lookup and srcu_read_lock() in
rtnl_link_ops_get(), and before rtnl_link_ops_put() in
rtnl_dump_ifinfo(), running "ip link show type dummy" alongside
"rmmod dummy" on a KASAN kernel gives:

  BUG: KASAN: vmalloc-out-of-bounds in __srcu_read_unlock+0x57/0x70
  Read of size 8 at addr ffffffffc02ff318 by task ip/147
  Call Trace:
   __srcu_read_unlock+0x57/0x70
   rtnl_dump_ifinfo.cold+0x30/0x3b
   rtnl_dumpit+0x7a/0x1b0
   netlink_dump+0x486/0x11b0
   __netlink_dump_start+0x661/0x910
   rtnetlink_rcv_msg+0x611/0x9e0
   netlink_rcv_skb+0x126/0x380
   netlink_unicast+0x605/0x830
   netlink_sendmsg+0x6d0/0xbb0
   __sys_sendto+0x335/0x3a0

Call synchronize_rcu() before synchronize_srcu(), as
rtnl_af_unregister() already does. This should be enough because
rtnl_link_ops_get() is the only RCU walker of link_ops, and it takes
ops->srcu before rcu_read_unlock(), so every reader that found ops is
covered by synchronize_srcu() once the RCU grace period ends. The extra
grace period only costs time at module unload.

Readers and the writer were serialized by RTNL until link_ops got its
own mutex, which is why the missing RCU wait did not matter before.

Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index be9d1625bac31..abcd2c4ea2178 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,6 +707,7 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	list_del_rcu(&ops->list);
 	mutex_unlock(&link_ops_mutex);
 
+	synchronize_rcu();
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
 

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.53.0

