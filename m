Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD7367F3A
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327301; cv=none; b=br6v+06X24ArjyUiEmbPJ9zc5ZJFAPL7SvTZCaWAiPAb1mnMmx7uwNVDJNf2cAvoY+pAaBzKoYSdKdmXzWSCa7KR1gS5Mgdty2CMWjbBh7wffFVDuFU0it2GqNnj8Jp0v9yFbVUeldm8LxPqGxfkvdyVWPRrvR0Lkh4nShmxgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327301; c=relaxed/simple;
	bh=jAspQQ6QLSyolmznrEa6PcbeUeNNtkpmVdRb8KClrg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQORBgWqLp9eSprblYRwQmm/dLrst3mXWD6ro6xC/ZBr0R6izqzmG9wu0TABncVwTaREpw/Zudg9V+ZauS+Bpt/+WHW62nOPqKNUNXv1DLmr+cxmSCI7FQC2rRdTmP0kTbntJWJqmxPCnOJCIPd9NuQgk8F/Dfj+rEhOw42EB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNSF0uvs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNSF0uvs"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-486fa798933so710505f8f.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327298; x=1789932098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAspQQ6QLSyolmznrEa6PcbeUeNNtkpmVdRb8KClrg8=;
        b=FNSF0uvsW6ZUyvJeG3trArx6QOpjxfVvK88dtUJ8lIgGESP1hnUdrxpB6qGBfgYCpN
         XN8F2x6XmjYW4/T9kPCw+Tbyqf9mfoj8i0EgOaLh8Dw4MC65z3WKBtHdoToL+yOCHTBt
         QLK7t6Lv6xpCnDwUWuePLV/7Cag5RT51Ej7TYSBoLkMRayUH0G018Een3hl4fYsj2ihl
         BBeVgK7jX/7gNwiBKFdwfuMQjCRRqyLH3J+lZZfDLELP0yJTBg2UYpSfcGSqeM9O2L8S
         ndABfUJXp3zwaT9icAEb4sdwj/hyvwYgxpNEDd7vt0UgOeXE/gkaACDvv1OtQ4FzKe/J
         BKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327298; x=1789932098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jAspQQ6QLSyolmznrEa6PcbeUeNNtkpmVdRb8KClrg8=;
        b=O2PpURlsK2LEtwKYOE0bk3TOnCjaXje009nfXd/ZZMnriX/OyRg0UQON9oPZcD/9Wl
         wxXr7m5HBtFUCb1FWMHjoFrg60lyNgPLC1ybxNn9ME2M3AuKfHmbNhYjRcDSD1Izxowh
         33YTLoxjzXSOc9wvvGsZXQJ6EEEnHSqu4W1d0NPU83HjWzSx3gxVQVgMKffgImVdxQGS
         6BwZRmzPmjn3h+NlQQecbV6tIW3qMWyT55ubnkiiHChJto1G4TwNCFFRXknaTj31Xz8F
         ZkyMhokEmSJ5ZJs1xiLlZM2ykeyaa9UVocdPIc7rN6UnOX06jm+ziNwTIzNfRYorDYyR
         ATEg==
X-Forwarded-Encrypted: i=1; AKwUvBy8PP/mBylZ4gOMw17yumzjlBJ4TPd3iTYyGMQ5U2EiDmAzBUyi49IoOoITsiXxz7/AL3V9Ia8=@vger.kernel.org
X-Gm-Message-State: AFuF++kU4cxofHLPIXgJKg4yB1RpOdfLq2F/2pubR/jpN8PZ/PoD8oOe
	iG5LJ8tE4eX1ws/cx/5kbxVGhvjl2TGBVTFoy1KyPJoo38Dq3JX9hkeq
X-Gm-Gg: AYBFou1H2LW70KKKMfl+mZTWDFlLFUi05jU21xWKaLN03iuah3lgMFuCQRxgUk9dSFS
	j0pD0d5BTG5R3m+LlaSWH1u6e7ZxQeQtDVDjGqfpyBZi0aTc9BqxflZHGbobOtqCKmZViaitZWW
	TXVwgNeebpRB2XytqUsBgY6Ysf2WVKk1jJOYoqBIESohf9EPVkLkeRBs0HP1U5xJLhrrm1Zm8IN
	SXwEqkN19SVvKZHj1IOLk9KRkfgtl4YcEUU2RReO5z4SqvMJTfnVEnMCjvJ/UPrKyZUFZ7+Y9PT
	sOgil5Upvxgwsgz0M2GFBchPmLbz2haqIZat9N9MMfL3z8Znk8rKIuPhLJBWKdTqAgJkiRN/Sf0
	hB7tScDINmib3XmOZpGydViBYXn48V4YMGt4iz7861dcVIIMBuWyvHyl+QI98FlatTopyelWuvo
	I4A3QOlXKddKh/4OmiLo7OVv25PeKp77nMp/3Azc8TWw+IFJ5TCoGL5pIH5GsLzUxVru1lTqPYd
	rSSrzmeIL+Tu2IGpxkhQWGomHkRej5jKIj9Ac6l6tch4OOHCjOCTuw6eM43Pe2QlJMlg0ML/260
	bps33SCkDOdJPuBSI6z9FLxSDpr8fQSx8yXF1LebY1MFUBBovD5PszwWrzTfYHgFb0LzeO4SuKA
	2bw==
X-Received: by 2002:a05:6000:40dc:b0:486:f614:dd0f with SMTP id ffacd0b85a97d-486f614df05mr8750281f8f.52.1789327297885;
        Sun, 13 Sep 2026 12:21:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm20244963f8f.35.2026.09.13.12.21.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:21:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 0632/1191] bpf: Sync tail_call_reachable with callee state on entry
Date: Sun, 13 Sep 2026 21:21:27 +0200
Message-Id: <20260913192127.2336-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065602.449560744@linuxfoundation.org>
References: <20260912065548.086904252@linuxfoundation.org> <20260912065602.449560744@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless 6.1 backports of upstream commits
01793ed86b5d ("bpf, verifier: Correct tail_call_reachable for bpf prog")
and 54c27ea6dadb ("bpf: Fix tail_call_reachable leak") can also be
included.

This patch resets tail_call_reachable on callee entry, but 6.1 lacks both
the direct-tail-call initialization and the parent-state restoration it
relies on. This can leave the root program falsely unmarked and make the x86
JIT omit required tail-call counter handling.

I reproduced this on 6.1.188-rc1 in QEMU: Linux permits 33 successful tail
calls, so the test must stop after 34 program entries including the initial
invocation. The unmodified rc1 reached 35, bypassing the limit.

With tested 6.1 adaptations of both commits applied, the same test stopped
at the expected 34 entries.

Thanks,
Karl
