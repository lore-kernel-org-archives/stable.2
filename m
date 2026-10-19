Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69749CF25
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401179; cv=none; b=Gv3oFBTk5JqCdE/4mQdIJesn9Yzf+T9VR3dgX4v3onDqzHB3RbtR++jQjIUi9/9cDxuq/guvUXPrwHNalW0EbCf6yVsNkiutd62j0H6VBt2MWrvAN7/jqOCnfpy+Tmi9F6fgl9CmOQOAthTXfwTeFMlOO/Z9E52iB1LZ9qu0Ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401179; c=relaxed/simple;
	bh=t/h5DpMhUIYeLONHjlycBELUNoQmFT3rwegVO/JrzCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9d50Pz3s0OmT9KwXkHC8KGoBpufwSijKCrUPwUE7Vzkrrrp/klKzdmL3f7T0fcYKaIILTuhjteQqdCQEReMVq8YsA0gYdEH9gxGZo1LyBefMsonLsMANQ0eSvgD6M5UnPVWRlmchG40P6JAE6iQqdakznC0dng9uyIqHhnZRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/P2EyqG; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/P2EyqG"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1832200eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792401177; x=1793005977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/h5DpMhUIYeLONHjlycBELUNoQmFT3rwegVO/JrzCw=;
        b=h/P2EyqG+vz/k5AG6bPvlzBTpbXciM8oS4PXFPyqt0gyHmhbnqh/x1ZCDItJLnJSvv
         FHphneFX6sD1g1iyvN1I4vIly2ZNj02BmotmVvzZgIGzPOIrmeJQx1Ha+XfDQI40LrBz
         qkP+UfQLzZc6oN36YZ1/vp1Bpc58q01to4oFpb2Et3bqBM6ZegHZPQigoFfxslIxEr2n
         8UiWvDJL9gweZSzWbSeU18GjVYnOKalGoU75jeFOW8oNeTmkmo9gZGagpgd7ATOtQ6ct
         pBTa3lAf4SgawdmIZCRfne9FW8otDRf5tQDJIuACHZD05aHwe0sqpBMOCJvCSOMYEQMC
         BVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401177; x=1793005977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/h5DpMhUIYeLONHjlycBELUNoQmFT3rwegVO/JrzCw=;
        b=pNG/7MGUcxavTJEmjP4T/Zxh28AEyOvmCayUneRFmy/gKDnhcJKB5SkxC1dv602A6N
         ZDmxP1ahdkGZpTD9bI3ok5ua8J0csEBkhz2pyPMiCtdhAsl0XWCzgqnwR6ucUoo7KJZj
         pQXCDwb2NKFOF3mS3q+G8GHhKXsQo86Z6YGPefLEV4p6MhkQ5XLPd3gBSY30oSIHxman
         wbsawoWlwTOkYmXOPlEnLJBSz5zyiCc9gIHoDzOPDtSMeDkaab4HgCMCf94oaBZSH4Ac
         RTc6jEJNfrxzozBySuZkywFTSysG3rJcSmg/GQWr0q8cWYF7bfLc+hNicphjnvuze8HP
         j6ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwv2/Zo5gDt+ZyLMAKTexwiJT3DXPRwm8hU7RGo3XvTPeP/C7sSm/cxQ7c/TbUbxOSxEqWnG14=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Ji+vQuxCCYnl0DmTDYlngt7OHsg9fYdgrcNDjQEZI+re9i+p
	sosPRt2H7IfzQ7f63g3bBaSU/PILmmdxF2jOGrLlD7e8mg6iyf3TZKnWm3MDK3egoz6maQ==
X-Gm-Gg: AYBFou1BPX/ysJvA7wZKLPhzHo98BqM1HZOZSazvblx9yW1r4KKUR3fW0ziaxTcrT0F
	556H0d2LeJyRuY5xWNIzLBMXx7jQDyf4beVBgIHJBDUKOGglm+uPd/ySnQec4jGblHOn5V/B+gg
	WVi8kH9awucY6grin0an39NynmQYSSRr8mgyKN4/T/m5FdsRZGzSdcpzSafYmY5rHLB8U/BPM/X
	mRT9qcL7doBxLP/x74349agOhtUQ9GYwjNLnGlNZyouoHvlD/zU3qjVRrhpHIllHv6s0R4BqH/a
	tBKyqWgaxCKmnJeZsGlwN+aUiXRofeoptOceYloCBE9qgwVCKf3lo/GXmu1QeE3J9IflhlnEKZ7
	GWxNy0VRsUhXC5XrVZOMaIzZjbxCCz/Frr5oI3bFrYJV1KS1gCYWdKwOP04eAQVldZo4BoTMGrk
	Mq3P5pG4M4RcM5irAHefHQxurPIXIUKDzpawNJrwMJjXHfMfuXm0iRPfXfAUAyP6/aBJz6xGbnN
	Ahuw28n2yM=
X-Received: by 2002:a05:7300:d588:b0:35f:4780:518e with SMTP id 5a478bee46e88-361a16609bdmr11651555eec.16.1792401177429;
        Mon, 19 Oct 2026 02:12:57 -0700 (PDT)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819be413sm30693119eec.13.2026.10.19.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:12:56 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:12:52 +0800
From: yyaqia@gmail.com
To: Helge Deller <deller@gmx.de>, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fbcon: Include font geometry in the rotated font
 cache
Message-ID: <atXeFarSzZcJmThe@blue>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-2-yyaqia@gmail.com>
 <b93a87be-f55d-45e9-8705-74a5c63600ab@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93a87be-f55d-45e9-8705-74a5c63600ab@gmx.de>

On 2026-10-18 16:05, Helge Deller wrote:
> I've replaced the v1 version of this series with this v3 version
> in fbdev/for-next git tree for further testing.

Sorry, the patch was not good enough, Zimmermann reviewed the code and I
did some modification after that. So we might need to switch to v4
version, sadly. Anyway, appreciate your continuous work for testing.

Thanks,
Yao Yiqi
