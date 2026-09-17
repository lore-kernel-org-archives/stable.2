Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDF4BA9FB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642336; cv=none; b=aWrz4GwWwH/FXUxI8o4cyRuZaPqKbwFpVk9yoVWSgBc7qKTU+oyNoGkLJ199EWR5qTG3C/cwp3/ytNvBbA4uCJWT8s4WTK/JZExaawF6sEt73kJUTeH9spNAaqvnV9HFzRZcLA+yJEUSBt2ZZaJ2ZHtC6DNhBAMtvyMfE3955uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642336; c=relaxed/simple;
	bh=JdCRFDcolkURErydh36AhWOM371Zu8e2GX2loPhofOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8UX/xz4pO3rr/XrCWjdLgTzC6CEcaJzaMZXYkp2Eh7S88lG/G1sKgo7OwT4DA+4+Z6XYf2ji5JaqZOIQOAly+2XB9lHH3eQMpTVMv7g3FDKnqYCpAONKjUbiO2u4GwSdleUpO5DmJwCDCpgHN1o2q9BwvSYJtEslself5y2X1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9MSFhF/; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9MSFhF/"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d440939f0so3851677b3.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642332; x=1790247132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
        b=s9MSFhF/vfOf7N0h+ty6KzNX+m2iEVRxzV061KtYyQ7ytdPF82TgislepHJNCEk6e0
         XcZLYrt+xVYiOjbCT65Qu5zKCM7Nq0p+NRGtVFxE88ZXYjdNZNAahcDUPgHoo5j3XoqL
         i8kdbfDSPd2VvQf/wYK7mG+WB7vwQ7zwkSpbrWXS/kMYq/PntVOMBX0OHAn4UMIK3DCP
         P16hQ5kkYczSD2743uMORDnwCZQ/YVD+D9A5WWa3bUrsGC1q1S+u69RWBsHXsfLvFpG9
         8fn2CS8k1zk39S3VyJ9lmU8iesJmC/Zvwqw5FpYhawM0zBk5geQ9rPBNe2q+4orZ2INk
         HFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642332; x=1790247132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
        b=RWjd/kGd8yu6y2UzEIeZoGxeqaUUwlC4Z6V3RElpbm92lKIyLgao7lrZx2ITnyr3RJ
         jiwiPNxD2bkmN2WGW9c7czkAvK1skEGpiKg6hadG0+SAsOLRKCmC2tMhH/e1P5M9ZZU3
         VO6JVu07A5XC7e9seTdCXK8fBzxOmo6OZQRQYPgEgJoV9kervL4gylpCE4qmg8KjLdDr
         /fwC/3jLWuyTJRhZBrXkZGnQqIhoLH5YmfMUquFAZ+gpQFAlfDp1q/oo3sv/yjZv6AAc
         G5Nwc+Kxy2vMUhO4s9xSkewLNEbqAnysitY0VBXs479Z8sGw7z76ePUu8+mjgrB3qGL6
         SP3A==
X-Forwarded-Encrypted: i=1; AKwUvBxvcTEW29VOgezmVL1kCFcH2BNjbgKvsPJF2zNVK+SiXzmCifqbCIZRczE/x51wYOFEc/qsdlM=@vger.kernel.org
X-Gm-Message-State: AFuF++nNOn+MDLtRdKAVBGaXEN/+7JblQ2A+QIS3i4LYECAj0L8KEOkx
	OAHIXQaupOTzsHQtOG4EJ1AKHLRGmf842PF/CDKSIK5hYLV8Tj/DBhWc
X-Gm-Gg: AYBFou2d0w9zxQtN31Khj1ehqCoO4j0sV4UqyxL/VJFbeHGskFEJMP47M5Isg0DKngV
	Lj+88coLlu7MMy9XEEN7YuiCey+WW4yh0N52i3cW5s9dl7oR/stZtSdsGRSf1Ad5mlFMlumF7Jx
	vPHrfLuH47HQq3DJgA7RLJAXDpcRtR7XFFDH8fip7RzynG5oTGIQE4aXcDJpJr8zoYY5JPS+bUk
	B9vrcf2vOo/lZ54nzKj79/MX1LHWl6mR1jefK7J2ycIKq6mrgiG786lSFmMTQaT1dHougZEEynr
	bh+IEK6epq/DQVuF/enFFpoCJOIK5on+JJV9R4F5D8mnEICfyKFlJPXXgbwRIvYF61fAJFGTN6L
	tyfmSJqshcYMc2pRx+ES1ueWwSl0Gqzbd8lfzU5mKOanu2H/Vy53bRJ2yHouf0Jmi86fzk8X4iZ
	BqTQEXE9Z7ppYLdR/UJhgZEBYrLoqweTjyoo42FzYZAheaT6ingP5qBPoxhIYozQ==
