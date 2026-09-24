Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6A30D3E0
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266469; cv=none; b=fEbamXNHlo2FLe/sx+ZD+JdLDQvwEYA0VS9qas8CVPKc8zkDtrsMC7SQ7Y+U/DdrL5KpqyvdvPIC5pBricUTu8o3JBoF514PZqoZ/SO8vHYbyrs8T0jNgiuUyS+wQO0JzrAy7NXxxL8ifAC6DD2vD3dGRnSuJzEhAsU44VyLbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266469; c=relaxed/simple;
	bh=4KycQmv/y3uSOW6bbpMEKLY5l9Z72oT4ziHVMe1/+K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW5KAvflT1WheKQG+DFVDi/4cdYbyT2uv2BQntCw+E44MiauN/pSUNcEfkI0BpW+mIP8t4fKF6No/Ip4igX6Cp8TVXMHcZyZOlZDIgW6gylGyEs3CCOSSwAnnbEvWSVDU1M8H/K5AWIZx6BxY1wWc+pnUTq8pKCKjikKiVxTe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ8Rx6XA; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ8Rx6XA"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso11434825ad.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266467; x=1790871267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4N81IHB88R7EO6e16xVo7GeqgBSbrBSWBWPmQpiEIqw=;
        b=CQ8Rx6XA3AYjsUUT1t6pOx67T9ImQwenLU/JvI/0SzINPaXhDowjNe+Q2corE7Q8Kk
         nauYf5iuUny0EMmTVb0IaDJwOMJC9WiCxQ+IXII5De1Mb6TS8hsBmnWJuJoBTAkjJKV9
         4leE8jDf/FOwKkp7rxhwh/YlgPWFMKNHRK9I1b716fpinWOFX1IQYb8eavKEsOJ9SeZQ
         21Yuw4dbwsdIqbSEOA9f8H9o0gzV76eMCwmR4t12e0PGkaRGjFyjAaZGSFUht9hp9Kh9
         dFdaxPf3QcBDjkXcnRTB5V/qy7hxaT7WpF54LwjoWNW4yO0k+qn8vv4AXa2k7C3yENlY
         LQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266467; x=1790871267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4N81IHB88R7EO6e16xVo7GeqgBSbrBSWBWPmQpiEIqw=;
        b=kUUToWrlrUum5jpUcK9EQJ0TT1R+2EEpzXUClUGncYpWCLxvR5pECupt7lfSqUzQ5X
         3u53hh9agsRgTkZWvfG2nWQPruuVf9JL+dVQCijaEXs/gmuMkRxiUUw6aTu/gci9NpIv
         pyzNMuXLbpO8rnicq7qD6+XDmrVfjJuHdoU6n9jc82XFoZGGC4h8j+dxaVtcy9bgbMg4
         pj97pLY2jKXLMS0hArLzKNqqrMLw+ynG3Z9YV2BBG9RbyqILpOx2EMLJ6eZuKa0Omt1d
         QwZpd5G2oQyN4yVWOMj8cQUXWME1MY5tFHUYdz7F6unKs4SU/2O3JA88QfiKPxSGVv5b
         MCxg==
X-Forwarded-Encrypted: i=1; AKwUvBwXkXtNJI1z+/oVT+8Jzqu3k8dnMBe8PldzWySURmtlb/jbb8aaUhrbZ7sJL4UUfQFBmWqB/e0=@vger.kernel.org
X-Gm-Message-State: AFuF++nXIZPAcWJUNE/3TMygL2vHioPSi8lliCkkzegsnGWuxfYAD8Sc
	UZTCB9lE3QsJVsJLTUBFes6bQH5lbpyw0LiaRAxDNwKuvr1bPkcTMQfg
X-Gm-Gg: AYBFou3JFsrFSEp/L8HLLHJj2y6mXH6niirRCTqMtEle5BlLhHnPYWcyG2APBAiag4d
	QUfDU3RD3GhkxW2ebHK2spOYgaVGMGJezD5jghWon/QZTlmqDdO3aNwNhpP+RovslCAeb/9nCAg
	LQVLhZ7iCsy0xgBydo879lV+Y+3QmW/XmxtJA8zhYlmQdj5RKMdnfwkFep0bCHTu3VFyLlVhTDT
	1gM8UyOrxdM4hCyD4UPl5/IR4uIiuCQ4tvMdiYIsEZqIGeQ3elzDgcbahQOOnFDejthuAr4qhnY
	+EN9IsiMdic6VIa4bBv6x4Suefm59T7GIhmBx38OXX8upSIV2ohl0+RpW5GrN15OqrrnJ8Aml1b
	JBa1MMqpDXqiZz3XSitYfBwtAfmT2gb6Hy4PK4tCVCUaEVoLSFJ9YGjk//SLimdOkA3KMEDuFgr
	5kigYT4ccxfY7ckuEWQdM0dqMMu9F7UaHHBIMPH+9U/j/0xl1Axch678Lq7/GBGgdgQjOy7+EZ8
	MzBiKuUEThH
X-Received: by 2002:a17:903:2341:b0:2dd:c053:c20a with SMTP id d9443c01a7336-2df7dc19ecfmr25831085ad.38.1790266466910;
        Thu, 24 Sep 2026 09:14:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm30509205ad.48.2026.09.24.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:14:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 09:14:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gigabyte_waterforce) reject short input reports
Message-ID: <bfd9924a-fe78-4575-8e9d-2cc649413e47@roeck-us.net>
References: <20260924151133.1233860-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924151133.1233860-1-yaojiale02@163.com>

On Thu, Sep 24, 2026 at 11:11:32PM +0800, Jiale Yao wrote:
> The HID driver raw_event callback runs before HID core validates the
> received report length.  waterforce_raw_event() reads the command bytes
> and then accesses fixed offsets for firmware or status data without any
> length checks.  A truncated report can therefore cause out-of-bounds reads
> and update hwmon state with data beyond the received report.
> 
> Require both command bytes before identifying a report, then check the
> minimum length needed by the firmware and status paths before accessing
> their payloads.  Commit 47669bec44fe ("HID: asus: refactor the two
> workqueues and init sequence") added equivalent raw-event length
> validation to hid-asus.

Oh, and the reference to the other commit is pointless.

Guenter
