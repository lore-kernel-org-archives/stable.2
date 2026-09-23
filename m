Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350F49A3CD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162455; cv=none; b=oG1jvN1qPsBAMgf0wSFlGKZPSkrUtXpSB4zPQv4c7ORSPkKfWrkNJsP+11H5RjzgcJYWJd5Ea0EPCOU58GTquLv1g8pyXwv9c8tr8QJdZVAs1EQFd2zFFJNEPkSLvonFgf1EIMHobKrcrnXKiV6Gp4BVeIR53SUJp1OZoe7cx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162455; c=relaxed/simple;
	bh=ljPZGMW3EOOyQDGbBFq6Gu4+MAFs0+T56XB1zZrbm2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okEUbKqDV/hmSSgnY9jSRaTOjoFhZTJFLjKkQd0/wyCWxwPJboKikUU9r3v1IOjpp1bQqixLx+KHc5amVZyh2PIXq+MoXVYt8aywsduR1c7d/v1Uwza11qgULyjwX8BszlmmKDdRzAgEs2UuVvJdSzpMqcc/IJGIlEaExbIbZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVWOiFIK; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVWOiFIK"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e4e75342aso59533eec.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162452; x=1790767252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=BVWOiFIKs2ja0GMbAE2WuwcWnyFcW3E1bmvWj/P1Z4sHdFzevPgXnMLf6U+4SChNRK
         ThMpxkMNan5bX1AZ904J4qOgvBHI+bvo7Wa3R2jS8W0mhkhuCIOhCZ+t2YAgD9gaW5Ub
         zVD7Jwz8oDk0rE4qOBeWvnpjD9dwVG1M7YCZBKeAGmtIChPbY+ZZAXnOBTSL9ok+IQN0
         LD7s0I0nEBWlKZ7vOBMgUkeJqrIWaZ+8rqGcJkq3wQRfedt4qrowVvH3ODniEF24JtkB
         d6MwreZxeMkp3AfN9Dz+//01pDqy5eL55GmfJfRAwzJUXgoWU7jW+vOHKcHrFHPkFkoZ
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162452; x=1790767252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=xJ90TN6jEco3/bMwJkmLU3phcc443GDdAQ6DJfECrC7pIwtpDuYShJDNJF4RTsBf63
         2OwJ7k58rHBYysAF6Oo7I8taWuvTBy7u6+r12wJMz96tN9bd/kjpjdeW167V9si50Q2z
         TDzK1/QKD9o/QKbNXGfFA1CCTmH+Y/p3wt/P6iDIv1MO0Ww4Xzx7eA5+6aVKLRHjTu7+
         jTRp9XY/0EtRD7KdqAJqYvElc0OmxrP/SA3/ROdlc1t9SlMeXhDbtg5QiIemPCDY3yAX
         jhoRclZUSKxHjVZqesgjPPhveBa/1SV31awFSXeiTImVTowSkkWUuFFPXRTkp14Ui/Nr
         F8KQ==
X-Forwarded-Encrypted: i=1; AKwUvByM38/i4ZV1AIAfVZbtxftYwuUc/031fLnw5aPkttURvLtXrzPtwe7MVPmTrcBosRYYHnRn7zU=@vger.kernel.org
X-Gm-Message-State: AFuF++miBcU/3k4ennRE7HyrYWkxvyRY4FY+1xwUlNwrWF81eWiI+TRH
	l0dmc3OHsxkEb/S7g+lvmIAPGRDL7eq6hwz/fLWGN6ugrdWIO+K4V3D7
X-Gm-Gg: AYBFou30f71FZaCf+b4O6ljfZsaW8PMPdHhB3Qg5qrc4e2S+7EuEUtsjZ4Qbb2Q2y9v
	I8fqDNRoOb55Y+VulJGjGTJFVQ4TeUAVAxUJIBU713mB/q3//xr/Gn7qsVTNsI+oNorSVLOYJ4h
	scnkjkHiXbM9EbP4RzLSoPvOM32B+NT6lXfqZov0eX+VDuEmJHf5Nuluv5w34TNFJiX6CjcLQoj
	1JESglplnRvoGwWEJo/yRqGVzfVb4wonRl2topcAPeDO7MPOkPYEdks1vJgDLCw97dP8qMOQJa7
	rMHEviTQvDffxZZF8Y4ljED9scIZogtp8l/FONxnKFCLA8i/FFaxelv8EkQCmQtDxyiE7pDVqiG
	41gWijhGVhha6Hs1rJDhDBJVbQy32kXLZ+EaRRVZ4YozuYOq536CQzsuSc41HqU4yXunrqAdCq1
	jAl7mf0EVwJOlYH2RSdNTzskME/BbvIXFgTT5D7KAyrVkPK7a42eES7WrZ9YRom7DwI0PWV38+Y
	u2KzTRJjFWYOkhnrFfx/0XWjW5hjl9o60P3xOp5fIOfh6NTRaDS7HIM3tbwwIw9iFyhFK8mEkaE
	aUr2P0QfQU63iNDCvQ==
X-Received: by 2002:a05:7300:c8c7:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-33f3750519cmr1326580eec.0.1790162451512;
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d46f48sm11925271eec.23.2026.09.23.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Wed, 23 Sep 2026 16:50:44 +0530
Message-ID: <20260923112044.187266-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arOpj4C67BnrNreM@wunner.de>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com> <arOpj4C67BnrNreM@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 12:27:27PM +0200, Lukas Wunner wrote:
> Hm, pci_pm_suspend_noirq() should bail out earlier because of the
> dev_pm_skip_suspend() check.  That check resolves to:
>
>   dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev)
>
> The code comment in device_prepare_smart_suspend() explains that
> smart_suspend is true for devices without PM callbacks.  But only
> if the parent has smart suspend enabled as well.  I guess that's
> the sticking point?  That the port above the card reader doesn't
> have smart suspend enabled?

It is that check, but it fails on the card reader itself, before the
parent is looked at.  no_pm_callbacks is only set when the bus has no
PM ops either, and pci_bus_type always has pci_dev_pm_ops, so no PCI
device ever counts as having no callbacks.  With no driver to set
DPM_FLAG_SMART_SUSPEND, the reader never gets smart_suspend.

pcieport does set the flag for the port, and on this machine the port
stays in D3hot through suspend.

Thanks,
Navon
