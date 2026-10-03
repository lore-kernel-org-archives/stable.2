Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331E412C05
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022947; cv=none; b=VCH7nKeY4gfiG6CfgnEBtvMbwEm+9Zs0Ha/8mzUi28hRhLSXTR8ffkc6ureBkg7PGyAQtlropP4CJsg+PJeslBHKwh9Y+r71D3OUiYS9GxXP9ZJUtoc2LKBD8ZQX3vBZoIld+Lv6W6cu51zfCQ1aMmL6GK4jWTwZ5awLUP0DTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022947; c=relaxed/simple;
	bh=9dbU2MdjPPQ+2L06YpaubCzSFA40VM5mN5AfcEjE9ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFNJN0vV//P+Uj9jozOYF1mvUNkMD8ohxj0iwduiQHMB6Eyj6UXirHK+uGvZ2a8uCFh6lbQsJd+BhODqD9gHkRT0g218/Ggg8DIc9mTCSsvxP+IPHxCDaAmQfpNf9ah9YQZXF8Tn+SJTmMwvW+7Sm+AiyRmUvOAJvX1cz7N5hVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWSkUf+P; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWSkUf+P"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a782e791daso189597a91.0
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791022945; x=1791627745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUMcFmx4x50WyYpp/LJX866o0Ow7gt7cpBwhiL0d2Ic=;
        b=UWSkUf+PEHylaSMq5Vy3FTo6DZK+MgmkajW2dK0w3tkmPO2Ah8vCiWtNwokrmiDXX9
         smeYQjm/1c1hTU4SPsYtq395XzCJok9ydVdda5z9aBXAwIQmL0HuJBRsfJ9prYdFPIzn
         ma7A4q+qebzcbf8pflOCi229JTJVJ4ozc48K3V7pheeSPEo5DmKayJCmqdP87LzL8WQL
         CWpVQ/vkfwM9G6b8qWc/L1cFWX2wTFNKTHt+fx3kZhfRs6ykB8GytJrLhgHtyAs5OR4a
         V4UIUGkPwpvFwR3eF6UKlTBvr/wkoQfcKThV46El7JYe4wgYRm8zNB4smGP9OpwTQexs
         VqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791022945; x=1791627745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUMcFmx4x50WyYpp/LJX866o0Ow7gt7cpBwhiL0d2Ic=;
        b=kNYN2tqccW4w3U+iNXX3iFu/c8dZdQYJFISCLKhCJ2VtMs1XHZ52ZDECzc7sDcspSa
         ct30FDgCklKNPA64D9Zx18Bm9VJC5U7x2wfZP+FkQAUOndX/ovHpTUoZ8Bwq8oaSMwmg
         G4RSpn235qT2q8MZ0uxEOV2I6H70he7RAG4/EQqCJFQJU3Y3mR/kBKDbwHWAdPXnBK+D
         gVBFyPNNQqRI2VGXUAfJCtoDUaIou5zZSZ+SpUOtZsWmxL/XdXm/wu0tvIVlvWR+wLGN
         jIaida1QPpsJolQeDXPka7jbpX4PBmnSvQaXXUHlI5/t5jkoJu39si/KDWuDPUeAhwEV
         QOSA==
X-Forwarded-Encrypted: i=1; AKwUvBxN+2Uv1q0UwToIyIBiD4t4Cf0biVokYThZum62Ruuozk124Sc665r8tNV/XCZCGOFX+jfEQeM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3o/k4Om9zL0Y6bYBznCjtM7FDYVjWYGr406DoZ1PeA4KUjLhO
	umlBaJMQBRF4ZRMToPEyp/eL3hEg/vjGBR62btz/7vYPZj/bue51YnkgKIciP7c=
