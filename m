Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94C38D401
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889679; cv=none; b=lTfLi4YlBjgRH3n3ZmdgE1ltQH+hSy+h3gdXYXX6nLh86OwrmYBdLNqhBMMBn/ThyYam/MDsEl9yDf+iy0hNZ6kNztoMJaL8chGa3X0rISbJEtL9+E/aR/9d+byz1GYn0DTeFV50Nxdhs2l/IM0vCqPVUYn0qx8Ti++8BHT2gzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889679; c=relaxed/simple;
	bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Nbt4u+/pNv1SpaG6O3yw+5oY3zwN7ynjpiNNtGoWRwvtv3zh5HBpsNd5SQ7QzEYDsgLAjwp5QsGztSan0NUK2lPVTGKfJhElUu6vyj5ISBCInTy9Qzor6buCEk+1BMvWUJHYpy7OwOa9SzuphIp/NB+PZrXSbU55dT8USvvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1vyzj8k; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1vyzj8k"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e25187so1137537b3a.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889677; x=1790494477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
        b=o1vyzj8k7ZU+K0eTMvOakrVZ/+0TzqwLtHzIxAOp/yv7fPplQ+9lNGrOLelYqUJL80
         WALOShO8hSArhEuAu1BhpLK4iC/B8xnXBn/LEOyh1WYXXdiHoAFZ6L7LQM5WoHTin4mz
         97Bqsc9rtzfhLb9OVziyDEqICN/hAxkhQdiKrpiWrOYH6UlAZfkqy+xyIluEFdQa5xNq
         qJj4T0Nlog7KcsktR0Jl1X3CK6s+DKrk8dKJf2XTxwpbZQ1LDBZmP6ESu2kpQ2SEd6xM
         u0adS0osf1KwE558f3/+JdhC9mCWrNBb2X/fHMDAnkhIZMZY/vEEKvqBSf5h+ylaKRVK
         JXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889677; x=1790494477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
        b=115fwsp7fdsUoHD7P6kYapBq+jQt/qtV1o6riS9JilQCaB0mnjz+SqaMkUP5GxRFin
         ARXh4OpiTe8Yj7GeeSbSyTEk0LiJz8R0Pvnt9aG5znxiUmIDR3S7xzOzZCKv0rx/Pkbf
         jkDEPIrTJTqy5n1HrjnTSH9u7AKOIMDrKMoc7+WZwm5bxzuCu7ISvfP9Q7WyMk0LP4X1
         wzNkmsu5FCK3rukGhIb1Ac8hDbMzB1ShZZkatih7S4KLrSZSEJ03rCn8nBUrxYmNokLf
         I70/IZOo113PcaKb2wNahRrBD7URlGMDf7THP/xWyXlqAN9apoqcjTifMK+ffZbD7/CN
         RXIQ==
X-Forwarded-Encrypted: i=1; AKwUvByfUdYn5l0f29DztB9OFCrFPNBnTN7t7hckOMF/A/KWHDnR5iyZt/1OcJN8Kj8a5v5DxvUIhnI=@vger.kernel.org
X-Gm-Message-State: AFuF++msKvGy6eHeZ7iq1FRWMpUOyc6eQ8hoFOIHFNjK88fSbIrofHil
	a41uknUaQDT0kJOBHRRZV/v2e2i6SjOcGKmmK+gxpBC2vG1YZ5DJ8QnKD7dE1YdPyuq2gEjq
X-Gm-Gg: AYBFou2nJtWMfl42jsB+19E7uM3Jy/ZeYX2WOqwZBj84BNfig5C/t7E/RKzk+FbYkXi
	mjAzXXns1kjRK4ULec3AiaSs4HmtmgyZTJDMWEOv9n2BtMJ3mHr5koZuNMbHL9pIrK3h15fHn4k
	4PouG+9Jh1gBlQyk4eKeSPBVPr9R1NJ+3LHm7ml2SrUJidpuCpzy0JrP37K55KV34sViQZhDG9j
	MDatqi/O9zWV+M6+jG1prZnfOn5fhHZOLaVWdyExfPZQAGnhDTHhd6bGphcxtuQCm+bwi7W65xv
	DWpsZbLMkoCc/Eyfwez68dMkRAVTaobPMCzghhgWwjxmRLFFqz+d6WWc9LhF4NhZV7a74abNQng
	XEgkNK3C3UR4hA3Gjjy/ZNImYi0Hq6B+v6qfyf81eIY7luISxMw2NXlU8BmEDu0aEF7y9PZDiX3
	dJryKm2GFrRsiPWHvhBsvv8H3DzuGpSMH/XNbXGseEZOf8Y5uRB/3JY3uq7QE8CPoJ101y8ggAG
	cBOrcPtwk32YgVKFr8kZXPu6+FYIypfwiipLii/WUL+yFJVtXZ81cIIp+g/ZQo6K5DQPs8BROzj
