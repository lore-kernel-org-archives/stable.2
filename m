Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1B318ED2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434838; cv=none; b=IE3b8TMrSt8rwp7vf/s0ZWj2WwsjTx5j7ORHGxahrRKI2jIBo+ALXp8fRlY3rZ5BHrRBdNAUaC4/6vLrs+ZCWrq4HIzy5KAPZWJRsXf2hgoIROd2X+ghdl2cYcJbE/nqXBGfCtXskNZwRWiaCQ7xU2q4aDSxZWFp3Q0cf0rmzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434838; c=relaxed/simple;
	bh=ZdUW3KC9naKIDkAGSiGquiNX4Ac1xMCc60Ruj3r7Cig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht9GogK+qgbSfH+0hzMuf+EL8rITzgggZhbxEZYC1ZQbG6fngrLBND3UIFXkl22ZDNaEE/YzG/S5UnsQtx8+hkWGLyDTJBQ02r51yxwWBtEl5hBoO7xG/nukVEDkOW+vc1Hv2EkL50lJCgHNRnwTdwbU3egSpM8xa1XA/AC64qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6F7pXwz; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6F7pXwz"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so29909551cf.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434836; x=1790039636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9b1lBFng9K4L8nuKAcvrbbiVs0Np5hE/iDE9F6xQlyE=;
        b=S6F7pXwzJUONxtjTUlHNJIsTEx+rBYS2tU2JP75tUaitUbkmdl3r0641vZ9pPBW8os
         vGKl5J4ufToG0POUXMhJqhHA4pi2Fjn7tTPC1G/BwKUXKyYCct73S5VuzWbyHJ1RdmZY
         qJHxUYW7P2dWC3W8e4WYe9GEd8bCNqlCvhEBSmXVdpBx+FwLetRYEDpgIOJrApCx7PjX
         ZaKr9FfoDtlAtEQgvDpKy9EsjziQ5FMYnvuEBwQE1746IpUvSks4sIfB0HTdXXCRNMHl
         7K1pM+lQWMPYVBVl1BTCNfPpRC1uXTyFgiwsVOK0IzWwaC6alQ850E/Z1Q2pQISPNiLy
         8eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434836; x=1790039636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9b1lBFng9K4L8nuKAcvrbbiVs0Np5hE/iDE9F6xQlyE=;
        b=O+37pkA3UFbOTU0cGGrEZwLJhJwD0bb+e74S/5uek/ELTiUqCPGC/InIr2lUzrh7nA
         Enw2BO1hpjyscr8sfbVEIngcHN5n4Ju0L6V+/O9OKMyQuHUK7y+qLbMyUevmi9wB7YIH
         au3mBChAZmGxePJFDasOEYx0abCKMhOyMdNnlKVJLNxiQNikwUO2LfAtLUy8lp/8dZHd
         ZSq6087d+Nw4sALVyP55E+fxbrT/b6PrcAcJfFgTtjhs5QeXD8eePWr5UvyQHIADReLk
         VbgE6AY5q1kamhhuQb4ddVfHpgsgiz0HIevjH1ISZwOqCe7QRAdADrUQ+hROkgtP4gP8
         mKUQ==
X-Forwarded-Encrypted: i=1; AKwUvBx20/RMi8mQ1zBkyrc6NBaDggygdwAVi558AInOgR0sdGU5/ULIJkA3TlP/h9ZGiG5aH6AehLw=@vger.kernel.org
X-Gm-Message-State: AFuF++nKb0G2YSzKQswYAdrulcIFxEANKhm6LL3wJEGDC/53PG5gytlz
	QT8E0+DIXbO/ntu5M96IaYXG6biFLwL/Wb3s9LpErGWFvV5twaqP3cM=
X-Gm-Gg: AYBFou0ZqH0Mfshg6RWt24X7/7GrA2zJtYB095Tihr2qfJPZ3QOPQ1Y9TAUOPBs8yaF
	HxnS3cPjW9ptWmElYQQO3lgHTbc7TAB+TSoTDmOv/pc61sWlvhw9FGZlS7wfSDH8Ec19bOYbdy9
	qgJdSnYElbEKdt0pi5ZAgAi2Rrnxx6tjip8W0INXQVG+IyaMNXcdCs6pExJrsyWmda0ObqLZXvg
	8gOHLradNxH2PCFCDU5ooyNaDmC7NI7cagSCffUOEXIpZchZzR59urlJBum6E/YMCsrEE6/0RjE
	ddPW8AujxgT0l7C43s0RHMunPYtYEh8AwQbym0+hPg/tfKDoTosY3+uwu9tSTcZwguv5El1sTPb
	61zqbTBDXs/1jpSHltLtL/D0cdCp9hLN/hZdJpl11i65L7kVW7ZkO/rq0LakFJzMH2I+1aNEqRL
	h3f/OoLWkMi/XgtTa5iMpR2E6z4sZklnsEkh2kn5Mf4xqZAtxP5uj3UySsALnNBSsNhnTYVMmLZ
	FwNhoRKOQKabtzAzddnfojb4ElId6u2G4wCxsmqS+XP2hvH2dQ8xeb0i8tVbogCcDrL8rLGqOTE
	fyH9xRVn0fmkWEuOLCShGJKzN7EH3nRMZBqcZgcpko128GKKJW1NXrafBpTBsW8W
X-Received: by 2002:a05:622a:2b47:b0:530:e2bd:c272 with SMTP id d75a77b69052e-5310d0793bbmr102700421cf.52.1789434831180;
        Mon, 14 Sep 2026 18:13:51 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm109060396d6.37.2026.09.14.18.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:13:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: sti: hva: Release the runtime clock on teardown
Date: Mon, 14 Sep 2026 21:13:27 -0400
Message-ID: <20260915011327.57695-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915011327.57695-1-mhun512@gmail.com>
References: <20260915011327.57695-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hva_hw_remove() drops the probe's runtime PM reference asynchronously
before disabling runtime PM. Disabling PM can cancel the queued suspend
and leave its clock prepared and enabled. The IP-version error path has
the same problem.

Disable runtime PM before checking its final status, then suspend the
hardware directly if still active and record the suspended state. Drop
the probe reference without queuing more PM work. Skip direct clock
cleanup when CONFIG_PM is disabled, since no runtime callback acquired it.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 57b2c0628b60 ("[media] st-hva: multi-format video encoder V4L2 driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/st/sti/hva/hva-hw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-hw.c b/drivers/media/platform/st/sti/hva/hva-hw.c
index a608e35..cb55dde 100644
--- a/drivers/media/platform/st/sti/hva/hva-hw.c
+++ b/drivers/media/platform/st/sti/hva/hva-hw.c
@@ -395,9 +395,12 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 	return 0;
 
 err_pm:
-	pm_runtime_put(dev);
+	pm_runtime_put_noidle(dev);
 err_disable:
 	pm_runtime_disable(dev);
+	if (IS_ENABLED(CONFIG_PM) && !pm_runtime_status_suspended(dev))
+		hva_hw_runtime_suspend(dev);
+	pm_runtime_set_suspended(dev);
 
 	return ret;
 }
@@ -409,8 +412,11 @@ void hva_hw_remove(struct hva_dev *hva)
 	disable_irq(hva->irq_its);
 	disable_irq(hva->irq_err);
 
-	pm_runtime_put_autosuspend(dev);
 	pm_runtime_disable(dev);
+	if (IS_ENABLED(CONFIG_PM) && !pm_runtime_status_suspended(dev))
+		hva_hw_runtime_suspend(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 }
 
 int hva_hw_runtime_suspend(struct device *dev)
