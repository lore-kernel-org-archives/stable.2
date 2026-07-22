Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E1345724
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727442; cv=none; b=YZ2wtK7I8IKw65ZVJ0kNNEDbEmQsNB0xH+71SOy36ZKZOf1Tfluaw1vCmznzhGOyvHhdpHq17YOfMbGO59iSVyosekpvzavRbwcUlnaXkU+/x+jKZE8eokOKP8HBKVShmW3eJqNt5LZJXqak1aiEIxIeMdRTumRLdnrIjtdOFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727442; c=relaxed/simple;
	bh=B6DpiGoerm9m3DlKhnPY/JClD3wc4h1Lk9LkpF+0tDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DDkSXMoebxw6YMKgFAoX76aK5EOutC92P4ARLV2l5qo2dKxtNx4bX8HHq2a8PjtTLMA0cC69fI7TWnBwvB3nCYa1IBqLxB5952KtUZpj09JTtGu+6ozSvHwmp3RRWBWrLv3BJMCPyIR/AySPH41+iXJ17sM8tVie/FWrqSXFAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TEILQjwN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TEILQjwN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb63dbd229so3714988a34.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784727440; x=1785332240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAPdTlgSNacIapUcDKLSVpf/yIfFiTTXS9eHbffFj4s=;
        b=TEILQjwNrOiZHReGbFT9eY7JC4sY5CYfws1tnvEipU34pwlKjszYb6L2BpaGAzajeA
         38d2EP5W79rqRC0vYtNCzLz7Ov9LcWuEgVIBC9qCJRXR5zZubWI3N2AcqzCBv1e+bsef
         UQXUIgoK9AQ/N9J3jwmnm7ZUcxrVxBei5KkRL3vk1LV+RQ0XNYG/4RXTNw/GkuT6OXyR
         BEmM0D1yBkjvueI3fmx4ELqn4udGBwK4MlHzIhe/rk3iF4RqA+hjx0BY4gcvOfGRYMDB
         sxtzBwtewijuVgVtmmc/mIMiYo7EuYwj41IKd1+Fg8UkPCFz+abOF8nC1hs8HbP7Ul/U
         39gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727440; x=1785332240;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAPdTlgSNacIapUcDKLSVpf/yIfFiTTXS9eHbffFj4s=;
        b=GTB+OoFPRx3gAXw2barYK9BP8DX8pBmF2jfaux0E28TuLWmQMJ9yXPFbrNjkiL9pT4
         G+gpXYnvqECzFwLdWVS4rETVocJbA6q5ZozmbwUNgQt5ZI6/ekH1I1uK4fhQDpbs63R0
         V4jaXZ4iqUENPEDvncpao7Ko6Hat1mBr1T+0kg9OVSDHTb9r8p/Xo/n5bmO23uYswPEt
         cjfXT1JpSVBNh2woWXPJw+EJ7zIIxbjAlXGCBVzlzUre02+PwBBVS2KGjUTjVAmWy/Wd
         xZkkR9tJnbayscDwEJLphlWY1L8M0OAfCcg5hxg//4ZBjuyhR0GSrfXz65Hj4zWQMPrP
         vqSg==
X-Forwarded-Encrypted: i=1; AHgh+RpCDjDAdxjCgXfe0VmBs/3Sz00XqDjf3ImSKewCT5JZPsIT0DjwFqAm3Kkou/P8wDUHY4ndPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzPNtMQj0yLP65pybImxYFx6epD3933FKUTeSHwaWkpLhXPll
	tSb98AB3SSgKUuRWy61lJw0fqVYwXLFS+waP+GqtIoFWwvdGo0tTg+F1OKvc3vZYlukE2QtG2/S
	xGRsI4Vs=
X-Gm-Gg: AR+sD134goZIEnfVOIyA96S4vjVUdVcCjBDojREPcrrM8RiXuGicZfbYDtrUD66Pah5
	G7Opu/gL/2eXb6jrBKXoQ7BDAZiW4QQjzDdTRWOz8Aunjal4NehTeolAlElsIQplJbs5a3LjIcG
	0fWrELMKCn7pshIj1GNYFcqNNCZZiQjubqh6BDpDs7c3a8Jhu3sXpfEaQ4k+AesgvId6WNpZ6zN
	VbOOxSGHn8QfH9xiOm60vqRFYwkrm/M4VI9sKZdZSo4bp74JzmPBLjejfs1Z0XRzxo0Up4IT649
	rkhf/GB7dK21y7l/a9wpK+ZGPrX8R6nb9g1qa8Owcdkm/gxJ7N98alUtQcydCzMdMl/KRjrw5op
	XbC30TwvtPkS274i00+3QUQR4nEEkcrwO86vq3ammRMTBL/eJykHNsQ/c3BUpPWGM6bkxM7qa3G
	yFtQ4i8UEytHL9tH4J6cH8ruSt3Mwk2NQObFn1
X-Received: by 2002:a05:6830:6e63:b0:7ed:ce16:7d72 with SMTP id 46e09a7af769-7ee22d3db82mr1681252a34.5.1784727439923;
        Wed, 22 Jul 2026 06:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.129.101])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db53fdsm1326508a34.4.2026.07.22.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:37:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yitang Yang <yi1tang.yang@gmail.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, io-uring@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260722124551.130563-1-yi1tang.yang@gmail.com>
References: <20260722124551.130563-1-yi1tang.yang@gmail.com>
Subject: Re: [PATCH v2] io_uring/rw: fix missing ERESTARTSYS conversion in
 read paths
Message-Id: <178472743437.597590.12441381990712899617.b4-ty@b4>
Date: Wed, 22 Jul 2026 07:37:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 22 Jul 2026 20:45:51 +0800, Yitang Yang wrote:
> Both read and write may receive internal restart error codes from
> the filesystem layer and should be converted to -EINTR. However,
> when multishot read support was added, the error code normalization
> was lost for both io_read() and io_read_mshot().
> 
> Extract the conversion into io_fixup_restart_res() and apply it
> in all three locations: io_rw_done(), io_read(), and io_read_mshot().
> 
> [...]

Applied, thanks!

[1/1] io_uring/rw: fix missing ERESTARTSYS conversion in read paths
      commit: ab05caca123c6d0b41850b7c05b246e4dca4a770

Best regards,
-- 
Jens Axboe



