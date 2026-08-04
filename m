Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2E43C7B1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832898; cv=none; b=X2PATQbRx4cbRVJRrwRIDZPOOCf49WtgNvWk+HxVpVx2UaDMjWCeIEz1tOgw29Vqe4LdWmHBbp2CZJCNFHji/IPWzu5F7vatk4pgBqRcHDwE87Hsf6NTvF9K7hxW9Txz2j74eVC2+jns6zvG6T24t30QCbJU853CwwiDCkZcHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832898; c=relaxed/simple;
	bh=9gSqiJz6XGNwmera6N1NagiFzsXO1G1ZbBb0iBzg/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKAzji4OyC4V+U5sd2gPwvTb4jDo/udMhYDDPHuwGE6mSjlikO64LIJQi9A9TmYTw8EW9L96zx+N4A2lWK0FwtRR0Xy8Uwop62LmgKAL2V8zK3N97LXnlsh3tGVGuNwEwfpvJRcHc8of5QiDr56cz+G/EVwcAfdEQo3T6qLQhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XdetY4/d; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdetY4/d"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3933291b3a.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832893; x=1786437693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BFRFRfJMZ4b6gvD/HiRAMl7FYBOFgGlyncLVS5iH/pU=;
        b=XdetY4/dzhR+Hegtgo6unZCw5OMEtGapAd7KcYyJHKKJTZNTh75bTz1Qyu8Us57FSI
         Sbm36cLD1+MjLz/FdbfEl2iS3emI7taKWUGFPeoXEd2oVAQUctV/XpERCmLCIYMdMQJw
         185p3tMRsCV0ABAVw0b/xuQ8QBU4anDNT1kpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832893; x=1786437693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFRFRfJMZ4b6gvD/HiRAMl7FYBOFgGlyncLVS5iH/pU=;
        b=G/VJS20gQHHnX/9vTeRX8w55iNG7QnDTD+wwgH7QTJPv5vQEBejnrpPexw4ou1SnQi
         WsfKpYy5jZqVRfQgV2VMqfNfe0OeFZukP0+bk6f9uIO7m2cuJ/qf2mwGqQGzGbYWTZP+
         y8lO42xMBI5+GH1d+e1kh/2KZK4ofgxK1zmBriY2gVgy0q00yxaNdTN+yU/DHJl3ze/a
         5fxjH0n/+wAp29QPa67DFSFqj1LoJzF3papUWzEQav0cM3pXOJXLriRqptT9NO82OwkQ
         BMDzlBYGjG6gjJN5HgwP7cuZQovADWD+wAUuHjEH8Az40ABw+/Ovdyr+MQQG9uOyEdwV
         MYnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTXRSoNskjdnzD6So4LYjuaznZTzIwp9l8IVngJKPj94y6kffFMhvHlyUNcr7v+NQ91ktCrag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcVAk3GsGWqa7kqL+QcXzf1a2sxbY/ltjOBvd3sFY8plaTlQl
	H8PFa2GS3c9XmT14abP/mqYUraQY0HjV3LSkiQLX12b0GSK7m+5sk5MRP6I90srDcw==
X-Gm-Gg: AR+sD13B5RyIvvXT/aWxbHaPvrJ4cKQeS8L3s/oNJOLRqoIvj+C3J5ZLNgK8ep99Awq
	9KAGtK0ytEgQhZXDiWhKya71PUrE/ELVxBLQtCW3yr4ukakOQ/7fAQUzemRIJmuLzuRD5E5jRQq
	tFNS8i0CRJIs7EEoCZaReRGM8tk9IfTjr0J6nNbu/my2q7fswCzSosKJHNk2d21eFEOjC9El9xR
	aIV1655zcgpUqZhiTLjpYx1jtKGs8NeTKqFSovmuaYU5FAETPUjsAUVh+TR21UGkRPM2cVbfUiD
	DYzffKafmWpSeaacHstAJqhH7sWtgMHfbRlR8JZhItmKaQEyyMfdDzt50PqiKIpdZACyg0NN7t3
	hPQjm0wixMB3/dxGIdWPwPHXNbDPJuyoqt6Je/SL6nKrpIY5zJOIBGt0CCgPUMXO7aBFcdj0jaJ
	3ypgAyoJL/3Y+dV2alUdDeCSOII5HydjuUarPhR1Harc7N7fbPgA9knyaSnc+lyRZ1RDO2Zavi/
	V0ySLbxaVz1+I3TXQfvzwNpiBk1
X-Received: by 2002:a05:6a00:1496:b0:847:8bf0:b82 with SMTP id d2e1a72fcca58-84ee495bdcemr12441171b3a.60.1785832893553;
        Tue, 04 Aug 2026 01:41:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c73bsm4783637b3a.29.2026.08.04.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:41:32 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:41:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix out-of-bounds access in writeback_store()
Message-ID: <anGlfDQuLZbrXvrn@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804065919.3970386-2-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804065919.3970386-2-xialonglong2025@163.com>

On (26/08/04 14:59), Longlong Xia wrote:
> writeback_store() calculates the table scan bounds before taking
> dev_lock. A reset followed by reconfiguration with a smaller disksize
> can therefore replace zram->table while writeback_store() is waiting for
> the lock. Once it acquires the lock, it sees an initialized device but
> scans the new table using the old upper bound, resulting in an
> out-of-bounds access.
> 
> Calculate the number of pages while holding dev_lock so the scan bound
> matches the table protected by the lock.
> 
> Fixes: a939888ec38b ("zram: support idle/huge page writeback")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