X-Received: by 2002:a05:690c:c50d:b0:87e:2404:444d with SMTP id 00721157ae682-892264eedcemr20325507b3.59.1789642331820;
        Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8928ff17829sm13960517b3.40.2026.09.17.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Greear <greearb@candelatech.com>,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] e1000e: fix NETIF_F_RXALL buffer overrun
Date: Thu, 17 Sep 2026 06:51:44 -0400
Message-ID: <20260917105144.11308-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SBP is set, the card may deliver frames which would otherwise be
filtered out by LPE being unset. This would allow the device to write
up to 526 bytes beyond the skb's data allocation: over its own shinfo,
and beyond. This bug is reachable only when MTU <= 1500 and
NETIF_F_RXALL is set by ethtool.

To reproduce, build a kernel with CONFIG_SLUB_DEBUG=y and boot with
slub_debug=FZP. Enable RXALL with 'ethtool -K <iface> rx-all on'. Leave
MTU at 1500. Directly link with a remote machine and set the remote
link to MTU 9000. Send oversized frames from the remote machine with
'ping -f -M do -s 8972 -p 00'. Unload e1000e on the machine under test.
Observe slub_debug faults in 'dmesg'. If IOMMU is enabled, you may also
see IOMMU faults during pings.

Fix this by ensuring that buffers are large enough for an entire 2048
byte chunk when NETIF_F_RXALL is set. Do this by moving final
rx_buffer_len determination to one place, right before RCTL.BSIZE is
determined. This will correctly re-evaluate every time the adapter is
configured, not just on MTU change.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Claude:claude-5-1-fable
Fixes: cf955e6c96cb ("e1000e: Support RXALL feature flag.")
Cc: stable@vger.kernel.org
---
v2:
* Don't make a new function for setting rx_buffer_len.
* Rewording.
* Add steps to reproduce.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 41 +++++++++++-----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..f31dd5886b09 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3094,6 +3094,23 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 		e1e_wphy(hw, 22, phy_data);
 	}
 
+	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
+	 * means we reserve 2 more, this pushes us to allocate from the next
+	 * larger slab size.
+	 * i.e. RXBUFFER_2048 --> size-4096 slab
+	 * However with the new *_jumbo_rx* routines, jumbo receives will use
+	 * fragmented skbs
+	 */
+	if (adapter->max_frame_size <= 2048)
+		adapter->rx_buffer_len = 2048;
+	else
+		adapter->rx_buffer_len = 4096;
+
+	/* adjust allocation if LPE protects us, and we aren't using SBP */
+	if (adapter->max_frame_size <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) &&
+	    !(adapter->netdev->features & NETIF_F_RXALL))
+		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
+
 	/* Setup buffer sizes */
 	rctl &= ~E1000_RCTL_SZ_4096;
 	rctl |= E1000_RCTL_BSEX;
@@ -6079,30 +6096,12 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 
 	pm_runtime_get_sync(netdev->dev.parent);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
 		e1000e_down(adapter, true);
-
-	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
-	 * means we reserve 2 more, this pushes us to allocate from the next
-	 * larger slab size.
-	 * i.e. RXBUFFER_2048 --> size-4096 slab
-	 * However with the new *_jumbo_rx* routines, jumbo receives will use
-	 * fragmented skbs
-	 */
-
-	if (max_frame <= 2048)
-		adapter->rx_buffer_len = 2048;
-	else
-		adapter->rx_buffer_len = 4096;
-
-	/* adjust allocation if LPE protects us, and we aren't using SBP */
-	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
-		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
-
-	if (netif_running(netdev))
 		e1000e_up(adapter);
-	else
+	} else {
 		e1000e_reset(adapter);
+	}
 
 	pm_runtime_put_sync(netdev->dev.parent);
 
-- 
2.43.0

