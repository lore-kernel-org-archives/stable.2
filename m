Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2F5519AA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979603; cv=none; b=lPcRUWdZ70xCRidOxmmuCeBAJcWgxrVXbHxFWNjnn5ae2VU41xFOal8/8cSKzASiw3Om90aBshS3PX+uy7mNBFt/wLSYX60T6GqK1ohsfmD15nRe0tbE3rWwIWdJNNM07HMIcYCUIomcWd7u2Hpl1P0X5rkZw/8JHwbIphV/JX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979603; c=relaxed/simple;
	bh=+oyxqFzqfMDcIsmsc4uQGYbyiAM3Odf+roDza8FdPKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDIXG2y9/B6HHYtkHcN5wDI2ZA38e2/H49BO0xIUHSK/wTOxcjNA/fRBJhroSqT/L9J36/Vua63NvdPEakxl6RDa2yFYkZR4BPXV8V4XBC27L2slYjvaiUVQcfapJ14jFbh29jW7+JehNA7SgCFTJGgQUBy1pnCgHMCuBXP6YYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQBlwEPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQBlwEPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2A21F00893;
	Wed,  9 Sep 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979601;
	bh=yf5BnI0KO8X/hzXL5/4r05iVet230BfI4sTFUiC9+LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQBlwEPnYEGBz5LmIDNYx4Bas7JpE7DWHbVK+/Wxq18QsDx/EPu4mGMXpXDjutDGT
	 QTM94zqUPi4VCZqRAT9FT6oXdOkK4P16LIKXayzptFS6w6qHsJZRRO8P6Aejie0sRN
	 PhgOGINWSEaIk+75uuz+U/PkYYOnz3nvZ2Hivo7nPIWXVGyWX9rhNIlelXANsHa1uC
	 NncDbz7DHcdqTJdeNxC8jE7t5NbVb3jQqa7m8/4nPZk3F/XmaSfkKuc+/TWAV8jY2k
	 Zao66dkb60dWk95k0WNXR6kRLSFVBSajVHk37iLFPhncbhVNvayIHU0LTenECw61ZZ
	 BRXaPRCk7M4ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net/smc: stop killed, freed and out_of_sync sharing a byte
Date: Wed,  9 Sep 2026 14:46:37 -0400
Message-ID: <20260909184637.3461682-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909184637.3461682-1-sashal@kernel.org>
References: <2026090313-resupply-paprika-8273@gregkh>
 <20260909184637.3461682-1-sashal@kernel.org>
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
index ed86e11949ef7..932241b325ac2 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -233,9 +233,9 @@ struct smc_connection {
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

