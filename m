Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D76413799
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925748; cv=none; b=Y0rujb1BlTUT1CMFtN9qVkUs1yJQzavoJ2nmJLN7inlMkxUYSoiE2ajqixVtd7E38/BNvUuixL0Qd93tXJG1o0xnce8NP2y8oZgboHWfej4pEUJdOLfwhSa8WPRug60wf3BObj1MvUnLprXskAHO4i+fzEZN4kQlPzYb36GRtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925748; c=relaxed/simple;
	bh=StromziW+40JYZDwey68lBv5UX9Ghm/SOb7iQ63o/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFU3QRR7PJU2tBte2IzC7UZ1B1w/t8gaoc2AQeEHOWJ4F0Fvjj8ICPB2dbSY40FFiRTD5FzhrmCgUsiUGODYWb2qE7ehvL+eOaI8HDD0e7wRbH7zGky7FO2U5tpJZLo4gYetySuzQYfHGp5Mk7QGYpzWL9F0/scB/6kDJPrY124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y/u9Sp6n; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y/u9Sp6n"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so833486a91.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785925746; x=1786530546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=Y/u9Sp6nltKRLaeAjg5iuymnnM4YPfvxH+qMT2AxrXuXWBvE+0NvZIKkATFM/nj9ki
         MOeQUz5ZdqIkcTDamsgY5lMJPwmbruITBZguLulvcF8JRviXEjZablTihBEMgeE52i3v
         3paA2LSTCseiVqAqg1s1qcPsYfE3BOKXg62Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925746; x=1786530546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=IemIFJ/ou7OLcZ240zoMrJ1DbmOXbbVKX7K34VhmKA6cUokbJIqwG07vsdgrXOrysN
         +mg+5NM0f1EQUR2aEmgEJbSrzTHZTuO8yf54QJuMBZiM1DVAi99oCBlnM6p3srpi8cp0
         gNv+y+CEpeD9X4TddfrQrgW9uImrYBN87/DAHUztNtJTfK7dhHojtqKMh5zqFZ+4lKgd
         ZDVSGlU2X9wEHeJ2AIlJeIFrN5dbhG/qU7TMHK44i7He8Af2/W3J79doFI1JQnNd7gsG
         IHusLfkBj4NPlXFxKW3gBWuOKDufOUAo3ExNkk2m8T2F/xBjcK47A+fuwwuoE7nFad5g
         vv+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqIBcd0gTTu/fhiGrGq26yoO4HFzphnT5FSFmfX/QTyIKflZsE4t72l1h+DFBjqsImxvCahQxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbFe2i9A8CyuISFzvLwargn3/8YwtKpWJbnKS7M+jCN2rV6Up
	rqzrW5tdIFCB0TH6q0nbqKaZy3+NO5dAkVdWZFODqicY5bH9uKz5thC0VQaWopIqpw==
X-Gm-Gg: AR+sD11piNMPEFF1DAF5DP5IrKS5yXFH6PmSL1c3d7DYKsthvmn5LO44W1CQ/xwzAeq
	m7MWcIol0OEDMHMMXsafCiQKfygvEJ6ecs1g3+8HIA1uuBM54u4LouI/VTwcNOtpuuSp/SXybuJ
	PMiUQfnG1q2ixrnOWqVGkYKZ74y6vard4J87SAclRRU8Dlc51dzXcxoqqHhC7N1bNMqP5jUd9Mm
	xv1waLe8Zo3DBsCv6k818o9nRF43wVj7Ls52yULEY7SWayVhtF4dYIggtCIK+45fNTVF3LnyJoo
	p6AsGHQb+Q5k5guuoY0ysBLTjfmk6wVospGTirUiDLknJ2wCM+Td+RdOD1hLCuivzf6R2j5logE
	xxxI+oEae0Dk14fRwsCAecoXE1MQW3yw4xafuGx5n4l4iKsCpHYHk027iqBATp3QAZFKKwsCYMU
	BC5EIgvPd+ZsCfTXT1Bt57iiFQ023bRNbDtu5v6QXtn2xM10iFw+3T8R1m3qz9gzHWUxa5NeD2k
	uqa4Pz0Lpa9IZdbfNHHdUehSWOP
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr5818956a91.8.1785925746154;
        Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903914186esm2780030a91.1.2026.08.05.03.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:29:05 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:29:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMQTJeiBZUHX2Y_@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805021854.1057715-1-senozhatsky@chromium.org>

On (26/08/05 11:18), Sergey Senozhatsky wrote:
> Device reset does not take into account in-flight async IO
> requests so we can free meta table and reset device concurrently
> with those requests being executed. The block layer guidelines
> indicate that queue state should be protected by blk_mq_freeze_queue()
> during teardown.  Freeze zram queue before device reset.
> 
> Fixes: cd67e10ac699 ("zram: promote zram from staging")
> Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

lockdep doesn't seem to be happy...
Let me look into it.
