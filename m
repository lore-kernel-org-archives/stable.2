Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762F2E6CA6
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488014; cv=none; b=k3dYjrPCyur0Z7Bb3vU4Brsm9BD7jGAFchGZKq24MCxtfPLtdNslUgOanVCliDi+S5gCbWUE1dUieiwOhqhDlQZq63s7OZLUW9Td4QouQfKgTkv3B3D5xBlgwp/XZ16DSrlfr9BJGSCqO4wa+hp/CRqj5UhyxoTeGz7koaDVG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488014; c=relaxed/simple;
	bh=c5rcdDdlE0FtYLAQf6VE6WbsbI2ilBQWR013Nj2HKGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR/eLwApBxS3d1nXdfEMauppwWpNcNF4sHzHPkvPmVko2HSXebkwhDe3BkTGavxxnLCY5rlDJZn/XstKwPVhI3BVcn9RB0QnQDdMCfEv5aAXY3/LydzZlfL1Qn2ELMx+PKbNjP9qSwvmXKPnfNTxBYPpw2okbjpEm+xVPXtX92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBeaedNa; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBeaedNa"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98dc46a95so356746e0c.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488009; x=1790092809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jBwXWyCEkSTnm4vqQrbw6NCM+Mqq0U3bxGvHWqgfP9c=;
        b=BBeaedNaTksirHZrxy24M/hSXLmU9eCYHTAGP7qx6jeZMdbGHh9LTP4HCCMGbdlb0R
         AnGuJChstU+nUoHxNaLlg4y32rDHGMquRNT4hqb+wIUDDXvpO24UQwQjTY+jknIj90G8
         HPD+MkG2aoO0ukvV+GiCz71MukfDhxzINdXtZXkvwSDOBL4OrRu4eijvZtOZcoILMblM
         RzYo51DOSZLiIdtSkipIO+/Hu9YzLtwBVT1MUikgKUFMY8A53dFDzBcuajPK6w2/ufk6
         nEeLP9+Fdpm9EFC5H+2+SiwJBVHOUgRrs+s3NKmHKtrU0xttCy41zTNWaqvm3mYRt4nF
         Bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488009; x=1790092809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jBwXWyCEkSTnm4vqQrbw6NCM+Mqq0U3bxGvHWqgfP9c=;
        b=Ny64UOMGq0Fkk81zhjfbd30dBwwq87KYjvdoH8x3k4xA22Roay/HYyBPduW3WwnsWD
         mgaLWSKAIP24hrzjS7u3IuoNqIazLrnMO6PxMBuyG/Egy2PmI3Xp4nOTYbUvhdlyR+5k
         xc/bSmm8KDmQWU2Gk0fcMEOR7SgoFiOKrHfereZWbWX9K4tSHTV3cyv8NhRHfFyZo+o8
         cce8dDEzmGUStnDqUcaZOcOc0xRgvTVmNF/oKDn+aYLCT3njPiBWHxgI3HY1l3d/7eDG
         i2vMOrX2Wxo/zwRA36WC9NEQ+qywYk5NH2hZhLTH+yViwap9UL1btrWQJHrx58+AgPqF
         Niow==
X-Forwarded-Encrypted: i=1; AKwUvBwnRTUyL/6NhsA8IDqxrbEmu/0JhsSRPxWtoAblKEXz2VTdRaiD7jiZ0a9W279c/e33kNmsoDs=@vger.kernel.org
X-Gm-Message-State: AFuF++mHLla4ZN7KWrNp8RN+oVd2H8pkjxAdTRshpd7fi3Glh2LSy5QI
	9tMWCo5Gcfq31q12xn7mFkX+XkEtaGvNQb/deMD775eO4UOGEyHcMG7QyfmkD97fZsk=
X-Gm-Gg: AYBFou1vAolO0Cn0ZSoZTh1KLrbB4H4mJMTrF2o3sYJVVZeb+2GHLH1+B8+WpK0Es6r
	DBlx7BDyLB66rv4iKE6fqj5oet2NqaLRS9HUVQrMHWtmQOfrldVO7llR+NrVL8WYXdOAbQYDWUM
	vbR1YFbmJHOZDfhs5b2oboO9B1QXPur07rBLQtpss8IqenViAhw/wLbPv7lKT0x27yARd40hLxd
	XLZPIhr9RxIQnQTFxKuXmpCkKIy30JRcjhTIq6toeDlMa9/JGNYxL8wublUiX6oiBAOEJXw66oH
	2fm2ExtFGqNh2188Bt0vbDMLVa0o4ywbO+Tkxf5HFqWXyuYvcIJEGbI8ShWiXJp1+gn7B9Y8CcS
	vqywn+qpL9289vjwnX8EAqzUzsZlN4ibXdP8EhyyteWI0WOXudBpNnDejdvQ9/WVZ0SfqEsMglt
	4m0zTw5s9r8NRb+gY6q0CmCh5aqcBITcjkPs+sohuoz7C0D+8CvJW7SftFDUtGQp5URw==
X-Received: by 2002:a05:6122:f8b:b0:5c8:2852:36cc with SMTP id 71dfb90a1353d-5c993c0c8c3mr3364356e0c.4.1789488009295;
        Tue, 15 Sep 2026 09:00:09 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c99149d764sm1485543e0c.3.2026.09.15.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:00:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] Bluetooth: mgmt: fix race in read_unconf_index_list()
Date: Tue, 15 Sep 2026 12:59:52 -0300
Message-ID: <20260915155952.3104711-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_unconf_index_list() counts unconfigured controllers before allocating
its response, then checks the device flags again while filling it.

hci_dev_list_lock stabilizes list membership, but it does not serialize the
per-device flags. During asynchronous controller setup, the worker can set
HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
omitted from the allocation count can then become eligible for the fill
pass, causing an out-of-bounds write to rp->index[].

Allocate space for every device on hci_dev_list. Since list membership
cannot change while hci_dev_list_lock is held, the response remains large
enough regardless of flag transitions. The reported count and response
length still include only eligible unconfigured controllers.

Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/mgmt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e34..1f6691278 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -496,13 +496,9 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	read_lock(&hci_dev_list_lock);
 
-	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	count = list_count_nodes(&hci_dev_list);
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
-- 
2.43.0

