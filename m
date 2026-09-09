Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C138C2A0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975149; cv=none; b=FomU4m7HITj3W18rdxjs4eXVuV0wkAj8mbpskBhbXVdlGVFfzbny2KL5GMRgh2p3SJD8SEUqiOqnVS8w07RgIut8tJGPDpuAozPRnA99jRSKpRJo+QzqBkutVZ23llLWUpaMypJkrAXYnYSaW1zSrQczkDQPf9bwZejjQL1wAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975149; c=relaxed/simple;
	bh=YMhp/mchI8V2lTQddDc5EXja7I2eFnpOywGXM9Z2eGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEFB0VJ0PXX7LrsgSkzA7hlw11hUdHvejXXxdHjodbVBuT5UcqY6rEoxbzz8FyqGvc4rhQyeH7ujDUYbCkm1XWSU6HIW4BtsKEOnKwdNTjayJBXQlpZCT1nxmsgs0Ei/5XJZNSpmexkfQcuW74bPiGUclRKuTDGUKFT3LCBzHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h94lzGk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h94lzGk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC6E1F00899;
	Wed,  9 Sep 2026 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975147;
	bh=rVopnMx1kG4IXYydEh4KRNCaAJeJzlaC2ozfJ/VkHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h94lzGk4W/byVbvp1iAqvB+oGeM2qQJ5NKQ4VG/5ozQbUMzM5A+hqfexhe2CQMGsQ
	 J0DUD6jZxv+IpIBiMop0hYLkdv/VXd/X1CDGCNay4UzmgmeNk3dq15eHHYajeeefFV
	 VBGLAoIYI1esHyRyxG1h2lQbV1KabZ9pRu5KSbuKVhLJ5keIZhUDJbB4Hx4g84/Rk0
	 VQ1XQueiBS9/RRc2ZbLNpGTBSGuN2pG2PqC8zY+4BvDCckNKfScmLrwGFmiUg2pi1T
	 9HgGzkiU8/k4LLtj13SSukCkgtsWz2vG0AiEGIoY1ny5Hee+Zff1yIrziirFOOb6BV
	 L8Lovwz2eiwAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net/smc: stop killed, freed and out_of_sync sharing a byte
Date: Wed,  9 Sep 2026 13:32:24 -0400
Message-ID: <20260909173224.3297067-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909173224.3297067-1-sashal@kernel.org>
References: <2026090312-corporal-discover-f40c@gregkh>
 <20260909173224.3297067-1-sashal@kernel.org>
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
index ea45467c11409..1425fd756d343 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -277,9 +277,9 @@ struct smc_connection {
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

