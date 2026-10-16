Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481537EFE3
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160920; cv=none; b=oQvzxUeur7jePi1fxV15KNQnrVeDudvLSgpH7to/nzcSQZRKaeY/vo5Q9W4YfM6V3L8C9d1oBxGX/XyAh/IdCOqRqurJ1OLBcv/Nan5wPi8mK+8HpLCreRYcvVyCk6o3DZZj01lAdLdJfTenR3HqiaHwiU+bLo1MgJTu8aDUVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160920; c=relaxed/simple;
	bh=tCiJvvmVqkDn9bBZcYj3gCwhrS0H3F9Qtdp20m+sp5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f0NHdrlMpbQdk6idHNQZTVtsUZqkrWrRYEo6/BbZx1HhnV4tjXPwbQqQLex0/aBFmiVswpTqM4g/1yvT6kmI1qfasZ9QuOHOZCpHdmt1s3Opxc0C1JLOrWoV5U9HO0PgEeeUDF0e8WMJmn1rGdlr+zKNo2AWtQ1RG8ZhkzLOzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=FHqdv+3V; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="FHqdv+3V"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso11276923eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160918; x=1792765718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZNDAA0XdcAcUqgBVAh4lShInRCyhCpm07d2o6YZC/E=;
        b=FHqdv+3VwCIo2+J09xi+YGOLak1/q7OXSZbyRS8Vl5Oi1QMPJQiA04n3Pj6hT22CDc
         7t3ymWfa8wbsAep8/pc2X5m7e+UwGg/xRAsOYoPhBSNwwy/QPLKf610iOHnwxfV/wc6I
         FajLQalN0zpeqlpItO3ZtQU87+MIhplG39URNEn7F6OfSc1Z//kAthnm25gy1MGUP97+
         MTJw6vR5eSiXGiAguaO8/wkqA3uCziRO6z9iwuhKnM/T9fpdkCTzKJT5U137bgYWc/xJ
         vdTYVcxRhucjvsDaEnLFbiY6qIbaqkstPRk2buvy7GUosej7lIiE9hcMeVhe9gIS69LO
         goRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160918; x=1792765718;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZNDAA0XdcAcUqgBVAh4lShInRCyhCpm07d2o6YZC/E=;
        b=yygP8Z5RBzq3gZwAPi31JwXU3PV1tKoXMNF93d4CJnPbfCgg15uo9E+LrzR4qBzudg
         NzIo8LjAI1jQGjppbHIck6JEljOmCQRy4iASu/wHE+NyZEKLtWxrr5PGwLhYUs6aBvEb
         Dmf24m36VKrnn7pnLdAmDt4WbcLoyEwVxrp6hyoNU4s54YVacP+0vlMIbnzl0nDyt2YY
         AI8lNPKjMhjpa3QeQKY6/tM3vyexPDb76DPRVcUc7pdqgmxr8wEjUP36+r5RpSgrh2x4
         lX32XQxki1LjGYiUaC+cFtcPldI1TuY/6oDU8xk2DbaqB1lch0+//eQJRGKm10YObvSA
         um2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzy9xka3D7aQ1h5qK3aMCgPshv+Xb6QXQerAC/jzNvE5PDbQVUOcuUGZbLyND048VYVXzgX6jE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe5pNopOCifWcYtkMsFDyQVFhNlGc++/BnjogpLEX/uXf3WXBt
	lB3ZxvdiJheaAIs5z3UcFJjFY8aLnBe4o5+XDPwqD9qrPuqy7uOoeQzAor2zxiQLLJQ=
X-Gm-Gg: AYBFou0V/P9eGZFRgE5et+OhBoli6TIqL6NaUluuY+nHmZgxBYbi/SsZ/8+sLNrC3X/
	oAsGfWVfQYvBAT+3qZApvAurX+LXW7qYmHVReeiR5d34b8FNl1X+xq9mlTZaGkh8F1H1hTDxHen
	1egrLd/Yhq8rdDDnLjrbf2eXre/dapxEo7d3+lIIYbZdIkxhdq8i6HcjAsNetVDP+sFw5a2vGEx
	rwFbdR3rAUpha8mesvxLa1BnrVQgKU9L1yqUHkSsSJbUidwPHvju/jPrZCWCQNHfeXb9JUZ8lld
	4+vFFpX47EhypkS2fcI2zEGP3/vjk0aGm624caX5ThmtvbH0pK8fH1ay9z5PYLkpZdYTR+B49O6
	3C8Y7EYCpebTkYbe8mHIYaSDf3SLKUpZUECaJ/L9Ic0VrF34kwpCxSmphLIwMvzfUPz4dak3X4J
	2mDsA8TW0gdkT/F0Rmabw5IPBvGra5sQbn6CKZiYiV7VypNJmSpuQ0UxlBPMsUrMVkotSj9wrjC
	XBXhwDWvjL5i6RNdmJj41TydZd08V42g63cKHY+ou9uWL8j1H97p7q44xgHy/eBsYaq
X-Received: by 2002:a05:7301:1706:b0:35e:6816:fa72 with SMTP id 5a478bee46e88-35e6816febdmr8708847eec.18.1792160916751;
        Fri, 16 Oct 2026 07:28:36 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:28:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, sonotri <sono7ri@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261015120654.241354-1-sono7ri@gmail.com>
References: <20261015120654.241354-1-sono7ri@gmail.com>
Subject: Re: [PATCH] ublk: pin module while release work is pending
Message-Id: <179216091563.2070939.8848021281402109877.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 15 Oct 2026 21:06:54 +0900, sonotri wrote:
> ublk_ch_release() takes a device reference and queues exit_work.  The VFS
> module reference held through the file operations is dropped after
> ->release() returns.  A queued work item does not acquire its own module
> reference for the callback.
> 
> Consequently, normal module removal can start while exit_work is pending or
> executing.  In addition to the worker callback itself, the final device put
> can invoke ublk_cdev_rel(), which is also module code.
> 
> [...]

Applied, thanks!

[1/1] ublk: pin module while release work is pending
      commit: afc9cde716b29ce814798d649a95f9128ba42b43

Best regards,
-- 
Jens Axboe



