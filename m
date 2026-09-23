Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC263BB678
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141483; cv=none; b=DXaoTPM1Efi7m89ENiELGAqbub0knpUE3nFAC7CT1om09UvttYv2eWBttLt9kGRP25glOT7FicE6S8GjY0Yxfy3N0ps0Jgc0/bUgyxKJLDnzbKhzmLLFH2QOtir03BTMiXNFcLkJKVbvjFYtcAHH4ym24wGEtO1pQ09Mc1CR8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141483; c=relaxed/simple;
	bh=ehFRQ3FZleExfRY9jjlGGdk7L45AX2N0aVofYNFEIo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cil+pBvu5mWoF+C/CfDIkZUsbRq2q4VcY7S3rChccXKx7hLqpHR27723IkgYSoRPRWQOY9bMbzdj7dWtckI6EyjfHKXj+sV7kqQtDfHeoYR9S6PnktKE0U9p1a2K7XxO3DnGeIUkJ8p5Zkj02Mf/UH5C42QRY4JQQqOqud2Khfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3vOoP8p; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3vOoP8p"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530301ff353so8300481cf.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790141481; x=1790746281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFpOg8k0FRJ6+H0KfdVDioIX8p2jh6VxkW8sAx0q0/Q=;
        b=j3vOoP8pRQ9BrhOxrhsotlGge/xt20Jlxm5Nt86aYCLgHFxNiMPd9NHQn4oBsUKTV1
         0yTWOQWWhv41ByQcNsxtKcXxhl/Iow41OJo/XSeAkwMgWj9BLy1jKvBKxnPsbovWUxOV
         X5tnVC+sbaU1pnEwMgxuIkc/4Zh1joO+c47jBPoGFjZMZj6Cv+rFT+EFeaK/N2FOPSj/
         8JzxcZ3R2b10bGr05jqSXnwU3epbhzDFZIIVP4UsXWha2mt4NVGqjwVD4+vNLlW5n1Ub
         w0m0b8avXtYVbMDrrAPmfhXaJ2Z7yYXCto5JnBwz9RfEGk/UAild135OWfzvxXyVFXKk
         Phhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790141481; x=1790746281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFpOg8k0FRJ6+H0KfdVDioIX8p2jh6VxkW8sAx0q0/Q=;
        b=A2DR3AlhXMkpeWhU31fWx/B1K4NyB5kS2SqI7IQGOSR91NUY8hju/abrbZFPRhtdn6
         x3bPdK/8pKYNMyG34OeTsr/wjfHIohK5IDf+vWETIfkznsnX3rmoe7nD/i85sR8vfLya
         zR6MuknnoU6AYj4fzt6PKRKGMTANU9aXADfRc/gKNpr7mh4URQ0kPthZvpGbslhWiUQp
         nYh5BPHtWJpcb6P4D23Xw1lAUxEMmMvtp+YhUmyEuQJyp89wmuB5B7b4hvx3f9ifoZq+
         N2kWRdUFXPgIWIInsv3YT8KacfEyr+LG5M20aE8Z1mFSooE/3/HLr3NeJS3goWTsR/ak
         1imA==
X-Forwarded-Encrypted: i=1; AKwUvByyjLxYx1MqgGt6z7R4XdWz7oFVvLxF/HH03ennzQKr8siTMLbL2YwbVSgAwKX3Vp9ZP6FyqDE=@vger.kernel.org
X-Gm-Message-State: AFuF++kJkaUO/8VcbArDVZ9JlLz6iqsNJzWh3fxxRz53+A2TjQQVbO0r
	uiN4ZzgQ5L6pxRIxImA0mPI97cUAKkwSz1S0nlEGF/rwx4LeMIMBMi0=
X-Gm-Gg: AYBFou3PCV4vha5V+vEtkh5lZzySxW4ggPw0+ztQxQuG3tHD5ZXT7lMfbLdRwS7fy7N
	vBYt7xUY4Vg/Z/0wGTTQpbx1y5whb4Uh9bSW1Q3FCCq0v+4ZjVNyUD6xfyrj/0SH+G7aCp7A4IV
	b2+Jwz9S1IJpwm3Zil8nfb4vO8LtCXpRxXfMgbxK85CZ5bJOce1XFzRA+239Zoee3ZVxidNlIVx
	EZrIvJtmnvodWNFr1ucrDUxdcU/9kIdO3VaZUM9EfG9iGVd7egDYrl3zrg+nwozKLhgfsfQkANm
	nJyZi+BaIFJk5KKF87QDEwEskd12EOfdIA4XX9/PHQezboEyltWffd4oeHPNZTcQNiQBHf9h4wU
	/zL30+9TG4TQNWEC19IWuRYltGfsdrQw3ZV4Fk1nxot0lpoDGSw8uYpSj0Y/OtsAdxMUX1enSX0
	FPtKDgrGRAkuaLcadmPvoPKitQxSIT5NTj7Dl0NorUG/ZyLXz/MXw06feyJN4+EX6TL+aZvopnE
	IkuTCJExlfygEWoh2ubNVmvW6p1eLRvD2IfhMHXgDDpCWz9KQsD5MYsOMJwd/abwZtaR7G2e/JZ
	2EySgqdvCbQLgSd8PNq5eePAV6b33uuZz9zpZmVhCAuyXoKtMcDldRA+UYlBMskm+LTa4MV8e2R
	+5RhlhdX4ERxV
X-Received: by 2002:a05:6214:4a81:b0:910:3de8:177a with SMTP id 6a1803df08f44-9140c368a32mr24771786d6.16.1790141480528;
        Tue, 22 Sep 2026 22:31:20 -0700 (PDT)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c2a71cdsm13876646d6.3.2026.09.22.22.31.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 22:31:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: host: xhci-tegra: Unregister OTG notifier before cancelling id_work
Date: Wed, 23 Sep 2026 01:31:17 -0400
Message-ID: <20260923053118.92147-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra_xusb_remove() cancels id_work, then calls otg_set_host() with a
NULL host.  That leaves id_nb registered until devm_usb_phy_release2()
runs after .remove() returns, so a role change can queue id_work again
and use the HCD released by usb_put_hcd().

Unregister id_nb first.  atomic_notifier_chain_unregister() finishes
callbacks already on the chain, and cancel_work_sync() drains the work
they queued.  devm_usb_phy_release2() unregisters again.  A second
unregister finds no entry; the wrapper discards the internal -ENOENT.
The devres entry is still required for usb_put_phy().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org # 5.7+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/xhci-tegra.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 6f235d1e117e..f5894f2a5991 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1542,11 +1542,20 @@ static void tegra_xusb_deinit_usb_phy(struct tegra_xusb *tegra)
 {
 	unsigned int i;
 
-	cancel_work_sync(&tegra->id_work);
-
-	for (i = 0; i < tegra->num_usb_phys; i++)
-		if (tegra->usbphy[i])
+	/*
+	 * id_nb is registered on the PHY notifier chain by
+	 * devm_usb_get_phy_by_node(), so devres would only drop it after
+	 * tegra_xusb_remove() has returned.  Unregister it here, before the
+	 * work is cancelled, so that it cannot be queued again.
+	 */
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		if (tegra->usbphy[i]) {
+			usb_unregister_notifier(tegra->usbphy[i], &tegra->id_nb);
 			otg_set_host(tegra->usbphy[i]->otg, NULL);
+		}
+	}
+
+	cancel_work_sync(&tegra->id_work);
 }
 
 static int tegra_xusb_setup_wakeup(struct platform_device *pdev, struct tegra_xusb *tegra)

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
