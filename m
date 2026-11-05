Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793868048;
	b=jHWS0w3NvSbVr5ePS7C1lDxllgyRidKKV9xnRiFkhzFC0ymS8gg0wm9WqyuvsiZca8DH
	 Bcmz3I2rcEwJFiqtZCmeDFCEDzD7e/U48SWt/AJzlDFUAq5myvkw1VZ6V1/yBNoE54D7g
	 rqxZrzo+G24ZCpnIl8D1KTeWQU4CqRAGEYsHYxiN+NtzUw3VtCFQe/3PDM4tCxuqcR1ke
	 aR1U4GFfskr8cVDkzIFeV8JouMIME532KXFrGrNy6QV6uehccQPjWB/rv807uAcvR7CAS
	 8jOyQ/wbKiPgnvLv/nAW3c2zfYbwWGJYybmVzjBlzzjwiVipeAInXI97ZmAlLjNmSjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
	b=nr8RrWJXJ2VLrALh2A185qriTb0ihkc4SdJtrX9OgzQ7XOKbDOrwjidY2czs3JdV8r19
	 xux8alSxlTZfUsmj9dOKYlmRX9Vhc2wdOldBA5NFQUF9dGq1CcY1pqr0h9kJzYITIPFA/
	 gVzVxq35RNqyUCKGAsZFbEPiWoPI32zm/rsTqxSdzyivge7EKkItA1zbQXPnLCBZMrRL0
	 nd/A6/u/iH8qbSprBrqCJmNtam+S7LpjMkGVH+h1xTiNNHl5OnD5oGzVb8zN8RURI7f8B
	 iNc1vw4flVeAz4dZbvpUYSz/SnGomqlL0I1x9IpCAMLnpRQhuIme4K3g2Abu/BgYXbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZ+gm+R7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B4606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 142B4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZ+gm+R7
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2f2edb19so147482385a.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:40:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793868047; cv=none;
        d=google.com; s=arc-20260327;
        b=Vnxp2jqXbrmehnpaZ4g5+cG9IBB7PResr1fVmK9aPSmQ/UWgWvrfKKwAZUKlb8tyHo
         49cw9DkQPUC1Ah0oR3z4CGR2Y+pRn7zgXZJcPgJ13zC+/HVzJbLCz7PLPRMbGMa69Okv
         nESF2qIajZ0RtoTvugmqmyWHoZNaVYPBq6hpn7adGn1y81aqCQO3KXZbh7DKGkdNUCqd
         GrHiG5ZY5cc+mWnWCePzrD7m325dSzcK3QKrrQaOpLavooxMAaHzuqlSpYToaA8KvPtB
         qnVZmz1O1R5tKTS0cKG66Io+AyFASImCAa4ZrhOQJC9tA5ApXG7hm7yMi7EtM3p4VJeI
         K60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
        fh=86HMdYy5m/bxwSn5JngRrRLshUt2MLEejH7f7CFG1Vg=;
        b=Iz0qxXB1SGQnbx6Y5ZgJl2ipzj/tJj5fgIc9GEKJLOPhH3jV6jLO0GMguAvldjOSMY
         m67aU8llLQGB4RRvtRixR5uxFQwd4Qx/vmAV4aPIj8euli/hOTg3jN2qgebhAULfZiJQ
         kACmj9sgeWPdYDrtR/FPDvz9bpVRlVEHBaxoXsVdnKHOcVGUvoJy7Q1K4pHFrY7SHXtW
         /fV4ABByKdg9uYjtfe5KYnNsGGwYm5lBcDNxA9Xuy0kjlPduBRtNqmJa1+b+dRXPi/w5
         jYrAQRGmK+vjCnmg7UMPw9KmtESaXKjcXr4QFeYGou9uopAZh3PRLrrCrW8owDUFWdI5
         DzkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793868047; x=1794472847; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
        b=HZ+gm+R7VieQONVY13nyzwBD/v6AqYAUd1UjqdLW1HVQAz2Hmo1rYPGBieA7NC3Swm
         ZPMEp4trRmfqXSqAXkKvkDno5NclXxQEaIGd0t3TsW0uPUJwNn/Wbkxu3tW4uk5bVQjq
         91VS6NxLadMsvtU0RuJo251+RW926MZEhD4A9CZhL2zPpp19RsgAuXkpiT3U+JLsRwic
         s6mKGYwGJHof9ftWapRsjblyyTi8FaXbKgPbWv+j9gy9SzZ8/c7n6O/p8dvdkUGzFyf7
         ngTr2ccjR4y6RaX95c7Rv1NSmNIv8uMExnrn1A3pqrrc6I9UAdLed9MLJaU28iU6uZeJ
         RWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868047; x=1794472847;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DDWemAYLpFySPEhpz6MZnQPpQ/I0i4/WwxV7qkmL+Ig=;
        b=JXAdyl4hTEQ8Wyeh3bVjAaHPB+N1mbWm7CDZM7+sxbEQA1vmfAeBpxCXGMMh3sXIuT
         NWVeX7yNM5/Rx4c122zeIUZYEsRxGoG6qHvJMMrkTS2HE8DfEjxcrBT5JEHY/dN85Ksn
         cSsD5kPF4AQokU31Kir/Ybv3Ur7h45BZq+R7KC77G1F45lLi4W9IPqjmYeng2bcvX/6R
         IduEZGJ/6PqIv5JpmaSeAzhjlbmZFOtN3zLJeW31LRVw3LWl04GmDilQ6Ct9R1kX10Vb
         w40b1PKVNy3VCPoRTZOnn9GyoIksA7gvi4NwAlSnBlfT930gfhMpAeVpOBqxGKdI453F
         zacg==
