Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD054028CA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490353; cv=none; b=c1IF4142Uc/Cj7bZOuzLWvS3+1CAznjXWzMBcBAxzPjQLFzWHR3kNzQ6jlF2kQINwSgSJKw7zmqCDOcqTvsyOo/2q7AP1MB6K8vlydOz0Oz0MNBAuuHps52OgLcHkyKo4LPqgFUV6cE5D3kaH+/biUcTFrIqgpdc0wK6hxhW6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490353; c=relaxed/simple;
	bh=PXTFLasdbor8sCU1RD8RI4t04idnaIPVCj4SCtEOxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmkHsc2pQIc0qFYAgqTR5j6UeYCKrMRk0a+ydiZ7Zcp0M32hvOEnEpYXwq0y9AwIYirEluZ4obuHNoL2cUt2VCiD1dQ1OrhpXaOXqVTv7FWrgafUhgbGBAQiNncQHSgaeEY85BReD9EH8utFnJmKmQlOhbcAflOBm8etZdo+6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TcSVzYHW; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="TcSVzYHW"
Received: by dvalin.narfation.org (Postfix) id 1C77C2045E;
	Fri, 26 Jun 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OSopJtj7ppYSjnEhqIsscCBXht2wUAZgGyIq+VEtIk=;
	b=TcSVzYHWZkAAMg9SS9b8R8I1+7zT+SAcLESluc+crPfefmsRJbrcv2akZV8HY1Ty8/h0eg
	suK3YDUy/4qHO/IzKhFPSE6geAGnqcJZuShR/c1VOUUqq/Q5ztr/IxiL6pSTA/hD304tvA
	zZyozPIPcekBrjuOBpWtCNRUDweGhys=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 06/26] batman-adv: tp_meter: fix fast recovery precondition
Date: Fri, 26 Jun 2026 18:12:05 +0200
Message-ID: <20260626161225.124839-7-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2b0d08f08ed3b2174f05c43089ec65f3543a025b upstream.

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e4f76c141af3e..77bc69573a562 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

