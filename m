Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613445304B3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915218; cv=none; b=dycb9rZ48itQHiKcuvW5fWVmt+XQlRDv+dHoA2aUaIGXvvUxhjkPKHNAHO/XhcVwxtpJg8v2Yc92G5UFXwx0Oxv36f8L5D1Sa6rZeODFiMjnrdz1fV+td8LDa/epIU+4+M3hglWpmlaI5mscumKhWppNnAgTM3zttGh+1qxZqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915218; c=relaxed/simple;
	bh=p/LeoY8oW4ZcMNr9MNsFO8YGI1ZLRh8OYU4+K6O6RMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nilyc53/xDhz9i5CqCr3NEhYHzgrjCWToErVGMX5JOsEdI6KV6pYG6kaqnG374QtrrJdhbLOCFq8o8kYEuTC9KFf+ypQxP8GeDifTevxb8LkxnwTokD8YOWACkDr9+EXy5eEpHmr6IJvQlO8CQx40+meFuCqbnsPnl53e9FJTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=YMaghwkW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="YMaghwkW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1148750a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791915216; x=1792520016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VhuK/BYJoyJDHlMffiVTc+pqt7ZYhMeD2kIg//kcPM=;
        b=YMaghwkWir7ydsrEDWXUDqx0UgwS0GpOsL/wD0jzcGLiBCpKfz7/kgugEb5hD0manA
         bR5Zhtnx2umoqHQMh67dJwQ5QBzWhqpAoqe5x1588Lxzw3hNlQxL1m3oaxjLLg1Rf4o4
         qwJFqLyNRQOvu6B9gDeSMzEouj6rEbeJjLL2Vhb1gdfKeyNazbYCoZRgFXkrEbUrebu4
         BCRgD3NFDInVz7R0rthZH8bzTqYaDtwhroIbledyliLL7lizjoIDKhK/eI8pY/iLEj87
         JZJSumfhRwADNTE8c72Tj8pl+o9xDSJDu6FUi7CZSFht+N3kf8a0DN5lxDmITkaXxslh
         kjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915216; x=1792520016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VhuK/BYJoyJDHlMffiVTc+pqt7ZYhMeD2kIg//kcPM=;
        b=pfiSPV5EQdIHN+XaRfDoMtoGLUs9/d+ZHwrml87HhVQjhl8ebn+ifwGkNmavenwRlh
         P2UdJr8DMuG8vGdwK1lAVhb9GBO0280YdlnWlWQKCpC7Tgij+RNwRAGC5tokz+UTv+sx
         HVVP6zLwg61JONaF9tfXoTQvC0Vw1Vwfn6JAQLdApTnxqri5rYyp93pSxbb+s0RH1jaf
         WswVKS4AA+TAnzCt0yoNrNEnTZVSEvPMmjQqaDjFDseT9N6nXdud0eXlfcrYs9g0IM9l
         q2jyGnDNpdyxpHlBvnc2st1OK6XmscLhPRAfmsSgZdRT/ENxI439xMe92OSkTmSPzXZg
         vSfg==
X-Forwarded-Encrypted: i=1; AKwUvBzKUUXurboOOIZ66QWJV7CxtN78d+/04Oxg97Cv55PUywm/8xGdZsSUrZJ7VBmeZuQ7bK/JzHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdQzxOcwDhadRE9gGs2hTS6jFre2o0OyGexJ/EsHv2vRvcb5kG
	oAMckGDrAjQtdCJ7ACsbK0ti1eRgt7UOC6FMizbmZf/36WzVsuPxa/3ZTdmlenPVP4Q=
X-Gm-Gg: AYBFou2S934GTqVDQHFmd82OwmDTtzFvMMR9MyXgneEGeqens7y+H198A5rDzfK96ee
	zwaY5RVH5O4AEc69hCXJ2MrbuqpLJfv5GBddKjhbEQgkdPgxEOwYgD/rLtS60px9W0B9Yh0fjgj
	ApIg/XMprv3nE1eXwv3H2gHAhHwJLdPH0O2Q7a6ZW9ahuMNTkHaatU6WG4FXepQcSMwZ9FkWck+
	FkJ7JIHYZF2Ae15PPaGh/uKegryOFh1sHjnfEmBPoevYH9GxTn67lLFhqBV8S3CTDXrL8yW0Kvb
	i/zZ7/Gv9sGoxFcUvbhYwtMkelJU6xH5w/PsSTfFMnT+HUd6UM4Y40lweZGZVUyLLiJrLxLT/y/
	V/wd/NL1uXu2Xx+3IuVr+uxc8MOetXuId1wOhoXnmALxwXIOQXZjEcLPDxIESi1bAvUg4yyWZVc
	MnYDXAx7pl3YR3z7NlZtmfydGZqyT3JW8bWcsqigxZd7/hrUwY6cEa6LmvynNv+gZx1NdLQ2p8d
	a0+ojBRX++RZGztFJsmf2xjCPM6qcc=
X-Received: by 2002:a05:6a21:483:b0:3e0:da23:874e with SMTP id adf61e73a8af0-3e16bdae7acmr12155970637.21.1791915215614;
        Tue, 13 Oct 2026 11:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e082e4sm5923184a12.10.2026.10.13.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:13:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sashiko-bot@kernel.org,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v2 2/2] scsi: mvumi: reject an out-of-range handshake frame length
Date: Wed, 14 Oct 2026 03:13:20 +0900
Message-ID: <20261013181320.3421771-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-170275@kernel.org>
References: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr> <20261013173145.3412863-3-yhlee@isslab.korea.ac.kr> <sashiko-outbox-170275@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the re-review.

I answered the endianness and handshake-abort points on the v1 thread --
briefly: frame_length is a native u16 that the driver reads and writes
without byte-swapping everywhere, and the error return matches the existing
checksum/page-code paths while this patch already replaces the infinite
loop with a bounded rejection:
  https://lore.kernel.org/linux-scsi/20261013173536.3414059-1-yhlee@isslab.korea.ac.kr/

On the two new points:

- READ_ONCE: v2 already compiles to a single load of frame_length here (the
  bound check and the checksum use the same register), so the double fetch
  is not present in the object code.  I can wrap the read in READ_ONCE() to
  guarantee that at the language level if you prefer.
- allocation sizing: you are right -- max_io and the cl_in/out entry sizes
  from the handshake page feed an unchecked multiply in mvumi_init_data()
  and can under-allocate.  That is a separate bug from the frame_length
  bound in this patch; I will address it in its own patch.
