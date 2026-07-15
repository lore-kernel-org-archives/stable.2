Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A22336ECF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154879; cv=none; b=E6rp8BqlLqozEVGrMJxo67EoLH+WZnQB2FElM1waybEejJU39S7aazpE1/P1j2z+QvlduSzSiyR1jGr4ITVOC9T2UK8GxPWdbDiEGfvvh9SgeDYIcWyhH4Cke9n4zCGmeJahnH5UZcbXFfLjGtEjyZPXCUh8e/4EtxjjAgqjD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154879; c=relaxed/simple;
	bh=epCF3WAtVK+rHoAAfkpRXRa/RsXFmQXBbOeXNtNyprE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kfZtJRxKpjruxUOpLC3d3BfKDQSi5X8CqoEiGyaQ0yO2lDQ/PV9pA7veIN7qzz/6Vcd8FRNXtFU+ZjAbMT6iohKJ8vl6+Z4s8+SKfcUK+sdIfv6vf4jexIRl+Yp6BwnQ8/S3IkQaZh1K3Hy5+1vANZeKcY97FRSQwD/1wkJ0UGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=g50754wT; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="g50754wT"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-451d8064238so3391531fac.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154875; x=1784759675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMsKH9F+ormFI1Pys8jKczpMBx0PRFI2SBhZZ0ypZyA=;
        b=g50754wT3OirDsmAblB+hhBMkqxo4Peg/u97803yY5t2xqzH/385hrjeZ+dlg5P6tE
         5A3LfzlK+0q9Yg454PhlCQn+jOkK80KFm+3YbBVcXHRD0afc945bHTSz8c1FqdAnjV88
         rvkX6niE0g53fPovTvhJhmoIvEj2wrHaQs1iNcNtLfjVo/EVWWI54CLPVMs+906Bv1FO
         cDHStmT1DlZPe4x0zKWuA13EkT1m4nzoOEAlg4uGRov2gipCvTkTSTrJSdSeenfr9uyn
         4LMWJS3Or6h2d/0loGoLJ/ImA+1ZEaeseRqjCKZafF9Ec+5OYTdSHF93jyFMw6OxZMFp
         Dwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154875; x=1784759675;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMsKH9F+ormFI1Pys8jKczpMBx0PRFI2SBhZZ0ypZyA=;
        b=JNtHgzC5YdBoekRuAnP2BCO97mQUW6YFXRrUGlxMMhPvSgynnKSeqeTAUX/+42huUQ
         JFtZmVuvEDJujeN3OQUgjDGpuFlOytbEXyzkAsO7spyozVA0gY3kUsw+4YBmj7ctYfaS
         hVabDyS3JvdKR+Vbpmqjc0U3uVG/5ko8gd2vIMDOfPEB7X5W3zH93lsqyqJDbBU1ZB7n
         ve7eMpxg0vMIuBlNOQCThZfw9d/1f8/P4C8oUkEen0/6mmuWglYszvIsiWP1dJ9Yp3wF
         Qte8/PRtgJxRjBGrnvoFs/VnKkkOsh61PG0Ne2SKxkTt4UPc7QzWRVbNdz/5fEhdqUEg
         ju2A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8ulMEaMmS3mQdSQL6W9l3uhKB4t4gS4yb8NO1eswk9MJ5e9YDTHns0qA4vJ29pIP2ybUq2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMd/3Q8XftEpeNA/3h72UWmoebe/VPfoxKzxbdugMNOeO9jWv
	Tcddiyp2xmnfJqiRQlWQNzMCcN9QwS27+L3vg5i7zVaQ5WPzLbI2fgOwMBWeWpuTeyVKXgN5Mom
	8263Kk24=
X-Gm-Gg: AfdE7clbFPk097F7FuH4i88E11P9I8aL/INRZGTTDIyy+2gORSolpzo2s5nSr4Udjgh
	aOxMq4iVCGcmGp9ShhmpFGgv5QFJKupRHpXFryQEgIB7rMxrJJeBJHswsnvS7vkf8njijWQNU+P
	vQWblLZXsA36yYkWnjglc9DzDHKZBPfIR9lEvXimwQ2gWEtbHUWPicheBprYy7IQPDiszc+UcT/
	K14XHhJtRd/tom5RRhfeNE/LEYAQYBBKHUcx6Ui3ebPWOUj3+Dit27mPwsldvaZPFkMLPRE+yAr
	d39GRnqGHBnKasDSUqvgl4ydFRlHGjua4l/EcP/Fw2p054/TEVU75ZDp+BaGxaNA0sAkIZ+iWT3
	ant+PzXIYih+1G181hp2RMHO1ri6QSnOWtzG7kNxzUxWeggf0/oNw7cj1B+rk8m/thoVgEBzeD7
	HwtgiWeVQh1+fZDDH1IiypzQYZ3xaTdfMzmzicjG8w3mP630A7UT6dOpY=
X-Received: by 2002:a05:6870:65a9:b0:43b:637b:c33f with SMTP id 586e51a60fabf-455f7a2d10fmr5770132fac.6.1784154875484;
        Wed, 15 Jul 2026 15:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Usama Arif <usama.arif@linux.dev>, Mike Waychison <mike@waychison.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260715192950.2488921-1-mike@waychison.com>
References: <20260715192950.2488921-1-mike@waychison.com>
Subject: Re: [PATCH] block: fix race in blk_time_get_ns() returning 0
Message-Id: <178415487451.159585.8139693010371927224.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 15:29:50 -0400, Mike Waychison wrote:
> blk_time_get_ns() populates the per-plug cached timestamp and then
> returns it by re-reading the field:
> 
> 	if (!plug->cur_ktime) {
> 		plug->cur_ktime = ktime_get_ns();
> 		current->flags |= PF_BLOCK_TS;
> 	}
> 	return plug->cur_ktime;
> 
> [...]

Applied, thanks!

[1/1] block: fix race in blk_time_get_ns() returning 0
      commit: 691b052139c94ee6640ac39e0b764dd3867897c0

Best regards,
-- 
Jens Axboe



