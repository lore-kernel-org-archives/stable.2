Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F545A288
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437479; cv=none; b=QM64c2Jo07I6meGwlKxAsuIGpvzckA4PWhXZmrxE/JsVVmPNX353Ac7AsTVuvMJr1fYdC+cmwFVpQjDTnJE8Z2miht1CC4lf4zyIKq6SO1kXg0eyFwUWeI9F/N3FIOIGs5nqPmilS93c5PrR3RdbXI28nbuNOtHx1HoGnHhy7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437479; c=relaxed/simple;
	bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPt91tdGdCTSvP6AThivcq0zbcwXxOti660bVRav9hr6kAaNkZ4ZEEpBBGtvw05vW1PucPFIpOjEXGbDthw2BvmfDSJmJHWJ9LRAZGve3hPaXByCukhGUEgsih6Yq7qFAvWDnfMqZc+/uZVxrlnL6XEzHCUQse5UJT23dV3LvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbXSBPwl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXSBPwl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92f03daaa97so9673685a.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437474; x=1786042274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
        b=dbXSBPwl/axs7jdG/NBdo19m0EnLk6VSS/imBSQ6U4H1gTcP0BWXunHCd+fhG4AX6w
         ncW3/R9auVY9V4P+fCFDoOxnL2RF99+ZuHn0upWPZF/kIV2+/uah8h5f/ca/xRNOT0Np
         bEV7CNGcQqeNvNuvnwgWKHyVhzaD208sTapD1GjMx7gdkTpumWofIS5DSzT1e5ljAj+x
         P8W2QUao4629ATFS4u07xX26ggH83i0oGmsPp3g3Q4nBWIe1AetNb/Qd5btvHJ+ZVjI6
         MBVNWkV4P2DHEwJoz+ncMgr+zznAI+hyfG6yJKCtRGNa65TdKaLpZCdsjCRzY36Aer8I
         8axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437474; x=1786042274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QasLks235D3Eb0nbmLmVRu8yqlEceaufhX+B37Vh9zU=;
        b=IinKo8zSI3T5XtbqszMh6B40lJG6ky1TZ7YwGe+KTT6CAQkoLx5Oc0Fy+D/FRV/oro
         /ofNRQCfDR14r0Esp+eNcqngwKhMo7lWkp0a06p2W/Ofzj8d0q47ej3ZVfyZ/J8WPLDH
         nn/918qA/MubKB1ayVCZhhvn8gPlRARNDS76Wfyl0oY8W6T0dygHuGezN2JpRieFCfNz
         U5Qs+lPnPVfJ2/LliSMC5I2SU1K6Od6qXu6u5t/Rf9RqQhpmBdI53K27Qcx+DnRjgbfQ
         wTcBcWatdknJO2ZrwnHK8HjJBR+4i3he5PpPTGKKiQQP3JfTdgOS0+iVG5b2gMl3ynum
         0ZYw==
X-Forwarded-Encrypted: i=1; AHgh+RoKTc89ntC1UFd+IMlk8DU6vsnIm2VAkLzWWKatlX4vEV8+EdlsBvPGHd1Tldbb89rCHCls0bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BkDIyI3c1KY1dl+boqHh5Mx9m7kkEqd1WVPmkDQDO3IoUPIJ
	N02iSK4hxtE9CF5/9LnQBj0IoKMHPnaZ85mcHp2y0PKy6ZOoRV+x1v8=
X-Gm-Gg: AR+sD10rY7FZb7tfElH6z8tIEXw70Msn5fUPzIQd6ZQ7rZr8uEcg7UuQN5NPpIWSLQ3
	CeY0EG3qpdO0m/KnwHox21THV4aCDLFeuUut+iNUBFOfeJjG7zH1/+9J/4oWYc3J356I2K4JSkl
	DnB3aLSr1PGPQncDxjXfCMk3f/LDa3D6ELqsGBVKnRN29eJL6Yr1xPzDsGVqtPRaDU3fCadXA/T
	FYZ0ax0ie9/auWd9t3BC+gxEGDK7RvjyhUaDEZm0Y+Qp8OgaQF7U1jLSEaG24qGkzCBC7FZTv0H
	H169RVja4ZRECpsNjzkB9egm3qO6AcKQXAE2JM5cO25xg/ned3qv0P3kAHejW7R8Qw+1ZZrEIGg
	I9LCE9V85nB3/DSY4PkB7WyxzGekVPL7gQESB8SvT4zhkOYW58taVzSrzgM18/664te/y/eR668
	GgfWKeomHGW6j9EEEv321rPbKX+ErxoGPW90dd4ppqwiwSvETfiu81SSuprMUmg+tkvYkHxot2I
	xRo3PPZ3P9hrDJPokRB1OP8AcGULvbQ+xRA8KVHoQ==
X-Received: by 2002:a05:620a:a189:10b0:92e:4a4a:4478 with SMTP id af79cd13be357-93485fc90bamr300178385a.31.1785437474388;
        Thu, 30 Jul 2026 11:51:14 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3220f1bsm470795385a.9.2026.07.30.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:51:14 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com,
	hvilleneuve@dimonoff.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	manuel.lauss@gmail.com,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx
Date: Thu, 30 Jul 2026 15:50:42 -0300
Message-Id: <20260730185042.28678-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026073005-clubbed-spinner-9e9f@gregkh>
References: <2026073005-clubbed-spinner-9e9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This breaks the build :(

Thanks, and sorry. It slipped by because my build had
CONFIG_SERIAL_OF_PLATFORM=y, so modpost never flagged the missing
namespace import. v4 will add MODULE_IMPORT_NS("SERIAL_8250") (as 8250_dw.c
does), I'll send it once I've confirmed the modular build.
