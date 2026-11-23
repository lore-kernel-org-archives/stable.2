Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413320;
	b=dnCbq+/fCf94XOQH4Y7f/sOsupupMWPpp8JNKZB21kqya16ANXBYlRnZuTDbX71inWTI
	 YJrX/5nB1us2wFsqCY4J+BtH7mAcyWaN5F/My5hsMe33MWBe9xEhu/aJMNt7TxeJko/l1
	 G164qON/3oFvxB/PQ+7faZ8taJ+q6B9B+Hwg3UvW2vZl3DIT6Ubi6NPwOlErUPIeTAWRX
	 5+2i11hzrMlxNz0bRcoJaF2ehqlNVTtVvZxNamURaEO3EqlZ9iOE8wH/oygWpyjGk3T1W
	 Nyu8m/nRU4KEs0u+Vehv8A2qXTyNN54bP4dgU+8hSAZPOEQR7oexAgUWuwH1ENPZxmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=75MwwDfJskbLcXnBINWfK7mei4WvO5E0Z8Rt9qBeNGU=;
	b=BJAHcdxdEDugFGCLwScA8CRL/Rkx5L3kfVy7gG7HRvZR6cvNvGkceAzvr5hFPQMc5p3m
	 cjk5vOggLgEWHini5TNRJRaEWN7SZklfUTwmU4PXaZZESkJdDUVXVubdQE7J7RETAI7Ko
	 WYkaxVAkqZ99Vm8Pfj5/FtnaZBqYSUSWJ6ihph6Pkr7ga1liLunt2K7r5NVuKIyC7gJHj
	 tGQW3H5p1DYH+88Z1TXywyXwH2nSWA3qTnY+yQiU0/17A0Y+4da/bHf8GINSkwU1knKFY
	 0OuRt3qZHeRqN+ltsLJnhU7atOSdTixSJJMvPwC9ySZ6U4LzmTP2nN34szG4Em0z4Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=uUpK3tkH;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DE606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=uUpK3tkH
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db35e7953so2898563d50.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795413319; x=1796018119; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75MwwDfJskbLcXnBINWfK7mei4WvO5E0Z8Rt9qBeNGU=;
        b=uUpK3tkH/epkS3pb12eC3yHOntdM3YB9np5CxD5jQStj8tiLbmxgeLAXI9Ymg5Vimj
         uDCIx7jwRtyGwuv0vJB9jHuK+QaxKLuQHBXy8zuOxGwZ6UUPRF8bZLoiis8SaVcBpAQx
         rHd+9lbyOIrod65qaHfuQ0tIAtLuhSmRSX+QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413319; x=1796018119;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75MwwDfJskbLcXnBINWfK7mei4WvO5E0Z8Rt9qBeNGU=;
        b=avPWyd/4OdMC8h0Vu8jDs+/6C+dMpmugPAzKTD1WkScpKE/WxWtcdGTwLPb6jN7Jt4
         Cn1aqwu0yqeiI3Krc3RABu1mVwDub/RrV0SXiyW49OKF3bQZjrUUyJbfHkuZcjt+Y5jG
         ESK+kbns/tYaCaiZCDszckE8ieDvAeodCrNDoyUJADabExGREI4b8uXCwluqjkSr+Y66
         Ku/g8cV9ZAb2GSMzfT9jVoQ38RXnQnk4scNLbql++dgnIUVC+sE1lVnfgKUdG0jEiLkG
         roONxqJHvsi5oM8F0VlrM9w6+gCfmW7C6Ef60eJBTo+uqYwKrswUyaQAtH2NTIXcBfCz
         RC+A==
X-Forwarded-Encrypted: i=1; AL+hErG2KiHajjoXCkY7eXsAbTTcP0MYV7dGB8FYSxxpqQSSFZBiLEf9eMmoUQy9UpPUE0QdoOqNGnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cB21JtOvxCuAjV/k8r6AODeQpXj+ZcWW/xTu18bEjTHX0E/wd
	yLJQG47pAP77O9aDcy/2UXPrn38boCQHSI3nwmjh3l7S27QOOsyke2MikRUqiJmv3rU=
X-Gm-Gg: AZFdTZcQZEgPG/RwH4ykP6CevdSzwG5WY64aST8V+4WDVA+LrHwEYd+x0q/I5ou00eK
	2MFLdWiaW1G8349hALhY8AunGZmItdMrCrdpNOMG8bJMuTkt7obg5xHAK5usUiwmVSB3UMrZFws
	nZQZt5bGalBDbBfNsm91Mgey0vxfyH11v67sk1eqAn9S4bzaXHhYD+pZ6wqHEW++hbrSGgfNeaj
	asIZDEfkk+9MFJCmDS8HmOulEHglW4/cdqoLOREFDf6OMRsq6pQodJMr4OZJJyKfjkoYB9SG+Vd
	jZbEV+FvD1iXFdTFb9+92+19S3d42qlekuPgvACoda6ctAR+LdT+4Nm3FNLQeCZiT+3hG+i2D1V
	GFH1WC0ZTVn/WFSppxIHtsCP7OIMOZqi2ppYf7+BFyOzbad3tbyfbg4WBWOx6JCwz74T6TbyPsD
	Tq0eoDwoRvFeX3D6/CrFMPCVIJNNpNg4i7f9fsBpCFwA2ehaAXDgLk2e78w0ShtqIi38fNwemEB
	vIge8GoL+UhALu85HjRHVCpJy1g+qkrdWUwLZydwtyVfn2wz9CJ4t7XLwCZjztqycRwfH+RRQ8D
	kne+7OFYlN/nCKqN9F7moqu9qxfkTdEzzh1FPUfFcfnnC9KG4+FrE+jjOg4wflMZG8w5Z/1X1OY
	ipaTYZM3JLXFOSWfiD62nlRUHA70LDZxz3u9M1pBjC2TQ5iwiVIW9um5/03kLeaQSFRBhJqO4aU
	xvWOpqbsMQj0lUpQynsHOhFRoHFsVrmjp00lDstlakW2IYcQbKl9XRlTRBYUSLsv5qa3hW517kH
	15F4++s6K1QrLr/YM+9lBhOEsccGEBk+ObsuMRrGS85Zd8Is8S6L95yAgwBqAgkvQ==
X-Received: by 2002:a05:690e:1905:b0:67b:e67a:da38 with SMTP id 956f58d0204a3-67df4423620mr3279582d50.21.1795413319184;
        Sun, 22 Nov 2026 21:55:19 -0800 (PST)
Received: from [172.20.0.3] (static-host-74-205-137-217.epbinternet.com. [74.205.137.217])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df30e4407sm5198997d50.0.2026.11.22.21.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:55:18 -0800 (PST)
Date: Sun, 22 Nov 2026 21:55:15 -0800
From: Chris Down <chris@chrisdown.name>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Kairui Song <kasong@tencent.com>,
	linux-mm@kvack.org, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] mm/list_lru: fix potential infinite loop on xa node
	allocation failure
In-Reply-To: <20261122031143.3639941-1-songmuchun@bytedance.com>
References: <20261122031143.3639941-1-songmuchun@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <awPVQ3aJxojMSEhb@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Muchun,

Thanks, I reproduced the RCU stall by injecting failures into the xa_node
allocations for an unpopulated ancestor while reading a file from a new
nested cgroup. With this patch the stall goes away.

Given that:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
