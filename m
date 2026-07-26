Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7141DE4F1
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070493; cv=none; b=pe3Ct6MfkFJyEVbVWJfR42PygT3HQo1CQfqfiLyhGfyLEFrSiu833CvBtOOElwE5E+8R1FjBeHiWr7HmfZE18+3M2/2XJgYkVCA28FE868aTzB2Q1Lqf1jpVoTDz+gkj1hQmOpwBg8J38ozHEgZm6XzB/Tdtsfko9DWSVsuq9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070493; c=relaxed/simple;
	bh=G/BZUXslFAgDtZicYKHg0W2DY3kmiaHszfRC3Kypzw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3c3wVFb+HfHA645pDaNFUxCLZkRVbvu15cO0jP18v2CvNa9WA+hC/pwr37cS7uTWihSq/qP4EYoM5iVTtSsPqebSWshtNsrTdnRj3eJXr5oyaDKa0dcbqiBXIJAGxjVAkK84KQqldTYeZHtkLY02m7en7iDvPcRftRMNNZTISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=hYLqkFYB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="hYLqkFYB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49548e01d02so9328265e9.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785070490; x=1785675290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXMJZ8+ajRgjYl5T9Gyp2DCx1T0UuYeHZUx0ld4Dmso=;
        b=hYLqkFYBgX1UoNDHCvhjDeAfktsTlotCZF+nlY5rlsMgd3BHCcEOx+OT/BMuzjW/f+
         Dd29J3NYeUcGlgYQmfyzvKe3nxxXx9O+aCKh/tmnAK+vgtkr59fgVZg7LVRJzc1OOymM
         5IqRUQ3W0P6k+Phnxy4yjsUVi2uJFY5P7o6QOWoD7o7Wigpr7NjnyXDu90XMiCqbeAwh
         lIobMQoE4m2g9S1RwRECNN35PsYONgTy2IOf18Su5nl2E+CGAFe1Hd4SnnIEeXre8/CJ
         o1zDKndrZHo35XJ9B7vdU19ZyS9MCxEbGTF5R7papc2ULovD2OTpcLusbxuPcSD56u52
         0MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785070490; x=1785675290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXMJZ8+ajRgjYl5T9Gyp2DCx1T0UuYeHZUx0ld4Dmso=;
        b=VPWk9KV5VErVEcotPqR3zNxm9m++YBN2Xzbiuon5ONYAiZG+ZswELgFwDjKTriKczb
         4dh9mB0o/3HKu8eEv2KjE82RarFYPPLrnAnsAPBD5qTFLiZx/aWo0vnlINDHcxSxZO45
         n8cQ0HIyOD+0/QGp+cnQIbXMr+OGZqVYqLIbrLQV/yw7prbT+/M5BlrwNjlrmazoNYeC
         0fVBGyaqESkFdmMyeRj789SiDLxGWu3UH3kweDHJkhCxqiL2Pv/VYIx3/IZ8AG2wFHcV
         MvBiuT5put4TzREDxtw+cnxP/uhGZ59Q6viJUqK7rC7wic9GzcX5nuUNtKYS2Ml7d7s6
         tYhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOfG4DE1IZkysogG0S5Vt5fv318Zk1WWO/6qgH1QT1Lxg54hI0D3MQGseYHahRDrkXx2iqbN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckpS18lwdfkz2JJjB12rotABAqHIkcjc5cj9tQGN34uQxjZmk
	rqoZW9NkpxX8WOZvRAAZiTEV9JXDx9Muf8G/FxWw6zbjGzpDi2OlyjkoBHd5g8xT+9j21hc6aoz
	1zz+YIQ==
