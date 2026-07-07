Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4430C343
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435650; cv=none; b=hCR4C88IpjklNybMFlPlwaW/F1C3OW4zfioHJDSK9OPUJj7Jz4RsZV37+y7gzy1C/t9lRRJA79aNgVNtEQUonhP0qbxmnhLqh/FNPAWodTZ/7pfoSn1ES4d4EdiR0B+pISoxcutQ2zURlfFj0w4/Dk+KYhihyZXGJo0vqw21QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435650; c=relaxed/simple;
	bh=nkbeH07ahq6lR43mT21OcufoIF0m1FgGm9Tv0j5qWJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPWDVn1ye+9UA+dWpAPN1CO6Ro56qwRWcnd4+w5KQuAY2E8KbsachqJzAFt68s7HJ43ANGGazMObKUeouEz1MJTJ4nc0YPoms5ZZldfaSV0HNhFW+dQDytB1ei9w+l7fs7nXrLKp8OarThJWInhAgI8PQ9pWN8MspRhdd80FWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4L/Ofsu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwFLQDdu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4L/Ofsu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwFLQDdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFPv6f1DvPzvaf/+BF1GucAu1+JyaOuON0uoWlg9A54=;
	b=G4L/Ofsu6fmMdN/Q54KS8wCVzjS1jSRUrbQPjUBJemtKSsZkyfNhVkhuQ7f8oW1iZ+btWn
	4VnffpLMt00F4I8z1IosW5hg3MZTjKK7C2OBa2JB3nI+GICqNtZNyCKpePcn2Bmpx3NSn7
	wX/QkBzSdxGIgODEZ98Tq2RFlOUMDUw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-2KsL4Aq1PuCDSyZ7lrN1Yw-1; Tue, 07 Jul 2026 10:47:26 -0400
X-MC-Unique: 2KsL4Aq1PuCDSyZ7lrN1Yw-1
X-Mimecast-MFC-AGG-ID: 2KsL4Aq1PuCDSyZ7lrN1Yw_1783435645
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a13e51ee7fso6588724eaf.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435645; x=1784040445; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FFPv6f1DvPzvaf/+BF1GucAu1+JyaOuON0uoWlg9A54=;
        b=VwFLQDduPOLyqJfXuhbeOuvPtjICfjwOPAuO10u3l8dzk0YxRERBOuqDka0oICeipX
         nE/SyAoOO1t/YsVWsKxam67KSNsFli97vIfjtz5jZ1HCl5oZGJDBaDWa1wPpd6xn9sCB
         9YFkoU3ZJmY9gsbpVDAGY7ZmPqWBTOqaXSYm8U5zggJJTao0xYkE8darenTovKEOzNYf
         QcG7WzRWRMtRsVrdlZJ1rKkqasrG0A5jXdXa9QC7Llw1r4zhFtIwQrq4bivU8EAsA7Dv
         1Ivx2ZMJ/wuKbPQkhG5e6j+anfJJ/w/wWUXx6vKzvNxIthb1ZZ3cb2/ZZJDqnsZ9eC06
         inUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435645; x=1784040445;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFPv6f1DvPzvaf/+BF1GucAu1+JyaOuON0uoWlg9A54=;
        b=X+J4/pXpl9d7v/WgEun/wc9UG8B0X1Qms88ZKLsPfpc4S+Pl1DkNz8sL9SpB0o16id
         QJrhbZ/P1e9KFQD6aIHJemR5tQcWH0ilQfxNJgWn6++QP/UYk9a40k9J+DhuT9EHiq4i
         9wnMCeyfw7pGrQBw/504g6tNUFUDw2GpkEmhNB6mjVFoNr13iVfVCd2/bO19IqlBwsmE
         Yj6MEPRUmbsTnj2uOpOQD7u250Y4YIXS0CEhS9rveGMDUX4M6nAr7wSbhDb7i+sdc5zk
         2PXERtehoG5Y/Ta/+V8ezzMWxRlqBfiYg55WsjMVO1yoWrabTnfyW4jyu6wJlNS6t7hH
         cP7w==
X-Forwarded-Encrypted: i=1; AFNElJ8h5YLpMX70Ok84yQx/6NXCY8B0+ioOdu7O3w6f4O1OfpphBW4G34NnF51amAVrZmk8GHrGz7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oEnZ0wZ85RknTfYdcXJr/nCrvMlIxObWlUHJin+vaJS/mx93
	GSjDExwjbmfpdEb8v53YXaLQ7L6eCVmlZAaGaNt9578ogIzHPWYXI7/J7TYErWxKioaB8FlVAJC
	sL4ycdtuDEwQhsEpmY51ZacN1sWDjHZaH2orqqWICRt90jzT42Z8dfgdTyQ==
X-Gm-Gg: AfdE7cm0Q6wBtUO7V4e1SAe3/IQrvZakPyDINd8oLUvxi4DEShI+9dOz9FY07M/oASe
	TbgBf//RiXL541J4RwnDgqlBrg0nRS5zbZbo/Nj90w+4+fBDEcz0ayyxLogqI1hKOPU4rbpDG2Q
	akJEIlT90GZ83bNHBHFIoyJNTdUN+H1LGxyrzJ7etiFp/MAs1Dl7pYUrcLqiJkQQb2hDaCA8D2L
	OYq+FLwVl+0QZIGjyPvr8/ct/BcqZVz8OaMSAL8EbsTiEQCwCM/V5LJtb/6M7ypE0pm7L+5jeD+
	XnoASR6222ZCprbw5zo/TYOUMztTYVlX4bwuKPiYObIjLnHtIg+Ro6donKPoRcs05f0vam9PR9q
	YFN0A+U6C
X-Received: by 2002:a05:6820:4b09:b0:6a1:5ca0:d52d with SMTP id 006d021491bc7-6a35536af6cmr3395667eaf.17.1783435644624;
        Tue, 07 Jul 2026 07:47:24 -0700 (PDT)
X-Received: by 2002:a05:6820:4b09:b0:6a1:5ca0:d52d with SMTP id 006d021491bc7-6a35536af6cmr3395595eaf.17.1783435642165;
        Tue, 07 Jul 2026 07:47:22 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544a1725sm13981552a34.16.2026.07.07.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:47:21 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:47:17 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 1/6] clk: mediatek: mt2712: fix memory leak on module
 removal
Message-ID: <ak0RdSkV71J1_1By@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-2-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-2-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:30PM +0900, Akari Tsuyukusa wrote:
> clk_mt2712_apmixed_probe() in clk-mt2712-apmixedsys.c does not call
> platform_set_drvdata(), but clk_mt2712_apmixed_remove() callback calls
> platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL, which leads to
> calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: c6368ce86435 ("clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module build")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

