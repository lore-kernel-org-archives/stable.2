Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800018;
	b=EweeWKtx7R/UBfrpF+eF49m8ENsk6kahRYxavZhW2UZ+akqryiVgj2zSDytkWOiOWObM
	 k7MQcjodMKpHXAlVxADTm30tyIr759I47Y3P9z4Jaq4HusiLA5cWQaAbwRsNAVPEwoSow
	 hA2L7wgr43x+Xv/fLtss+uaE2KyYyQUcdp+157TIBYdltXoIdHnC9tm6ymNE78aONTkWi
	 lazw9FxjRkLdTG/52R0yduU+oO3u6ocKVCRzs5YVQNZUSlT6Y2LN0puUicLW2h7Pmdi/W
	 P/qHLvNZcNIj3UpGvXWBFnuNORCPR7BPGOhUu2SGYdt7fW9eMmrM4Wk6d9EM1wtGfmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=v0NPf7uK51C+NuOmfq0dUsG7uocw1sLSSOEDM1yf6wk=;
	b=EXUidMnPz8XWJc1X/FlfTvQi4cri78Z+t+6rVtj2fOgOP9mSctWo9gxkPdDcIEkTt2gc
	 UBzo8rwxKRvFO9pJjUlTGFkgL0lsRbqJ7A821Te+RQHXietVn8yM2/+3hU17AcSDj9HNQ
	 0xDAwP/Qk46WcJjKli0wbdlhngcCvVgsYZE6GmosqyWhFzwJYJAuhEZlY8nQQ3IJQSaIB
	 +6U39LUVfC1wj+zpfWjR1E4KtIgB5QKBXfCQIvV7z6Rg2K4JNttHCnpOfiRDdignDR2Hm
	 z7nfU+1wSW35PgceRo2Boqel6MAkndNi9hOP4dm6Vy0cG1uSsUdOpDEowiY86h07ilg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihjL52O0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21878606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21878606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihjL52O0
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e93e0d86a0so768425ad.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800017; cv=none;
        d=google.com; s=arc-20260327;
        b=k7cegZuoLcZ5HrSQBoXyez7QIRujCXpm/xT8Bp0KaRZtfuwSCyH3KNJBCftoys6zcj
         MILuoqfJ2IK+bJ018wMaFVfd3aFNOPUzNLmm9yBK1z76h+2Jz+XS9n5AJpi53WXsoooI
         gGwEybHFouWBTJdGHVN9sUEvfSe/3nECRolH8Mt2Pp6Y5LLw1DqlY5jQG1ORd90bdpG7
         ySnqG6sw7PjjdWbeJ1U9g1odjbCgUtbxLNpI8OrkFwdSftQ2NC5jjF6aJZNPPL9bWVrc
         Xo2nVUnX7rQL+yFLCHwvtAZ5krsqpIVfKhacne65Rko9WCGAW1x0QyBCk40dxsKTK2gb
         HSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v0NPf7uK51C+NuOmfq0dUsG7uocw1sLSSOEDM1yf6wk=;
        fh=ieBPpQjBbzUMJey1A3VKUNt7gw6n4RvNpcPJV+B0UPo=;
        b=pR/1wuo/cxlM/cflQH8tkQKGOPE6UXOHVZWvenD3elwH78dsUuXFXOkuCiCvrLtery
         h1wdh88h4Qvp9ZSXsUzi4LQv0LHIEBId4R0/VEi37FPpTkLjhvnuAmUZh2R7Od/cjz5g
         yn8C0Yc4cJjuRf2rV/O3s4ZaAjXBop3osdK4sYm/Pkg/bECfc947Td/uV7ifBURZeoQr
         hj3pi1ozTa2n6kT1/w3Are1kViHIWJ9BiVEQEpBNqLl5s5rsKV09Mx4kj6De6Gmnvclm
         HK9VoCCPEdJYD31zkPzA78DiJVYFgQgq9c8pOvb5Z6eG2msRtylvRf/7AaikF8N1GGq2
         B1xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800017; x=1794404817; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0NPf7uK51C+NuOmfq0dUsG7uocw1sLSSOEDM1yf6wk=;
        b=ihjL52O0skRU27mZA12gv9OY64lPiLkGxCFfeu7jBzNIK9f9Png6CsthAr4W8zGwFi
         G6Z1OqUsgWGMaSBARhoTyfGnSuPHH1hn8Z0W5atP3bxRFQ6Sp/rxG4dx2SLVIuGyfGz4
         33HUthHtECsfTJdUWVNzWbUijLTg1rfFmGn7mJZbZmha03HFNFCIkSQ6QEoI77W1O8i7
         dxKbU0C2RhYMpqd4V6c4RAa3jsMi9amjvuBHRjVqZeJtoH679Y3Au5ZBQdKg35b7+qc0
         AQ/Ud3ZweTCnAd41awwQHcXF69swy4Jgeib+fBC6lOOmNG4fbSDiAHc0vVZ7/hAW1AJZ
         HtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800017; x=1794404817;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v0NPf7uK51C+NuOmfq0dUsG7uocw1sLSSOEDM1yf6wk=;
        b=ZkX1K6fW+4JYNqtblEl8HzZdv9Vtr2VQg1RhbkKdv0R+QksqNo8pXFrxZziU8fka/J
         bofxdlqiPVbJA+WRJaNBRwKFtPwr8EMKyOqFFs7g+WkG1EF1fh2LdyJGlwiyDvGyDZKe
         dGTHIr+AnbHTyGw+0AKGIXXITE9VXqHBvpHxzx8bYIBCTPIbcfTnsvws3xvH1QB7BEtS
         85irpV0UKsgaQpzPLrHegcDxSiNQan6C4c32Unqu45t3YRbkYOmp9hdRe89pxknXEfhB
         V+fviY6ClSybbm5vVS+RQuyytkdqVMzyyWUiaAdu8RwdQBN1AI0OdcEjtwG1osYfTMw2
         8AOw==
