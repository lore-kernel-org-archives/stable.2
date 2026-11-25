Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795576418;
	b=wbxvTau3TtfyP89w3r8UFz/F9luHEh3ycT9SxtoHPfsZOK2z6BbXrNkmPWWLxAxi0u8a
	 hbt1zNLX1vUJjKvpIZ2HzU27GxjUuyRd12RuaZAAcKmp7nBLjE0dSB8pi09ARF7oyKOQ3
	 CbOwWBkyT22iIXwC6GzbpAS1kkpvNJuq6oaBFh0EP5LN/WFCa3whYxaXBGXjynONgsoLi
	 hG0YgZzw/LO7csM98CQSUHODyWbnPwqQ8UNUDs/UhnAIVvNH0FcEZLKrQrSGkfynmkabP
	 vVh1lv6qNzyUxbQNTo9kZ2Ib+RnHi/11Ri7yqYTo8seH8xfdQHTrljbwuGWujIpspkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
	b=O9qwjr6aXln7pQOHm29OlhltK5BleyfMLxyYkCUJdf4gRzrRqEDq+Xo1iXWAVrnRYqbD
	 Nf0wFi1VAr7WFPZH/SPfwhHJfllGyvsgLBUxRXTSbOFwgqkxfUEujnD59AeDEOgzhrxL5
	 dNPdajqQRcAODTQn8BMu0tha8EWXec9wS/ElndXjeFKC3KMVWZkY2948C85oin874Ax12
	 sfDMbZLecSg9ScQbNFvAPXR6hGZYiP5ebm383UlSJcNUa56jpHovUAW+aSAcIQQYcGLHQ
	 7cgVDOWB2JQGxjn71iE/gCrzdlg228K+CNjClfBSn4zCOx/EzhuQ2eBUJVBrqwqvvag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXmdTs58;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62604606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62604606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXmdTs58
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b497279c25so1316904a91.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795576418; cv=none;
        d=google.com; s=arc-20260327;
        b=jC3G6PRLPFoO+vz/BnmGcxj/MCMgbMXj5p/PeP9iWAdyknYAi/SKRkkRjNjgp7CIXy
         jo9cFze14kyIfmiiuInSOmp9qy6REapPs3JpC3NkC4wI2Cay3VH4tKdCqY2oQmC4THg1
         4pShcmNpGykR3j+bSIaTaQuCONOcAKZ9jpbsu3b5EyzZoftkgSRXvHm2qKew2Z9z7XP2
         OW7+GXgRfpcH4EKrePnSlTOJ8ztwrl4iijp6hzFqp83Qxr+OhUtwkAsabIngBEIbBa8W
         jE5OlDFBT/XEEIvB5mAxrFN/Md9bb8kYicIXCTLCDWvQvGN8VnL7dMRmHpxRWJdUn4WG
         +ICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        fh=XJvXPuZ2kn/s0RWMOW/MnOoUUxubQnqJTKu3KwJJx/g=;
        b=bUFANqp53U55tu3byLU4sEkj5zxIL0Hiz5swspMg2kb6gBAd8aIPH293+hfE/Ae4gp
         xO453yvA+roKArd95OD+DJ70UuTlG4hEw9lcrQOHYpI4eqFVq7hbMXJAvLGQwgnHhDqv
         kW4nUpwUfJBnFqS03sdZTv4YNVxToASva/LcgNjEvpf982XLOwR867Ufi7kfL8s/Ebmq
         zQ5z+nEwLqZPiW9R/o+SvnqINCiLnXTo8O14DCYOBjMIU7SL3LoXOqKRsdHoei4rCYwo
         M7sZJXBqk3iZVPzb48SGIJDyMonFrfi+nnIereoq4YonEPeX2aLi4sqTvjnWwQT5MYaq
         9hVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795576418; x=1796181218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        b=rXmdTs58n8JfEdQZ4HJe9pcRzDlBQeJ8CGNnQxZY9c+zSkk/5zUpxc5Ieu3awVsTbo
         1xDLVWvtEr5GNBNnsjB7e9TithIelqyGPJFxWAQBw70S3tFtNmU37c1INdWp0EknyzKM
         T1139q3oLAzi/hXRzI2Jrss2DdbZjCHcZZ0mKuvVeo3QskAtNhZ7TeTHj743Utw8bQLP
         n2sLt52jR6Sz1UOwtUJ2xlW7zoiLQpqnaSCzW7nrSgAzWgqaGJ4Z9jipS/AJUQqxNhL4
         sZcJ2jji6rFEGT+lIolVduLzCtkXWgXLtB61dIcFPnRXS5gO41XMwYyCOTVdVbQZtS5O
         Fx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795576418; x=1796181218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tCFbqC4C5B+TcudKUswIJlj5VybrEnHtIhkQZVCLE4o=;
        b=ba+vhjAJCkb7U6WS5Pl0UMvzUDYTiX/ClZmKIHd64j4S73Lmc1pvi4d+oSpzyg//mv
         gytBuLXJZs0Y1c6gpWiFIoXq23SivMu7cMPi3vqDcFlJPIlqtC//08DqRM15Q7iI/thz
         Uop2Kc95GROemoXA3b4Au7CZDlH9wwtWCl4Tyth9kE7dhtEfmBw+Xt6agE+ybeRSzIZq
         lTRFGMmLc3cFju4eEUKNNZALMn6cHoHG9X9ffMeyXDPUjyWpUlTMZRf0CWO/4Yge53Bo
         aUL82YjDTsUnxDIPIVSHpQsGdIHRz78SxqybvZ/RT05Xrm9tGsxv3nAaxsyHWQayTG7H
         B3BQ==
