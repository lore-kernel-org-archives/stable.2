Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033044AF148
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488226; cv=none; b=YLF1FVTYBHzpSU6btWMAeh4YzYTzEXNkcJG9gQKcrIt8Gn+fhATremWirdb7G5YBf1dNnRWkGb4cy58xEnClYaITQvoERTINC5kddboaF9DXQfzwPNrN7ocq+/w5HX3X7gQHyZxQN/+YH2/TWjG51G9hPbJZ1Q8foQI/ZaUrAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488226; c=relaxed/simple;
	bh=akz6aUJrU9noL7BHsmdBLUbZm7ypb5K09r+URlU8H/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHejehyPTBjilqe0AWukFcuMFYRiY9hFc2vkZNtWlijLMg6Q+Pu0v0LI202mlf64LXPdD0+FFRPv61L6zJstHfnoAArIy0WgnORuUsbHunFhRnIaRX21WysrHPuisgE3tzwhtzv5HTRDR2qy1vi0u2GuvklQ9QBIYG1rB89ulvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKlTD2QQ; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKlTD2QQ"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a6c77d255so1254816137.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488223; x=1790093023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9GyNMK0fri713TgvmOq1tEC71eXmhUWip0yVYKcndwI=;
        b=UKlTD2QQWoHcDSAKORijE3T5SpP2FC8yLQKha3P6ZMeIkiesNHf2uohZzct0ioprHU
         wZRj9C/Bbp+824m3Vd7tvtrl9pKlfK7+HyN01c9TvgPYcB06pEjeshEPW/yYHVF+Syi9
         SQ6zFZ/5pnJOvqiFNoSVfSap3U6ZnqkuId4eVvzNFspVDPfo37dG3cQCcBEeq2rJ9aKb
         5wIu4y0f2qssdNG7sX/AnBcfemh4FvBcc7A2wUHJO6RYPzIQI1QlNACaSZ708Q8psEYC
         +rvZ+n4t5j7aaX8bF92ieZBWR3qTyyMecE2ESSWI5koc3aYumm8UjHpiQcI7xAk0siVk
         3Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488223; x=1790093023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9GyNMK0fri713TgvmOq1tEC71eXmhUWip0yVYKcndwI=;
        b=g+UqMTVzwmK0lDk5pGtME2UYwysy4jCqmlROmg9aoGwAlAFimRFtWzMk9nEr5TpPrA
         wMG529Y/cHHdKg0K+z4Gf0qQVOJYU16FY0OJHoHvKDTrYAANmc6/YUg7YejFne26Kbbo
         85/B0UgrjoSfTUSdxupSyockdKpT3no8DCls9NHhtBcEWP9sw0XKgMhDKSezVM+fCgTM
         NFc9TZrUnNA7ND3gY1ZS+eF+mewe1pUiUPxvO00cXyk+q8eRlwYc1nQZT7mp4OoWZSlY
         vAAQCVoNiJvfDSI0fq9I+maL0Q6VWCAQ1rNkxWNgtWNDKGyzo0/xuJGSLG31pR3YZPYD
         cDVA==
X-Forwarded-Encrypted: i=1; AKwUvBxYjWb55VRNmyQpveBZQvttK+Pl+lRSCGGKaPZMHNVH7OVhzQ6JOC22slBQkyzXOl+Ymg7DQGM=@vger.kernel.org
X-Gm-Message-State: AFuF++mdg+QzQuVXl406+zmoL5/bal3jc8sy1c7hhEo3B4DTHA9RyEia
	g35OsAPwmmEtLraRNF9qMX3AkS4oKOqE/FXRZNyAP3i0eL9h681WvXSn
X-Gm-Gg: AYBFou3A+oml/OOvy5MoBMDMbpSgsL0oAIw3H0cWMZEZhhPKNg7WiW/gu9Ot5HlStID
	exNiE728luCMDg2og1M4xx4orAiQGnhyVCtwK3Q9FeI+a7RvIQgEArqGmnfqFuEuKU3AYmb88RW
	d3E2y/3ch/ftcYb+k0r/bdnOVbCdEmkV3lF/5hDV6iSTKk5P3qNGQ3Z9ohKXXZcwdrmz9IvUtlb
	di3heANPMbULmIQ9l/E+BKRToVPohy+EjdNnE+E7l/5scr5y0lkdCGjMSqs/Ew4Vc/Y4rNhkBKI
	WWsh7I1btoQy0ZoGABHknyCtDJpxQz+ISeX8xcz6o3XkWZ//uNBc2fUvmjqEdnGtjxCCX4mtKTW
	KRLp3CRknwsrI3Vf8XaEyjYOuPC6ML1jf6cK24aQd8ChcsuNv6SaEA6ugvu6nFihzedbmiyAuZC
	GoOQfrojz8L33vt+i+1wcQ1Nrccqn5uFPuavzIyFbhU63sqYmaPEc/+jxep8ZdqkuD
X-Received: by 2002:a05:6102:a146:b0:79b:b389:d6db with SMTP id ada2fe7eead31-79bb3a86689mr2219117137.2.1789488223464;
        Tue, 15 Sep 2026 09:03:43 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982b9fac504sm15052563241.8.2026.09.15.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:03:43 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] Bluetooth: ISO: balance the parent hold in hci_bind_bis()
Date: Tue, 15 Sep 2026 13:03:32 -0300
Message-ID: <20260915160332.3107274-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_link() takes a lifetime reference to its parent with
hci_conn_get(), but only takes an operational hold on the child.
hci_conn_unlink() later balances both a hold and a reference on the
parent.

The SCO and CIS paths pass a parent acquired from a connect helper, so
it already has a hold. For an additional BIS, hci_bind_bis() obtains the
parent from hci_conn_hash_lookup_big(), which returns a bare pointer.
Unlinking the child then drops the parent's existing hold and can
schedule it for disconnection while its socket is still using it.

Take a hold on the parent before linking it and drop that hold if linking
fails. A successful link transfers the hold to hci_conn_unlink().

Fixes: fa224d0c094a ("Bluetooth: ISO: Reassociate a socket with an active BIS")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/hci_conn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4..09a6e0240 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2342,10 +2342,13 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 	parent = hci_conn_hash_lookup_big(hdev,
 					  conn->iso_qos.bcast.big);
 	if (parent && parent != conn) {
+		hci_conn_hold(parent);
 		link = hci_conn_link(parent, conn);
 		hci_conn_drop(conn);
-		if (!link)
+		if (!link) {
+			hci_conn_drop(parent);
 			return ERR_PTR(-ENOLINK);
+		}
 	}
 
 	return conn;
-- 
2.43.0

