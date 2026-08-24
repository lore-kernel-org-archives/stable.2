Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13845C6F6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587243; cv=none; b=sD8AQG9dmFbn2+5uKtqsjVWDtDVW4mL++6mxE8kbFh5YbvIm4a8egO31nxAU2SsQZuXk2hJFOVvYWV5+low3sG69LgapzInyK3OZfPrITZ6oE6kU0nx1XFERY/lmp77oBC4rZdkqE/PBFRdwRRHSHdU5M2tIG4gkXhTNhsAYV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587243; c=relaxed/simple;
	bh=JDnNCm8POwOEh9r9Zuxavtl0AknyWidZ8VrOxDpaR+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9KwVdQJ9/Lgp+qxyeBz1Emnk5NspJll33spPmFWAcfGGaNYugggg8TKw0EX47DvdM6ggRmu3HhvWPz2PrHYep2NxIKBqhlBmgjCka0YGg0HAFHsOSxWizyoKX7NzqDXTGr4UYMBx2fb98o1SpfCcPXof62RQhg99h/1Bhnvdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9syJETW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR6wtOqY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9syJETW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR6wtOqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787587240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hh+S6BT+/ZJJa40lL1O++OyyII1KUrPxAo2YLD9DsQ=;
	b=h9syJETWzi18gQ7VfX5vAJ0UpI30n2qSz0Pwpolt3W43kDIXM5U90VRIJIpEquiT0EuU2J
	kFeklVHXAVsKz/UvBH2Z400Qc1y6tPaJbXsgfm48WRIlHdWDiVHw3deUUj8iZUH01d1uyz
	eZkNEQ+f51VkRyDL8kMEB6V7BMxSeLI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Iwcu6cc3Pz659XzhgikNPA-1; Mon, 24 Aug 2026 12:00:38 -0400
X-MC-Unique: Iwcu6cc3Pz659XzhgikNPA-1
X-Mimecast-MFC-AGG-ID: Iwcu6cc3Pz659XzhgikNPA_1787587238
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494527488so629114185a.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787587238; x=1788192038; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1hh+S6BT+/ZJJa40lL1O++OyyII1KUrPxAo2YLD9DsQ=;
        b=FR6wtOqYdVNrQDfHMo0Jo4uZZKRSu8QBdnoHPKHj7fFs4aqEQkuSViCpvqQ5N50rFi
         ZWlefCp/p+53Wiu58EZhmQM+LMdtxlkeHhQss5PsnD7mRRkpc4mOJlZSi+2QsTriV683
         KTeaSZSSiqDIj4penZAvG8rx4P4lyi4Axw6ERvfSWo7mMdy9bvXLZI0WtB+3KwZunYvK
         OBJ5/PK4sz1Ahpx+ZsHSiZBYX2VzDw1WEgpJN2zGtPRKNiB4N06qNFDlTr/bAUB30FXa
         KCISmM3Jpx79t1rpAtnkzAq83WjwEsw447UrHp9RtmRy+//ShDm7VMBlXCSLLC9bTfdt
         QnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587238; x=1788192038;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hh+S6BT+/ZJJa40lL1O++OyyII1KUrPxAo2YLD9DsQ=;
        b=n3GZVGK6M9MESbGd18+omTidPVubQ2+MeDAaKLzcACc6AzgcpiCBNfuepGEUQPtwvZ
         JRXa+C6rlGWWcWMCbyrnkNJUK016oiJy2AKa7TaUMnJCcKJ9DUku8YLrD5aQchCh0IQB
         FlUB4Ujnk1lBT/1SVb2BUhf6CmmwBm7a7ywmiXbOkYZti0vt3ta0qCB1W0jfQrdeZSSC
         ZD7rBkeW9N0vNruVh2BvXMviD6eo8a5hDlN8TNYynTYY3IJxvDYKQaUpyMF/o5X2IHzw
         oailaugSK3zkbl8VRhLK2xgfOzIWTPrVllIBWNtq45D521mpBLr4N0+foYBtSmrydJHp
         EVOA==
