Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028974DE72F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605890; cv=none; b=UzgX12+AXm7m5HCHsqY60s74wr57E9abhCoz/BNdFyJsLIz8Rn53hTYMjCGQUvrQmNAQxll+Yla68rNK32Y07eiOrc0CASPqfEzR5K/YHHkYz4OFUjOn71XsVc/3XLcDnojc0hrxD8duEAkrs8zg55Ljf5uzqLhi9HdJDnJbA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605890; c=relaxed/simple;
	bh=ttRLp5uZBBXIDZVrjCp1/B/OT2B3HDt+3d9o6TVjSxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TG233MsHmsVuy7W1Zr/a9UAt/vYasJZDn6fJqS3fC2IESe7hv35w1cxVAX/VJVcwz5OuAyiEHwWGrGoRoBS/o7//lVT3uh2XQy7pK52jJaiWCvD6elX2YSuzSaaPpE79LiDGyT1pd9vEHMOqKoIcw1u7AHnJ3BYwdxIk4yRK8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cCvfrCMW; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cCvfrCMW"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144d60be6b0so1735469c88.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790605881; x=1791210681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XjEI2w0L+wVlxSuDV0P7eMrDPKELPiH3pO+YDTZIuR4=;
        b=cCvfrCMWtzK/r95NE2TdZLDL9vVOGEUnR0e/8U5i4KeiN9qic5XMPyQA2oZrDwELoo
         jdScsgI90nEkv8qdf4BP4GSojsHdp1HR282ON1+rHX5hI9F9Qfye0w3tpIRexndB74g8
         wjh0aDhHc9tyMmeOHrX/+Y7igxtEB35viPE+KQ1feQNi+6Xnshrdf4Wy5EUt9my17H1+
         q9BPGCcIMP3G2w06R/na71/tHnXysv1lvwf7b00k/htmjGXXPl/1AimDafAgUw7bR9Q7
         Cf+G+zVY5Q5ltsBzaqhDga6swiqa7DohJEjbBE8/TYWxjPP5MDt9mLF14YI8awWygDhX
         dxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605881; x=1791210681;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjEI2w0L+wVlxSuDV0P7eMrDPKELPiH3pO+YDTZIuR4=;
        b=XYHJN32W/6ztBkBw63X5ZoMpt6vlmCI85/AIwml+RHb7Jsz/RTPL6ngEHF7/oX/81S
         9rA5kgYDCiRUf+KagIgbrcLra+JACbHec8gy778ziNmwY3gm3BgK+NiIXLgPpGr3NCTN
         /Bew2GH+qEhyQCSSnZHfZsPMdWmpohl9NrSpM5xw/82MqyY5xcHU1FbtjYSDw6zNuiwc
         BzNr2gUmtTSBfFtQ0Sha9caJ40gY7i8+BHR8g0oO6Pot9EAYD5kZVAsAAUgvzxzPdjKw
         QCCXmygYxd5fDBunrhPGIua9vKu0rTGqFcGmb+6oq1uAw+4wlwRd2XGL2Y7Is+0en5GE
         /0sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOIkI2+FAdT7dqFtIwlQAupLZzbkQk5XpsLYei5QHPM+ZeXBcisH0TslPuF3CgxlOdypGq+gg=@vger.kernel.org
X-Gm-Message-State: AFuF++lgPyNF1VrBo7ehFHr5eBtdyu/hQ5fhpFZzDw+ee8GF1MrPCmtp
	Oa/YCEdMPpcdeG/fU+e01I1KoLV8VkWkKCm6Q/Aytybb5Xi2hK87OHsf8mu0UWcjkXo=
X-Gm-Gg: AYBFou2iNTfRDUtzxq9npAvOYOD6TeN8mKN5cVt8L7FH/qvE4vEjJ60OeUCDvj2gqVT
	h6k2tjO+B6FfaMJsroz6QjQEzep1oq439HNTz+W8uJRVGYWhKGvHVLXE+zE0WfCNWaXG/NGqYfl
	AmhLH4SGYtodRbV75nn/1ThpnHf0BvjX8/SBuyaFxcPnTOA5ZtcoWQXt/Peay2TZHdwPI/EON9y
	ZyiIAJiD9iBy3PGtQIlu0v6oTeQZmAt6GHc2H9ab0PjADU80uhtby48ypLXjQAttrERrS3n5fFc
	ocNnUScPVdof9554ElwakuuGiP2cbgXisopPQKYfBh79G/WuFBE2Ta0yXn2LlybiUX+BXeCenYR
	RsJSV96NC7o4YLfvasXHFHOEd8sQfcsFMQg5UenkJEBnFuAO0vzdeP8Ygq+AAFrt4d9Wtiaq+w0
	qoUn5zUAJhvkTKhfH/fCcS/6BeEOgn1TJj6ZE+mcJsESrrIDUjjIikXu/RI/Cyf8baDcyK/rxzq
	VwPNDvUVuJQep6i/BvADyMEkPsCTL7gXI/tzgVVxK+VMBPYZ7wT4v3J0g==
X-Received: by 2002:a05:7022:6889:b0:141:517e:52ef with SMTP id a92af1059eb24-146ce492c9fmr13591875c88.17.1790605881108;
        Mon, 28 Sep 2026 07:31:21 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm28616577c88.13.2026.09.28.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Junyuan Feng <a@lollipopkit.com>
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
References: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Subject: Re: [PATCH] io_uring/zcrx: requeue multishot receives stopped by a
 local resource
Message-Id: <179060587969.984285.7352315513863005103.b4-ty@b4>
Date: Mon, 28 Sep 2026 08:31:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 23 Sep 2026 09:20:44 +0000, Junyuan Feng wrote:
> A multishot RECV_ZC can go idle with unread TCP data when a receiver-local
> resource runs out. An empty copy-fallback niov freelist returns -ENOMEM;
> a full CQ returns -ENOSPC. After partial progress the stop reason is
> lost: io_zcrx_copy_chunk() and io_zcrx_recv_skb() report the copied
> bytes, and tcp_read_sock() drops an error from a later call once earlier
> data was consumed. The edge-triggered request is then not requeued, so
> it cannot consume the remaining data until another socket event arrives.
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: requeue multishot receives stopped by a local resource
      commit: 98ad5b63f5041dc354a6e694f4a9436f74e0681b

Best regards,
-- 
Jens Axboe



