Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133477;
	b=YCyO/BegcWY75DOadm4LhDSVrUzfRBecPjNyuvNpYYIaCgJa7S6LODKcKKUVxhJNKSTP
	 PsScf5yAplqC6uupoGfw3T0Y2bMiqRTiKMFRejsxQx6NcsF2lsZ3GBJu/OKqS6LkZ9gfu
	 0jFHNU87WaosBWsGYQ7MuKRQev2G7ecjWNjjiXRUkCVy5nQE12Y3PbIrnB5g19JmzSCn9
	 5jl4znqlpxlV4JaqZuYQUeWrPGrhVhWIPRfE3ayhJ+Oi7dfx+Xf2PGFQI8TzZU0HY2ZUO
	 A1vJsolm8SU2gj2PfvSTKtSO+gJ9pjIjZvhQxrK+XWlauRJnHQjp4IlSnUV08t8SaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dX2sdwg6msO+2Hy2n1fUrye627ZQcDy+aS+NuM+NVo0=;
	b=Oo0AW+uoUrGecKBysnTJv9TPCgspzl1/pwxv4giwE+ZoKC6b4SLWt9qDb0qfv6UzsZSa
	 RjJBcK3FkmITrGpZLPdGxJZZlip5or44wY/rp4nRS4wTMBEF5aMP+2BHce1Svt4Qa5W9N
	 D0tAC+O5prtDhL2+xxyVcdtBAiRiguo8kAWA3N8GpucKjxOX9q1by1FsqAJHrkCh52Fk3
	 58UHGsLR6nroi+9m48/TlePAiAeregecdCoHeK+7RA2jM09xvMb3iiK4hoGDdz5UdP5N/
	 2FQrenryGln6bbPNkojHUIs9F/LkkWkBA0K+s6FioQEYq5G2mW0RiKOOI41B1F4ijEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJqzfke9;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA2606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEFA2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJqzfke9
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2f59de176so327509b3a.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133476; x=1795738276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dX2sdwg6msO+2Hy2n1fUrye627ZQcDy+aS+NuM+NVo0=;
        b=TJqzfke9jFntflzsu6R0AwzaFu1KNFLU8Cv8ipBv2rtoWTIDoqfa4z2rJQpQwPW6rL
         AOSMR4Zx4c+j3qhAuY2j2geHE3njxRCSbUTTqPTTLQRFiIXxYIb7kEq3zvUQyzkTStja
         MFoMDiR5ZFpGXlfotungxVz1P1pTJ/Asymf+IhJ305ug/IcsdkeVlby2kS5ydS4XKgJm
         BAbxyKX1DTsbgaXIzQ1LX6ptXki2d0PIJbttKfykgChhYgt3/HT7/x1NPMfAxoaMS7Hd
         b2XQLzaGXSmk0asB5G7Rb1Z6PUqAJJaAcW3UCTJBwwfmC/iarfy/LdqLB9LUROync6bN
         US9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133476; x=1795738276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dX2sdwg6msO+2Hy2n1fUrye627ZQcDy+aS+NuM+NVo0=;
        b=QBEXwLIaSPPmC+qat1yQ1juN2Abhngc24j8y5sFNVAEGMXMb4nJGaEFLuz/+87+aZm
         5notcXgWdqicCOUlF/1ONl97jpEo33wxOt44M5UnB+xuNqwZ4u7ttzpzQcMRSNhl1Tri
         fjXZjaWf5dwicaH31xJCOW6yMDStLTbamghXJzN1CTPkRuPKh53hP+icCOIdJcmgksEW
         Bcr8FTvLL4OQO37RLS164M0ZEKg7lzTmrRczAEnlf32G7eisgX4rOCp/qDfwGI6c8YZd
         YwFH0mIA5AzQIghyltXFWH9j27SK4Z8fJsOvz2DbHxU+f+GsbUB4l13Yw8xk8lISLnXv
         R7Vg==
