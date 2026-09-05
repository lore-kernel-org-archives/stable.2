Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733D319601
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599007; cv=none; b=IRKTjWxVtGIOjyMT9EU+wYDJ1im6VwV1QGga0vUqs83Lz3NHLiBw9ZgLWHjnLPtheWelZcvUeQ/PxyFagVzCge8EaPQm0iriQBTzKrPnUenexqj5x+kjENlCxzV5OtD96TgB4TG8WqwkEaIkkXIZlp/sCUttvqZmtXD6Ysrrdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599007; c=relaxed/simple;
	bh=MenI5bEjIOZcZKbrKG6kdI+EdM2T7LxYNCZDcx5VIow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GImLVy1wcSUmnQ75b/ZArg2FSHCK5OFZFe6wj0OPqm8Jsv4TDpSwNWujZjYHNE2O3PZZpYPJsVpFuWpg/08pImyHwgSIPDissvzlVPIi2Zxnm2Q0J6EBM+82WNqUVHM5ANfY+hTf4mthA4GKbaOHwLgIXX+l1u+5CLNeOJspmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSn5CbPm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSn5CbPm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso28719265e9.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599002; x=1789203802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2gzn74/He6vpPugMVv60IyFY+oEpXPCD/bgVBASQsf8=;
        b=pSn5CbPmu2+Y3rgu91RwJV/EPOruNy+FAjPDUlkSkawXolHK5fSTDnd2Hdt/DHd2kF
         u+GVhNQYHdNEKrHajhSnyaiZn8CuFMIoaQDCM9yYt8ZZS44Iyz6/g70gYlVxcsmInhHS
         TrP0vHdpsMyBmeska2x4FHo/kbU1dg29JPALomK7ZORVYyCV6io30fP5anCbSSx6PvUZ
         oRcl/HFC93Xxi49rPfA9ww9TX8VfH+idy4FvHKNpsQHxPIZXGHfz7DAi5TIdHNmoSvU8
         aCClC8KC506hBg0i4O2+aijd4vFZSh+MBGeRUC/437lGKED4ZsRH/Xwdw8Zgn8OIcwjp
         2KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599002; x=1789203802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gzn74/He6vpPugMVv60IyFY+oEpXPCD/bgVBASQsf8=;
        b=Rm3CWiApKBpfxGeHp77Q/1ilzLYte+AtsCD3fOMvybICX2jigGOBVUTZJXutPYLY1i
         QqvLM6+YlUTjNXVYTY5OdpJhoGOsReOUDvoaYgbMx8nOfITRVFPbkuPNGGVT9taqf2W+
         c8Uv59gfXDJwWfc4QMunb5F593DiKlwcXFiBdWV33j1qtX/1IWuvBrhOR3Fbp+wPcUmi
         vUNIoS9f+Hf53RqWQlafXnpN07QjPXd34wAnxJ9k6qyTr+BL89xkVjHFJVXkLDiGCQAy
         oay4ZVBs7WP3wK1bVh6DF7E9cIeXwJ7fV+odmokp72boapokzBrFMveAKhEBxmz121AG
         l5aw==
X-Forwarded-Encrypted: i=1; AKwUvBziYSt8VTTj9AC0RltHTEJDFWJDbApjsUXVLYsmDLw689O8IReRk/qb3fPTPJLgUQ36CHUjYmk=@vger.kernel.org
X-Gm-Message-State: AFuF++kwh09nmYsyOKhjMbS06vYgzRWEVKulc19sodBs7CcayzP5OwXn
	Y5jq2BzsQCovznz7XZRoOtS9+OSWwXqXg6qL3lbOoZzcAKtfRHdTj4MY
X-Gm-Gg: AYBFou2Y+ap3g79U1D4LWrJcWSIISgZRLjglhaT5bg4de5ABJ9mf2I8MDxRsnrFljPK
	Mr2MAyHl3OA5nt1iVfFdB7UgJ8b2k1n2iPjnR5oHWR+AVQVa8PPnA9KUF8yLm7YbriL90wv/4GW
	ZfXP1pA1KvG6GMWjLwMuPtg06Y0EqhkVYHlCggEGUW1G6gGeC8dOvwtSNm4XlbV0Ftc5eKxEuoY
	4xtf7vJBsOAyl6Kwog3cf14MlK95dJN70VeVf3Mmc+L98mrmsPqhmzlFEFidJZiPY7cLC3Twgeg
	NjYaEa+BuddJBU10e5NTvho1gVDKfVuM64Bib5+Fbvf/JRXfuinvwBEIBcvy8aba46DoCaUsM6a
	MHHvXd5PG2jilBwkX7JpORwht6BRycAa1qK4SgDk0De4PP3r7drEU1w1/Ib74cH4AKxld7KAT1M
	8wcydsyMGgyAaYbVbjEx613GmvRDjjEmxJ3FQeKzc0pZhxgw4BAu9AE9IkdjDvEQmIQLlJn0by0
	Yv30sSfxXSnulZs7aXIFnxomw==
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49cfa211cd7mr94741675e9.27.1788599001762;
        Sat, 05 Sep 2026 02:03:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm233373185e9.14.2026.09.05.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:03:21 -0700 (PDT)
Date: Sat, 5 Sep 2026 10:03:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
 james.morse@arm.com, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, stable@vger.kernel.org, usama.anjum@arm.com,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v3 16/21] arm64: percpu: Implement preemptible void RMW
 ops
Message-ID: <20260905100319.0a50c17f@pumpkin>
In-Reply-To: <20260904161758.376504-17-mark.rutland@arm.com>
References: <20260904161758.376504-1-mark.rutland@arm.com>
	<20260904161758.376504-17-mark.rutland@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 17:17:53 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Use the PCPU GPR infrastructure to implement all of the RMW ops which do
> not return a value.
...
>  #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\

Isn't this definition exactly the same as __PERCPU_RET_OP_CASE() except
for s/tmp/ret/ and the 'return ret'?

Since the compiler will just ignore the unwanted return value
there is not point replicating the definition.

David
