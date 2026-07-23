Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F33CAA57
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788598; cv=none; b=OyitB1xcx9ERjSPuY0W2e8rEmJZBDkJllMeFerI0S5w5r6joWcZwYhLHCMgHK08qRir+c5gh7FMDHagNHYoz4tgipvVSzHGQB9DzxUVmcG6fgeyr2B58JJ7mhq+CPDZCJx9ZL4XE2ZaoZJXTt/3TaUmdUf2gO5QsFNI8I5XRqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788598; c=relaxed/simple;
	bh=HncrykrRemgI5fAPmsexCTMiB2KmCqX9lrGam/r48AI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcB3cntkBBefIyJTRIAqS3WXKBJhi85dco4o8RqFgfk7ZoAf1hq6EmIm6ZbavCC8vJavdkQ+Go+vU6YliD2OCrsEFyx21tMXIfTpDTLtHlgnzOHChJqhqcJ6XBed+2nfe6Rygum1MUyokL5mUijj+64ZGaOvarBvawrS2FXEZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L/FlX3PA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/FlX3PA"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845c92bc464so170860b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788596; x=1785393396; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXO1TEMJyOs3biZ4fK22mPvqvMv5jSJi6mC/UFO7sc4=;
        b=L/FlX3PARni/LiS8zMQgpMJXIyRWuU3TVrn6kio/qBhJo2gc6XLbp2SAwD0oI1c+xA
         qgcJxB4Ushw0m75gBAQCZmRHXysJKXIofV8S7HWKrxOLrXTVRDPdo8PFJ0AxWikL9FeU
         dy96KzV93Pdb3gNc9cTofczTW5dLQ9ZF/78fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788596; x=1785393396;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXO1TEMJyOs3biZ4fK22mPvqvMv5jSJi6mC/UFO7sc4=;
        b=IaWbCT/rTuGkI7q/jBJoRYb+A0zbY5jGrrdiEKHw/s2N14/zNFOOocC5rBnxxz28ER
         jaWQ4pmWd1xtgXGWi7cwqJnKeddoZqXoj3Cc7psXL5Lcm8dv3Y2QJ0VEKTzYjYlfYQRH
         5iQ96wQ4S/FWjUd3g2AxNu/9TW0OUKSXunj/04T44xZQCRjJyu05wmGrMcqnJ4Opb06A
         PU3K4Lj6ZPXAg0JBheF0uMYTDOCvbtAvr4jfhaiRuZ+4indmGpc3qzQrt8HJoocypfa8
         cPHc0gvEsHzfHXfOwBOp9p30WaH4WGVUe5yS1/SONFK8EO6KZljQwsx3vHO3n0NQjwlr
         Ynhw==
X-Forwarded-Encrypted: i=1; AHgh+RpNGHAlg9F4hplR1XcSOhIVeunKqIUV//6LtkiY4IzjYvcUhe7gCVN8TxJ/X8yEbBoP03ivD14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNCLEvYAzIwV0vPk72BJ6lvhuzs6rWe8KHzlrBLtrc4shMl1E
	Xzgo4IUpJyXCSV5ZcbxLGM9C5KA6eL1IpSHwn5GjkAblG/qC/596iRJlbKXlHayqO8UFPA+56nH
	DTcI=
X-Gm-Gg: AR+sD13u7A/pExA2hdxfiaDmuHOurRdoKciHWW2nUPbaByuZonP5z54PHKR3XYy9z1q
	spHCuInIXcZR26DkVSO4bMFau7Lnhb+Yl9UPg5Tst6CKiBlFNtUUtUFhU0ih+5YyXQrMnBfDDXQ
	9YDvl9+8xUgGxrHgND7S0g8boH0Jx/FqFmgSyrHa1L+6Rw6JlMwXLvi9rTZzDH7xPm2KLh+NO3j
	Nh4/ZBkEDkFkjvxnxBt3r3onRifSGXg8oYqTofUfUZPn2YHmauex8KZdVJOMy7RyLylgon2yoxS
	QGZz8Z3iu/Q4WaiX8HfT9xAo3LBkoKLopd2k0jQI9GnY6pvIMboTZa8mOh1r19fBe3rxnFE92ZI
	OezkPSgkjnv1qdElLXhHDWA2V84AGBDp7w+GsPUOovGYP2056+mg3whaq/CIgA/zGE5M7GqKqYh
	NepUE9lVQeodNLZSHBfpJvRK2nCNIEi5MrDFWj2Vs+oFV350pIb/E3
X-Received: by 2002:a05:6a00:3d0c:b0:847:8b11:596d with SMTP id d2e1a72fcca58-84e2bb1c7efmr2182263b3a.41.1784788596566;
        Wed, 22 Jul 2026 23:36:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17266107sm2512248b3a.17.2026.07.22.23.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:36:36 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:36:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG2CyrA-yEUmHqV@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Sasha, Greg,
> 
> this is the backport to 5.15 for the above CVE.  The fix was relatively
> simple upstream but only due to years of refactoring and cleaning up
> of the code; fixing from scratch is not really feasible so start by
> applying the patches that are needed.
> 
> Please apply this instead of v1, due to a missing line in the last
> patch.  Sorry about that.

Sorry for the noise, has this series stuck?
