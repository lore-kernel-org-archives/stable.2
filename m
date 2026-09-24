Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184474503E1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243567; cv=none; b=tbI8QE01fZVBr4WoDbZeaMnkRoX1V5WAZFo8Vib7JlU7CQHDsqYndODs1PHnrDJK5QxZkBhzcbdTpPjqfK1BnCzz+FZRTggkm5i7Rjn+Zce90f8RvGR7L2iBKY0Glmthcx8+Jk+D3Qb8V8hNowc/s/1GnSJgb1q6gAQYXbpS29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243567; c=relaxed/simple;
	bh=rTAeLUGzo8r0TuAfsid4fA9EZfYaJkVHTjAke4swyEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5sV0bkGfPlvzuiBhOZhpCSWPT0WbNqfgQikRux/ltbq9pXCsDgTk+aD9JqWgLpOkghcWob70fgbIJsBqJvxQhx1Ctv5FTDxsI2Ht2nn414u1xMDMK6a2sSxSWbcdjW0q36qfRIK64jSE4rU7eamMhBO2cENqOgniwXx1Br+2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjG0On4e; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjG0On4e"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so3052126a12.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243552; x=1790848352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
        b=LjG0On4emcLI8kw9inSbg0s8NyiyFsncnR4iGuF+yi1U7P/IKMhYtIfs6I/O1soFzR
         TzxDPQF5W3ah2tDM9ARi+4UOnEZjsfo5qsSCtwrXIwgySnv50IS6FH7PPkotIWyKA8Mw
         jrKVbjwPFzJkfIVLJWv7tNS0P0VW4U6YF/gyvzfAGUhx9SfTOjLH3DWABEUtbV/WQucW
         SBF74PTvOk0gfEf8Gx1bNvkGdC+Sqao0FC+DfdN6fLr/w/rmTvEMHaGj2ka4t5hILssO
         uSD6WXlh0ENeMgked2Grc5oPm9TKukVSn0gZD0A/IBtAExu32YREh8UDDDnmBuv3G28H
         S4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243552; x=1790848352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
        b=Qad1ZqHYIszyQXkklb+c35fMClezqh7DN9yttPpFk/4yeLrQNooV6InbpdwBMsWiV1
         x/UDq6TALsBDooyiTiYfHi7PMSG8lc6jDF+j9rRwDWxOOWd+fQ1JFO/YhJWQMYNVnq6I
         EsW1WlX/4bTYwPFgGHvmU14xzAcczAMnLVxwm58TwAUmBM6YRCq6R6/YAHdbCPvlW8VK
         PkGka+X28feTHUfl3LkrnoEwyaX01BG805mgmUIpbw2uQRRPJ2AjRMznqFefH5Rx6lkp
         nBTvaS6VREB+DUZwmT6Ir3daNVG4MpEXppytSMWHu+rwUxr4h02YxNjHsnCShGhhgGE5
         cv9w==
X-Forwarded-Encrypted: i=1; AKwUvBwJnAm2StCSBFuSIiIgNQ8HQYJlghJn4cSxRz+TfA89kaaRnp2sUn6OL3duijUuH3HuSC8fwYs=@vger.kernel.org
X-Gm-Message-State: AFuF++lTWNPTX9ssB8ZelFvX8cTZFqiOJc6f+c9KerkmNr7uCtNzaYfr
	XYEn+e68d6mh0v+TeW01IOpr0WhLOeMLfFaTT6hfAObZvt94k6qGfPNR
X-Gm-Gg: AYBFou3yKoOS7k7uGfwIdS+Puxzx/+AA3f0jQ9LP/z681FXBuYLy3VaDGT8q1Gjxh6W
	/sW6Ys2MPBZEiOXT5WJtOMlCwd4S/5IMAAgwofcvZnca9HCvAPqGjS+9/RSJ0U9rgxA2B9hpTmP
	NGIeAjGwUqDoMpX+m2SpSyEmaCWvvYxu3vmMMB2iIbPTYbw8naqwyG+xvzJ7AURinu25mlf6vpY
	VgA28PNkt6aA4dZVP8DFs6jrK8YHirPeGiIPl3mtixG49HS5hHDEmQ7ml60YYvfTxyFxUBg0Iyf
	vM1GknAQUxCBvhMyZQFLdjZ5CyFJog1yGb5Khr1YVsJdFesfWHki/HhFF6bh69IG5I/9nFWBnKs
	bsovveGydxIszsXNtydXD8KdP/v9GN3c8RKO1Vmjp6bNrWrMBtcFnAsk0pm0gw/0TWsghXmUu9K
	f1soPlaLr+cbd9y21dR28MYuT2XUY+IYqV1KsMNQXz0afZyjAuj53E7qWmSguk4eRKlF/Ys4u9O
	ILSQ1CEP2m6+zws
X-Received: by 2002:a05:6402:4502:b0:6aa:1c28:81b6 with SMTP id 4fb4d7f45d1cf-6aac8f546fdmr1573268a12.17.1790243551492;
        Thu, 24 Sep 2026 02:52:31 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3506813a12.8.2026.09.24.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:52:30 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 24 Sep 2026 12:51:52 +0300
Message-ID: <20260924095152.3069-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When e1000_probe() fails, the shared error handling ladder attempts to
iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
not a CE4100, this pointer remains uninitialized (NULL). On architectures
like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
which is fatal under panic_on_warn.

Fix this by conditionally unmapping the CE4100 MDIO base only if the
mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
be valid for all error paths reaching the err_sw_init label.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2: 
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

