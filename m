Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D643C3C02
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149714; cv=none; b=dzNV9GVH7vequMQojcsti13+qPdX8oJqmOdgYwgEmarL8oWp/Mm0ey43KV7m4kr86bcyQFsg+2EvgGug4uc1QcrqQy8SqGilPh/KxhEYy/wS9bgcOrQPZADI8xsjS7VmRPw6QaXzVmfXq2dkOyfS2KzYhh7HSEUq82Sf++bfTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149714; c=relaxed/simple;
	bh=JWo7qptpEQzm5VHboo67cAi1vsGRFcq3ubh3+dfJsWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjwAJ+7TT9eT773OAeQ6+KrMckV9Lh0n7mwUUE/vhRNGF1DGZbqitxjp+KngKAb4Cq1jfqlVLh/MTS/7Eu1O0s/a/jjFI2VKGq+wbET6t6I+9vHzUp5xtJvBjUgReR6i+tNpGH6CKWJ5JkemN2R965MamNQ1PVZgUJL57UbHlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JsSdJZpG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsSdJZpG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d7200b2e15so31832815ad.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788149711; x=1788754511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sf/yHYtrO3MQh0Uz1YqiTDYHxqYrBGeKFLdYV/NPx7E=;
        b=JsSdJZpGdCeI2ltUaUM/Rk32oLibhNj1jwKI23MgiLnDLnVQA0FjFNnwIW1vb4+Qjj
         p8dga2++saDpM81nzNBIEHsiyAkdH+grOTDWaOr+6eGawBQNxTlAujEAwfqwn+bZCfYt
         +x53SdIj1TRS0OKrRvxqaRlRisCmQfaFlz7k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788149711; x=1788754511;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sf/yHYtrO3MQh0Uz1YqiTDYHxqYrBGeKFLdYV/NPx7E=;
        b=e1Ez+rroEJdyykJHEw+xcX5PCIYSAdUN9hNZsRzQRop2JAW81JOO5+vcPCG7o/SuPX
         oxDGyxk6+G8NKzJTfc7YuKJqkvf6ZXD9spNMvkTCkmiqySS4RVk1wxScpOtMrH4DP6HS
         sfrMg/tNasOkTnI45t+t906zelZOHdP/ttTT0XI0u90L6TsRTi9ZZULJK6wD6lsRjH6N
         Y6HCP91k7CgYIL4LqBlcIhyGKTTRH9n0gAm/hJ8BNLCnTzOx+KFFhFiOOFUcax+y6Xvp
         HDjGVc2eWQxv4pUfBzE5EWbQqkT0fAGM7KlFCxN7lUKKGqFrBCJpAaR/hxKCPi00Eb4/
         /sPw==
X-Forwarded-Encrypted: i=1; AKwUvBwnuQ/UPdslf8Ns1+r+L+ySqBHgpJlsM+RH96RyT7bCm8dqIiJNH8dgnRvXp4TV5kjZfHMtL4c=@vger.kernel.org
X-Gm-Message-State: AFuF++lh07uoDC9A44cRWP1sNloXhvruHXEZn+H8i+U5QqmU0XKu+Ycg
	GgQUczBKfq+hUXaBuxum1/ofu6UgxXCNFu54MHX0a11rWT1DbcCwm/kgzA1Oz9ZxHRSW6XjBGbp
	/jFU=
X-Gm-Gg: AYBFou0tQOsFBfwoVSQP8pI4aINidQ2sDaSQ0UvPCCSKQtpXtUgoJEM8qkSm9duloK9
	9Cmx2JfvQA65Ma+yoZ+WaJdq3YNXEr5MNz71SmI+mJwFoAQLy9wcCewDMmjKZx+kfaQ0x/ZSXlm
	Y1Api1bK3c4u1rXb0Y4UAHMRmkFiIJZkXZKqHvt9eBqB/5DSdbAlNGh1RSJGjVWPM/cUrVY2uun
	tykkQNNoW7aIxbEuiarS1BqiBMpV+bvbDlqQv+9536ioSB5oChitlcemOIEJQ8gYx5L12UAqnIf
	vZH80ctu1D7RWuYDvQk7Z0vBCOVgGwe6cHJvKu0hX0lX5qlIuaDbDYCvYn3fvgF4U4nqYNcGwdx
	wUL5xIez6zDQ6NnseetPHaEDpatv4hy6N9zyCYSlkAqThak9cQchbS16e1qk5Lj534kTli88Sjv
	YKH1jo2a+UPOuzlYaDzS/4cqOlHS3pEGujot6GJyavGPpe3Nm8VB+0UcpFZUisCmLBRxlO7PEvB
	w/FLUcizqq4G6Ww4C5+3r6x6iTq
X-Received: by 2002:a17:903:3d07:b0:2d8:d4d7:f055 with SMTP id d9443c01a7336-2d93fa78359mr10662945ad.22.1788149711457;
        Sun, 30 Aug 2026 21:15:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:6c22:caaa:530b:455d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b6fcsm28017105ad.56.2026.08.30.21.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:15:10 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:15:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, bgeffon@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apT-ocFYDmU6iC-j@google.com>
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>

On (26/08/28 10:24), Andrew Morton wrote:
> On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
[..]
> 
> Thanks.  Sashiko asked a couple of questions about this change:
> 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com


> Does this early return prevent marking valid boot-time pages as idle?
> When a page is accessed during the first second of system boot, its ac_time
> would be 0.

There is no possibility for zram to hold pages during first second of
system boot, regardless of whether zram was configured as a swap device
or as a block device (mount-ed with real filesystem).


> Can the early return above bypass this zram device initialization check?

We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
from that, that's not how one checks if device was initialized.  We may
want to consolidate those checks, just for symmetry.
