Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13516352017
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254814; cv=none; b=eE+RRUemorFo7kKt+MEEUxFvAfr1tj3l5Jp/BBeGIcDU1ou9RBFfx91E1ntpXFebkxI8l+laSnT21O0pU+FHUAV+u831TbDejASIe31/iJthUK28+fOGE5lJlg9Py/4vaENjupUl2xVag4czCXX6j/DvJGpIP8IR17djIBgL5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254814; c=relaxed/simple;
	bh=b1Ef7m01SlvbqYksVxxjRq3JiNuZbQ9XJSkONcITG2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXkoUKfRR1p4y9nxBAVd5d9/Q2vMEYgtzPFq68+HqrVh8T3I/wM38yLj0sp9oa7Ex2FgkDebrmuC2E6+Ie9q49ho0OgO/wf9w3kFN+DCfc2SkWmPMnsoUqmtMflgjufMv4ciEF6b5klYoJecMn6QcrPnsh26DqxlopFzbHm+yqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csT6t/ve; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csT6t/ve"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8434840cea8so371307b3a.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254812; x=1781859612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am9un3Mpyi4zgWESM9WSZJ/9n4NAc/vveWguadq2LnY=;
        b=csT6t/veI9lYyoxo+o4M26sc7eObWSVqBuM4P1YzcJq90dMpzaN9wjYNGCC73kzxqe
         yHfM92J+TcObWIwCIbRbPvckqsOn/Ydr3npyaQRcp/ogN+PSUzyHyVeXjWnr+yW+PgBx
         DlDNSjBL/G4mAzHynrm1l6bwn842YVsyjQwij+BLOF15V/thrhlC67SH4fumujEyz5G9
         81DZywt1+H1HJvpQHAB/ZFBt3jVPitHog08VCpiPuYja3WCeHNuuOkcOh81tblqs1TXJ
         6YbXbWp9zo0VIE7EN9uGAss5M/Qk68Eod+BZ80l2VVwfFMPmge9WiCzpOMYIncvH2Cop
         8qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254812; x=1781859612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=am9un3Mpyi4zgWESM9WSZJ/9n4NAc/vveWguadq2LnY=;
        b=NxHrQ7uq2l/1eJTMUJdKtHg5TguhmaVW9LwV7GdE33P9goJSjGIfMQdwPPr3TsOn1I
         4Oz6JdTr77tfAD6ZshqKefjwZNyMgcHSOX2U89t+iO/pS3AWe0JPnRu+RpEYzHaqVGzn
         RIkMlEEAtr9xyJGv2qKJ8EE2IZ5uCorPxFqtAOxGlruS1V7VX0D5ZD6PS5DOF6wkFMwo
         Edlg7CQ9CMrsg9yM3y2cRSeqJ1Rf5Fh9x39OPJ1pi2N1UGZ7uNDZcrbLvsfUZ/nEwNN7
         zBQPTG3RnsQrpaY2R7t1B0mfIC7nMSPuBQ3YccdamYgh3Ev5hYxFGrQ2JSPbIIJncqeA
         5A7A==
X-Forwarded-Encrypted: i=1; AFNElJ+bQfth+Ir9ZFv9OTUbcVljnyKzNYeAiHY3gzWCnTjSfpAMfFfGSZVQrGXwz4g/IPllwqmTMtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMko6EH6LCRl0Q+vgco163SnWk9cHD2rkVPMHp4go7kGcOeACU
	sM5gIPePCcCVdUNths6Yq60tffvtZv9q10y+x+WjYYbSTV4Kcqw9CLdH
X-Gm-Gg: Acq92OHA1ELIQVh09jn9Tbwj/BUlxRQKKxWBzrnaGDn6cHJtKV4ats8dwqJ38qkA6x0
	iIqMQii9+J1EAqnYZmn+ldzgtFqu17T1DRuZaqtigWq4iLQafeV70uqt0YX94WVDZiZ050XLfQd
	hLPuJ3YNNUbYUgFiy9sKtzZbfbDAhO+sBZf+pZIy5KcAZLNAC8wE/drsncPaswrszbhxkjj5rwT
	iH9yqs1YvUeW3NKCVAs2yzXhP4BLU8oGF0wtZlp+XG8gVGKj0/3MUPcmYR5VL3m0nqNoqDmNal2
	D8Ptg71XUKmDhqObLp+2Nfj1fO3UcJ7L1lIem3SGba38wDuBQO0Po/e9t3Mcvz0zUXvqBKBiYIe
	fcCDECBNHeGxxJVMkeoEt1iPdpql4ru+K4sZDhEwfx4KQa6iQ2zG8F/cdakqWT058FCFYQzf176
	T6Wk78HLaIKZJyRbUvXyCf8TFxvbU4n3tMbgGuZtSnk1Gcu/Qp1y9JZg4ms8c=
X-Received: by 2002:a05:6a00:2354:b0:835:3f51:730e with SMTP id d2e1a72fcca58-8434cd24381mr2048514b3a.13.1781254812154;
        Fri, 12 Jun 2026 02:00:12 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:11 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:41 +0800
Message-Id: <20260612085941.3158249-8-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrmi_changelink() operates on at most two netns, dev_net(dev) and the
interface link netns xi->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in xi->net can rewrite an interface that
lives in xi->net.

Gate xfrmi_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/xfrm/xfrm_interface_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..688306bf62c5 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1

