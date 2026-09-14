Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7E41D639
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380560; cv=none; b=uCv8rsalggeC3Ykut/qvAunenaLz9CQwLafA6hkrGugwB4nQxi4CdZOPmgrA7VMNZdg+X3LXTKCTelPm9QFI3tJBm7dL0WsxHDo+d7GPuLVKcvXM9bu113mwhV6OXAmp8HibZA96bKyo6EGIfWId+zKfBox1iRPSzp9VdlOrknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380560; c=relaxed/simple;
	bh=orZaZWZGvI1tCeE19P5a3V+UTWdeZC4NNvIK0PHV8PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzOXmdT1iyr9c3heuW4Fg1O/Z29I3L6i8Covtixa54FJeDrBfqByL6IFhZtbJXWygKxX8OGgy6ibommQbJAuDppcmAwqeAjm5gXyso5oJrK8dPKhQZvq7PpxoV4z2gG2vENFRlf1TPvNej2pmMdX9BRdyUL21m6qidF6n+AzyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ujm3Wpb9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ujm3Wpb9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so33714615e9.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789380556; x=1789985356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiDtW76OrPQle4sNBKcnEO0egtcxluIwtMmImWhO1Fg=;
        b=Ujm3Wpb9vKVRXQ7UVUt3zGe3Z9tE9l0KDjPNBvMzeuG0XLYoG1EyHijUIVV1xN+6Dt
         ibCVIth/1LR44ZNGAFi34eXsAgIqtIqCIeO7yru5EY0i1Nh5KpCKy/LpGSmQJtvS+rtP
         0lux8uLoSPylhD61f2nzAZbP5CrIRo4gRzw3g3oRJU1WN2tONcddYb0uJeChDzEkQ0XU
         8WvgKobntcVR2YA7Qr8/eh3CkxFa9WJqrjX5wcntZeznvITVXmznCLs6tHAV3oDBEvJh
         OMCKPb9wMQ3e6Mhr1bkyhSS3zh6c4p+lqGtWecIFjC2HsDmYAvzwhISsDTnPu0sIrYrf
         55JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380556; x=1789985356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiDtW76OrPQle4sNBKcnEO0egtcxluIwtMmImWhO1Fg=;
        b=P6QFrPuygYj4AV3WmYxPVvo/crlsa4p/YvSxf9cfcXTU+HUr8WDXmUYe8D1dbpgSk1
         NB/v/atVrYQTTloyS0sZkwSiEUmTtU3vQ9tvEBAPVmO26SGxOy3pZ4cXpyUYa6HgYTh/
         l/MJAVn7FIQdgOK0sYweCmh89vMhiSNRN4g6odpHhCh8kUc6cp67f9KXpLY0O8p6mFQF
         zneJi2dw5Ep2YbjRdUu2YorPt+a0Kg08BmpO/O9Rui10AxJjqSzYHO+sHydLQefxvN2t
         1et1JStZps4/h6cZxfQtc05Y2Se0PaBWvtp1136RyvP063OMSsRTrLXor9StcjU3BJ73
         Oh0w==
X-Forwarded-Encrypted: i=1; AKwUvBxXipe5QZ4GrtAqPxOcDuW1DzMxiBFMbE3bDxh+j6/pEnk0Ktt848XswW41kPsQANN/ShpZ5CA=@vger.kernel.org
X-Gm-Message-State: AFuF++muMZcNyVzrmfQBaK1QhKSLLJJuIrodPDvY44vE3qW85PdU3g4S
	06CReM3tm+nImR3PDZqJk2ISTv/1sE8nIXL8+EOAhR1OlWEZs/7HeJny
