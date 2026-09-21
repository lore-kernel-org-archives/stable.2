Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89364CCDE3
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005345; cv=none; b=OPKn16rAztzcOhTM8hnqeIA1qzr/6rxgD6XeeJCbQuxCmWolEBqoK6O8KPn4YqxBoJk7Cskf5aPg2fDvVYzw7lCDq2IGSzu5nxXNnPqm0EPh22NgdzDaDUhlyxknK6ea0UYWDvYL3QevzwxJ37qpbh3vfuIrfbLEMcAfRG7oQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005345; c=relaxed/simple;
	bh=lRZjMrGJtMkO5fjKjctGS+IB0XlrEM2bLj8+OXK50P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9rK+g7VEwOORDHmzS0v10RzzrBx9DKQC1dmyMR8WAzu3hxlmXlgT8psxvB9/vWHlKGYvgnzLWi6OZunvw+OUmuTRLsROW0p+N/Xc6PSlp11hC2nXgmzb+FWku6ZLh/RfZkRHZbwQaqMfOHvMI3cndDg68CE6057iUU1Jb9jvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWSjkzkA; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWSjkzkA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a3so2763062b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005343; x=1790610143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvCNVHGgMCfVbha0X/YNf7Xfe8skNfPu5j6zn9xlEcI=;
        b=LWSjkzkAxtngWvNPj+ec2XnJNetA4WlVoAxfp6GBSUuAVxgvUmmtr0gEEdy95h0HMI
         VR+wIHYLA0qMjd2RSNJdid3HSbBaRczUF6O5hYg06mgYeT8izXmpOGTPh5maK2WcMjqs
         f+yPkTomLK6SsRJzuQbujYfIvZA3jM61fkWKGZAYz9ay/NNSIZlQaHA9JbsKuauUFwIr
         0/Vv4+MmS0IYiw76JnjR10ewGaeZ2Qn/Udcgw78Rormfm26Eo2ViYfA9AVe8JcTdT8NL
         ETD3nwXswJ7W92kdys9T/7rNAkNb38AdIYg5XnFkytWjanjiOsQMNFe8gPv4p8GS4WVV
         TVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005343; x=1790610143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvCNVHGgMCfVbha0X/YNf7Xfe8skNfPu5j6zn9xlEcI=;
        b=ITN8DgqM+tSxRzz+AfHSiNxxvhjhRZly2VBXmotmLU5bKj+FX04ofvqdv5Iz54uKo5
         3Ak48eBDMeAk1ZteTdYjNE8iztEnWFdU4O4lJ63rE/1hyIaCYN0ZAdby5h1VWKTNpOJ8
         r6scPzPtPNfN02lR+24Z3iSdygKCsGkIjpjcqeGWn8LFkA2gzM9de1WMLh8ly8ShC9ey
         UFz+wuISpOZTNlvHA9ZnrBqMHdK9Rr5/wElsrBheqrM57M03wiDUbeEtlYiYjj/gZB4Z
         m56bl3ncPt5KIQ5XtClyT9H43gmFzV5IT/UllDDEJI6j9kHzl2K36btObUyrMLbOvOJ/
         ydMA==
X-Gm-Message-State: AFuF++l0YbuFIXSBcTTM1OVqC8DR7F26T0XMRd8u7k+t5dhuN3466Hu5
	r8DskmbzwcDWRiW95AQyYJqKr1fFhfC2aOyyhfkIMfOrRvhTKwvZZBMI
X-Gm-Gg: AYBFou1pxLDbvQ1oUVv4LV6HsciH507PUlYYMQR60y2CRs7ADX7qlEmvJjVakVPhJKS
	HTGZBBuhlP2A+TTTyrayMmc4epEqfD4MYDDdjN5++uICTd5ZqnvQjdemI86lyAybl8+y11VgnJ1
	7Ga7If3aLjm5IsR4mLQvQBmabR/WPBPOA/MF8jCGW31hiprrCCV7YNE582OK04RMmzkbt01ZIS1
	e/0zaZvyD9EkvurkAcAVX3+yFOC+1Ey0uj0jDNmu92J2WgPDGZlVYObbJioA5YUZzw2OyYUzXq9
	xnBAvSr1Rh0o8xqK9FqNpcGUm9e5pvOxyo6qOKETmQptGXgJOandp1TvA8HNfuFrut/bj5YeGCm
	LKdHih+C2/u83demF4KzUrFWdwgVGiuII4p7FWUCMXei/vhvXW88fC9N4ACXxQI/VPi4mCm8jRc
	5P3SjgiMk+CTgsG5fYV4FwUCqP70rEzXx9LR8pj1/s4/owATMTHl/7KPwZ7D2Wx3oW
X-Received: by 2002:a05:6a00:856:b0:848:4859:a45 with SMTP id d2e1a72fcca58-874db7f4b04mr16549838b3a.2.1790005342833;
        Mon, 21 Sep 2026 08:42:22 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa70200esm3449599b3a.61.2026.09.21.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:42:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Amit Bernstein <amitbern@amazon.com>,
	Netanel Belgazal <netanel@annapurnalabs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] net: ena: fix PHC cleanup on probe failure
Date: Mon, 21 Sep 2026 23:42:01 +0800
Message-ID: <20260921154202.471662-2-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921154202.471662-1-lgs201920130244@gmail.com>
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ena_probe() initializes the PHC as part of ena_device_init(), but the
probe failure path does not destroy it before freeing the PHC private
data.

The normal removal path calls ena_phc_destroy() through
ena_destroy_device() before ena_phc_free(). However, if probe fails
after ena_device_init() succeeds, the error path reaches ena_phc_free()
without unregistering the PTP clock or destroying the device PHC
resources.

Call ena_phc_destroy() in the probe error path before freeing the PHC
private data.

This issue was found by manual code inspection.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index ea89619039d8..5f0864d16dd3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_phc_destroy(adapter);
 ena_devlink_destroy:
 	ena_devlink_free(devlink);
 err_metrics_destroy:
-- 
2.43.0

