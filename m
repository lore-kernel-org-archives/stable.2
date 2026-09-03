Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8601DDC33
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404549; cv=none; b=jNlOyFFY3UuPYwRv92R6+3bYh5kf1CukvKQN1BFz2iHdOiDcy32615VQFMQQJbLx6gmf8MKEXYkQUj86ciJzT1BwdWZzABYR4hTDgbnHqdQGNrXWSICEe5iagOBHPpLv4FaoW3K1h7/E8aTKmQj7X0nvuerbydQ0n+ZTmkqZLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404549; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0l3hZVm0xGA6Pwpti1SQsdsoC+OeRkv4GFu0dMYpLQDVaFB+yYZvqsLOjucrzGJHN0cNWFYNazJR4YMO4mpWxMx7Jl5gNKZblTfVOzSASCjA5lxOfpxsq4FysAH6/j4hMORyQFT6K+G2INf1D6A3oPgAxaV4+C8bYCg4kOIEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsAEOPqE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsAEOPqE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2263946a91.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788404548; x=1789009348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=dsAEOPqE2T//Zqe9xpBqiq2770L9IIkELVSkcjj2BTeIRea4k7F7WrQ7gT+g2f7Met
         Cafev1aHMIgvIaQvCBm8yiExWturXRJFMWQ2pCa8EQ9I/AsfPXVO/zz7MhRTdyABlwVl
         hKrN02PlXlYngrEWH+HI82jEzbbISVqnF13LRmgQV3ZUCz+sXAMEE+EtvP7qBsFhzcn8
         Vbq48dWjBHLOBHD+OZG+bc3FPtX1RkxBaMhgISbP4x5OwPsgZ4uYFRLxQbk1guKLnxjz
         VgITSBbKxDYer5oaKjsvl8C7JIfjUx3kgZJM71nN7pEqZV9thqULQIJuZ515AKFM0z0r
         0NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404548; x=1789009348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Iz5K7uu7DSakt9posE4uxQn62K7/+CXd+HUw8yqPDTGRVvqBoGaNnepfsVrJZwAAsA
         paRW17bL3PS3+tFaVbZNL8X0Gi36cXeO6rP6e53ahFlVRlcUe6KJVFoxNjTCl51sVAEj
         14DDl0C64UsC+6fyT14KO7+po8QT8Z4nzcuxnMwg8zpRilzGIviG0PwWNCk6S9/8LxvE
         xNhEEJwjhnFK1ejv0syjVXgYj0Yipz8bre1a0ZRxrLfi2xor8u+7EFBNbe5a9bkr+txZ
         YUPsNQ+s0bUjexAcfQ8IEELkIHvJMt5iPJOA9fgKONkqeyncwop1RuYfAkypMgYt0hPu
         lfhg==
X-Forwarded-Encrypted: i=1; AKwUvBwL+ZncmYYrVNxYZS264ETcgANlC2+bYugzpuT8U6lJdZSPNw4Db0FspvBNjMidUVyG9WT4dcw=@vger.kernel.org
X-Gm-Message-State: AFuF++koWGIh2y1j45r2qcMXICJs0nF2CDPIc/vay4vng/n+45z9yJIY
	aNyZQvr7vjr3J3h48CmI3hrc3YCH1dJXUbJc263LUyosUzNAf8WE9xI=
X-Gm-Gg: AYBFou0QNQt68SeJG4xOJmsy/n5CrSNcSSaXEd1TWvrL/QSQGjb5CrW+NxI/v73QO0c
	/xS4Jm1lCNva38aZ2W2wsEpS6nfCWNWMoUSIapvemvMQln8O9vte1s1MXjESFIjGG6YY+xnTHCr
	RNPGqEqQjHYGRDMsp8oQon8aLm8VIYYPuVLjSapMyA//5IU2YR6txMbX6Ag1r1P5P6Fqo+UBdAV
	ZJRsjpPlxIk5UujWUL8/geNhZfDYnE85BT8LeVoy/fsHe9DHJQTNIvukjbA9mPbjqQGrC+pGMsS
	9Vwd3LynTiOZUp5Ot+V1zPUCzJIohGLXhJqfdEmHeQ339wQrvmP/91kukn9+kcXRemRttD9BWq+
	FEeRRts+FJsf3I/SdaeVzhClbhIc3ANbljgd+uqgV0k/01mc2ukPfcVLZOCy5iC8IDbZc4Y1wyV
	UV/Venm+Wa6piKUWQNh5x4KyJsXSx8oldo19uPnDMirKe9za7lr8THIDrqfPitIjU7FP9zW96Fl
	h+U0dm9QzwZXFrv2mKD3IugjLHu
X-Received: by 2002:a17:90b:184d:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39aedfb8bb9mr15043842a91.6.1788404547583;
        Wed, 02 Sep 2026 20:02:27 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:f76b:3efb:3463:cad7:ba39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325592d9c5sm2209189eec.11.2026.09.02.20.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:02:26 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:32:20 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, stable@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/8] xfs: always set xfs_healthmon::first_event when
 inserting at front of list
Message-ID: <uohx7k2iv73uhqwl67qjioz6bknvxk7h5rccx6eqyrgxihjzht@nebg7c4evcav>
References: <178832750217.3507776.15975397025387963886.stgit@frogsfrogsfrogs>
 <178832750287.3507776.8244145130516180990.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178832750287.3507776.8244145130516180990.stgit@frogsfrogsfrogs>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
