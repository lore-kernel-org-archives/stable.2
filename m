Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18C2EDD70
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504165; cv=none; b=enA0EqGbto9S0dNzbH2yR7eK6RDTJLxi495idBNNdRtHMv9BrTiG7K/AkPVdBExb8TWrpFR6NFmHWxZ9zPVzsoKpsaSbPJHKadwmS6/j/Jg2DEcLr9JV4jb6VDOXvVhAOYklD5iHssTih1V4sYzV4g5jqgKBNQ6Nk+vtuvummlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504165; c=relaxed/simple;
	bh=68V5rOqPNK3FVglsigFb/BFRax3Z0p2704n/K6dXm2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5QEDdIQh71VJV06OjHb79gz/wnizav8qfGJfbhxMJkjnzBOvef3uGKX+NQcF+7ItHQy/c8p9RpgwaXyuhXgkQ+Di8+KLic9g4pWAIj0BPUKtDVsIbl0V0lJmX9EFE4sJHGm/Ydztxo8bETQ+b9czgwVBDuK0OGRdZ0xgWGWCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LeCjvNrh; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LeCjvNrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504103;
	bh=OFcL2qU1SwskXFKzrfd2h3zC4Kiqeut2hQ5lpB57irE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LeCjvNrhZpi6dvHrrGBxEyTxUXoMFFzhOqNnG5maVoYcp7JEpoalGwag2h9RHwspJ
	 0CZ1Zbu69wCMNXu3gUNldL4lt/gliu+0XkwTX7MtAggDm2qgDLJb1SnPtKHTVYYCQu
	 tC9knZekU9QRd6V427k82hLAzBO8wvWiKn94rJaw=
X-QQ-mid: zesmtpgz3t1783504097ta09c7de5
X-QQ-Originating-IP: vACJNgUoWWkdWhtSp+Sdhnf+wI82HAqynSl6LwuPhzg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:48:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2046046456992337298
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 03/11] bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
Date: Wed,  8 Jul 2026 17:47:06 +0800
Message-Id: <20260708094710.27047-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NbAqzpwV8myl6G0oQv4muJvlNtzQlkm7ofF0KSWKLMcIMgQCQ0ef9Ju5
	VYqoGE8L1f6kpCtq4MQ1oSn86jhGVsmvXFnFvh9JQSe9zcxWXBVi8vtL/L8WiPwMrFfYxWu
	lEAEK/XBsrK6mHnDDwcaJyNrEZX4QppBrLmz4JC5+fwY+Ri7Nb1FPpDuSrUC6WxOIoXQnhj
	Mx9MvBvfCLTzy7uvstU56bxjfS87Rs8BX+TajaYJG8EjInLIWlaQy+5Ve2lmDC9GYeI0/Tu
	WJQ5+imXuM305W1tau0lWP2xgTtPIx6qR9bxJiNGx01/O3JEMnJ61tWtduW2SgaEWLXLuMv
	j3yPGO2pO8SNsKp5C3AriWjAcWNIkspdVFLXECR/90GOqzialjc0lHUIu7zUwfFmtG22Fir
	KjrTwdex8cLE5hvkMUV5zehtVW75Rf6swcm//XpMAElLGCRIWZYfE9OrhWaWHF/C1BENJtb
	c5hZXiu9DuZGXYeja1O0nOVr4Hm/df1b/zCkoXANVYCx5yWtBDn8U0MXowaZGtcIJ6j08Kp
	cs0Qj39ThlYr1ERWeYVjbTFFkddU8wtDvTTrhmeh4koPxd88+PoprvvGBng9JSzR6cI4g1O
	amjAvHECimVNfhDR+kS0qjacbSNS05SY5Z5PgqwpjQDrH5YBSwPwYWThg4Ef9AUuTnwYfLd
	dvUoY3p14YR0emLlvqap1WgdbdY0A0I8IqUQHNhCIKS0UIlOKB9QZtlCqSqk7qTfYljaJiU
	lnOaMXuEjF1s/bVnosTCX2SpbpyQCw87+4nkdQmFdeXM5qokYzg0qCBsVcdrgyWyM+kQ8Uo
	0zdqDu+NXPbB27OqVpS/eonxbBoPTpS4j6tTEHQ+Apl6ETXu7Mlj+/8KSmUuvgEwEjZgSWJ
	LwNQ1CZR9e8YgfO8VwTt29STRQzqrR/+vowbZjY5/bTYyDTzH4Qg3DMDcVxqMjzJ8KOqcF+
	faD5CXdG1M3tTrW8OOE+Y2RChXjhSrHVtQA3VOD+0dKWIM7psJjJWdjttxDQ5KYB7TtkMQC
	fsHv0mraFUI7GPo6cMaYXtctSHBRkxZTi1hwCm1YCVlZo8odPUpEladbmOHaNjnnzalPSRG
	BULabFeDgLNoQtO3N/kQPg=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit d064ea7fe2a24938997b5e88e6b61cbb0a4bb906 ]

If a bonding device has slave devices, then the current logic to derive
the feature set for the master bond device is limited in that flags which
are fully supported by the underlying slave devices cannot be propagated
up to vlan devices which sit on top of bond devices. Instead, these get
blindly masked out via current NETIF_F_ALL_FOR_ALL logic.

vlan_features and mpls_features should reuse netdev_base_features() in
order derive the set in the same way as ndo_fix_features before iterating
through the slave devices to refine the feature set.

Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
Fixes: 2e770b507ccd ("net: bonding: Inherit MPLS features from slave devices")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241210141245.327886-2-daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 6069914e0f42c7783863577328b92a7de0bedc6b)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 36277bcefe290..d200909a75cfe 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1499,8 +1499,9 @@ static void bond_compute_features(struct bonding *bond)
 
 	if (!bond_has_slaves(bond))
 		goto done;
-	vlan_features &= NETIF_F_ALL_FOR_ALL;
-	mpls_features &= NETIF_F_ALL_FOR_ALL;
+
+	vlan_features = netdev_base_features(vlan_features);
+	mpls_features = netdev_base_features(mpls_features);
 
 	bond_for_each_slave(bond, slave, iter) {
 		vlan_features = netdev_increment_features(vlan_features,
-- 
2.30.2

