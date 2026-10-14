Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD51FC0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940721; cv=none; b=mM+qj50Qfu2cMxE3KzgEOo+cuSiRcS318kRBQ1cceuCkwzk5xN1AuutLPMXdUSJdHa7UCrDGsq48gkTa3eeGfoMgasFOavYoudzkYjkGISldMQcSctO6OAu15nox2jNabl8Q3Ip4c5V+L3FaGc5gD+oC8DwDIzZj1Qv/hSfQa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940721; c=relaxed/simple;
	bh=b+2Mv1LpDFg9goZtZ1oDMZLOr1tRhG1QhMX5Qn6Q2Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzjOmf54XgqY0YhAb0BNABS+ne+VU/XzZ/MGHR/Ads6Z/135rUZm0JQ+aLSH5olHiZChVgKzIj/rlwg2nWNwCDnpCwJ/TdC5+3nTANnwZ5+fArNad8m8HcpiQBwmQGSVp7hyNiRPxLoSc/jBmMhYy17tr4E7SZ+r9r3lkX8GS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Wy86SfeX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Wy86SfeX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso198911a12.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791940716; x=1792545516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ja8EyJvuRT6hgl8HNzUWNQGXZ1QnpSq8JcxdmHiFCDc=;
        b=Wy86SfeXomgiHiyv7uM1cWpswNtwte32c+KhRk2xe44zezfebC+WmmCc3pHqMnfIdj
         6j+Me2jecZ3XWVn2e/gnWpIQmmj1GalwfMPxVavgQ78FDtp/2wPLSehIier7mL9bIjEB
         jk+ZDeTOnmWtsVXU2TgYcZk5t3vt+diw7vbTYYsbn13SuZmHP+ZtHQOdCc6ZRa/KIAHp
         jl0SLcoumQNq8RF/0bCSYmH4hPeEImKt8WKY2z0elvGae1/x7XAvzevHLfdPJlNf6V5L
         7pu6jipINhiB+6L3V6QfFSHkStVFTfFU4sRsv7oK+UyMhVSMMvE3V7K2CW27GIc48K2b
         MF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791940716; x=1792545516;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ja8EyJvuRT6hgl8HNzUWNQGXZ1QnpSq8JcxdmHiFCDc=;
        b=O57UZ2jJrm9py8qNZ3JkT5KW0tHbgiDMDJYcSeo2+hIfS4/pXMhVy31vmXATvHGOKU
         PYcu/U+n/D/jd47MvBKmHpNipa8p19Akq/68mMxPmSJIWNeTuW2orHduf3b5CZkK0rqJ
         uc/ePw73lftX4DnbXcAy5O2LBqe21ZrXN7pGF17B/cuCU6hS2zTgIIu7n7ScA0xx9SDF
         B7ksRNVwojk69KB3hbMQn/rLgY+ykVoB3ws6gArR6rSyep8DOnByi/8Ssy7TVtXSkQsL
         gnqoM6SyCveg1v/12TNcrCiJ6spTNqYaqI7j1WBes7NFlt3MAIoX1ayGQ4Tf4RO5kT4j
         iyPA==
X-Forwarded-Encrypted: i=1; AKwUvByjbvsx+UcKAHo2+VuYM6BapP2jOm+HwCVHeDNVP5VBWesRUxrVJjpAGTM0y+d64ZnxlShViC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEtIOEAqxAnaLkpr/EDVjGqHFk0t8wVH4ruavO+hTdzLlrxtuh
	XJqYEX8fRtrNRc+hmlSZUNGPQSg0amG4/atzkP0Y/C+4Y8F6eUTnjCC4uzBVFwQVQnE=
X-Gm-Gg: AYBFou3lWlK3nTxlCnOFA0UtW8+tr/f4XBLFyJ45i0WWqwqFYIIOOfGMU821T7OW29Y
	mr20ueGggVA7p4c1OVxeJ0Rmh64BJtKaXcTyt9tU76kMHOcsTlUeBqUn9qzECgqTvjgr0UOQ4MO
	cCLrJYjsLiJUKT7msnP5dUqo0pmsvxuuQcmaog9IX/gOyBqvFplGEGTtMJYsaa6hNkNb4o1a6Di
	AstHaIXYff/9PLCTcGYiwmW0qRk8FCuuIuoFWZ9ea+6Hr9N0hL323EaQEar5T7bNuBlwVi1hc2b
	T9x0PeMxpeOdMXggBda8Q3MxTM6FrFnIW6yV+9K+MKjUl18IKWSTceSK4doQfkrHhMLexmpiFYm
	+UXeLaWXAfThTxiO0eoqxZk0OJM4NB4OjpgWfFHwAvFXpp2dBrN+8EXa3iPlRGYFJ7/8q7rlIxy
	MjIO/h2hayvjSyiJLXzc4VMUYw31zVQV+uxVp8Ohr/tdL9EAzC929T1huvRl9mQNIijCebv4gnN
	a+zr+1bB/a/lcB1r3mj
X-Received: by 2002:a17:90b:3c04:b0:3a7:db88:3495 with SMTP id 98e67ed59e1d1-3ab3a93262dmr12843399a91.52.1791940715867;
        Tue, 13 Oct 2026 18:18:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f3db2f5sm1967806a91.1.2026.10.13.18.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 18:18:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sashiko-bot@kernel.org,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Wed, 14 Oct 2026 10:18:27 +0900
Message-ID: <20261014011827.3479523-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-170653@kernel.org>
References: <20261014004226.3469868-1-yhlee@isslab.korea.ac.kr> <sashiko-outbox-170653@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks -- both are addressed in v2.

- 32-bit truncation: correct.  size_t is 32 bits on 32-bit targets, so the
  products wrap and "total > UINT_MAX" can never be true there.  v2 computes
  the total in u64, which is 64-bit on every architecture.

- list_num_io vs max_io: v2 rejects a handshake list depth that is zero or
  yields more entries than max_io.  The inbound and outbound rings are
  allocated for max_io entries and the slot index wraps on list_num_io, so
  bounding list_num_io by max_io keeps the index within the rings.
