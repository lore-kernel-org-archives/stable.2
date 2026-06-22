Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B063793CC
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165678; cv=none; b=kttO8uhFCuS0SzdVz7XBvDaPJeBlhI19xqGuFsA296zuHrH1s32z9r7HxRzR+ZYktAGeaRJAH6j95kUX8oykdlDzbm11w7WilyPCaLOLtDdSZxWaUhIS+YBcpuHPq32ZMuafmjVuEDU4DS4L26ANkUPylhbeiq2R/4IW/0LEc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165678; c=relaxed/simple;
	bh=yFP6vPTIKZFpIVTyukJeuS1iJIwz/CHA4/+ifh84bHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f8R6Y5TBXrP+fjWiMQc4GLE+2vztpebIRHkfCJJaRjl0WGWCu+K0RSWxYjVa4P8VD+tXq2BlG+PULEfmt4sari2UQ/l0MZJb76q8YfzBFZQtcgw+DSgN0PwvHgxcHA8DvhdU2RThCoEFL5r4FML1iislfV4zssXsI/SsBw7biAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MhNiM7DS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MhNiM7DS"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dfe7712572so43515797b3.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165672; x=1782770472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=porwEAXdPPEg6IzZtdKU9orivYQedDa6+cnPOd+H1g8=;
        b=MhNiM7DSi0XxarxsgxrbaZWRNv3ZBG25xZLeXaTuXmKpMrO/UYUDVGAeo+leXcJawL
         xQFs24yGmtLs2G8TCzlLAblbaBNw+7W38P2nYo14IhBow29GTbvjz9Hy1y/Tb+ZHIcjC
         V7h1O+6cgMikMh9HRgUO1qdxHHq8Buk9wD0YsOR0OWyOvob/TOSY+ouWChxEMsB3HTLy
         FbFe3EFjpWxJNjz0N78CaGhKHWU0eekEuJrTSZu/g6ZlRhBhYC4/GhgINOvwlkcokF1p
         Ti5pQ4OHuNeP088anlsqgtWJfSIVuLVjIxPCBiQhv7Qh8EiZXQHbPOakjLE4BZ9fCb6v
         YqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165672; x=1782770472;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=porwEAXdPPEg6IzZtdKU9orivYQedDa6+cnPOd+H1g8=;
        b=gLmgMHuFD8qbixRH4D4h832n0LQwXafO8PtSO8jf+/IuTB43yrIdUrnIJBKN1/q5Qo
         syLZGt31g1qHFMcYfZRI2jIBUzsTVTiOb9xXLOD29t7/QfkvjxbvuIVYWdVG6uuMU6K3
         Vo0015v6oTd49lJfQJnus534wKUuwXPpeOwUQpQe8Eeihfhdw9LHQoQ2Ae64N3z6nM//
         YgVFqyTBqBIEVZZ9mdjPCRY430W6BPrNcZE7PFI6cqZC2XcaqDVU1Kggju5yIqxbUs+F
         +50UPWQ5QS2j6L2gQz68iinPHasvr/K6nc505i2yRwEGN3o9CDWnxKFlgLT8WpqgmDMN
         ge3g==
X-Forwarded-Encrypted: i=1; AHgh+Rq+jXrVdVvaCYR0akroIoP6t0VvrQJgIGWl7KXIAlq3WN9w36rB+qqdrGCbKfe1ghsueBDRDMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1HseJyMIWo2a2jDna4s+ZIPCkTP/kTRWXCQH08AFpn0R6uQt
	Ic5WnHeD9jxmSRLcNlw+Dvf8E4t++McWSB0hbeuEECooBTxdlRpEazF58bpjlTd1RJo=
X-Gm-Gg: AfdE7clLjXIA2ActOzrqCeRYVtZexDk8dvkEyCisXMe1ltkqy1vyVtQYG4PVysFt1u+
	F9fTetRCAys0c0gjGS7bBE2YOPM8E/i0YBlEc9NYpSgr+cHSbzUR72YzyI8rKqb84trCQmn0c/N
	SwJ3f3aDnyG7LGVQ2E5FD2MEN5P2oFzVJV8wJo/zdbe7t7zNvGan+Zm4newAHYCH6JChZz4GXxt
	aw91tpOW5zI/Kys3syyT6fqf8Hmd367sXaMsU66tjRctx03sEEPUG63q3lj86eaM7S+ZDR1NFXZ
	5F8uuiiCsvyFPLSPd9SLEFsiclBp38Sjv27zCj+1y1/xTlawIJmX6rLrcphkTXoCkQ/AVKO5JX9
	buE4iyoL16D1uLM+rlKEyx3XAlySWUMHQY1f5dLNmHIpdsEHqlo8OqqmjLJahK8vauDFnk2bC4Y
	R3F9m1cHTtAshobowauDs4vaLnwsrEQ2V+Wmo=
X-Received: by 2002:a05:690c:46c6:b0:7b6:cd36:84af with SMTP id 00721157ae682-801335040f1mr192567407b3.32.1782165671695;
        Mon, 22 Jun 2026 15:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>, 
 coregee2000@gmail.com
In-Reply-To: <20260205155425.342084-1-ming.lei@redhat.com>
References: <20260205155425.342084-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Message-Id: <178216566327.110437.11201759901497714686.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:01:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 05 Feb 2026 23:54:23 +0800, Ming Lei wrote:
> When multiple blkgs in the same blkcg are released concurrently,
> a use-after-free can occur. The race happens when one blkg's
> __blkcg_rstat_flush() removes another blkg's iostat entries via
> llist_del_all(). The second blkg sees an empty list and proceeds
> to free itself while the first is still iterating over its entries.
> 
> Move the flush from __blkg_release() (RCU callback) to blkg_release()
> (before call_rcu). This ensures the RCU grace period waits for any
> concurrent flush's rcu_read_lock() section to complete before freeing.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix UAF in __blkcg_rstat_flush()
      commit: 0ab5ee5a1badb58cbb2242617cb01a4972b1f2a2

Best regards,
-- 
Jens Axboe



