Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016B29A9C3;
	Tue, 15 Sep 2026 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434205; cv=none; b=TeVBu2TD50UUcYBn+X9qKBoerDAQiX8PKQREY0lhXcuhPFcTWRgTwEUGEibMkmdOdNRuqjDfj9LbJYRlyPf7w8Snb7zk3CtCb2TeqgbVHKCtmHx3+D+YEUjumyzhoCZf9v4Nt13OuiznMkEJ5M9gfO6AyVWxtr6DELCJjHxoQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434205; c=relaxed/simple;
	bh=ikx6CZu4sJTUdT4YtO8hSIjEY9iSEDOe7wD07BmcRmA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G8OArOLeP0YodB4sf9eBBkYtpKI0HIe7Avwt6EiYn8oDGCidUKSna1IL36BTjPlq92uK44OJiLNW9QUbtr84NMZlDkVVjUof42wUNUCkNbXkWnnlJPi4nCwDtlFktethbrjGYZ2jYSaZdDvUulxf8gwYgGBQY59bFZXCTg/wRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nixbaqla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nixbaqla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325AB1F000FF;
	Tue, 15 Sep 2026 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434203;
	bh=adINl+VeAlKEA1FJgDE6kAnLYhmVWeMHTKgjiVxWSJQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nixbaqla5/ouYSM5Dc1Yf2FI8n8GKmffvMBwG2rn5SAkwW3vOb5+VyXAlxgiEVhvz
	 dORQiTzZ9AHVeuY1iFUMJxAfDsltE8Y7RQx+79N8VRlA6K+1r3hEGGF+6Fv97NjUn7
	 CcZ4TYXbteIoFkgi76MLHElcDEbAR8M31eNzZQMe6oYIhOAe9ttTW8AwHFzW54ElyZ
	 yk+QIa1S9nzWG211ACN4EyxEZLJZdNbAQHyRMLCMsKSP+GxI1AqaSVDxjJ8TfRnq6J
	 2no2ZwLB586ZAFTqyfcuTSv25HGoBIPdB6OfdXjtdb5r1KhgXJliZblzIgoc3d9eqL
	 IwhsPTckeaN9A==
Content-Type: multipart/mixed; boundary="===============2740431078445834191=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <904eb79ba4ec6f898754f9ad8dbafd08c82b1333929038fa9cd7dc4d8a188d16@mail.kernel.org>
In-Reply-To: <20260913-b4-send-hid-bpf-event-bounds-v1-1-614fb56a0635@gmail.com>
References: <20260913-b4-send-hid-bpf-event-bounds-v1-1-614fb56a0635@gmail.com>
Subject: Re: [PATCH] HID: bpf: reject oversized device events before copying
From: bot+bpf-ci@kernel.org
To: markdamirkan@gmail.com,jikos@kernel.org,bentiss@kernel.org
Cc: linux-input@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org,markdamirkan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 01:03:23 +0000 (UTC)

--===============2740431078445834191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> HID-BPF allocates its device-event buffer from the largest report in the
> device's parsed report descriptor.  dispatch_hid_bpf_device_event() then
> copies the transport-provided report into that buffer before checking its
> size.
>
> An input report larger than the allocated event buffer therefore causes
> a heap out-of-bounds write when a device-event program is attached.  The
> later check of the BPF program's return value cannot prevent the initial
> copy.
>
> Reject reports that exceed either the transport buffer or the persistent
> HID-BPF event buffer before clearing or copying the data.
>
> With a 64-byte event allocation, a same-file KUnit test produced a
> one-byte KASAN out-of-bounds write for a 65-byte report in three runs.
> The 64-byte boundary remained clean.  After this change, both cases were
> clean in three runs and the oversized report returned -EINVAL.  The test
> exercised the production dispatch function but not the complete UHID and
> BPF attachment path.

This isn't a bug, but could the last paragraph be trimmed to one
sentence naming the reproducer, since the KUnit test it refers to is not
part of the patch? The rest of the message clearly states the problem
and the fix, and this final paragraph reads more like a test report than
a changelog - it counts test runs and caveats its own coverage.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34914058900
--===============2740431078445834191==--
