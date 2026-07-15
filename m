Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AC3B14C0
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132884; cv=none; b=JhpW2Cj7JEwa9Y9rj9B4coErpp+MJQXjpcv4cL0psn0EDh+eZGKxfdLvlDZH1Lgu5SuEtp8G5wSn//ZU94dvywLO36VYk7g+AZSr/MvmyvOkvqmdSWs1WYzB+kwLdh6XW0Rg9c8VkBzzLpNKo9jKstirOtW8jccHf4L/2FXT6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132884; c=relaxed/simple;
	bh=whbeM1Ql/RDLLR1NnOzpt+hHqQRUALuIobIOc7I4+VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvXQ9+S+xMMnF/2s5itMLNMkhiZKCETBnmswP4esS5XjM8ni7RMAPujsZEF3+sLUyzDbg/d4UbFHxQVacquie9nINGCB8cKCLG5G7pS7ICdy6pJKd946KrpMDqdK5PYDs20clT1HUrhLbfGj4rjrQFaVtUNfyrONLwtWnQ9oqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=oDyZsiG7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="oDyZsiG7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-476d8e647e9so5359417f8f.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784132881; x=1784737681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whbeM1Ql/RDLLR1NnOzpt+hHqQRUALuIobIOc7I4+VE=;
        b=oDyZsiG7wiOfWqhQ8BRe1ed0vb1ZHCXw4JU7iYbeNZs+nFCbEB0LFbiaYxvz76l0l5
         Y+O5A9/QNrieEHrCFenP0EtJvuFMFYs4zPy5ATNHyRl3XVEN0i/ojqrMPV0iigchW6oB
         FzAjChBFRsmXMhmHW20aa93RUJxcGG2xnfRNJ0yEnQQOnY/85J++MnjJ3pqNOmiZLIw/
         V3XFeo5DQn+dZXcWhI+Nnqed2i2fjXMn1X6tDMNkU9Az4hyb6tIEin+57W2ig8xmzUs5
         lnbZdA3xp4GZ80YIt2lp0HX1RJFT7OB8fTYBze/Y2b5MkInHH1o6/H+tqrte9neBbPzL
         inuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132881; x=1784737681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=whbeM1Ql/RDLLR1NnOzpt+hHqQRUALuIobIOc7I4+VE=;
        b=VcnXK0KZonuj76lKxV6VnGJru0Z7UBrghg+ulzLUP/BFxNaReC+nro1g3QukYNG5WQ
         9lWFtbkWF37yb9J93J8yeIy3Cf5W0lwV9c7tHH7iL3//amT/6fZppZ1zlwLCfUwLvboZ
         bd8XNWblFPytJ5ekfFcbWtAciwbyDAtdRzXhNjJbjw78OtakgOJVJ+lC75G1ofvavtvy
         7WqgDLgY9cB4tXgzMEipneMHlQvZ0jo6Chh+acMT5brL9hjgQy6fz4VvemJokuEL+wO8
         LCWj4BEkxhU/2MrgSXKR4Ibh7+bDU+VWNGDBKLkwzj75VXU1k7k0j2iMtzFkB9CK+47V
         mXdg==
X-Forwarded-Encrypted: i=1; AHgh+RqLxHLC5GQOTPIFq8qC4JchOjjQi4mRLDtwgD6a+5XDD9zJfT4s0ueE7WL1wl+H+nWEUC+EM0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDEqDEnnWbKTsgDuDxQsOj+QKiYXj9Nnr4Nw6v2xAsFP4WUEF
	rrtwm5xnmLHd5fPS91EbMLGoUkNnOZZ+7w4f+4VLts8mLTN8YU+vs/QBcKGqqfidyMNb
X-Gm-Gg: AfdE7ckUsmKzzGZpwXlcVRwgGQAtSdLEA4two4nlK/1H8yP9aK4eiBTd+/vjvlfQl4h
	lwFyuBdiFTsk3v2cwYfyv5GFFr+dZs6pqvLAe1Oz38GB2MPwLFRO5sf8O0frgPMpAyk93HzzEa/
	1Ry2lXh8ONXc5iZZ4BLo9Pch/8T+7zs0UH+qFJWBL4jGXveF4B2wRRJPTpubPyGy8Hy32X8JcHE
	UNACnBBHb21lk3+qNrzdWu5CIb9PmdQObwdUszp8mg4S8qRl0319/VJJRSEdHSGyEazVxH/baG7
	MwA8z0GZ9IpQC0AHtvLyIoveOpUQ/Wj1RG0AlM/MhKIzHjbeA4koua2e3kqD3n4WrFPKE6Vi8/g
	cZQym4yp/6zHcOCwut2mI9Y1xu+t1QrypGYvHEuKB9+k1fRDffmqt9lA+wBr6rvS363PJxgibhB
	c6B8OUq4MQQY1O6Xq0+IPMJpt1BzAsf/015fAUoS7DJjMU/t9QTK0jXdI5wXYrp7fe18Z8Yhg+P
	Rj0nGaV4tzK/X04GyniN7asVlIccg==
X-Received: by 2002:a5d:5f87:0:b0:47d:f445:9490 with SMTP id ffacd0b85a97d-47f488c6b08mr8260998f8f.60.1784132880500;
        Wed, 15 Jul 2026 09:28:00 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a9cesm18065381f8f.14.2026.07.15.09.27.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 09:28:00 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
Date: Wed, 15 Jul 2026 18:27:57 +0200
Message-ID: <20260715162757.1886-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715144752.GF56330@francesco-nb>
References: <20260715144752.GF56330@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> maybe define an intermediate variable to store `offsetof(struct ie_body, ptk_body)`
> so that it is clear what this is, and you also can re-use it later?

Good idea, will do in v2. Thanks.

-Doruk
