Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E193F1AC5
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877792; cv=none; b=jsK3HIMJkWReI1wK2nUr1gPW4WKATf5xcED90DkSFw7dQYusjuYJcDKjjxvSI9CwcI6BMjAVnM3X3txbtPWuTdB7Nd2TYmQDxXNcVMG4L0PMPgLkGhP7KvYR2JYEmi9j+Y/mrFUMrvbSek4W4BddaNA3zkK9S02G8ca++MXCJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877792; c=relaxed/simple;
	bh=vuCy3XNQRwK2pAv8DV9ohIZ4yjPKBGFN3TicIXMmLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5LssWnvkcnkdKngohHqeSFs8Wa+NRUI4BDbG7AvhMOsOkCmJ30k6cPFCwvT/3uAaR7KsMpqi3N/fYzU/pLUlzwHVcSPsNk5plKge3GBmhINRXI0N3sQ+bODSJV14NePJ0dwCW1y/8WkM+/7IXueQBbXVAw29joM/dWbjeq0ve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJAbM5Y; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJAbM5Y"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-67561cbafd0so2857270d50.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877785; x=1791482585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSRI8/Iy//RZIheBCqOOgWpv3l9S3TrqbEtSt4XD5L0=;
        b=XbJAbM5Y63BgY8f4j+eS042/clTc1G0oifIQxmqGl9ySUlPIktHx7mRIhC7yWfThs8
         q9bJwzBYOetZ256o1uxGUru5wlyBjYVCBxPEujni7fvP/GwCZ5FMYmfyakJb2dCwkjLu
         Ubtu4Bs8LTPfy8yjdYscagnsGI1cgA95o1fWKy2pK1N7NC4+P9fzd1LOTZhZQGD8vGC9
         e6d/vu+v1bHn+1pkkPwvAz3AWi8+xfz2Y1Xx+LVQCSuIhktmHslrbsbDfPFEhfWA/81y
         QML2cfw9wHmy4jSaWOlx3Bifxuo0hWhTWs0oLbqKRYSNRJZ4vvanlD5znk8vylbkCZU2
         XPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877785; x=1791482585;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSRI8/Iy//RZIheBCqOOgWpv3l9S3TrqbEtSt4XD5L0=;
        b=mShRrYGOqimR9OGGa5CfVZNr3pZsozUNqoW3tsyCdOVChhKXk7h/YAvZ+jPjL2e1yE
         EUMi54qU60mhG7ca2dKposxOYq1hvqa+EvBP5EZ1464yVkGriQ2UZESRoBLWKsmGWnRd
         aql/gOcRZu3mbGySeUdj5uj2gB6msBQU1+1jx9gQrsVP+ylGry3caJKvmZVKeKN+fAGe
         r8r/m9e5oTVFt0dyCjzS+xXkz3BvT7QwQO33vAESES5wBqx3FzqZcX+LdWR/dmx/4aUM
         9Rf1mGmvCAnDV0SFDvbOd1GJ8ofv8xRoTfXdCoSCKMoMz3R3WGm2WWI4KudSSfhl/Y97
         9UAw==
X-Forwarded-Encrypted: i=1; AKwUvBx9rVVeulVTelZB0kURNUg1zSo+8UqXQbOXAo0y755L8XauSaW8yPIpnrLXx+4R/8dG+IGn2yE=@vger.kernel.org
X-Gm-Message-State: AFuF++ngXUUQ1+TtWvw8ilULlFfCNFPWcJGyfsapNLaLvvZEFcNL8A/1
	nWIZVJEUl1Rp/edx/iwQn+yWYwki0ffUngoX0k8Pgvw7peIpkpIdKy8=
X-Gm-Gg: AYBFou3bSoxWygx5VqjbOty5cCfOXF2uK3ab6shwWuMo8bYHm/axEoLUIVFZhKIVEQY
	H/E1go91oQH7KOFkfVSG3KBSrm3DpATYhcXJF5whsJBPsm2Ns4DUXJr0r3xECqWi8TqVvxjoQ9r
	ppyLI9fIMYHLdB7sm1rLcVbb8WMgrWeF0l43VmGgwb7m32+u2uMxJhhgGOL3+ncxDz4c2rwm/Js
	iIf43/KzQWxc1Az4t11asqKCutLMWSquTMGwE6RRRvBiOUwaOU1C0kToNh4M7A4tOcPel+vjcVf
	oIeDUgh92KxR+EP8E/4lfjtey6tFxJBRbXKPoRz37v1IfBd70ND69umUyWYCWlwhflB9jbYVTmP
	EUQT3dlFebtsWn2LFmWS/cPEJaCkirWw7vcSb/QUWIhn44M9mzOz86RYV2aqy3xa6xpnvRNtKYo
	A4unaPA+hrZWLgVWkCTv4Tpb0839WXJVdp90SJE+4MUBB7/yNz2uUMZS7Q9uGIWzNpHJuqZRjqQ
	1E01ak8SY914IpE3Lcl7i0+lvizuVC16Fg2PpvTZSPmFMfzzZ9aGRmfizpLKVd9uvYsmsYzv/7m
	w7oLewEfiRjlD6o8um6LMQ1+VrDc
X-Received: by 2002:a05:690e:1513:b0:676:858d:35d1 with SMTP id 956f58d0204a3-677ac03bb85mr68872d50.36.1790877785206;
        Thu, 01 Oct 2026 11:03:05 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917b200fd90sm20983806d6.37.2026.10.01.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:03:04 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net RESEND] net: fec: drain PEROUT requests before canceling the timer
Date: Thu,  1 Oct 2026 14:02:58 -0400
Message-ID: <20261001180258.4054391-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fec_ptp_stop() cancels perout_timer before unregistering the PTP clock.
A PEROUT ioctl can set perout_enable, release the driver's locks and
then be preempted before hrtimer_start(). The unregister path waits for
that ioctl, which can rearm the timer after it was canceled. Removal
then frees the netdev containing the still-armed timer.

Unregister the PTP clock first so all in-flight ioctls have returned
before canceling the timer. Clear the PEROUT state and compare channel
afterward, then disable PPS. Serialize the channel write with PTP clock
shutdown and skip it when that clock is off.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Resend notes:
- Send via git send-email over SMTP to preserve diff and hunk headers.
- No code changes from the previous submission.

Previous submission:
https://lore.kernel.org/netdev/CAGEsz8EYe=gBFr_hEYFLUeiJMRtau=eV3cDUUmHJOQkC0qvfqw@mail.gmail.com/

 drivers/net/ethernet/freescale/fec_ptp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..67901e036ac3 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -506,10 +506,13 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 
 	hrtimer_cancel(&fep->perout_timer);
 
+	mutex_lock(&fep->ptp_clk_mutex);
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 	fep->perout_enable = false;
-	writel(0, fep->hwp + FEC_TCSR(channel));
+	if (fep->ptp_clk_on)
+		writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	mutex_unlock(&fep->ptp_clk_mutex);
 
 	return 0;
 }
@@ -856,11 +859,12 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	if (fep->pps_enable)
-		fec_ptp_enable_pps(fep, 0);
-
 	cancel_delayed_work_sync(&fep->time_keep);
-	hrtimer_cancel(&fep->perout_timer);
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
+
+	/* An in-flight PEROUT ioctl can arm the timer until unregister returns. */
+	fec_ptp_pps_disable(fep, fep->pps_channel);
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
 }
-- 
2.53.0
