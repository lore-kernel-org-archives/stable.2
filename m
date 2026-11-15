Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769130;
	b=PX7XJwN7wZ+F7t1dmIoqSvqrrz9r6cNqRTyDNpJSMt5a0sQTwdi8KeyUjT8lUt2a7boY
	 xH6tJtUjYUjj3FLdoe2rW/IMnhgeELxfWmKfhEIUJqWMmEwxrre6uCpiVkUdV8xw+FcsD
	 ikKEZIcQ6vcKYHMcmR5WVwpXKVMU4jF2SbZj4RNZg1UQQnMlSuQu7+pYOWDIp2FLN+Yqo
	 qk+6Fdy4BB0rFvaVzLRLBxS+AbtVi7Fv+Mv9MbdIffDUx76V7LOBMZyVtso6QUr3+8BSD
	 iOpvvfv3zioKmJcw+KPM3D2/je7pp6zpQPBlQM7vJkWp9p0SWEwUvT44I36dJBgXu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BvKuisBW9st6dv4iYQYmdk7UUIHA5W7Ob6TCeUj4NB4=;
	b=WQJGsykbVe8U9Hw+DTrDgIkd7nx5zRydrICBl3EH1yGiljJXxWXNQz3YX6C4BdbvXUYv
	 Qkc7aKYmkVBAIOoZ1Ugj2bIOtlkiDNS+B/H+ASCtO6MTEF5obfLCsKko0S8Ad4nW7/k9J
	 +ri07pwJs22FXOOqv+ybwp8Zv1QgJcDPmSOHqFiQ3LIDmpA85NzV/tuMP8PuqJl5s3cDr
	 JADgOXwghn+aanECl9eYyleLUjYeBj2F6bng3Nu2CnihT8mQMYpRK/5uG3IXfJ8vay5mI
	 xRgfgQ/5hu0e1Tg77+liArNOvZLwqckfpRoaXQ+hWl+mKJ1ijRd6qG5bmxGYJjsTnsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEoxaJhj;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D24606A886
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D24606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEoxaJhj
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3acec6677so3578823c88.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794769129; x=1795373929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BvKuisBW9st6dv4iYQYmdk7UUIHA5W7Ob6TCeUj4NB4=;
        b=aEoxaJhjYDfx4ScZ7+L4NjQUNajI0PdG1J1JOxjZJT7LGTv4DBXLaKAi6WHOlabSKI
         I+khqWWi0Rgc+C9ZZrBNqqgshJBzZK0KAwQC5YVmVnh9u4Vlk2P20IQbVNRfaXi3M3nE
         hnCkU8zwdDKRtG5bNfEq7qFubwf2rlZusMF9UFsK3n/k6W3/ZvHzOuFKP/EmGzSA7I4a
         6D5ak1Ac8jPdEU9erARKpRgQrKjojKm2Q+A1V2KmquZZzHQWtuyITnPZGHWZUVU0XJtn
         fThLmy2Z7/wdFAhVI4fA9x/3y3xqobYCl7jfomPyUtkDLssdQa1vbYzHVpfnXCgcyNpo
         Brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794769129; x=1795373929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BvKuisBW9st6dv4iYQYmdk7UUIHA5W7Ob6TCeUj4NB4=;
        b=kTF08PtBBseQ8C1K7ioemq2GM/J2F3I0+lEn26tNybq1noKkS3FExvyCv1FVui5oBb
         36Hb5V7odX5B2tVFTfg8Alk9NawG5rBKDLzM73/mdQeCINupiy/oTsJsXNaBIiUSKi/3
         TDUcO032DAnH89keYyKIx0gY//nsWBrAQi2OZuF+JXVaQJSFBLSNCr4fnrhrQ91GsjrL
         GBT19rasSAuzoiHq7eZGmuexPDA250IBdeO5aQTHO6B4y0xr7HgF+4ZX6xrU3pZcO1zl
         NvX3PBMb19I0U4rDZfI9BlIDksfeeytLaqDpC16UGZr09/eHr/glL/VzpVqzr5R3oi7j
         bb5w==
X-Forwarded-Encrypted: i=1; AL+hErG2t+40wcpg1yH3OwSbC85JyL5TZp2PZvX6DCCHNQmidYfhmqVZCiDBdqDIwXv3mGW7NG5XvZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HiQEMSZwo5tqBX4b+Zz5P29dOhqYI3lTIWY+2bOVJaeOUkjMw
	C49xSNvobQZIj90VIFcxb4E5Y5niTSdsrUnjpXsuH+Z6jcGY4HZxtudA
X-Gm-Gg: AYBFou0g3BDoPCTz6GEoWdHjQm22i8J+XFqE6noSgb5O6UJLV+Ww7ftQit0KgedwrDz
	58+LIJq1TgJ06s4lUegjVXoCpN+TbQTaJERTuh+ZYM52I0WXuvF3tLwt3Jy9BG3kV6UPIik8fHm
	CMvjLwwOgi5MiY6Q8ceMvXLRj+S5AcTd/uhkNUXPaSW++X6n7vMPQrF5TsLZtZIvIBGp9XNlORQ
	cpXuzmDXR2p0/rUvVfX87Qs/Ci+UgmUhtG1hlkAC3QJ2gFiTyFwrxAJAy9ldIWYJmCxzhnK+2Y1
	8f1cL/rYfIHOzHqJ4ytcEH9xoBXJHTYF0mzmd1s2cGVW40zEw49Xo5/U1z45Aro9rgCxCGpHuKa
	njm/S+9zDprTNlKecztSVYd9J0PZJm0nnoS6i5lPSsnuQlpiv+4aBX599Pvw1VQDzyWr8LHKzyd
	XVvxFE7IMT8grS9RstxaghEf90e9vtZGrK6SIt2DepSWtYWJvWqQUAuz5JN25vnmmG1ibhjbTKB
	l+YdZH/k9U8BEOiLH7vcQ5WjsoNLZsAe+EEkELJW7VXiwnm/jExCQ7eJYL/YIUJh9bBifAvtV6H
	k9n8lChGVbji1Ag5khuvxiRw4uOsSk4MS3Ff1kZ5AP2tWmNiL25ukA==
X-Received: by 2002:a05:701b:450f:10b0:1b2:41af:c21c with SMTP id a92af1059eb24-1b503157396mr7939805c88.39.1794769129109;
        Sun, 15 Nov 2026 10:58:49 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm82306c88.0.2026.11.15.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:58:48 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless 0/2] wifi: brcmfmac: fwsignal: bound indices from firmware signals
Date: Mon, 16 Nov 2026 02:58:41 +0800
Message-Id: <20261115185843.64633-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

These patches add bounds checks for indices that the device sends in the
BCDC firmware signals. Patch 1 covers the AMPDU reorder indices. Patch 2
covers the interface index of MACDESC_ADD. On USB, brcmfmac parses these
signals with the default module parameters.

Both bugs were found with a static analysis tool that we develop. A
userspace harness that compiles the fwsignal.c functions unchanged
reproduces them under sanitizers. No hardware was available for testing.

Maoyi Xie (2):
  wifi: brcmfmac: fwsignal: bound the AMPDU reorder indices
  wifi: brcmfmac: fwsignal: bound the MACDESC_ADD interface index

 .../broadcom/brcm80211/brcmfmac/core.h        |  2 ++
 .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 26 ++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1

