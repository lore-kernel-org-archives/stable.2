Received: from usb-smtp-delivery-121.mimecast.com (usb-smtp-delivery-121.mimecast.com [170.10.153.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7C343D86
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984788; cv=none; b=pZgNrNu7O0RO5wqO+wKSpmB2rdUoK9fx/9cORVKF3qC+DyMVIJCagYFhUYhG5GsiSRr21hf7C+r4Co0RAyl8eSbNvBQ+FUmLZAI9mwde8Z9QLGFOI7JiejAlPKj6e0o7FAI16ItXO04pN6Ezas8b3dluL1i1YYnWSIflQTGNk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984788; c=relaxed/simple;
	bh=TZFVk9+SsHc1swMhp3SUboW+aKy0gwpEnNLXJg0DOBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwWKFDr+9XSEpJGpWTkM/knx01IGBKBBzsjZFPAA7lk4aKUzIJYrWZALSgoGm/OjgjtupZDx00PHPUkwh4/8gDArR3BnoTgp344xK9GaNV0u/wuBvbHfOQQtHE2zhYdWCrStJmuzGXtsWpdBKSZxcNkk+mpdKHPLR07D2STiGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=VKgHONii; arc=none smtp.client-ip=170.10.153.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="VKgHONii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=extrahop.com;
	s=mimecast20251212; t=1787984785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZFVk9+SsHc1swMhp3SUboW+aKy0gwpEnNLXJg0DOBs=;
	b=VKgHONiijcabpuilBkYF316TY6yPZ5r+Ka0iWibZ3bjNu/pvTKVZfqGdEAdX+G4aG+Wr97
	Q8f+McJl9rXWYH3LlwkRxp3rwENfp8wMPMMrUdUY9ftMKExzq/Fhghw+wmT/rIVtX7/XBK
	YKwxrFGAToT/mnb8vGaJmJyjjh8HQVl66B1zLK37d3Z0QdOSLjcWdzJx5HsBseDLr8Zza3
	2+tTVcZUSIzyPFVvsOrBp63/cWFKtToYkG9S8nNswHOdJ07y0RYNp+PRSMNzmV7Gzv8dWc
	Wil5m4ssziBOJjf4ClDnWI1p7IQWFoFACg2JUjo3XowcJncEbNtehJ6KiNw6hw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-29-3AHFOw2-N4CSB4KTse2yMA-1; Fri, 28 Aug 2026 23:25:12 -0700
X-MC-Unique: 3AHFOw2-N4CSB4KTse2yMA-1
X-Mimecast-MFC-AGG-ID: 3AHFOw2-N4CSB4KTse2yMA_1787984712
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b1bd347d5fso2665552b6e.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 23:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787984712; x=1788589512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZFVk9+SsHc1swMhp3SUboW+aKy0gwpEnNLXJg0DOBs=;
        b=aO5zjaS0vItnd0Ra0AIXcioWe3LL1VmQalL9y/iTLXdUYntGeWrmXqUk3WiF+63an2
         2MrQNGmL+wA23FoRElFkAYvshhwBu5UZhXuzwPdKmKHcesLJdGKcqdVE024HszZSxNod
         cAwxm95rAWbDKIO5D5VU+HOvH37ntNji4pZ2jIq7yws+QrxCkh7WuWlizYdJbLctFjci
         pUHI7fK7yeRGdTBbVT0e+WYRD2EpPmjM96LnLGQ5DMyJ40+scudZMV2gysOd49tRngYS
         6fDLxliRHjUHjiuqOKzdyt28x6uEGmmJMKHMDhHWkSTmrAgAtEtSrTkfnk6HT+yv8WEm
         MbFg==
X-Forwarded-Encrypted: i=1; AHgh+RpI90iBRSvaYGqKB+FGnzg91d7++rWPgahLlGQg5KKxDorqoWsDdRGn8+4A78bgYd6oXLuBU3E=@vger.kernel.org
X-Gm-Message-State: AFuF++m8u45ef19DvQGStRj6rj6unTkrC5v8BshKBwMzd5mQn/3EeKyU
	NHGORAyeT2POfhXc9kuhtDLuB7ci9QJaVF84R9t1boEvrlDaZgly23q6A56IXCTH0LyZODvteLF
	DMWuR8rCDxRYxSaPn2c9nJCrjBklGzc7Sokb26GAJY5SZ9ecMnvPEL3/FfWFiF5fxaHtTEpoygN
	SAyVVOUoBMoBA+Bbe6NVIAjaTa08t0EWs+6iBli/OpW0bCuVkjoY4Puo+MncULHaLLmdzUu26ft
	yxdVsmq/E4pWdzeeRK/GuNR5Ztxo2gv
X-Gm-Gg: AR+sD12jaumK951NLkk0vST/uYoTSIv+Sxp8lhw1+HMusFamVIPs7HtlP9bqKfirvl/
	XbzCZoD+Z8u5iKt28JomteXmyvrxoIDRC1db/XKQxDc+wyjGDCdS1zuKpgBY3OG5aOGjhM7CORL
	m42QvM8ng96/tZNZF9hsczvjZI5DWr9RjyYeIdI9uacmutjup5Vu9kTSvc
X-Received: by 2002:a05:6808:4f2c:b0:497:c1f1:1511 with SMTP id 5614622812f47-4b39826e228mr15019427b6e.16.1787984711880;
        Fri, 28 Aug 2026 23:25:11 -0700 (PDT)
X-Received: by 2002:a05:6808:4f2c:b0:497:c1f1:1511 with SMTP id
 5614622812f47-4b39826e228mr15019380b6e.16.1787984711397; Fri, 28 Aug 2026
 23:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-b4-mlx5-temp-warn-revert-v1-1-4e2ae5a0351f@cressey.dev>
In-Reply-To: <20260828-b4-mlx5-temp-warn-revert-v1-1-4e2ae5a0351f@cressey.dev>
From: Will Mortensen <will@extrahop.com>
Date: Fri, 28 Aug 2026 23:24:44 -0700
X-Gm-Features: AcwNN1VIs84aW7h4LmG_OYt9spu4FqOdcNHlqLQ_KUB6rblJb6GvwjB57CH3xp0
Message-ID: <CAMpnoC6XDYNN8HaEp_FtJATd5mUg0dk+66uvS-+0_T7+dcNWdQ@mail.gmail.com>
Subject: Re: [PATCH net] Revert "net/mlx5: Add sensor name to temperature
 event message"
To: Ben Cressey <ben@cressey.dev>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shahar Shitrit <shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FjkTvxLwfzlWoFoANV3dE0tgHMK2I7roAnLoPCGeq3A_1787984712
X-Mimecast-Originator: extrahop.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:56=E2=80=AFPM Ben Cressey <ben@cressey.dev> wrote=
:
> print_sensor_names_in_bit_set() passes the sensor index from the
> temperature warning event to hwmon_get_sensor_name(), which uses it
> as an index into temp_channel_desc[]. That array is indexed by hwmon
> channel, not by sensor index: it has one entry per ASIC or platform
> sensor the device reports, plus at most one module sensor
> (module_scount is 0 or 1). Module sensors have index 64 and up, so a
> module temperature warning reads far past the end of the allocation
> and prints whatever memory follows it, up to the next NUL byte, into
> the log.
>
> The mapping from sensor index to hwmon channel cannot be made
> reliable here: the driver registers at most one module channel, while
> the event can carry bits for other ports' modules, and the bitmap in
> the existing warning already distinguishes the ASIC sensor (bit 0)
> from module sensors (bit 64 and up). Drop the name lookup rather than
> fix the mapping, as suggested in review of an earlier fix [1].

I don't know about "cannot be made reliable here", since my patch
hopefully did make the warning reliable (although it didn't fix other
fragile assumptions about sensors in hwmon.c, which aren't fixed by
reverting either).

Anyway, thanks for picking this up and sorry for dropping it on the floor. =
:-)

Reviewed-by: Will Mortensen <will@extrahop.com>

