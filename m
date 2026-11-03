Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746303;
	b=VOvsXrV5PbESDHnQMwdwe0i1zHQCToxyvvPsz86odBoWjHfUHDf95zIfesW7KzVL17X0
	 XLlwY13q9WDZV4OljVzgWWZEmh/N1jvj52bs97LbtEZdzopNbW0j+e6JIdlaW7nmSULeQ
	 oV4eCYi3cgvAV2T0IJthQvgdxKgQoBAkR/EcPhxGuwemnk8hSYkbK/lyqGrVzRz0IcdtB
	 pUtsCeMcWsPQYRx59/6ftdLkPr48oJxI++EwxriOv7LjgKxdll3aMTzfuf4YDgtUlaB59
	 pJjxhowWy8UAHtPVXcMvtVTJ14LUi7uZm1Dy1HBRZ6NLT63soO/nJY9VinwsdMZYmfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
	b=4C0nSrA/T8RNh+xBnkEWlGmF+rW5k0d+XpsaUVikkqagV0TujIa1e1Xiw8KQLe25Fnrc
	 8qQb9BWnBqMpUYb3ZFCyYfIYUMUmHTAMfSPJ3yLHhTUoDvEzxVRjGMTSEya8fkhiqzDI+
	 R5EsRARDI9liJkI69SW1C5KvEMiaicyElyzPR7SbqBrqYP08sNbL2GI4w8e1AAu0sYplG
	 mF/2eXf1lVytfYYL5qJ1ksvfI/CMO3cqT/7LvfSOcodK7O2h3vwjboETBOWuOoBHucOqS
	 PCTEY1gkAFuXLPC/Q8dRcl/XHU0Zq2mnxMmnPLh/4p4dtY2pntgr1lpISbQ9oU+ruUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5OoO+mP;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A4606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3A4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5OoO+mP
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso53699a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746302; x=1794351102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
        b=K5OoO+mPeQIgJ0QvWq0G5ftnB/gmSZRUeQyCu9SwbTEeL0zej/U2UClWjE3au2JQrZ
         RYqK4LUYzsrc0Fcikmk9sLQAChktZRhTFmZl01JeLkB7nMSI1vWVeYxWgFVkmCgcr+j2
         ghymHACfpqROaD/jSkvgCz7Do3q/VNL551svFkodhcbtl/epNp4azusQUA0PeQMG8smK
         1r7AkvOrbesT1sydLZOOnBrxZDyZvwc5J4MeOs6NFp266gNh1ZyTDJrZKLY8Ljcvd9fR
         sdlWfqwj1J557RMqX3rUX0hRWVT4jHWdVVkI9PSkvZu2+yoU5PDflDm6JiJiIBtuYet0
         eFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746302; x=1794351102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
        b=FUw1Zzz1uubLHFj3oOVTtLb+v/yH8scFqDb/DERXhtHG4xj8UnmcdCdSOYAZg2QlbF
         3kZI0j6Ruz77elKdSN0Rbx8LDRAE/epi/t4g9hSdjaqbQgtZXzVSZ961WRRNpwt1LtOc
         j4HkHxR6Uoom5mS/73qQ9pQIPxNUMbd5/w0rWO5L6XMxOnY8xSyhq7DTLhClOMNC/aPR
         52XvLF4k4z3aAfQCeuFj1p/nge67ygKM3VjUd8gCZWjOaAF+uMBvLQJ1GgAsYkv4oi7O
         8FJQNqdIZSafTkDRITgYsQduXFUZNky4rB1DLWNaaIRHtLoCoEjR0q2TmQGReHFP5GgD
         6AFA==
X-Forwarded-Encrypted: i=1; AKwUvBxkGBoIhKHwKl6Q4z3kxqrtMQTG9JVeMq0sqdpFLWL6CNXNfD200Gfr952cR8EHy44l9oMjxRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8KVLBfPc3HHji4YhpnbBMISAhnybhA+VhhwjkSV60SFGiLoWz
	3heApesqk33/CIZYFjSoFpL438DmXJ63mIn9huKreX8OwWBYA8pb7Db3
