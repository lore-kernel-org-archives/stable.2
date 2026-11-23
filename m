Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465533;
	b=ZM1XJ95is8N7jUWW8oCZE16FFXHMTOT2/kcuaY8KvKdYW1xZsE4wSzfxVGH10ab8D0Wi
	 QsozlJm6UMYkbvCDr17DwmV1vlDBWwCB5rk7T3a4G+yjFsnppBp9dCw7sIMMi1SWt04qg
	 avLQ3hbrP/twso68gPM6DWqVQqgkk+dH0DOINTi7yVonBj5/xILCjfb3/hnRLEQ3CsweU
	 wCQovY+6Na+hhQpMIlRGP6LFnl4+X4DQi6+UKrJXTKI5v4jpqfD2oMt0+9GpMx3G52I15
	 MpsgFGWx0t5tIO8y1/GEXdo6KHM0xdYDUPsAieScH2FHHOAXZK9E1TwrbOEC9PhsZ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
	b=TvTLCxnKBMrds2g4IxHRv9//MFe/8u6zUE5Fx/T3Hywv+bA2ADgyL2vCOqfRrUCgVZi9
	 zdgRjyfgKyC0E9qgIbEKdgG4B5RzzJywVag/f7dCTxY5wIWW1UlX1mefGJYaE21OhOWG7
	 8NKPozNf2DXLF8R3JTY1Xvz6h1K4ZJgeOo+WHaT+UMOKGJMYIS0Mriy7bYGY7yWxSbJWA
	 AlUtJ2xyxiM20yaV3NkGpHu4zsHH0HmmTmp46LaHlK69T/sjjVIWUxf2M9xP5ObO3KkLW
	 rpuTsmoO+Q+fEu1lATjkJTmHq8TRLQJYlnZnq2afS9oq3PXTj7icoLnXG3eVMlwngRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCd6gmjn;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC3606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBFC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCd6gmjn
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso4727236c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465532; x=1796070332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
        b=WCd6gmjncxMKRkd3iKSikeE3vcvosLDXqXyReoAZrp6OZ4q2WT8+0IcqcC6y0DBGnK
         Z/qPmKd3p7srywRjuTHqBTPm8wHoCQqGrGMP3tiQFsED0ZnQmO2w5ggdMmOqJnaKA1Jx
         dzPYRhXIXslkbw7j8nS0MqG6ExvbF0rpiQi+u4Acp5jjPSCm1LsV7Sq2cWd3DgXN2jvY
         11FqIOt5eHTARvp4KmADAMrXyHWBX67qEzNn5eVvz8+uSyeAJCE/J200NSoJtSqgvjZ3
         dE/K8YQpTCLaYSaKa+Jg2F6mrpdTitmcWKIn0812wjnhPAGL5aAjGTEyLpbI5bMnBfqy
         JaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465532; x=1796070332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
        b=e0rSr9bYHw/n+MmVLKYdM47cRf9poq0MkkSj8E/R9rHUo7JqkZR31E7A/+QNcWVnLL
         YjtJrEomjTSMSFDzQC368gRATL2XdbQX5TptXpeOPD6l3pA5qGEn0bdrO+16TCXrk7LC
         6bfl74sxDhPYwNbp6Wtx21Y86m4nyOFPaHne3GwT5vzVWmG6ysqEMMSd2KU0TInNBAh/
         vs7YQoM6UAwkpfYlhfWM2/aReYn9pIzu5xI6nqfTUYytlko6VPUNp/5J9kSBOlzvho0i
         wDiRBbz5+GKMKGRnRUHXpLr8XE6CXONaLy3p35+VKRPGBf1gYcy7d5v/8CYiRIy/GYbo
         yiAQ==
X-Forwarded-Encrypted: i=1; AL+hErF0EJzqosxhJzLptqni6vII/IRrheAqPK5lZETS+Gedi8hYQvycl9WXx5smNarT6bidDlg3ftk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tVJAGdNd+gzfijpxbUZbVMT7qjSebx5QE30AWDTgsNHSPCNBJ
	NRr3WwnI6cri8Pria05Np9usDPl2uwqV+pBin+O50wn7/arE+j/FwKTs
X-Gm-Gg: AZFdTZeABFGKWODowxCdj2/+JjsSt39vSekt8hy4bxZFypExVzk02mPA/+XxYs3eHvM
	kAIs71tyTAyX5FIISBars/3+2ONqanNgsl21tjCQGB/iYQcfLDZkD7SX9UdvPMCMaJ9gn4BurUC
	qO+hX94TQZTcWzhhO33j/CNa9rWLl5bxIS6ZnTyIuR3q2EEOy7Y+4BPkMyAg3HlBRWBpASW89fa
	B3lAPQuUk4gGsNYtsQYH4ANJj+DbEgZPKUEiyZtxJkDMgMpsP/OwW1XNk7d9/s6UHSbD0nw/3+H
	m4yEw0Efn0IG2Gp5SNGgm+ILEDOBHhgcGdpsc4FmuetFp5SXS1OfknfuXE/uRKTWnSViqg+bxnY
	U7mV31WyD0ZcVzmlhtYwBDvOMmmEopb22cafG3Nb/NopSGuBO4YFIK/XQ4PPSexgIYue0HWSix1
	I6o3dP2RQvzlSF0DojZB7GtkzGdmTluS8C9SWDooQMtqd3rF7F/stv0EYxG1N0dwpHLn/hlmjhs
	VLcXtYX6A83YCUanmk8tqmjPvgicMM9Pe1N2EQmMHxAqlsWODET+oYE6qoeaGHknnXpVosr2CLe
	0pEdV0dUCCPtXTlY8kri7K1wvmxOHhz3rODf7tYWUWTJV0AiyiY+JXY13FkEIJSz5JPQYrU=
X-Received: by 2002:a05:7022:290:b0:1b5:dc3:209b with SMTP id a92af1059eb24-1b5568ac6b0mr11976416c88.22.1795465531758;
        Mon, 23 Nov 2026 12:25:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm29277191c88.3.2026.11.23.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:25:30 -0800 (PST)
Date: Mon, 23 Nov 2026 12:25:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Fengping Yu <fengping.yu@mediatek.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 08/10] Input: mt6779-keypad - enable keypad clock before
 programming registers
Message-ID: <awShM65vJT7DhZLT@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-9-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-9-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:14PM +0000, Lee Jones wrote:
> mt6779_keypad_pdrv_probe() writes the debounce and matrix selection
> registers over MMIO before acquiring and enabling the "kpd" clock via
> devm_clk_get_enabled().
> 
> When the keypad clock is gated off at boot or its clock provider defers
> probe, accessing unclocked keypad MMIO registers can trigger a bus abort
> or silently drop the configuration writes.
> 
> Acquire and enable the "kpd" clock before accessing the keypad
> registers.
> 
> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
> Closes: https://sashiko.dev/#/bug/linux-fc15622a-407a-48b2-88db-195cdb311dbf
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
