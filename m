Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3494F7CAE
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414135; cv=none; b=rVLCJNHhoVwCtblSQW6+CytiTafDQMdpm3Zi7+qudh+K5/xrq/UHm3oyTmvlzPEUh9StI/HXeVmSDdWmWtruEHMrVaeiM6DTKmBB67h5OvHtR3GN/+Yn6wg34wmGL4/P9LIZBOylWcIoYIj5Dq2mGg+RbhOfK9jMIho7SHf8mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414135; c=relaxed/simple;
	bh=sAJ6i94PJtOldxxhMOOrYPRkX1IMkHwm0U8Q0od/RyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iumRVwoS3RwVGQhr0GxzTMmyT6wZBFG3Q6cboBa4PmXKIPkrCrswzGHxSGFcyXuGEkqRKNe8p1Jp6DNYovPX0vlbgT5oOTuYdY8LhJ2IMSxoa13E7M9evxYMkycSxxd71YO1mqIBMDOnHTeqmy8rh1+9Ua/pmHz50m9cGvlSttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agxY1rn+; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agxY1rn+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6019004eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414133; x=1793018933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cn0ZhmPVY7gAqZB4Dcd8F5JEGSmnEQH7CIRljs+xzu0=;
        b=agxY1rn+sC27hpHVueEY8fteily1lWsX/JFwb4vycbiA/gjW8xaJDgAu6OEooxawdW
         FT/d1n7/r3mYfFEtb+XX498PKZ/+rYjc91CgrO37up4hM/F0DyN3vPlS3STXmZmu8zk2
         O6jqdLkIqOYovQYiYfGBY0/62FL0Fz75Gucy6+qR+61vC359rK3P3EyL6KRD09Fp8J3I
         eArV/9Nec64Ve+KRs3v5zZHb4IL3N2cCwWPM3oroUxR647JQa7CJKliIKamhUS6SUL4Y
         yXV+7xTrWWbcooucynjNJdu9DTQP/T+s5C4e9QWJMfNCz9yneM5Xw06WFsimsypCUVdg
         bslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414133; x=1793018933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cn0ZhmPVY7gAqZB4Dcd8F5JEGSmnEQH7CIRljs+xzu0=;
        b=jqnAhVoLu4LrLafIFrnmlR+ypsZP9v016nQb3qgTldM1NP95tjEXBaP1k5pjFn0Hv/
         9X8gaKLWCg9RaGtTFSUaTOOdME/CJVhrfN5LnGAbASYifSVo9JAwyUfDAHg3S5C+h864
         hTEhR+LBcAj8iTkZLwtfMd7SoDy1dnvxpj5fh5zi0q8nelQ9qOUMEul4u1JzkR46K5lT
         BdYn4J8KCa4wV0NoIPWJakJnwLEKMguFFHOJLFJDKhKGsnLShC5X5inz3ra4HIxYBRrH
         XIQ8hdXYvGK2ZP5zZ3c4Coy956mN4UtyK/tulzyzsUeo058ySPZ5p+Ec+3xBFmTe/Q2m
         SsOg==
X-Forwarded-Encrypted: i=1; AKwUvBwOp7/o+jxAr+DIFJR2pCnyMe4TWzikfhlujW3LJQqgp3US1Nkye2UcI7YARGQKeplk2EthAl0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRtLRxwyk8NMRcrN4rifrpPeSqHohTDxj7UAh261CRUHR4rwGY
	9tIgBDlt/ybMBL7S5Ux/pTrI0vjlh6uDxkcVGvFFZsQrPBl6JPWLSZzb
X-Gm-Gg: AYBFou1HAYIQyVcqTk/KAsRtPrducTl6pk9Zq9D6uPmJWLseA3X5OGs1GLubQjvBiXX
	3i55L412Sgq+cY2pW/vHfek7F5BaSZvc9VkO1iyeNgmg62MgZHZsHl312S4OQWu615/29EHSebI
	a40qE2RA1hz7kFFmi2jR84PQgcUWd2VHJYr0BEYF70pbuMnuc8vJm523+z7n0TiBvYc5VPCqABe
	swCQC4HCDZlZrz2X1Y9+7FNKBZHb4hW5jtX7A4cbNVTIWub57H1sPp/zMCjL7y7AJmDbJXupFLN
	kdhU3K0WJSeO1Fls9cEJeG/C621bqdsOQ20NHeZ5nP7sdpkSmmPew5Yw774kMoA9n/9sWUaoCbI
	egKSyLTT+1YedEhH/1P3hbzbZXmX1qaSQlZZIhfJfa2SIemNxGSj+cmFFnvfTbQCSgHOv8PN4Ln
	FNHG/MKQcEkByF2GwiGU16AAPYP99unaaLBonGpuoVhXlKMenP0sLyikTdP71ziLFfwutL6aXZG
	VKBN5GoJwsnNw==
X-Received: by 2002:a05:701b:4519:20b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1863f0cbe04mr9434353c88.5.1792414133401;
        Mon, 19 Oct 2026 05:48:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-185aaea8b24sm21947868c88.19.2026.10.19.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:48:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 05:48:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (gigabyte_waterforce) reject short input
 reports
Message-ID: <f7f8b839-1e65-4bca-93cd-4f00953890e0@roeck-us.net>
References: <20260927084959.893708-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927084959.893708-1-yaojiale02@163.com>

On Sun, Sep 27, 2026 at 04:49:59PM +0800, Jiale Yao wrote:
> The HID raw_event callback runs before HID core validates the received
> report length. waterforce_raw_event() reads command bytes and then accesses
> fixed offsets for firmware or status data without any length checks. A
> truncated report can therefore cause out-of-bounds reads and update hwmon
> state with unrelated data.
> 
> Require every report to contain the firmware response fields, which also
> covers both command bytes. After identifying a status response, require
> the byte at the highest status offset before accessing its payload.
> 
> Fixes: 42ac68e3d4ba ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Applied.

Thanks,
Guenter
