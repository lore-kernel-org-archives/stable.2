Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F43290DB
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955599; cv=none; b=csj0+yPyrHXT4vwMAIJFCFKYCxYeSti8kdCPX8aeLh0RFE3zeOdEcp5oPC5h9PQp1OkRiEZ6MvIk/2rlhBq0KAAGvM34Cdfzt9BL/YX1jlpkWRopaTIYWinKs9mdaG0IEnmC/4ZEKRSTh8cH1Wg7OZWAaEhzNYOCyoN8hYjx580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955599; c=relaxed/simple;
	bh=52IBy1BJuzvTZDxziuf9dk+dFSrRNgB01jHdwF9uJm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CL4wNMpffC55QkK80CY9ZunpMCXsJiJQNaunDjWqyAh0FNkcBdJJwvmb2cuKQbGPdNzNxTIhR2BgxqoqsFiIzlQUAfYWFsl1OCA5gsPaZeHxzbTT4SrNG9J+PHMregVx8cjqQnEnym0mShMn/5VlmfCwPD7VrgIzWWQ8qNTicJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AAttWLSz; arc=none smtp.client-ip=95.215.58.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AAttWLSz"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=52IBy1BJuzvTZDxziuf9dk+dFSrRNgB01jHdwF9uJm0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786955595; v=1; x=1787560395;
 b=AAttWLSz9xAhqw5pyEfsT5DlqYGzBVs8keHCfAQJ1Qtqhcqzf2Y3bxLOguC3AreKzF7H8q/p
 MH4HaAP6YWe8b3eNNaNk2s9bivq45K70hf3PM2DvEyjHWQFkymJEq8xWajieYiVDLDxUAtHgWWh
 UgRPNskqvyAD9ee7450FOhHA=
X-Envelope-To: stable@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.150)
	by smtp.migadu.com with ESMTPS id caaa19c7febc858b;
	Mon, 17 Aug 2026 08:33:15 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH 0/2] bonding: 3ad: fix 2 RCU issues in ad_mux_machine()
Date: Mon, 17 Aug 2026 16:32:35 +0800
Message-Id: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3aT8vJT4ouRSXdMUS8s0MxNTE/MkcyWg8oKi1LTMCrBR0bG1tQA
 s5u+FWgAAAA==
X-Change-ID: 20260806-bond_rcu-5d99f64547b7
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series addresses a NULL pointer dereference in ad_mux_machine()
when ad_port_selection_logic() detaches a port from its aggregator
but does not assign a replacement.

Patch 1 adds an early null aggregator check in ad_mux_machine() to
prevent the oops. Patch 2 is a minor RCU fix that uses RCU_INIT_POINTER()
when initializing port->aggregator to NULL.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Hangbin Liu (2):
      bonding: 3ad: fix NULL pointer dereference in ad_mux_machine()
      bonding: 3ad: use RCU_INIT_POINTER for rcu pointer initialization

 drivers/net/bonding/bond_3ad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 44871eadd07a7f004aa00cb87399461eea08c630
change-id: 20260806-bond_rcu-5d99f64547b7

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

