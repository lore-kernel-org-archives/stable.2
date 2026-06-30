Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3840E8D9
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823376; cv=none; b=A1ENqCW7PQHYQKDMBsymyyL+aCIkicrO4OGvpkmrXoYBbKeIzBGcwT4D7jtazf+a/SYzZK4QBE7Hcklcgus7M3BWWsGDaiZtpvI6/Hz4xfcJDDv4vmU9NLSXoVqhtI7x4QXcK4MsYzuDnRNaF6ZZrYHkE48qKj5oA1wnGCqqe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823376; c=relaxed/simple;
	bh=QWPvsZn8DT0/Vu+hfGGOncPmT+V2i9T+xJS7wbHqZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLkMmLs4M6ftATvfpGelnr9tHVsa/v6N/JUACVJDEK69tJaFRi3olTYrOfz4K4AQC6ZxvJjFmsVNJp+nBWk5dZ4X3TuzVlJ5+W6p+bAGmcuHRT4B0gqe1OFh8wAxtAYTQPcNpzEMvUKF/X4yPZH0zwxLvJKfRI5MCUSja4rtSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AQyU9Svc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AQyU9Svc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50c5d14cso136145185a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823374; x=1783428174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
        b=AQyU9SvcetA82WLkeROen+k6W0F5e3l9/8IL757VdeHfqC5l/eTg5b69ecvU7K+/Zk
         vX66jljRtZLrJV4TCgrpL5ZSb8/fooY7Tu4xVHTBP5AMm/3+CMCqV3nsZ9YtiFvTsdYa
         5mjDednvi2WYt2+uFBSZ7p1AMa98HBI8gmlN+PTnP7Sk2ovzsLwtzTtDf6FS53eqP8ZO
         Y4PNEd8K3+mbp0NqoAVJ4pTi1V44AOlwaWbStPtz65hEl8e+S0ecQmq8ZEpLXkVPMmZ3
         qIEb/GNUWmMHuyrhe92sozLhDWtcKwWpjWvIJsJLxUHoSvBqhNa9xER0ylnst6ppdGz1
         RChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823374; x=1783428174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
        b=nfiBQp9pKaHLNvX3hfAq0GaqSdZXyE5C06FTUq8gglqbvNa72ShH7+SguzbppT+JKm
         H6rE5eNVrHLXJ5hN73meAbvvhs5TN/lNrUvvAZyjlmMoaBtxVRXR23ObuqcM8XTH7gJS
         WFfpZvm1wqE6ToShRzAhiySN0tO+chRGpsV5SA6p6ts86urMfP8iDuHs6QlAuksQZ17+
         fQ7GgBpoCp2DyTXCXQ8CB7x6A32zjHPW5UYjRRSGIfmtDRSL10XLKc+L8J9/mG8WQLwH
         +6U59uNyhRC/6wsmv88SBxu7TTXGiC2fcZ9M+yvt0ynbQlHbpnh+OWs2VO958ElunPnh
         7uFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kv1TYFRQRrf5fg7Usc3YszYQ1JiEAnknSoxM1aoKi/YqK59/THb45TxzohefM+HtBkIWuZCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0CCoKjqXDjJtZop5LB8/9hsoUtHUf1qCtsxqlDfZbpjjKNaQ
	2A5X2khtHL25WuS2U1imFfwRzlJFxBva+ndqPOZzEMDlzfr27MpdNTQVfcGOWZ4TWPw=
X-Gm-Gg: AfdE7ckbaBKhCTf0QpYpwPM2P9+o1WfYeQB0SGTei5if/dtADld4OAiCdW/o630ufqe
	xv64yGSzbLV81oqybGtzAPiU1rdf2DVDjV35VgjL59Gd3oSPXRgPX4BOJbo9lyC7O8W2rUoyTmD
	R4ZqGvpD5TTvD4nUxVdDYqk6804x9QDVBiMciggB1rqzQdcencAenrGjWZ1UyWQ0+504+uGxKzK
	YVLTYZeJYw++de6GmK224+f6fLgBoclPvJzqx45+y/KuvNbsEr6EvhwcPDS8w9aIjEkr75bHvfi
	+wCSt83iEPvpAy3MVhE3hCVj6evDG0PhCmHcwx+pnUjRAVyy8EvdgyFfnWuhc0b/H6dL16dLjoU
	MfGLYG+PF1/Y1WjS7UnlnYuY95YmJVRNRKRTbgP2tKEvpuPOita9WNsuMDZPSpGlR8wgDMYicin
	Sxq8attA6f8Lsh4OhRXHioEExER9J25pnMgOQSvFDF/Dgv/1gm6583QrC3dcuCwMS+gZk=
X-Received: by 2002:a05:620a:8391:b0:92e:4867:95af with SMTP id af79cd13be357-92e62af0f9amr515174185a.73.1782823374078;
        Tue, 30 Jun 2026 05:42:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm226634685a.39.2026.06.30.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXng-00000001qgI-3Vni;
	Tue, 30 Jun 2026 09:42:52 -0300
Date: Tue, 30 Jun 2026 09:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pranjal Shrivastava <praan@google.com>, David Hu <xuehaohu@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, kpberry@google.com, chriscli@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630124252.GD7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
 <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623235350.6540eaa2@pumpkin>

On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:

> > If we restrict incoming dmabuf transfers to fit within VFS-centric 
> > limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> > it to manage a significantly higher number of memory registrations. By 
> > cleanly splitting these massive contiguous device buffers into 
> > page-aligned SGL entries, we directly improve the efficiency of P2P 
> > transfers and memory registration.
> 
> But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
> a lot of io) when the quotient is always 1.
> Splitting into 2G chunks is a lot cheaper.

Doesn't matter this isn't fast path stuff. It is better to use fewer
SGL entries, IHMO.

> > Since this change doesn't seem to have a negative impact on standard file
> > I/O or break existing VFS constraints, I'm curious why we shouldn't 
> > support splitting these >4GB P2P transfers? Am I missing something?
> 
> I was only wondering whether it was needed...
> It does bring up the question of why the >4GB transfers even need splitting.
> But that is another question.

SGL can only store an unsigned int size, so any large physical range
has to be split down.

rdma now a days has code to process the sgl and restore back the > 4G
sizes since mode RDMA HW can accept that.

commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
Author: Michael Margolin <mrgolin@amazon.com>
Date:   Mon Feb 17 14:16:23 2025 +0000

    RDMA/core: Fix best page size finding when it can cross SG entries
    
So whatever this produces needs to be compatible with that to undo it.

Jason
