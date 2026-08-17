Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1246D0B5;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996451; cv=none; b=shzehI0+5VY4e6qePvjxS5afd4mRyxBGXp3QbNw2byM6ZDDs5w8lRkWnv5DF1HG1virs9jShXjouRIiTP4SXFdcmQfJ+0Ege07ucaQwPYtkFtNTDLqMxhyJNQ+GyoDEELBo033ixwhVcrZJIICflI78f+wvEYz80HZvf74gCrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996451; c=relaxed/simple;
	bh=xAAxDyvnDi8yNJ6ByWgjRWlh3/HZjKsKtAZ8OmkRJfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdevGyBMtutsxd/n9N+KgZuubQgtCDWpvpITpVoZ0TsyG8jZ7CWk6JgDJuZqZtwUAS+25nBYADUdu0VMycTfKb/M9KJRbYKeqHkmjU5rb7zj/YomCFJCW/FWRL1c32CZ99LAekA/0aR3qs2y/g453a0cyf+TH27yr0yn0moA9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIEtRiu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIEtRiu3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 714F3C4AF09;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786996450;
	bh=xAAxDyvnDi8yNJ6ByWgjRWlh3/HZjKsKtAZ8OmkRJfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIEtRiu3cyoFUP8Dlj+glac4A/3KoXETHv6QY9C08p+CnNSW0wSceq8gJ3/OrNwZN
	 uJgmfs/nKEtc5/TrmPIrGwSLShC5MGfhOCZ50DaXcWQAyU7elkJwAxE2hwBlxT9VwV
	 S2yPiP70Cb0UyC8ug5bqe++vRtw1bWnJFKL47yRERHbnsj2wtKYVLTzl7ZyZwmCNdW
	 U565SMo4zJc/xCROE53PviKhBTT660Sn8oeQ2ljT+WaPDJ8mBq2wViEIOrs4XYXIYU
	 bc72PeU8F9UEBm03Vs9qVymN/9sqg7hbIlnVLyG+V8WnYMdd6NIsgJ1Jr7dXpgITJR
	 lfWbdW8GCiWrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A37C5DF7E;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 17 Aug 2026 21:54:02 +0200
Subject: [PATCH 5/5] thunderbolt: Cancel the DPRX read when the domain is
 stopped
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
In-Reply-To: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: asahi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Sven Peter <sven@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=xAAxDyvnDi8yNJ6ByWgjRWlh3/HZjKsKtAZ8OmkRJfM=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Zz2v3HMVJchkYPVucEcU2w2VV2NLYnJ/+X0mGDrZp95
 RfXmct0lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACai4sTI8Cg2d5/x75PfSv+t
 KXjgpv52v9D6nir1uEc1Mf3S3TuM7jP8ZDyfHekRmVYR+rytTcJ7Y9Z2z2/v+/tul5oF6nf3vO/
 hAAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

tb_stop only tears down DMA tunnels so a DP tunnel that is still
waiting for dprx_work to complete keeps that work queued while the
routers are removed and the control channel is stopped. The work only
stops once the DPRX timeout has passed and because it requeues itself
until then the flush_workqueue in tb_domain_remove won't wait for its
final run. The callback then runs against a domain that is already torn
down. A reference to that domain is kept so the completion waiting for
that domain to disappear in unbind will block until the timeout is
eventually reached.

Just cancel the work in tb_stop. This doesn't affect DP tunnels that are
already alive and keeps those displays working.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
I also didn't run into this but noticed it when fixing the hop alloc thing
and think it makes sense to fix it anyway.
---
 drivers/thunderbolt/tb.c     | 5 ++++-
 drivers/thunderbolt/tunnel.c | 9 +++++++++
 drivers/thunderbolt/tunnel.h | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e368a6b53f64..f7e68372da09 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2958,10 +2958,13 @@ static void tb_stop(struct tb *tb)
 		/*
 		 * DMA tunnels require the driver to be functional so we
 		 * tear them down. Other protocol tunnels can be left
-		 * intact.
+		 * intact but a DPRX capabilities read that is still in
+		 * flight has to be canceled before the routers go away.
 		 */
 		if (tb_tunnel_is_dma(tunnel))
 			tb_tunnel_deactivate(tunnel);
+		else if (tb_tunnel_is_dp(tunnel))
+			tb_tunnel_cancel_dprx(tunnel);
 		tb_tunnel_put(tunnel);
 	}
 	tb_switch_remove(tb->root_switch);
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 52fa90786ff8..5b1ae5a0c12b 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -2487,6 +2487,15 @@ void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
 	tb_tunnel_set_active(tunnel, false);
 }
 
+/**
+ * tb_tunnel_cancel_dprx() - Cancel the DPRX capabilities read work
+ * @tunnel: tunnel to cancel the DPRX capabilities read work for
+ */
+void tb_tunnel_cancel_dprx(struct tb_tunnel *tunnel)
+{
+	tb_dp_dprx_stop(tunnel);
+}
+
 /**
  * tb_tunnel_port_on_path() - Does the tunnel go through port
  * @tunnel: Tunnel to check
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 4878763a82b3..9de5fac04269 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -138,6 +138,7 @@ struct tb_tunnel *tb_tunnel_alloc_usb3(struct tb *tb, struct tb_port *up,
 void tb_tunnel_put(struct tb_tunnel *tunnel);
 int tb_tunnel_activate(struct tb_tunnel *tunnel);
 void tb_tunnel_deactivate(struct tb_tunnel *tunnel);
+void tb_tunnel_cancel_dprx(struct tb_tunnel *tunnel);
 
 /**
  * tb_tunnel_is_active() - Is tunnel fully activated

-- 
2.55.0


