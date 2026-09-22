Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AD31A55E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037491; cv=none; b=Ird6IyAgW3JpK9jcvj+30VVPyePyb7LajDQmXl1+Y9VMCsoTRfW2TzS3KDeGTYewbyuTZ+58GGld7T4SHqFmXpKNbTnF0PpGqzRoyfhUsj2Hswvcbb3D8QGfOLGirUGbLlOfkWdVRS3EnO+IEqFo92zPYFWaDTda314MzqeW1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037491; c=relaxed/simple;
	bh=xtUfDTogkvswBHYd+l0SxFxD1eU2IzxbiBtqrmpreT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kek3A5dS3XvODd50MCOBD5Dj4eZe2e088DbrRsxuTCoguGVZXw8PpHuAGSzEUuz3jaolNJR4yWkuB8wrIsx1mB5DkCRAUJ9ENB6ujw6PY1VDvXHnWsrRylAPU9ipuZEHuSFq8r2wIxNqSwxTupUdmjggIAGPSYTdIENyugw04gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfxCRyjZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfxCRyjZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so412972a12.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037489; x=1790642289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vK9yWKbLePV+PhIzuB8+Y294NhkTxfEqJ9/AYRPGsHs=;
        b=KfxCRyjZajsnFb9ivUs+xhCuHmKO/PGGnrxIivzb74I51zUSN3Bsri+kgG5o+3O7Qs
         X6diPDceo5NOq5qK1r5EsEQQXeeIyyPyAyqbmIkKWX93BkqDJFTHvROJaKfL5Ma9/IBs
         qPtjGdjKcP7xbvcPE9YcZfTYlfZMYIpLzYaCeCJiqRUumZ84a1a/f3jGHRW4caQdATWY
         JHztINCz/tSOkX+ZYh7zEdOE9m7kae4QsQSsRNeN+Zgjp0TpH3PmiWuyX6MjcLJ+4de8
         QN4oUBihX98sKCf6oLzwaKRKKXhw0X6cPcRlDWTMOzjUFM67dvXpzg03OpBg4lRUXTj+
         wKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037489; x=1790642289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vK9yWKbLePV+PhIzuB8+Y294NhkTxfEqJ9/AYRPGsHs=;
        b=cfY97tSF8hrPxNzPfzGLTd1hqHcmztZp5AgmkjAGmo5Z6laH9CuRbr4LO3teu2YiWr
         M/Hzqsuq+ogvvP2n9pHn0VDmy9ZPwA0WgESoOxjzierVdO/R94aba7ruq/VLgfGAmlxW
         E6qwsiCPBVSs8ubydsRzAO3gsFJ7+BtAl64JiX6vPKMpFeoUEHLW7AAOy+amKmxQko7k
         zYGawf+C7/u69VeF0UW30c8BYDb6YmOCzm+mo+dIyJFXnYr2AX0aRdBNzVX3SZcCOuM2
         hPIExvYtWTFKQ83jcRlcYVRTzNi3YUtU3xounwBNcK+zccD7T0SkroZu6pPA6QgAY/h1
         CbBw==
X-Forwarded-Encrypted: i=1; AKwUvByV314e3YvC0QQCfmAy5JF98MK/u1gD4qT7uxoYJT2RW18V3MEg90C8mVwoYIyJS91kBk2lBwM=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ1x2B7GQStweFaa5D9YO+9kc6ObfCpIZO9GibS0gRsno2+tUn
	HHJu/jBwsr04aO/LQq8Z4PE98xVM23lqoLfKHiJ09C7BSC6FxnieXFc=
X-Gm-Gg: AYBFou2A2ZL3EPSRPOe/mozRpNaV0JUhZAITIqZqlJr46WaGxeeQdd/xQpjmkbvhBEG
	i2F+nRiofd8kCyXX1YmFgfsP+zkP1Kz1nj2Q/HA6pZho50oj4g7KR6SZlxPN6M78ge7go1ZB/P4
	El3b164rfHr8IL+lj3ihtGQa58j7FQJh8o3cZFnOJ4tUfS6mn60oNOpobRV4ws0U5dL2vnM6ecX
	iXsSi1WcXwI2BmaftQZWaDV98o4Az5I5kWfgJDazjQ88Q8HoCPD+GZPYdPpoMbyYrVZaAQMXGRH
	Bl4goj7/wmEL+wn1pcsCFy7Y9bvs8hWuqmBa0GMCC/QxWHjTDFT3h5ZzalIzRqNKm2ncpQ0IYrU
	d4zgb9QYzEtMFddpDb1762aNIi0e7XzaeVqMBjRK6325dolAALCsj17ufIFxAunJWIHLQYcq+ih
	mr2m0QqBNh6+nG1ZyxiZfBVnJdVycVdA9zaUybbhJr0x/daMuc4KADpBbHVgeLybzFIGNuCtGy8
	wy4H6V9niIDNylNJ0BSDq0P
X-Received: by 2002:a05:6a21:e8c:b0:3d3:aed2:6f21 with SMTP id adf61e73a8af0-3dde01c1bfcmr1241002637.21.1790037488713;
        Mon, 21 Sep 2026 17:38:08 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:38b7:a3:b37e:ac86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a18ddbsm15551a12.7.2026.09.21.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:38:07 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: vdonnefort@google.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v1] ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
Date: Tue, 22 Sep 2026 09:38:02 +0900
Message-ID: <20260922003802.1270847-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arDlCou_U1nV9Zqq@google.com>
References: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com> <arDlCou_U1nV9Zqq@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 09:04:26AM +0100, Vincent Donnefort wrote:
> Looking at the delta between rb_meta_subbuf_idx() and rb_range_align_subbuf, it
> seems it's just the former didn't include that struct ring_buffer_cpu_meta
> isn't?

Right -- the sizeof(struct ring_buffer_cpu_meta) term was missing.

> That is quite long commit description just to say that :)

Fair enough.  I will keep them shorter.

Thanks for the review.

Donggeun
