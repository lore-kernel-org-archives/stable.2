Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1334E01EB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780417; cv=none; b=Uw8gZEBot5IRfT6KnaPf+ORP9ZS2TTGEC50BitMEVHSi8cGtivOpojOBS/1WpfSouVuteSyt4M5vGAuXzd6wH4MUFElLgtvfY/9HqCmISGRrCNxnB/5h6U+6n5kS00dWIObvZMx6FEMzMn9pmxhCcPctVF40tH2oN0lkwqvrNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780417; c=relaxed/simple;
	bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDtHban+f6QiIb0s1OqrGXzaEz3Dwt9pw1BVJt1Xlm3qhnUidr2SqLXaWsIwegGHI1KtuxdRlfdDTpXjb9T8FmW1fmAW7mZRVq4PWdUwjcEB1r4Y91b8sHmc5mq9zuXuzMDMwYHzEvCQyNmk7Xi3UkYUMVUn7k94XcUvUKpyrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com; spf=pass smtp.mailfrom=wirenboard.com; dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b=F8RW3fmv; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b="F8RW3fmv"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b017a3be3so690458f8f.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1790780407; x=1791385207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
        b=F8RW3fmvSsQEBBFMGzNQe6AKDFOS07PNQnNg5iQlEU5mPSBLnyFhBhG1Z0OuteD7OM
         LiB84yO/xsbCh6Chrcbutrbp/Ft56velzW9HwHuBmF+E4qzrTeId+Kf8TIy3T/7FHLeV
         eQZ+TQ+Atf+9sIkB3u01NheS9D6lwcZAjySsHmuzJaKcJplYfgBtV+edjsuHDj50lU4q
         oN6cWXcenuPVk5+1IHSUBVtTcppw7gk81NmR8U6LWOpUZKMzbETs4Gf9nWMkXN22pr9V
         3Bx94BXSD85E+BOmxRpahtV99D9vYFvLCNt7aEIQuVE/++J7FpWJtGX7qS/yUZolgvKd
         90/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780407; x=1791385207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
        b=tCIKhSsMcyzCl8b2EKubfMSffMZ9oWBONhA7RHn07fnTM/34nUHln5wW/HXUJOf3V6
         B5mf1Xk7hbmMqwu/M/oCCId1fAc+m2JZw6o2MbkJ/YmOHvzb/hjisWv0Azh53KE7rp7N
         GysQ/yiCubzJdWGgMnyymWX6uocExmTVmHd+NMn6YW32Y/m8dIbVSA3nc27iTC4s8yRM
         i5E/Hq1StJ+mjflwzYtxVdO+8pgrewJWvfowv2y8X2sw/JdOHKX9gSDeRglcJyA0diph
         m6E6OYL45V7vDuwcuwDaStQWvXfr7Su2bHQvMPG48yBFnjFRezMURucR0LD2UiG/3tBj
         GsIw==
X-Gm-Message-State: AFq9FYJz1aMgtJfhkNsy4dCjxg3T+Vq/i/+gC/54BFrnUKpa9adwPGFa
	VklMR/Yl6jSSv8JnodEHZ7SjO3LTLtn2wKHFA/R6VSCcRpsz33vLLZgpVws3o7nJ0xM=
X-Gm-Gg: AYBFou0Wp4wlhfT5O46pWRH5RIJeuZbV+Uv7jXalpvT06QzTalzi121ETjjeaA+GS2I
	wtUVYRhvDdye8Y9qDZtN0rOGspbpiJHG+vWRbMjOc6KZJQGHh5KT7C+6m2+uLUr63fC7PmrVC8e
	G7KEClE8QYkehPnSaappZPfgcAOYtfjYlD8h2df9AnHp7hiEOc883T0s8aiIABM+UgxzBWN5eb5
	ZuNvLUK/elTocqUwWYVTf4ubG4K1WNR+HL1z+K/vulB0GdYmROITdNbRwqDekzoGS9/jUt8XUHi
	1j09PHNSHu+gv/bd65qQFPRfmnkILNX8rvTHtxxBLF73dRXkTM7pFawaJXjPx90blqw9CaMDZ12
	Pe7RBtRQJ+t0Dda4iic3bti0s8A42C8GAoTI00+TRmYDDCvcnXDML56sY53kdLrzDftJP+89JBh
	3hG8HUP7ym+lqR4ZJrrlI5+lm6ph9gwhDI5cvPvDhBJPQCbkYgnJPVt7fFn1BJk+XNnD28vDZB+
	5gTZKIbyipXqDbxaVEltT3PV3QHlYGY
X-Received: by 2002:a05:6000:2284:b0:488:8859:b0dc with SMTP id ffacd0b85a97d-48b02554433mr3462451f8f.56.1790780406941;
        Wed, 30 Sep 2026 08:00:06 -0700 (PDT)
Received: from localhost.localdomain ([85.137.25.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b028b237esm4605274f8f.0.2026.09.30.08.00.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 08:00:06 -0700 (PDT)
From: Ilya Titov <ilya.titov@wirenboard.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	linusw@kernel.org
Subject: Re: [PATCH 5.15.y 3/3] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Wed, 30 Sep 2026 18:00:03 +0300
Message-ID: <20260930150004.37497-1-ilya.titov@wirenboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930111402.1206529-3-sashal@kernel.org>
References: <20260930111402.1206529-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks good to me. Thanks a lot for doing the backports!
