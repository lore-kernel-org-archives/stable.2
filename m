Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987820;
	b=OMRFmRdZKjqUlUDvWx7zsOe1hBxmcnlVrTP8Fun89K8UdvEEFV8jwA3Os110RAABSmVL
	 PnY7g9dGCuoBkpUgFbyFDK5HYpvXhDLb2qMb/o5bkMbfDlILzeF4PGoRfjyzH8W/jkny9
	 rdngvZICwbPyAU0iXAPuXSdkfzCkBi7HrkRUuVnsnmYrmB0CZAYd5gGVAxfLODtVsVKeF
	 9jNyYSxe8wyrDKECBdAaifH/tPu5qO8pz6TghrAVUatGf508OllkrnaRZ4vjHt/AhpeR6
	 c0c1M/14v9IUizqoTvL6o2QHNeRCmTNPaZM+ri4BgLOhzdJ/aXCRWTD0ph/hbEcvLyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987820;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b737YrD1Vuqp1UqKoujfmzIBpXH+TGHVeB6r5nqOeC8=;
	b=ZGrJv9uMiulx+my1VzJuAQN/1Mxf0/Zd2r/stJtek1uLOm7Du0mTb+6Adc4btqwMWMht
	 C23o/3Oy7f9vlrzs09UnCqN7p7IlaOV+afR8Xmjc7pjEmrcBPTz1JnWv4MxQb2btp5CAD
	 iUqPU+3cjoLuaawLLblSuflb2kIIW8OEJVUGHsD/4Rs79vYxMXWP8ntmK7FrIG8wefEDq
	 jQb4zett2qJ3WQTNMZ05hy9bJXDNpw28RlAHtnhC0rKIDdppfZ+erC4rVGAqJ4dQojp1j
	 rVYgZJ1jVv6H3CnJLH96lGTFGYG6cAu0ViBih5PMFE8acUZkqNthWaF4gjHp/6hGhSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=OlGon56e;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C405606A32F;
	Wed, 18 Nov 2026 07:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C405606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=OlGon56e
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id E6B1126BC2;
	Wed, 18 Nov 2026 12:43:36 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 6D97826BC0;
	Wed, 18 Nov 2026 12:43:34 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 6D97826BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1794987816; bh=b737YrD1Vuqp1UqKoujfmzIBpXH+TGHVeB6r5nqOeC8=;
	h=From:To:Cc:Subject:Date;
	b=OlGon56eLuA3hxxuXUg/EEofiMCJVx7s7td7yv5E5/fOSwI40q7kSKBS6mAuBk/Ym
	 bzkIXrbTes/dmu2fefJvees6SgRgB8FivU+RMqg6tYpLE5vGp3BA0ReEBBwk+d1Ukg
	 LO7U6FqVg7D92aUWqzu732a/jtuYJ8cN46AuRra6mwMGHmGgH4Qz9w8M9c+ECYT09d
	 bB+mwT0jeo4BJSDlEFU+6Brc4uvUOiXvHxDfO+s49J6LI0uLt3sVwLpwGx3/BrspqC
	 ZM2Zz6aJRrKVemyzHA60ZXbClukilCzbzDd+JCSkG70jnaH4MVYwnPB8/IwbHKkGN0
	 iNQMCzcTUjuCw==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net] ice: Avoid tracing bridge ports after initialization failure
Date: Wed, 18 Nov 2026 11:42:59 +0400
Message-ID: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
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

ice_eswitch_br_port_link() traces representor and uplink bridge ports
before checking whether their initialization succeeded. If allocation
fails, the port pointer remains NULL. If xa_insert() fails, the cleanup
path clears the pointer and frees the port.

With the ice_eswitch_br_port_link trace event enabled, its handler
dereferences the NULL pointer while reading the port fields.

Call the tracepoint only after successful port initialization.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: d129c2a245bf ("ice: add tracepoints for the switchdev bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 1d8a6b95ccda..6d07c15ba9d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -1118,7 +1118,8 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
 		struct ice_repr *repr = ice_netdev_to_repr(dev);
 
 		err = ice_eswitch_br_vf_repr_port_init(bridge, repr);
-		trace_ice_eswitch_br_port_link(repr->br_port);
+		if (!err)
+			trace_ice_eswitch_br_port_link(repr->br_port);
 	} else {
 		struct net_device *ice_dev;
 		struct ice_pf *pf;
@@ -1134,7 +1135,8 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
 		pf = ice_netdev_to_pf(ice_dev);
 
 		err = ice_eswitch_br_uplink_port_init(bridge, pf);
-		trace_ice_eswitch_br_port_link(pf->br_port);
+		if (!err)
+			trace_ice_eswitch_br_port_link(pf->br_port);
 	}
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to init bridge port");
-- 
2.56.0


