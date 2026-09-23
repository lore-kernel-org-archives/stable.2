Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0F5226A3
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170965; cv=none; b=UbV4S7xoN5tqqrtfJXricTur/PTkREjU+GRtkmNnIqjiIbcQIZAnVZU7Tg5GvTxSz3SnRv9ut43QoR4Z5i78y9pbWhSdN0n5bbAe9S4dAYWLPXhLzHkyffh+pfAfn6bQ1pB1NpuiaNKS/k5XwZZQjsazn9/fBcoO13g3LLUjZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170965; c=relaxed/simple;
	bh=LJV30kQ3AhVA19Qy4NIYzlbllUic9lnXc34rf+8lBzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKA+7Kp+lQXuk5UC96rSMFBKWtgBZnq1DPdoQsdgwuZbCXop5lUDYicIWDH/CJjLbG72hhnPhWKOcLyKrlgmGVBYIQwXURdZgNknmjoEEAa5UkHGi84r2g7+f2vYR+Fu75VTAHxIo6g0/xbQQUTAPfGlvXsLXhcxg8TC90b2+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJYoXcNO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJYoXcNO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba92so673876a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170963; x=1790775763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW9r7iNqfIgerNjHvG5s0sL/lw15LFmmpUDkujs3h4w=;
        b=YJYoXcNO9tam3m+wEIriMKQpqKt5QN1zYYQm3yl0F49YbafC7pU+Lc8A+IzBTeIrBP
         kyPPzyB9Xt73wY0pxyOCZukMd5P02+1c2xhvp9P7/KyUEXLLs60FL1sBMjvJW88RzUSU
         /JOqyE+qrIoSk13zl8NCbIpsPSMKfAvuabgiNQ/EGvoWyRLmLgYFJAy0oiXEqKj4vFHO
         3XmdcV4+CT/FS8NjwugQOsf5cK9rTbVCRmSa7+xZslmWMvJvynzKP3+j8Ff49ZvMU87r
         vxOgHhw6s74CG3jZt9pEZI0cKWiEiHIdX1pPCrQ09w7L5o8komj3mBkem0MIao+KlvlB
         xbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170963; x=1790775763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iW9r7iNqfIgerNjHvG5s0sL/lw15LFmmpUDkujs3h4w=;
        b=rw0uWInlgLaCPTHd5i42pKq0BJhMFwO94Xu8weKvAeuadpicShF0j6qzO589xOFOiG
         8JTDE2mCTloDlI6wyu2QI98eWqTNwjuzsldozMTWtEULyDJC3cjYopBXLhramUR2ttUe
         +v7nCha+7GEBr7ZtiCUEtG7+n8itdrEPc+PiBsPo1TEq/Y8GW57ANT5eG8B/52bHnNzT
         grAtBhdTC+8mqS4JxTyvkZdabANqvnOYo6M1jgi7f1l7q8TTY0j71VW0czOKSVvdf2lv
         xQg/p26ptXpEj1adx2jt9wdD7gHT33h7U7xus3Z70SPdZnQmObRdFlNu75GIO9tNZhCn
         4CBg==
X-Forwarded-Encrypted: i=1; AKwUvBwThMvzrQS6UERMLfmcI3Y5Si71tyvXGtlz6v/yN5KIdG36wsrFHo/clnxkXYvqyxnj7iVbtU0=@vger.kernel.org
X-Gm-Message-State: AFuF++mnUOEl/CK0DEV7OcNukGYc/YUPT56nOdYkHDxT+F/dTZ17L1qo
	SPmQ7hFsWyQo2FUqiETM2Vrapxo61UJ4hPtd8Wt1Qm1A9y81c32ZaB58
X-Gm-Gg: AYBFou112cu4Xl7dr4vlDOWu/DocEb/fftphN5708K1uYDEAWwMnxQxjy9g3mxirHyZ
	Os2EgpNMf/e2GR4+/a/bmLFqL/nrk1MX480mpKQ94SLMswGxfM9ee8AzEUt+V5IS+UQj79O+c+N
	JmjmSgEu7XClmisLUW9X/joQeSQZKF1J3dyKBXVxNSEV5JnUp3+fNamW2Usrg86CJX40fiUmFU2
	iqLKDPj9FfRMeM197zfidNPlnc6m5sNgTn2OjKEngF/oQ1gQK9Bebc5rnapJGgnHE7BFw94xcz9
	deXyki9JcNowK3RcXR4X2IiSzn/V525HzruDajuPxKyrZZkefI1e7WE3pFBJ+CY2ofh3uRpIU+B
	AjnHV6G3XjnROThyJQRolV/3XgK8PLKLZnKkDlcinmQD/218/fCb2aU2Q6R/J6PEtK+LQCTsQZ1
	3yz8NiCp0G369qTZSda/G3czpdZlvI3UURg7J6gwS/aNGZGOHEI4kzOAW7FcRdrJ45EEHQ7WZ5l
	lJdOsAI2rA=
X-Received: by 2002:a17:90b:3d8e:b0:39e:194b:fb2b with SMTP id 98e67ed59e1d1-3a07e51d0f1mr2640854a91.22.1790170962777;
        Wed, 23 Sep 2026 06:42:42 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a089197169sm2966570a91.8.2026.09.23.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:42:42 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	kees@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] time/jiffies: Saturate in mult_hz() instead of wrapping
Date: Wed, 23 Sep 2026 21:42:36 +0800
Message-ID: <20260923134237.3628505-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <pu5kcrhze4f2wz5fk2miocxx5edgmj4tp2zwcv3bpeo46vo47f@siezjqbxiuk2>
References: <20260922031229.2300283-3-zhanxusheng@xiaomi.com> <pu5kcrhze4f2wz5fk2miocxx5edgmj4tp2zwcv3bpeo46vo47f@siezjqbxiuk2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 02:27:56PM +0200, Joel Granados wrote:
> Not sure what the difference is but this is the result on my test
> system.
>
>   #  echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
>   -bash: echo: write error: Invalid argument
>   # cat /proc/sys/net/ipv4/tcp_keepalive_time
>   7200
>
> I tested v7.3-rc4. What is your base and did you modify any other sysctl
> before you ran this?

CONFIG_HZ.  My changelog gave a bare number without saying that, sorry.

The value has to exceed ULONG_MAX / HZ for the product to wrap, so it is
HZ specific.  I tested with CONFIG_HZ=1000, where the first wrapping
input is 18446744073709552.  At any lower HZ that same value does not
wrap, the real product exceeds INT_MAX, and proc_int_u2k_conv_uop()
rejects it - which is the EINVAL you saw.  No other sysctl was touched.

	HZ    ULONG_MAX / HZ         first wrapping input   wraps to
	100   184467440737095516     184467440737095517     84
	250   73786976294838206      73786976294838207      134
	300   61489146912365172      61489146912365173      284
	1000  18446744073709551      18446744073709552      384

Measured on v7.3-rc4 with CONFIG_HZ=250, unpatched:

  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838206 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838207 > /proc/sys/net/ipv4/tcp_keepalive_time
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  0

One below the threshold is rejected, the one at it is stored as 134
jiffies.  With the patch, same build:

  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200
  # echo 73786976294838206 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # echo 73786976294838207 > /proc/sys/net/ipv4/tcp_keepalive_time
  sh: write error: Invalid argument
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200

tcp_fin_timeout behaves the same.  Legitimate values are unaffected:
7200 reads back as 7200 either way.

I will respin with the threshold written as ULONG_MAX / HZ and the
example labelled with its HZ.
