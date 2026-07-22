Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6935677C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731173; cv=none; b=Atb+bMomYQFTMfMipmbHXMJW0nVATej/Bse5FUmQhKNHO6vRVRap9Ef9bjWiTiBhefOT3H3O/lM6yJl0lXqu2W0hlOIPHbwJPjtl+k/X05KRuQ803RyaYrvLLaQKTI/PgUcWo7Anu4ZHe8c6K5dfT1w1ZmkT7QnWhm8V5VNlh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731173; c=relaxed/simple;
	bh=jcUaMpmjpauStKYFTJAqGvP14ijyRu7tCwY30O35G0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ov+M/MObQkuClj1hk91wDq3GeKvpINxL5t3VITL0HNPkBkB3IGWRkJ5SJc34lr5ceSpfFS/L+qhd9nsdhZ/40PghikUzlkQu1Z7w3NL75dI5M4ABbG5O8nxW31sJj/7UAD05t2MKWJZrMN+BE6gGQxuVISRMCPW0gfgTW2AHzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXGbIdfL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXGbIdfL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so6013490b3a.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784731171; x=1785335971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcUaMpmjpauStKYFTJAqGvP14ijyRu7tCwY30O35G0o=;
        b=jXGbIdfL8Zb/lxli4CvAId0yXLdEopgj1a6WvKs6eQI9OVArOGfnebeyzzQoDAHQH1
         94nZGdxyaT5XaCNiSDhAdiCrEa77X4z8bHRg9RJDDJed6nyY7/i8rRl8sIUvXYL7Nqm4
         7MHHbpUnMAlYvc8U91yv2ilCRSeOmmi72/QyqVTi6kVHMH1oJSsk4jJzorzIEVwVB4wJ
         kTxAYY4vNben7UeeTiX2YRpQQKCygn5zcCXjvtxoWDd3cgonhO6cdN7jAqBw+vhgBium
         lD0XXb4DE+UJMkBGhynUyEjsGY3SNtSKgv/kUrUlr8PtXYIQq4fWmK3ATsFeY1pjDTNw
         3dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731171; x=1785335971;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcUaMpmjpauStKYFTJAqGvP14ijyRu7tCwY30O35G0o=;
        b=PKHVJtrFSRLdd+HOi9gq68A4kr75SBprWjjr3hKmru8tCUo7lJh4o7htavuhd8EPfh
         HLVpWnXHaSluy2EnqHN3mSmQiBuRTMhe7bWd9TFRfDyR5cLuYVXBDn1Io3CMRTTeZUb1
         QGP+m1xHeVKyPbcoY4BEh2JsCiZCaf29F7X2E2xeqSgBDyCrNVSI642n9s3XaLt/JWuz
         +hB7onMMV86jlJbWdoFTBrXRYmPJJYJc62kHwum/KiDPNJnKF+UmYZMuB88z7apw7M49
         ID9tCqWS6LfV48mAXEWkh6aVFKYrr2UGtoDVnxIMrKz30PkdP8VvxbBdD4fpVvNWnuqv
         uUMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQbfLLbE5GcBkRlCiTafVgTCKHVNFnICdQTv9kBC/YnwQOZ+QWSFd98ycJZ+ysny5DAtE0irk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyCiWBN2JwiRuXamLq1asUUEXq/ggOF8a4iGV4WQJfxfca04E
	EsjLRQNWalYTOSUZcdr6CZXCL2Bx5OHkaz/KS/xaLmojFWCRqP/P9gax
X-Gm-Gg: AR+sD12/zpqE244665QbAcZ2+kQB84nMBj6fKM5FmW/n3A1HxigTFlS9pHFewXK/l2H
	xWILmWWvNAhT86M+5je03+V0QNO7/dOnNDazlKkIYEeEmFnGzQvd61TQ97j8orez9u/IEghvjRu
	KUtCHZ9ELsjaan/3eWdlmr4gNWrx2NjPdRxqV39sUmwFs6zLwEdH/c3OQvgqD+7dHdfCENSs9Pd
	sC714gqWY7714YENASJTgo9kfHGSmHrj/hN8qROlXLTzt9PA38t+UapbHWarCic9yvHvJ7rg0JF
	B04pW+sKFDPncgdl//FL8lrT9ZJFLJIyU2MMwZQ0F1Vn0f8MmmaLYU5i6Pn6Sb/N93fIGrPsTo5
	nk3DukukfjcToK16+UclKEB+Ys2PdZVTBhdK7mpgjWFRxHxZIWqIDcR8byXX53+eUyzcLXbK1KX
	bOM+5LibIETl3vBLrRhPiyFZ7lVbsYEQP9ve1DU4yho6U28OZk+SMy
X-Received: by 2002:a05:6a00:12d1:b0:84a:65e8:137e with SMTP id d2e1a72fcca58-84e160b567dmr4384228b3a.17.1784731171148;
        Wed, 22 Jul 2026 07:39:31 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f3180sm1464273b3a.56.2026.07.22.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:39:30 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sangho Lee <kudo3228@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] freevxfs: reject invalid OLT record sizes
Date: Wed, 22 Jul 2026 23:39:27 +0900
Message-ID: <20260722143927.1393827-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <amCzLbCYaj2b_U1S@infradead.org>
References: <20260722105706.1385095-1-kudo3228@gmail.com> <amCzLbCYaj2b_U1S@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review.

I agree that freevxfs has extremely limited usage. My rationale was that the
filesystem remains buildable in mainline and a malformed image causes a
deterministic unbounded loop during mount. The fix is small and ensures that
the on-disk record walk always makes progress.

If you think freevxfs should no longer receive this kind of hardening, I will
not pursue the patch further. Otherwise, I can send a v2 with the line wrapped.

Thanks,
Sangho
