Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77A3E6394
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356729; cv=none; b=CDgSW0JnrAQywS/zRHQrzLzz+QJpH5ZjrmI4RzyGA3iKeTjFcXLye2mB38PQzh2bHhfvTMy5++ZW/aLw2FxA52XqfvRqo0qtcKlPbS+ivxVw+XUyUN3lRrDxFYqc8AVTf4I7LC3/XpCgs8KCNUpICN3iR755rxScrMXiZaflMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356729; c=relaxed/simple;
	bh=wMHBvDevb1HH83ISn4ILYpsOlM3EIIsW4bpsFjH6lrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep6/LZpN81ZuThtd+k556E+gXM8tkJx7uQ8MCWMFudmnQ5/Vi6UWyUuiz/Q5df+j/jgK9MaAsU77/umIPA/c0zTmBQ/qj10VpHqidzpgFf4LIkgRAMzsS1bO4dMdmJ+ulm/ItF/ZS15RUPmU8rd44Es6XUbAPbclhzZLUzQp+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFTLadVH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFTLadVH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so9964405e9.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792356726; x=1792961526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ms4tyV1sL6nNdfngDRnkwbO5sD+oKmpI75kMudnVvyk=;
        b=hFTLadVHMCnwXenpidFM+pmbJumzuIap7cS2jE2kHGuwZpRR4VTXYAJaqr4U0yCZAd
         1PQiuE6dVcJtyLQxefoQbiS/cCIoasSAitsEmx/GqI5JQqozDjkjBMp5KeG5iJyLhhCJ
         H7rtWa0yLfPEK2H9EXmsS82KKrV4MFwXDvOCdrkRiHHFnrqZzIB+quQC0k5tnc6+Bwgt
         I5ogEuL4eU9QHtj9THgV+QZdtpyavme2adPOpYfI5yNh76egL7K4Lqw3PmbFQe3yV/0I
         Uq9M5CHn2jSWzwVU/qPeNyPIXHfqcgctQ7g+DhdYOZtb3tBZ0YrZ0l6GoROzhd2dyPYd
         7YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356726; x=1792961526;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ms4tyV1sL6nNdfngDRnkwbO5sD+oKmpI75kMudnVvyk=;
        b=hQbrvjHvWWgKTSguTkhhbxaKAP3QNfYjMdhFZH8F+aDLHhRXdi3h7nW0NWppaG0gV+
         iAC0PKOiq0NMMxJwzUOJvnGSjrDmmV9Zqo13QwTWY0IQ8EDs9987QMrkLbGxiuM7P3C2
         CobC7bg/b//o0Jql696kpCs3WETH5q1XuLQ2jWM6V+dxndPm9TxhXgbjkXbip+pN3X9/
         1pKr+pvZhP51SpR8MhL30m+UcZJk7k3IM+mCjRt+cUz4SyUyf5P7Ywc9WgDbBv1wuWln
         n/t2oPeYmoUScr2EItlv1JUybP31eYrY4R2wpnKQ7VxdP2PoxBMoolr3IEbLeVMwS2PL
         JOmg==
X-Forwarded-Encrypted: i=1; AKwUvBwhaC3UNE5Cg7awsO2ZOnz9VgLeHE5jgpVtN3dJ/Qrn/daDdJSB4NQESW5h4DulKsbStgbCfXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc4ifbZlXD5ONAgEh4/Vk8k0CPW7rJt5G88qf6s6vjZRV1xl0Z
	X1f+lkAN3ULjZADwZmd7hNtG+pbO+NvfHLvdkl0OvK42tgEFM38fn1MX
X-Gm-Gg: AYBFou1ugsnEH33A+sLzuSRmKfq2CJZ3+AknXzrHAsqPGf3gA/vElEZAINsVLhfsqtq
	+QLKXWwuDI8PBapBTJTNRKHM3A+SkxfQE+abKCniPARmTu1E3loRfAK435lY7n0xLNlXsAQry9X
	7Yik8DLJfE/1HzX23FBPi2wStpdqXDTrUDeC3RPoGjEW0ju7BxVdn79TwwYcaMcWieGOnHr/qTl
	AkQlY/2uSzdBWrICYhk6BH8WmDI0wPZKjAXfiokAdjB4EuVs5uDeR7ZefipkBU4MPxdcBIwVw2C
	N5GuBOK7RKHHD+LZLxvtBELssgbjKrR5y4rH1F93Kk/EyapoDD7JhFJFuFb+ZPxZc3NyVVSbApv
	fVPlKWbhEq6I8D+N1Li/X73Vm3sO4XFn0MZLGIx4MzVJJ/qh6WmcgsOuqnMCXzx9K2tjpCfJxY3
	YhJJOwcW5Z6wZWVIhT0PliaWaQgyOg3bi+GX2m1apvnPu/VDr8nBq0DofkRBClSKidgeQv40f2P
	g==
X-Received: by 2002:a05:600c:3b11:b0:4a1:9661:14b7 with SMTP id 5b1f17b1804b1-4a1d761202cmr112714575e9.32.1792356726210;
        Sun, 18 Oct 2026 13:52:06 -0700 (PDT)
Received: from CachyOS ([176.88.124.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d28b698asm223954145e9.11.2026.10.18.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:52:05 -0700 (PDT)
From: =?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>
To: linux@roeck-us.net,
	mtosatti@redhat.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	xzhangjr@gmail.com,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>
Subject: Re: [PATCH] hwmon: (coretemp) Fix handling of isolated SMT siblings
Date: Sun, 18 Oct 2026 23:51:33 +0300
Message-ID: <20261018205140.34668-1-ycistak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016-codex-coretemp-housekeeping-v1-1-96618c5676b2@gmail.com>
References: <20261016-codex-coretemp-housekeeping-v1-1-96618c5676b2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I tested this on an Intel Core i7-14700F (hybrid, 8 P-cores with SMT
and 12 E-cores) running 7.2.9-2-cachyos, booted with nohz_full=2.
cpu2 and cpu3 are SMT siblings with core_id 4, i.e. temp6.

Without the patch, temp6 is missing: the hwmon device has 20 labels
instead of 21 (the package plus 20 cores).

With the patch applied to the hwmon-next version of coretemp.c and
loaded as a module:

  - temp6_label is "Core 4" and temp6_input reads 31000.
  - Offlining cpu3 removes temp6 instead of moving it to the isolated
    cpu2. Onlining cpu3 brings temp6 back.

This reply was drafted with the help of an LLM; the tests were run by
me on the machine above.

Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
