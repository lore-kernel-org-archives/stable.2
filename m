Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461731;
	b=tpnuKAHJAkX6AKqHdFwYH8Apkollmk0YoqtA5cvBscsluhOQHYEylNygTnx6lc87/+VM
	 Sm/FHEGlpfaqGqOyhpCUjcpcnh4ZZqy6z5ZyBbq5tng3rY/6PNHeq574VXvcXEvoEmBb1
	 91aCce9lufsr2C1VwHyvRkpN5AvYN9RCWoDjxF3nKsIiZZ2LJIJNsSt8uSQutI2UXvcE7
	 pn+Eq7i4Yh3k0+9bcp97L/u80rhUnZftFL2n+Nz4dSLeqjzNiaapiimCE3b3fFJG9Db8p
	 0iAWYHZEV3FJbk2CwHPxMQnJ0zn8KKVWAj0S+DvTfU6Tw2qfBSAZhUbYfj87EkSrJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461731;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0E0Q82Is6zdEjs6jL2vNo7lRDKdCGLWZjluyuxDIQjY=;
	b=XcF7+JbAZy2OM9LmT2AMGaFUB1vv3r6zv7kxyLNleJ5GJVIGcAEvTpZGF8ai8KknmCRB
	 KecrQfYxTu+7XXlQgSPZNYdB//QT4GhB3tboJoYhuk4S9lUA7NAFmj/BAcg6DU6gud4p1
	 z2urf2lVA9F+Mm8fOrxYjYfCwr3zrxRlqEU65thOmd6qm6vMPnhe6pDoJQYxLea75a0VR
	 U3jj+6JyhAxlIgW3PnO0s/GTCMzpyD1HVVDsZ5snIW1/NP5DzCfMmYmaTVZLlusrpv4U2
	 1OoxaQwrpnglGVsuqANZrm63TrSLR54xJNu9fweBOqBm90CwBmZUWP+DEVHyR/5KMSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="IcD/Wkuw";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE0606A319;
	Tue, 20 Oct 2026 02:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBE0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IcD/Wkuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IcD/Wkuwea181oj1+ZhQlsefMEZjCRnWU3t7K0zHabYpAXROemLoRAujzGGyCSu7baYhTD1K7oQTr
	 u2LSDwtzzS2NKpBKpXmSeB0eoNPRnDj/LJH2ng3gNdImqWKKYCgLISYRou24eG2GGw6FnXFrf1AtbL
	 pJfuCil0d6+pUJTE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ad6cb9609e-14724;
	Tue, 20 Oct 2026 10:01:58 +0800 (CST)
X-RM-TRANSID:2ee56ad6cb9609e-14724
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ad6cb95dba-ba9c2;
	Tue, 20 Oct 2026 10:01:58 +0800 (CST)
X-RM-TRANSID:2ee66ad6cb95dba-ba9c2
From: yanxia <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	lorenzo@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] veth: fix stale peer max_mtu on XDP program replacement
Date: Tue, 20 Oct 2026 10:01:47 +0800
Message-ID: <20261020020147.790274-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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
---
 drivers/net/veth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 643b97dc..7db389ae 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1622,10 +1622,9 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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

base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
-- 
2.43.0



