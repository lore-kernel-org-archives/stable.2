Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068220;
	b=bNud5iAwtdCFSWCQ4i0H7yrNMiRPUDqcKWunN0dpciY7ZIty2Yvxbycycn2jptcBIqWM
	 PBieSNqHqLPHh9g8n3Q/L4vD38/8TYpaqlfG7lQg6pNpjnWubjG+E3CdP3w6jRNf+o6lD
	 E29YsYV2sBFpFxWK+Wcr7UHqFn6UXqI5gT1HZJGB8Kj/TcUUYbBiie4kJLNqFzGa5ZuN0
	 Uj6dTBIKUu80MeDAoJFckhb2k6+wu2Q9VrI966OxvAh/cXxTeo0v3+Pk+1iTzPXT+aAy9
	 IK9I4XFOPNLuf433ggL7Hm6hzrxgByxRvsDBZH67D9RHWiMrOB7Ogru6klLVTnc7bcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OCMTF3ce5FBUr7IZB6OhqFZbZRksxBMNW3r02rJq5Uc=;
	b=2Ey2OnGng82G2ruUzY1pVHzrPFZ8VVzpoYG5EaliB8ItKgANbiA+N9NyG86LX5bTv3iQ
	 LCMyRA7mB9rAEUL3uxB+1PHKjy1BZyKwXB4oyE4+ew56ufD7wHL5g/EaxNMN5dNgPqm+n
	 khR9+adoK2OqO00erg0NTX6R7txArDWFlnEG590SGRStg6UXR3J3y467wdTlbiGJb9bMN
	 pHng7yYu5AxqAILKWbO0+1vUPRaluRT8eQNP8+J7ApBvQLy+hjneXyv81mBcP54hThWj4
	 txiIuvjwbfGoRmOcQeTTZxLlaBapillxmUAkSNnqM/i59G0THSswazW85vBk4KMcm0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W57lBc6J;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A8606EEB4
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31A8606EEB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W57lBc6J
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso721581a91.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068219; x=1794673019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCMTF3ce5FBUr7IZB6OhqFZbZRksxBMNW3r02rJq5Uc=;
        b=W57lBc6JrgHgDNSBWPIV9roirP+GQ5gTTanYwzPUSoOiGZfwExwMKrIj0/f2kWd2sP
         lr1FUX0Ei07sOdacPr4a0YVIEYWPP6BRM4vGGxuFJ/ZwQ/GCA6WO2S3ZDaJKTU3tsYcP
         SjaOXmbJ+96LFg7fbixLoHnNs5gmOf8z/tNFh0rP0lPT3Tbrcf9VezrTcITlNg65ZNMe
         0o+4afykcsM5GvJquu5tjwR90bFPSLqGzjdPr10kQBjBrtKtngOqEKjZXNKPeckYOwSU
         nLxewBK4KT5csWRD61WJxYAC0X/FBalNXKwWwzDapMLahcaHCs7EPC7un/Cls08UoML3
         Wsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068219; x=1794673019;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCMTF3ce5FBUr7IZB6OhqFZbZRksxBMNW3r02rJq5Uc=;
        b=QOy4Uj9tliC6qLe8GE2Na3JSFPkLagSSPTjslmOcpPIr14Jy9k7Fa9mBAM2Ph6SmqX
         cca6KZr9QKZ/okoqyY8gRIzQF1izbbMAXvWlDfaTsS8x7SWwquQhLU02qXODJbw3yaYs
         8QU+jK2ewJaxbK3eUnou6CRHev4FvbJwaTISxYCGbMmI5eUb/Aa9jz/fnbwJoLajVeVj
         9/OO5bBN6HH7p25gEckTtSKe3VppcCW66e/9H3GldNFVBtQKIV/QnTyXAOvPhvUG+I7l
         D9+97b1ZhgyEUgGd8OZqSUg1W8gQVpZyb1eCv5ujvgmfXAbKZ5RZ12NRY90r/jBfKxzO
         o+hA==
