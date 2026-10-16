Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223A563280
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171204; cv=none; b=WTtvkoK3ZDO1eggOXen0W1/by2y5nv3VHnP1SUuAY1xmrRVx1ZGStaot5X7UZwyj1LzB+9Tw2bApXmWye12uBnPmW4E3QPU09aoKGSkzkmSeVmn5uMbx0vnizjIsZ4DVNCFOW+2B3wsINOOga+cRYSLPo4BmQUXHL/Ev8hDJhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171204; c=relaxed/simple;
	bh=cTHC0yfCpvz+ibcoG/JoiYW49Rvi7kVF4gEa7suZXJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OetvTaQwM9U8AYDJRx8+sDDi5VkulWlfsVdqX2W6MhYOXJMNHG1yyspr+zj02q2028KY48Tu16anNFMU56YKZsV/+vdFYmtHG88jkwUtrUgojFDj2GZk/PtdicOjb64eiAH/2ZhauRCwfzPHtt7TL9u5+7G7phv8/o/cHCs0VCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtKhGn0p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtKhGn0p"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8520161fdb9so110098b3a.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171203; x=1792776003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uE2PjX0J6WzVcXk7jQ9SWzOLACgaklkDei11e3qQjvU=;
        b=UtKhGn0p736k/u7NOG/qzvDIu3hFwX3efMbC4Uv98H+7aXkKMWwv/Jww0GHzxLcScw
         u2hj9+kOlaZGf/hbX3ZdOLpE7sfYGRatsPlbFs7Z49t/QIpAAacjZAF7g7eFH1mqWh1C
         UkkYW4LR5k8Ioufy/p6Z21BIJ6NjhXzC5LijFOM+cJ+KTq/88gvP6TI5rqkiH6sIdhOz
         LmVexEQN5UG5xUUvpBKILkRezjIk/5HCu3aPdk4SfaiwNaGmK8uF8yqHbfpHWzTMgW/U
         e9r2u4sBHnJ6SNc2ov7SUUP6yHTm+hk7w1Mcw7VXTgJ3DQG8neU2ToXljC8njWym1NbZ
         BXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171203; x=1792776003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uE2PjX0J6WzVcXk7jQ9SWzOLACgaklkDei11e3qQjvU=;
        b=xVuVmgTnbyJNJOIFdsYwmZbueuFNO5Gv+VZ9ac5WSlDqMNCKwUdP501uLOokfnJJIG
         2vlwkLE5j9KJypF8oVU1tjqATsWfV3LnsDvD84x18vlSQ0q9gNI3flevfhDQ1cZ3VjiQ
         KWQMrEwUa+iulKVBgcmj+IKwS4KMIeAE9OQXOVLzPaq1o6BMFTH+3Em7fFHMbm3Cn6Hd
         eeiE5h+zz2jwI4O85SjUov6MxdCsA2MtlJZDtVOcUMyXEVNzY9Z/hZflvkym1DpfxSpn
         Npg4rVyvZjqrQbWQQfxyGBJNUfFE1Q3Q2dNi5f5PWqqnVRuILHkvSLaHKMnfdTueCbwE
         FMkA==
X-Gm-Message-State: AFq9FYK6VaNoqD0k4oALBIgpx0nO9Eaz0TguZVzJUWHZ5coNRrfmcJpX
	Gyrn/n2XvNz0LGa8VWyIxlVxs3Z81Hcm0cqzbMlbztJNvHMX3CbhIECo1PsPwFqEVWqSQD9jfVH
	NXg9b/w==
X-Gm-Gg: AYBFou2YpeRxeiMcqrw+8QC/wqZvDuXDp5GHbx0d10JKDt8nN2NtVREYaknNnkIfMik
	D6+wJCxUoSuLBzdjG8bLYao6+Uc2UfQusN74NbwgSinscgWjxt/lNJHtAYFkTRqbEP5nOItbFs1
	CHZ9JR//u40F1ZfiAJSsHcpHuPz5Hu1Acpn28PUgxjNC4kjmNlytOEoxXrfyPm9VjwHIbaarC4p
	EKVMGPKnoiPuUddyNFsraKqwCEDmvCh4WPAkQJEFi8uqLnAFT3+D8+VJTWq817tGtEEK5vZcmHA
	1gHFmW4YUkTwHmT3u+vbYAZxGvMmnAdx9qUQnWNPebeyJALg7Sxw+RpJwtn+HJ92YDK4F4jXS++
	05+UYVW9xLdf57CF3gbOUrnAtirVCh47S9vstqDwpTRtZSsxMu8ACXcn/1SB0A0qlZuDzWwMhFU
	xeq7WirUvhyHjUHs4GQAxOXlqa06WMnHtqU9EhxAo/TNTO3FFz3+e/+HzzsLPMWMf4MYGNjRNGa
	eNRHbGg+Z/beoBJidqDwqYiCmzF9jiKryRhcj10
X-Received: by 2002:a05:6a00:ad89:b0:89e:37b0:d1bc with SMTP id d2e1a72fcca58-8a04cb17911mr192844b3a.28.1792171200516;
        Fri, 16 Oct 2026 10:20:00 -0700 (PDT)
Received: from google.com (248.182.125.34.bc.googleusercontent.com. [34.125.182.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57268ff1sm1433387b3a.22.2026.10.16.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:19:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:18:49 +0000
From: Eric Biggers <ebiggers@google.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: Re: Patch "ext4: switch to using the crc32c library" has been added
 to the 6.12-stable tree
Message-ID: <20261016171849.GA122880@google.com>
References: <20261016171336.3983051-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016171336.3983051-1-sashal@kernel.org>

[+Cc linux-ext4@vger.kernel.org]

On Fri, Oct 16, 2026 at 01:13:35PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ext4: switch to using the crc32c library
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ext4-switch-to-using-the-crc32c-library.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nack.  Missing prerequisite commits and didn't Cc the mailing list.

- Eric
