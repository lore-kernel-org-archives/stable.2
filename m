Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251632139C9
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777295; cv=none; b=ga90ZunDn2iWiiVcYls8YQN/fs7bqjMjqes72//Xvm5fMPPhhOAU8D7lQOyokWvcXpYQhKa28ZH7HPC9SWOSKXRqdy5dj1SN4f7thCoyzgFy+XxHCibOX6wmVXLGyKYSd/3aI8ETxBbJgtcukQhWOfwl/fscmnOWKBMKN3FX5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777295; c=relaxed/simple;
	bh=jQvSLtfuIPDAKmmLDRJEf2naowzs8N4VS6D/XoOOehY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1fxnU9LZNz7rsn7jeNLtlSLyqSHhx+T6CxGlJJvO1KkKaO8mjvkrqD6BaSl7we/pVX7U/R1OcxkTKhMB/OqOBMYV1iQjQm41/N9nOIiMR6I8LnDQmZ4MxbCs4iFNmRpExsxZhHSl2/UhQudhptH5EPM+A22tfaOvgSvjVzz5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSGSyjqI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSGSyjqI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso1911125ad.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777291; x=1785382091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHZVZTCMmEvKPugPr8dJCpxRM4kbAf/u/60KC50+QaY=;
        b=GSGSyjqIiFq5uydRcWwkYbrXnonABdb9GK8OTHn0Oz2Wv8rqHAmO6u7wA8OFvV6ruR
         qo2YS8VgkRwCMYZBlG8OsWYyZxP7qqHBkGLHJGYmMZ1tR/dCoEt1rXoAt7nBj6eglRR5
         FPdHubzrTACYAGtIVgYo29aXEN03St+Tjdpg7Ev9kfcmYH8hzymEJE9P05CLqX4K4ysl
         U5iWF7ERe9jMaofWMKLxdHClSdk7qbuL84bo+gdKwgEAujl/SkYMEvhAv9VpiDyFuUEH
         nr8BEFZue5C7edtkNnO2ekgL/CaRdOyt0Qf7GcubhahxQCEetz/14gzdWtyaZ5xhGX3h
         iNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777291; x=1785382091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHZVZTCMmEvKPugPr8dJCpxRM4kbAf/u/60KC50+QaY=;
        b=kW0qZbWTW6/UTIf+cAOKKyx/8KsRGr9fGGTS94zQQJBpbtt3U5NwDousIv1THiNtKM
         Y77hAra0QlmdO8aYhbHD56+bdSdsuSy0oWBn6MxLkM2v0USQVW8g92hzRnhSn9oWS2mx
         lpNvOIrmKYxf56TaAsE42/OpUFTgbparGuu2lkwDmOT1W8PCRa2J4Vbn02o+SE8iGv4/
         EEYNnX50AbNKerLaAm4b0tXR6SNMUAbQ9aV2yKlyoGb+Q9aAXrtYKUYFIKBF9oNjJbdf
         PoAwDiIiyIhpGvdOnMoZZHHQcDACGNUp9HwPo7pr0CDtdwR7cB5aMm7sYwrfmqu1Qeoz
         ZekQ==
X-Forwarded-Encrypted: i=1; AHgh+RoL9B6VkpFiw8jy8yrXi8rcm9LyvjRQgmWKGLH2MYso0aiF8gRhBbQ/Dkw8Eljeee8iGrIp9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmWn1Qmm/hqfUfAxQvRHzltz2zIv5XvLdswBapV9sBMbp7RjC
	ZPZX/9lcXYHLQcphqYthmN+RJpIip47prieuDXzKcsyUeK+GU9w+J0wX
X-Gm-Gg: AR+sD13VDfOOlnqC6VQ+qkWnziYn4jpQW/a54FaKhzy3rRK1paGASR8VFGooFy3+teq
	tV77n09NyG0O5bjiPbj4ucbgKolr/O7y/YIoPmBPJ5z/wbmApF6iiwlHGGhcJhGMKr4TauoNEAS
	2F8g1mxa/xHpC/eG56lkZAL9I4aCIXQeSEF9TWnVyANrEzMdMkZ+XtiAokuRGL1gS25vgxcLW+c
	BnMrwcKQQNEqqeG99Vn9iDYzHCVmuxiKdFEPzPq6sqxMlVIrkFfsj61E4AJoJAvVYCEO5OKv2uk
	Vl7vHokDWK8qXDIJa/EI4e2SUkKlEz7bbHh+BwDHAbawy1E3k4sOZvE/yht4kSmcXE2EBFrdEyU
	fzUWhn7Iptou86QpgLjIi36XbCZzmTorsjgdkOGVjZ2Myhe+/nQyLSj2P4qb8ZijuHXpTJWg7hv
	aSGNijBOnxVPzpHuVxNZYTGIkjOZFdlQQsRdPFp4jdtKT8X7BgXkZO
X-Received: by 2002:a17:903:244a:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2cfa6a51b43mr16909445ad.6.1784777291143;
        Wed, 22 Jul 2026 20:28:11 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm24538485ad.18.2026.07.22.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:28:10 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: jikos@kernel.org,
	alan@signal11.us,
	padovan@profusion.mobi,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kudo3228@gmail.com
Subject: [PATCH 0/2] Bluetooth: HIDP: validate short receive frames
Date: Thu, 23 Jul 2026 12:28:05 +0900
Message-ID: <20260723032807.1616487-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HIDP control and interrupt receive paths assume that every L2CAP SDU
contains a transaction header. The raw-report return path also assumes that
a numbered DATA response contains a report ID. Both assumptions allow a
connected peer to make HIDP consume data beyond the logical skb boundary.

The tests used two BlueZ 5.87 btvirt BR/EDR controllers, real L2CAP PSM
0x11/0x13 channels, HIDPCONNADD, and HIDIOCGFEATURE on bluetooth.git at
df541cd485ff. The series also applies without changes to bluetooth-next at
6f55ad8fb0ac.

On the unpatched KMSAN kernel, an empty control SDU produced two
uninitialized-value reports in hidp_session_run(), an empty interrupt SDU
produced one, and a DATA | FEATURE header without a report payload produced
one. Patch 1 removed only the first three reports; applying both patches
removed all four.

The tests also placed a controlled byte after the declared L2CAP PDU. A
trailing 0x15 after a zero-length control SDU was interpreted as virtual
cable unplug and terminated the unpatched HIDP session. The patched session
rejected the frame and completed a later feature report request. A trailing
report ID after a header-only DATA response made the unpatched raw-report
request complete with a zero-byte result; the patched kernel rejected it.

Finally, each path received 10,000 malformed responses on KASAN and UBSAN
kernels. No KASAN, UBSAN, Oops, or kernel BUG was observed. The KASAN runs
and all patched UBSAN runs accepted a subsequent valid feature report. The
unpatched UBSAN numbered-report run instead completed requests from queued
short responses, which further exposed the missing payload validation. No
information disclosure or code execution is claimed.

Sangho Lee (2):
  Bluetooth: HIDP: reject frames without a transaction header
  Bluetooth: HIDP: validate numbered report payloads

 net/bluetooth/hidp/core.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0
