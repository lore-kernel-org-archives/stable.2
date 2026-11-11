Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421011;
	b=U2Vg88QpMwx8oBb4UyTxAwkQI/VucGfkCjsRLZjANWIGS6Gh0zd/vYmnR2mgb/OFSZXC
	 rJVEnmY+IuijENNzIokBO4Mz108qIKMpVZO13fo4OinNI4bKhgBUj0qcDK2tz65rzoNhG
	 hRHetczjgmGPi0bt9lPU9psJvj9UwlOo9krblKzsU+YTOqIWoM8zbHxr5skmY1DJM7yji
	 kEmECsSvPFeETRllVEJoHaJD8py1NbpIsOmqjkEQF3CmrO0bMWCWPlwfK1RkMgMUipLHe
	 +Q3TirZo4LxQts+XkMR+xaQmtf+FTIFzmNk90SW2VYZBOFR/thYPikB8+CTGCc3eJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mWelvUhtUXGQCx2llHxsnjIIFY7dlsr1a1mDC5mmlrc=;
	b=WTLaCy2vT3MbT2jlqPGy8e+prv1Ccsx0YwjdlKwH1OH1Ct95LfrmE2OCaoW8OA6dyAG3
	 Vbg8fYDfos25+0RtDSTXLlLE1Stv4MKz/STCUtz/nnm4jt2HI+lW+ACN4zM6Dx0kmXUJ/
	 gZ8fjKIv6chQZA6RaGzueGV3qF6Dd+tKyo5Ob2cKHU4BNCHiVkWH0KRZ91LlFtbW3RA43
	 V35ha5IFUlRwNrXwhxkCJgv01YJC1wDBJACkZFiHtAK8V77sp7kfxw+f/NROcCMmU3xs+
	 TA9vetLlZO1bfMJfu/Js1vUjHYEVOxgMlvUr+dZpwJwnsaDbmGLitxNr7oRZzZ4Pf0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpq+t+Tt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E246606A893
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpq+t+Tt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59601F00A05;
	Wed, 11 Nov 2026 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421011;
	bh=mWelvUhtUXGQCx2llHxsnjIIFY7dlsr1a1mDC5mmlrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lpq+t+TtgcIDbY9Ku0/MmPvmznMDwns9IH1TNqgYHdke/bwsdL1v967kMFJOzuHmu
	 n2liyu+78QtQm0olt+7t2NsOFDs5S3PbT0Vu93RMkscdiYluBPQZbQsdFXOyZydXuj
	 zVE4aGqkBuS6zMurqQ3QOMd5dHElsCJYS0Wnam9LYDNy/0TcHtuS9jts3uIbNOOAvK
	 PjKtS+6oQLr9K+QXL6Y0KJk+wCG4O1dqGdfWHGyOgp3bYAn9DcPV41ttHDsEzCY5Le
	 l3mCFTt8QrgXJQ115tpSZJa/2kkkLzluPZMVta3L5n9iyrR3uIS+661ooXABUzC8Xq
	 PHPB7Zs6JKQGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: yanxia <yanxia@cmss.chinamobile.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] veth: fix stale peer max_mtu on XDP program replacement
Date: Wed, 11 Nov 2026 13:16:49 -0500
Message-ID: <20261111181637.3806221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055359-failed-6.1-c955325db639@kernel.org>
References: <20261107055359-failed-6.1-c955325db639@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yanxia <yanxia@cmss.chinamobile.com>

[ Upstream commit c955325db639e9503941227e14e1f1ccc99442a1 ]

veth_xdp_set() calculates the peer MTU limit from the incoming program's
XDP fragment capability, but only stores it when no program was attached.
Replacing a program with one having a different fragment capability
therefore leaves the peer's max_mtu stale.

Replacing a regular program with an xdp.frags program keeps rejecting
otherwise valid jumbo MTUs. The opposite replacement leaves a larger
limit in place and permits MTUs which a fresh attachment of the regular
program would reject.

Update peer->max_mtu after every successful attachment or replacement.
Keep the GSO feature update conditional on the first attachment.

Found during review of the XDP replacement path and confirmed with
native XDP on an isolated veth pair. Before the fix, direct replacement
rejects MTU 9000 after switching to xdp.frags, and accepts it after
switching back to a regular program. Detaching and attaching instead
produces the expected results in both directions.

UML tests on net reproduce the problem before this change and match the
detach/attach controls afterwards, with both devices up or down and
with either endpoint receiving XDP. Failed replacements preserve the
previous state; same-type replacements and detach also behave as
expected. Small-frame traffic passes in the devices-up cases.

Fixes: 7cda76d858a4 ("veth: Allow jumbo frames in xdp mode")
Cc: stable@vger.kernel.org
Signed-off-by: yanxia <yanxia@cmss.chinamobile.com>
Link: https://patch.msgid.link/20261020020147.790274-1-yanxia@cmss.chinamobile.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted context for the missing xdp_features_set_redirect_target(peer, true) call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e8064b9253720..b8a2b3be2767e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1536,10 +1536,9 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			}
 		}
 
-		if (!old_prog) {
+		if (!old_prog)
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
-			peer->max_mtu = max_mtu;
-		}
+		peer->max_mtu = max_mtu;
 	}
 
 	if (old_prog) {
-- 
2.53.0