X-Gm-Message-State: APuU4Z+3lbyqB9+7NCZ8aiQKDL5I826hPKtdfYEFMoShTu8OT2Hv3Bs+
	JLzUn1Cmzxo7zwlUQPMnyiWFYo7T3OGLDcESWuPgHl21n2c7ZJIb6w3jnCkOp6jn9nhRKpBnaFp
	jOQjpiRs=
X-Gm-Gg: AYBFou2TiertDkD9nogDdEM22gDINPytU+BnQTCSrt7DIdeLj8fwLgnomviOiChk6Gg
	Y7D1n2BjqfbX3agqajG0d0vA0vFmF4POxWWWub5tA2R9WMicG3LX5a5OL+RxW+9oKqsjo815G6p
	YvxvW04uQXwmjz3nMNs9QEqDRaRNqn+Tpt0ngbcURnSS9XgTtL/ukjBJS8c3FE/9y0fp9dFEHyA
	FWb9j+NkQWYlYtaQO0rOT9FMw7V7+7nfmTC6GNVMZsigpUJ8gf3tTIHbJaP4MmkMrJYe8lqPBek
	vDLMNsdp/WZHEwODQz97+fwGd2cueuWu9+83KNCJm5LSkN6o3bnrmteZAvmaQ+lHOM4nIoly9oF
	V/1S0+kjYRB3L6SjjERsxqLJJoq1wVl1Z4R/3kykDNtgIKA/8e3PhjzSxrDFx5QcarlCSaECL8s
	8NyvxJRN69nwVRdQD0ecrBSEccxy28QAUI0314AommqcI+cJcPDbM4keJkzSXyu/0mZ3K89tEeZ
	d7i+eRxFCN4OGp3UK7JSG46dttMFWOppUnjkOkxlVZ8zpSpwbsGlsluIRAAgqDu2cLOTQZJN13L
	v4s3//q7T278SLnModbWhBvaTyIGF3snubcEPTWG5pKfjNgEqirW2ahg2rcbaLsHeuJ/FOAuUgE
	=
X-Received: by 2002:a17:90b:39a3:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3b0db6d40c9mr5919574a91.22.1794068218860;
        Sat, 07 Nov 2026 08:16:58 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.16.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 0/9] io_uring fixes for 7.3-stable
Date: Sat,  7 Nov 2026 09:16:47 -0700
Message-ID: <20261107161656.2500790-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are io_uring fixes for 7.3-stable. They were waiting on the
io_uring pull for 7.4-rc, which Linus has now merged.

They apply on top of v7.3.3 with the current queue-7.3 applied
(stable-queue 0ae08d01c389). They don't depend on anything in the queue,
and apply to v7.3.3 alone as well.

The io_uring series I sent earlier this week is already in v7.3.3, these
go on top of that.

Please take patches 1-3 together. Patch 2 closes a race that patch 1
opens up, and patch 3 fixes a WARN_ON_ONCE() that patch 2 introduces on
SQPOLL thread exit.

Patch 1 needed changes to apply to 7.3, the [axboe: ...] note at the end
of it says what was changed.

Chris Mason (1):
  io_uring/cancel: drop sqd->lock while SQPOLL waits

Jens Axboe (3):
  io_uring/sqpoll: don't attach to a thread that is canceling
  io_uring/poll: don't poll a writer for a read side hangup
  io_uring/poll: don't poll a writer for urgent data

Shakeel Butt (1):
  io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Shang En Sim (2):
  io_uring/cancel: count all requests that a CANCEL_ALL cancels
  io_uring/poll: cancel all matching requests in one pass

Shuai Liu (1):
  io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Yuansheng Yang (1):
  io_uring/rsrc: hold uring_lock across index-alloc put_user

 io_uring/cancel.c | 26 ++++++++++++++++++--
 io_uring/poll.c   | 62 +++++++++++++++++++++++++++++++++++++++++------
 io_uring/rsrc.c   | 21 ++++++++++++----
 io_uring/sqpoll.c | 26 +++++++++++++++++++-
 4 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.56.0

