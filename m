Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7F48D867
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681490; cv=none; b=av2Ryoz0ZD5eGNm7v3yeQU+b0TwMpzEspDKpAhbZP6JI6ynabCL1C6190AMecGE0HbpRMo4lr1olMJGMqJimoUGn7+w4wIfloq3WpUVBMwW6RnHsI6bjLHH+5JHv3SREXS1b6AxqNcHQOq9cbR6ZRVh2sGtPKg+FscMAGn0daH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681490; c=relaxed/simple;
	bh=8LTMiilxRKxEpRQ9qXa1k/tYlVZwEKVcRdEoec676P4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ewnWUVBCxhoPAGVhl0y81nJKhtCRcAyE1bActbCzJQEzR8XokyZKGqQHzw5I8wmQbmJ+e6pTW6YOO+JHnoYuJ3MWiOnguQmOXICUFiHEuTWwBhi4EBhzLEUcH0KmphDz+lIZwJGvtK5lbxrUAOrirZgeEas6zCkIjpJrimaDwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PRCOef1c; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PRCOef1c"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee4f241f42so1027629a34.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787681486; x=1788286286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVLGjH/4cRIyTeDl3IahVFbiHa8Lkd8VxiWt/wscO3s=;
        b=PRCOef1cOfILfVKM4TskCCFR974XmX4s1P6feqgZOsh1ovfTzrgVt9IQbazDEs/Xfw
         +uICZfU15VTGIYu13HhTxAfD6VsrBG8R1e5TBqQRMQOBzTwZhOwjNC9uCKwqiXIKCHVG
         MzJXe8xj3zy46F5nHduJGsqC4TSnvOc2hMk9Ql81/LVw3PujtHfCarGLVyqLq67EiPFz
         YN84fdtTj5jwuXPUzEW8bOxo9bTGiGeV5eHZrpKGNvE3mniLRs505gRGuKGpVTbXJ55i
         IBP3AQFt2ka5iYEYZVHQY66z+lZlzgDnLs83fWINRyKxX9OUfhOAZZzk1H5KYcphoAXN
         5o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681486; x=1788286286;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVLGjH/4cRIyTeDl3IahVFbiHa8Lkd8VxiWt/wscO3s=;
        b=hdF0DWARk9kKOMXxCezQeSK7trd/ef037mWCGiTSgCi4C+g/mZk2wEhQySPg6IPlsZ
         SVeM6A/WGZ5lq9Ue/kkaSgUgqPQgCaONx4ub2jaTc42s2e4ruNp2Or6al5oS9wqgD6Fi
         UNp+7Zx+HRwJhniXhqXwnaM7+YuvgK02YZNoM+uIL6uFSqrATTYYz+10vZvBGVOtXqvF
         TDyvqmflaklS6Ra42GpbYvRYanAKpQpAh5N5Feqa7u8Vk7tSF8Ad604Fpbj7CCnOtSt7
         5KA+iV2ONOYE0YEhAZxStT4ko7yaljXgfhIAh32iKRoaupshNcokx7yJIwupXNDZXGwF
         dBkA==
X-Forwarded-Encrypted: i=1; AHgh+RpEAqLmkQqUO+Y4HzBDq/aB5pRuLxDcJSz1Zetn4FOtreIAMS0EVXVeSKZ5XRiMNkwW+lPOSP0=@vger.kernel.org
X-Gm-Message-State: AFuF++nf2OzlZNF28UzTzeG6RKeobTEtSVHw43qur6LHGfR3e5r9kZPS
	yUDagTwEqHB7FW/LLljjjTsN/8Z8XWUmfgTkXvU6OcqGddYf+BAI8QpvbBZfffupR6A=
X-Gm-Gg: AR+sD10YIK8eVW155QDDUljwgqtDF+7V7GIOEFC3BwCOl19y4SsiE9FDaibZ1J5RY10
	1AO/y5pWU3+DudZX9NZVUOTgR9gvDG1KLsYvc5S5BY5WOX9rssDqMuKNRBI072qcFUNgM3lKNEM
	E9+JT9EK9JOBPiJg0JZaBuACIvT+skmou8E0finO1QlmsS3R4P1LIPV49PDtJMGodtIl4Kyh2YK
	vRGxubqSUE5f3Me5BRSU2SaZXkbJkvRgz6VLOByWqeh0yhLIEay+gnMYfE7pgvc5j7Obyi+TsXv
	JCsTYJnf8Pn5mTpW0gnAq60Nbg04IlYSqrsmsgmAYbfi8gqvIZGaY4aMslWg5ZEe67Dk722VsDo
	22IrHWOwmDPzqSc4zgD50qvaYWDBjcZWkS1ezfh8xIiPq7bXpE12wzTCIc89tYZwgvV3zMZ2/hg
	oZajZrWWAgsycKKaK0n98Q7zQJrr0oNj6gSTpivj8N+jXigbC+a0w0dgm5k80RpWjr9zbgH4k0s
	agtRPf+kOW13oSL1epkgOokQ0XB29du3oBKhc6V
X-Received: by 2002:a05:6830:6ed0:b0:7f1:e04d:fc4e with SMTP id 46e09a7af769-7f4aebe8194mr6315769a34.2.1787681485832;
        Tue, 25 Aug 2026 11:11:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c4424de5sm185250a34.17.2026.08.25.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:11:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Laxman Acharya <acharyalaxman8848@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260821103317.91437-1-acharyalaxman8848@gmail.com>
References: <20260821103317.91437-1-acharyalaxman8848@gmail.com>
Subject: Re: [PATCH] io_uring/query: cap user size passed to
 copy_struct_to_user
Message-Id: <178768148488.43624.9542937429211727465.b4-ty@b4>
Date: Tue, 25 Aug 2026 12:11:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 21 Aug 2026 16:18:17 +0545, Laxman Acharya wrote:
> io_handle_query_entry() clamps hdr.size for the inbound copy_from_user()
> but keeps the original user value as usize. copy_struct_to_user() uses
> that usize and, when it is larger than the kernel result, clear_user()s
> the trailing bytes.
> 
> As hdr.size is a __u32, a query can request nearly 4 GiB of zeroing,
> including on the error path where res_size stays 0. The interface is
> reachable without a ring via IORING_REGISTER_QUERY.
> 
> [...]

Applied, thanks!

[1/1] io_uring/query: cap user size passed to copy_struct_to_user
      commit: ba77efee1b95b4ad7559b1cdbe7cd7fa36dca95b

Best regards,
-- 
Jens Axboe



