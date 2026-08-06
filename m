Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DD386C0A
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037132; cv=none; b=UIP0Cxv8wLolwPmMHLdVqQ33sWtjg+nfopfT04/ML/6W2W39PUDXsjSvvaOUrksE4cejivkg3qgykx1P/hKZaFuyeVxUFk2Ia0phAF6F0Oe3EFs1GOMJSDMnwPq1OClQxnQxVdfdNNb4ZUI1notmOx7dhhf5eiX5eKb4+v25DlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037132; c=relaxed/simple;
	bh=6iehjLz7tK5y+wF7aaPT++cscWa2tz3sEd1stPo+JWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4GeQudx8HuG9tRKu/C75vE7co97ilNrAfk8Q77mg8BV+b3SZu6w41MAsXnOVh+ZQdLNBO0jRtaN930dgU+p5cL9CH6e9q3pakkr9+YOPs/W0FXLqhyocPSjTr1lD4ovW6JudKN9c86wocu65a1XVSqTK3XDCgpjUSG+hCyhZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw9ptqlC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw9ptqlC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2334259a91.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786037130; x=1786641930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TRdZm2/OzOJOHLAefUfdbI0717vY0s82LnHh3Ur5RU=;
        b=Pw9ptqlCc5rOjAO4BXNmTTEMDJnKqw7XP81Rrvodq+jkgjRuPUm5BU4pv69plaar2A
         3QTEsx7bMDqqaaxemFmoPKCrjyCydKb33ve6bjh8Xo1HKhf5vvy+9cfuyXBm07DPWtzi
         lARALAsc49dNY6gcc0whhbFrPcYCE7pAVb5pWedQ6NyjAygrGscK6ZdMSTZ2xd2MUSDV
         ouzdCSqkuSzdDSnTPtQO8HTT/xpEUKXTWvWkVZEZGfyJLZ1grYzUCbIh2zKqzRgdwud2
         o4gAA1cY3paoPQY7bQ/C3C4uPyjtbXXOU6g/k/ihlQDJryq0whq9ZP822IPPZa43qI5R
         BM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786037130; x=1786641930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TRdZm2/OzOJOHLAefUfdbI0717vY0s82LnHh3Ur5RU=;
        b=s8pQ2lln+vTSaNeczR50YVziRZl3/sL7ZqIBA4iu8rrTk6SWcjAnRZTyfYRo/+JUm0
         pGmdrxy1HP5UpOYTCV9+b4nCWO98nUsyjxeC71kup4VE0M+/Zsvb9LqTwCRuCfqYNJ1h
         XR7aTA0gSM6pSNXomNXCKc2w1Jj1kDiKnmpn+dfyR0Nhb9HvkKnVaTyjVp1zZkNUNejH
         K/ZJsXTrBw38evhfbwdTcWquaOCI7REPKWUKi4DN9gr0ap5YsWPJwlh2TsTqynLUB/pV
         0tk+u0I7sF1PYXqPXJVJb6od3X+cb3YMXfGt5w7HLCBwBXGNpIyM8yXm4/a3WevXdSEy
         zepQ==
X-Forwarded-Encrypted: i=1; AHgh+RoH9cl/EHxvfWRRooA5TJqs8fP5Ge5mLDhFAydel3hMq93TkINaSDrl6/iuYTkzWk0FpvumU9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgXEB+QlRayaCN83JdPcl9EDN7jBlPSWAenLSJW+Paf8S7Cav
	0lbVlaiK4B0HMyNnYxIK5M/JBr70+SjhGPC4xB+dMxdJfDhu4lUEMfeS
X-Gm-Gg: AR+sD10YOUKQ2cM4LQdXfv3cJ9nhzvVJJGUs5fLAMDnH6hb2LndKW4LSzVlBqAAlw0e
	f6ZyPzoFMXqoeCjsVm1jPYumdhjbDkSOC/gGTwsdt+0lFg6D0gi7XUdjuvaf/CTCIzi2fa/vwQh
	ICSYHPJvzT/o3oxx58yD8woGVEKuSCbI1QgO2Nhx4s9xYFXwsyeb/2wGucutq/tu6PriKeZ3vGq
	Ve/2DUUK40k15i5ULfhlF1fpP8OSf7UsRRiZcqi5p7OWBH0JVRc1thW9sjhWb3EpJeiRnpNtrB9
	Q1Cw4Ks/rcrLcRp6MFCjTEmtzS86E9vf2XRrWkdQqDSaq2/a72GPyJKlo6XH8SSXjAJ3AfVUFpG
	vCe9svQxKAeHRH932HpbkMSlJnjafchyDzdBteT7UoypkW0Hx7OAYZph/UO4ovaDca3wqGNQT/U
	DWQgkOzsVq7JbE8/LzU2u0cbJLqYzqW7MIVShDnElshnPqCJoCbnxwUzAJUn0xEWyh
X-Received: by 2002:a17:90b:1c0a:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3903b9eab48mr15997786a91.0.1786037130324;
        Thu, 06 Aug 2026 10:25:30 -0700 (PDT)
Received: from Default ([2409:40f4:1024:7ab9:e121:51b9:f38d:da64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d7e4csm31113126eec.31.2026.08.06.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:25:29 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: usbip_host: Fix null pointer dereference in rebind_store
Date: Thu,  6 Aug 2026 22:55:13 +0530
Message-ID: <20260806172513.126406-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080645-nickname-undated-d0bb@gregkh>
References: <2026080645-nickname-undated-d0bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 07:42:27 +0200, Greg KH wrote:
>On Thu, Aug 06, 2026 at 11:06:51AM +0530, Jeffin Philip wrote:
>> On Thu, Aug 06 2026, Greg KH wrote:
>> >What prevents bid->udev from becoming NULL right after you checked this?
>> We could use usb_get_dev() and hold a reference to udev when the busid_lock
>> is being held and then release it after do_rebind, or would that be incorrect?
>
>I do not know, try it and see!

I tested usb_get_dev() and usb_put_dev() on the rebind path and it compiled
without errors. No undesired behavior during rebind either.

>> >How was this tested?
>> The method to reproduce it is in the same thread.
>
>How is this just now an issue?  What changed to cause it to suddenly
>start happening, or has this codepath never been tested?

Nothing has changed AFAIK. The driver itself depended on sequential
order of operations and in doing so, failed to secure itself against
non-sequential order of operations.

I will send patch v2 soon addressing these issues.

Thanks,
Jeffin.
