Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90C204C31
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611387; cv=none; b=aCZIeE8rK8wriPpSRt++YNoWHiGN/i6iRzMM8wIHmXZQj0nK/XhTWunymM6f/X8Y4A9CopFmafm5Tqx2Zqjhe9vnbbKx1a9fMCiI9RHi7eq9sXqYOjOmKQFOr5v68H8agstyqGxIl5U1fwBtlqTyWPjga6mYm8HPEYWEZSvyago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611387; c=relaxed/simple;
	bh=11YjS3aBQimnsp80x8+0ECW648rUHy8AMz8fIwiS0xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXlpImuiaiPwbCwb9MlVQeKRe9pkwGx40OwUTHmdhluzrRJo4NxCb+h0tlsjE9McMc6dxSNT0gP2yO0KkNC+jRc7ymLOKFVM3RcoWslKYLwNrhxfyjgbuTxvsW22c05jJwBjicb6ExHqag6M3LePvnyn4wZpinn0sz3O5AXp2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=pl+IFFWo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="pl+IFFWo"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535a54bed9so471129eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1791611382; x=1792216182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xpuBGBuv4heJCbpRtk090DDHZAYZZjZ3SWsUL8DCKM=;
        b=pl+IFFWoNV//H/Wigd9ew0Cuh2psCfiBzkUe8xP+z5yLskQZH+wlgupMt/0WrE5d77
         5Ikgnxh8y2bOXfK6QOWqmDhFB1q2vLzykJQGG2IB1DE5haNYubkoKQWs9zjPU2VAUICE
         iTWlQcFl12He6eJ842F9K0lIUwptedXDN+qt5yfYu6AAXO45z1GSeAi+wq0dygC506yS
         3nQfzPFxA1rmhI80kzEfJWTgC3eflXu7re5Xr9EQBKZwTwKMDfyQe/VKLhYsX43kXwY5
         NFZBMXckYCzp1J4hAgJfcloUtEDFfLkH+oCGVeM3NmuwbZlrvi8tcVPfuHuPwjaVXgel
         uL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791611382; x=1792216182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xpuBGBuv4heJCbpRtk090DDHZAYZZjZ3SWsUL8DCKM=;
        b=nl4oS4VgDC6uw2kUCfd+DkoLtHicnGQJTT10QrNMLEcKlCttH7DRUjJ5BvCuR1ym2Y
         xDwtIyCyhkAhg7Ed/pKMSyyzUK7ijpQQfloemvj+faz2HzPbjiJlNTP5suiHnw5RZ81u
         gZ6CG67MzGJFwp2Fo7kei+ALRkuPACYw+iREn98LSqYa1M1PgGEwY92v4AxR+HzK6YTo
         53+X9TsGmWbixxei9LiL3/xjHkKkYfu4MzBXytF//Lenz/s6jskX3+m5vi+SQ7B1Aqdc
         C/7CNlEMPH6lp8v7vrO0/PCPkLlU9oRn+bUUWQZqTQNPy9FDh9xV62EnuAuSp3gettZ1
         pTeg==
X-Gm-Message-State: AFq9FYIRnA7H6GracCDtjQTs6dyvZb0CmFMwlmLh2ZCBadgeWTSP69XP
	bRLmwJsZA3GYedZJawed7rjAmsVoxmVFFwKhn8A0FcjtT3pgDkI04GyPaNRaa1wHm8Q=
X-Gm-Gg: AYBFou1A/WssXPk81oIOZNnWlvcnHChjQcZyRoqlrzHuHPrX7uIYhgz38n7vUiGeQPH
	ZSfDtdiW5n2DnPLd6jdHjjh/t+7dWMzrbRLuVfSTVFpublHgenM5m3ntLNYZUW9O3IUeo5Bo7PY
	V78L+CBi38kn96bzBarb3nGedqorbbgW6MCZ/QXYn+zV/lp8QK69vTg4u/omLkwVEb8zib+pTdZ
	O6ROF4HkVQ2UidDoELmuBTkcxhjnfLEm1Hli4gjLIl3bpUDeXHqTYCO3k0liRJqcKz2z+9LezIu
	EZavmTvTm9UevhuZspWO1RgFtIOXWX3qm9DhkU6LKgQk/f6vXb8OtAWit9R+5FmUpbbz0An+bHk
	e95tGBHV5VR33P73vQzLHgdpdbK6FYMiDtb0of9CCiPlhebOUVoE4FnNpaixd1bGU9INTC/C4cH
	m6SBwGu7RUzMZIng0GVODD/SzyHECr2MCwZ1R1kg+dhqlkaVZ+CjydJ5Wol1w7QAjQKxYKCOVyH
	W/La2cBje/Go3EAQk0kITDV1bM5hQv7r+D9yO2I9YbnZZP/a4PTJDdwtA68qDlZfWOgti6jCwT5
	cgJe4z3sdw==
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-3537e0788bemr7193296eec.14.1791611381889;
        Fri, 09 Oct 2026 22:49:41 -0700 (PDT)
Received: from Metius ([103.158.43.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1cc25sm13543066eec.8.2026.10.09.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 22:49:41 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:19:35 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Andrey Misiurov <andrey.misyrov@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	justin.tee@broadcom.com, paul.ely@broadcom.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 6.1.y] scsi: lpfc: Fix use-after-free of mboxq in
 lpfc_sli4_driver_resource_setup()
Message-ID: <irfspelsns7bao36eh5i5gebv2ktqguoinjsvmeebmwpbet34h@kuteiore4fx6>
References: <20261008184328.2857037-1-andrey.misyrov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008184328.2857037-1-andrey.misyrov@gmail.com>

On Thu, Oct 08, 2026 at 08:43:28PM +0200, Andrey Misiurov wrote:
> Move the mempool_free() to where upstream and the other stable trees
> have it.
> 
> Fixes: 299f5baa1321 ("scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()")
> Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>

I'm the author of the upstream patch (not a maintainer). 
The fix looks good to me. Thanks for catching this.

Acked-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

How did you detect this? Just curious.

Regards,
Nihaal
