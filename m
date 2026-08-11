Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79879345EBB
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414007; cv=none; b=jKHTsIjBrHvZ51hwlLgFHRVaT42C3BVjIizbU/uyt0wUxBfb/k/49n3fKvihSaCvnaObwQcD3Ii9THia9lHZFvdlq1OYBtiHwgDSJreXi28U8IKXkdYzcGkyTXJWcZyFiDvGbJPzk/Hhwta21taKAGiNo3Xde+exeGfuutsKRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414007; c=relaxed/simple;
	bh=NPkKek9tVbr2Alb7M6x4U7WeXxJD1FMWAbkqHKuzxYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP0CqE5KAmlTiZTybtxOEzLeGkQDmRc9DbWUxmszv5DQada2v/4NwVP5/3QadB5U/RfX/jKIpItbGfRyRpQmBFtd/cM50g7gK8ClqErablv5U6cRQ67JoPFwMJtiUt2/Vy593wwS0uW7RMhDpy/t6MmofZvAe511vrCD7csjiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JNH5xUl2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNH5xUl2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2474867a91.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786414006; x=1787018806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XNoTPBmi5ooOPVWeRqi5RL/3itbRAm49mArkGvygYC0=;
        b=JNH5xUl2RMQdyEiRWmDg9q5EAVDIhaCSkVDUWlZlchrqgPEQv5/AYhssqZz9Zb8pox
         yLNQR5CiTA9KTO/Nk9OQNf9WTWyUpBgLI0IX4E3TUCFtUB246N6zec/urdbtCSr9MGLh
         Aly2eUXmahiiOD4a1yi5jKVNlTPfv0s+y/96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786414006; x=1787018806;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNoTPBmi5ooOPVWeRqi5RL/3itbRAm49mArkGvygYC0=;
        b=O252iAW+j+vrhQnjWcvMz5CCA6QwtxAKZ1ObkqHaFn9L7ZBI/y4gDwj3LOePiScqwh
         /ni3UPKeLQLCsnXzzHS/wsaQH3dVbaC/7DtIAdQ9AhPnWs1hm8KQxI9w2EAXWSPyV7Nl
         S7ekSPQPvMAujZVVE9SUC4UBhI23lp9AT4jmWkQHRr3dOWbxoAAypMLPEh7dZxns8kdo
         Y/+ckmCFkQJA8oFXiVk03H+uqn9RgZ9nv1St3EZkmgkhVC30e5Ng4aESqcOJDC/SUvBg
         gd2GroLRdpj8Fqjo3+ve/U/kHjZVsDNCexltzml6IY565DMEEJ5f5NKk+cuilq3EHQ0E
         oOcw==
X-Forwarded-Encrypted: i=1; AHgh+RrrQnproNy9aQium1UwwlbTTKCf+qms5f+Lo+Vh42NTq2u9Ugf4sTz+ZaLhtkWhS4iJ50IpbVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpM8UkxJj3+eo+2OAB7q+LgUKybV9NxWaD0/BUPI7cjGDSaHJ
	LDff/fddu2EAN09rzdusgi7gJ+iRKga3qOjPXh5S3t5dxmiZRpuhBR7tPbdcoiA/PYSehSZjW5r
	GQhA=
X-Gm-Gg: AR+sD11vKfNR/ejIBuDyKKbSfUQPYwtVuoXV3iE0SXkz6glwzFX2H3O1oCHhQYT4mRv
	ynRosp+7g3pV3ufvXdOqV/v/McBl/UhUSq4nbpMw0h9yXnaUpZPiTgEsQrLpolnoMKvtR3EqelJ
	nvN6c+ab7pPq5VX2HQXOdsJRKUuxqD5S69GWJhztSKoJO5fZEPdmyGRWPCvqIWea58G+UvvWW5+
	GqRZ1pfnxVdHccPZ4wLX49vIRFDrdbuodbeF119kOKBj2Uz0lipnaXb9YmZueFb8IX06oh9194P
	furjCg3rbd2+jf07+rqbD8nV7tSnuTnXP4Be6t8W93WEBz6DJ7wGBLrXhrNI8uRdFl5fAlwMmSx
	Wn1R9IFejzXfel3JfTxxXQo5HuFQmRtKjv9rlGWTniLDW13m60TwINfXia2UbK505M86GGojMSc
	40ahFNtcTyUz+OIp5tSBKIqA74KryG8VV72NMUv4EsbI7lEdT6s4Oa0Z/VXMFm4YJdSoJRfn9Kx
	L+mzdfBAfEWFnBS85qcmPGEYBl/jr3hXw==
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr23452524a91.14.1786414005723;
        Mon, 10 Aug 2026 19:06:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ddfb:e755:8f7f:81af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050827sm1513560a91.2.2026.08.10.19.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:06:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:06:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Carlier <devnexen@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix slot lock bit position on big-endian 64-bit
Message-ID: <anqDmZKiVfyNB5FL@google.com>
References: <20260810202241.2436603-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810202241.2436603-1-devnexen@gmail.com>

On (26/08/10 21:22), David Carlier wrote:
> The slot lock is a bit operation on the whole __lock word, which
> flags and ac_time alias as two u32s. On little-endian the lock bit
> lands in the position ZRAM_ENTRY_LOCK reserves in flags, so the
> aliasing works out. On 64-bit big-endian it lands in ac_time
> instead: with ZRAM_TRACK_ENTRY_ACTIME enabled, storing the access
> time from mark_slot_accessed() or slot_free() wipes out the held
> lock bit, letting another CPU take the same slot lock; an access
> time value with that bit set makes the slot look locked forever.
> 
> Shift the lock bit into the flags half of the word on big-endian
> 64-bit.
> 
> Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
