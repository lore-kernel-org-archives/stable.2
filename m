Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF85275AC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068220; cv=none; b=ngrmSTLLTOwSG7NLx6DMajqAXM+gnFDoPZVjbkV0OJ6+siYC2d2wXjXmXdoXLIPv7otnbIkrtjG6TloKfdlmJOa1GGrrgDOpuXtBXVH9FAebJme85gRC57odDeL5HwHBD46WlF/3ZtRSVSDrZavx3OIIBIvXZLXz0AA2xnybHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068220; c=relaxed/simple;
	bh=wkOW124WuFQQCipMuwELLw27Qx4x1bj/S8RRLSKncZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsrgVaeeQJqvpnPnpasgjn+wpSEihushofnlr4lM4oQT31xYdtkAIviGa9yaC9487hKO4DmgBZfpgms5Lf3wFQdQwg95HVLvW9zGOJMkvi0gsC/QIU6wNU/vym7DrLA9/Iz9ulWJMNUAh71XuOQN9zmheFuDHwW/FW+6QreZLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGY+AXxt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGY+AXxt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so27618875e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790068216; x=1790673016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95n40ZP9Z6iTAIldKB90q2CM8xGRzAwUON6dqMEGMLY=;
        b=qGY+AXxt7623LzERg/mEE6+Ms7RT/rJ3c4pQ6qIeCUP/sUVfnkqW3bjYHDjkr45pwr
         zH1JbgnOgOdVafF0n+Bf8PnKUf5wR8pc3AOoREg2mslfPW5YQG9yuLde870ytLkWVTjQ
         JgIbaxrTrFpvt+IJhtMV7Y+SxYGznJNGW27XYYTS5PertN0ho2CZSU0aNLqVzOPMcu3w
         K/aDKu4JlDeFFd4QnFRZTVX9NH3lt9fhDrcLWggaMsnDP8uH4c44bHz75iEhep1s6cDg
         hlqEAzSwHoFO7czr2kOTEZGzfvDfum/gMjMzEzq7zsdG/KsmWoNj1p0RHihsNZXqgyQr
         R/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068216; x=1790673016;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95n40ZP9Z6iTAIldKB90q2CM8xGRzAwUON6dqMEGMLY=;
        b=iDZQDR/Y5kWO4uaNZrK/cBsfMrocH/gheD6/qcdmrUSMVPsrjQF22O4QIoODyWmuI2
         rbyyNqcLfIpFGXARPEVWEUxuqaVMltJKU44YT3S9e4DYcg6TrCb6lR0rnWo1o1KFmKaC
         teEV+b6GyEUSF6XjaqQzecKdVD8sGHsCnWVO8nECY6IoSYevMP2qGqsP91iS9l9kbU4z
         wxYcfT0rArmtVnnWQ//0Lw+2ElbFahmPQ+snAtKobf0dBd8CwmWzLJY/vhjTehCVR/kY
         9VEYfUlvNpFzFmrrnShfjMfDkzXs9hdZjr4HA15TtJt6lL6Xf6oXF9mm63fHc0MtNGCF
         96/w==
X-Forwarded-Encrypted: i=1; AKwUvBwokDNdW/mh9QCwOByMr9ebHzFwRaKVKEWxcSz0+qYz8mkqS7IBre6JIq507qpW3tDcFNvBjrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mT0XC2Oqf4NHM74E45Vf4vJwFcNaw/xfpve6PR48gFHLvCuI03
	KX4UqJkuKxjv8V04DGaFMzGC+xunV9WZBb2cniWieYrt4glJNcCcnicA
X-Gm-Gg: AYBFou0GVYmvf64Q5wToTIO+XoDRg/mprh7tzm070eZYuCRPYyhHxljX0uo8AnYumaY
	ARQp125kuN2SSEFZiYmylNsd82gvCufjFwFwmy5eKgGKXwEB5osGtiaRAGz/qk1ZcdN5Oz8+NLa
	ASzBUMeC2MPxblPLJabjDgFYoCEiwX3U09FBcOZqtBlMx2Q1dWJcn3bZIRNJmUA1MxJGDh/jlnn
	+rDcLxsCwghcI43YA6Xa4VFM1k71dzH1T44ji/2DLACXgx15Rwkz8qhNKe9DAGxDQwyoY9RGWbb
	9E8sNopopb1tJ9e5s+u8gwmYbli/+ktez5wWG6f5ydzXnTtTfTouWqVMdBrDfQhQNyvdzKuEBSE
	Tkom6LMcPcBwpsyAupDsBabklY1YxltSpnV2RP0/MNEQGUfbiMgL2XRqB+IEtKqHT2FLgOskhR+
	ccrojyF0N/8fmgX75XBTNgJ0ZQedBdfkqkxr0KMqL+i4zmlSdYdcaTmZB/nTuUpBKq1ANgVHP0M
	plP/F9hfF9ky6lrNsHPQRlytx/nYHg+Mg4IQWm/iZTqlVXGVjyFs5tq0chf0/29gROnVtoQD9Ni
	L27q
X-Received: by 2002:a05:600c:4e16:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-49fc574a641mr164997875e9.33.1790068216048;
        Tue, 22 Sep 2026 02:10:16 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fda8f04f7sm57710925e9.0.2026.09.22.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:10:15 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:10:13 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: don't lose a failed direct I/O bio's error
 when zeroing the tail
Message-ID: <arJF9USiUqIEWB1M@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-4-parri.andrea@gmail.com>
 <20260921223432.GO6283@frogsfrogsfrogs>
 <arIT5A3MR7VtCeba@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIT5A3MR7VtCeba@infradead.org>

> > Why ssize_t?  iomap_dio_zero returns int, right?
> 
> More importantly iomap_dio_zero can only return an error for a
> logic bomb assert using WARN_ON.  I'd suggest to simply return without
> an error there and remove the handling of the iomap_dio_zero return
> value entirely, as it clearly casues more harm than it helps.

Agreed, that's cleaner than retyping the local.  I'll drop the
zerror/ret handling entirely for v2 and just call iomap_dio_zero()
without capturing its return.

Darrick, that also answers your question, the type mismatch goes
away since there's no local variable left.

Thanks!
  Andrea
