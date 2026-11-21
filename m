Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296609;
	b=QV7dQUEQBTrvNHK2vfc7FqrNVlNDRxOtkVqOEpTkpQWgyc9ZsCNi29q+RkVH4lOe80Jh
	 3N6eQYHMO7Ck2wyLHkCWy/XZ0ljcglByQxiMNemYJN7mGOhCesZyw4/ODqrRidUtkoqCi
	 V0KUlpckxlHw40fksRipjY30wJO3utOGwrPk6fKmhothrRz72oVSQqgT/GR+7UTx4exvq
	 VX/iDCGLI2q723Itc1kGQHvsDQFhyi8b9EGGYsS7eqV+ZiHU9/bQYLyuTifVt0jAPhbQr
	 35F62dalkgTOyCv4UtPUtYqvfY4ariTreJ2C84nwXZ86M0oqVhfq20K2cmmzPSGeJCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=W2B7sm4VbQNGTv2YdlDriek5PxhVZmHspvSGwasVDRA=;
	b=CCWcFWunidx2d1Z2rfk9AtRFnCWVZbt7hmkJ6AFx1qbIIKgVZxjR7Cvr1iLtSq6mxWYr
	 3ReSOEqZ1FXmRk6sm5KvKKKHkNcSr6+2pBQmP8Vur+SK9hHRfZt8I+ec1xcLdqsFYSe3Q
	 tNPIK7mkYXtRzAi4dTU9AW6c1Ki4KQRk/q6u1jvxt0lJ08EnkDe1Ut9ilCdAwMeMLJIz2
	 ajN6Ud3sSfBinRyozRHlNkC1j8r0533n+1ydt1vRrHtfxf430Na7to1BOnYCZRZwwVv1S
	 vjZuVNwkNO7FzFNa8bf9W5HjXQHNFQAZyZRJwuMJ/Zxf08QlXf9FvrcT7Ikv/GvT6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=d++OWG+K;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230B606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3230B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=d++OWG+K
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4bd734cf350so1023799fac.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296608; x=1795901408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2B7sm4VbQNGTv2YdlDriek5PxhVZmHspvSGwasVDRA=;
        b=d++OWG+KinqFUyN3pDbkWg4rmR/esOShBhjkPE3dfjUORc6gmuE/Mn5FuOJDXGCnax
         DPXZitMho4ddFA9Xqy4sEwDpHnPlm7LsKqoJ7nsgfJQXTeCtoQutiTtGgnZbSCZ5+Rj4
         +E0k+hbBrgpfOlE3SxJScPh58EgRvLe7vY2kX64Gyeo3CkKMBmG0SexaOaQ+ECekv1S5
         s1Poeo1l+8wtTnnP9Obiu7z4+xEKL5edpsAtVV1DHOSjdqeya1E5HzN/Y8PwjsExmMJY
         0ptZ3rPKLMVtmlNQGIUCcqpRIH6mMTn/k7yZWwPSD9K3RSn9T5qgw0c+7C7b3Zw3Wou5
         xX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296608; x=1795901408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W2B7sm4VbQNGTv2YdlDriek5PxhVZmHspvSGwasVDRA=;
        b=zXknybrSVEgeDmUiq3e5gdoakS2eNKATwsfkzTPebHAJZm9bPnMsZNH0f6VVtr7IIt
         svNEJUSWGeOSY3qDyjB5Z85UU714P9PdHMRcPlvNQNrmUat7zxpmXt5+88ppIoGi8Msj
         qO2BFaAnlpeDOEbDqPjMLHeGYei6EF2XuEyxNl8FMCXzuDWbXNCE+NEwF2WrEF1Lq1rH
         WmT4v0PWMmuJu1Scvy02x0bcJ+VRUahSdfpgT2LQuGg86H9jEOSPjhsWFDPFpGajnaSY
         Nlkxk1oPAlXPdx8O1Kbc/yFTmLYNkjibyPYSb/FpsN9/Sy3Yj+9cKVz4acg+T+5UWa+f
         SXtA==
X-Gm-Message-State: APuU4Z8+biCuyod78eyhbVOA5vYNW/SEcWEUlW/OuT44Im7hufntos36
	NeeJuUwByVuF8TcvmZeb4h1RCCPlz0/LYJHRZVvediq3hm2IS+CUqlzVhaoaaKWxSchUCHpwpA2
	OLNNdNns=
