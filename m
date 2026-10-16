Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3424DD3AB
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163924; cv=none; b=B3bC+Ziun7A3CYPuC5J4fJLs0oecBEgObQ+BpLCClvEulkJTRFLdBWjfEjGIKbolUHHNrEmCVbVeW0EoEItv1X4GKr0L9tKMWjqItwKZUIHLVV705khBv2MQl5xp+rTfVL65K6nSYaYLRSZCdNSeyR67Ev9/EoMn7XXiQHjkwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163924; c=relaxed/simple;
	bh=gTsOfT7qc4+y/R1b+Q3dOr5vhFSgpJC8pEs2pNorJ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaeOPui5aLMbda99rUD/+247Ek5Dlp5SKo85xRCLClrQQ5UPnfOnYbY8tkYV+cqig8rR34MUbxofU3PoAQgTEu2/1Ut11/vfVu32BYZViX83CCuTIFvGBmGuXKYCcrtWqF4efHBPpP2i36svzjNnRtSMZ8HdVVzVB3p8h/jXPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I8paqOTn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I8paqOTn"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917c04630c2so1069246d6.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792163922; x=1792768722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gTsOfT7qc4+y/R1b+Q3dOr5vhFSgpJC8pEs2pNorJ7A=;
        b=I8paqOTnnBFl4CkOn5U2tiES1BNMEhJ9AhGndoNW6nis4nPUdDSdPf+KFX41YXHqEX
         PHEu+27JD5JaY2CtLXAlUvIL7At5OVKogRdkeOqcQqIAuuYTxulfUoLUU148ys8nEvHv
         zh6rZ2bLk+Z78gGyJPZPfDXTrL1vgSl9dr+zFSLToUp9FpCdsJueLcMMsmdy3K438/wx
         06jj+HxmusbDb/dflHBzRuXq6HWFKD7jdSs+dMWn/qCSsxoi5N3IaTqIScZdbw4Fvj5T
         qCbeT443JGf+uDJJZrMd2nBB7hFJY9b7F9QO6muUFZLVU7g6YPPLoGvlLSMQKdyVREgG
         DjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163922; x=1792768722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTsOfT7qc4+y/R1b+Q3dOr5vhFSgpJC8pEs2pNorJ7A=;
        b=ZtD0YQ2X3WhzUK53ErZEuiyLjHIR6yHup/f4pUwCNMsWefA9Ymm+LdsoYHmM18gC+D
         xSS+Hz158SaYZ9mPRDXYDt2cvEcJ8Dxl8oqdoEzsSk0t73HTyk8k2BWDvAp/QZaw13YH
         ARxAYNITARxhsd/KnPNv+JHniYZw6o2dJwyB4t+QS5dmTuqBQJKNWNJrtaaw4xffbaCD
         2CeL/zc/ogfL4pTzkJcveXEDnSm8evanQRQugOmNQDHw/J976DihGFI2af+UZ2O7ncv3
         UwTTIW1cDYL8+2GGtlqqVWP01OGkr/dmieCR4QD7rRr03NV7id4N3zjDVuA8OK0TR0Py
         GoNw==
X-Forwarded-Encrypted: i=1; AKwUvBxNNtYEKJ/x2pM2d07sZwz4EYKR2j7VSa+M/IhXbzNGe/6ObWJjmNU6/NjAlcJXfsQxT8PRKSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6MUxwcmaFPE9MnpF6KMLyuGOTjsZqv4ZY2oZ1/FxxyAJH+JLA
	O6Yz2+ctupm8t4PhkYdOVXBqIR1bgl+DXvASNb+Z3eE65SY4kiMuuCmog+PYWKFwJ40=
X-Gm-Gg: AYBFou1FG0L5zNafNcjiAuJNkWftzb75m1iiW17bbh9s3iPr7qdwVfey200sd85VqrL
	WlZ+r3ytbFINC79ZBBzpo81vStpKfVv9XvCggU1p9CBOIkvKef3Ly63z+AauhGYjoEEw/MZ1z2s
	atj2nyqtZGXwNsaaPE5ET1zI6bydwU9Ts/CqyFrD85hMaDqe9fUA2jhbPH6WFncD7IdbwA0qj4W
	jqPE+6Pe6+2MeQ1almO7y9JkZ4gIsm3DjuUCkA5umh/C/BL7o3tK/n/hc41yp5wwta+18jtgJb1
	Qemc1sdt44mVEcs4Ta6jizuWbR+10BoOyrYClT1tN8uKwEG1tuBR7xDA8NRch5XdJ5YEpea6AK7
	rxsj4bkcviLfo9puMa/NTvdW0Z9xwDmqUgT73zRL/t2AZ9qVpMXRoEW5MiDNcK0N6JpDbjdXVyC
	MDGpwGuI6CJALZkt8ev4Ull8wsq2DhEva+fcswzgj82SBEEmLcrTBcfbK0y0g3gtmzG4XIG9Yzy
	BsjjUsdWmHvrOnTzYR2hmfPMqX8+OvVRB+vSTJXg94JW2i0F5kb3Mg=
X-Received: by 2002:a05:6214:202c:b0:90c:b843:d679 with SMTP id 6a1803df08f44-91bdf063686mr5556436d6.29.1792163921793;
        Fri, 16 Oct 2026 08:18:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbade61csm24949136d6.26.2026.10.16.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:18:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:18:39 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, 
	brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, mgorman@techsingularity.net, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: validate zonelist slots against
 concurrent rebuilds
Message-ID: <atJAIfZ55x68Ft8p@gourry-fedora-PF4VCD3F>
References: <20261015210539.3243563-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015210539.3243563-1-gourry@gourry.net>

On Thu, Oct 15, 2026 at 05:05:39PM -0400, Gregory Price (Meta) wrote:
> Onlining the first block of a zone (e.g. via virtio-mem or a DIMM)
> rebuilds every node's zonelists in place. An allocation in flight can
> then be served from a zone it never asked for: a GFP_KERNEL allocation
> can get a page from ZONE_MOVABLE.
>

Sashiko pointed out some other race conditions (related, different),
i'm going to repackage this one with those fixes because they're likely
to conflict and they'll all want to be backported together.

~Gregory
