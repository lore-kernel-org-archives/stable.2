Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600496;
	b=qBYRJJHPhBlBPjm4CecUwZN73oN1Vo/w7OWbN765nUu8pPjICGaPQxUvfImYBX1iarle
	 pEiY21Za4MbHUQaS1inio7heY4YyM+b7zIUHL7XsPIDmAZfpi12Unr0CT9g2knxbkJ4VK
	 vRxoKIsxy81Jb1nnWEKXjlv0PDexzCb+tJayiVREq+KVj2H+ZJuXT3lD7+UDrpiknKDaF
	 eqe+Oz2RfOXpbRvvz80r/pcVTcnZiAh4RWLeTr0XpTTaDv3uEbaKXGZFPphy4qd07fS60
	 /MIUbBhVVM15rl4Be1URVAQ2t7h5qhD4HnvSXsu8Cy1/xWN6oQ1wewpU9IsHULhWMAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6I5GZeUN2pAjlsmZQiQqPXA5FlW6woKT3gvbw936o5s=;
	b=l8aq2F2lwOGE71+3I0OQqPtSA0gZ3AeD8IwDgAYZdQnbtTNEQYNAXk5huVGALT8wGy56
	 w7FIZzIuiy4PIB8gkItV+mDWTRAUhmmtZc8wyv9zR2Hh4cp0NHXFrCstFTBM1hRLiN4JU
	 fbUlzftobXZqR/Q9fGottYjr9UmlcM1+r+dtn+Epswe/cfD97Lmh1F59SjEM+BddD+ytV
	 J+SitICL0v8xtVDUXUWUXonG+76U20ZuRedjTqYy0QstrqO36c2C6FCt0/UQThrNb8HtP
	 G/VGJAARArEsaPx2VzdGmxgRwVW0cQBguLLECdmPreWKQkwWZB92Os8E2cZnRpuUxcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ag3Wv27h;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB7606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EB7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ag3Wv27h
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so1203945a91.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793600495; x=1794205295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6I5GZeUN2pAjlsmZQiQqPXA5FlW6woKT3gvbw936o5s=;
        b=ag3Wv27hyHXbOvgVVdI4F3IuF8G5IR1L3U+Yzi18VBgKxoROt9UdlY4DTa1xsvNAkA
         T8LQKEj+LfTg8ypiLjhqMzIGFPNNyn1La1sy390vILU++K4gZmR7TQbG5/doOenuW623
         9zo1P4HsmyPj7T1VqyZBgb29C0biXt6zBOm4cWvcqd+84wVIKIFFgDptjONcYTeG/DAb
         OfBRQAKfd6BilcH3Hl2G9q3Kwel/4LT3XvFP33jrtrGk9feZwkRwd/1A8o3MAePQrC26
         KfR1qiX0TpCv9CTQ3PCv+L8SbfVwt/WVZlPww7+RW8WZ83ZDt9iYblXF223EjdspGgS5
         TQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600495; x=1794205295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6I5GZeUN2pAjlsmZQiQqPXA5FlW6woKT3gvbw936o5s=;
        b=JCdU5eayrGh3Le6SOvpppYEf3heOe9TfbL1FWyuFIGaCF0BvMXP77WnLs0M+TMf2zB
         /G+WArwSNGOcCp8bjvLlNO5qIJ3z0uoDsdas8nrLmtMcdcleHIY1KNuQbmWd2adxKPJr
         dVcgSwkkWbH2gvTnDArXuA6V1AVz5zcpqWEKMCuYQX3vTLExZSRgLJMZ5Pd4f7ao9eqJ
         blxMQfMk64+JbQYvv8LXu0VS9mZah6O3joceplNueEWaWhgS6wnyUq1WYBzwJBK4/f44
         XiDAoG7hYloXzU1ycOxnQR/TN5u8ZOKkRI713faQlbCywbNuGbwlR4tdPCgvqhikIULy
         7vhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwug2WAyB8Y6uPQGErcXylQk1C4CcSyQIc/i15n+TjjIwroM4EniAAO7okKBPUDXro63qxBR9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9/wi8expJVNkeaD5U5zZ1XF8NFlzzzrGDq9hVv8ofJ+FLLUFT
	5Ym3Tjlo15Q585ezctzF/LAbXOKKVHp26G/wRs3GYjgGnazOQ9UTQJoQt8vYUp3P1yY=
X-Gm-Gg: AYBFou0m5O7NyzDmZmYfbAYxXgFd6kuxr3Tn3+3z/L8xNf/U8/Z1WFB6U3nKU8M4XrQ
	H016BBRiVDq3yJIgCyCS04J6VgvDfeUftABzcnOmIjBHSWvWlwP25ae8l3YdbEnDGYfYk8p0rXC
	GfR5ztO3w91+IGopsmMuHcIIgXzI0IyvSsVd3xulekAc8pehRmjeCUwPuSVRu8vSoimyQgk6Unx
	gw6zDXU+CBu+H7GzaFl6HmO7O97IrKo7zTdZ3CMZcWKiNfB+XHXg/4N7+j71YSzPEIV5owubG39
	Vf+gRkLW7MrqtE3zB+6Rn2FwTJFEShIG6KvPEhLwR7gixz9AbJv+ZP7YDpc2W6tyxRae+nYHs7X
	hw7TUtHUKiurN4mVj6EFSfHBccDsjoxo7hBHi1b3phouuM24hpVKLq4cxYbAlxRsJdf5xjVCRlk
	ddJCw7LxgXgI7ZtP+nlGa1lCKOKWwiBYLvFwCy8/eA2xLNdzLUPY6XC2vT/WXok1GDWNCjHTAdf
	XvE2zokMH81iV/fTBBdTeXLyEdNHdIe0YXfp4/j92Vx0lhxoyNrUsmS77vFBpZYvKaWUgkNtUBg
	e+CrG85Bnfb5HahlZYcKNtz4lrZ0Z1EYDXO1zAGzyVuRE+zPUluQpJmOm0JeKfvRpUyqoChcWxN
	c+QCJrosSsQyzhkjpGbm2g91+PVBN56EsUu8d8Q==
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr7805282a91.49.1793600495142;
        Sun, 01 Nov 2026 22:21:35 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:d115:e4f4:23fd:61df])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm16685858a91.16.2026.11.01.22.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:21:34 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v2 RESEND 0/2] RDMA/srp: bound the receive IU the target asks for
Date: Mon,  2 Nov 2026 15:21:25 +0900
Message-ID: <20261102062125.617482-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <418587e0-f727-4089-bc98-faaeb88ec308@acm.org>
References: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr> <418587e0-f727-4089-bc98-faaeb88ec308@acm.org>
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

Reposted on top of v7.4-rc1 as v3. Only the commit message of 1/2 changed;
its KASAN report now comes from a real rxe connection. No code changes:

  https://lore.kernel.org/r/20261102061938.617371-1-yhlee@isslab.korea.ac.kr
