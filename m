Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846473;
	b=0UghduaMSLLMe1R48VqFXw6ukt57VmnBa2CGSScOpRRkdx1bl2n6iu63jQ4FjhwMniIj
	 b1/MetjjGyJX7aHginRDqtVsd5mliety/1nRP1tqQktE5ho7wNMdk3Cnj02F+xgd0r7ob
	 owviJDbrqcTV3r6rXh3NJNOGBtpIO8jsEGAb7+8TgbdD5SNw/hWO0lB8KyHqyNHBpTTxG
	 U5FRD16JRAPGh9ETSJGkOWPmgYD/ITQJG9BnVQkkba4wUV0/4kbF/rEZXPIZMzT6df1FD
	 0n7h2sHv63E3KQFrv6sH+y+7AUfVqj5Isp3zH0YoKxPl+hYqkD4JzsLn3MrCSRO5cPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846473;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dZe/LijuVLl7MoBOEgcpysGGUCW3oMka5tpf4Xkq18w=;
	b=jKfmCRw4Ey0qbAeHwSg7+MaUpnHm0H60B1u4IQ1+sSNoQxsbPnDVHiBAmcUfz1C5/5J9
	 Ittyhqo7/Ux0GZeVYZ8SQnhShTVLUE8Wqnfz0w60EtTPiTgh4AgL6MQ1Ao7jX9rMqvRI7
	 gUfQWCJizl6LnkzPwntiPVYbyXsdnBV3JFDonuPg1qg0oo2YGLhoQfqgRTbJWqWWnn51R
	 q6YrJEqqkzjYszTuMm+mD5yaztSaPq8X06MOgxWiNgezRiXz/ib6FCSAnrzPWYd2TJz6C
	 /ITarVbOPFtvK3kXYDtuz7/oMq/7j9ZIYWCGmtCf70KNscfbvQ5Z9a1VAxR3VsAwzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pisu.la;
	spf=pass smtp.mailfrom=pisu.la;
	dkim=pass header.d=pisu.la header.i=@pisu.la header.a=rsa-sha256 header.s=protonmail2 header.b=nhWUzufZ;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175B606A322;
	Mon, 16 Nov 2026 16:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8175B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pisu.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pisu.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pisu.la header.i=@pisu.la header.a=rsa-sha256 header.s=protonmail2 header.b=nhWUzufZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pisu.la;
	s=protonmail2; t=1794846468; x=1795105668;
	bh=dZe/LijuVLl7MoBOEgcpysGGUCW3oMka5tpf4Xkq18w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nhWUzufZ8YEhdFzqvfugw8jS2dfMkh3TdFnQyI0AO448S+BoELVndnJ3KQ9P2mP5a
	 kYaz2alAUyp2SCSdEiaubvFDzqT773pilVIBnb0wH6IWQHSeJbih9K9VL+zXGKn8+2
	 IZ7JfVHSpWK7GtGX0U5R97a5hTilWIHgwliqa+cclvr/C/CdHx1yY3mDtOM0g8eQt/
	 dKy2ndZh48BIKQRxPhR9vT7YJfsplBH66TkAIqh24083c4ahJ6W9WwONS3KcgC9lif
	 Ce6v9NJNAdELXkmbfnixRDLW02WiuTw1aa9YEV6soNwb9QYIS20IgjPmfbbJaBmUSd
	 PBq4B4OuB0UMA==
Date: Mon, 16 Nov 2026 16:27:41 +0000
To: =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
From: =?utf-8?Q?Miko=C5=82aj_Pisula?= <mikolaj@pisu.la>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Miko=C5=82aj_Pisula?= <mikolaj@pisu.la>, stable@vger.kernel.org
Subject: [PATCH] wifi: ath9k_htc: fix use-after-free of tx cleanup timer after failed start
Message-ID: <20261116162702.15393-1-mikolaj@pisu.la>
Feedback-ID: 197744389:user:proton
X-Pm-Message-ID: 148aae3cd3306f701aa0b110078fd135038b2bb3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ath9k_htc_start() does not treat a failure of
ath9k_htc_update_cap_target() as fatal: it logs it at debug level and
goes on to clear ATH_OP_INVALID, starts HTC, wakes the queues and arms
priv->tx.cleanup_timer. It then returns the stale error code.

mac80211 takes the failed drv_start() to mean the interface was not
opened and never calls ath9k_htc_stop(), which is the only place the
timer is deleted. The timer re-arms itself, so it is still pending when
the device is unplugged and ath9k_htc_disconnect_device() frees the
ieee80211_hw:

  ODEBUG: free active (active state 0) object: 000000002df157c8 object type=
: timer_list hint: ath9k_htc_tx_cleanup_timer+0x0/0x770 [ath9k_htc]
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x1a4/0x3b0, CPU#2:=
 kworker/2:2/110
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   debug_check_no_obj_freed+0x44c/0x5b0
   __free_frozen_pages+0x724/0xed0
   device_release+0xcf/0x390
   kobject_put+0x19e/0x530
   ath9k_hif_usb_disconnect+0x371/0x540 [ath9k_htc]
   usb_unbind_interface+0x1a0/0x860
   device_release_driver_internal+0x35c/0x560
   bus_remove_device+0x28a/0x540
   device_del+0x371/0x930
   usb_disable_device+0x2ad/0x6a0
   usb_disconnect+0x27f/0x990
   hub_event+0x1bd5/0x3ad0

Without debug objects the timer core later finds the freed timer in its
wheel ("WARNING: kernel/time/timer.c ... !fn" in __run_timers()).

The device is fully started at that point, so return 0. The interface
then goes through the normal stop path, which deletes the timer.

First seen with a TP-Link AR9271 adapter whose interface open failed.
Reproduced on v7.4-rc2 with a USB proxy that withholds the reply to
WMI_TARGET_IC_UPDATE_CMDID and then disconnects the device; with this
change the same sequence produces no report.

Fixes: 859c3ca1e460 ("ath9k_htc: Add a timer to cleanup WMI events")
Cc: stable@vger.kernel.org
Signed-off-by: Miko=C5=82aj Pisula <mikolaj@pisu.la>
---
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wi=
reless/ath/ath9k/htc_drv_main.c
index 6578114a4019..773787416694 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -970,7 +970,7 @@ static int ath9k_htc_start(struct ieee80211_hw *hw)
=20
 =09mutex_unlock(&priv->mutex);
=20
-=09return ret;
+=09return 0;
 }
=20
 static void ath9k_htc_stop(struct ieee80211_hw *hw, bool suspend)
--=20
2.56.1


