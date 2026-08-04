Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BC418A49
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840448; cv=none; b=cF15Ov/g+asjUfK2E7MfSXSz1mvRopUaQv7eWuHFhjsZ+EQrhFVVmNdvrFxGRIhfVqiFXvw/mPCWSf7w/DvBk6hI855Vd20Fc32M2t6XupD0J34u98NUqfMpmneebpbNPsHJ6P+wLsaDMnpBYhEm33MbGO1dqwrrAikGRVEmfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840448; c=relaxed/simple;
	bh=rqvgJdK0WQdZ3GPu6vFSXk3iXWjhQRzWNwKesfFsM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWgV2DAvQ68yFFcIDdRBfz39vlhn3y+7NKd8E4DNWvrCiq7MnSlkYgCa2/iWXlS2KrOj22ofXb39Q/St2PE+LTC13Xcwyy5VA/qsL+dd3uC8BOajEBdzC3iOvzeSeRzZlSgo1oJGMPqXZA70MISHqjI7JDA4aorrtMzKOsZk4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFOciiAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFOciiAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA01F000E9;
	Tue,  4 Aug 2026 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840446;
	bh=LrArEZeRM6xavqCUHNoCqOfpbxK77dOOKXsd7nq8MZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFOciiAhJ1+pliU1pLd31VnoVLWdsP3/gwfl5mIhe22CmmB38nCITPpFpF95CmeuI
	 o0yO+K2AEsyV46PeU1dwlPbKNTyInMTRnMDJSZYRzuG2z5WEYaLMeFBHclYVO2TDQN
	 2C16I2aHBDT7nwtzj72tUZfz7ud0uZZncXoKqEdiPi+45YPJi0yT0EhfUPRjCK9lbe
	 w5k+Jri4FKGQR3VQQ3tWPF9OjO80zJzeyj1JLBGAHMwDe556OEdS61Sh9dDmByjDao
	 fLwbK9cNLtk+icImUOhiFEANET3jQly11YSXppxhHGiBKTUddOhZuU8lmimXYhds/X
	 PyZv4TGnNHoWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: marvell-cam: fix missing pci_disable_device() on remove
Date: Tue,  4 Aug 2026 06:47:24 -0400
Message-ID: <20260804104724.2826056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072930-finally-subtype-79f3@gregkh>
References: <2026072930-finally-subtype-79f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 033ff0420e4c9c240ae5523fff39770298efa964 ]

During manual code audit, we found that cafe_pci_probe() enables the
PCI device with pci_enable_device(), and its probe error path properly
calls pci_disable_device() on failure.

However, cafe_pci_remove() tears down the controller and frees the
driver data without disabling the PCI device, leaving the remove path
inconsistent with probe cleanup.

Add the missing pci_disable_device() call to cafe_pci_remove().

Fixes: abfa3df36c01 ("[media] marvell-cam: Separate out the Marvell camera core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/marvell-ccic/cafe-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 9aa374fa8b364..5e6ef67ae7f90 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -610,6 +610,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
-- 
2.53.0

