Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57042587F
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172148; cv=none; b=uqpwdWy+KP5MnmdShAVBg4hFrPsQCt5FJx5LG7p3799gHPP3D3PlqvcZasA2L4t3OoX30R+hWhQgQRC2KL3ely0kkF+xjOjxLwypgF3rpKhQRQvxWtZpZM2YuPHjnOV4ZIQRKZ1uxzB55k3fNPEymO7POU4mBIdBl4uN/LdtNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172148; c=relaxed/simple;
	bh=FXdp9OQo4ALBepWPdxFlx1eYESgmKpUpw3e2ck8BZxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EGnNT2JyPgtLSABmlCtX5lH1oEMsdUGXx6Jmh+3XSsToUi8AWJ0KT0IdEMn5cEKIEgq8Yi6xy6DZnkoD+c9TmTVmZpt8kgnepZFFSP5CJQU8n7b2MqCRsRtGophKw5tgJd487k6CSE4nqOwnlzdMbIKPU5xEpfs0K0BaR5coFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TW3ia6iE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TW3ia6iE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52192509869so22441181cf.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785172145; x=1785776945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tN5F81l95SRX0lNSZtF4N3Sk0HbQflC2AEM0fGaV70=;
        b=TW3ia6iE8u81oSlFifjhwmq4TPvvefQ2Udb01Q2//3fHHVrn+KpNyXAlWa5GzQxFb/
         aOJQ4CJ0NMMcR0GhffNIxztiyYmhJNI51EsHxW/OyqTllAMWGbZjPpqYtsiHSjhIVOZl
         jDUvdmeYgToLvwJaGIsjq01s/xz0HaoN37lmUOfYQ0n/uZoH4BPli9APp4mJPluHbN6A
         pVtHs/vXjPMDLbnGIHjbPUAMHCurp3FSdE4SE6opWCX8yhKjBxWDGsC0T03bRg7cKXEv
         z/fb+eYy5NdmfmyrSX+b1Y9Q0sfqi+p9dddaJZzOazZKTCBZ/KTJqbPvoahJ9VpZjR31
         eGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172145; x=1785776945;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tN5F81l95SRX0lNSZtF4N3Sk0HbQflC2AEM0fGaV70=;
        b=hsDby4DC7ZEr8X8JWEhQ0O93euKB6wDfPSwqgnQ5ogP5DVm2afM+UEQul29AqB+8fG
         tFaSX2dfkf3XEdrwdZZGi2Yx+7JOh0tPxtiG3yZZC/d4+Uk1jJcrY6aR1c+1synnuOWm
         i+IZMZhwNTGS5AsufUckXf9r+7DQiKN6CmPvrgfvXLS64mXrtAzgfBlgWp6O1cYlYM5b
         ca3cnLWvG122NI9Es8hhcqsXX9/i+okTLFiE20gjQvXBoO2P5LGyuMsL8gPO8WQCfIeE
         BPKNoYmCgrlxroYy9yxzERztKQrnYJetqPYlbTHewOWgIC7YEW50vdvjF4CP+ToUdU3L
         yImg==
X-Forwarded-Encrypted: i=1; AHgh+Rr11Z7q83Eoe7YUUi1hz2VQ8bXV7IdyjPFBXwVLIs/yw9PXXJOAwjB2iBZ+j/PPqrTMC2ZsOFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQgxQJM8saMWFilzM2IZ9BxwNUpTgoGAYbxeMWFp16q9bljrW
	93Cj68rtz01uffx5aIBmtoYCvJ5+hbJglCeKqHnpUoE6JiKPcrTWcdlGeyHHc24Z5gfooCbtXZn
	18j6UbIEM1g==
X-Gm-Gg: AR+sD118gO6kmDmqD/Ezmdvd55kA0x+DAItWy1ofqL4ZrfOyBYqx9z/h30jrHGNtB+j
	JrpoIXd9SSQiKTVJ0ozVHUjMPnJQ0DwIzauPpK/ZCrnzvJTrUu/K3SeendL2QsX9gX5WKOqHVG/
	Hi8MxHey3s+yjavfvvXMokl4WY8WjwnS123niSKMmEvIXytETSaJ0cpzkjnBunXYVNVl1uLAQJK
	Y13iPyfqJ9Hw/CkGGErojZffNc96G8hA88X1GIU19mkScCj60NusLKiOvQptu/khj1WcwJxNCDc
	7+Dv2rQu7QCME8yOPbPgaKehryeRtEEUC0TBANaEdHKR6hJ0kHxwtOSy9QPq9BmiavhF/Bu5QxG
	ttbTGPSENCHWXSucktMYYX/NyTx/ga8nLlE08YOh+mA0uhGoH+vLuoKuxDA1m0yQk0PxflEXT8y
	RKH7n30ebgoim9R3WHsOnQe04vT4l3m7u0BN2kir1u+6TXoAeY9eqJv72R
X-Received: by 2002:ac8:7dcf:0:b0:51c:7b12:1211 with SMTP id d75a77b69052e-529a8754649mr97926101cf.79.1785172144843;
        Mon, 27 Jul 2026 10:09:04 -0700 (PDT)
Received: from [127.0.0.1] ([65.202.22.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2a0a7ffsm57646871cf.26.2026.07.27.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:09:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, stable@vger.kernel.org
In-Reply-To: <20260726145025.1507383-1-tom.leiming@gmail.com>
References: <20260726145025.1507383-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: reset kernel-owned dev_info fields in
 ublk_ctrl_add_dev()
Message-Id: <178517214380.2192703.14950200230738719801.b4-ty@b4>
Date: Mon, 27 Jul 2026 11:09:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 26 Jul 2026 09:50:25 -0500, Ming Lei wrote:
> ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
> ub->dev_info and then fixes up the fields the driver owns, but misses
> ->state and ->ublksrv_pid.
> 
> A device added with ->state = UBLK_S_DEV_LIVE passes the
> "->state != UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as its
> proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
> right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
> UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
> poisoned ->state also gets START_USER_RECOVERY and the char device
> read/write path onto a device that was never started, and wedges START_DEV
> at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
> unrelated task as the ublk server.
> 
> [...]

Applied, thanks!

[1/1] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
      commit: e65848e4ce352bac9e3465099354c8b8f845391f

Best regards,
-- 
Jens Axboe



