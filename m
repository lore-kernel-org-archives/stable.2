Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C923CBE80
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437591; cv=none; b=k9PBHKPIP3wr3JrrOuXDUuIJze4cfq6F6sCGikWp1/xT9CFLorijNhW+GVEpDWMDmEO/8ITQ4ZWReL+NnwWiKquUZDleG/00pvGTG3pW2fV9iqjA3Vc7rjA/KigSRIeHR8l8G5AJOOxriBBTLgEWnd0OfSC7RHeMmtq39hMJGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437591; c=relaxed/simple;
	bh=+uL7gF2g0/TZv16n3YoEteaP89TWBxkKh2ww7oIIoow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvZzd5qBRDA0d2GESxtLBB2jhvATCp00DTpz4oTrxDhzsQhRYuX9+0AegDlZa0juKop3KzmZcmYXTuWuH9QQbAM9vYwkEqrIwpYU/kIyfzNnrTbNiSpKGA+o3cSbfh3Fbe8ppXdxsHrUZfvTlwuz2asneto3HHySz2nHtOn8iI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa0tJGb/; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa0tJGb/"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so349941685a.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437589; x=1790042389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hf+CFdNUbLJ7V2+bEHmHU2ffZSj8H/v1W4UactONX8U=;
        b=Wa0tJGb/EZd20gZAXyj13eRHQdpYXzMv+WKkX2tURKfIT9EJa2cN4pZvaIB0k7iqnM
         EGcCierq2QGs+8S9fpvyHIyIw+Aw+WxF3+PfJ4XGqVPXAJM2srg3sRKfu1KasLgbHB0O
         3OBIP9NEucSippujmyccms7O+REjeawIhP3j9VeuNk4G+Wg206FO3GfyXrXahumNJIT3
         QbjU+1jIiXcO6oCQbXl3Ire/FfUE9zbU5hrzhN/xAHEBkVYeypftntP1dmhPKfsSpzgb
         1JaKUkKxsKr5fB1VvNUXrXQeo3HOFFUHONfptX3wMlUshmCIefCvRr752BM3qGMQzaMi
         r+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437589; x=1790042389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hf+CFdNUbLJ7V2+bEHmHU2ffZSj8H/v1W4UactONX8U=;
        b=y9JQHdzcGuNoPEMMXRatGiqv451ExJj/xEi8Q+MX/Z7PvI4SZHe1Bqbs0Pn48qld2N
         qd7DzsACATJB99DJDyLEnlGy0qS4Ri09BoQxu8q1STkH60h4wcmygjFvXC1ROODKAwt/
         UHza52KJoA9HQeJ7gfXhxpnBVrWWnyxaXZzrctUgCUCRgKPyZ70nHOSlJZRH2rOXRmVR
         2RVPH4jPAvNSpKdjRXb+HAxbTtK6d5sCDg5ZesBHFUHQfUs3HPZ96EOq/VTVy4jCQfR5
         /3McNwyoh1XyZ5BC173YuHA3/ssY67WEUjVmz/FbBNuahxaFfAgjb7uo1VID2+gUjc7W
         q0Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwG+qMzlJ2g2cOlcGWaRlFoLEzKmf8SxMpf3g7ZXJs+n9oZq7ptktkmj0pUdglDpKP63o9Abjo=@vger.kernel.org
X-Gm-Message-State: AFuF++lEuwY6Sf/TTdV8eBePrTzDh3ItSgcWHw73TBL/FsRSpuAawAB2
	yvj0fOGK/9dFI0BcEleM5Ii/Uj5WBt82U8nmwfNOE1IGfiDuBE0x7k4=
X-Gm-Gg: AYBFou29SonOoBkxQSs1p+irVYOIhOKgSZpW0+1snEHUMdbrtnwftAx/nfHmJqykQVm
	+wx8IbKwzK1p77MnV8ll5DvndX97Ove1R/Ak7heCMADZUm3dnJLlr604QYC0Hnn9MbxnbtKK+WI
	3PjmbDdKmK0iB1oSLt6fi/ayLE3qSNaziU/MYSsxOPHJd0iz+xS4WTkt5AetegfKj+XF9uRNzTd
	eUvAIXIugdOyAg13jeHz0AVDPcziuwQDQg+qldV2jZZPovs07jKJ+gVesQbsi/nCYdGwOwmmJQb
	J9P24nb3d17fyUZTnuY3SX0ksL+SZ9aWXgVpRB49Vlzs9hxaOme9ZxaJmCAd5XDMfKVNkcRa/Se
	li8VHvkal8aU9EItQH03GQ7R1zEvJLV5sq++AW/sRDEamOlN8cL0xlnysQN46akrUQ1uho04oFl
	JlxvZpuDpIbpuf5mfWb3VduGen+jsPd+ooQLAsQTNT3BrSXwmiZr9DlVFwCpPNObG6HKduXBXSk
	rINQO1L2fdV58LIhwtCcDkmPT5P8Zgi8VNwm8kv/LAQXyiI1MoiSegE1kOpD40XRmWowS46sNoZ
	1oZl009BGuaUmCd/a2/iM2E+S5qjXBSSjKkzsQCq0sA2oQuilxuMzTxFWBndOpIwhkqn3A==
X-Received: by 2002:a05:620a:1a06:b0:92e:520a:ffab with SMTP id af79cd13be357-93a29a07d87mr837367585a.38.1789437588673;
        Mon, 14 Sep 2026 18:59:48 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e807eba7sm1137116085a.29.2026.09.14.18.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:59:47 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: wan: farsync: Disable PCI device on removal
Date: Mon, 14 Sep 2026 21:59:40 -0400
Message-ID: <20260915015941.86661-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fst_add_one() enables the PCI device and disables it on probe failures,
but fst_remove_one() never releases the successful probe's enable
reference. Disable the PCI device after the existing interrupt, tasklet,
mapping and DMA cleanup has completed.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/farsync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 6508c53..0ea6372 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2561,6 +2561,7 @@ fst_remove_one(struct pci_dev *pdev)
 				  card->tx_dma_handle_card);
 	}
 	fst_card_array[card->card_no] = NULL;
+	pci_disable_device(pdev);
 	kfree(card);
 }
 
