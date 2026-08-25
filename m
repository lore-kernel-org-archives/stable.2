Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8F3F211A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654767; cv=none; b=bfG6lvDIesj6RWmrn/DJLa998/6Iu+B3jZvaQUegZat2+ypP0dGNjk8V2mA+jjCaaTL9hYVq/Z8GSY1LyOOYQasDj5Zi16r3Bza/N4f2xWLeC7E4yIOp6tUkTW8lLZjTqSnCTFQ8UjHI4N+oRKusmlyvGePejflVopIzISR5Gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654767; c=relaxed/simple;
	bh=KoWnSXBGaCj0jbCTvpHVOuxUQJsRstO2RferBywnX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIzMajDHbzhE1Bf8KhQVij5gq4n1ET/FCwO096CK+sMEAhXgHpt99KQM927y97IujQAiFeg4pOvrLHHvxG9MZ6UKsKiL2F1XTPGjEBnPYC04Naq7iJ3GHC/B8Mn6hHymMMKlqzflNO2J3DXSI4iSt0k0Q2xyzu27lfpkDcq8mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHtFIvj+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHtFIvj+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84847482584so478880b3a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654765; x=1788259565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=AHtFIvj+/BQoViIcSXaft0hLMxSXaiwmktIVpdOYjaXN/Ax8LzXgnN6Ee6ipbkHDtp
         qLGHd1InfT8gELovqTATjtQXnx1BOzcMONxuqj4+Uq3x0abr3WTnGhRswGQMUtlAOLps
         +5AhgL+2btxtvntx462ZCXyJCiCork6jLKW/uwp9+wGt9vl5NuxaxdkbbolEm59wOfoK
         hqcdHyreG28jgKvbF535nXiabcEEoRQ9cQ8YiPGhn1tvhTggXU98KbGVgETTY3IdnM3P
         FUnWinXPGt2iwhyIYFNIapd1UgNccqDRwKolLMwbEbMcYZDGzE5xFqAzTeCUrByHjE3g
         bh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654765; x=1788259565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=VYsciTTGIE1ZemvqRP0/wFlTWNXpysqMWrBkrpCQtDeeyEsOOWyOPIXneWf9qVhGeT
         0crzbz7WuMQxQne3vwlN3ssN+GATYrYD5axTuXLFgi0uNaQ2Sm9LrxVsi3TlIsSdmprA
         2sU1dMmTaM2jMKhk7ahSbtrNTKVy8vP/9gvx6oTmk+eXDyHcFIBvf3N/csIvWfGZ5BwU
         vp3OiWnlh3f7/sHBaqFxPHJcmdanhTnPXEVkFs7CZ9zyjP1xNP4z8JqVvPQmC2aMp2hL
         cbtro83LMr6YrQCtie0DA2MnGrlsy9a/GdanbT+HI8lzJOSKBaw7YHYJ9n0hRXr5GsDB
         bsjw==
X-Forwarded-Encrypted: i=1; AHgh+Rrz4YMA5e/b+tBPfEJ6rzz0Y+KzakF8PY41RZ+tlTiwXUFnmVzYikpn3X4n2eQVS3EiSicSr5U=@vger.kernel.org
X-Gm-Message-State: AFuF++n63mzoCD905qh3WiPw87pXf40CTMdO6v3EO/mtkCAFkF+Trd2A
	O++6YH2YmEVQ4M1YVULxEg3UqTlp4Z4xRy3V2GS4i/vbZkbD09qE64Mp
X-Gm-Gg: AR+sD10qFNsOtHtmOOFa3Ahmy6uFesNiB87qsW5N9cY6EoAWPdYA9ICaNYg9olY1umb
	L42sQuX+l5U2RQ0BWQ2r6BNeXdicT8Egq1hPwFJAZy51NOJvplxlw78XqYvSP0muHWBtMyzgoDC
	eVSKfWppCyaWaKptv3PBl+NL9EgDCmaLd9P1DPOVzBOJSXFKYfDzcEOOHtgDYzRb+DJoVyfK1ah
	ulUf2/96fCtgc/9LfJCR52ddPgCFGpvxsONR3tbGeRXHTrpV62gThVw2SytG+QnxMdPJfVjZBY/
	11cVvcGgTcFOXVJfhF4NGs5pmUrG+ZVMhE382uVywBKK7LZPkkdxtn/V+aHqqP1hw5iOeI6dlZe
	dFDuSyck7Ad245BUbsBaB6dkiO5tLo3K79eseutN3lnRjJNuYQQyz6Jpg807pwlrjUOujJ8q1nS
	bIVPTpZlOWDsEB5Siw0g8Al7usJ8ICKPjTetYZ/yudj44PTzjSFDwSkfEN9eBj3ltL4sZy2HSJ4
	d/Ei9k48s21dWk4FTGw5hojL/qDlE3maOXvhPVmQIYAI7BRpx1pMiUK7qJ0P5FmdQhX1h4zbulP
	bSnlX8EQOsUeWjjnf6epi2u1
X-Received: by 2002:a05:6a00:1256:b0:84f:df11:b78e with SMTP id d2e1a72fcca58-8523ba7ac8cmr6307085b3a.2.1787654764552;
        Tue, 25 Aug 2026 03:46:04 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef09d4esm3031755b3a.17.2026.08.25.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:46:04 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Tue, 25 Aug 2026 18:45:57 +0800
Message-ID: <20260825104557.15951-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-2-98lawweijie@gmail.com>
References: <20260825061027.105062-2-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by the v4 series:
https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing these bugs and I should have
acknowledged that in the earlier postings.  Neither diff is changed.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