X-Forwarded-Encrypted: i=1; AKwUvByWDY18d+gA+WkiUtkt+Nf/3BXANz0vp9xyu8ge546cACxKa+OhxyEvxUE3TXCXGex6JlWhxbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eoWiuTS/iHp519on6Su1hkIqbYGy9JCl6x8rcXkvoaXTAg2Be
	SAfgLhHViJsKtNaVypLC+Uvlaxe2FXniesI7fdzdnvAs5zY4uTbjQQODnOc7xFc1beWyNo1Eb3I
	RjRQaJhaLggq7ZvoX58gusnrggvuG3d9fzMiE7mo=
X-Gm-Gg: AYBFou3LVR//yd8QUX5EGZvFa0LBFPW/cZFdZDrZL/o9ql59mUQ9F5SAiIgbk3EL7x7
	SAqZYLtLDik7+ieqhwwp0rG/sGZk6Szm3OQJXApbuOnCKb/DMwq2fi7IPQoC9X6XrI5trQo7Q9e
	V0w1d5o/i+i78sKEw1NyX27hVlmmjLQrgIecz7AgZGDRSgiuOzqPKNHVJLpo45MsfvGs1kv8hZG
	RUcmPcNkz9Cqn+BtGRur3Bgsde1ujr/BKCBjwlWPMKtXSrvgld/Gbpu64LtZXFQ5pys7kbRPAZl
	cbgn6tWenwxUkPBbx8JaaroNQ9EDjsG5p16Qu4SDOPf7po4CX2uypg5ReXjnx4SfRs/H446O9wR
	ckzahU8Tae1/Yq8kMbFubmzH8nB8Ox+mYDYsfJg==
X-Received: by 2002:a17:902:f644:b0:2d8:f4d4:7044 with SMTP id
 d9443c01a7336-2eb364ac899mr234912175ad.3.1793800017381; Wed, 04 Nov 2026
 05:46:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103174911.1600930-1-lui2012qwq@gmail.com> <179379596607.2456854.2339185330606278000.b4-review@b4>
In-Reply-To: <179379596607.2456854.2339185330606278000.b4-review@b4>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Wed, 4 Nov 2026 21:46:43 +0800
X-Gm-Features: AclHuK8QFgSjlnkIh2jmVtX_lksuV4gAkSWDxxHqNDiGeOkcAvuVCuc4ZkicWFE
Message-ID: <CAE=Q7=4-eyygfMRttGqPDh-d-2iaU8NojQBr5gJWniTZbLJ2GA@mail.gmail.com>
Subject: Re: [PATCH] regulator: cancel disable_work synchronously in regulator_unregister()
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 04, 2026 at 08:39:05PM +0000, Mark Brown wrote:
> I think you want disable_delayed_work_sync() here for the rearming part.

Agreed, that's a mistake in my patch. Thanks for pointing it out. I'll
send a v2 switching to disable_delayed_work_sync(), which keeps the
work disabled so a racing regulator_disable_deferred() can't re-arm it
during the teardown.
