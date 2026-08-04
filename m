Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD13FADF1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809839; cv=none; b=Rx387aBiVHxMMJUidfhU+yXccR19kzxHlo8ViKwPd1V8Bgr+cM9TxAFrIXtROqtx2vkco9KT9zMA8MPFC05767p6XCcENOUMhyGG8xqO1emFGcxpYcEw+AuTQ4QDbtRtzp0Bpd9yrFpSCkLYSlJ3LV5X9TQRiYlN3E9PWi3gFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809839; c=relaxed/simple;
	bh=guG5wGSGgehUpGOTPeyxEWPEjO6+bFcAy5mYnbnBxOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lJkuDIAehVRnDonVCMqDOK0PPNT8yJF9qunPm/xPY3wBwqlgpu7203GE9FotcJH/pK+AwCdGhp0OkMoeniZWIjNBqgjlv6CnFioMsfkksCOjWt0WCHF6kcwgDot2cVoPvMcGo1YnjzLIpWNDn2qcn64bJwmhqIro+Bq01ffNvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=c6kwxSe4; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="c6kwxSe4"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso2675729a34.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809836; x=1786414636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZdXBAcwzRvpMNmypeuohu6GLszlFiczxSZjKK3L42A=;
        b=c6kwxSe4rAuE+J1385DUaBHkfxoU/8i+HFstELwLNWeQofV+5Ywb1JiIvotkCLNA5Q
         j/2rphIibfPW4ZWpIaKHA50cG0OOnIx//TXXQrGIdIuyuG2qDgOs6CG9p/fMyZAwcy5l
         WY3fg3q+hRLEifyP41yn41ZBFUHBEPNtsKUSzhmNFXashBpN8jQc/NCc00epOu3zQPi7
         PAwOw3YmKxr7QQe2d6GEzsEiqPwp987aA2xuJIB4a8gzZudN6f+Uw0brZx/B8uJOO1IM
         SaDtHuT5mu2so4Vh0CgkODm3Nd0YwKWMeWWAh6PGOPGUbW6VBEsyOP7TcSBk1IMOhY1F
         T8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809836; x=1786414636;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZdXBAcwzRvpMNmypeuohu6GLszlFiczxSZjKK3L42A=;
        b=BrbU6meXvt4hDpCmoAlU440H/ZVvPnZEfBBIzH5eg4NUjNzFDhGCmFA3wJ+G3toj2y
         fVEmVWWvBWWXtrT7+SwRQBZY7Rt/qKioMiz7ix8osUCUI4ACtl9Cn7qNvvWlGw8q6DDu
         D9Nv59J+fYeuV4ou5hy2zzbUViGQImiMYRQykZ08ToRdtCpdoCBGwIhwyVyV3nrhah48
         IhjpyqlU2yXR6gQrOTueklWd0u+/IiNtL9c9rNLYFrLW+TDxopqlztFBUPq8r/TcbgJj
         Lr4AiHJqcOVzCcanXK7X/+0qzL8LNL88BZ/K3UOkzBrGlznEH4hByr4Kr05M8i+gkN7U
         QdnA==
X-Forwarded-Encrypted: i=1; AHgh+RpTrJ/RteD1+5R/FQDEft0Tb4TAyAxHw7YPZLHVHyT9u53UsWlSXRzD7Mpk/pBrmLJM3erXOfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSIuweAzDJNWAoPUx0FjAhwzoqy7jmUWsRrrONVfoTNOazPCv
	TEd9bFlvCg/GB2VeSqX+gKDzdtxI39GmRdVfBymEZ2bzuJkYpXkZICVN9+AwusTgnJmOGrgzaDq
	rXm80RtvztQ==
X-Gm-Gg: AR+sD13Vl7HHLeos6/vijsF98nxm+tSnNpxwaxpIacxHI98jUQUvqn2fEMV4kUxfJSq
	PgVrPpiqncvvyg5bkDf5zrlPpzVzjTrgFkhaaMgA+hy8JiHEaeJdL0lw+/ujdzb614i8E9wqyk4
	IUPc+dlSh3Z0Nxxqjnz52/DTpgV0Vq1T6idGwkrCtWtgDDDquujJ1eQ0BhVFe13MtFi1Lno7aQ6
	TblTHX/yFlft4+GbH1N64JYoy7SNvH2uezC6J+6tK8QnAvFZAlZZwCLO6KGmj6cT9e68L0NFYt7
	ISYsIihvpDnn/2siSbLPEHRRKU1KMJgU5JmUUcEqlDXP9MeBAc0u3KYAv3e32hNWERDP6/MIorR
	HnJuuU/wyGgqD+1m0vD3ZlnNZ5JN68JsN9wfSV1qNvu2gysdoY3d5nsGjwtDUa8xlGggUdtPt0Q
	3dWvb9Az/D9VYBWVT7Se/kGIAmEEn2C8EIw6+ONL0U+3iRg/4As8WQbOnRPXLtqEn6tdJ74bB8t
	ckMYUSyCUEqG6iFBMGRYx4V2+NxrDJYgt87Ook5cF5bcpcgnakX
X-Received: by 2002:a05:6830:67d4:b0:7ea:b8c:4198 with SMTP id 46e09a7af769-7f196ca46b7mr23355946a34.8.1785809836367;
        Mon, 03 Aug 2026 19:17:16 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a55asm8914812a34.13.2026.08.03.19.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:17:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260802163030.51005-1-ali@iusegentoo.com>
References: <20260802163030.51005-1-ali@iusegentoo.com>
Subject: Re: [PATCH] io_uring/rsrc: fix folio size overflow in
 io_vec_fill_bvec()
Message-Id: <178580983549.518281.3281041637140008411.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:17:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 16:30:30 +0000, Ali Ahmet Memis wrote:
> io_vec_fill_bvec() computes the folio size with a plain int 1:
> 
> 	unsigned long folio_size = 1 << imu->folio_shift;
> 
> imu->folio_shift is unsigned int and comes from folio_shift() of the
> folio backing the registered buffer, so it can be 32 or more on a 64 bit
> kernel. Shifting int 1 that far is undefined, and on x86 and arm64 the
> count is taken modulo 32, so a shift of 34 yields 4 rather than 16G.
> Every other folio_shift shift in this file already uses 1UL.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: fix folio size overflow in io_vec_fill_bvec()
      commit: 3f3a6a16bbe8bde76532d9415438f8cdef439e5d

Best regards,
-- 
Jens Axboe



