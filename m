Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7638655E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975303; cv=none; b=sw+GqhPFxb8sF2qyCkBAYobrzACLAcES6DSE6abXvCJVA81iVJFXY9yNCefDlhWVCe+HOzwiWuD8gKmZDmqLanF+eEs7pe+zZi6zgoKvU9doKmX42+JAA30tG9DPHi47J2xuXZt1vejQo+Q/Rm4tv2MHVXmQjlbiD4JeISx7TlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975303; c=relaxed/simple;
	bh=X8n/uoYvx/8YjcHiugo4sOTEA62BTjUr9POQ85xTZPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djW4hWxh0M2PaUrY5JjidSlmBArx07pvB0MFE6aU5EJLwgA8U4b7L/2idA/DHCMht/SZPAh6oeFLJqKUn089BFNWLLvkJ2XzDuAX/8edHR2zThIOtiDSa1o9NYa0ZI4r1ckZpWZzLVl5qBdSHZ1v5ptrwKoJ7Nc1FTb/6I/lKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG38lM5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG38lM5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D8B1F00893;
	Wed,  9 Sep 2026 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975302;
	bh=nsf5tCcNHVjgRC/tjFEZLJncNHjj3xdjc15WaQonMoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iG38lM5NuzJOb5TXm3e9euie90e0NOv0U8E7loW6Gg7KDgv9oxZ2A2k3Pj9FT1sHA
	 mY8i8O0BaGCvSox/j7q5nbPOtSvZYyxNXAGalkg4KpF4/u5UhxsLXjoHZHkE+OCs1T
	 Jxi2N9i7+U+1szEI4XFJ43qrkBo6xtWIpE5QRzzraLGxHw8DeHB7y6MwDW/s3+Qmq5
	 XzqwI2htP4RMOcFZ6KM51jpqakv1PpIIDDtUosw0bw50skW62V5bg0FUmphbMmz47M
	 3mCUBi6eafEd4Vn9LDamCRii9SoNCHcWpkFc9m59G0/4VBe1KcqLXwITfiuOku4dhS
	 w4KGHP39NmeAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net/smc: stop killed, freed and out_of_sync sharing a byte
Date: Wed,  9 Sep 2026 13:34:59 -0400
Message-ID: <20260909173459.3308094-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909173459.3308094-1-sashal@kernel.org>
References: <2026090312-cedar-failing-0a11@gregkh>
 <20260909173459.3308094-1-sashal@kernel.org>
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
index 366cd1a0b950e..b19f41e7e1171 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -238,9 +238,9 @@ struct smc_connection {
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

