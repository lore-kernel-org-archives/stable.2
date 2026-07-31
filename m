Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91892331ECF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479564; cv=none; b=PuI/0mvnXfxK8ei+mLyH9V195CGZ3ESRVYPpt13YLi2s96uk6IjvReceZPL0m0qist1HiAKb6m6Rseq+9ysr/P0VGeosIs2Icg25NtY3ihG8KS9Bk3lCyNVPuCFJGdtJo2XeNIwvW3VE1I0kIevX1S3RCcwc9zT5Ap8ipwuaH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479564; c=relaxed/simple;
	bh=ofZ15thW10V3Oo1i/JC03bWEaUctqtD54+OnPeFR1l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn9KcwfudRj1qgWas+S5rwvP/YXbm4zvhAklyiDI8bdMNqb3q5JjduvbMGk8NiEZt/4j1M5D+SQDPEXUOVunJB+4ZPkhInt9BW8ukxgbwMFU6CkMV66x5DNZgJ0lDNzSeJKDDbnwpY1e1LyjwB8q3Gf2CkxbOGhisLMypCmLC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qER5XtHx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qER5XtHx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso326423f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479560; x=1786084360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dxm2yKlW5AqKAUFOXXuaAiGhenk3HP3ULcfm5FsuF8M=;
        b=qER5XtHxak+wX5xAc+0wZIc9vSqLu72bk89pmoV80yKuP1/vAlqNpIfa31eAQk8xpH
         aQfVqceY9N3XndCOgIB2TTyIPQIJzqi3r73hDw2/btklkrsfdD/Y0x/0nUb550Yrs7FC
         +2g/GePj4dsonuugx17BDJ+CJXt/cxqIR8FtGLXBQgJF7av/NmOb/o6cTG4ZCtrMGUay
         Mmjxjn/4omCPgWLQaPwWhY64iiyu2hHP0PSI2QkPiIid2MEAnDD/R5JlBGbbWLlBFGdK
         7wvTd9slxav0BqueKknlkmVPGfpGklSg1S9z1FrIRFJGl7oC51DT3vX2DNafaUldh7ix
         X3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479560; x=1786084360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dxm2yKlW5AqKAUFOXXuaAiGhenk3HP3ULcfm5FsuF8M=;
        b=UHFQhbqJl8S4mqPCBy08k5NoZFEa6TQ0d4DaXBikUGehmP0vl9+HqMyyrGVQYSDI8N
         n/Z+2M391HOytfGWisYgSxgETPxugA49w3viiwPLNhFLlvzwY79M15rwTts1bwxTlv+R
         f4oMMEFtg+d/u+/HTtcJIIo2aZiJujiLsH+LCxY4id5dLrK/LV5ycbTBxgrmEGJVyjsL
         Kl4tCeKI8OKLSAZ2mWwCNn69Ywp+PXYfR6FDFB7FBcPcSmyswP7rTe28vu4wfBtU0IZi
         KagtMINMsuBrqQhKn444zIw2UKuMVeTmiiE/aPp5IJts1ob23ibZzmqh0LvKi6q2e6CX
         YRyg==
X-Forwarded-Encrypted: i=1; AHgh+RrP3vbw/vL+oVMQNkOHabJV6Kw7W1XtKgp8yFf7ypydG7Ex5qOT5BYdBEvG9cOw3xP+D0+zD9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdetxEltg52PawLXU3qZ8GgQb1nSSoBH4ZgO55HnHOvSqpXxD
	pCdPKabN+166n5FeNlAcioGDG64pWvce/3SRQ7pLEh85Qz9LPAzCXD/T