X-Forwarded-Encrypted: i=1; AHgh+RpMEx6c37QmPg5S/wXB8DiEY7HBcRaRyWxuHJjnGSupqKVuMSUTGVbHBAypQVvzyTqF45yF+/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mgj9NZA/zizaCAbahEqhsUR7DGgubdQwUEdsDm3rWO0cbRJFTD
	S81WwiymIfni2Ut8ERqkTyxWjh0zACS1VHGK3SZZkcmr94mlwDxJsE/2VK6DEHxI5BFpzCu34sV
	vR3ioa8KAvnsDxtNPiS+YW0RhxOD9Kn5hC3u3DyxntkO1KrD2/gEFV63KmQ==
X-Gm-Gg: AR+sD12U/DERZf+zMa946txIOi+uBd2qbjr5b7OwqXLP5MmvuSvUR7Ng7AbsbTkTbic
	w73gTqY4FDwWEQTzIRkYl+AlNYgaR+YzXotD+ZqaRz0w2tlm05jqBQpl0YWGW9CI+wijLcvbr33
	TTz6breFMaYYpOF8Co2aLVzatz2lE/Ii0bPJhrF+QhaAzW+khiWb+5Vx73QYKs7E7ZqQM1WV2Gr
	0hbtVqzWq14iYlt7QHHl7oXUZTeMH7Ikiv56n418Szq7csYpW5YehjU1fiWgtgwHtuupPyk0XWp
	zE9b6QErMyy9ocj98BBIiFhkgFdgE+a9aXRkB+4T+WZ1szOKTBVFZbGCcIoViJRmNA/THkuAcb8
	PgV5+swwDfwu3H0hIOwLosq112+jLu7CQ76g=
X-Received: by 2002:a05:620a:c55:b0:914:afc1:c66d with SMTP id af79cd13be357-9373945a4dfmr2575002685a.11.1787587237600;
        Mon, 24 Aug 2026 09:00:37 -0700 (PDT)
X-Received: by 2002:a05:620a:c55:b0:914:afc1:c66d with SMTP id af79cd13be357-9373945a4dfmr2574985285a.11.1787587237031;
        Mon, 24 Aug 2026 09:00:37 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749d9531fsm532494885a.24.2026.08.24.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:00:36 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:00:34 -0400
From: Brian Masney <bmasney@redhat.com>
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: mstar: msc313-mpll: fix off-by-one in clock
 array allocation
Message-ID: <aoxqosHN8sqiR_XC@redhat.com>
References: <67ec3261-9f3d-4dcc-b916-19dc8be56a6e@web.de>
 <20260824142800.3497263-1-hanzhijian1991@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824142800.3497263-1-hanzhijian1991@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Mon, Aug 24, 2026 at 10:28:00PM +0800, hanzhijian wrote:
> The hws array of mpll->clk_data is allocated with struct_size() using
> ARRAY_SIZE(output_dividers) as the element count, giving it 7 elements.
> But the probe function stores the MPLL clock at hws[0] and one
> fixed-factor clock for each output divider at hws[i + 1] for i in
> [0, ARRAY_SIZE(output_dividers)), writing 8 elements in total.  The
> final write to hws[7] is past the end of the allocation.
> 
> clk_data->num is also set to NUMOUTPUTS (8), so the clock framework
> reads hws[0..7], again accessing hws[7] out of bounds.
> 
> Use NUMOUTPUTS as the element count so the allocation matches the
> number of clocks actually stored and exposed.
> 
> Found by smatch:
>   drivers/clk/mstar/clk-msc313-mpll.c:134 msc313_mpll_probe()
>   error: buffer overflow 'mpll->clk_data->hws' 7 <= 7
> 
> Fixes: bef7a78da716 ("clk: mstar: MStar/SigmaStar MPLL driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