X-Received: by 2002:a05:6a00:3e1a:b0:857:7384:b5fa with SMTP id d2e1a72fcca58-874dd9f68cfmr9984638b3a.22.1789889676965;
        Sun, 20 Sep 2026 00:34:36 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa107365sm1716383b3a.47.2026.09.20.00.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:34:36 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH 1/1] tpm: ignore duplicate PCR banks in tpm2_get_pcr_allocation
Date: Sun, 20 Sep 2026 15:34:28 +0800
Message-ID: <20260920073428.64168-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
References: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review. We checked all three items against the tree this
patch was based on. Two of them describe real pre-existing validation gaps
in tpm2_get_pcr_allocation(); the third does not apply to that function.
None of them is introduced or altered by this patch, which only makes
allocated_banks[] unique by hash algorithm.

> 1) Stack out-of-bounds read in `tpm2_get_pcr_allocation()` when parsing
> TPM response due to trusting `size_of_select`.

Confirmed, and it is pre-existing. struct tpm2_pcr_selection declares
pcr_select as a fixed u8[3] (include/linux/tpm_command.h:419-423), while
size_of_select is a u8 taken verbatim from the TPM response
(drivers/char/tpm/tpm2-cmd.c:567). memchr_inv() is then called with that
attacker-controlled length over the 3-byte stack array (tpm2-cmd.c:570), so
size_of_select up to 255 makes it read up to 252 bytes past pcr_select. The
value is only used as a boolean, so this is an out-of-bounds read rather
than a direct information leak, but it is still undefined behaviour and
KASAN would flag it with a hostile TPM. It was introduced by bcfff8384f6c
("tpm: dynamically allocate the allocated_banks array"), long before this
patch.

It is a different root cause from ignoring duplicate hash algorithms,
so it is outside the scope of this series.

> 2) Heap out-of-bounds read in `tpm2_get_pcr_allocation()` due to
> insufficient buffer length validation before copying the TPM response
> payload.

The "insufficient validation" part is correct, but we do not think it is
reachable as a heap out-of-bounds read. The guard before the copy only
proves that marker + offsetof(size_of_select) is inside the response, i.e.
3 bytes (tpm2-cmd.c:560-565), while memcpy() then copies
sizeof(pcr_selection) = 6 bytes (tpm2-cmd.c:567). memcpy() can go past
end only because of that 3-byte guard versus the 6-byte copy, so the
source read exceeds the logical end by at most 3 bytes.

After a successful tpm_try_transmit(), len equals header->length
(tpm-interface.c:202), and tpm_transmit_cmd() stores that value in
buf->length. rsp_len taken from the header is therefore the same length,
not a weaker bound than buf->length.

The loop is capped at nr_possible_banks <= TPM2_MAX_PCR_BANKS = 8
(tpm2-cmd.c:548), with marker advancing by at most 3 + 255 per iteration.
The last memcpy source is therefore at offset 1825; after the loop marker
is at most 2083, still well inside the TPM_BUFSIZE (4096) kzalloc buffer,
so the read never leaves the allocation. The over-read is limited to the
area between the logical response end and the end of the same buffer.

This guard also predates the patch (1db15344f874).

> 3) Function mixes goto-based error handling with `__free()` scope-based
> cleanup, violating subsystem guidelines.

We could not find such a mix in tpm2_get_pcr_allocation(). The function has
no goto: it uses only break and return (tpm2-cmd.c:534, 544, 551, 597),
with __free(kfree) on buf as the only cleanup construct.

To summarize: item 1 is a real pre-existing out-of-bounds read. For item 2
the insufficient guard is real, but a heap out-of-bounds read is not
reachable. Item 3 does not apply to this function. This series is
intentionally limited to ignoring duplicate hash algorithms so that
nr_allocated_banks, and therefore groups_cnt, always equals the number of
distinct algorithms the TPM reports.

Best regards,
Yuqi Xu
