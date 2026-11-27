Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746437;
	b=BqeZHBBXbPKrt4cbqd/RQibH9NQct9beAH4OI5UTdEmhnrWvuV01S5dUqVS4pfm+UR6m
	 F5mPIOkdiD7ssoW8b7dfjfhYk9ezQesGfVFS4Ua3TcZ4qyHSP1OoLz4S0iM3glQTKrli2
	 ONWdkt5ZP/68FiQdGpgrfwJQ1QTkkzQ1/2cL6M2gQ6WrpKTgqfnr1NERHXbj1xKqXyW3L
	 wiYTaZckFaVZba78aiFKcRwEq1Lfd9+sBJk0zS7+61fZqC5x2QwLrnWiVh3ULvdG20IjR
	 iKgtCX4ufes60BMGMgmuSyYxj2DOgQZoz+kRl2Mp8qNQDVdsN1q27yH8OOeJDI7bNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nJBBBgFeyRHLupMJKNp7qu0AyiXuwDo4GRynD+DGoec=;
	b=VHX59R0DHWObwd3N+LXuhToFWm6aff7nYWbtapJo84C+JEQvN0o8pMM4wOCmPnEEsQvB
	 IoTGNf8GaLUVGPDZ/oVpKUiONAdbO3eGq5FXGU70eZN8XfudiaU0okRd+GUxBN542fr7F
	 axnIzgjQaJ0XFNxWsy0i5/D604WGrvyRXbz6ymG4hIsyBSZn0VMBSQZaSPNRxLBV/OLav
	 u82c6f/cVJ7gQPPiVlrY1NHsFS22br28rtxHuMZ2Y1m15mKREWfRRn7aWOXMw2UoeLZ0t
	 bu42KUJ32SYGIRqDNs1chMV9Qa7nvAMAVrigvKBRBdLL/EJCfdlWnj15WJwurzUmUjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SYoD0ME+;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED2606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDED2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SYoD0ME+
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdece95eca4so100845a12.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 18:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746436; x=1796351236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJBBBgFeyRHLupMJKNp7qu0AyiXuwDo4GRynD+DGoec=;
        b=SYoD0ME+aq+mD4AGlnesWPsK4E9RbOCu/bvQdzLNNuDEa9pF+waQ+DvrJxtWfE+kDl
         B3wEtTn9ThiDuL6k6dnXxBcST30Vo+fj65hhsSxgIA7hwMFnlUx2ex0vxdSciZcKRnEr
         yzvL7XZMg3VS0YbUBJWk9ZP6qpjK/1CxEb1CoPfyB7NRww1d1cVV1SQYVseM1oYCDwas
         GeIUrSYJ9SuA+c9jJ3n2pZSaC2XalvVpo8CZAho50rz3b3TTNOTUwrrPpb0s8JWqBFU8
         516MxTI/TL9NYUNsDlTDXsPHuCgAwYklmTWRgpQUe0TuVSopDPogULSL1SFPzHCI+fR4
         hQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746436; x=1796351236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJBBBgFeyRHLupMJKNp7qu0AyiXuwDo4GRynD+DGoec=;
        b=NHkAfbQuM0xREHtvlBvg9w/nBKXUKTYUXxlLhiiy3gaa3ANverBT14XZT2SStj8NID
         m5oR3mcreNLoTtixt4CBvFNz2SMqKonId/u5ksio7Lz4bqQ2d8/2RGPhH0zmkPZd5K5V
         48J87s3zsA0Z1fGwcvcJ5fMz5PRZ5FsUuEQBWyktaS/X3g3hdb8I8w5jRzE1gknlXMvw
         fFSog2XZ7Rl6nDP9/w5gw2iZERmyL3ijtO2bGr0ypz6Cd5aJqnnEdzgtGdzBjnGlLHCW
         kJ7VH44+8kmrM5kI3AyudEtYjp3mJWoHA7NTtptQ2QI3emrgCinIrIsJ5Hc/ivkfwLI+
         M2hw==
X-Forwarded-Encrypted: i=1; AL+hErGQYujdQEoj+npTfkUXSsv0DlyGP/+D9j8xYnKPS4c1/G2OLa6vPsK6Gucyqw/GFALFOfnHKQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/DlG+qhBO3kB1wNXr2tJrpNXp45x8fh0wTqjJPyjP2dAUyY2y
	loPDkBZlMTC4lWb2ivVwoJRZ7yDSPq7dl3yO2bYFgHUY9bRbMimbqaCa
X-Gm-Gg: AZFdTZdl/uEvEAEZfzoVbCarcypeZKD8iw5iIIT0YRh1Rpe4cLsH9icpRh+VR2VzTZA
	Nt8P9/WSyjoPjRXwS1loQJ8tO2PbWq/RvDNsHlzGwXfA9VLzKfVQDICvPAWZ9c8dCSk/THfnlDj
	dwTtJrbBxlEVha5O7scOXwP/5Kh3DyQfsrDdBXraOVEm286G4hPJOOxlCF5xxodq7XcybkC6p1z
	wKCNr51pzZ65XtaEt2F8JWxBUggcJeRoDlHwrpOLziIyZeTyUvKK8y96PnQOExnK84Kviw7G1Ua
	xMeYCb8pUXOhPJBEJz8xu8ddtfsGT2rmUfpLzfI8zjVnj17BOqcQdfBQXyRyD7GBx8LDPunRgks
	8BTOTMA9nR88DIhUh77PWWybaopTFtZ9vATet5xFDAi3dpD8X8jqZ92n1JIbC+t6Z6e3QVSlg+Y
	2klTEmQCtCzG0j90339/tNlUUQO3e3Y66ykgajWSL9rRLgeN5wCEVY/+VPOuDCZDoLrrPuquAs6
	eAvNqY/wfpnLfvGnpluuuv7kRod6j/Q3V2g1VTyiH1fjruLKuMVpiiFis6VeXuHqPLWQyanAZLW
	coqyvzVOKgyZNhDvX9bQJgjSpdAV/KYU98VI6Z7a3bz6Klo/H/ZYoQNN5gJmA/zLMqoC5TY1T5l
	BqgDKOEg=
X-Received: by 2002:a17:902:c40b:b0:2f0:7db6:50ad with SMTP id d9443c01a7336-2f07db65335mr158745195ad.18.1795746435838;
        Thu, 26 Nov 2026 18:27:15 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-229-10-180.dynamic-ip.hinet.net. [36.229.10.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b58fce71sm57903655ad.45.2026.11.26.18.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:27:15 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jacopo.mondi@ideasonboard.com,
	kernel-list@raspberrypi.com,
	mchehab@kernel.org,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: pisp_be: Initialize lock before requesting IRQ
Date: Fri, 27 Nov 2026 10:27:10 +0800
Message-ID: <20261127022710.685062-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
In-Reply-To: <20260830150045.2704062-1-runyu.xiao@seu.edu.cn>
References: <20260830150045.2704062-1-runyu.xiao@seu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 23:00:45 +0800, Runyu Xiao wrote:
> The PiSP BE interrupt handler can schedule work that takes hw_lock. The
> lock must be initialized before devm_request_irq() makes the handler
> runnable.

I tested this on a Raspberry Pi 5 (Raspberry Pi OS kernel 6.18.39),
together with the other two pending pisp_be fixes, by rebuilding the
pisp_be module.

The driver probes normally, unloading and reloading the module 20 times
works, v4l2-compliance -m on the pispbe media device passes 400/400
before and after the reloads, and there are no new kernel messages.

Tested-by: Roy <rongh7426@gmail.com>
