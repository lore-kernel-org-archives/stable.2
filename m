Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7284434987
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462980; cv=none; b=CElsQ/DA0NXDIsfIo4r5ClPUC2K1tyEaT26GTV0v7BTwE0Hpy4u6HDIhJYveYAxSjTs8SZpXWCm5oLAlY3/Zmw88F8YWGwMl9c/uEQXuhb5k1p7wdvFEUOl+cM+yZnlXNIa/jw0eryLahLSld3Qzhru4NCQIzXh3dXhIMaNQbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462980; c=relaxed/simple;
	bh=ZI01giqCOg4r2BC/31Ii/Jx+mxfuzQ3xbAm6e2K6C8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF1sFenuQ/TU3tSbnuTZXelr+f4XH5XYsuN4fWIAXSViaTXBjkb6Z4OKTsKHlwo3VesahvVBmdOQgSe0lK0HLasxdxAuIdU4lhq+oTNxtEVsInYJA9+hdFtkYPwbxhWuABeJ8T14KFJvO1qz6s9SbjVVtboPUwwcgyPzIt/T4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8jYbAq/; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8jYbAq/"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so440475666b.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462977; x=1790067777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96B/n0qyp7z+ICJfhqaTshDbMoTzd8gumlBOo7qhHZw=;
        b=H8jYbAq/k24Q6j1MuXjRsZ9lDK81mFluOzrjRTNB6BOrSQOKLSomPRo9KhNfQFGZP9
         637gAhVJ66x6oFv/Y/rtIFEJBkOagQjIPdMiZ/IzOlInEtQ5jbaeTC7mK+fFWuAXCe0B
         OBF5KHyrL0Sr7bLezopx0wtPTMTp9XTk3JSwHxccLtnQSLDdQYY0Wes0ktYgIJ3g6a0w
         fDtjTPeFMeqhVuCTYm/uNrY48lb5VVlMlgNjjgRvzWGB4WfkzyuscgR/DqqUitovnhwO
         Yr8WhscD9oA3gWOXZGLDRkBYaEAUGZYUmsICqqBjePOkwCO5p4Pe15ADWhrBtFrGYENc
         GUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462977; x=1790067777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96B/n0qyp7z+ICJfhqaTshDbMoTzd8gumlBOo7qhHZw=;
        b=dO4+nXlSUkEe/VIYCuWsUoi9syeew4y+XYR8EYnTETOUD8awXjiqnZSszA25aGlzcY
         IUgmMleV1K33hoNt4Nmj0p89jBAFc1A2Ktk5QUgQx179UDo2Loor+AdDcOql1HFdpBHj
         8FlLPD9l3/iEjTIiKSZjEEf7eLn1rkk4xI2PVz6JkbVuiFEKiyJVjnEzSKu6drwbySSe
         /iiDyYv7bkO5jLRxjfjVpC/6BeGPT6bdBOi3CL6jfj72seRr14w0wl1yVgyoKnHyUAWg
         1q5pvnyEQ44SC7stDl6n2PPPdvgduFJgEmNtvAgSEKOOy+GBrhDQOJNo+LUDJUyveDaZ
         31cA==
X-Forwarded-Encrypted: i=1; AKwUvByAN2NjOImKt0aetRxZhO+f4Yy6FG9eCPyekSDCm6i0xdEa7NMiXGsvxE1gA9jRqq9N9V1pTX0=@vger.kernel.org
X-Gm-Message-State: AFuF++n1oHJl7rO0NVbhbAob3s3Jzut4XI/pR0r4s4iqgLgqjo2rodIQ
	JGHE2Ee1bOkL1aCxhshOFihwFIuFlkVvhaIGyQFLzsjZy1nd4TBwkGCz
X-Gm-Gg: AYBFou3L65evIQ5GzhU8YgLsz4p/kkRo6USldYVruyOA+6WNWSmOLD6m2npyclt5H1c
	/K2psPUJsfMChwu5R50+T433D+wcobZeY9b/g8Y/bBaNbwm1wdvXvyEoyCCxbG6HNSAEnYIoewP
	9UDKzcISBZEe9vEYx6YqNixsev/n63WURfZb3X102TFfUQY2/NxKFnA1MWKV3bYgJCWy+G+bLMz
	DNImPgrygjJCtO58JEK1lMSGFH2yVvhjljdCHsd1I9J0grMfilZ7D+pX+kpbx6gRzbV5FAbSzr/
	xuV5llvYhE3Hs4cZ71o9jRhJBowAy1nd9aWpfmbNETr7FL0RWA9U++XJG87832stYvYBw0cRxrx
	R6w1L2+K8yeFUHmznmpzri8D9hmgDv2yLUPPX6M5myqBPZtN9yvz4hlmaeTrLYCp3YlEOJ8UGF1
	uhpVDx7LlAmDI202OBt4s69unXRFnRTHeyN9uexkZmHNW3IC5Kdw6Tp+nJnNnr+ZVsx700e45uA
	k7W6pcUG0qT0283zzl4OmarXJT8Yu6KfIal5Lddt7e7v8Ilsm+psLSmTIn36gQR7vmbkFhxTJc/
	h09HQlt7EcLCcrckHs4RIWKDeWXoMiVDTgA+imCt9vv3te6pbiRwTzw/pPPsp6mQ7tDZWggh2Bk
	A+v2VZq+U+3A9+dEmg0z8/z51avSGj59wiPfOCOZk7arYZVvEAg0mL+nahZICdku/mQwE0f6ntp
	Mn0nAY0c+WtxevkBIpVwry7j19vBCe0Ml6sfBGZIJPdegs9CRg8TKqEFx3B/I/KpojPp7TH9aa6
	Y8ghpawyws=
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id a640c23a62f3a-c29b839a057mr853572666b.2.1789462976636;
        Tue, 15 Sep 2026 02:02:56 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (88.71.12.34.bc.googleusercontent.com. [34.12.71.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm546369266b.1.2026.09.15.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:02:56 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 3/6] usb: xhci: add missing pm_runtime_dont_use_autosuspend() calls
Date: Tue, 15 Sep 2026 09:02:20 +0000
Message-ID: <20260915090223.1346-4-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915090223.1346-1-joshua.crofts1@gmail.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disable_runtime label in xhci_plat_probe() and xhci_plat_remove() both
call pm_runtime_disable() on error or device teardown, but don't call
pm_runtime_dont_use_autosuspend(), causing resource leaks.

Add the missing pm_runtime_dont_use_autosuspend().

Found using Coccinelle.

Fixes: b0c69b4bace3 ("usb: host: plat: Enable xHCI plat runtime PM")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/usb/host/xhci-plat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6fd595f81a30..29e743d6868e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -388,6 +388,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 disable_runtime:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return ret;
 }
@@ -461,6 +462,7 @@ void xhci_plat_remove(struct platform_device *dev)
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
+	pm_runtime_dont_use_autosuspend(&dev->dev);
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_set_suspended(&dev->dev);
 }
-- 
2.47.3

