Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961244D6B2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625341; cv=none; b=O3BU6V/0lNbmyJJRs92JWuctZuQAlsiAfrKscnMKOMXzZkVwceXgkTqPELjfQprgSqStZe/V5R8hoZU75vZgfdsmeFakYyWSPwvtnuJJVBNvhOvnx873vWIm2Ni20opMIfb2z8i6RUNe1Nh/4SNP/CMKvaquxRHmua8XtLVwBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625341; c=relaxed/simple;
	bh=FHyn7VEuIK6Tq42xdDfHnfMaLSY5qOQoWiKTDRss06g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U23cbdGqFQQ0vQZP3v0VxwkLJmgvaKNCDVO7ry95YNEgans/CD4Ak94aJifIuMHoJTms2Z47RuHLY2hruMdb7u9IENSrpgwZ+GPsNrFltVEinUZQr2eqi9fJndgKiDzUSNb559/IDRnX4cP9qp3w2vBeonmBU/1CNRZN3H3KEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U299z58t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U299z58t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BC1F00A3E;
	Tue, 16 Jun 2026 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625340;
	bh=NoAsVgVwoZg2nUHsuYG4zWtkjhTi4BQDreshzTA75qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U299z58tacFsSoFAqyBlgy8+AZ1q71JXgGCPtfkuSgHDY3lCbXROZxi+GBFC/qKaI
	 1hmtnwhbzk0+lQaJztbvP+pfDZq1bixgkLQiy2MoD0oaZ1tsthpl9SJIegz1anAnX4
	 RUWQ8Q7X5IJVc4J6WHmYd4FH3wB2tGiK87a5meMeUKJpnXxoJoqGthHeNXd8fMFLkc
	 utJ6YR7CmdYLMtOEIs8Fdbn4ASiG1wKQ9Q+/7BWQ1SaETyTu1J4FZosG57XRgEYgYZ
	 H2VvrK6dJeRIvdF/A5GnSv3dEAtIelzkJAYLbmk4/z7DUHG1LL7xfXY9R4sc6hM9tO
	 7Vqxx+VglaKLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] bnxt_en: Modify bnxt_disable_int_sync() to be called more than once.
Date: Tue, 16 Jun 2026 11:55:37 -0400
Message-ID: <20260616155538.3323509-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061544-stony-launder-1952@gregkh>
References: <2026061544-stony-launder-1952@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 38290e37297087f7ea3ef7904b8f185d77c42976 ]

In the event of a fatal firmware error, we want to disable IRQ early
in the recovery sequence.  This change will allow it to be called
safely again as part of the normal shutdown sequence.

Reviewed-by: Edwin Peer <edwin.peer@broadcom.com>
Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d930276f2cdd ("bnxt_en: Fix NULL pointer dereference")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fd54a194a5e5fe..ff14c44b8f2bb3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4382,6 +4382,9 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
+	if (!bp->irq_tbl)
+		return;
+
 	atomic_inc(&bp->intr_sem);
 
 	bnxt_disable_int(bp);
-- 
2.53.0

