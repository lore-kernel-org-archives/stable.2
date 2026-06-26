Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46B3EEAC7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470785; cv=none; b=gxvLjADWAYrDozgR7OAPInyemicDPJWnhbc9pTBC0WU9QU7kedTbnezZgzvpWfHjdNdoSICXOApGx8b1tnJKJ/iu0UAfXNuslLBPJQEhhAgajPLfUiOML+ZG11j61zDe5jgpX47FLbLeHcZNBtx6YNbroRMRFZt2HlwE1yRoWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470785; c=relaxed/simple;
	bh=1JDnbphgkwE1KwABR21Ek6aBBXkftvzLaGcZcBhvZKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyW9zp1P4I7TqhukO2u1nRa7N6z1o7eKU33CA+5atN5EYVSM2C32P5egUEbk26Cm3LXP2BLOuuW6HByHXMyzW/2M6R6Ics57L+4bet3tV/OpzvrxInX8DZgYVH6jhBQKlErN67LM6ha1O1KgUqvGpRhEtMn5Egp+JwTHqbOrfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcG92g6t; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcG92g6t"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so1799619eec.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470783; x=1783075583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk1ykdKswi+f64tQfdwb5C7NxqilUtkk+OdxyKwsqlw=;
        b=HcG92g6tbt3rTKXu7PWR8gWTyNGiFtAoRRCNppl8Q/WsCTLXhkLyDGBjlxHiGkNK/8
         ca5dqk9b0nGYmKC6dbcNgRD82W9Pc/+qETfn6kKsZschQeaGSLaIf1UBofqeXmnNBfPC
         Htw+GXhySSi/QTPKdzhNpmrCWa12L/utGfncviU6rOE8aW011PutxKlmBGWTRYEBOA+8
         mCUv5XYFmt47lZAFwSfRj54X+qoK8R2ekjjH2r0MPURMKBTVsx6+X2/ruNOxvDr8cIZf
         uvRL3gDoyhSevPTdiEJX/Wz50Q+q+W8x7Iiq5f7A8aPfg7j9TtShOl4AK1Qigj1kUNwK
         4BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470783; x=1783075583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qk1ykdKswi+f64tQfdwb5C7NxqilUtkk+OdxyKwsqlw=;
        b=CgKNcHa+AKh+dBV/xO5IS5ppNtccHhhuuzednXu95/h+V4C9fg2wz9XWLNort/oDwg
         Uqu2JL8XFPTb8l0mq9uifwajXv7vwjNWdqBbadYlZUf4R4aFFpeywObYKX+A51dHFyQ9
         6/er/nt+qG4zLC7POkRe8QCiTQeSp0YutMpWr2Sv2jUhQTYeZxZR5kq2mcSTfTShWLtU
         lg2MENExgFTR9rVlyHkXZxCZ8FJ3ZTyFtiiU4vi7VPzuwAjlDjH9PoJnFQGdcqEzg1EZ
         fZzfv2JZZnRJcHmS4hbInBUfRBeXAG2JU0lNd93e9z/cbyxv1H/5rRRAoBySTlHICk25
         vLPQ==
X-Gm-Message-State: AOJu0YwK0hi56N5ySiPPtMmtGDejVsJHfc+eYEdnSGsIlxZCRYWzspwa
	TLR1WO95jJxPtZt50RUtZZGEEOi2YD50Xk/kr8M8ouXiLmVK4gZX09cFq+Jvt2k4Oiot9g==
X-Gm-Gg: AfdE7ckq89bGT81yOVqzNHI+MCiwpjrSMKYpFXLdE7/rCTHBYhpg0cg02WJ6Q9s2lxy
	4lNXfuhG9vvRG6pqESBmBBFQPlH4MF1+3AWWYQVsZK78fosH7wkSXwdRdPuxqKFoS68W1wQi/8l
	2LkzTFH8ChKqwWkibHw5EBfYI1+go/rP+SVO2nBIInVkT6K79QZTnIUOLrV0YTDmehtr5d5vjHA
	zpwVXV+I8e+2kRns5/OGSbqNXu9HxNfIWCtxWyPxV8bjKDJHEKZBwferzhAKAPPce21Nclfymtw
	5RvCD/LfhHz2iECLJHyi2d5w2ljNvJ9yDl1KnwjG5ddirQZvZT35UtvgnOrHzMxAY+CSciPSOhS
	SYoGEKZv0WvqsXjeGHyl4NzqQNLRpuM6KpDHLB1jAkEDLk2exwwGlgFZ+ePmEStyWpBa8is0OP1
	CoZq9ddmUzdVtPJb4dDFS9TkaIs1bl0Si/ts3NgYYKeOrCppxL/d+Ek+hFrw==
X-Received: by 2002:a05:7301:9f01:b0:2ea:b85c:153d with SMTP id 5a478bee46e88-30c84d435f3mr5453392eec.27.1782470782777;
        Fri, 26 Jun 2026 03:46:22 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm17823093eec.30.2026.06.26.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:46:22 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: stable@vger.kernel.org
Cc: tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: [PATCH 2/2] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
Date: Fri, 26 Jun 2026 16:16:04 +0530
Message-Id: <20260626104604.3465124-3-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

commit e3ac0d9f1a205f33a43fba3b79ef74d2f604c78b upstream.

MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
FUNC_CTRL events that are missing the status field.

Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB
length before struct access") the status was read from out-of-bounds of
SKB data, which usually would result to success with
BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The bounds
check added in that commit returns with error instead, producing
"Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
device unusable.

Fix the regression by interpreting too short packet as status
BTMTK_WMT_ON_UNDONE, which makes the device work normally again.

Fixes: 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> # MT7922 (0489:e0e2)
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e3ac0d9f1a205f33a43fba3b79ef74d2f604c78b)
Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
---
 drivers/bluetooth/btmtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 5c6f4d4b2e7f..582915f9a8d7 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -679,8 +679,8 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	case BTMTK_WMT_FUNC_CTRL:
 		if (!skb_pull_data(data->evt_skb,
 				   sizeof(wmt_evt_funcc->status))) {
-			err = -EINVAL;
-			goto err_free_skb;
+			status = BTMTK_WMT_ON_UNDONE;
+			break;
 		}
 
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-- 
2.34.1

