Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846C43F8AD
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832952; cv=none; b=YAgMsLX+UQFl3zwfOf1nwlweplRjaUlCeFSCVbSAY7HYa+syoBU2Q7JyNVM07BXlu/7u8JPdbOmuRxlR5hM5K8soo/03vH1GseAlgDKYpE2e7TT6G/tainzw/ilZcl0JOEtgP19jGCNYS9tirgOcq2rKP5+fb88Qf+35JkZTggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832952; c=relaxed/simple;
	bh=+t9We9CHhq5QIISRp6hFIb2HR/+6MY+ToLEhAlYRB8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8X8OMLzXqDWnxX4fMFS2VYx9rmxeTH8tage60w6/XfyOKf3komUMtYUuOcpjzItntKw19RHLcOmTb2ku9U4VAr9Im/GEbBS7OJAlM2D0+hIUn1BnF0THOZFCSdYXYpyBsdIs9BapubvSX0te2eiXrcpv3rfX6mfqT4D/jlo49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLFMkr8B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLFMkr8B"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84847482584so532445b3a.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832950; x=1786437750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Msf4BCiiq7h8sHc+GDuq/av89v8kUaD3jKqA6c2u6wo=;
        b=JLFMkr8BJcz3cfAuglwhBaNDDfVRhFMmg0016XMxPxAjtEekh0j6Zjd596K901Re0J
         Gx5Agtl5gfiqbMlcAU3umbrt4A0p2DrEcegf1JvZQQkLV/HrMuSeRq+VjA201rD7zBLa
         QECvhmEc+6XVBu947abshUAjjmdqkv5g8kTCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832950; x=1786437750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Msf4BCiiq7h8sHc+GDuq/av89v8kUaD3jKqA6c2u6wo=;
        b=qbu6jTQZaxhG6sPinWqE5c/wG5IcFhhNULqfO1fkOy3QgrcX0+mZyYSAJ1Kvp3t43Q
         HHFvvj8bmk0rYwz2fakY6wH45A4xnbmKVSVgDJofBnhX5+JLGo4u3CuSSM8koJejT5cC
         jRkfI0RJr9pJYciRyipEpPIeaFz3iYYUXcbLPYvRoPv/KnEwPIQA6WmYVIQ5HWSOBFK8
         3i1F7lOPCO6H2j9+FSqoSHr4AuaP7cPuZDZhWm1MmB9NdJLEBL7ha0HN5LPonFwAeman
         t7Odgn3e02drKg5K4r1Qu/E522Ried6QeG5jIzCz5RBdDwZc0xAbM3GeRWvbzN/pAy26
         w0BA==
X-Forwarded-Encrypted: i=1; AHgh+RrwtFe+Lt5+mtEypf4N17DO6cGQK3qdporrNVgutB3wrz89GDsQKFWIImJT6eLX8rvWe9BRlBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSae4BlBHfaEIOm8gtU3YMtm5Ts6666LjKycyEAtS3SNivFDC
	PpEnJeeixOz0hzHLODaUGQwedXq4apZAtro15Cr2jXeOq703q9eYdA1Sm0caU1OpIw==
X-Gm-Gg: AR+sD13k5Y1/DFML+WyYF5//QKgSyNd9U1bSmURvc4f7uIcnoZuZ/snvyxXKSzvf0q0
	Pi/aKQ/RsGDZA1/zJ/WSxZcBimbrmZ0w04s0ImbkZjcmWn147qFIzIwrbuj+f0+3rdxc1Y88oTW
	frl0R9+cm/VyvWCC5/FCBCHPXLxwdO85IHT/tBBNrJxxfAF+wlfMNVL44QT9jGr3uum/75O3Np6
	nY46TzQphBQHZpn9tOnKJJygpB+QeL/ywaP/LXDLRgSROYRH1/M5omjW0AMNER9aw8AgsRz1Tw1
	/w2r167rq4hOxqV1NQDnf0zgpJaYufoNoT66ozVlGZWUcZ3qSx7Vaip/qyt1IcMMyXshlFdmb/Y
	BrqLwA+6EHAUtzRfkuggkry+5hFTibDVsDtpusFbQmOVtZmkLw8j2fF2Dy+rxMUO7sda+jO6Mhq
	BC48K/mPqoQDPf5kAQehC+WV8YOjhBeZYHnq4dvgDAInTsgkICkM6uBodW0AGIWt3zmxMxfcJHY
	ja1kA/1XQEDk5ngnuRLBWMeV095
X-Received: by 2002:a05:6a00:4fd4:b0:847:b45b:fef3 with SMTP id d2e1a72fcca58-84f1cb227b4mr2528791b3a.27.1785832950153;
        Tue, 04 Aug 2026 01:42:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd35a4esm4854159b3a.10.2026.08.04.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:42:29 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:42:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: fix out-of-bounds access in read_block_state()
Message-ID: <anGlv6GhiDL8gQI1@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804065919.3970386-3-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804065919.3970386-3-xialonglong2025@163.com>

On (26/08/04 14:59), Longlong Xia wrote:
> read_block_state() calculates nr_pages before taking dev_lock. If the
> device is reset and reinitialized with a smaller disksize before lock
> acquisition, nr_pages still describes the old table. The subsequent
> loop can then call slot_lock() past the end of the newly allocated
> table.
> 
> Read disksize after acquiring dev_lock and checking that the device is
> initialized. The read lock then keeps the table and its bound stable for
> the duration of the scan.
> 
> Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
