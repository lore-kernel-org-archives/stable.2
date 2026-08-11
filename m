Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83041A565
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437624; cv=none; b=G6q6bQhjwZQHclXwmU9GYcJH9ZE9ksied+fW7T3YlUjFMqdBdss8Js8aUljJMtB2uun6LwNZChokie7/mc0l551ax9P/HXcDkLYQTLYzUYSbYrdLIeei35Ld9yyXaLxM3OZWVn3ZnxOvt7CfkN9XYcG++i6hf87qyHEd3cYT9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437624; c=relaxed/simple;
	bh=0v+cbzWnRAjA6ojEnzjct5jVn+xaEqlkAJcHpwhAehU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIkvBlpXKXuuAnvxDIhyUoGjAbDVT5hTb7Bql2/ySTZRyLBE4ZkilYqJnw74nqU4Uokcfjy0Z3S+JOCQ9PPSh+C/6z96Y2bbmQOAikqVRJQCT0xkobY5JLhwFSfvrbu9iJSpJSQjV1ZlD2yruc2fbhGMZjvdhrbTd4gz7s6wKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrydZMMu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrydZMMu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1618534f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437621; x=1787042421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQrvHx8cRmWpupSwg8UgPnESCrLlQxGAZWKrSs5aESA=;
        b=NrydZMMuUcq8SXYadr3Fo6AvZ3W5btAmD475fvywDWXWcVuFwXfNAYev5ayivV7gth
         lz2uGUJpTSJZvvj8n2KFSA19mBHdlFXbZh1PGFiWnFSbnB7P0xksYPzWsy1eU0ZbZ90u
         ROOnaZlmQ2LrGenwJ9dfUCnA1miOVR2Q4lbPxtUBsYzS4FzRvCBlczZnvau0TwMjnYgh
         Bpo9gjkdkXZYiIRCq8giJIpOk+XWEZ9LQtBnxf/UUPeLG/gEE6kbTxtoGM9jsvA6pear
         KPebkQAD76YdNt0jhXyPlmNokkFl+Mv7OCnJc/Q8SLyJywl9nf2M3HowMZCPLjzndWJE
         5YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437621; x=1787042421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQrvHx8cRmWpupSwg8UgPnESCrLlQxGAZWKrSs5aESA=;
        b=TC54W7/5aof5/4ssBF2Afd3dArfWFqO8vO3pywZqnv8kgKYweYGX5MIcE0oNawWY9G
         1DTDeDQi2jvGxTa1mYzwLA+DO6+aIhVUhet/0NOdB3+ehvYyqS91Fqu9zYh4vpKBJP0k
         wrpY8Hz2jS4YguQTIRzz+KkLLV7m61rSbKFqyYMYOBr9rC1UR/P+IAEASHiHoBVtqRyY
         1wap/2KC8BJv9V7Sy04G8DWc4Czu2CzFVmUkk9a6w8/X06/RXW++K/9kS51t2fy5Dt0H
         mwSzrKvKxWXJGM28N0Iy1nmPJl/5u84j0fOFw8Gjp6tChf21KTsQzdqmLYB5QfOw528x
         D5ig==
X-Gm-Message-State: AOJu0YwvpzXRBzPdeEBtM81RKBCZPEBWh/GtAPgg+b3I7VOcWX34PW/W
	CLmlP0r2SU7MFEl6vWPONiPgUPiPH4CnlvnvTLpjqwutLfp1I6Z2s9dPSsb6y5HQ
X-Gm-Gg: AR+sD12qg1nToNWL6Xtw9WjBvKDrHRqN6Y2bsB/xsmG7o1TC+uD8QTTg+gMovYMBBHv
	eYdb/6pEJGqeS/muTwXnTI5GKes5rUTfYlaurqFISSK4fc5PQ+l+E/j/cLcBUvP5N0U+/1fqpKQ
	0SWEzG5bWAXvDzS+3r4Ssq2ZdZYwKYdAafyC3fJOF7fF6A2gb/7r5gAHefrk6r8gql/CetIvuKH
	XdS3kFwk4gAbecPCdRTcOJgXdpk/kEIPGnZ/88hDKvHDCdaHgsz95uYvu0Cw/LQmmtO8WqheIRy
	M/+D2rj+SSBK8iZGAvIpGactw4/uMM+KmnYLKnWSzu0Z8VpVUVZQTsWyVuoC+0rxzH6J4Diybp+
	GdxBSN+H0vS4mRvmtQTkZ1YTq0zlxfLu4UEN31coJto1pKY9JV07sgU04T38L1dlN5WbDNnV7Ih
	HQDrVYgG3wsCm29kK4fSl+uW2Ss2Fa3d+SFkIERr1mkmLWYnUO1AnCvjJu5+k+0HcjVW9l
X-Received: by 2002:a05:6000:29cf:b0:47f:f908:ba7b with SMTP id ffacd0b85a97d-4814addb4b7mr1946548f8f.23.1786437620646;
        Tue, 11 Aug 2026 01:40:20 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac70dsm3233679f8f.5.2026.08.11.01.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:40:19 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Tue, 11 Aug 2026 10:40:18 +0200
Message-ID: <20260811084018.3566861-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810141437.2805389-1-mehmet.fide@gmail.com>
References: <20260810141437.2805389-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some measurements on the hardware, in case they help decide this one.

I ran the transfers that fail on 6.12 against 6.18.44, which carries
cac7e5054115, on the same board (Colibri VF50, vf610, DSPI in DMA mode) with
MOSI and MISO shorted at the connector, using spidev_test:

  3, 5, 7, 9, 11 and 13 byte transfers: every byte comes back, in order.
  Even lengths and a single byte: fine as well.
  SPI_LSB_FIRST at 2, 3, 5, 8 and 13 bytes: bytes come back unchanged.

Without the commit, the same odd length transfers lose the tail of the buffer,
because the accel path packs into 16 bit frames and computes the word count as
len / 2, and SPI_LSB_FIRST comes back byte swapped, because the accel helpers
byte swap through cpu_to_be16() on top of the hardware LSBFE bit. That is what
we have been carrying a local equivalent for.

So the commit is what makes those transfers correct on this hardware, not just
a saving of pointless repacking.

Thanks,
Mehmet
