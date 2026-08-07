Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50646C4C2
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091195; cv=none; b=KtPtDeNC0Di/Bufm2MxwrMdSAGqQSVrRIcNo1K0Lh0UCWXzokrUyYkzXwr8XEu3nvZg1UGpuyz5vNfSB7IqS/XLxvk76tFg1eTS1j3FtvmzuN+rQCer+baliBbhLr04gbflaUzit2qLI41BFkFuoABMnKSqitqeACNkeZ32NsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091195; c=relaxed/simple;
	bh=StDQICSSTYfrDyqy3wyl3t6MvwAR/CjM2yoIGOCA/eQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YidZ6PL+xTDM9DMwHVg2dRYhWVXuntH0gdhM4SxWNraGF4tOn25rmiBmyATWX0prViti9OlLIT63ZPo1T3piObug3gEXHd2uisl7rO5c5nAtR8W4m9V0+JmkTgxIbAFVWnTvk6bfHk4QKw44XLubLHPuCPmOxSPeML8wKRBa6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odm4ol7y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odm4ol7y"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce7d2adef4so46894865ad.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091191; x=1786695991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rzU8xub4Kt9oAWjkKq11oBriTEMhTM7pr8/P/jz7Ayw=;
        b=Odm4ol7ydpAVlxv2Tu8JZC5PtUTYXy2PRWIh4qlj7UtHSYvQgOnFW8v1qjCY1COJyF
         4BfncxHQ8bEf0F5B9vGRmqPMfsHvtB5ucGtpfd+tqWvks/b7FcN/6OKJFbzxNjBpGLbr
         M/rgtprpheYpi8pJwShXwaTs7IKyuSHJViyo+d2QO5CmDiTSMwSrjEZSPtzDKsYKxZcy
         mLeloD7Tzemgivpy5Qk7btRbxhahPfcJ9jhI2KGpv/F2UTSZxNO+YQX/eHqTliMlpddE
         /dqcJx3BHbQ7kZwc1bfUafZgoTPKi/u+7h+/GTdcAFXSJ1eD/WZt0CMenjOyFZNzjFji
         w9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091191; x=1786695991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzU8xub4Kt9oAWjkKq11oBriTEMhTM7pr8/P/jz7Ayw=;
        b=DnWuuQi/xLRN2768ceC/Rz+gI8gOcgwI5Zf7tuUgyFVgHCYknSrx8u/RiVbOwQZiWz
         +4PKOh/PuW4HWxfuauQvriPEWwzmpwdr4nTONnYoG+YS5LJFEMdWsMcP8Dzhb5a5r0NU
         dq1t4Z1UQxfeKLMn9BSUUmAUK0HHNhTUFcD944I0jgi0UEUYqnzhy53s6wWxTbefKQ/5
         C86P9G/jc7vYDaWo9NiRhRn53ZeySe+oVRDPAn4Yr7P/g7R6nlBGEA8aVzHK0R5i1eL8
         f61AQNl+6PNkfGGtlfeGmX/298JG6VyOp1yqajIWS61hZhtHo3xPHMcc74yt7qAjcBSz
         Vt6A==
X-Forwarded-Encrypted: i=1; AHgh+RonrDCfTx6mjYCHP8bwQdY1dHwOINME0KtnHd3kstkCUj1wr4YM7TToKLfLyCZQvgsqvn8mdAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy556wUKg2pq5/rB2kJP16yjQHX1NkEwDagbjpKmOpc7NC/y12o
	wIodIiF5Gk6knXbu3jnZjwGZhlSO8jahe3emCnpqt+wZhUWqitU2z9Rd
