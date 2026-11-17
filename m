Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891664;
	b=1e4BaU8Aa8NTPJdrypekCqOKJg7frtcxxGk2RpXfUReZuhLR3d0W6HMPi9NkdEORk1dz
	 SFPzQZTYtN2MJtyTdxXmtoutvhfIxN8c8MiirADCzOhQJK/Nh0eEWGpcOB43uCeqw3ND7
	 f9pG3qP57+TmXH8GqQIrFqOyQ9dRCufFhaUESTEdA1Re37Kk/XUZfqFMGBKL0nc21ie/z
	 fwhK/zQ9rMJceq38VJkdPyAZ7aPDzRVErpVNcHgF75YCCkuH4cSJwIpctrGs4UqJ+gYw7
	 fIJIwxAyAWMxX5IrIl72UHS7UQO0fIRL94mzlq/Olx/dux1jctGC6dR0YmCZNXDeX9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
	b=k/Yzt6Lu2YETkeyvzoo+a6jhyPuFlcQgvLaEcF+OIsl1HLUxvrGAPglKGs4SqLySUcIC
	 mxMN6CQIy4NXx+f1uI9sZU6QqNTL6ySpqVhBM4kLetpkXLKFraRLvX/wqUw2WhP7dVNMd
	 Fw52gPtZQ7RcRRIkMsqPYpZqTGVfPusrjORdDz6YJRQoZNIYH400UY98adOQEnCyFFon1
	 tCTdj8OVst6WI1d/fVokR0CngwBUBVPlQcP1lNPZC6NSbN8HKWXc985UPZ6fpX7780FPK
	 iQGCsInCOIO78bu5TmSOZEC1ZFYw141bfHe0g4GxtWMY7JD72klqkK/Y9s/z7Iv9bDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMBCuBSi;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241E606A33E
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4241E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMBCuBSi
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso2356422a91.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 21:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794891663; x=1795496463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
        b=FMBCuBSi0o0iZVslnqf3UELcTJrbpF/yE/5GBAQFI4DZNYb+tKCJuP9Zm/yHgJKM2f
         nbx3+kS5uLsZNC6i2Ad2wpnKWrhRI5E3qIXCadS023dfOElycHXVpdy03GFLCRVTpV1Y
         7bL9hgEdWop6arRUR47GViYq+326skZZK7GncmLpoIuk4RFE6N4rX7xQMlbnJq/zHjH5
         qNUxmrkk0Offg4LQn0YAXBhpv2PEKt+W6k19mKSiJfoGv0xEkHEOp4EpBYz0hVH19pmv
         ecD/JOPLKR7mo0RfLsldF3NqzAnliYbDKInZw3/ETcKvsu7DBpSFgoSA1brXZloBfQU4
         Kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891663; x=1795496463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
        b=HvBpjxg+vE3uHaXJ5KtAE+9hW1D91rpfkD+xakyC+JLJhMAyzzqDp3Ivkd0qG1fmv6
         KMrVEKwyoxBHED4iHvB8fYGCEizSWo6jY1zBa9ym0T0NP54XfZg+N+RNyckhhkOpbHKJ
         /I9JGsARN5MxWKYeS0LCUcEh/ywI4/tO47y/wwCdtqEnnc1Qkx55TYTBqD1H1DdD+5bz
         DKfuOzkW0vs3fAaOosYF9YEtBKf2cLC5D2gzle2Fc3WIhh7oKlLRj751GRMFHPjj8Fnv
         sCIrDUjYgGm+o9faoaPUbQf4HGysrvhtJD1haqZBumkhJ3R24er+jT/rQOLGGKK2zH+K
         RQKQ==
X-Forwarded-Encrypted: i=1; AL+hErHougxCOmyvimq1+Gr6SI/OHxp3+QZMgGGUWfOeTlLNSrClpjRM8y0qQxHBdNViz9pCT/7yBHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WRfTdIqn5HaKidW4u4ADQLOZ0BYOwc1aBD7zNVLYlVMjtoG6E
	6x0U6QNWpvV8/OSAeVlng009ONdTNZeb1DZNoFGbePVNbYWspwudFHJ/
X-Gm-Gg: AZFdTZfOrEorzLSAlq1uxzNubcztkfB2rOVQ+y7kzMgaBZVnVjcUREySl1lYs2Fg+In
	uD6aqalMtPiQC8XrjiBy94Xi5sKiCl7Cq7b0z15sWlJ/TuZV9HR7Yg37b4nieVxOrlrZQdcsmbI
	phYI5Tp58bJ3r0Rv88Yaa8jRxaDafUDjd9LF8yA63/ju5859GHbnAoCDw/fZuPZjxvyk1m1oZbn
	TAfeEAm5oSqOFGY0Mw9nrM2n8BtReTxhAMT4NXQnNvGuENPdrMapI0UC5O+1qR6R+3J3k9t/7eY
	9iPpGkTHaezpP+DDXx2zmX/+TWP0FRyfHJiN5cLjaAGmmpKcazZ+5Hp7oeMokSm/cCrw0uiWiZ4
	l0sfopXzZbb/RIpUA/l97MyIJualFe6ssCe19JGTImjlxFCW5btQcACUIyrTvrX7Fxf1gvXCen/
	5ru2Z2G49JCSXrw+mI2c859zvtfddxGa6ov912bMimyXRpx0GyShewdom2b5Kbi8k1S745mc4o9
	UAWmoITjcFn/7p3dKHs6mWwzHNEcf3w79zpqfun2c39R3BvWOs/lQKv4J1HUsnXB7+Hjg45i2SV
	QzIg+6o2F+DbABX0xsEo9RJV1Bg7juu0JzUVVNzZszYTNIaAJSv/T0XyDrTIeEGjwiWU+7KNmnB
	5gOEM0G82ZIoPOl9Qz4nPqiJu0eIhiRmOIn0oDlpSIVSiMTK004FBtKAwha+IaPGoWAcrffBKX1
	yfe9twUj1qZ1ZIwlzr/l1S0J1olsbPXNIYauzrt/kz4wjy2NLZ9HI7bNlxWb3sKs5JfeirqsNXA
	H0Zfv3+GqkAKzY1oQNGYV/PeaAYxFm32EEBeNc6d4b7yaEpI2GYJpTgc9fiXEY22UFs8SwBIBXM
	hM0hWEs2Gw==
X-Received: by 2002:a17:90b:1dc8:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3b1b0b5be93mr12038413a91.41.1794891663081;
        Mon, 16 Nov 2026 21:01:03 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abec8092sm2046720a91.17.2026.11.16.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:01:02 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Reject .function on the function trace event
Date: Tue, 17 Nov 2026 15:30:42 +1030
Message-Id: <20261117050042.58677-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <20261114195914.2678414-1-devnexen@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 19:59:14 +0000
David Carlier <devnexen@gmail.com> wrote:

> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")

regex was an embedded struct in filter_pred until cfb58e278c6a
("tracing/filters: Dynamically allocate filter_pred.regex"). Before that the
pattern came out of the zeroed predicate empty and
__ftrace_function_set_filter() returned -EINVAL, so cfb58e278c6a looks like
the tag you want.