X-Gm-Gg: AYBFou3XqmVOaCbAvmdniWNgkSwhJOU1U01qeXMnDnw+IpgZdito0X0XaoueQhT944E
	D5RFA5gbzqZA9WDLfd66tCCL8YzH7Ezc7723jXHN2sAo/YHgiiGXQZTzjygVwKiZ9DtabftKrrb
	SG+X2oHFNgJdXK+CJbtnzgqIYKlMXTqe0aUTYSFbkVXaHINhquXV/U+St+dN74mfirU8rFmgU4b
	A1lJ1RUwNgLyx3evn1wO5QprMYuDgFYo7L5xhB9tNxM/GGlGBzuwLlqmgWIF+KbNi2O13QLkzqH
	gRrry31wR00V8V179DGmvDBYFHl2zfeeOfslp1j4co1BqqSjOWGO80HW0B7M/dcdL3tdOJvXV+0
	iFD41VTtk6815AjIXNPdKtuCkV1Pui3wYGZiJX8CFNehuldXPhbGQux5sXXvwQAlzVeX2EiGMpR
	jv/QS58hPCTuOL7KP+s9Q/hzRMYqDB9Yxo+c+P0ZnqRSn1Sm3jb+OwOO/0dDGsKTzJQ1cWanAz6
	+LBUxsqmpmLzx9jvXsY6ECsJck3QxwY7c/SA/onQ1yn+qI0oK1kmxjkCEJCXfIkrl0Buj8R2A==
X-Received: by 2002:a05:600c:19cf:b0:49e:73d3:78ad with SMTP id 5b1f17b1804b1-49e7a6859femr20731045e9.18.1789380555982;
        Mon, 14 Sep 2026 03:09:15 -0700 (PDT)
Received: from omarchy.lan (p200300dec74de0474f67e4b61f2de2c6.dip0.t-ipconnect.de. [2003:de:c74d:e047:4f67:e4b6:1f2d:e2c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm458381205e9.14.2026.09.14.03.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:09:15 -0700 (PDT)
From: Manuel Knitza <manuel.knitza@googlemail.com>
To: junjie.cao@intel.com,
	miguel.vadillo@intel.com,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org
Cc: hpa@redhat.com,
	regressions@leemhuis.info,
	spencer@omarchy.org,
	regnirpsj@gmail.com,
	antti.laakso@linux.intel.com,
	mehdi.djait@linux.intel.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Manuel Knitza <manuel.knitza@googlemail.com>
Subject: Re: [PATCH v2] media: i2c: cvs: Get the wake IRQ without claiming the GPIO
Date: Mon, 14 Sep 2026 12:09:14 +0200
Message-ID: <20260914100914.230246-1-manuel.knitza@googlemail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913133017.624919-1-junjie.cao@intel.com>
References: <20260913133017.624919-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending here at your request, so the tag is picked up with v2. Same
test, unchanged - v2 carries the same code.

Tested-by: Manuel Knitza <manuel.knitza@googlemail.com>

Answering the DA16260 question you asked in the ipu-bridge thread, and
giving the tag here where it belongs.

Dell XPS 16 DA16260, INTC10E1, ov08x40, linux-ptl 7.2.3. No spk-id
conflict: all four CS35L56 amplifiers bind, no -EBUSY, audio works.

Note what that does and does not show. I am running your change, but as
a DKMS copy of drivers/media/i2c/cvs rather than a kernel build - Arch
derived configs cannot enable CONFIG_VIDEO_INTEL_CVS, exactly as you
described, so the Omarchy packaging carries the in-tree driver as a DKMS
module and applies this patch verbatim on top (omacom/omarchy-pkgs#418).
So it is a test of the patched code, not of the unpatched driver on this
model - I never ran that, and cannot say whether the DA16260 would have
hit the conflict without it.

The rest of your analysis matches what I see. With vision-drivers gated
out and the in-tree driver bound, the graph is as intended:

  intel_cvs i2c-INTC10E1:00: Quirks: 0x7a (VID:0x06cb PID:0x0701)
  intel_ipu7_isys: bind Intel CVS nlanes is 2 port is 0
  intel_ipu7_isys: All sensor registration completed.

"Intel CVS" sits between ov08x40 and Intel IPU7 CSI2 0 on
/dev/v4l-subdev4, the sensor enumerates and frames flow. The
manage.c:1502 WARNING from the out-of-tree module is gone too, since that
driver never had the IRQF_ONESHOT issue.

Thanks for the correction in the other thread - I had claimed there was
no in-tree CVS driver, which was wrong.

Assisted-by: Claude Code:claude-opus-5
