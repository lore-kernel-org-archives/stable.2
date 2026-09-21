Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8747F3A2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035063; cv=none; b=UpznfpEWG8Bqn2ftkHNPB+pipMSCZpvRaB6/xy3b3vFOmXC+FlGv4o9EtfBkA5RLIPojgbT/KZt7HFhmqhvaFnPzrdBZwjvFhZgIY6KhUT8/zfHZfnmthlTIm5POiXmhUxVIrjE/KBrnFADUFx+HTGX4knnKxoPOIEL0uwVjmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035063; c=relaxed/simple;
	bh=cnVBOVNcoBUw8knbr6P7SfsCy/zQCwhwUZU65FPLmlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPvZiMWI5/JN3xdBEX1hIsgojBePM58p1as6ATfJYjULg1paN+5dCBVZztoR+USW85bm27TUi/gZ/ymLqTWECAq0RDTZMsUpm40trMlrvhlcJIGEXvzOZrvxnUNudqY7Gj65F4gXPLHosHqjT5YxhIWo4zzsv88ZrteYyIK8uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZughzlR4; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZughzlR4"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2797538a12.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035061; x=1790639861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnVBOVNcoBUw8knbr6P7SfsCy/zQCwhwUZU65FPLmlQ=;
        b=ZughzlR4wEjFFcYd1dgfTfM0rCk0M+Ag/meEzUQNIz/DzjJtontU7z0HvUO2blRi7L
         EZE16AAG8wlh0mO7ajaA0XvGq9s3/Y+2g2/jjFSEQV3Ah7v5AHP4USxl3pMc/53VpTyD
         aaLr4M7/bHqdbbwhx/12Iih2sEl/uOabUNwidCKbbGCK3M/cyCEVqtFVDjxbPMqCXKc4
         Mr1z46X68WDEmtyk6USa4QRLrGyDBf8gRIa8p9fk9tztX2etO2aUvtf0k5GdTWanBEE3
         fxASPqnevuZtCqhY3xOhheSDZeuFqI/8xde9/WGKy48kxbSI4w9Jov+6NcQW5nVIPxb6
         dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035061; x=1790639861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnVBOVNcoBUw8knbr6P7SfsCy/zQCwhwUZU65FPLmlQ=;
        b=AJHc8EQr7bOVgOOMxMWEYJlIJYVLlpsEMf/bd9T+IxVzaa6kQArXr6PoLUbGJ+HcpQ
         r9q4sJwiMZtDXQgyE9p7X+7rFx0UXZazkD+BKb0aa1ZXxMNrUOgnYTIO1vv8+4x+0qfQ
         ZZNg/QL5EAVQ0pPEE3lwM/4NEMpM799XSfXcszAt9lfjOUJI90/K5lzTqJBx11tDkBNm
         yokE+f90kK4kcXSI/KiAvq4oVhGDpMB0eNm27USTz57HkpVQFGQsFiFQ10uD3ui/zhXk
         F2k7i6MbH7ucZMiUzIFvTtq6zdnidDZG8HpsBQ1uSqpFT+SDLJBRZ9HuBlcZdkT2YT+E
         ycGg==
X-Forwarded-Encrypted: i=1; AKwUvBxxIDoXIOxmZDxtfuPEii5HL7OQHX/MBbGwjSeRHPhzzO4blsmmDS7TYViGkC2EOyAjZ6gKRKM=@vger.kernel.org
X-Gm-Message-State: AFuF++kXzZVWY6FQuYbzVjynOShcCYhkzsoVvn+yEI5P+1eGr77kSE+O
	cN7IDqlzNgLGEDRw0dGul5rl/dx6D0J/3ul/DGL19o84cCvIAafNr9xzCs7di3We3JQ=
X-Gm-Gg: AYBFou0XdsSgKFORPEd/vztdC/DMcTKPXcS9UlIDKKFysGb6fxznYI63l0N0QMmRGK/
	U6vSEfKJHP4N4kshwsrajyo09M+Qoaa7tHBRHirHkcfSJq9eMp209KtEZbagQQoV4JbsmZnPkOt
	enRwCDNSvFTerBtXes5F4SIKP52TP8DlJP/oEUEzHxe6VbzHXRsTfV2yvz+PXZwdfkpHYmaq6Do
	lpPJXZ33LqD7ncBCOx4j2t9FS4MTcH0ZHmvKl79mQCI3fs9wrQj5mKhwl1imQ2T5wyK1U3nBE3g
	e2c2bbZNKYJkAlZY8+D/MRKCk1IY9U4Xa0RcFmnOF0DJ0GXGwwVTdUrWLQ0hAFCGlI/9/rsi+GI
	MT/tRQCT7BLxRZgLmY0CNkXxQukBfLEPTQx6wDRkrNUEbh4RKcT4SaQo2QLg/NlldtGL7nt9xSS
	cb7H/ScjYAx3UIMdyr+W3zyt9m4Dzviuen/sq8uF6xeq0tBuwRZbtVOmfLYxbyERU=
X-Received: by 2002:a05:6a21:a510:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3dd8c3fe2abmr20429703637.6.1790035061042;
        Mon, 21 Sep 2026 16:57:41 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc754bc9c91sm88077a12.25.2026.09.21.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:57:39 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	liuwb@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd
Date: Mon, 21 Sep 2026 17:57:37 -0600
Message-ID: <20260921235737.5666-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921072551.3708191-1-liuc63@xiaopeng.com>
References: <20260921072551.3708191-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 15:25:51 +0800, Liu Chao wrote:
> Fixes: c47d7b09891a ("USB: audio: add USB audio class definitions")

Reviewed-by: Ivy Lopez <skunkolee@gmail.com>
