Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86A34B697
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477162; cv=none; b=aI1rkSsonlMkTKBGkZ1cCElL5yQxzKZvqQEii7+zceS9xkIBMxjxmSMXmSRnkxF/8UXjYY8GYu0d+A5caYKQ6KPtwv7cu+dinzIoGk1asnhlcPw47hD3YUa96feFKypnnIIZk4GDxowrVx+XJo4b4pcxM6B88d929FxFqpZLpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477162; c=relaxed/simple;
	bh=IPntKLkEOzLvzwxcSGiD302RIanbdRbGDxuKARn4u7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=efYzA1b/DdhqTf868OVH8D7viUZh3jgh57svcoRl8Soe/QCN379RTlsnFYDWQSiFeWpeOmjGiCS8SZcJUBnJ17QpAUdB7SfM4a/VDrsHNCDv+jSwjTuh+EqFB/lxefkVmUPBebPi5hy1elRyewg/u5CCQWKbqecBGl0cW5ndJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=uWOYQ8bG; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="uWOYQ8bG"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a3ea601aa1so2545746eaf.0
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784477159; x=1785081959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MvDZW/POLDcRoqoRMZWeqN9TSs71ndbA2gC5lGcHbc=;
        b=uWOYQ8bG82QAZGo3rGsmqYID2AA82Cc79StI+zvWaD/UEgIga9h8++LnKbdb5O9Qkj
         KlZP+5gb+zF5a9gq21mp8825DIJkl7O1xgVZVbrYNWVGNjDpqBcYu01ee6C3i009EvmY
         LrXHoWCC9sVU3Kw/9C9A4b/1FmjfDU7YM4MWod0V0pc+LprdNyhuxZL6tfsW4enqLoqb
         daVpuWFrZc/2ffNAPaSvszLKGJqk7ukkn39r8bz/Dh9OHs4oEPQqEQ5Lgxl0Mh2XdP4i
         gd7IQCWToQyp3WTtC4GaVWluWabJwq1I/2u6dGsvMzTCOUz65H+MQpGv2VZC89xwZG9g
         yEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477159; x=1785081959;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MvDZW/POLDcRoqoRMZWeqN9TSs71ndbA2gC5lGcHbc=;
        b=iYBSAEjqcbKjHKEs8Uui5P7TSsnp19yZhyaA3n/NDhJS0wwpPYyPqs9jySJVHQnJ3i
         1b85ua7vIlqRM6zVKnF8SpZEyctcq5pq0NCO6L+PjCLLhXkskTJUDSaSXnxVixouYei+
         T6NQmp0PPsESkMqR2Nx9ekFBLXakAM8DICvy0TLvaEfi/JkPNpf/mgbQF1YFpBYBaqzF
         udA3aWH3fvz22K5fPQOmlEKQVpa82MSxp+bnCP4R3+nWNYnHMchE2fMmmw1Yru6bPkd4
         6INM8mIlPTP/TpdOTpiqdljvsRS3J6J2aS9RkVqcmoNk1NLFJPbC4NRzDo2HNI44+S8w
         g8Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpSsUPlLnByxXPMlkPDrz6z/azMgxG2ZHDJp9wAnSek4evPO/LjaXx/M9irhRgyRD2DFS1Vx78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTVN7rIGTF22GaAcqMzOra40pvIQ19uDHoOcJcjuHGih3GYZe
	vbaYQEYVU9SyVGVfc5mJFFBguhinmzB2wOjXKNpWYFTSBsWnn9qz/cChKuKtW+wSyw3ZqhFi46y
	laBEiAwY=
X-Gm-Gg: AfdE7ckAoYupZVduO7vG05uFbJclD4w6Zl2BPkmu/c+0YOvjDBXQt9N61v8PVGkfO3A
	wfnEoZYUdTCss03WzucZIlhuknaWDX31ZUs9k3DEr6AijHq8ojCC01udQ7fqa7CW1ogVgOYj9RH
	6GQ6X0JrHQr5HW1g1lIRwvpLpwJOpzOiVS5RYsorlwOwteWYWln+1Ln1ZIXcA3tscSwXz6wFOay
	4KNuUW2AhvirHORJGkVcf2YtNURjDaIg2Njjx0amlW1Bx6NoXXrfdDO54bJH/2fXcbWgOpjLAmo
	9w/njwe3SjgV+k3aNrRbtCm13QQ0TJDoRA9pRzOdJEB4SuFHYEuEvuPOw+4rKwYmAd922FlXMFb
	/Wjmp0HP5g96ICXSh9GUXCDLQ8w+ga1z3RMiwRJCamlZTSR7wzdDGBRkmon6hT8LbkDneZWcIkd
	H1oKfc350cuNMbC8awRcloJSnA7xe7VQz7E2l0JL6pwZVfMjhYTFyT4lVUR+Gyw5sW
X-Received: by 2002:a05:6820:4df9:b0:6a1:818d:97da with SMTP id 006d021491bc7-6a521583b58mr5007205eaf.24.1784477158915;
        Sun, 19 Jul 2026 09:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf983632sm5994012a34.19.2026.07.19.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:05:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 George Salisbury <gsalisbury@apnic.net>, stable@vger.kernel.org
In-Reply-To: <20260719134540.120269-1-tom.leiming@gmail.com>
References: <20260719134540.120269-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: wait on ublk_dev_ready() instead of
 ub->completion
Message-Id: <178447715664.1223836.10975749805730287423.b4-ty@b4>
Date: Sun, 19 Jul 2026 10:05:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 19 Jul 2026 08:45:40 -0500, Ming Lei wrote:
> ub->completion is only re-armed by a successful START_USER_RECOVERY. If
> the ublk server sends END_USER_RECOVERY without one - e.g. its START
> failed with -EBUSY and the error was ignored - the wait is satisfied by
> the stale completion of the previous recovery cycle, and the device is
> marked LIVE and the requeue list kicked while the FETCH stream is still
> running and ubq->canceling is still set. The kick redispatches a
> previously requeued request, __ublk_queue_rq_common() sees ->canceling
> and parks it again via __ublk_abort_rq(), and after the last FETCH
> clears ->canceling nothing ever kicks the requeue list again: the
> request is stranded there while holding its tag. If it is the flush
> machinery's flush_rq, every subsequent fsync piles up in uninterruptible
> sleep and teardown hangs on tag draining. This matches a report of a
> lost PREFLUSH with ext4 on top of ublk after daemon crash recovery.
> 
> [...]

Applied, thanks!

[1/1] ublk: wait on ublk_dev_ready() instead of ub->completion
      commit: 432a9b2780c0a01caf547bd1fc2fcf28aeb8d173

Best regards,
-- 
Jens Axboe



