Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743030;
	b=M4gYpvbXEfhIIektIQ+RGV8VSLYpDng+OyuLnv5M/ytWJmNr4yrOxFiQTdpxkilr3AO7
	 w8qV4R7dprccYpnsMyAvlqN3iCeE5w7FDe2Xg+NBG/eUOb9nB9BHjyiWsHOLtaUpWETgV
	 A5VIV+a0DeDWmCfGPv5d8fIKsUO8hlIrQAjkgCl9WdjZJjMqeXl6jMLYtB5xRYqiGYilX
	 tEhIDPDRyf9bxPTpXwEzVLRqfs40y6WY3t+u+L0OVq20A3T+hCrlXAKa1CkYoZtKIPJxl
	 Sm2lepF0931u8/U/YNfovC5y9OtlrXg0DgOb2VVb73sC+D8yxvxfVOh5k4QVpKf9jvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
	b=0ZMEd5YvSD7WJHf3bILcD1T9zst5s6luMDHWjrAY8myA/Nu51ZW1PPDrI7H4DP1ovv1i
	 90NSAQhrbb7kBzn1fpJMjDSMFIr40006k+XtBDfrNddE9VcQLyXgGz7B1foIksAVbdbdF
	 kjcvzVC7BTNUeGxO4epwWjxc7FN9nXONFTM14AHaACi0hEOI8t0kJPh3P+B6e7M9r867Q
	 VPOGUaLGcnj6/v/jvDPZKd6S7tki3mncFf4rZqlShdvTAdfpRHOvFr8jmS7LF4hEyE0OF
	 p1Ag5hTQJMaPBZlew7wwm0c66TcvpXc1sP903egKu8zqFaoyujzEwE35fnb5B8y3cwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tubLW7bn;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22330606A334
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22330606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tubLW7bn
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso1731874a12.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743028; x=1794347828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
        b=tubLW7bnYjfWqdPm2oGDw5PfxnGrX3czHSKi31HUXnFOcrxrOa6+OLs95+7frtrRyq
         GhtrNCDB/x8RvE+XHeqfkuxc4V2DejccpHCwOIrR65Bwf1Hy1URQ3Th/iEPrrcDS8M55
         iuUYRl5p0RoSaJ0W77WD6zp6+wYSAlO/NrTRlOpVjHhZUMBpfTzcgaQM/mn32v3R4EJP
         k7IBLQs1uXMTjduHml1DmTXVrptlDT6F3vYg3hdWTTgrjUqYnaafou2TRwUM8DdxUnkd
         5P7/Mw9VGFSDvM8FTs0dEpf4e79B0LF5V8yvbxNUa2DeLyXc7HFNXH/TwxDaQ6CU0NU4
         oSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743028; x=1794347828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
        b=RVsQUEfQPKJkNVQmFjtAaEkB6GXstUks37zRV7FVJbrtkzEnC1ZiESVcbz9dyEKMpd
         YnpXNMsIK+fUhh7CP3F9CkZo0WIDJ9MxPygU8hxIgkNaepMcdd26qE9knr8XE6P+IssT
         lpep9jSPqzXYh/HJPLBevzH9urxAGNhaoL/4JVpyzQT2djnb4ECTRFm9CMwyTT/FysMQ
         MmWpp/Qply21Ro/Z0uSS9POkim611itC6td0DPo/pVrS0O7jmtkaIakmI+/Wgy9lnx1D
         SqhA5BoIg2pjhye9YOaFuGjrPrAFOBqot4zrRW7h9nxbnUi86qlPF9l0aSiq8nZI9gxp
         4U0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlKlTXbuqvEho4N5A/qMolCeoQGD3q8PLaCu6D2yYC5MAF41sQaajUAWB/94O4sxhx0Lv76s4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dnw3Ab+1JTmQFFzaMFJyt05tmd+5nZGQkRh1DNcRKnPJ4ddW4
	vgXMUlRgFsAeFcA5A3I4hCIsPkAQTI1Yfxn7PxdE7RgbgXcooV7jfkr/
X-Gm-Gg: AYBFou0J8dwJAaqCPy/J8Csk4s7TvhqXkNqylIjjZAPymoRlTjNKn6bXXZ6HcwDsr0S
	skD54cQnH9mnboE5l1Fe/sDYSWJM5hnTtNvEVtEUrgmhSaIIT6DdIfqe6s7+6RdXw8FrMavfmra
	FRN9xnClKEhNVea6hluZ/692+xt+JEtSXNoLL4EbrlVHhx1cOtcQC9dPV6f1OqiaJlPyHiac+kl
	Nq/mQ8GRomoxO6K7jrnjcPr2LC0h8UkIFwWFUxNMmaVsESfvoZ95+KiYP2Wr4OH6TP2Lj6BKsE4
	BZx2IaR+NwtBpSnHIUjZ/AXNqKPSs1xZFWwkp8hotYSGKUgPVyowUaSl6fUAAf548nXn27riLBm
	/tcdHSfeQxiglhAyuOkXOJjnvPrkCucsY/lELrVI4P9IxL/mwT7NjBSjbhVtYrYQ034Hv46RxQ+
	hajOV/4AA5AfXubu1LiDMuLxIeq0A00t3m5K/HUpJ86tGSCOEHhv2OsF6wBYTo6HiUrM6dEpZuY
	vnZxbghce7rJ3P93DiF3JcadH4X3aux6lJOt7sDYqogOut4uxwJyKiz5gDWhFadnIckYYb8SoVR
	X6K9K0vjbMPqlYO1Oh5t3IE7ttHT9gx2vFxCtKhJJy3zEVgBRhgyh/2BrTt+m/gN7lO8/7goeg8
	Hgj+Rta/rOdG2aS+S4SUjLGU=
X-Received: by 2002:a17:907:7247:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49d13b3532mr1528577666b.18.1793743028344;
        Tue, 03 Nov 2026 13:57:08 -0800 (PST)
Received: from localhost.localdomain (87-205-122-125.dynamic.inetia.pl. [87.205.122.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e495f70sm3697866b.76.2026.11.03.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:57:07 -0800 (PST)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: cassel@kernel.org
Cc: rylos78@gmail.com,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Tue,  3 Nov 2026 22:57:06 +0100
Message-ID: <20261103215706.508495-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aui0uB-EkF7MKOGb@ryzen>
References: <aui0uB-EkF7MKOGb@ryzen>
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

Niklas Cassel wrote:
> A Tested-by would be nice here :)

Happy to test, I just need to prepare the hardware first. I will send
a Tested-by once that is done. Please do not wait for me if the patch
is otherwise ready.

Kyrylo Biryuk
