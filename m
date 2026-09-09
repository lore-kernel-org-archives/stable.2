Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9153446C0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980981; cv=none; b=tKmTrpaWfSw2/iAFxWNu4mvPRlQQrMFMWJ/yZecpGBhDR7EVWx5f5eqcJSr+bGRoTXkckxA/J7G3JcfiGgc5m6Dn3OwwNah68cbP32bHxX+mCrJ41Ahs0x94NdbIxFkiP8gjTbICAyYwTulGBCpJnEXoP1Y5Q/tGbQswxCd2gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980981; c=relaxed/simple;
	bh=Fv3YpE8rn69mWc0+unxV7FtgBOidj7x7HoAetoSXXg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbahvKARTuKgCDqsVe5iz7n7KcilJjrqyYjT+Ek63HwvsuryuDi9WmuHxXdCvFmB8N8C1FzpAQL9nVArm+hPlDKKXuVcgtm93kgHioya6tEOCcNMp1Tae2h6pyqpW89p465TQRfPMIVQV5/2BVxJFWPsOXjZiXuESeZu7oFxw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp3Oqo3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp3Oqo3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD7E1F00899;
	Wed,  9 Sep 2026 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980979;
	bh=DJhnqDx16/SgEalbuLaN+0EvsIDfrdAcEFJ4f9IKass=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wp3Oqo3a09sHcnPWKXo3W74LLVuidWVEiQRUufbACfsN0tmYoyi05ULlLfN2vIvVE
	 Ph3AvgIdxPe6hBl66TR8CgKRp9DAr/fsqucwblYTZX1/3s/ztpTSOWwsB+bnk7kDxy
	 ADmbt4b6bMzx9Z9MhEDlxAuXLjk2/nDbG7zFeh1nS9oZtMsZkdODZUB5sgZRzb1CwL
	 dlY0TwTD4CXxieh8Owzz/5n2cpfJtKNhihmREM0YnaoeESEKT2y1XM/3+bFJXWwtLA
	 PDKrnSgjc9XIIzDF/eSwtd1zyT2M5KvQMtQtxMZVrRCMTpga9yT2EIVToV8cl1MROo
	 nZAUmMGrPl69w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net/smc: stop killed, freed and out_of_sync sharing a byte
Date: Wed,  9 Sep 2026 15:09:35 -0400
Message-ID: <20260909190935.3545815-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190935.3545815-1-sashal@kernel.org>
References: <2026090313-litter-deputize-53d5@gregkh>
 <20260909190935.3545815-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hidayath Khan <hidayath@linux.ibm.com>

[ Upstream commit db51a8658c11a82432b64999519a269c3aabb447 ]

The three connection state flags are single-bit bitfields, so they occupy
one byte of struct smc_connection and every store to one is a
read-modify-write of the other two:

    u8  killed : 1;
    u8  freed : 1;
    u8  out_of_sync : 1;

They are not written under a common lock. smc_cdc_msg_validate() sets
out_of_sync from the receive tasklet, while smc_conn_kill() sets killed
from process context under lock_sock(), and the receive path does not defer
to the backlog when the socket is owned -- smc_cdc_msg_recv() takes only
bh_lock_sock().

Give each flag its own byte so a store no longer touches its neighbours.
All readers test them as booleans and are unchanged. struct smc_connection
grows by two bytes.

Fixes: b286a0651e44 ("net/smc: handle incoming CDC validation message")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260820074642.966856-2-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1153dfaaca71d..aee665bd03f14 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -216,9 +216,9 @@ struct smc_connection {
 						 * 0 for SMC-R, 32 for SMC-D
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
-	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termination */
-	u8			out_of_sync : 1; /* out of sync with peer */
+	u8			killed;		/* abnormal termination */
+	u8			freed;		/* normal termination */
+	u8			out_of_sync;	/* out of sync with peer */
 };
 
 struct smc_sock {				/* smc sock container */
-- 
2.53.0