X-Gm-Gg: AR+sD10EttufTHXInktMnOqQMSYWMl8TTjdvI1ftUtdELbe1XfZMpFSpZPIAAaDYPgZ
	sNcoTGEls7rxPjSp3xoAHJsiy0IeF61px1PpER7lRj7MfmJjlJ7CuEsON2CGvICIqJFVq7L3og6
	ErOSkldhwemRIIzy+yyrLdgGoiajogh5hlQD4BJFqTo6vj5W28gclOURn6iGriZNqHC/uJIhuBI
	UA5OB89Q3MKKcI6iF5je7BVWeQTrHNUKdkitQXTbDadY3ZM9bxf5QyQQ07QgTzsegqZDQAZWVm2
	oIyGf135OT/8tnjuwqz6kcP+CEOwEd7argntVyugqc15AzseWIq1JYscjd7of3lnh5dKPJ6KtWg
	dReL7Q2cvwylyvkjIqpuaz0D6luEi7lKD4spGSjnOZ9kO0uEQL6Et8Gw1hEsFAE33oPGQuVf+2K
	Ve+gHGvVpct+Btzyl8oMN7gm0y7f81y8dp0OBchsyxRyuapX6vCdKhPwC0mtflzdTPbVmy1mR1z
	vkHKgWwGiDPaDuzr5soEjhU+FsdyrQXBzXdqStalf7GMWn9DNQakdQK9zwaXEXVuwkayI0G9LFi
	93YBGUvbhLZ0YyiuJw==
X-Received: by 2002:a05:6000:717:b0:46e:230f:d095 with SMTP id ffacd0b85a97d-47fd2ab9d52mr1895019f8f.7.1785479559600;
        Thu, 30 Jul 2026 23:32:39 -0700 (PDT)
Received: from localhost.localdomain (85-118-77-64.mtel.net. [85.118.77.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm1188418f8f.27.2026.07.30.23.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 23:32:39 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	chunfan.chen@gmail.com
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	wenst@chromium.org,
	rafael.beims@toradex.com,
	avraham.stern@intel.com,
	peddolla.reddy@oss.qualcomm.com,
	error27@gmail.com,
	s.kerkmann@pengutronix.de,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH v2] wifi: mwifiex: ignore ROM regulatory hint on WRT3200ACM/WRT32x
Date: Fri, 31 Jul 2026 09:31:18 +0300
Message-ID: <20260731063118.26171-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <amsBes9fCF9ZdkCS@nxpwireless-Inspiron-14-Plus-7440>
References: <amsBes9fCF9ZdkCS@nxpwireless-Inspiron-14-Plus-7440>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
from the mwifiex ROM, which conflicts with the platform regulatory
configuration on units sold outside the US market. For example:
- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
- phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
- phy2 mwifiex 2.4 and 5 GHz, hard-coded region US

When the system boots, it detects a conflict between the user selected
region and the radios, e.g. BG FR US, and applies extreme restrictions,
preventing use of 5 GHz and DFS channels. This also affects phy0.

Ignore the incorrect regulatory hint in the ROM of these devices, so
userspace can set the correct platform regulatory domain. These radios
are locked to the hard-coded configuration for which they are certified,
so the only impact is that the region conflict is avoided and the 5 GHz
radios can be used.

The change affects only WRT3200ACM and WRT32x routers, and helps
overcome the incorrect behaviour of proprietary radio firmware.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Tested-on: WRT3200ACM, OpenWrt
Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
The dts files on Linux use only board names. A patch in OpenWrt adds
device names which are easier to understand. If we want to be compatible
with both, we can either use board names or accept this patch in Linux:
https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/patches-6.18/
311-adjust-compatible-for-linksys.patch

I implemented and tested a better approach with no board specific code:
- check for a device-tree flag in mwifiex_register_cfg80211in()
  !of_property_read_bool(of_root, "marvell,ignore-regulatory-hint")
- add this flag to the root device tree of each affected board
Currently this affects only armada-385-linksys-rango.dts,
because Linux has no dts for venom. OpenWrt will take care of that.
This approach is more flexible and scalable, because the flag can
also be used in other drivers, e.g. mwlwifi (not part of Linux).
Any help is welcome!

v2:
Replace the compatible device names, which are currently only available on
OpenWrt with board names which are available on both Linux and OpenWrt.

 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index abc703441c5d..ff6a22237a0f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4899,7 +4899,15 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 				country_code =
 					mwifiex_11d_code_2_region(
 						adapter->region_code);
+
+				/* WRT3200ACM/WRT32x ROM always reports US, which
+				 * conflicts with routers sold outside the US.
+				 * Ignore this hint so userspace can
+				 * set the correct regulatory domain.
+				 */
 				if (country_code &&
+				    !of_machine_is_compatible("linksys,rango") &&
+				    !of_machine_is_compatible("linksys,venom") &&
 				    regulatory_hint(wiphy, country_code))
 					mwifiex_dbg(priv->adapter, ERROR,
 						    "regulatory_hint() failed\n");
-- 
2.55.0

