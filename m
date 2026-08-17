Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F06442FDE;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996450; cv=none; b=S9L6CaVOQa39jUdc0iIrgYm2uLoC0NdMonpLma/RBmD95gPLRJlkoJybrTGY2gkDiK7ztoBccpfzDN4MAbHA34qy+TPSgRMYLOUEntZ1UKCxlpKfD4+ltjbWAu276LyAFCtAq0OoHZT/PVPUY4NpiBbvK9+IWiLZVfRgSHk94os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996450; c=relaxed/simple;
	bh=+IqWwA2cdc2aw+WXnNBLXR5Jq6+YKLS5E0CzDhozjwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Si9rQ4gjVK648mjyYHTWoBFQ2pb7pkb//4MHL9FopMpQp/nKee3AJzDRkZKh2EcMT28FJo/616Mjj7/bTFKrmw6s5Ia/e5gunVGa0So+gdN7ToxiLPgRr/CcMx1LPpz//sJJ8Kj4TP53UDwliLTh1TXkgs2NoHQJGw/iZTWTNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNTHx7wi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNTHx7wi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 377E9C2BCF4;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786996450;
	bh=+IqWwA2cdc2aw+WXnNBLXR5Jq6+YKLS5E0CzDhozjwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cNTHx7wijcComiQ4cxrdYDcd2+2dL7clJ2PAGnVxWWXTNZZsJLHIckkvWNpBxr4vx
	 67CUaa3uHxzwJUhPrzU5/hommyQFh/BJ5NjTU3ekQATp63tN9TJ2SjlUSJjUUpa6bW
	 bDMSACw46xFGpEgBnASDijTWda/mtzC0Z0gNYA6IiYmZb6bpPld/jbtNfJAFMmRyb0
	 WbkfYPpAntgVKS60OEXV+qfcYMgLGFueZ76lt7B9Ff2SGajOuajUBR4hs+TU1sI3Or
	 lDx2pgHS9bli54DGBtYEnwBLdxMRBZ5EH2irMvkEeIiG/9aigPgpjmaDpn9zD58uFk
	 vVd3FawrGxUxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1620EC5B572;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 17 Aug 2026 21:53:58 +0200
Subject: [PATCH 1/5] thunderbolt: Fix tunnel reference leak when the DPRX
 work is not started
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
In-Reply-To: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: asahi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Sven Peter <sven@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=+IqWwA2cdc2aw+WXnNBLXR5Jq6+YKLS5E0CzDhozjwg=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Zz2u1wKb3JO2af3PTArFq3ZMFVjujVmVtjf1a2HPQrc
 P/eueZVRykLgxgXg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiAtwMfzg/T9r5J1kpgNep
 dsOEUoWejAUvK7aa/P+8xGTv4xyVnXMZ/qez/xZ/ebLIMEf8nKiaqs4a9VtXjjk9rfE59mXPOa5
 TcmwA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

tb_dp_dprx_start always takes a tunnel reference which is only dropped
by dprx_work eventually. Tunnels that have no callback don't ever queue
that work and tb_dp_dprx_stop then has nothing to cancel. It however only
releases the reference if cancel_delayed_work returned true and the
reference is leaked then.

Fix this by only taking the reference when dprx_work is actually queued.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
I didn't actually hit this on hardware but found it while fixing a domain
leak in the same area and that fix depends on this one.
---
 drivers/thunderbolt/tunnel.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index b7f32305f14a..50580ebdac4b 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1113,15 +1113,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
 
 static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 {
-	/*
-	 * Bump up the reference to keep the tunnel around. It will be
-	 * dropped in tb_dp_dprx_stop() once the tunnel is deactivated.
-	 */
-	tb_tunnel_get(tunnel);
-
-	tunnel->dprx_started = true;
-
 	if (tunnel->callback) {
+		/*
+		 * Bump up the reference to keep the tunnel around until the
+		 * work has run or has been canceled.
+		 */
+		tb_tunnel_get(tunnel);
+
+		tunnel->dprx_started = true;
 		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
 		queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
 		return -EINPROGRESS;

-- 
2.55.0


