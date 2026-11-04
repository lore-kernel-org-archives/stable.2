Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814043;
	b=ZpkX1eThY/RdIU5eZLMuussrhpCZEAiJ7LCACqhdwAi7EGRG4/1POILPxKBasubos8mr
	 2ShX037TkYXRqDHzsK0BKtiCmOPuh7vyb6h/LBfKvYPjA0NKqK1t0rNZnApJ/nQdSjxyD
	 uyzMBRh6s/QwRcTo2gq3kvtpV7geLfPtdObZkonUmq4raPgk1lyen/Tl0sOtYd6shKike
	 6OQnwDCRptw7Faq3LHwXlWA+4SA4OUO6vjv6fG9/ywzL9w5fJGYRb47T8XGY4Cnh8DzpX
	 YEv21NweYw/2hKvl9E6JG3410JGGJpyf6fKOQh5tP0CeEXHMeFgnL6JPvh/4uIO/fVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YhtsBhvAospz3gnGs+ngXfQiCOJCp4pP7kl7qhf9OF0=;
	b=BxCcSlMg1K1bmYkFiLxiGGvJ44qP1++cYI5g4GnKrdgOyjoUGK0vBrOI/3LrEGpZ1Xs7
	 p5fCKr9d7z7LNc1i5Vj7igS57x1SoUXmH1DEJFPqWMFynmwtjC57ZLAujoXAWc610lMzy
	 qdXEjGWMcTgZXE9HzHYKr7kh5kNT9l5qppU0KGNAHce/ub5YR11x6UahqIjT/zjz01so/
	 RTMlJTv78tzXtXG7+uR4t9JbFvMYsUMXN2VVUqewB1A8D8El+G/R9NOSPvJ9dKWBlK/gx
	 p5itOpYKaL5ig8n3v/I20nP3ImHHBSaLXIUiWuEomdSq23j//2PMyiKLwbR2DDHYzsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hCETnKBj;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A031606A90B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A031606A90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hCETnKBj
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e64d52949so86176185a.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793814042; x=1794418842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YhtsBhvAospz3gnGs+ngXfQiCOJCp4pP7kl7qhf9OF0=;
        b=hCETnKBjmqap4TuILlk1+y/t0ff88T9bZ+dOuwmLpwI6VzqQXi+7Ew1fUV0EIAA1Oe
         F8n5/Bs8WbP5ggdzMFDDPirWaPqIAx1iA/mDgvVJL7nQofjclhAmGbrh6dLRfzskNhB7
         ZczB48jwVorfxwOqKyEaj0deWOyd2jxm73M/SO+t68KSEg3LRDOS8txtRYEIGFQ/wO9F
         AFPz8T7X6Dkf0onwwvqIXu+u89B6aWxxrnvyvHPOMy6hW4tHhDs42P/YG+wJPPJAP7z5
         +htRw9gum7ooVb0W++2j2THOtF8fcc+b/xcGhtRsZffcGxHM6VTCl/yRyTyEigEerFK4
         CWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814042; x=1794418842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhtsBhvAospz3gnGs+ngXfQiCOJCp4pP7kl7qhf9OF0=;
        b=LF0W/E3+3kNCNzedIFzA1LAybluJ3Q2UcZp0wcy8F2ULekDPM9GNaM4QZMnPo+/Gjx
         4i/Q1HBt9gQ4ehF5h8UJQ1pguaNvZOeY5zLRr6BFIj457f+l1bMzKLxWI+zXwBLHKwmp
         bvyPFL31huOo5C/CcpWF/A4duvFoyhnVXxK8KwQtrwnm9e2AVi/Iox0QCHkGiZOnoDXH
         HNbyDBzFEhzUdHFSuFfKNNM6zZTrkK8USJGXvRIH8+zc6MorpL9J6vFI9ZExKd7AzFAQ
         S0N6pKIRpf81Jc8GUNPO5ApCgO7Bpl4XyQ2EK+NYvmETro4H761vUt1CWQK0uoRlklYW
         BVTw==
X-Forwarded-Encrypted: i=1; AKwUvBwXPnLMvfI1DaqE9Q52irdphwnX8s81EzechXJKnaFpXiXWn212xZSOrXcpJKI+KV4HtrmzDdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WPi5pttkxA8CGyzojuTJDm9N72tZoDQGgds/bjsBeVwIsJls2
	gjc0QV+K+HtH/0+aXztJieO9D38g/jaF0/uE1bvE6hMvsOQvQMYtVbJGn3bUzX3LuP0=
X-Gm-Gg: AYBFou3WimY36aMaDHp/Gojrt5FcJNxBe4VpXMe+D6NwFAzuztZUSa2ruwr550zsFOg
	18Ssksx5J835jGU/PhptgyxJ7yINRDAN6rSWqAMzB1EIclWMp7PWFjCUUCtt+V7H0bewPxPXgsI
	4mugGusKdPD8Yb5u9nP6mvHIxkRzeueww//3PRWQNLYG6NZVlECL3x2sZ2EeMg6egITf64wZCOg
	jzH9Czza6td1pj5yYya3cNlVwWy4WT+/vFBcoND0/tEUUoRTRylf98NbkEhG4gnff4dbQuIAeMQ
	OILxxfVYfyGk6Am46lcypwqoMjUlqS8jhTGuW6bIjJra49NNl0aCLHLFtbdxiwcWjMk7YShmLDF
	Mn+kokQTpcwTaYl+CkdU339fTejm7PN1kg9wa32OJsq5l6lFW+U8MFshY10xszAs1ckCv2tB0yr
	69+Cv6zxrGhG9hvvTKP7JdOc7/OPItAkGnBq7HrMKEYxk4NSp/j/iqnjcHU7LixthnKpPYpaOSC
	etSXzeEh0/daI3UM067g5BNwfq3bRPIqlMOqq5gkt9FsunN9/ppPwtv5a8VkaXkCEpiTqnL/Xvx
	GxEQYc3iH2OQ1yz0Cdh5lKsSHXh2IQO1PXP0WvKxo6UrsWMoW0peA+LusfNcd2es5StW67nU+sN
	YoIlXtoVVJw==
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr2734997985a.47.1793814042031;
        Wed, 04 Nov 2026 09:40:42 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb3aadsm24214876d6.8.2026.11.04.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:40:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOeyX-0000000GzI9-0S67;
	Wed, 04 Nov 2026 13:40:41 -0400
Date: Wed, 4 Nov 2026 13:40:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: 0z5a <dezhen.lu@student.uni-tuebingen.de>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix DevX umem page size truncation
 for pages >= 4G
Message-ID: <20261104174041.GY3889730@ziepe.ca>
References: <20261103142804.67210-1-dezhen.lu@student.uni-tuebingen.de>
 <20261104100747.GD478286@unreal>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104100747.GD478286@unreal>

On Wed, Nov 04, 2026 at 12:07:47PM +0200, Leon Romanovsky wrote:

> Isn't this fix enough?
> https://patch.msgid.link/r/1-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com
> 15fe76e23615 ("RDMA/umem: Fix truncation for block sizes >= 4G")

No, the long AI generated commit message buried what the bug here is:

> > -static unsigned int devx_umem_find_best_pgsize(struct ib_umem *umem,
> > -					       unsigned long pgsz_bitmap)
> > +static unsigned long devx_umem_find_best_pgsize(struct ib_umem *umem,
> > +						unsigned long pgsz_bitmap)
> >  {

That 'int' is an integer truncation if the page size is > 4G. The
entire page size path from the core code has to be unsigned long if
the pgsz_bitmap is unsigned long.

Similar root cause of truncate, but different code.

Jason
