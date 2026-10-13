Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2B5293FD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912954; cv=none; b=KJxT2JDjip8GpOW3dYE2RlEex3K1NuipsaL+NkNuojoHGAfr58sTUu+2q/nfaHHsm90AD9w3uw8DGNo4bKuBhPXHxWkOfSKMq+IwBv/LlCthjbWPldjLhuDK7PpbeP9fHjhyeeYK/5gtR7aG8Tg28AfcDq2bk7AgjYvGASNd85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912954; c=relaxed/simple;
	bh=lgDJ0JtWigmwOVnRmfUIilQcNGRXRE2L0/dPjGSB/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUAIvwqhU4oQFZ35nWjXBfhPjQw1PD4PXPfe7nlDxiMQ3faJbzyykPe/yTPzdu0AvFOcVtBInoQkgfMIOtGueelx5qxO3mtv3nvb1oarvriiGOUrYylUYc0S6VxaX1VxQvTIGFdGo00hSFzBlgUKh91WHcRn9CExxK+UatiYb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=e/vdyxsS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="e/vdyxsS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1697240a91.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791912949; x=1792517749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvR/1ROxn6YzE4aqrudO/0g8Dfn5SQqN2g0aeRLqJ5I=;
        b=e/vdyxsSAqay+ilYXvnwdyNbraHvM5qvSo05Pn342eqBME6naAIJxHsnGoVbWCSFtY
         oZl6HTBU5EtJcw+PxCNK71K42J0pa2yoiJVbgs36HqlKKFyznoQcYc1Bl/TNnY6oREx6
         YoMcYy1u5JI0MQQpNJbzpWlqmGiXpeBLm5G4O9/3UUFHw18GgGvkiK8pCkvsIOufthsH
         ASUQWCedgRAtgv/egm1u1NZa3dY4wlNeoyiAjQA0m1ig6Scqdd+BmGlAYGL5YJ1m+5dq
         /SyeUNAWZWF4MhDT1KIXfifZo8WAmjj/JYfWFaPpWoNYSvq7HfTcPB0+eC2gKvYRxCY5
         t5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912949; x=1792517749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvR/1ROxn6YzE4aqrudO/0g8Dfn5SQqN2g0aeRLqJ5I=;
        b=Fj9ltN1jpDg+KLtrpNhTOWVkLg410mY7ra+ieDpEyswxbSDoacTa26zQsDVIm6wZlb
         5DnQkOY/LqEbpvoNPDCkaPpRzB0dB2oOJNmwYAKGTUx/Pn+XCwdrulvVuCnVTnYAjfow
         EBXAT+z337W4YwdeJQ6MxVKkSiAMpCzNfGcGKhG26DX6OVrnmv0C7bQDpIze22Jz1KCt
         94rSAU2daXleMU8QxegKOoilwjKnJoEEecIkODQedGqYGPJgspwJa1WDH7S4OE63zRiW
         lGbO4TGwlYETfun5s5m43nxslwXQArCpvw0jSZgTHi2aG4NtFcQL8Q0uJXrPTB7w3nDZ
         5ybA==
X-Forwarded-Encrypted: i=1; AKwUvBwJVcuSxzc4Y8/0IZFzVs0wPzuHBYfQLrWts9H8iM3vovJjLAuT4uLiL+Xbl/DjfMWNdiJQMP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCsANSEkXJ5UaDAipn+tNWcNtKTpHGi+83YCPgi0fz6PJF4IDA
	Rin4Ca0n43KA9P4A8GJXO7nHHT3T8iT0vYRoczekYIYqOv49zBfp4LaFkRjjG91cbN0=
X-Gm-Gg: AYBFou1QZSpSsFSQ3mi6tVvG5JYyRvvlYu0RKw4aBIbJ0uEaqEGZ3LW8Q0DbSsC3R7U
	v7FYSVDF65NoO0eTqomG4/w26uxc/LbjUv/bFKJ3XH5qCaxrNz0iRi5fd85oewlCrwC5tSGM+Sa
	ZpErIAPGqcySbQSfMCOKzCs2E5V+YdGl24uIOK+K37IXGtAKTgQBi/2JE3qSkE59il6IqmzGw4I
	M3y3hJ4aHgK8Exy5OI4OqOFRvb8yRDISmoaX3NsW48rEkiZvXJ9EWap38sl5tXT0CeRhR31e+mZ
	F3/fGtPjKSnq4dxJb4yQmmhBKcCu2ESfGIIT8CZQCNXs9rM2OTBhg7Z+qn3IBoxj7W7ooOCE/+9
	TsPQJNTKFkzRwceRPVvhr9uZnIDV75q5ol8z8H0WA/xeCDiE76BjAsSG8tWJEDT1FPbywvJa88V
	/KfJsrUb+kAoPKs0wUxBaCbs8VNCadIhP6tL70s+4iU2xo87FWSkUurKNBvia8RiMNxyAyjdHfx
	vW4gTzuZknSxMA/zQjR
X-Received: by 2002:a17:90b:5346:b0:3a8:1830:8b9f with SMTP id 98e67ed59e1d1-3ab3a9118aemr9797166a91.16.1791912949063;
        Tue, 13 Oct 2026 10:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6325e7afsm133859a91.3.2026.10.13.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sashiko-bot@kernel.org,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH 2/2] scsi: mvumi: reject an out-of-range handshake frame length
Date: Wed, 14 Oct 2026 02:35:36 +0900
Message-ID: <20261013173536.3414059-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-170111@kernel.org>
References: <20261013161620.3210533-1-yhlee@isslab.korea.ac.kr> <20261013161620.3210533-3-yhlee@isslab.korea.ac.kr> <sashiko-outbox-170111@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

[High] double fetch: fixed in v2 -- the handshake frame_length is now read
once into a local that feeds both the bound check and the checksum, so the
device cannot change it in between:
  https://lore.kernel.org/linux-scsi/20261013173145.3412863-1-yhlee@isslab.korea.ac.kr/

[Medium] endianness: frame_length is a native u16; mvumi reads and writes it
without byte-swapping everywhere -- the existing mvumi_calculate_checksum()
calls and the driver's own frame_length stores -- and mvumi.h uses no __le
types.  The bound check follows that convention; converting only here would
disagree with how the field is used elsewhere.

[Medium] handshake abort: this patch already replaces the unbounded-length
infinite loop with a bounded rejection.  The remaining behaviour -- the
handshake timing out on an error return -- is the driver's existing recovery
path, shared with the checksum and page-code errors.  Making
mvumi_handshake_event() fail fast on that return would also abort the
FW_STATE_STARTING restart that mvumi_handshake() performs when the firmware
reports a non-OK status, so it is a separate change that needs the handshake
protocol semantics, not something to fold in here.
