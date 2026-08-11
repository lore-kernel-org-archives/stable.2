Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2E38E8CB
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415302; cv=none; b=fmdJgzdv7uh0+bSAXVIMQxc5/zDqiENBx8lRYxwzFy2ePkb7OxyEMLzsPrVxa1tyDbKJunnxSybzgq28TVHwHrbOzS+B0Ws3NDR9bmxO2pfxFlBZ24PB/pp2ICpoth0jW4rzSSG99WyCYIdSE55VCGFkuNbk6BFjLKOI3FtEHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415302; c=relaxed/simple;
	bh=EzPzl+l9Ufho5GNxK3W3JivUyRtZrJP80YSgfAHv/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FukuQGbFuxclhlvcjNJuVBaWooYFmRePvzNkLq7TLMiwXbO8npexzB8GEyrMCJPBtfH5gIeo75hn11xpivpqPtBb27eBaLWTCxxHcmACH9LoCZwgDsxAYe3CuD5WIqe73UFrXGUqRR0HsFDgrBEjyqC5PpJKbh6p2xYpVsiUuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NT+QfLh6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NT+QfLh6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3343561b3a.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786415300; x=1787020100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gi+z0Sfoxf7HH2fFrc33xdgvFQt641flXsi+XK17J90=;
        b=NT+QfLh6YQG8JWFal7zryHQHtHLVaRwb7hHDfC0bYe/r1lRENzMe3SJt/9pOUuqTnC
         /JOpNhtdbNNerv+3fQj35Gzg/a2oUGZddGcM4OEzVaBNWoo1KBrv29ZcQU440Jk8pw+b
         UObtjXScNCr7YqAER1zdT9b5zFEuHX9RmU0AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415300; x=1787020100;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gi+z0Sfoxf7HH2fFrc33xdgvFQt641flXsi+XK17J90=;
        b=Vw7GGs3d3LdygekTY9toUxKrZZ/h6E9in7zKfSE8FDSo3xlkwq983eUkdcD35CbdJQ
         9KqP6ZCm5rEVoYvIVdHpSl3NwaeWPFMxzE+a65UUl5t+ajTPWc/6HyptA58MjcPjWJna
         gWKpyN/hKeX3Q4udCTDBs/c2QAdRUX2P5sY2HQLzC1ZVu2gGSBpStT72CHCeghKb9WVX
         28Dm9hEuQ8U81iPkUHvik7lQHjdRX47LYXdubcF2QMFPA4r5G/d16GpRYUwu6smcZo2Y
         L4XXAOWIonwQ2kL04XWLaFvdvrVABSNbHjB4ERxJS8sEuyW7x2gR2JEYklK2H3GCN+kT
         IWWw==
X-Forwarded-Encrypted: i=1; AHgh+Rpwp7nTgCa0JT7352CZHQZnqyxrza16uD7wJqF+3vifHZ/AVxjqYoAllNuW0vaYqC1SKQyRpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WectMi3bGSSYSe8g6tHg9CbvYF+RpCNilaiGkQB6w8po5qU4
	LMj808esKnlRgCtCDYLwVs3mgZKQZ7PfZZMWs5eYZSraNJ1QL4t0UAakrhgTaq/Wdw==
X-Gm-Gg: AR+sD134AckV3yGyWrh7MXmmS8Ebcw4CqANARTz7VHewg4a53Bqd5lU4/Z7UqEVOR/T
	vswgoA+Qtj4ol8FhwqmCH4naq6ayWVOriYMrLRHt8Lrq9RWHi5nDPMfmWIUq1ulfF3cFhofJkfo
	4BVL8NPGolE+06hRAN94dGonA31ouTapf1fDHsQIOlsePHrDwjNY7AIavV+qxO6TTk1qlxkk1X1
	/fA2+4fFuJGRrHO4zgtVLVQimFBR0YKpcWFuJdhuVBP4MILc9u2prXTAW734MQnpx2FkgIVdNly
	LkNo0o9phqkM72TxU3y+Yvt+Ilvil0VF1sWj+qDNx65N7Hs04ILNbJdJnNUDfYRN635mCrZfZPt
	p1b4Lz5cnw8Esfl2PvI/cWqHRMLGxDvlWaEWSINsi8A8Hr5voKF8JUoAh8GsVZdVb/gJsgGM3m2
	eTG+cBc2chJJs/AC7jBPnrlS+zEL/faQwxVCI75yqhUwA5t3tm3cymNjXXJ/XaqK6672r0nN5xc
	aDQTFmyyj+c2EBijBCP1YuUOxTVUQ==
X-Received: by 2002:a05:6a00:2394:b0:848:354f:4f8f with SMTP id d2e1a72fcca58-84f5e0688cfmr29315940b3a.22.1786415299781;
        Mon, 10 Aug 2026 19:28:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ddfb:e755:8f7f:81af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f192sm4499377b3a.30.2026.08.10.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:28:19 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:28:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] zsmalloc: account for handle size in class lookup
Message-ID: <anqIohlUBvDhlwt-@google.com>
References: <20260809115518.3791787-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809115518.3791787-1-xialonglong2025@163.com>

On (26/08/09 19:55), Longlong Xia wrote:
> zs_lookup_class_index() lets zram recompression decide whether a newly
> compressed object would use a smaller size class. It currently classifies
> the payload size directly, while zs_malloc() adds ZS_HANDLE_SIZE before
> selecting the class.
> 
> This makes lookup disagree with allocation near size-class boundaries.
> With 4 KiB pages, CONFIG_ZSMALLOC_CHAIN_SIZE=8, and 64-bit handles, a
> 1025-to-1024-byte recompression appears to move from class 64 to class 62
> although both allocations use class 64. Conversely, a 1049-to-1025-byte
> recompression appears to stay in class 64 although the allocations move
> from class 65 to class 64.
> 
> As a result, zram can accept replacements with no allocation benefit or
> reject ones that would save memory, potentially marking the object
> incompressible.
> 
> Factor size-class selection into lookup_size_class(), account for the
> handle there, and use the helper for both lookup and allocation.
> 
> Fixes: 7c2af309abd2 ("zram: add size class equals check into recompression")
> Assisted-by: Codex:gpt-5.6-sol
> Cc: stable@vger.kernel.org
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