X-Gm-Gg: AR+sD10t60WeldD1QXyd39wVWCWY/TyXNfMQ22mdmxtqSB/IQgmQCdRv6kMCfZEz5j6
	HtsB4cw3vpBvhgrR1P09al/8R320E7oBMXoZS+Yk5l2werjBz7Ni3eqGGog6aE/gT9y89JzNjs4
	0z5aHKN/3SqQPa2Ei4xKRv6mBvbypop9FMeQLKt2dTvwS3/HEvYp3egsEiYgXaoct7HIiZnY/g2
	Pwm+DkRqILG5O3vIyoDbXbNpIfPet/pWn5k0e+KDX8KYyztFmO2heOH5eyvuvjHP5/P+kGhnluT
	w6uEY1mZjKqSBePuWXTxgv3nSd2X9A7O4i5Iycj2XLwyu/FDBXIrn2ZR9n24hVnnq5NHCs1xWIt
	o7pPBnW0WFNTr0l5mAWxJplRku8M5FTvYBf7BIkN4B8+MhotkyBx5+iNSlxW6IrajuN3wLXQdz+
	cDuiuQUA2DKaGySbRD9uu8fdB48mFSesKC8Da2ZZx5ky1qduG3qDI1LJnJtb++5tot2dUSwO2A9
	sXJwl3C5y2j8C3KV+38uyZb/MOYSDp01zoQ+M64L5ubaPRTYVJq6hVcp70Lbs/s1w==
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr2519576a91.13.1786091191456;
        Fri, 07 Aug 2026 01:26:31 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440 (61-228-218-123.dynamic-ip.hinet.net. [61.228.218.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff244aasm1558519a91.12.2026.08.07.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:30 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
X-Google-Original-From: Jeff Chen <jeff.chen_1@nxp.com>
Date: Fri, 7 Aug 2026 16:26:23 +0800
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, chunfan.chen@gmail.com, francesco@dolcini.it,
	johannes.berg@intel.com, kees@kernel.org,
	miriam.rachel.korenblit@intel.com, wenst@chromium.org,
	rafael.beims@toradex.com, avraham.stern@intel.com,
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com,
	s.kerkmann@pengutronix.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: ignore ROM regulatory hint on
 WRT3200ACM/WRT32x
Message-ID: <anWWr80yAcOQaVVS@nxpwireless-Inspiron-14-Plus-7440>
References: <amsBes9fCF9ZdkCS@nxpwireless-Inspiron-14-Plus-7440>
 <20260731063118.26171-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731063118.26171-1-gvalkov@gmail.com>

On Fri, Jul 31, 2026 at 09:31:18 AM +0300, Georgi Valkov wrote:
> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> from the mwifiex ROM, which conflicts with the platform regulatory
> configuration on units sold outside the US market. For example:
> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> 
> When the system boots, it detects a conflict between the user selected
> region and the radios, e.g. BG FR US, and applies extreme restrictions,
> preventing use of 5 GHz and DFS channels. This also affects phy0.
> 
> Ignore the incorrect regulatory hint in the ROM of these devices, so
> userspace can set the correct platform regulatory domain. These radios
> are locked to the hard-coded configuration for which they are certified,
> so the only impact is that the region conflict is avoided and the 5 GHz
> radios can be used.
> 
> The change affects only WRT3200ACM and WRT32x routers, and helps
> overcome the incorrect behaviour of proprietary radio firmware.
> 
> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> [2] https://github.com/openwrt/openwrt/issues/9956
> 
> Tested-on: WRT3200ACM, OpenWrt
> Cc: stable@vger.kernel.org
> Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
> ---

Hi Georgi,

Thanks for the V2. The updated strings now match both environments.

However, checking board-specific DT strings inside a generic peripheral driver 
is still not a good idea. 

Since you asked about a better approach, why not consider the solution 
mentioned by openwrt-ai using the "reg_alpha2" module parameter? 

If OpenWrt injects "reg_alpha2=00" via a modprobe conf file under 
target/linux/mvebu/, the ROM regulatory hint can be overridden from userspace 
without needing any hardcoded logic inside the upstream driver.

Best regards,

Jeff