X-Gm-Gg: AYBFou2xm4myYihsMyzC2hPG4rTOEExdCJRrVeXn553HA5QnZqwGoFQVHC3jcH/vMsC
	j+GKu+tSBAot+cCODsI6O8loDTCwFzGT3WxmK6EUMqoeBs3hkow8zWP+ODCbM1RyPumYiAsn+e0
	V2dBu2fWI6tZytKoRkl3/EOJpi0rN+i8lE6Pv5ZWrRwvf5ouKbAbbOL6czzNlzLWDHO+NOLSBlL
	78l0dVxUeJE9NhleotgNFjgeZY1lkzLX+FNyM+TwpXhVWNG3pm0kOs5Fjwq1ykznkYCcmf9XjMA
	zchlnTx1vfQSUA6UjpkZR3lcZHKTJWK+SuH6AY6vicpZwTodaKJFQpDkGmhzNN/D6McZaZiFJ67
	XWnL31zbn1eUztUKTWL8THL3BH24ygksDaYVO4nq0PInMiaehr4qOvwgt065WLE3+NEmE7Ty5jd
	+HqN+uHVhmDsw3NtQeLouJjlCa/Y3t0cEba92BGo3UWxtKrx3U1PnTcn1tEBJiE4AKyImXc80Yt
	8+moSDB+2O9HrBsE9RvymxG
X-Received: by 2002:a17:90a:fc50:b0:3a2:b70b:9cc8 with SMTP id 98e67ed59e1d1-3a7877462d9mr1377137a91.61.1791022945437;
        Sat, 03 Oct 2026 03:22:25 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79a98e7c0sm1240273a91.0.2026.10.03.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 03:22:25 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bhelgaas@google.com
Cc: alistair@alistair23.me,
	jic23@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's sysfs name
Date: Sat,  3 Oct 2026 19:22:21 +0900
Message-ID: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DOE feature is reported twice, sysfs_add_file_to_group() fails
with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
frees that attribute's name, but leaves the pointer in place.
pci_doe_sysfs_feature_remove() frees every name again when the device
is removed, or when a later feature fails to register, so the name is
freed twice:

  BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b0
  Call Trace:
   kfree+0x11a/0x420
   pci_doe_sysfs_feature_remove+0x117/0x1b0
   pci_doe_sysfs_teardown+0x90/0xf0
   pci_remove_bus_device+0x128/0x2e0
   pci_stop_and_remove_bus_device_locked+0x1d/0x30
   remove_store+0xd2/0xf0

Clear the pointer after freeing the name.

Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
Cc: stable@vger.kernel.org
Suggested-by: Alistair Francis <alistair@alistair23.me>
Assisted-by: LLM
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Changes in v2:
- Keep freeing the duplicate's name in pci_doe_sysfs_feature_populate()
  and clear the pointer, instead of leaving it to
  pci_doe_sysfs_feature_remove() (Alistair Francis)

v1: https://lore.kernel.org/all/20260928035035.252394-1-donggeunyoo.kernel@gmail.com/

Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
reports its CDAT feature once, so a test-only change either registers
its DOE capability as a second mailbox or inserts the feature N extra
times into one:

  case                                   before           after
  no duplicate, remove                   no report        no report
  no duplicate, a name fails at probe    no report        no report
  two mailboxes, remove                  double free      no report
  two mailboxes, 3 remove/rescan cycles  3 double frees   no report
  3 duplicates in one mailbox, remove    3 double frees   no report
  2 duplicates, a later name fails,      2 double frees   no report
    probed twice

The doe_features listing is the same before and after in every case.

 drivers/pci/doe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index ac95b1d2d9997..6b5d9ba8e9697 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -208,8 +208,9 @@ static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
 				pci_warn(pdev, "Failed adding %s to sysfs group\n",
 					 attrs[i].attr.name);
 				goto fail;
-			} else
-				kfree(attrs[i].attr.name);
+			}
+			kfree(attrs[i].attr.name);
+			attrs[i].attr.name = NULL;
 		}
 	}
 
-- 
2.53.0

