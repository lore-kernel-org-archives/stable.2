Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B243B6D9;
	Thu, 30 Jul 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423809; cv=none; b=LYukEq7/tcwIYXFyX/50/kL/WXyd9smsHy6C0ORdVuLQ9LJS5mU3+iymnDQupZ47X7KipgsEPzgMcNdTzRdfvdxdgvm/3ywwyhnsFfDbfG/1wavLw3IqKTpjj1Yd1JTKijC2wBD0TKQK0yytzRnRT4eJ6M9M9w4VIv5urYHIV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423809; c=relaxed/simple;
	bh=3m+0Rel/SioUjohWrueEwRGYOuk4TpOYyhufeOplM3w=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=g2yNjTTlTyxwvcy2FHR91nWv0SGzgQrSieGdyQDrica2OgA3GAiCgVoE5DYA2k/pp4yZuxJ4XaxpSKZQT4BVkQpphLs6A2Q9VgChxhKpqhLX86SBgCtrRpD0PXI77DabxxafW7tXHsP8C4uWks24mK1Mo2ZwTy9zxiI0M+Kje1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f5baaiti; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f5baaiti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785423798; bh=4J1TLV8JAiNez+SC9E+z5pMym6BWD2VgswClea7/mzg=;
	h=From:Date:Subject:To:Cc;
	b=f5baaitiMvFjUcceosjpg1+uWs2YSW1oB7L6F2fbfHboOggJ+ILGdehcSwdqqQQOs
	 d0bKUHo/moI5Oq3emaz8xuOyobtEUSPu9PDlZnMQIB1c5HbwATJGp+Uefh8ueTCW+D
	 kLTyztVSWFSAB7ahhWLIl1FpNQsyBsTtttQC4xVY=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id D00C8E0; Thu, 30 Jul 2026 23:03:16 +0800
X-QQ-mid: xmsmtpt1785423796tyfph8pgh
Message-ID: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
X-QQ-XMAILINFO: MKkTBAOwcWdycxePHtZ1KdnZiQodJuqwNqiSzHuzoppuascroFqdog8xt2U3PN
	 ObCHmmGwTyyG+EsY7Auxx9IN4uKCPkX5F/btqdvS0PIeOhkUwo3lVbOOWzUJ6xgq+vAfLJ4ECmjK
	 Ktmm9XsP4ouAUVhMqm0FnJMsDUbXh67RGHSlDExZVh4W6enSXTRyIekrETBQjK4oeF6cEJJWHfsX
	 QgAj+o8heeLcew6zLrUixX2DfD9ttVRCF55+rznDbbjG1i0yU7jgK/TI4UP+35+ggaSqp1G3nC3p
	 d+GcRFt2tvU3pE0mjv6rOyitSL4nZUe7h2h0V+/P/4ypFli+ZApvhtPM5qdRKUiXo0XzXQfY+2xV
	 1T+0M1jGZ3Ier+KUEl+rn6HIjmrSg9/ROO4u5bqgdTSPSCibXl6tmxaptVyUO3H2eVeCj0LYcW//
	 oxB9uC3im0MJ9sNDyJP1eLA+Sjmq9xFeaqR7Qi8gG4mYq9YOl55tIafAI30kBw9RkPODIudLWIFS
	 FKzNTYhYIk/sE+vQyq9pkFrGL53LgPngyN0xBOjo/iT45hNwFZafvwTkcU2tMqQokj+Ui17DJ+Hr
	 pb5NCBre17b+Ks/GwA3X8T9bAKkxJ2NB+BNZOYRpDbTF88HaIF1YiOT/k/wG5OGd4uGZrLefxdj9
	 oxcdLCzwPbeCsizt6EIGms2E+HFQRHUS03b8bZoYHSdeRHlkg44Xja6Vkze5+H6RKX0nHtaJYyi/
	 wNkvyUF873pIB4zE7yzQ6wLj7wjnhJzMGC/mjgyUH1toVORVKSwJeQFJlVFJ5k218ZQqkxP7R195
	 14nRs46RLRKCZSO0tVUte8ZYAEtUiViZwJJK+gKReiJYpe5D7kutwXlAufNzvVHVSWvaA1DX3gco
	 FlV3ATstnVyHpXNVgmhgTP/ohpzvUe1Y2M070tkvSTEp4T8xvv3RYgCFRrVafi45KOmwdonpnkY0
	 qD10CDU32Eh0nH9ewDFGnTiBLxdGllUkUTCjrTytly/9xp+vSWAMoRNAtTqKRW3Xuvcxn18EEDUo
	 WDScufoS8KDHMJzsvzL6A9NQkQ1LSlVPNcufyaCUt3rsMT3KwJmcZ5HlMkfgyrmDRC2gEfRhPYfB
	 C/xGXFZpvzV5E95VbHF3+dRmJ6EEW6LPnGQY3pexy4H1kFKaxAhFL/xvcPK6M2Xu9wtgdJd3RIZ0
	 4wMoR+Yi4vcV+qdQ1LbifIPIpJ
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 23:03:12 +0800
Subject: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid echo
 index
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v1-1-8e162ad02a28@qq.com>
X-B4-Tracking: v=1; b=H4sIAK9na2oC/yXM2wpAQBSF4VfRvjY1DpnyKnIxxsJWDs1GSt7d4
 PKrf62LBJ4hVEYXeRwsvMwBSRyRG+zcQ3EbTKlOC20yrSYrG7yyTZch14VBbijEq0fH53dU1b9
 lb0a47V3TfT+Klr7pagAAAA==
X-Change-ID: 20260730-master-abf3e4067e47
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

can_put_echo_skb() consumes the skb on all paths except when the echo index
is out of bounds. This leaves ownership with the caller on -EINVAL, unlike
the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..44ebeba99837 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		kfree_skb(skb);
 		return -EINVAL;
 	}
 

---
base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
change-id: 20260730-master-abf3e4067e47

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

