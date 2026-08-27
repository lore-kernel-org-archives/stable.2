Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA12D7D47
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808620; cv=none; b=Ch8eyIKlwWye7Te+sbZGD27lAMMaO2vS6lsh/aqZl2NpdTFaJhM6SZBxWhnGgkOoCe2ugUvw3pTk5lNZFB209EHKUKz/RtGxUG3yvYLaV/4xczOWNWFyaezkGzCrdeSm4Z7wmFH3qstuDRlJzp6aKkm9BcM/xDhXLf67H/WgPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808620; c=relaxed/simple;
	bh=S6Rl6zBjfS0Ca1JzT051AkUrgEr/ED6h/G4rtheoPQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmikzvmEp71pfQZO834YNnB0WP+t/UpZmzgT1eff0G/A61HlQmaNsCixDCRa3uHbbwywKVUF0Hcv6r7eeYjkfkyqyRwmFknQliokXIQSL80avkB/O57zOPqh/ZROULb8DCpSu6Z5T8p22FU7ulYdW4MTOav8hagftSGOE3pIvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqGFyV//; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqGFyV//"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1465775a12.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787808619; x=1788413419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XT4IaIglNY0yBU6DSM9OX+m1P0B6x9mKUa+wNt0cik=;
        b=GqGFyV//Yo+Y31aCZ0BkXVa8Rth27BXyDZgGlriDdUNt3zm9UVZsMIRsAm4j4UpUbj
         34nP/0/+2P/UcQrZ0A90c88oRnlVFq2HJALvgPEXEnGfzuPehgA/M2QeIQW3ZRM3+3zm
         qOT1ije3LVTJFxdzDnfz4o3ruoHg6A3sfHTPbsGjoLQcyjvcNOzbE7RraQW+56VuRw+N
         F6rRTMWafz+3uG9DAvKqRK8pQ4kknIrpBOab/bGLr090poVfFXYv3Mo2ORfpzlNWpCXx
         yWj3k+2/UzWsN49p3DIPBXJTQMm9qkmMJsoB7YCPG8s+ocDTyjSfFVchysd5501hzEFz
         VoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808619; x=1788413419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XT4IaIglNY0yBU6DSM9OX+m1P0B6x9mKUa+wNt0cik=;
        b=SgN+Rr1YbBYjfp116a9QLhAJj1og9oB5k/MWARiWGW7hNEJvt/qussTAw3T9PlE5fL
         7RKgBltJzzo381HC8Oc6yHCh7TuzoDKQvPMKlJTTJhqux6JWFKd2RS+dztOotlQ3KBsy
         v2n9p7wjTEdBaZhIrvVeATEih5eu0Nu+rKi4kcCtyUmnPvkGeJ7VKx8akLdt41yP1JtZ
         HKsyqB5aDwhkH/AihYRweLY4qN1yKLD7G6OaQIPvqLDYiIQA1Bzb/TzpM/O27QjV3eBM
         2g47Tm0q34MiK30a8uFZ8K9+8K+bkbx6OZYhM8AhXufTiRvWjEsqt0BPKoT7vmLAz69k
         IiCA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/45nqq0jXDV/ZxbCF1DohF7O97u6HFG97X3Befjkf25lq9ou25C7FydwZBhLVLt8qzx5Xh7A=@vger.kernel.org
X-Gm-Message-State: AFuF++kQdDvnxtCGRbc+B/Z81Ygcg6osgjJHEsoK29J/iSUNIQGpRo0N
	5g6nH/Izf3X8HVOLnDlEwqw4z1M0BN9b9MqR7FB5tEZGO9ay39ChK3pd
X-Gm-Gg: AR+sD12DmQVImRXHPbK7KxeOmkPeaF/J39i82D+9DOdxslhAzTnonDJJgu5baz6WDZp
	/352M2g+4X4Y2qrLwI31iivwyNWT4ZNLFSqyIKbeSCsfgkX4smMkHjtSASFZcLN3F91IVfk+FVw
	vPuIPS3nw6PIdYBpMxX98MbhvPcq/uYo9j8elqkl/1iE25TrCKelJWV6KMDop6M0T/C5ksdkLpA
	8gsJ4/+94L8/t0rKbU85lnp+e8jZvKvAtHF4kF4uDZIwLLG4/W6OJfa01VmBkR0RqqCtXBVtloz
	Eb/qPvAwaFORh91a6kThHz4ZMM/vlFctsZkG6XbWFgZipCr6Mshy6Gw9eAmDy5/r3pqn2ZKxRNf
	fxcS8hic/GZTVjN6HiFLDOmlZnmWyxIrf0OWtISGMuQJWMwHEW3Wks96wmv8AOpQJ3wXsQMwAu/
	laTtFUJbrLny9WsOSPDOY9Xsro+b+1yT0pObB2q4sAAaGrmLO2FHn5kgGciy+etCAbpg==
X-Received: by 2002:a05:6a21:4a97:b0:3d1:5c01:e6c0 with SMTP id adf61e73a8af0-3d15c01ef14mr4338564637.11.1787808618511;
        Wed, 26 Aug 2026 22:30:18 -0700 (PDT)
Received: from Default ([2409:40f4:1012:4330:756d:2890:a615:2db9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035ff1sm12138693c88.11.2026.08.26.22.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:30:17 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dwlsalmeida@gmail.com,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail
Date: Thu, 27 Aug 2026 11:00:03 +0530
Message-ID: <20260827053004.14261-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082710-curse-hardwired-baaa@gregkh>
References: <2026082710-curse-hardwired-baaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 07:20:31 +0200, Greg KH wrote:

>On Thu, Aug 27, 2026 at 10:45:08AM +0530, Jeffin Philip wrote:
>> On Thu, 27 Aug 2026 06:51:21 +0200, Greg KH wrote:
>> 
>> >While "fun", this is not a normal path that users ever will hit.  See
>> >this thread where I propose tainting the kernel if you attempt to do
>> >this:
>> >	 https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org
>> 
>> Thanks for the reference. The task hang is not possible
>> then. However, the UAF will be triggered anyway as we are just simulating
>> an unbind. Even if the driver's .release is called naturally, if we are
>> streaming data, it could cause the UAF, no?
>
>I'm not saying your patch is incorrect, just that using bind/unbind in a
>way to justify code changes isn't ok on it's own (we are seeing some
>crazy platform and pci driver patches being proposed because of this...)
>
>It's up to the maintainers here, just wanted to point out that this is
>NOT a normal codepath that users can ever exercise and think it's not
>going to possibly cause problem.

Understood. Thanks for the review.

Thanks,
Jeffin.
