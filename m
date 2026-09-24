Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC24A9D62
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265925; cv=none; b=Ac3JULfvWIZ/2uzJQ0qQahBKLazW2yGnNK4fiDHs1sn/oaY5538/2KoFu5Un5+mmkslbZe/Md0QtfQu+PxowTahUVXCOzxRRiRhdU5B8fiv3eB7reV3suMrKZ5y50t+YZQk4ix1dfYUbVwdmQxdtq9miKOUJ7F6cn0hWzvyh62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265925; c=relaxed/simple;
	bh=ikXMgmXHONWXYFYrMoc05cqE3qRXFvvliZBDSOJzrak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3DYUcKfpC+A3BJ9h5FG3bWmMWlpbAPTj/cJyQyqzXoLVR6x1/wGFtC0k/9laxm0A7rCIGCxY+wfdkBFitDWVSNcvKJ6NVu/guMRG+WQrSj9I9cia3rPds3HtFIxTnrw3dLKVlhbngCq7sjIHqzbIBGYc9q5RpkO+l7DxogyeOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR58+ES4; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR58+ES4"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so26263a91.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265921; x=1790870721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0MSHTGjNK+jZgiSFsmQTMaSs2OTjPQCQBd2UwSTXfYI=;
        b=jR58+ES481tNIBZMkFyT8Cnhz8Sq0hacKrg8PBI4sD4PqF7NFzUBRE9xkBZoZH29IL
         qX82KTmFLAL034bwG+8k/nruP/bBdhC/E4l+8r7vdTwbvVPjiacFVemFkumfpm+JS9TH
         bjHEuUmmbeC2PK7ZxJ7ewYJswwxyWNqaVyXVDhEOBq2sgCK9BRVzd25kXr5y7VKZd4xK
         lg1hKSX65O+gwmMzrAz8p48NHSa9xDIaOZQ2Ed4ijfcaxd/B6Q+089af5Zg8uGxFSTKo
         QTucBGpkBG1iybK8rtlCZq4vAJx3gdXvcn9+dIMhpj0t1GnxIRQoxGEycr7KbiDvZ/ZA
         sejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265921; x=1790870721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MSHTGjNK+jZgiSFsmQTMaSs2OTjPQCQBd2UwSTXfYI=;
        b=mS4xk+mxbc567HjAeSscSPSYFQAHBXfgP9xIg4IdDF38pRUERl/vVJbQ8XP9tuka5U
         x5nV66aItzLSXi+ZWdVipRHoYLafg38I24NiPzmifxe3R1T04BpO6PSAJ7xz/TTcDT2c
         iFCCpU42AZYKoomBuhrM28PlXt66fv4hRnWLx0Gkbp8prpwhY8vmid+0sG+ZatcTXWKk
         Ls5ERguWmos/EK4wVmD+aA90K84FisXW0a33K/zPwAVTYiUIYwqOhSjiFaVX9bAH0EDO
         UpJiswx6ohZ1G+6Eu+Ihfi5E38/XMkmn23SFlVPvINxT+5Artndv/Hmp/sYSkS4AVnAS
         P/FQ==
X-Forwarded-Encrypted: i=1; AKwUvBwz0YtbT1BCvgbrPACMRYv/Ju9spPqhXNLhHegHHw72Yu1bVe/XbzgI0hqK32r7YqengcUvwY4=@vger.kernel.org
X-Gm-Message-State: AFuF++mUZC4ffkH2hU8hljftXG4Zq4uEXqkKmxKfNWSW2c/6+J6sXmZe
	W5ble3KIAinDOXrOxE2huROlMAnPIovUzP+BBBI8P9IhD5MNuiq0ihbH
X-Gm-Gg: AYBFou0M9vYszq+qg3PrJLT8HXyWdNutSZuzii9JyuIAkM9bRej3muoBsBPsrQW2q8e
	kXx5Nnw1PevRlugt7UBJGWjXZ3j+yPhLQTdwQYRJrJPKJIXebBcez02HapFMqky0fLekR/CRUAA
	GsHRpG9k0X51H/+Xb80LABF/W3pKk9bgr+OODhfcggz+jU7DJw6YFrozY04mkDlvUxif7n5eytL
	pOuf7Izq6SLwoye6np3eg68OCMH7CUlaXZ10aUDn2Wiovi1YLqq3sjaaq5bSbhZ9QBEgBoHYsQs
	JRhr5TKUbrMbnB5Lf10V2dFHk3tVlsdR19E81R0w9Rx4RaNG2gAK/uPAwZnNBPwCYdM71eCqqu3
	6OypPABja/Hugl5RZveyNYx35WQHBApvgV3Cumly/QpYTdiaX7Lme9SlVn5x85GXp0dyOpG3Bbc
	RZDG3/CH+wkSkCbfD2hTkiNUHaw3sqr2MLLULNNIc2qINI9jchF5OVU9cN+bRuS+iIG64BuZQl+
	rETMVK2oDer
X-Received: by 2002:a17:90a:b81:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3a0abc3c2a8mr650385a91.34.1790265920942;
        Thu, 24 Sep 2026 09:05:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f5e79sm2965662a12.25.2026.09.24.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:05:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 09:05:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) reject short status reports
Message-ID: <7b40ae2e-57d8-44f7-9791-ac65a3e97290@roeck-us.net>
References: <20260924151121.1233666-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924151121.1233666-1-yaojiale02@163.com>

On Thu, Sep 24, 2026 at 11:11:21PM +0800, Jiale Yao wrote:
> The HID driver raw_event callback runs before HID core validates the
> received report length.  aqc_raw_event() reads device-specific status
> fields at fixed offsets, including multi-byte values, without checking
> that the received buffer contains the complete report.  A truncated status
> report can therefore cause out-of-bounds reads and update hwmon state with
> data beyond the received report.
> 
> Reject status reports shorter than the length derived from their report
> descriptor before accessing any fields.  Commit 47669bec44fe ("HID: asus:
> refactor the two workqueues and init sequence") added equivalent raw-event
> length validation to hid-asus.
> 
> Fixes: 0e35f63f7f4e ("hwmon: add driver for Aquacomputer D5 Next")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 1ca70e726298..1ebc8bc4c090 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1331,6 +1331,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  
>  	if (report->id != STATUS_REPORT_ID)
>  		return 0;
> +	if (size < hid_report_len(report))
> +		return 0;

That doesn't ensure that the report is not at least as long as accessed
later in the function, and thus does not fix anything. The same applies
to the other patch.

A proper fix would be to ensure that size is at least as long as accessed
in the function. hid_report_len() does not and can not know that value.
It is purely driver specific.

Also, the code added in commit 47669bec44fe is:

        if (size < 2) {
                hid_dbg(hdev, "Unexpected keyboard report size %d\n", size);
                return 0;
        }

which makes sense because asus_raw_event() never accesses more than two bytes
in the report. The statement "Commit 47669bec44fe ("HID: asus: refactor the two
workqueues and init sequence") added equivalent raw-event length validation
to hid-asus" is either hallucinated or intentionally misleading.

Guenter
