Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001C3D5C26
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945974; cv=none; b=Bn2lXwflL3rNtVsSSmtGOVkv+F+GleW+7I2N0xVKtj30JzzW1fpaAZxcMiLQWpHZPkGVGZ8oMh0msMhHenafeGCleU0jE5ZRgTLMyw9BqxqNk/BNI3B3PnHTGjAJ6PIH68+jXmuh/Oktj07bfya9HORTGZ8BytMhGp7pHKPWOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945974; c=relaxed/simple;
	bh=melWLkCuf2kqUkkcKAdsE32vTrMM4BRZv4D04t5AoVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQZII5ha6//OJPIW4aVp3qIf92xty/t7pT4BhTV2idZvGGCJ/EMNpG+qJV4pJEvgMwyu80+XUCYKQVne34Qqa6TTBIyjuetlFg3+Zc/MRveR0MBosh9MDLKUvz7auEv7kPPMSi9AQI/cs8WQnkeGwZyCI1mapr3GdHeW8u2xaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLhwgSPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLhwgSPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A792D1F00A3D;
	Wed,  9 Sep 2026 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945973;
	bh=/F74M9plKMcOYXior4ER3ymGV1tXRWaFLzGsDC5KfNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLhwgSPSPRBI3DGRTEziXsFgaLNQOt5LLv/1umiiQRK7oz7vTy7y/pckiytakFXE1
	 QWbRffejVzmkiaPJy+aln73ITvDgKKepvo1P4/yTbqVUfCnk8Eq+n6U8TlvW3ASBl0
	 SEHJta7rl9LEVXcGDN/dmzSUJDpMIfA3MDXmIIRIDYrR3NZCN9QbOcl787VpKutdUI
	 CsDJwlmbcZQpTb7VaNFoOoXjA3F3lAwZMHpcofLcbZBwwh9hHp9/atgb4jLap0iqNd
	 IftPeXg/TiINSA09prUAo7npPhSqAun2vNOAG/g0w582MguKmdEnRVmvSdE7JD53Gm
	 ZmaFV8pp3gaHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linkai Gong <gonglinkai@kylinos.cn>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: fnic: Use GFP_ATOMIC for VLAN alloc under spinlock
Date: Wed,  9 Sep 2026 05:26:10 -0400
Message-ID: <20260909092611.1293600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090300-shirt-frown-80ad@gregkh>
References: <2026090300-shirt-frown-80ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linkai Gong <gonglinkai@kylinos.cn>

[ Upstream commit 9639c6324524ea3f934908bd51f02430000954ab ]

fnic_fcoe_process_vlan_resp() allocates a VLAN descriptor with
kzalloc_obj() (default GFP_KERNEL) while holding vlans_lock via
spin_lock_irqsave(). GFP_KERNEL may sleep, which is not allowed in this
atomic context and can trigger a sleeping-from-invalid-context warning
or deadlock.

Pass GFP_ATOMIC so the allocation is safe under the IRQ-safe spinlock.

Fixes: 098585aa8aca ("scsi: fnic: Add and integrate support for FIP")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>
Link: https://patch.msgid.link/20260731073820.16449-1-gonglinkai@kylinos.cn
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ adapted kzalloc_obj(*vlan, GFP_ATOMIC) to kzalloc(sizeof(*vlan), GFP_ATOMIC). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index ce62ab1180bd7..e08a4f5ac2176 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -139,7 +139,7 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num,
 				     "process_vlan_resp: FIP VLAN %d\n", vid);
-			vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
+			vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 
 			if (!vlan) {
 				/* retry from timer */
-- 
2.53.0