X-Gm-Gg: AR+sD10acVGeKW14XmAcp35bTZokUZYpOpBTvhIItiT7pdC3N7oBCQRCPSYfpUgtO1E
	P+FcQHyBCjvgrvLlKPe15UF/65nwAEUrxo+jnBwILKbFN1Lm576a7feZiVsrbEsFEE17bHqsUVs
	p/fl15yKhYfwgAO+fqUjGSnkaaNWuAlVcljF7stJURpEoQ/MHdWb0uO0P/Hoc+/3TiDs20TOuWZ
	2+7lXdLG1Bh/+fpCTKtyrZNeU1PaaEEVHPciEpAey40vm57CMDBfkSqHVpKDOjBDFfGnR7axDZ8
	FuUosWzV4f0OXz5SGyVlBFla8KVU+2ZzYQcgq3ZjwNjeiuxv6YqKfP6IfBUeZcfibGbac0fcDY3
	0szbxG4/kuoNbFlAIQR1cKqzlz8s54Vrppn9YL/kWkRgdlD+vilUH5PeIkmzRr3G38xf3B987N6
	R6T/tW1zJWcnAWc7+zf6MD/zhdzePlt5LCT9JO+uPKEz5319QziYgkFRvAR9dquoEl3i67f38oK
	Tv9IiArEr9Nk4GZfNd+cv4ElAgQogU7/dk=
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id 5b1f17b1804b1-496b5747d8dmr70352725e9.22.1785070489769;
        Sun, 26 Jul 2026 05:54:49 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c67339sm42043563f8f.31.2026.07.26.05.54.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 05:54:49 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: xmei5@asu.edu,
	thomas.karlsson@paneda.se,
	daniel@iogearbox.net,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] macvlan: require lower-netns admin for shared port settings
Date: Sun, 26 Jul 2026 14:54:47 +0200
Message-ID: <20260726125447.32244-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A macvlan device can be moved to a network namespace whose user
namespace does not administer the lower device. The rtnetlink
changelink path checks CAP_NET_ADMIN only in the macvlan device network
namespace. However, IFLA_MACVLAN_BC_QUEUE_LEN and
IFLA_MACVLAN_BC_CUTOFF update macvlan_port fields shared by every
macvlan on the lower device.

A caller can also create a nested macvlan on the moved device.
macvlan_common_newlink() resolves that device to the real lower device
without rechecking access to its network namespace.

Xiang Mei reported that a caller can set the shared broadcast queue
length to U32_MAX from an unprivileged user namespace and grow the host
backlog until OOM under an incoming broadcast flood. A fixed numeric
limit was proposed, but legitimate deployments use queue lengths of
100000 or more.

Require CAP_NET_ADMIN in the lower device network namespace for shared
port changes and nested macvlan creation. Per-device settings remain
available to an administrator of the macvlan device network namespace.
This matches the permission model used by ipvlan.

Found by 0sec automated security-research tooling (https://0sec.ai).

Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Closes: https://lore.kernel.org/r/20260706212556.3199234-1-xmei5@asu.edu
Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/macvlan.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9a4bc99dbf53b..22f03b206c718 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1483,8 +1483,11 @@ int macvlan_common_newlink(struct net_device *dev,
 	/* When creating macvlans or macvtaps on top of other macvlans - use
 	 * the real device as the lowerdev.
 	 */
-	if (netif_is_macvlan(lowerdev))
+	if (netif_is_macvlan(lowerdev)) {
 		lowerdev = macvlan_dev_real_dev(lowerdev);
+		if (!rtnl_dev_link_net_capable(dev, dev_net(lowerdev)))
+			return -EPERM;
+	}
 
 	if (!tb[IFLA_MTU])
 		dev->mtu = lowerdev->mtu;
@@ -1623,6 +1626,12 @@ static int macvlan_changelink(struct net_device *dev,
 	enum macvlan_macaddr_mode macmode;
 	int ret;
 
+	if (data &&
+	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] ||
+	     data[IFLA_MACVLAN_BC_CUTOFF]) &&
+	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev)))
+		return -EPERM;
+
 	/* Validate mode, but don't set yet: setting flags may fail. */
 	if (data && data[IFLA_MACVLAN_MODE]) {
 		set_mode = true;
-- 
2.43.0

