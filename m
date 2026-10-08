Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9C412BF8
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458338; cv=none; b=QJ8xhjQSfZqL+sQFQ2N3iCvZ8YJ4f2fdQqmCjP+YFXhGlwC0AC6yBumyxy35nlaol+rA9ComSJGwDpogPFC6+ptCTrqnqUxO4WhZEI3uUy1Ay7pcDi50naZymjUjVEn2aN4weoA47IpWBpnZ3vuramSb/adLy3ftPmcFnWWQzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458338; c=relaxed/simple;
	bh=EExW1k94qxqJzDLBNcXAe1CRJKzbkc8M/lq4PoGuabA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=CI64FPDVWVeKhn80C12vFiaPj5v5fUm6eHlA+Q052RnyjSahv3/KBj0+3ERgHdH2tr0HxS4Z2ChpnvW25xaWWqwEM4AgNqpPNPRueEeDXhax71IRNEMVUZJuUf4tE5GgZOZyE6BEa5sjLCUGY9GnyHGO20mImy95vCuEJEGcZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH1GPtz6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH1GPtz6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e61f017091so7510075ad.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791458337; x=1792063137; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EExW1k94qxqJzDLBNcXAe1CRJKzbkc8M/lq4PoGuabA=;
        b=GH1GPtz6Cy3YRBbU/PvREeBQXKlOijchz1AA7q4CIFlO0ShwXCYcX8NKTT0Y6DWeo8
         nDW5OXSxEeOS1QvHD8PtBdYcv1Qo/Zgy/ZZSVnuItRxFKjbOvpBpqd1XQoTeerSglRZV
         swaa+2DDJhNq1d49Kx6uDWiw9Xmtm60aBayPIKLmzLIv0fEBtBOl6MPdAlbVR06iSvl4
         4zr+UsueseiJ3u4eQU+JQf5XHRsLJPNH4hs1/hp3bs4QHtGffRXpC9mRgCTf/HQLUGDQ
         mbFEv0lgsWTyllcUhP+MLmY/Q4xn2O6WXmWVbZvbi9p7MWmxmbmXKJcRHAI5T8xaE/tC
         XdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458337; x=1792063137;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EExW1k94qxqJzDLBNcXAe1CRJKzbkc8M/lq4PoGuabA=;
        b=IeqEOtEGDFYfc4NPZXSnUCrWg8gfACIsb8LHNfw3WW51B+2gkAVliZ9TCu52aWyh9/
         TdpcrdEMoRXn04C5WytlNIwoMHRuvJj4gZY527/AQVCViEXTRYI05Br7nVXNvPHq6Ofk
         Cvb/Sq7ucxamfr5f3YXc+T/Zhhe1iPu99irVo96lcEnN5Y9TY9ieuQCTJ7/BfnGWDVpn
         3AUoQmRBmjd8jJHZLZmO79Y1NOGN8jrOCW/3VMVX/wX1KDxiBDlDDXYkHdxt4deijUbr
         PVmTIpOMpruPIW2zJ3/iY0oK4UoH/lcRsaFGxRqc1nQgE6Pa3Q82arYMu4bNHVqnHCZ2
         I7pg==
X-Forwarded-Encrypted: i=1; AKwUvBz4oCKzovGqi4XUKaZY2OPbKINcT4+gZ2i9waenynRthp+5SV8tG/RytPz4sxbjUd1xs2VALIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKupgTJsD7T8guwYQPRnV6dX2xQyiykL+QuEzpxKDd/DMYWTZ8m
	9WrmcpVT11EAYGa6a7ysjgvOH05DEeik9onxBkIOgHj0I04qERN+6qqG
X-Gm-Gg: AYBFou0gsi7Oq8tH6XpyWB+3fFT3sx+8CRYe83rBYCEJZT6AP2trnjEohXD5kTDTJxt
	dD0sYTnKKfhO6WIgD6l+hJhvok/dD+DnHctbuLgH/ZP/OPAqBUv3yAP0Hc5xrbuOFTFH57Z2brW
	Ii94KyBBDDbDnxTui1yzdzbu7KCdpNdOvCorIO/FYIu7Mdwpk/Pl4djWOpTXrRft4/RF5wYsNqL
	zUA4eD9HMmoo2SS1HX6Z3esnWqC+XgkUJGGQTml7Viqg+kr8dGUFhmY/oksffAP/yu+BIdylQAA
	KGIZg9qHVvFi//6GrApmFC2jrCxWyjj4c1kv+q+N4XMLwDrShTPevlDHI/05SW7BBkjC1/tW+W7
	kVLqs0FEBrzpZ47FwDaXQKDhWyZxeP4t+GN8XvrAeAmnm7sY/7ct76bCfbx/RGxINBuG/mOB1iU
	cQKIkBj3wH9EJ8kF0ot4W2zthEE378SVlaJ5rYyB4qLr1giGWUBiaodTREFTDXUWU+AijnDg==
X-Received: by 2002:a17:903:2cd:b0:2e5:cf8c:633d with SMTP id d9443c01a7336-2e6004e72dfmr41869325ad.34.1791458336730;
        Thu, 08 Oct 2026 04:18:56 -0700 (PDT)
Received: from [127.0.0.1] ([58.186.69.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482d316sm22914955ad.49.2026.10.08.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:18:55 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] netfilter: nft_set_pipapo: skip transaction elements during GC
Date: Thu, 08 Oct 2026 18:18:51 +0700
Message-ID: <179145833177.61895.7787702708373982202@gmail.com>
In-Reply-To: <20261007182057.332512-1-dungvn2345@gmail.com>
References: <20261007182057.332512-1-dungvn2345@gmail.com>

Hi Pablo, Florian,

Thanks for the clarification and review.

Indeed, unlike nft_set_rbtree where interval end elements do not have a timeout
extension, pipapo elements track their own timeouts individually. A newly inserted
element cannot be expired during the commit window under valid timeouts.

Please disregard this patch. Apologies for the noise.

Thanks,
Bui Viet Dung
