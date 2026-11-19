Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070610;
	b=i6xoq7A/YTwjrrS+lnroisBRSEY9DYnksRwL3T8t91vhOcOGE519JbbKt9DRhcZfALiz
	 BQq5KSdNITw9CAR2fpnebe8aR2dwEQ5YXYdgh+XDIJbrYytw7rBMMTd+MP6mSGjuBmp+7
	 8TZh7JQE9czbq0G1wgVO+vE+Jdq8yAQv2WVW2Q1Jmq9DuxKxoFyWfK/5Qj8lb0g9e9W8g
	 DL8kF1MWP+GFp8J6BNTflDY8Bro9NJf7uNPEKRvuKlcowUdfTcYHFfrub1q1RzQKKdsAB
	 JaPzXyR/FUGv+n6wS4rMh6zX9g9IUr6Y6eFs3oH3nI+R+3n+qSgebwupkKW6Ia8EZWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
	b=LNxGwGuFF8G9Zc6GgvLaZfrhy2NGadkYXDr4Erv8sdFi+ZVu8tnQnBPzZobeK5Rz8oVn
	 9QlIyHCW7WKtTsagbYBpwIxPErDVxaBAfk/Dke44aXOLPDBol2gr4xyZt1G6JSKHsH9b7
	 YZqkqXC0MXckllaLJqKVZpAklE/EnToEwskPWFGc472cWu6jT/S4JZON1NbO4i97C0+jD
	 gMs5pf0Cpl4d4w1CQOCfFtOGlK8bNhLIHYSYkZkwW8m4TC7YulqiklrQncDqhrC5ITDuw
	 o+roKjBjRuGDYJIEyWVT6hMydZBhBplrsYhC9BWnqAXF6Ol0HSBvgsFy5fzumTvHE2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M791bM/E";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D8606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M791bM/E
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso913455a12.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070609; x=1795675409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
        b=M791bM/EJ6YDr7z6lKX8YSF22UffBSA9Fa+DCJFUleFbxsXZiFoAi/xfZ9BehWd6M3
         WEGlD7o0/6flrw6VTWLQkXt321yG8isfrs/CcFfMx0n2hH9Z3F9mRMVUazJ2yfBiCPWS
         hH/FT7nomy0RwanfVtrUClrQHnca6PGaz1ifwKiOmPzFq6oeij7XUORx5LEnN7jw2Rqs
         IoF99aZldktmoceKhLx8wl2r6RWj4L98OcDS79PkOqsLhTjOradqe5FH7rSiQl9tvu+o
         5jQsjGa7plxWJoBYUjldy2c6EKvRuSWUm9jTMCXu+uTinAH+/xOZUFtnIExS0EQWCjAU
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070609; x=1795675409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlw/MFAgR3dlvJ1uhPp3TNx4s72LXZKJq2RTq8GSaTM=;
        b=yAvHtQZjlEHSD3oCLYIojFCK/sk6R6kUMcMIbLo3iNKLiBt8YEd1uEp+0vhhKPYBM6
         DY5q6+PvhgYlik3Y3yXoRXCJ6r2dJarad1M6t6vt2nAxjiNbeLpz3HHPrN2Wcsh81DEn
         wBbq2ZeQ1GxLB3WGfDLvtDe/A/g2pb1c1DOXP5SXq3dmyx38w2mQa1dtce8nHk1e2O5h
         I3kDuFRb/WAPm9LNgUkLC5On6uHQQwSJTAenbHtjI5E8fs9L/AcDqKylG+U3gM59/nTQ
         UzA23PPbXJk74/CKBK9jDWawMsn2Y4CMczKB20fzH2HAGjdxkFh+8vpgun3+Zq1vlroq
         0gZQ==
X-Forwarded-Encrypted: i=1; AL+hErEuOlLUy8XYFukXd3ksjBFE7NstX6UluE+WaxYReWCAOKcwYt7AICYnABwa8soYsT49b/g0R48=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pkaGRxzYBe3USiaiYes39bEYZeZUnsP2GJTRSw5ykEU8ip2mE
	JUvK/peKngM8IKhLoBE1VlGxeKPm8B6fdSQqfqIYrwLBhekIm40OBvee
