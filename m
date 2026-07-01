Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C444403E87
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899938; cv=none; b=kM3NBD2cIGvTL9ROgkyENjKhyttPDKOqW7UICP6X/0bL+Wjs+z/xoSNvjCWUD9VTNSRp5alx6Xxi0mOxYz/d24DdbNSpNizDAS3oOSqcTGHYhes9UBpyMsIOokGPfxKjh19LOyUnWPm4euPSOexBoWVcqgThiLAqUynoJsV8Aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899938; c=relaxed/simple;
	bh=v7yW10N5rdbaNr0AbgfvIKAE851swmfImkTSQtp0FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRY7YxwT705v6sEljihnQHpDyjAugnnRxAnzt0Xyof2oEy2Ns4AbAqFAMMgWqrPhbW5mmPQg5eeIAo/sej06ETAAFhoeW6EXgdyrq8EDSJk70eRupTROnRJftavducK2MswpYBWj6WCZI4CqCn55DV2tspfWB1Lf6nDpLkPuahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlLg6tN7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlLg6tN7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso27175e9.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782899936; x=1783504736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=mlLg6tN74O6CRQzUrm4inY4+UxBGv/bsVH6lXCQBdYsAsC28/bFRH2Q4uobIY+WmKd
         oV413GI6V25nKznPzDCORS+An95IrVWgghDeU4I/4soOgjvHub0Ml4C3wMqr+pVFo4/n
         Z/LBsKYFjItXy4eFKi27YmZ5MK2waGPN9hhCCk4Vy8j8wnIbrvXXi48AD7V3elwiwEL0
         g6q4wYM/LTKWV+wMScftHu9k6M58KCwURovjaUly3DQKtNp9/+qYcBAgpcWD4Bsp5sYd
         3NxNhRrdbCd5UgBb86Y7uTxDBJxPErAia6KqbNDEVpJfpueRJILKuSdVUSEElidPcSoR
         vnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899936; x=1783504736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=g79uIuxpyiCCZ/dyRjUeI8Dqsok8GYDrXg9Wjd6ALhmqy99skKruVXhZVB3EJNrSxd
         o0eabyy+D9Jikp6LJixAdkLoWWkI3U1jf6u1F1VLZ7o6DCDob4irh8pUKCipNod4Au4l
         2h2PDYrTKdS2UO0TM95nI2NblvaqlOfpq6b/KHRNhjgsagB6bvyskqthi/VUP23N/WNX
         OL3vRMp8ktUuddyuBXIl/djCcVZX3lklNwGZsEdQNEc3lnmRfjUeBmKjBlxiqRsISnvt
         rD8fQDv4RIIbtnGS9osJFX1ZMSTDFStBuDy70V1EbfXUb6irWSZbKLuBYHmQqsw9n4yF
         x/Hg==
X-Forwarded-Encrypted: i=1; AFNElJ8kq+XAgNKazPWrv1sIBWyoza4UxzxkAiLihNHbs5TB4FzmNkF7TATVyO/S4Cq9UVirD/gd2xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4os4PuJ4tEHEPNlHUQsts8OpAYkiT+whyRQcbs2esOPqoDxNw
	XQcKC+rDUnHABl6W6DtQ1ulMACteBtztBGPjjWMJZISQn5IfCfON+Bhh0JldtlAKgQ==
X-Gm-Gg: AfdE7clt+QbWP6K2fYa+BwsHhZXg0LUlTZsZ7et7CNJqQWxlMQGfuxjOZ2M3IXLvAqL
	hrIgQqvtcphUQUufLM4CsnQRGvK811x9lhmrJ4GRleXtZ9zM/6r+1xcIu20Nph8oUHEdrgkgvg1
	R9UkqGVQ7Dm/WimlvZ2COlwjfG+ZkIpfAKHb2+AC8oP01GN1hxApT1VV+9ikWcP6WfA6ojCgUSA
	y20K9gtcvBX3E/2dmWRzA0ryiiUcJJvMAoH/IcihthnsHpW7fiL+uv6K2Qp2SfBAmpdDJLPov5J
	+cGVkMHqAheshep9jurOzV85lmb2qMHyd3AnPxND7Pqh8MS8UZhe2YB+C/YbO3PzdE35U/2Sn9q
	I2FePvp08rZ/QArAJFmtVfOd77fdX4Z9tiAyXE1GBSNRl1ldt+KPv1K2+YPcLnmBfSe8KypNPKd
	Ez0yvo6waQTWWW3nFDaPM4jAdVsLICHTXuh3jb06N1QZGqiN2Nk3I=
X-Received: by 2002:a05:600c:22d4:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-493c0bcab48mr503405e9.6.1782899935171;
        Wed, 01 Jul 2026 02:58:55 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm31881885e9.1.2026.07.01.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:58:54 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:58:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akTk2uM0Kat4Jvrg@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akQYpCdwGnpKTnjN@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akQYpCdwGnpKTnjN@nvidia.com>

On Tue, Jun 30, 2026 at 12:27:32PM -0700, Nicolin Chen wrote:
> (I think Jason has answered most of the questions here.)
> 
> On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > For example, patch 4 disables the EVTQ to avoid events as there might
> > be a lot, why are they not fatal also?
> 
> FWIW, the PATCH-4 doesn't disable the EVTQ: EVTQ is disabled in
> kdump case prior to the series; PATCH-4 just makes sure it won't
> get enabled transiently.

Yes, I meant the patch disabling it even transiently because of DMA
faults, which was confusing to me because I though they are fatal anyway,
but I see Jason’s explanation now.

Thanks,
Mostafa

> 
> Nicolin
