Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0148CD63
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681492; cv=none; b=conj0XnsVC6AOEEvBMO77FovqKyCk2ERJtggJtyYbv3Fwb1v3gfRmj79F+LNOld4LvCbJK7wBI60+mA8rjeXtFyx0PAxo9AavEiinE1fOuh+ibw2vz+aTHkPYTHpG5UJrPq/smmuc6RYfWrcHGkoWFAaU5dMSrUOSciHrsnGRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681492; c=relaxed/simple;
	bh=N1QrMA5ObWp/XY1oSMeV1FCiVJPQXt/MwRzQHOM0Vng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GfPAes/9blmuVak7yWmecOKcHk9zjQaQS1N9akgLgzxCM7ClUTPWJKDnDzHpQIMgrrKuIgPoRluXS8rz3tOnR2wcYQy5s5g6I9t52sMp7UgYQ2XraWqzD1uLmU6bsLalYmSezpYxMEXaKE3l7aPPyMcS5oI81ACnxZt49hSx6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cWSJso5r; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cWSJso5r"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f18c0e03e3so51173a34.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787681487; x=1788286287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHGXj2p8sgHPOQBt6Rn3e/76PLQCdLvJmm0grKZQxr8=;
        b=cWSJso5rPGxrBT7jNKq7aCzWBPiw6YzWLusTwby4nADKjan572QhUc6PZ0qQC9Dm0J
         fFAz78G4RN92wO1tTQx0MKlFdqyYymtPEU3Ma8qNSSXQYsDTclEz46bdPl9YY7gOQycg
         eQYPHW+cgRdQVD1G6+cQdRQiJ0LfiIlrq3smUM50QU5RXmazIGjVMfnknGskbjrv/48L
         j9NmboDUE4451+4iAUeMYPpzmacZR6V+DwLZYcHtuClVv7eEepakK/h5/KkgjVo82eQW
         cUH83uCv29neChmqdLq60Lm48PKGyF1JnCf92SNJevUvpbpsfYRPe3Tq3VYJ8WqAGBVU
         qRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681487; x=1788286287;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHGXj2p8sgHPOQBt6Rn3e/76PLQCdLvJmm0grKZQxr8=;
        b=DaBgf1z5vRn47byvDsUqV3GCW2GVCG2RA2erE+Ku2jZIVwT4zeeWpcS/uSTl2QvFx6
         OvTArd19z9GIUviuKysylxbXzd7t77Wah9mGRWwQKKt9eybrLv6LLF5lo+CHq9FC4OXj
         zAL1az2TKsO6/3z6A9r6GrXOGQ/59FsRdPCCpA5Mrk8lFt3U51+qLi62fjq7Hi/+GOab
         lWlbVwpGi2PlD+Qc2bzEY4OpzgFRl1DMdWKoWzvdzHb2svHor1wj+e18SocqOCDcWGzU
         t6lZkbtnK/jjuqYAciNg0WcWP0oTL+uPIKeJHDSw9aPu4ASHNVZ7LtOzPLcsNKvvxdEI
         v94g==
X-Forwarded-Encrypted: i=1; AHgh+RrYe7FcIXQ7nQ87SduGhQLqAS0WoqhgnAJ5BY01eUqPHgWEpcrQbB7Jm08dZrXBh9w25B4OsOs=@vger.kernel.org
X-Gm-Message-State: AFuF++livhEqDSn3+awRauTfjZDi5VC4Wj21YCoa9hjGaeXmeL/rrmWQ
	/sT5n/xNERADPp0a/ZJnwKMeah11ZQqWBc7tlDcQr13mTLEdCjyCl9cFo6c8T/1/G2I=
X-Gm-Gg: AR+sD12cX8msTxuBslsp5aYyzngcR0HzoGi6JyiZwylS5Mi9Pmp+GnYz7hklaoflfvM
	imF5J1NCdtZnegaZbWj47WKE3ag7h2iVKqLTBWGC7RfxqD7l1md8a83kxRXkJN/DRXnYGxzAFF6
	ZG/RFvCCjgvYp1oD8w41v0aplUZe84rb+Wjqaj1japg4ORjy+P10Oaw+kStY12lrJsMok3r+3F5
	uYVEj2Y7vWsZeyOs1MOpayOPuycb67sDCP6V0pS1vG7RKgjDTnNZ+I3GvjPx1GpS8Abte33cWLA
	9TCFsk8n9Xhai0BRbAhaEZSCjLBZa/pd5AOoOpKzFd/nPHDoaer49k/1QdC/k1oH/3iCg2uMXJu
	596AgMKZSbNfONI5ZE6eIXmMP077ZwAU7M8jfj9aWAdPq/SdhCw5pSmHXiH36ba9gi2fAUNe3Dm
	UbcWsYhhp2TV1ZE+F3sB7ro/t8LrWIYWaqdR5GeXW29XGKmcpk/trvEJTtCdXZdOV0OvmXu09Hv
	QoO6XfZ4EoK0IXgAY0kjNun2786+cclOHUtuo3Q
X-Received: by 2002:a05:6830:6211:b0:7e9:cddb:142a with SMTP id 46e09a7af769-7f4c50847d4mr483681a34.7.1787681486941;
        Tue, 25 Aug 2026 11:11:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c4424de5sm185250a34.17.2026.08.25.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:11:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Hui Su <sh_def@163.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asml.silence@gmail.com, gganji11@naver.com, stable@vger.kernel.org
In-Reply-To: <20260818103336.1922818-2-sh_def@163.com>
References: <20260818103336.1922818-2-sh_def@163.com>
Subject: Re: [PATCH 1/2] io_uring/waitid: honor task_work cancellation
Message-Id: <178768148595.43624.3625796882295211976.b4-ty@b4>
Date: Tue, 25 Aug 2026 12:11:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 18 Aug 2026 18:33:36 +0800, Hui Su wrote:
> io_waitid_cb() may run through the fallback task_work path when
> task_work_add() can no longer queue work to the originating task. The
> fallback runs from a kworker and io_uring marks such task work as
> canceled through tw.cancel.
> 
> io_waitid_cb() currently ignores tw.cancel and calls __do_wait().
> waitid is task-context dependent: __do_wait() performs child lookup
> relative to current, and the retry path also uses
> current->signal->wait_chldexit. If the callback runs from the fallback
> kworker, current is therefore not the task that submitted the request.
> 
> [...]

Applied, thanks!

[1/2] io_uring/waitid: honor task_work cancellation
      commit: 14572de82e5022899e5856008bc9cac97004a88c
[2/2] io_uring/waitid: avoid siginfo copy during ring teardown
      commit: 2cf20c4e0f72d523b8673053e7120d092ff1f074

Best regards,
-- 
Jens Axboe



