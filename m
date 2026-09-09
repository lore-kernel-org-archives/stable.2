Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310493B0AE2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981230; cv=none; b=WoA4Q6pa17qInZNYtkieiIeCY5q+Tu2JUpfV2UdCG+jZDnBGl4lwXvpoR9OkjyIScZg8kMvcJn9lovFKaEjc7re1euXREK/qE/0/EXT8be5cJmCRqN3JvNFhYaPHtekaQuO+auuh7BpYlZ4TGrPBFD1TBwe2sixOeouC7IkJxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981230; c=relaxed/simple;
	bh=favPHhVYVt4mLEsWNumCMxQZrde/3z0ED2pIhO+EszA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpDMJt5VW5QpV0cbFbJW16zTveuos90CwTyht5GpABbiTQIcYGFv9MxZpFUQuPPcUY1iuReqi+9VNqIHVo/lfDNPloAOhTCZ+Vs3VKyC2UYtTTtlGelII1iG6gnPZn4RzG9ZKgbmLmCNavOIp5yd4Ky12a78lPemof8cgAHRRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp9D3FUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp9D3FUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029EE1F00899;
	Wed,  9 Sep 2026 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981228;
	bh=7nGRJw4bGDYG4J+nC8kiTUtM0e5GPGPYM/9tSHRnw3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mp9D3FUEDQks5sbaXgzafvErHLfeJv9sjT+nYAzwP1wZ1A/GWZg+HdCxKvsnYmEQa
	 68brUPQeiBJSzhpZmJOfcFKcMX5+MLgFTAvdB3T/U17scv2QGeGyC13K6IAy4sB65w
	 /ZlY7CI4I7lRPoMnj1/+ZUvBI6g5WGw2GwVxGsKQfLrN6DZGF6MPnj/JuUW5W7kgej
	 Vgp1YjfLG+2nVkMG0kObBiITBaLo8xweWyHslvNhCdf1Hs3PtP06IbCI7mwnqLDdd6
	 vAyDrDI1Ll+bjrkzGsyLgukvzGsnZgwKtFUsgJcP9AX5A2gJ0fmv0XEThjNp/dkXTJ
	 EBqopLCFsoTrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net/smc: stop killed, freed and out_of_sync sharing a byte
Date: Wed,  9 Sep 2026 15:13:44 -0400
Message-ID: <20260909191344.3552138-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191344.3552138-1-sashal@kernel.org>
References: <2026090314-stumble-payback-2ef5@gregkh>
 <20260909191344.3552138-1-sashal@kernel.org>
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
index 50c2b0ecf9dc5..14d22bfe7df9f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -210,9 +210,9 @@ struct smc_connection {
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