X-Forwarded-Encrypted: i=1; AL+hErHk6URV8RELAXmO3HBKbcqmbw8T6pRckxL6JjPB0IAVIcRK0seCkZr1JYqkViMV5QGmpYX0tAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nzzztWmuy5OkUnHBcIVlcy4huaveMyxI3Ze5cwE30upL8TllQ
	1tV4aC8FSpM0zYdXY21wXSe9SdITy3HiocforSy9bHMzfrtobrmJH42DeppS71md0LX0H6Mhelx
	2HzhAYAyPx7qBY6VFmu6vPvREP6XjqyM=
X-Gm-Gg: AZFdTZeghij5yjA1C4iyODqmC3qgScuCJmf1kd8o0PldFo+ev5WG19QvR45saNSSC8w
	vXYFcQ2lVToqxrGC+lyV4T4PQBEirbhdg4LdVrjYmbK4zObYTmx08sIvVt5l8Z8v7RvTLXTpyaR
	HSNJHAqTYwyAwyHtaKp16+dLhQF6wH9b3p+CHUmI759J/+hYHxygfP3eUfxHMYuvPopiS3iSeBy
	2/WLLslBz87J4IGQtdNZLamZB2zRmqxyW7kerPOQq2YdvT6EdLPXLYA3s0ZuL7ML7WALNQoKCkb
	ysYhwZqdPX8lZlzOMpoxxiDKf08wkmBvOG/nlyFKUv42U5u3Yat7TL6uUTHCKDdAkAuNOOxI3R2
	0S9J94C+ydlcPaMoWKMEwjKefLx3CJyI2M2BHtA==
X-Received: by 2002:a17:90b:17cd:b0:3ab:4f1:4f76 with SMTP id
 98e67ed59e1d1-3b41c900b24mr15919769a91.24.1795576417688; Tue, 24 Nov 2026
 19:13:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
 <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m> <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
In-Reply-To: <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 25 Nov 2026 11:13:24 +0800
X-Gm-Features: Aa3M54pnXMEK0Eck5BBUuqtUrkvY1nVqb3SO0OotTOKtwJph7tvN7_xbLx5Lf10
Message-ID: <CAEnQdOrzP9wKwmyuySRch=a4B5F3Akgsvk9TNUj1Vycq-4JZEg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +1. This sounds good to me.
>
> Henry, would you mind sending v2 along this line?
>
> (and maybe add some documentation).

 Sure, v2 sent: cachestat() now skips the xarray walk for DAX mappings
 and reports all zeros, and the behaviour is documented in the syscall's
 kernel-doc.

 Link: https://lore.kernel.org/linux-mm/20261125030432.274396-1-bsdhenrymartin@gmail.com/

 Thanks,
 Henry