X-Gm-Gg: AZFdTZe+dP5pONL4350iRlOEd1xx1fevt5eINpjj/n/n2TXfB1sVVz9cZ7rn7kpAup5
	qmSxhQmeOHOzUQEoDzJic+nb4f8cbBRghEgW1vt0cwrKlBYkA8D2KWL5onDG6V0yBm6o8QLGrqd
	ufo3/fH+aexFqXz7Xvrbo4Z9eIWqw7VI7B05ccrUc93zB4uhQgVFuLhOgVWa5Lkn6+AEM8Ny/cN
	IuG859mgFKLCliJ6lkkr/nTCnum9jP6828pk+wHn1djXeAJBqG891j+GWmPg36QYCmRG1Lf4kaY
	R7IHPjYw/EzIu3yRn4j+XYZBCUVb4RfV/vjtJljNq2J188D/UYku0GGqntEuTkJpsj4EtGohW/x
	duBBkEulhwk5GLH5Sbj80e45uaqPZxp+h367aUJRATq9a2MELSD+8eNAGD5VpAMFbTjf0FT+oNC
	9yFeeKs/wQhCGuy96O7G6fsCZG77iV7bpHLMu+wHezKhZ3vfTarD+6Pct2OZOOZXpeXkJ+XiVRH
	uE/ifC4xSdkWbJMM4KIRXucU3kmUSht/Kn0xySSARSYc10+O1pD9iTH+oz/XFpZvoIh0WkVq8A8
	HtzJkdHAGRr6UqJAMgbm4XgbvqlVjX/z/zMIZFw4xiOO8bY/mQkC6wMBtvxcmMdRaSHn+i68KVs
	fPGHdF+EQt8GJkgKVOSbMGup1ryVpvYLFH5aS
X-Received: by 2002:a05:6870:608a:20b0:4bc:b598:a664 with SMTP id 586e51a60fabf-4bcb5a7e915mr4352107fac.1.1795296607999;
        Sat, 21 Nov 2026 13:30:07 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm6110825fac.5.2026.11.21.13.30.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/4] io_uring fixes for 6.1-stable
Date: Sat, 21 Nov 2026 21:30:02 +0000
Message-ID: <20261121213006.1787626-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are io_uring fixes for 6.1-stable. All 4 patches are in Linus's
tree. Patches 2-4 came with the io_uring-7.4 pull, merged as commit
78d9aedf2342 (tag io_uring-7.4-20261119); the others were merged
earlier.

They apply on top of v6.1.192 plus queue-6.1 at stable-queue commit
3dd4b2d3c1f7, and also to v6.1.192 alone.

Patches 1-4 needed changes for 6.1; the [axboe: ...] note at the end of
each says what was changed and why. The rest are clean backports.

Patch 1/4 (io_uring: enable toggle of iowait usage when waiting on CQEs)
is a feature, not a fix. It is in stable because the QEMU developers
asked for it: QEMU uses IORING_ENTER_NO_IOWAIT and wants it supported on
all current stable kernels. Nothing changes unless the flag is set.

Testing: ran the liburing-2.15-75-ga10946dc test suite in KVM guests
(PROVE_LOCKING on) on the baseline v6.1.192 kernel and on the patched
kernel, which is v6.1.192 plus these patches and the other io_uring
commits already queued. The patched kernel failed the same tests as the
baseline, except connect-backlog, which failed only on the baseline (a
flaky test). The failures that remain are on both kernels (napi-test
timeout, send-zerocopy, timestamp and similar). No new dmesg splat
(WARNING, BUG, lockdep, KASAN, Oops). io_uring/ builds without warnings
on the release plus queue plus patches.

CVE assessment, by the io_uring maintainer:

Should not get a CVE:
  1/4 io_uring: enable toggle of iowait usage when waiting on CQEs
      Feature, not a fix. IORING_ENTER_NO_IOWAIT only skips setting
      in_iowait; nothing changes unless the flag is set.
  2/4 io_uring: fail soft links on negative IOU_COMPLETE results
      io_issue_sqe() now calls req_set_fail() for negative IOU_COMPLETE
      results, so IOSQE_IO_LINK dependents of a failed request are
      cancelled. This only changes link semantics of the caller's own
      requests.
  3/4 io_uring/rw: fail soft links on IOPOLL short or error IO
      The IOPOLL completion path now calls req_set_fail() when the
      result changed, so linked requests are cancelled after a short or
      failed read/write. Only the caller's own link chain is affected.
  4/4 io_uring/rsrc: keep the old file when a file update fails
      The old file was dropped from the registered slot before the new
      fd was checked, so a failed update left the slot empty and posted
      its tag CQE. Only the caller's own file table, no refcount or
      lifetime problem.

Cheng Yongkang (1):
  io_uring/rsrc: keep the old file when a file update fails

Jens Axboe (1):
  io_uring: enable toggle of iowait usage when waiting on CQEs

Yang Xiuwei (2):
  io_uring: fail soft links on negative IOU_COMPLETE results
  io_uring/rw: fail soft links on IOPOLL short or error IO

 include/uapi/linux/io_uring.h |  2 ++
 io_uring/io_uring.c           | 23 ++++++++++++++---------
 io_uring/rsrc.c               | 26 ++++++++++++++++----------
 io_uring/rw.c                 |  1 +
 4 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.55.0

