Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A60175A88
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030092; cv=none; b=o2wnfIbKP7Mtf+jFhxJSJ/thcKJkMtdbybJYn3X+kZO84iLAwsfZ929RuJRCxRXlbV0Iy8QW6wBfUq4NOOepo34DFeQoZI62unniXM7FyYPo0FucNUmdXm1QECQPUfIuexLx4toq7wkRpl+iHQ9HJS1lz62WvuPK+Ntx4hLI8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030092; c=relaxed/simple;
	bh=z8rbKTuCjfVAdfxDy/CGPYi1m0YldO3H97Xnt7VhH3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUX9gInG3UiSL7yDKRYH7xUgT5Vr1Yw+CTXCt6Hi2i5yTv182t75jEWX19Laerpo1NLpzQFxce+Q4mfMPA56I6XZHgAR7IAHqWNdDMsfnYb8Zn2sAibGeoPw4zK4CX7xpFD6KQTbLdKXQflWW4kW4BfPpkMSJy+3BAxJlglUJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Wll+KpqO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Wll+KpqO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8875d220446so2467462b3a.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792030090; x=1792634890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z8rbKTuCjfVAdfxDy/CGPYi1m0YldO3H97Xnt7VhH3w=;
        b=Wll+KpqOBdAMLuHsdEH0AWaIoOwkjud03lNvDuimaj3nfkL/2p9Jb+u3HToVrdiDDc
         DE+ogmhmG3pe6l08dhWL7bVTQ3VykIEvRdvxCfx7vC0VS9tpaVmYZOCwauWttYskjWv2
         sng0itOjOd+Tt6znE9+Axm4P3+B7tKnWJLvOrPuZPj6HPTs8VKWuQPjpr+w694VCTOKa
         aKfCNfMgaSJG6VhF9HGWou8oqfg/hC8yHwE+Q+AZN8yopVNlw7dClOcxF8qw8i6WF9kr
         d0hDQa3u7TVjv01UpFNtsDNCb15mhRV5ZnTqdqlyPv6sOHFRbmGbXmPApzZgk5G0jjxO
         8boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030090; x=1792634890;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z8rbKTuCjfVAdfxDy/CGPYi1m0YldO3H97Xnt7VhH3w=;
        b=DQ/J/ALjM/2HyUE4yP0/YdhVxJOj+1wMyY/6jXAG4almQubGL7EKps4cELkfgbVtLs
         xXpXSbybjWDbfugmMfqX71m0/YCg6BwbHnKUffCpEVNLGHYpGwdBADvrEXgWWX8CA1Yc
         qNCE/NFaxW7l2dj4GH+1cGWRxVYj4Oct0dE2LvfRd53iCxp16N1lUHbh6ZhnrivCx/pq
         tEsIU8FCItq/QpqFp0E1WW7dm8IM9g0jEZ6dFPTqZQSpG1Sd6mKuZHfk5IPkfiyHycSA
         8extwQSR1Fk1Rq33hhBMiKwx7DvgMKQRVnmj7MOXmu1NqYbYVpthLlHkmJf0GoI4r2o2
         QUSw==
X-Forwarded-Encrypted: i=1; AKwUvBzju73bZV0XxTez10dQ1Y1rP7DSKSTOW+TI9tpkSLUE+8EvpWLUj0k+M0ua2W/L7RVmwj0aP9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpd6JdYZwSVAodkKWzIVeIuKBIT/GzcPzkSLLbDhSrb76nc99g
	UMpBujGiepRCW42olNlh7P5YqMXHlG0l44AMIcrGzV1CY8nDykjLEGdiR7fkXrarGLMVOmZYdUQ
	2PPln
X-Gm-Gg: AYBFou0V+uvYfxX3Ssh8owGBxZvGwpzyK1STbf2iZ+Neu/QfD0UJEBEcOQvFIbTFHNW
	IfcJb03ciffKtIYJgqlGDKT2lKu1l6N/9wUfoPjw9WFxoItFsqgbu7f78s2wQK1t2o/LwW4eqaz
	6oQAfEglvGvSlfqg3IFy7OXuSQee5OVCwzvbsgevfjA2NctZ2QTnEBlRMkkc1XDth7ynHI8HVUU
	wkv6SxHwRKgePP2MFfU8y1/+5xCgjLTSfR3z/oNcoj12DT3upRZ1Asf9G7+WpznuDSmoZ2KYI+1
	7qXOj94xwEZFPLRx0jLWktiFE2/i5l59XhjC0zrqiWw30MePtuo0Ma9ivdnRywSh5H1TgeGLBBy
	aeXJmqUJnMwrO1GReNCtJtlGRui98KdsREHKNSgeR5WZFSr5/aE5iMB6Z6iEkvxBYBPwPG8mvlH
	4NhwUv7YFOgkyCSUixgk1yslagijGgKZIBwcvgknzv9ymNh44UcXE5oVMOIcBS36wym/nPJcNcf
	rDaPA==
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9925:72ae with SMTP id 98e67ed59e1d1-3ac99259edbmr818954a91.31.1792030088535;
        Wed, 14 Oct 2026 19:08:08 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm1770401a91.11.2026.10.14.19.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:08:08 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-scsi@vger.kernel.org
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v7 6/7] scsi: mvumi: validate the response frame tag before using it
Date: Thu, 15 Oct 2026 11:07:56 +0900
Message-ID: <20261015020757.3913811-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-172082@kernel.org>
References: <sashiko-outbox-172082@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review. None of these are regressions introduced by this
series; I verified each against the base tree.

Endianness (this patch and 5/7): the driver does no device-to-host endian
conversion anywhere -- these fields are plain u16 and are used natively
throughout (e.g. host->max_id = mhba->max_target_id, tag_pool.size =
mhba->max_io). The new checks read the same values the driver already
consumes, so they follow the existing convention rather than change it.
Making the driver big-endian-correct would be a driver-wide __le
conversion, which is a separate change. I'll note that on a big-endian
build the base driver silently accepts a byte-swapped count and scans
phantom targets; patch 5 turns that into an explicit probe failure.

MV9580 / per-completion udelay: the unconditional request_id comparison in
mvumi_receive_ob_list_entry() is pre-existing. This patch only wraps the
reads in READ_ONCE(), fixes the > to >= off-by-one, and localizes the tag;
the comparison itself is unchanged. The new re-check I add in the
completion handler is gated by request_id_enabled, matching the existing
gate in mvumi_check_ob_frame(), so a controller that leaves the flag clear
is unaffected.

dma_rmb(): the validate-then-memcpy ordering is unchanged from the base.
The ownership handshake here is the MMIO copy pointer read with ioread32()
in mvumi_check_ob_list_9143()/_9580(), which already carries the
architecture's read barrier, not the tag. The driver's own comment notes an
entry "may point to [an] entry in [the] outbound list before [the] entry
has valid data", so the tag can itself be stale; ordering the tag read
ahead of the payload read would not help, and a CPU barrier cannot make a
not-yet-DMAed payload arrive. I don't think a dma_rmb() here is correct
without a firmware write-ordering guarantee I can't establish from the
tree.

tombstone tag 0xff vs max_io > 255: correct, and pre-existing --
max_io_support is not bounded and the 0xff sentinel can alias a valid tag.
This series does not introduce it (the re-check reads the dequeued copy
before the sentinel is written), but the defect is real; I'll send a
follow-up that stamps the consumed entry with 0xffff, which is always
outside the u16 tag range, once this series lands.