X-Forwarded-Encrypted: i=1; AKwUvByzall3qEbtSPolUq1js/U2mczVFd6nkagp57gHOnKJkKcUBRfrwzELd6g6jTou9oOmKhp1huQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cBuGfKUY8W4kaU/ZdzoyuEQ4OoEnX8wYUS3xzMrwAmbfabPu1
	cW2fkWOcXiSzIqsw+D+6AJFhROMe0JyeBoV5eVPiMmBz/lL/hxrJPNTLxN/qfZcBvP3YsCAeBR4
	X+PML+Vd0aL9eomjCD9Vpcj7zcJLNJ4A=
X-Gm-Gg: AYBFou3Ao94CxMx1f1qYcHG+X41QrWNgUIASGBVIE2K1HsHK22Fpzl8mIoggFLa8QZG
	DJNpux9g0FUkgKNnvHSI24Zw/1s3XuggXpjrPoTFZIKw7qp7t+RMjh9VlFODtDL+HtooDi3dQaI
	e6mAMwSB8kFc7AkIF2ncUC0pkiH7QzDcfTpsUU248vtcY2gPuCtFBi7YndhmYkhrmrf8CtLEhi2
	1BH0H19CFJFmv5AwjDqMEWaRNMCLLja8OF0cYghHE0IbLaBxPxtzduqM2Y7SlAvvQw7V8k8H/va
	h156f+yBXIbYqylfcnUsePLIiVE/uNI1UwOJsI69Tnx+vuXLXRas5t+Ok3ItU4G1x6QyaRiFJT1
	iTD+fKFv4W0A+H1iKhLYGPAWCAslZ1bzSapJ8wCceFSVNpqFRYpFdTQX1IJUn4kdkqe3VIxy02d
	IOU/uAJ5S+XKxXpAm+tag+dw==
X-Received: by 2002:a05:620a:461e:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9442174519amr2850724985a.82.1793868047051; Thu, 05 Nov 2026
 00:40:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012220728.14861-1-fzeruhn@icloud.com>
In-Reply-To: <20261012220728.14861-1-fzeruhn@icloud.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Nov 2026 18:40:35 +1000
X-Gm-Features: AclHuK9rSpudI5xPUp8K5FrKXjgGz5azoUEdbeTlyuitC4ycwsyAChqMlEoBybI
Message-ID: <CAPM=9twX71mND8dKKjO8=ZOKAkcVD-zcpvcMEL9hv5z5b_-k-w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: keep MOT set between messages when
 no_zero_sized is set
To: Finn Zeruhn <fzeruhn@icloud.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 08:07, Finn Zeruhn <fzeruhn@icloud.com> wrote:
>
> When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
> address packet to close the transaction, so it clears MOT on the last
> data packet instead. The check only looks at the position within the
> current i2c_msg, so MOT is cleared at the end of every message and each
> one is terminated by an I2C stop.
>
> This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
> messages: a write of the segment pointer to 0x30, a write of the offset
> to 0x50, and the read. The stop after the first message resets the
> segment pointer, so the read returns segment 0 again.
>
> On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
> extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
> reads back as a copy of block 0. The checksum is valid, so nothing is
> reported, and the connector only offers fallback modes.
>
> Clear MOT only on the last packet of the last message, as the commit
> that added the option describes. Trailing messages without data are
> skipped when looking for that packet, since nothing is sent for them
> and the stop would otherwise be lost. With this, block 2 reads
> correctly and the native 7104x3840 modes are listed for the Dream Air.
>
> The same problem was pointed out by the Sashiko review of the patch that
> sets no_zero_sized for all DisplayPort connectors in nouveau.
>
> Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
> Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>


I've applied this to drm-misc-fixes.

Dave.
