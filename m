Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749A3932FF
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116659; cv=none; b=n18EYyxtU9JOhmUInqgDLc7a0rV2GJWePUEOoafKtwlB8HiT7wyPs6KQHq5j4mmMcuMhO9kZiButVbktpV0TLRGxfF2dzpOj7pt0eALuiLAGv4QSJCAF5YRI4Dk7NqfgqvLnjCNheStxjbQeYs7Wx7oqLVAovfGqRKN9SWmohOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116659; c=relaxed/simple;
	bh=KW7Gxhb9Rs7qDsVvu/Q6QOOYw2rabRWMk5SbCksXKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+1d6i5rtF271/oa1s0Qo3p3bLrBwsNTjPwuTYC8Ykjv8NffRrrM/tmmV9h8exXwxwtplexUuvzHYDaiwn9DdvOIWzYEAKtESWBOMvFNHPYfVV5MUWUsQ9pK52VzSEiHBkKUVSTO3lsNKL3fToqheG7IiWH51eJbqhzfGH7tLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=eb1ZUjcB; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="eb1ZUjcB"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so4869426eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116653; x=1792721453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cv7YGJljtETyHQvSebav9gk0BxMvhnrylSgDpKzc0l8=;
        b=eb1ZUjcBOQpCvH6YlIrE4Nbd+BbLhike/naXXFfZYDLEKxkqwFtS7mHeONUl1mfOTy
         ugys6CgeQL+rv5WEb4kkE8oD3TtRulRoHLHUtB6ev+uMIf8Yeu35/DUKcR1wxYTZ9c6X
         qZb68keuuwpfyEsvjh13cRqiF7ZRC8FHvlyFp5AVKfyz66Vdf+eGY15GO18qJTJFx/VP
         /q4nFquEjqM81gHRPw5v9jZn9HqFY+SXutmS//HY2mUjtdPsC5FBJJ3AH7oQFwGPVtSj
         xdsV3yIVVEzMPPE5N0/MkE5mmqzIYyyZjWJzOxNAYBcU+HUWP0q11awxxTsxo82RNRoF
         lt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116653; x=1792721453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cv7YGJljtETyHQvSebav9gk0BxMvhnrylSgDpKzc0l8=;
        b=v/TaPSK9mCoGlqPBYfCDKtph1QWwKQQo1UEVhse4kO5zBL7JDYWNYBd7iKfwhufyjb
         ueoq6KVH/XByNa11Ka3fxPPIg7VubK2zgsPZ1yCRvtcWI3582OhkwL1Ojq1F90TjdFgx
         VExPvoHxolTJlAv5LrW+6X452sAot3RRmhJ8zB6Tn5EoHVPVY+yYaWVg2chWFGCUoe5o
         XEL0tB9kZoM+T+3a7FIK5oZU6dx+nyrLOHTXVSCxih3uUmHcpKzQKlVtNOj6jQYIR0QC
         nkQ/J+zgs0qOkm4J9PvYzMtqc8cksNGH/8pZ13cYsrB1qvwdQS6QhUJZ8bR6+EBDll4r
         rELw==
X-Gm-Message-State: AFq9FYITx1dptlPiVey1lmNnDev9hzlB9Dn603T54NudCRRymlSqGNYy
	SaGPiYBqELlOA1z4AxMpnvw090wwBstBKdbzEQBJIdZ/g34p8VIuc6oQjYy7nDmsUXuSnEg71Z0
	ykPjgcOGFDw==
X-Gm-Gg: AYBFou2PG18hpeK5F6dZ6MPbLzA+BdRyuUvXagDuHZElVKlIrBJeCUdQcht75pMd9xg
	Kv7vra08AcraFqzg8dd0zlphJhkasV4WGYEnRxy2bQvICssaRl0zG7zVAawwjMGxLeIya+qeui1
	0EXMFa5Vi8+eo/Zpc3ouqf45OZrWdDkDA8KwDfH5p0INj6n7hj/w3GRXX+7OKuiBAnhhl50FWLA
	e86am+5C1u7yLN5j+E6h3X9UyXO36xa0x7Mjav6YgAF/X/B5tYVXosauiT17/7lhzd+wVeiOZ/a
	NWQFb8Lq5Cr0B4oMdWkEWFazynlNBSUjqWGo6sIJoDdPokNab35UhMHEQFE/VqWkNs91mGNi8d3
	Ko7lh8bbcBWQMxEOrX5hocL3FjgzuQ1TTGwdGOqTkUpFyFoHNcBur95/5DIBdO1quOKPHj6Ew3V
	9DcT6lzwLfrgQ7LYo1aXczv1eSlsruw0whLWdZru5RZFZQFPuNOQDA0PLYvH2RotQ0/xem07jZ0
	+oI/kKTK63iR0XYo9LKoK9BpskSAYIkIGyG60q60jhYkmlCgltcfTUDq/HUN9D+MpRgvmk=
X-Received: by 2002:a05:7301:6e9a:b0:358:dfed:d0fe with SMTP id 5a478bee46e88-358dfedd5fbmr22336352eec.5.1792116653426;
        Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm2638280eec.28.2026.10.15.19.10.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: halves@igalia.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org
Subject: [PATCH 6.6.y 1/2] Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
Date: Thu, 15 Oct 2026 22:10:46 -0400
Message-ID: <20261016021047.16461-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016021047.16461-1-artem@trailofbits.com>
References: <20261016021047.16461-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heitor Alves de Siqueira <halves@igalia.com>

[ Upstream commit 525daaea459fc215f432de1b8debbd9144bf97b0 ]

Since hci_dev_close_sync() can now be called during the reset path, we
should also set HCI_CMD_DRAIN_WORKQUEUE. This avoids queuing timeouts
while the hdev workqueue is being drained.

Fixes: 877afadad2dc ("Bluetooth: When HCI work queue is drained, only queue chained work")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-63974 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 net/bluetooth/hci_sync.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 607667cc357558ffefa812e1cf001ca923fdbf78..0c96e048d8816016c44f8d1b90c99f4addda8ed8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5349,6 +5349,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
+	/* Set HCI_DRAIN_WORKQUEUE flag to prevent queuing work during
+	 * reset/close. See hci_cmd_work() and handle_cmd_cnt_and_timer().
+	 */
+	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	synchronize_rcu();
+
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
@@ -5367,6 +5373,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 		return err;
 	}
 
@@ -5467,6 +5474,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Clear flags */
 	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
+	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