X-Forwarded-Encrypted: i=1; AL+hErF+5JK7dDUY+yazSVVi8C8Cd7a+Lc3cbU6QrCeRjHc5WV+MEKfiO/UvyFjAQz4pQTxNimQgafM=@vger.kernel.org
X-Gm-Message-State: APuU4Z96NVvommYH1Z0ZO1PxaA6Dmhfo6+h+o7Xe/RTsIGw9ZCqww+RK
	/hNrEcVY1LCTcqea8WFK/0p+m8sBB/B84d3wX3QnPlWo5kVO3Jy9WeOPucPz+xsg
X-Gm-Gg: AYBFou19nGKOXRSoiHGTriB72NXxMTY8k71fqvCShf+jxjCPQg3QCZy8e8aLqPAsX5F
	2YOXcz7GI7udH294is/HXFBVgb8wQHH59Jz5Rfq8nSKvhba1jr2vSraMti7qEN6PlVg7PgFB7fP
	TqmuR09eq7POWLlVIfY2xR/UwfeqLc/DVMbiOwVxbA0NGdcnHfwMXhM/b/hygDD8tGUJogYFmfj
	6hz2t86UncRdYWWO3GsGyDEnB9r3U38puhnHxemJ+cawsB8q60vJaAF070rab6e0ql/EYGoLt49
	bO97OipYCH+YqTa3lBWzawssBYlXuxATVmsjNfffikpj1r1yADT2X4zHeO5wXQOYMt5Yx+oriEM
	5YyF7MqgpVAJRAiLTR9DPTFtSsUG/0q3NG/C1Mbr/ymZvAqAOcTnK4CWna2wOZnqRvkaG/zRjXk
	hpcBpRqMVG/WQX3B1WwXqQXSj1j5xHh83ocP9Djr/z335Cb52NC7r2/F5XdDHWxvIAhDc0LDeqR
	j43ncCYLh1xmqjIIJSxfJBQKnDImek0oXeFNPKiYZEKXV/xrj2qI3roRV8OQOkHr0nfQ0UwHdvg
	Lb3JVtRQuPIsPrsaIH9rV1G3GC+KJuS25aRX4FDnD+qexxnx64NbeCb74FE9Oo2zCVlZe2SPxt1
	eATTA
X-Received: by 2002:a05:6a20:914a:b0:3f8:c7b1:688e with SMTP id adf61e73a8af0-4014d4557ffmr1304618637.30.1795133476084;
        Thu, 19 Nov 2026 16:11:16 -0800 (PST)
Received: from macbook.localdomain ([50.35.8.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c05fsm604400b3a.17.2026.11.19.16.11.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 16:11:15 -0800 (PST)
From: Brian Martin <brayniac@gmail.com>
To: Louis Thiery <thiery.louis@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/net: don't charge the folio offset to truesize for managed frags
Date: Thu, 19 Nov 2026 16:11:14 -0800
Message-ID: <20261120001114.61077-1-brayniac@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119232935.1708458-1-thiery.louis@gmail.com>
References: <20261119232935.1708458-1-thiery.louis@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 23:29:35 +0000, Louis Thiery wrote:
> Only the in-page part of the offset matters for how much memory a
> fragment ties up, so use offset_in_page().

This is the change suggested in my report earlier today:

  https://lore.kernel.org/io-uring/CAC+fX10wVVSqGnfCg+aazorsCxB34sUDV-XJiBPd6R3Kuqc-7Q@mail.gmail.com/

I applied this patch to io_uring-7.4 (0659e44ce739) and ran the
reproducer from that report. With it, SEND_ZC from a registered huge-page
buffer is charged the same as SEND_ZC without one on every row, for
hugetlb and THP, including 8192 for a send that crosses a page boundary.
On the stock kernel the same run shows the overcharge.

Jens, if you apply this, could you add:

Reported-by: Brian Martin <brayniac@gmail.com>
Closes: https://lore.kernel.org/io-uring/CAC+fX10wVVSqGnfCg+aazorsCxB34sUDV-XJiBPd6R3Kuqc-7Q@mail.gmail.com/

Tested-by: Brian Martin <brayniac@gmail.com>