X-Gm-Gg: AYBFou2OjmhNlfAhN/N1Gv+vz70muR9Jxd22hNuOM6NW+DmFi4J9pB182Q0w2EmN4vi
	N/9AgsL9LHmutK/s5A4bkYIPnp/zVKuBlQJJgaNdnbaasuJseAMtmzSsFJjvqCoMv/30NUO54HY
	wNArcJ1VC1pEwlwt23gaRqRn3jVbqCvekZXWa7SjzBEeKDgcZiQOBl3iu3uTyg76ijTeTHO0vNi
	utbk9x5mTaIPW6zzjohVnGnqBYlXvIUdXq5MpRwpNlOM/HRWAu4cLDMqYbBa3kvgKIMD3xGy60B
	H+hDIyZdoLHqbIODRI9ILP2PLgn+YEkyLZ++v4A01gs7ZnrM3jmvikBAErXuAvV1DutWG5Hwt+B
	amM0b/gF0jPpREe+fSG2iafi4TWmEPFi3iHOOiRwwenGZP13qOCEdni0v4B61FVjwUjzjHJU3wY
	Rld5SZBjkmI7/ZV/pSvoSD9YSVE27lxCEiEYhe6V4HnagLR0olEo/YpUfyzgKTG4x1fqegUyM9h
	E1oz8kkwjCVWgppKSNSnZZPn1/n4W6G93dEqoiDckdaCgisP2U2SGTFxQHhnIPXv45nYZzpzaGj
	xTdaUa9xW0QLzBpJV0bTPO2yiXlOwv/nN+Y0vhBEtJCIfbTpqE8tIL4yTz7Exu6ILiheaoQamyt
	SL8oR5/v0uAmAQDazgTMAAN06HBjtolBd7Xyarep45cuAogf8lk9w2QIcIOcwk5OvEowvZ23uMI
	+ApjKWcebGDZ9u2FV8n+fqmo0mm0p9VOZqIHi3Qoa/Kg7Yy0I0Rv6v9jn8NOa2OxRdyg==
X-Received: by 2002:a17:90b:17d1:b0:3b0:9941:8d41 with SMTP id 98e67ed59e1d1-3b09941917emr50243a91.28.1793746301998;
        Tue, 03 Nov 2026 14:51:41 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm913217a91.9.2026.11.03.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:51:41 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Tue,  3 Nov 2026 22:51:15 +0000
Message-ID: <20261103225116.3624270-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225116.3624270-1-jctchan@gmail.com>
References: <20261103225116.3624270-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

When ti_qspi_start_transfer_one() hits an error in qspi_transfer_msg(),
such as a transfer timeout (-ETIMEDOUT), it unlocks qspi->list_lock and
returns ret directly without writing QSPI_INVAL to QSPI_SPI_CMD_REG,
setting m->status, or calling spi_finalize_current_message(host).
Because the message is never finalized, spi_sync() or the spi_async()
callback waits forever on queued transfers. If spi_sync() took the
no-queue path, it returns -EINPROGRESS instead of the error, and the
message's optimize state is never released. The frame is also left
open, because the QSPI_INVAL write that ends it is skipped.

Set status to the transfer error and leave the transfer loop, so the
error goes through the existing tail: unlock list_lock, write
QSPI_INVAL, set m->status, and finalize the message. This fixes both
paths, and the caller now gets the error from qspi_transfer_msg()
instead of -EINVAL or -EINPROGRESS.

Tested at runtime with KUnit (spi_ti_qspi, ti_qspi_test, added later in
this series) by injecting a QSPI_SPI_STATUS_REG WC poll timeout
(-ETIMEDOUT) via logic_iomem emulated MMIO on ARCH=um.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 505a14954e2d ("spi/qspi: Add qspi flash controller")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..7360ee6bd122 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -708,8 +708,8 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
-			mutex_unlock(&qspi->list_lock);
-			return -EINVAL;
+			status = ret;
+			break;
 		}
 
 		m->actual_length += transfer_len_words * wlen;
-- 
2.56.0.385.gac671c819a-goog