X-Gm-Gg: AZFdTZckrK3NCRPPhFEpM6n/uYKOmERL3zlPyDldO7cRBkYa6qoi/9HeLjPkvv6qq8e
	8qzwzUWkZV6n7ruSYzuUGMGw6pIN8KDOzJLw3LXnuHs2fwREC7TDj3gCXufD9J45rNes/UNwouf
	v6egdlE6xlDftu9Kq0j2S9EjceXQLxqDCjG5WsGf5+k7bVTsyW80YVYQh1QXQh0pFlzadtwOlxI
	5DC/o9BImEb6Mo7aFgJXuOJfo71WCZJ98ytaH6ZNnhR6PiDhnpKsCDx2DmfcwKE3xMFUhXZBcda
	2fQXfir1LMBjFEV8HJ2gNDv0QyRR32X+MB7rsEBLLmSMuwyypHeOUs2Ns2OZgVqCWTAWuCK8UZU
	LsZ7upqoc7Lzuys2Ms4Vt6mZ+G99GljGQzG1288AkZb390uyJAA/VTuk53ePsyPCDqXnd8NhQsp
	VnphgbpRsjZJECC+mO16TT+576EthR4rfpqtdUFdJfnJ7+S0V30mEO1aaLX7xDBOMhL7LuYJj5v
	AbdJsxxLW9cLFoqsgp1ZW/QTfaOAPmcZ5hSKn7TyAFnvD3vZrTuK2i3PaXsDk8ck8Ct/ywbVD6f
	xkNR4r6mopX2GhwxeGx9TfO4Nk3DQ8ORuzVdJYyf/9F2R5Tqaj0wHac0z4f+3onmrR7DqIek6HU
	2EspgD42y235fjFzmdnvWZXlQHmNtlzJQs4tA4Zc=
X-Received: by 2002:a17:90b:390c:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3b3d07bfff2mr5487494a91.56.1795070609562;
        Wed, 18 Nov 2026 22:43:29 -0800 (PST)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0114fd607sm13890335ad.73.2026.11.18.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:43:29 -0800 (PST)
From: Wei Jie Law <98lawweijie@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: andrew.smirnov@gmail.com,
	bentiss@kernel.org,
	e.velds@gmail.com,
	gideonheinz02@gmail.com,
	hadess@hadess.net,
	hansg@kernel.org,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stuart.a.hayhurst@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force feedback on input unregister
Date: Thu, 19 Nov 2026 14:43:02 +0800
Message-ID: <20261119064303.274901-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com>
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

On Tue, 10 Nov 2026 22:48:20 -0800, Dmitry Torokhov wrote:
> Force-feedback teardown currently runs only in the force-feedback
> destroy callback, which is deferred until the last open event handle
> is closed. If userspace holds an open handle across USB disconnect or
> driver unbind, device removal frees driver state and destroys the
> command mutex while queued force-feedback work is still active, causing
> use-after-free errors.


Hi Dmitry,

I was auditing some HID drivers and found this exact same use-after-free.
My analysis agrees with yours, but I am replying as I think there is
a stable-tree gap -- this patch does not have Cc: stable and your cover
letter also only explicitly mentions the "first 14 patches". This UAF is
worse than a crash and can lead to LPE if exploited.

I realised this patch cannot be applied to any released stable tree as-is,
which explains the stable-tree gap. It needs ff->stop, added by
ef166ce08801 ("Input: stop force-feedback timer when unregistering input
devices") in v7.2-rc1, and it also needs context from earlier patches in
this series: g920_input_open() from 03/33, hidpp_dev_groups from 20/33 and
the reshaped hidpp_ff_destroy() from 18/33. So the UAF fix cannot reach
stable as this patch, and each tree would need a hand-written backport.

Every LTS kernel is affected: 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and
5.10.y. In all of them hidpp_ff_destroy() still destroys the workqueue
while hidpp_remove() never drains it, g920_get_config() still runs from
hidpp_probe() so FF init succeeds and the workqueue exists, and none of
them has ff->stop.

Note that I only mention LTS kernels as 7.2.y is EOL. 7.3.y is a special
case and only needs the driver-side context from 03/33, 18/33 and 20/33
since it has the necessary commits brought over from 7.2-rc1. To resolve
the LTS kernel gap, I would suggest writing a minimal stable-only fix to
resolve the UAF in the remaining LTS kernels.

The alternative is a hand-written backport of 22/33 plus its necessary
context (ef166ce08801, 03/33, 18/33 and 20/33) -- which seems like a mess
to do.

If you'd like, I already have a patch for stable trees that I can
contribute. Let me know your thoughts, thanks!

Cheers,
Wei Jie
