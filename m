Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D03911AF
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050554; cv=none; b=gSZHy6mYZ9kWCHXfXeyoKpdPh8m7tij/HhTnNshG5xGCfsYia2kl2AgfRdPFD4Zh4MZmF/taYXT/38k9UOI90Np7OO6Fi9Ah4MF+PQ5W9uGQJSPWLiKwqRJ5ixvd34nHEMV1p3Rxqy4S2SV1CqByJ1QXdAHqg2LNFJi35sSSg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050554; c=relaxed/simple;
	bh=1fA35AzLMLI8IsjeYb5yaRW8LrQiraBlfHGAy9JiyXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNaGrIyhqwhk1lEHhdskRqkMdNcG6cSnHhFbPrIXRkMXs99slJv1F1vHszNxo8ziNJBkKi/lNWhsfmcY1CST/nbU//n6gW5kIefA58X92SNa1e25BBJyS+SoTp6wPg7yv+TyOn21ZUnzM9zGAWEHFxYbR0eFVd/xkHmT+x1qw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com; spf=pass smtp.mailfrom=truenas.com; dkim=pass (2048-bit key) header.d=truenas.com header.i=@truenas.com header.b=AmJNRO1t; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truenas.com header.i=@truenas.com header.b="AmJNRO1t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso4695035e9.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1791050550; x=1791655350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fA35AzLMLI8IsjeYb5yaRW8LrQiraBlfHGAy9JiyXU=;
        b=AmJNRO1t6oWi0aOw+mT2mVndfXFuJ5Z3Czm2jr9X34mIMdbbTcJl/yp2donqbXgOSm
         G96nGc/CthyG2os9pHyHhLnnf116S8eB+e4brYmVuYDOnydOgqUOrLlwFDkJxDkd+hAp
         2Ov77RcTStcZLUrsXEawI4yClLqZdHzF5xPFVeQD18OdFqzcqpxLzsxo6JTHYElnjJEc
         1ZU11YzqcNtEKUslhyPm7dm+mYbzA4ttiCa9M4wMYvhmhBpuf5sQvGp4Y4dW8I/0sbcc
         lmX2ac8IpmIppGN2TQPhjq9m56ONpQ+9YQF3louEVH+qwUcLdSLbxrFNxWBO9mfDigrK
         0AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791050550; x=1791655350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fA35AzLMLI8IsjeYb5yaRW8LrQiraBlfHGAy9JiyXU=;
        b=zSOGPMlwf6d7mvvmrWMH5ILTAX4VBs9ZHGWZmIBMbHoRkEqGXzN8sPqo7sHANONA9I
         S8N/pDZ5oEoltj+UI6jhrnmDxj8cL1xVOOXqhLFKNAdJSnFsEyIA5tehpOQMlCWfRXp7
         UwTw6gu8N0ZTW1Zb0+5NF5XNF1SW0TyZ0/bMDymZU7bvi3E35c0dIK6kKy7CGDKQA4Dc
         hb79kRgfjyeoDh0dId8wYXA1RKOdQUnk2DULwqRL0uBpqVkD/sP9J0/xzyjzk7ryscUb
         vUki8/MwyW9qrHQIMxmvlLUJyYtX07HWsZjyE5re904vsLbpzxa4UhK92ZJl1CZvJOH0
         fXbg==
X-Forwarded-Encrypted: i=1; AKwUvBz/ai0eSlmzZhV3qOYnA/dfYnmOi8dJPlLyiNCWyBpS3DZ1XQssr4bCy++nVBfy8S2odzqS2SY=@vger.kernel.org
X-Gm-Message-State: AFuF++l/QoSDkHAMe4o1OZJ4ukw/cl74X7zJ1YD2BobElUiIkP1ZkOjh
	diJxAvfQuO8IWAGY5zhyLmRt/qA7AZW6vlYMREcV6S1xnPvuvuyVjqKwrNcqfsP+ow==
X-Gm-Gg: AYBFou2TSOdfk55t5MtRImb+6bw9oFp3Bjnz2DyszAjzAwFQHvSU+X0Fo9+jcDJnFTn
	WHxpFSrFFOwhyIzOkDGioopfrFUAOvZqziKS/XNjkUm+CGQ9U+yjp9qXkzXXooFc2N6sypoAG1L
	Leszp9KUIDAH7GGQ3BIxLRheFhnLF7Hamxbzr6tP1kVDg1FXePeZJt3MqU5w0BoiPna0pijhrcI
	89WH3MElVX8hDF6tQqZ4lcTksQDFdQ00l2Mjw4VBGHbxzZNqMYRNfE1N2UIY9yaJLjb/Ct7Ye3F
	MbtRWsjJONTit8tNk74r5ZkRXAHCQUzTo3mBFWNIbpdC/kNS26dZAcx8Giaij5ACPnPJ1ai1RVw
	r6T4g2EzaEaxsWtXWsQqwswCGlPH5p3b7wONMs29lJf38Vwl8BkvIqlzLU6FMHwA7nU+U21NxLK
	F5Uvsn76FXCYpkuInOZEBtMPvmOPn7KWIww0iP0Mc6cptsV/T0LA==
X-Received: by 2002:a05:600c:4e55:b0:49e:823a:9dec with SMTP id 5b1f17b1804b1-4a0274e9c4amr107646605e9.3.1791050550421;
        Sat, 03 Oct 2026 11:02:30 -0700 (PDT)
Received: from hamza-PC ([2400:adc1:158:c700::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f89c3sm12646948f8f.34.2026.10.03.11.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:02:29 -0700 (PDT)
Date: Sat, 3 Oct 2026 23:02:24 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, sashal@kernel.org, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asFC2Oryo2-9ww5r@hamza-PC>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <asEllR7if-J3wteg@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asEllR7if-J3wteg@gremlin>

On Sat, Oct 03, 2026 at 04:56:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> So this is a bug in perf, which should use its own counter for this,
> AFAICT.

Agreed, and the report's closing question pointed the same way, since
the commit itself closes a real hole. Glad the longstanding perf bug is
getting fixed as a result. Thanks for the analysis and for turning the
fix around so quickly.

Thanks,
Ameer Hamza
