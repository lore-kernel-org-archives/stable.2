Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585910;
	b=cmPr7vU8mPtpuuPPy6bSLGUbzDgAVejNL+mmvmss9YzZSir0QyLE2BpvTh7kCc4uXYlY
	 B4vkktwM5tbXKVo67Zvj9YWdsutuyZo4YMUDRV7/ujnY2CTZWVAEg3D6t52dIZfh166Yr
	 cCE5ndt9LkTrf/N5Y8rdL9vqjzU9j1vruSG+UPo2nYLiLVxyU9i7Dz/OLqREftwXnmgpZ
	 2TzPvCqcUhii5o9kjKxCiZzQ8y4+9drY+k+xh7dBHbYqugwJhx9Ppa7jPfMxMIL3LvlyD
	 bWF8INR9fbKOBURsqgjlxMRutX4jaZMREAOE1ajJQ8MQpH6zVuKN/z8Ev3qVja5A4Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585910;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LzpH6ZlFtWx3iq/V4Ca3j+tPjclLZq1yC4pTJfDWRc8=;
	b=BwKhXK5No52c8sEcV9cVdHYzC9SvrETFHIsqdH2ASXFlbp0q+nKU2HuNA1kwdqYEnRws
	 jg1eUtWQyMZVrpul3xiGlXMwRsM8fYme8vjtuVoiEKfaEJxg05TdGKaWKxPTtN62JdMEk
	 51CKE/Tjb5bysTwlqE/PSsSbClr1YQ36Zwvfwf7XNqRt+ly++4c9ueFE339Wn8w/Zj947
	 VfMcXOdYi+76ZhcxJS2XtmyOjYG8sxoe8Wn+53S0K+9AubuDeqNRtROEryfllp4ZpAprf
	 VfILQCxtnGKBVFaVpj3XJ4hP/QqIRmUPKKAoqstzMweAQOScDiGNB0jgyxhcB1QMytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=S6zdqfib;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB2606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CB2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=S6zdqfib
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793585906;
	bh=LzpH6ZlFtWx3iq/V4Ca3j+tPjclLZq1yC4pTJfDWRc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6zdqfibLP8H6Zdr9umZyiK2q3aifHaVmVT+mJIwGHRyMZ1iwn8x6OiBXEUOw3Q0s
	 FBF4FEs6/dP2rlHkxmArRQC1L8rDn7rcPl1qe9+b5V8H5GAlUIo7XPCEeSGPowGkiL
	 cD14CqSnLHr6RgSyXe5wiJQwzyATBjQmczsDcG/0=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.151])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 496A20BF; Mon, 02 Nov 2026 10:18:22 +0800
X-QQ-mid: xmsmtpt1793585902tmd4v4x7m
Message-ID: <tencent_F82F58C2455AF9A94D4C0FD52495CAD72308@qq.com>
X-QQ-XMAILINFO: NiqzJuKCE4mBRyz1QDXp2j/ZkT+xuxIe05NGxcYlTGV8GEezSHfKoryJkXsZJB
	 1llyNa6yFZVVAWVwGw2fcqVeLmCNexacwb9sjrqMnP1KNLc2zgrOakwYCyeU0NKEalvdlbVslc4A
	 JQVh0rwZKlLhZ2D8ivvJ6iGPrQLLdGqREiDVaS//QGSItB0EY6IR+lrtvJ5Q98HWxEtBKmmGX6Uq
	 M+bd/HUqom9qy+6Nqnu9xEQ73N+vIYg0gVIEp8ONZF6VOm/skfCLnMaxa11Y+2Mc5WGpCOrxp9M9
	 YUswaPHdYazWoLHqPd6cXZoOnVhuyW1o3puWAppADPw532wOt+QKtb+rVAb6s5H5lYabvq0hSpe8
	 jzRQfAeCkWmkGSSPkPGeGMJ4e6fWkSELkpzlJVA/S3TVkzGlsl2JnKW/biFAfmWtK1/qsxbU2w29
	 EsO3nDwVNeHNdCO8jGJjapLHkII/0fDa4U1hQq0dsg1n3zjHraJQgbWtvMo+ho681zTOSrFgDf+N
	 GMDHMPr8Fksc+V0qg69mY/G2gjZpY2gAjJg+m4Uthzs681jKtUrCM6SyBQRwj22gqo3ND7mB/waj
	 p00aTFP1v9lcFTDv8EXCVVvKX61jp/22RJjg9WB+QqutSo959MJD7C1R2L0kb31hGgAs0YZACt2l
	 eNAGqHumSaVelopu/qC+DxQe2LORC7qgtzqywZ92cu3um258yLASOCGGqhwNsMjeH2UCobJSt19M
	 CkrX8JsDMnozeYutGbrTc4Ja+c5lWTv+jrCDjcrq6ly2mfsSsOOcG3q81TqWkTh3AwO5gUNT1QCr
	 3xMH9loKXjkv3+z88I+4uFZk2F7Em7Rn7jtp0EWiJS90NEEPc5nBMaMmpXpyFaYhCeg7aO4O2inO
	 N8f3TOSaMNcwZFITlFIhu2fKBFXqyYHr6/hbxcBn7k5Q9jvT4dyQsqUP5d4xPi9JmnVfrX6tbcCS
	 qVXGc//tb+iFT7PeODR4/LyswXItgIkYnjfjlZqKanvbhkcagXa6V2PLaOvNbJFRRj9Qs7t43G66
	 CjnKe8OwAvJCWs4OMXMAIy2jNeSwjwkYh/nIN9+TPaiaDFKebLMWuIF1vWBLegcXQdpV6xVNTzkI
	 dTkdXjTKso12NDPMB0gTLcPslB+Y3uWM7lbE32xr8GXRLs4VM5xN14dD1hAFGiJsJlQs4tUDRx8Y
	 UkXu4lMyler4tHSn6EBUv3t0bObpYaT2K3sN0CCsyJ5RxxMgs9b2BDJeKiPFxmlZHYHU4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: bo cao <treebacker@foxmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	treebacker@foxmail.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net v4] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Mon,  2 Nov 2026 10:18:22 +0800
X-OQ-MSGID: <20261102021822.91796-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179358500215.3286.12801503551646664009@kernel.org>
References: <179358500215.3286.12801503551646664009@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies -- this information was already provided in the v3 thread,
and it was my oversight not to carry it into the v4 commit message as
the bot had asked.  It will be included in the commit message of any
future revision.

As replied on the v3 thread:

The issue was found during an LLM-assisted source audit of the IPv6
fragmentation path (manual code inspection with an LLM's help, not a
production hit or a syzbot report).

It was then verified at runtime with a standalone reproducer: a
single sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg
and IPV6_MTU set to fragheaderlen + 1 triggers the skb_over_panic()
described in the commit message (tested on 6.x, MSG_MORE on a device
without NETIF_F_SG).  The xfrm transport-mode variant from the v2
discussion was identified the same way, by inspection of the
ip6_append_data_mtu() recompute path.

bo cao

