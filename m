Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1233D9DCC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273865; cv=none; b=Nr1NtileP/4iGSZ5oqFRqgdjs/NqQ5to5DtYaAZlRUIpfm6dHTeMns7Y9G+cY7R/+TmvZI0+jYA0HjCM4bcCvcnqEa7dQbLN8LFwNYW5s5/snLnQzFbR1hHTHVHqTHo2BcWbEEY4nYMGliyAcAcr6bRL7Yqo1qSkI0zv0H7IUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273865; c=relaxed/simple;
	bh=+FOnypf+Mp9Aehq2Fj42wLy/OBdGqGeSb4cvSaI1vkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EAW7bIVqWN1Ek+SsIcfwAGthIwPGCUVMVwDkhiP9U5WRRh+1IIo9LcMgNbGnxuh56t2lVHpMbdRUQHjO/0ElwvKTANSYragozCmRlZpLoQZKoGkAvHI4AiUORiylxokA1ex+jKykbM/31zVuQ7pp0aGWSRoJejV1aAeU4wGAZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rajnTzC7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rajnTzC7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so5379277a12.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788273864; x=1788878664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0vWc8aYx42ainJ2ce8zUpuGQ/0dRtkVtNRSyYtCra4=;
        b=rajnTzC7rcc1nku/IOHvRjaPV7ZpESwpETxvIrqxRRl/yfb6GzpV6MgWy8Xjw4nVad
         uviXdrbfzzhte9j/4HS7ZOa96IumDqeERdrhivSXUSAibvx9rNiWMMTO4+whFK74Y/iU
         qTEUn8tp0aySYZ6YQOP5VHqjQrleSWFJO5v7sfglB+fWONDaFvRD8W6HcYmcTAusmAzO
         cP+jaMfNYXltQoLMAn86/B0133LDro49t80lx8OsVSJWnI28Eeig7SQLiduxf3qERjyp
         OPpbsXLZ3cqTuAJKIcOCrBxoRmD7CAZhYMessjxWBNDnofna1UQeU4QaUu5KvzA5zCFN
         IKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273864; x=1788878664;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0vWc8aYx42ainJ2ce8zUpuGQ/0dRtkVtNRSyYtCra4=;
        b=RPh1MuyCFSk+K99YUocZndAvzj7bJl9iJq6pGZdQRJls1e84GWXWQzBXrDhKF4i9bR
         L/Rwi0G7dejzOcIAP09LB+vONL8UYdPuRNdS+A+Ssd4I+RH7SMjsK7yj26CCMBZIxvAo
         h5JbM+kieTf6IVgRt+efqHtuxRQ2H1nYaDFYbuCb7u9AH+ZAe5QaOahEw029DUF9JMrj
         +u8hkrDfzkW2dDzR9ujSrI1XJb29rxHwEXNujM2lgyEWV0sxYBRWp/yQ4Kfj+eCBI1Ug
         5CiS9zic+OqBy03oC+Vbnky1zOG1XF6JKi7JDquGyWR28DyNzODIu5DUlYYBTjdPwXFG
         X1KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0x/WuNd4ehitGDaBL/Ptv1jgdIerGQlskr2oluim0zdsN3lYCvdNzt1c7QdImr65NwOQWsSY=@vger.kernel.org
X-Gm-Message-State: AFuF++mEis/XCPTqmXJsLj+NyKUUSw/oIJPmqqJ2lLyzBwYsdfsBWLJm
	a5Poev9EwoEjhgRSbYDDdiLkG89UVyYbmYaWJxRIRvvmyeKOAvkZrWG2w9ovKYA8yTA=
X-Gm-Gg: AR+sD10O9q6zU9OMTrUnNl+J2r5KHS3b/Tl/R5QqwhUs1zBtLwdaoaOjHy7P1SK22xA
	5pjWzceSwSj+Ib4lqUkCFYIX0AAEvu65js1IKO5+2QVNMcQzvqxHC7ARKDvjNh3p2dTrm4Yc43p
	mMa3wwLmflA+dnGiOSD0JUqzUt9UDgwTCBcONwbnvCRu59U61kruAusPTwMIVnJXhtx/hFkywVC
	rANr99egn9RT+Q22jt7a9aSP02goSeYCcQohS9nnNccCn04ZKucPnYCrW9vFhoEUcldcHY4oeyq
	IzSPM06fr+sohEbFJMlgJaG4/uuxO+iSlrKupIpF1/OS93ujniXsA3WKZo6R8ln0M8jgUZaVozB
	s5e7c85ggNF/8kn/jbFhLA/SQKvfj2615quJ7QcdDMMJRqLq/fQDHRvylYvykOS0be+AdjE2L+Q
	EwKyhwl9ESgL7uLW9Zs6UUhj/4Q68k/q4JOnClzCBj4VfvMskddYt1vTxvYpTlADhn0YPi8QPio
	0exuKDCbPz0C/aluqtI0rCzevdi/Avhgqt1kdCnbWaC
X-Received: by 2002:a05:6a20:9f43:b0:3d7:b90:acba with SMTP id adf61e73a8af0-3d7adebd88cmr14287762637.6.1788273863692;
        Tue, 01 Sep 2026 07:44:23 -0700 (PDT)
Received: from [127.0.0.1] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm34773046eec.25.2026.09.01.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:44:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: greg@kroah.com, Kanishka De Silva <kpskanna1915@gmail.com>
Cc: tom.leiming@gmail.com, security@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260830070133.559-1-kpskanna1915@gmail.com>
References: <20260830070133.559-1-kpskanna1915@gmail.com>
Subject: Re: [PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device
 mmap
Message-Id: <178827386275.2511601.3836130967214754314.b4-ty@b4>
Date: Tue, 01 Sep 2026 08:44:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 30 Aug 2026 12:31:33 +0530, Kanishka De Silva wrote:
> ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
> clears VM_MAYWRITE on the resulting read-only mapping. This allows
> a userspace daemon to mmap the per-queue command buffer PROT_READ,
> then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
> never cleared.
> 
> The command buffer holds struct ublksrv_io_desc entries that are
> kernel-written ABI; a writable mapping lets an unprivileged daemon
> process corrupt fields such as addr, op_flags, nr_sectors, and
> start_sector.
> 
> [...]

Applied, thanks!

[1/1] ublk: clear VM_MAYWRITE on read-only ublk char device mmap
      commit: 6e2b571b0a54755b06e092501913e1dfefe75d6c

Best regards,
-- 
Jens Axboe



