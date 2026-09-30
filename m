Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE4282F2A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729279; cv=none; b=A6tZyc9u0o1Wbqa/rLKFQeVYr4jnXqPEi2ipCLbE9zL1CcLUs/bjyDGh7vDoc/WQEsvYjlcMe6JQTAA4NohBFX0bUSMtIlK3pK9Z+8QxxeWF99ekeH8AsOrDMKzWwvfK1gmn0lmak2dMkfk0/e53MKYeTxwOf+/RUo4aX7cnmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729279; c=relaxed/simple;
	bh=IkJ9vtM6s7ZyhaUSNWu4KEIRoo54ySib6eoHDno0ZzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSU8KuBrfJue8NMbToR2hBL0J9cTght4aul1Ncv5DffnRLIGTrnu/cgB4hKa5PD/Szif5Uoc9+GL8M842o6bJjQmTlMvlQ1O6k8aAWXFKk3CuPekbA43c/cLgRDiMaEyn002YhZwba9H2D4mzOvEUcYw4IRqRjthVpBYjyS2Fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=SN8deThB; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="SN8deThB"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-885f0eca6c4so471673b3a.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790729276; x=1791334076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
        b=SN8deThBfTLAfxUrRXB8NfVFKSg9BKBgSG/I1r+g+TtwdY0D7V/IRkCTZX96sa+J0X
         8ZKeCS7kCi3JfcjJfBxvGMm9lsBKjHVEz50fZXJ/Q/6bzMOnpaApDANQ1Q/nLLlVBYr3
         D/M916tqwvnRiQwingSCKNlvUuhDCs88/oaIAudgv8ddcBzY0rzDIOwT0rdJzoaqBoq5
         Ho46T91/dZ4XJz9ghF+3sGEX21313eRIMwuPDDivStBzjtT/mQ9X3xjNvk2w1X8MJmxl
         NX9gQEZgjTgo0Qjdt430U9ArWSIISZkyvIQpmFlFj1kQRetxkvACFNI/g5viJEGUKNws
         /I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790729276; x=1791334076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
        b=SPvexgdRruAvRXnZUmh/vaOU2gV4srMvu8L1bS/KMfoEmiOdEGf9cJ/dedF1e/wnLX
         WPIXRV3b2YQ/u7wWQRoiPnd7Wa1P+zrxFsPMn01LhZEM37Zs/RZH8XrqUTpPsjzew6KP
         vVCLfNWDm6R4S86rOiY4ZAf4V2Ku0uYE9kv/iyRlAU3bdl4hokrXWMM49+s5MYZgrBPK
         MW7Xytfqt/xDJzALwypOdjv67OQJ3HlrMjayyY1rE2Wxo1/+I9TwU5DAcWSqmUoneuMh
         VVw0QHWfEAWY1Ew3uPvXsa4t7aKxByesa3O4T8jxZhel3MbbXn+RDPFKdJvuS46Dtl5H
         UwMw==
X-Forwarded-Encrypted: i=1; AKwUvBxKN5lIY+opYKv1VjnK2DQbCo9fpvVq+DRml73h1aEsdv4ddDxwtQcoe1VzSr+XRk+lhvvCGq4=@vger.kernel.org
X-Gm-Message-State: AFuF++ns6VYAbKe5c6EtRvLHDfcNFnqKPrajifW+DvAjWDxE3ZGyM2ix
	q1fkFPDdJkORINn3CRTyGsHJO4PyPpKVvF81SXbHDOtBDfjun2ExTM+7sadeve+63jU=
X-Gm-Gg: AYBFou0BBVkLPl9p6Ei//OZGTunkxMgQdkY4r4w4TD9LfmWl/UJWcDFMBEMlrEYp4xZ
	zi7XsrjusZ5Ea1xdNtg4sGroDBCVy2G52aO3Zybu70s+IqVuwczhnCiPVTVjHFl9OXgwj9K9U+0
	4N6YOadUtNPZCA/LXXvImgA9gSro4+aMVTBf4kCd3VOV48kbQ0k2tsYfCiYNgrC77KkNt19CIMK
	hY8IPfBOPVN44PAkvh/9X5Y93XBoN8QyWWvUkZ2/DZyWVR/vkTj5RDMFZUPo33d9KqjvgPcSciI
	mKvJEYXWdUMGL+43+9Gp22ebpfmD+fr5UI6RSQqwX2TMamv28nod8RHmxbsjJhWNt+44wleazpO
	XYTVWqHrc70hPPOidZKtsGtTIbTzqjGE1ogdzChfXz+5Uibsg8d0BY+KW6KmiZ3+efNiqlbp88A
	VTAKjR9/IQRqqRuIP1SEIqTPesSwQ4Dvll/Rw2ZrGE27ClGv2RV9NCBkwwwlNdJAXPk6lG5A8bm
	wb+WhpcuX5hONnr/C4Smrc=
X-Received: by 2002:a05:6a00:1906:b0:869:f065:f499 with SMTP id d2e1a72fcca58-886c3eb14a7mr659287b3a.25.1790729276326;
        Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8868ba02d02sm560259b3a.21.2026.09.29.17.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:47:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:47:54 -0700
From: Joe Damato <joe@dama.to>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Message-ID: <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
