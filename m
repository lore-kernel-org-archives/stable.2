Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7F3C9EE7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788897; cv=none; b=uMDwABg6VqwDa6CKnCIPeQ/1isdP1Iy5EV9YGUbtg3a4Ubr9M5nu7M2UqLPDvNg0S+CL0QZH8OBG8LkD6vMev0BzSZNfP9hmToZA9/05s+0gAysA1cVUSbCX8kvbS4nr+7NWx5UbSL0mUgLcSxn0iMS9d2YnOfhbFXfRu1nlCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788897; c=relaxed/simple;
	bh=86EaQ71H9wrBDpHi1TuDx7jIxfZCbuF6tqGwKMFU0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CgVAkyzAWcIv1DQKhEali6+qbbLbL5sM6phuSU4ZLhRHzIWTBQ14uz2QYC7hRULe9bskLPf+l123fuYnEQRNDCKYMO19OZIYrMu9l78+jzU6v9HPBpZQr8UNIBxHExf5UGpP6fejUyjpu0UObhF0DyIzcohSR29kisOU26TzuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QnZXsL8e; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnZXsL8e"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf41bab353so3994385ad.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788896; x=1785393696; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOSspY99PS95XYy3k/Cm2lnCOhDLD+Y8WEKL3nl/jIo=;
        b=QnZXsL8eB4WHe7wOnfWHc6PuK7vgML7+aYCkAdSywWwdCiRg8TNu8EA/kvFJXPKnV1
         bEx+PpIVUT5t/Wectv8X8l8M1djpTB/2vqij7hTGEdzqnnHNoAiZmehDLFNC33Ti0D9p
         4PiTfkojicFb5imFF84Kugtb62yAEYRCtbIkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788896; x=1785393696;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QOSspY99PS95XYy3k/Cm2lnCOhDLD+Y8WEKL3nl/jIo=;
        b=aMicecc2b/WIrxeJsAVtpxjSzsYuLEEae7THBER6IOcGxvRpH8oWcMzGWbjASSfgN3
         AxzfGqdLNMBuo9jVgV96Ac6/rcUvUq5qQ5cNCXt7YL7vBjGcESNDaFxzERZRhaVleMVX
         OsVqdV3+29Nhhd847hal09fwzU9CjM3s8q12Y0vmVIDnZZo0Bb/w1CU6tj1LXqDSONFm
         Y4UXfJWVFIt9Qp3ws+cAJcS67D4GPC3W8Ar6+e024QpGiYml+oT29RDLdlTFpOgjpKoe
         YvwErzECmS9naiD0qKyYxGZ5ozFUd/tKGDg4XiYhVCw+KXrUKld9s09kr/XF1THOHM3Y
         BzNg==
X-Forwarded-Encrypted: i=1; AHgh+RrA33b7ui+rK+R/58yXHIvQB0zp/AnrefilwOC0p8PvireiGvDR3225Z/rWNCb2gGDn0VYrV9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8e9IqQqEdAO8U7vrv0dy9QYp5FkwpbNbWjpDgVbOsTrPVRDja
	p25HJ6LwysgjyP+T5pA29dES2HED945IXad+pKgTAYaJxZQWolQQl5cra+Hs76ZwbA==
X-Gm-Gg: AR+sD1286S6PzaK3cQ695HnqvRa1o1xDgUV+X8nLI0/1XUK+xqXBpV0jcFB4wbWoeru
	14PC5EHiVyUx+7RP3fWkpx31lHT5gR0du/I1TXgrhswOPPePUKl+cHt64SR+lWSsfFUbfnrq3U4
	+WaNjuvtxn9Qnv8vifOhXk+6TiQwXT+qsOdi0K1tpN5jizs8i2dxl5AqWQsqNhHoLyRU8C2iyA3
	1NOBO8brfanlZjcqkJJ4MKycinBkJCKl1YD4TCeWYzryi2mXMVRu0sxb/VFfERFYFZxukKoIKHK
	2fjNIsQU7QMktTHoDRGJQ7ToPWrCezQ5pyo9dUwCeKsqL9IRBhxX8RnMaX87Rlb1ihW4SDAMNju
	B8GQHgCTBTNnv3/KxIIVXPpp09bTp0yVhjZdcy4bgNEelRGTQibVLTykOUtlEsISi2L+Y7bTuML
	QEXFGSH3JhnSZNhkVIeo5jVBcAdofNoyA3+tluWgvJwA==
X-Received: by 2002:a17:902:ce89:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cfa74bc9f2mr21950805ad.41.1784788895650;
        Wed, 22 Jul 2026 23:41:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd8b6esm27685815ad.26.2026.07.22.23.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:41:35 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:41:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH 5.10.y 00/17] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG3L3Tkmxuz_7S3@google.com>
Reply-To: 20260626112634.1778506-1-pbonzini@redhat.com
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
> this is the backport to 5.10 for the above CVE.  Similar to 5.15, the
> fix was relatively simple upstream but only due to years of refactoring
> and cleaning up of the code; fixing from scratch is not really feasible
> so start by applying the patches that are needed.

Similary to 5.15 patchset, has this series stuck?
