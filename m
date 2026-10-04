Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67A3AE712
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116947; cv=none; b=Ow3e1SfM+SbQRr7dNQ6/zI+jOkOSZ/htqs0GnvKQXI/UNVTSbgByv2LxmPIOSYrT7EDNOcE50JjIpoYhJ3Qpsty52Mord9V04k99kHfZwskzYHCmBJ1R3shj/s9BCt0zivgX258I9bG0wu2ukkjc4NCLiZKvFRC0ne+rJpv+qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116947; c=relaxed/simple;
	bh=O8AOb5QLaO7btcj37/Ldlt4sf7K5LubilbX/lofAehA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxGu2E2NhVawNmPxSuW3AaSs1OJb9LD7CDuFp3FfgHkQ+kC+d1tWGX6bwunPV+oe+73WrRwTnlR9fjaJBJWhQ/SzGxbaakR5zurV2fuzJFIXYxvUKhxwrVDh0tpKQCi8llHSGdkP1uqU4EAf71s+E+55QtDdsZ6jVVuHJCEpM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gvPb8qHC; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gvPb8qHC"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8875d220446so56877b3a.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791116946; x=1791721746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFxRZe/WwmbBPaTtaFu4NCRozMGI6L0mmZzZk89wk58=;
        b=LVxrQ5x5eDb7cGwhl96/rtmC8cyYA7WpN8Sv5ZnsZIwXWZt5v64p61C2kQu8UMhnGt
         OZ+xUyCftD6zTHYqdj/FT8V9ruvIOgNWvSEArsRqdTbU9p7SVkNltN4QfDxK2LnQbw4N
         CEls7Itz+NZA2H59Afg61g3YssY9DtxesF0ZFSR+hdwE2aysa0/113BWXMCZSHj8rQPb
         sBwqvt5Hys9bCj87grc9ib0UmVcIv0tdZwUvaL+u18CG6nH0Orj8MtUo7OemXh6BpZXS
         zUKYERtxt4bkAu3I5QTxE/9ASO4lcKlzSVWAxWtZ7cGq01JgjIyQj5tehEJKgG9chM9t
         rx+A==
X-Forwarded-Encrypted: i=1; AKwUvBwK9GSNb1MUNmc28bNbJeyGVNYKkOxrbvJ+n6gPXVNiEocvH9+5o4Taxd6FyucCDj3RJCoyCBA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF0mQwcSqnl3wtsHdiAIrGfDdnFgo1t+TdThKxsqoh3JGJQaEs
	j24GolxzbyT35nXk+jMPIygmuJcHMZF5AoDKcslLQ6ZiF7D2aobyKWOrAgmcfbQvXQSW/SEvzzb
	UvV9Yxrv5xOJe1/Y3+WbYauRRvYDNH5GqDebaGitq2v2cHfL4s/qJCXP7gGrlioY5RHTZsLcd+1
	fR9iE94UMsq+388LyIygYPJMMAPBfOX0loI1TVYZPNvuRMgIhkW63KSF316ejChbdqaRI3MC1q1
	U/IeiAxs6TfWIK4pw==
X-Gm-Gg: AYBFou0Cd4AqqogKRCTl9Zfjqq+5+nqdSCC/WXV7/tUbswpsF3VhFMIkdCCPxOXQ8J4
	pFse3Bq2wsi4etvWSl3RjkbtxV+dU1Ed4F0UrhQQAFfNKegG1M68UXYcTqgsFDFUpihVrwKWDlm
	gHNDeuUw3jxE/cjo9Bu7dfoMlq0XEsZCfxMQKyMqIsrksejav1kcmJFNG01hFNl6wGWeuZvLSqO
	OMTF7zyfjx/Ls2vrKjU0nrtAysNaMmRJHIP4+pX+vGLYUvXIGh+nDwmK4IGbHtKlyYDGQnWM6jx
	BzyzZfKYGA1x2rpmR7R5/DaX/mXSUtihRhZe5/cxo/geP+39NLogoeTqel67ypwFvRsKfa8NHDD
	E+zzVCX3Xx1rIkrDjrsWPNY+dwNRSsWWfvkDEoyyJ6q9/JGKGmEAR/j4+YXFkltmhZWd288w4Mi
	z6RwlB1korIAY2pkM1q+hOhJzQBBaBUbIhmaVjdxFGYQ==
X-Received: by 2002:a17:90a:e7c9:b0:3a0:eeda:39f3 with SMTP id 98e67ed59e1d1-3a6e72a7fdbmr3396111a91.24.1791116945671;
        Sun, 04 Oct 2026 05:29:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a78d62242csm2672028a91.3.2026.10.04.05.29.05
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 05:29:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34bbf2e3c5cso1967670eec.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791116944; x=1791721744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFxRZe/WwmbBPaTtaFu4NCRozMGI6L0mmZzZk89wk58=;
        b=gvPb8qHCErwh5NKRsf5UFEwscCV9c5S2eu+wxpiamYPbZf9l4WkdeYTyveOivSn7IN
         6Et0yXw0UM8kVfOf/GPgv6+8MM0PiBkwMMPQCQJlG06fD0/Kktj2LOnzlCgufqSovCGv
         yr7Srn/6hRj/NkMu5Hn5EBQ/AWOPsy+1a4TLE=
X-Forwarded-Encrypted: i=1; AKwUvBxc8U21w5lDJbXsH2lbZ6EsFGzpDjHW2JUucsQGGcPMIrKoAExyZssJn9YomcMkJrtgKR+bN8I=@vger.kernel.org
X-Received: by 2002:a05:7300:d518:b0:34b:dbbc:a72 with SMTP id 5a478bee46e88-34f2185446fmr13565352eec.24.1791116943854;
        Sun, 04 Oct 2026 05:29:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d518:b0:34b:dbbc:a72 with SMTP id 5a478bee46e88-34f2185446fmr13565295eec.24.1791116943044;
        Sun, 04 Oct 2026 05:29:03 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713861fsm4656855eec.10.2026.10.04.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:29:02 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Michele Dionisio <michele.dionisio@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/1] wifi: brcmfmac: fix P2P device removal race in brcmf_detach()
Date: Sun,  4 Oct 2026 05:28:57 -0700
Message-ID: <20261004122857.1391917-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924123027.4122909-2-michele.dionisio@gmail.com>
References: <20260924123027.4122909-1-michele.dionisio@gmail.com> <20260924123027.4122909-2-michele.dionisio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/24/2026 2:30 PM, Michele Dionisio wrote:
> When the driver is removed while the user space process that created
> the P2P device (e.g. wpa_supplicant) is still exiting, the P2P device
> interface is removed twice and the kernel crashes.

[...]

> For the interface without a netdev (the P2P device), take RTNL and the
> wiphy mutex in brcmf_detach() before reading iflist, and remove it with
> locked=true. If brcmf_p2p_del_vif() runs first, brcmf_detach() finds the
> slot empty. If brcmf_detach() runs first, nl80211 does not find the wdev
> any more. The interfaces with a netdev are removed as before, because
> brcmf_del_if() takes RTNL on its own for the primary interface.
> 
> Fixes: 9831bcb987df ("brcmfmac: Deleting of p2p device is leaking memory.")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5-5

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
