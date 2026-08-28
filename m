Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F244E67F
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945776; cv=none; b=RuwQYll59+oSCkHnraXUswZwypkGuzCgQNiXYHGqcdReQYaQPbcifGPjn11ZfFzUKUplUBnEd4aHd7kyjJ2wDYyw/SuXPmlZzzIomLvOyrhMTRB0LVXQxAZfcOLwkaUAgLrZHr34EMxwC1aaLzo2iZL2G/Ma8/P3GP/bsKxBnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945776; c=relaxed/simple;
	bh=9rLoirNGdrhtihJTDm3W3YPWN74hSLa6hyBsiY4AQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJu9/+oc7zUaYdankzmuXc3lCuVf4kMDWAeX3qr2G0RM3KCaPIQwJjyZpzoAj9upg6810SYYEGnJbc2NF1rpqchlEoWc4jpnUyu5Ioo9W1usUQCHAMS7xGm2mxA3kNyAu7iQngSZ9YRJIoDArkZSLxy0A1zMypHt6QMSySyzW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCgGRU8I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCgGRU8I"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so14900445e9.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787945772; x=1788550572; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcqUv9CJpcebyKMQa2XQtDkxwMPKUiPQnRfSle2UDDY=;
        b=iCgGRU8IbFVKVLXXbLUwHi3PKqQ5UWevIPYSys5l12+DMnPw+rj9PAQf1lG6uxUdjM
         05PII0Gi8McA5kWALFPSBynztnpB52G8cv5O82kC1TovufnJ+V18l7iJRoGPYuHW+ZA2
         bgyc/NbMn+WS1fx+OJLeMt3byPXE/bO0uWvh0KEFG7oZ7WYxHGFO3ZFih/zQNWCqI1Uu
         H9EMWT3zWwbwyVv7U6QZQdwdc2u27xixL1PBcgecJn/JmT66kNwG5pfw+Sy4jB+YZu3K
         zrli11s1i0yC8QlicVd/g2U3JO0bNCh/zpuTOJhWG3jsuZWst6D1WEWbCnY5lyXFVl5J
         +JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787945772; x=1788550572;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FcqUv9CJpcebyKMQa2XQtDkxwMPKUiPQnRfSle2UDDY=;
        b=KbpxR6M3D6ZPOJO1qMR7DH310bZ4/B3EXzBqXuugWhPe3H67dHr8JZaRURhO4vXOGe
         5UXiSoqLYPeJB3oKDfXQjNc4XBE1PhgRBnUUylTosEKNY3YEhEHtlciBCmp3edgZGIKC
         WeCDrRCTcVtIcDOXM41LFWXpW69VBxmXt/Bm1MIMtWYFo79ackL4kDqaIYnyKwlqnA9o
         mNwBWxqPAAYTq2puneUfFg/9IKlM3RMt0kOd0bDv/j6LFtlnoNOyQaiBz0NXXs+WtKAq
         uDTAVaQ6WkYPg6YYrbyT5DP9DGnrsqOTdKKkFxKPpMRpmcYkknn256/j7f8PCE/eHQF3
         HYrA==
X-Gm-Message-State: AFuF++nRwlu4UaHL2qv3enjGvbLMH6qJ1Wf8zOjlJoKICPso2fHI79KF
	O1y/qgGk0ggIswSPLPU7uQtNU/RBagxm+DCllpeJfYqhl0nw+3FnpGFI
X-Gm-Gg: AR+sD115gc5gJ7RhfU/71eyM6ugQhZLy2QsFtTB2nk0BLKuKb705BDE9Qli3E772rzS
	imXlRiliXZNpDlsPEK0E9u5zXaeWnNCq6kWPY7MlJMU4LxyoqYGgHXBUz2CHCxnlPe0PIf091lz
	JlYEMvyVnm4AMr1a0ombQPKwMt2LVVVZkGJgPe/KxkadurQo7bOddAZ5zTpI7aLv47643c4Sqjm
	Qo7wQqicQ8qTeG1Etc77vlxrxE1NrUJUdjqaR9+bZL1U857WeHNhBuW7heWLBsR5J0WsDsrgk9W
	yHMgzpz8Ns+lTCL0HaTmr2NF4VtmlM0fDaDrjURWHPT7TR855PY3IXD1Ou9sRmmDOgn7H5H8fQm
	+k+9jCaejdd4qua41u47j13uCc+vvFFP5Au8HKierKWi1fBlGZwC11XitGZeow6eTdGkd53dAnI
	geK4DWZ0YNcOoPKYDfw2EMVv8UdBDRjcTzyI176xDn9GFChSTs+3uKIlksLChQTv2yafWaGQ6FJ
	OF6pK3jyO0EbWOv7tS8a7Q=
X-Received: by 2002:a05:600c:c4a7:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49cca26ceeemr34627015e9.0.1787945771398;
        Fri, 28 Aug 2026 12:36:11 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm84072445e9.9.2026.08.28.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 12:36:10 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5BC9EBE2DE0; Fri, 28 Aug 2026 21:36:09 +0200 (CEST)
Date: Fri, 28 Aug 2026 21:36:09 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Kyle Zeng <kylebot@openai.com>, Peter Zijlstra <peterz@infradead.org>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Backporting fa091f46c383 ("perf: Reject exited events as group
 leaders") to 6.12.y and 6.6.y?
Message-ID: <apHjKRQq5V_c7ubA@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kyle, hi Peter,

fa091f46c383 ("perf: Reject exited events as group  leaders")
addressing CVE-2026-74753 was already backported from v7.2 to v7.1.10
and v6.18.46 but not yet to the relevant other versions in 6.12.y and
6.6.y.

Do you have a chance to backport the changes as well to 6.12.y and
6.6.y versions? The commit won't be possible to cherry-pick as it is
to those versions.

Regards,
Salvatore
