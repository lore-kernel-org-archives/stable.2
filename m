Received: from 3b.pm (3b.pm [159.69.114.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8D3C8716;
	Fri, 17 Jul 2026 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.114.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281878; cv=none; b=pCtQ47ePS69HJgODsdrTfzm113rYqxCCVzoUpuyxyxwSEXFw4e3a0i8UCrCYnpm+WK5KttCWMFhmdIVHYZKYNaIV2gxkLd0ArrzaeN13D9dfg3nVrEoh4svpgosvRp8T1nqLztvJXVmihjZB9PCyfjepAkDSdu3Zz/aE97p7DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281878; c=relaxed/simple;
	bh=Si70S4g2EmY+Kbsc81yJ+X6h1VLtSwHrkX2O2Nj8lAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xy2VBbPmhkU/s6pNHMiaPTZqM+Ni2C2s35Ycss16Th+uChmpFGspfHmL9HudnXmFUzSilM+ONbQgOQV+T9cw1vtBt3gIJAAcgagwRfXOVmTI67HTuL9AcCLCVcOMrgP49jaBNwK7XVZhMc2V5HCY1vW87SEqfRuMOGgnQ+VujUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3b.pm; spf=pass smtp.mailfrom=3b.pm; dkim=pass (3072-bit key) header.d=3b.pm header.i=@3b.pm header.b=JfZaXOgr; dkim=permerror (0-bit key) header.d=3b.pm header.i=@3b.pm header.b=vD2J+ADc; arc=none smtp.client-ip=159.69.114.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3b.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3b.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=3b.pm header.i=@3b.pm header.b="JfZaXOgr";
	dkim=permerror (0-bit key) header.d=3b.pm header.i=@3b.pm header.b="vD2J+ADc"
DKIM-Signature: v=1; a=rsa-sha256; s=20250428rsa; d=3b.pm; c=relaxed/relaxed; r=y;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To
	:From:Organization:Content-Type:In-Reply-To:References:List-Id:User-Agent
	:Thread-Topic:Thread-Index; t=1784281710; bh=HMQdhO4A8i1cuDck9n7I3DxjT138z7
	rpMGxly49GsyA=; b=JfZaXOgrT9t//9xs3RZ/SGWRlVzcVoeYnCiCmUH//+nBi8LGaSscHTTA6
	TvdEJ41TAGpBn8MOxpugojQNDCsGHkB50A28vKGlYQVPSRV9x/JJ62i8yjnUtnYm/ktsvpPqnJo
	cMcaXj13GpKx3BEFbXJuGLT7vsnJbLEvjZJEN1OhQwqIs1PeQoEpLQrE9Nl9zmABiSVW7135P15
	H5Mgmywsv2Odt5Py698PCE7RfkQ2OxNSY7lvMMJ6RVVDhR116yIdrl7GasbkfyAygTHM2JBXv+e
	8ZmJawf5Bn16B9gA957qYC2qZRgvK64oJwRRyfit0CJlLePlcD2kx6XAM3sSBs36Fmd/8nAwT4z
	c3k5yjJTBLOPqukPmFMPpOYIR/aBuOu+jwwS6LNRfDiRLZ1Q036EEpYD++muDhtxdX4b5bXiSIW
	uqXjlOc0k1OaQLOF1Y/ZZYx2Y3NQ4Jruo7BoxbQS4JQkxp+X+N7Uuu8pWVU2HWsUiVa6h+IyHdc
	Tdvku;
DKIM-Signature: v=1; a=ed25519-sha256; s=20250428eddsa; d=3b.pm; c=relaxed/relaxed; r=y;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To
	:From:Organization:Content-Type:In-Reply-To:References:List-Id:User-Agent
	:Thread-Topic:Thread-Index; t=1784281710; bh=HMQdhO4A8i1cuDck9n7I3DxjT138z7
	rpMGxly49GsyA=; b=vD2J+ADc4cR/CWnE0Eee4MGFfE8SMWyJur1dXcWMdrWUwbju02eP+B91U
	F4ylWTeKCNDfAjWUJqhfxXz13WEBA==;
From: Philipp David <pd-lkml@3b.pm>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp David <pd-lkml@3b.pm>,
	stable@vger.kernel.org
Subject: [PATCH] igc: fix netdev not re-attached after resume if interface is down
Date: Fri, 17 Jul 2026 11:22:00 +0200
Message-ID: <20260717092159.35496-2-pd-lkml@3b.pm>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__igc_resume() calls netif_device_attach() only inside the
netif_running() branch, so an interface that was down during suspend
is never re-attached on resume. It then stays in the not-present state
that __igc_shutdown() set via netif_device_detach(): ethtool reports
ENODEV and every attempt to bring the interface up fails the
netif_device_present() check in __dev_open() with -ENODEV, silently,
since __igc_resume() returns 0. Only reloading the driver recovers the
device.

This is easy to hit in practice because NetworkManager brings managed
interfaces down before sleep unless Wake-on-LAN is configured, making
the adapter unusable after every suspend/resume cycle with WoL
disabled.

Re-attach the netdev on every successful resume, as igb and e1000e do.

Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
Cc: stable@vger.kernel.org
Signed-off-by: Philipp David <pd-lkml@3b.pm>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..e777c2df0b73 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7586,11 +7586,13 @@ static int __igc_resume(struct device *dev, bool rpm)
 		err = __igc_open(netdev, true);
 		if (!rpm)
 			rtnl_unlock();
-		if (!err)
-			netif_device_attach(netdev);
+		if (err)
+			return err;
 	}
 
-	return err;
+	netif_device_attach(netdev);
+
+	return 0;
 }
 
 static int igc_resume(struct device *dev)
-- 
2.54.0

