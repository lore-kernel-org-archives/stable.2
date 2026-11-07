Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048842;
	b=hDoCsSaT/pJv91mUqCtMso3FIRvFwQBX3Z5tDnQcvt8sP55bpPU8iwzp3MaKwF9cIX48
	 LVU8p/D3vdBiosR/x7qh4wWuf8RJZAuGs0pgKmFR27OtN5kKQvMWVXzT0N+OFXK7y86rA
	 Tx8r166BtlPORjrqW34ZF1iVgqQVXmmHaF2k3AJEMlK8pZ8vBws4S2dOXeZvjFGu+YHpF
	 3XFnInH7L2IgM8+OZ9yqhdsFSQI6FzRrzDuPv0avbaqk7jVohQJfl3w3Lx2/6MwevXYqh
	 VVV7+bRTJit4ce6Kh6s8Em58hE84jSyBEOJr41d3Ygfwt6UC8e/59ihgmB8YF/uauyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c+qyPq43XHWRpJf5SOFHgnhFsLx4NxJ3o9+8CbH+yKQ=;
	b=ly1kVJ7QapOUqquFXwcb/Jb06aK7qRqaaCf/DbH6+Nuf4Apkj6nWlBuHahowuF15OCMM
	 k6exnfzX30I2DUxux5UfJHeHwo4us9tCXhqDdQEhRwR2HUCaEX/fOy5mZJ7eOiO0rAbJu
	 rUyzvChE6t8/JivueNdlrUpVr65hcX4u/O0BsjV9UwSC9juTgFjXtw+jZi44QN+SUwRSe
	 OeMJL7Q5awLgSpZIsHD/5D1j9Ri7oDeRVzzkwM1hAItzjbJyFBu6FOxI42SOYp6ADP3xi
	 9KPHIdZkK5jtH8NYjCU7Ks5Re17ADLtpdxyfs9xU0Ej9PmB2oRF8U70wU7krLTSCArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTrAatQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2758606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTrAatQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADBE1F008A1;
	Sat,  7 Nov 2026 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048841;
	bh=c+qyPq43XHWRpJf5SOFHgnhFsLx4NxJ3o9+8CbH+yKQ=;
	h=From:To:Cc:Subject:Date;
	b=bTrAatQITr3oeWx4La6cU2FN7CTy+bEslYczK0eOEWSzLgC1jVEf5kjNw1OLUWplt
	 pbaF24TgJIhJX23WQ4gBKa9zG/bgHpXCU4e8pyWTWrDU5QGHimKjWSWGsdJ/WSws1i
	 IEYLfzetKJiCOPvYo/RRqY8f/1TNkio+M8umGRO82492CMsRtcV5P6/qag3C/CCOIx
	 ECb9QWfcyUwiZJ9XdRdzbycbj5Ty4dVmar2m2ydW0Rsi2g5wjnH5AnPzkhSFEcvKAa
	 yDR4t+do8en2xy+RnTmewRnZLuL6rZhmGfNi76BwvaSUXx0CZ90817l9Js1mblV0BZ
	 M3/0qkXX+zsZQ==
From: Sasha Levin <sashal@kernel.org>
To: yanxia@cmss.chinamobile.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] veth: fix stale peer max_mtu on XDP program replacement" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:59 -0500
Message-ID: <20261107055359-failed-6.1-c955325db639@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c955325db639e9503941227e14e1f1ccc99442a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055359-failed-6.1-c955325db639@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c955325db639e9503941227e14e1f1ccc99442a1 Mon Sep 17 00:00:00 2001
From: yanxia <yanxia@cmss.chinamobile.com>
Date: Tue, 20 Oct 2026 10:01:47 +0800
Subject: [PATCH] veth: fix stale peer max_mtu on XDP program replacement

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
---
 drivers/net/veth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6205742f88d9c..3eca92d3dc60d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1627,10 +1627,9 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			}
 		}
 
-		if (!old_prog) {
+		if (!old_prog)
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
-			peer->max_mtu = max_mtu;
-		}
+		peer->max_mtu = max_mtu;
 
 		xdp_features_set_redirect_target(peer, true);
 	}
-- 
2.53.0




