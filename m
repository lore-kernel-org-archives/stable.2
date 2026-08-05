Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3A36F8EA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955092; cv=none; b=inh3md/FyEOfBqkrfZd2eZ7P8gzKhl3XMjXAanTOBE1A9h4D06kJzm3IOfhm5OTXu88kdKaWpvdbnpcy5QfMrtQgDKQvineqYXCyBmo9EBKxAA0dh2fWo93qLfL96kLy9C3LurMBDh8MFgMFdzejVIAEFLEQFfpDNAwTPr/jTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955092; c=relaxed/simple;
	bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff+MRQiyo7tdL78cLgXaoAVmfPOK+Ki0I6vUn/dCrdqtE47w7xk3UEHaXegK79v/muI5jAsyr++wVmMEnBo7UNryKetGzXhngvyfMzbMTfUfT4lt5C0m/n/iWmoWqWeUI6Ch6yQqmDPyTvBiDbokzF1NwJxK1hM1e78nWnvJRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMS/x+TP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMS/x+TP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4798bea72f9so844847f8f.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955089; x=1786559889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
        b=KMS/x+TPMeKU8y6jLUrpD2EPDQdu4U6Uv8XRHi9ZrfATFRw+tJ8g1p2OjbM/9HuX8O
         p6saWAlwn3v6USLD+1fnXoBrlPquxaaNP7wAYrhaZ2CjPyDtZKBwJMyEUGrPF/zLpbXp
         z+ltHd/sVNRXK9mNJ6YCw7uBCvtnHCJwUzuwq1enA5YQO2aw/CNJFpgViZz2kBhbRlQz
         G6be3QX7UM0gMlr7kkaIA4BuMFWrE3sc7+NQkRTvWmf6+T6NKY25RQau5my6cPVVuSd8
         JA9IbLAxiz/bKHyCmReUMfSHgMi5H/iimJqcOJTvTY0hWr8wut5NVj3q8NYbmWePdjBY
         fJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955089; x=1786559889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLKKBSXUsGhyPa2pLH2oRJo2N+mOGa5effE3cKzB+pI=;
        b=Sw22kNNlCeBgSXfxGrKSDgFED5v7S5J615rvDZOcjKTV4KyDwvbqwMkxnbeg0Aieca
         PQaI8T3Kc5rt7sks+Uwg2DiyjEmcG4/gtmYgcOhQ9aCS8hleJItFAGyts4NUVv7RyXu/
         y05on918WnxIZhwc1M94/l2O7s0ZuLsnlHnT57Z+M/TTziHxy0ncIlIary5otJagiuMt
         I/5m52xfVA8Fc2YJDnmA0JIJpfpZT13fT8LV49C7lMNYXQqGUXT514FKg6wHdxHiNZ1a
         dCvplbwsw6CpADtO4+6pH6fo/3SKldR8lUvCD3rLSuk3L8lSB48qP/fzD4PZtsuNWqm1
         e8pQ==
X-Gm-Message-State: AOJu0YyTtOBhoKU5u4xsfpzSL66b4uH3h6uHejbfpeBhPB+uEjv95D6h
	5v6sAq1NaiNX2LHqwtwk9BvvmFdeLosjiDaubKt6aAGh0zCVdPblIXHR
X-Gm-Gg: AR+sD10gOt3DguF0m8XbUoj7AEzHfK96dvrSsV1hoIrpbQmFpZjPcHVLoR5SPCcc7mV
	WpaCeGu5x3Bje6ze3/LlIW/KDLJ9Xpp9mp/OeQwznBm4bqCJobSUt0YZLW09WVQ90sgrL2M3pEP
	gPSU7ezEYg0zanzXljO/w/yVxV9OGZt68bOgcctL2kkooun54xPhRC7PJKsQaanYGRBy7ZHDjXj
	AA/z6Y5y5B44dv2h1oMZnhSEyymcP/B5R0x+y0AmMPZ3wJY5XUMFQV8gLYxqeACkDXRm6WEIRPd
	NQo4BVsLhly/uiVff/uRAFxMxz90oE4r7mYZM/8mh+qa6/5oFpKMgq+VwNzcUYmOLY9/pgvMIOk
	jQK8qo+lm8Z3WGt5Wo8bYp8Y/HoW2Qrldz4LHr3mvP/SNvIpYuzaOzeWFRJhA08W/xSNF1w78lF
	PLGJIddyZ8+6jeRhm97yDz11PWB6TRq8K612QJ/N/pUzgUfXkFEvn7yGMyS7V7edQ=
X-Received: by 2002:a05:6000:29db:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-47fec4e8f84mr11710292f8f.4.1785955088957;
        Wed, 05 Aug 2026 11:38:08 -0700 (PDT)
Received: from arbab-X395 ([14.1.104.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e5efsm11050977f8f.27.2026.08.05.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:38:08 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yun Zhou <yun.zhou@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Arbab Haider <arbabhaider6494@gmail.com>
Subject: Re: [PATCH 7.0.y 1/5] net: mvneta: re-enable percpu interrupt on resume
Date: Wed,  5 Aug 2026 23:38:03 +0500
Message-ID: <20260805183803.118565-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805164000.stable-0008@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arbab Haider <arbabhaider6494@gmail.com>

Hi Sasha,

Yes, it is. My mistake. 7.0.y went end-of-life with 7.0.14
(2026-06-27), and I overlooked that when preparing the series.

For context: these five patches are backports of mainline fixes
that I carry in a private 7.0.14 tree used on embedded boards that
are not moving off the 7.0 series in the near term. I sent them
to stable intending to add them to the stable queue, but an EOL
branch is the wrong target. Please drop them.

Since all of them are already in mainline, and therefore in
7.1.y and the longterm branches, nothing further is needed there.
I will keep the backports as out-of-tree patches for the private
tree.

Sorry for the noise.

Thanks,
Arbab
