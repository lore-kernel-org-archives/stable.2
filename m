Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793117283;
	b=Ijsi5DM1lfkajSapZNkg4rXPt6Wrc1xgEExQ0xJuIpuopSAq6xF8zi5WVL8QsEjM1KaH
	 dmTgvm1BZQkLyRVkeR0kBrm/aTlbimdSIU5L0H5ACPRmhHIEcLtWk2f8ltBEhgPm3qch9
	 fscIKy+NLNzqKFRqZeIQB05l9VIKC3lR2e2VhgUFOfRYfV1xHpJEYYzFwhMlcKK89gU0u
	 0Sn0fADIenklr1Uvkp5jo2Xu7Idh9kVJw//FtD0HPS0tffOwKH8AnJcO1kMZJcfXKUO/5
	 3PYP+sy7nIp8T0c6mINR3/BRtbGltCfF0F4GT8yOr98rfxSsr2qqDLBFqj6tZoW6u/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=ffMBajTL6Nz8q6evxLu9k4sljfzvWuKzldEDv2c+7M0=;
	b=RKMjpH+N8iF3lRWt33Lx/X7YfrCPUyrbsnka3FelDpVxdbsT70geqLINWoYtCU18TOI+
	 e4O7TqMeWstrzNVq8+8o3rjdIBgp02CIG3hLYQ/Ewc39mXm+M5nMRvhkx5cXhOSfRBJMl
	 CmJEXciqFP6ILZl+SqAfWJ6KbjiohsfbEzk/+8f/0hmKTPj/d4HQXGzs5/C2Tg0Q3K54a
	 npxePOfSao/nM7gzMS5YZj0jAbWbGMFWhFER+fRGT1UaWuyP9W0JuLk6AxD6gGbFE4gns
	 iVSSfvS2nRT5kiO91KoD7YkvHkWU4OTROMw0PGG2n4meYDjcR1/IgmKYBDAdZ1Pvskw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A18zgnQw;
	arc=fail smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538E606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4538E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A18zgnQw
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso24948a12.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793117282; cv=none;
        d=google.com; s=arc-20260327;
        b=GnI98JQzyPrEqtXqXeTWEDrebmgiU9avCrHFe2cnwi4AAHxegv3CAfWFD1B8VYvq6A
         qLsXo7Sv2chxIi27ebp1MAc2vVRcYAGVZlqMz+llf6P073L9WlfoXN4jDK9oHtMEd+sA
         TCdI8PdhKCZZ0YLdwN+Ox9panrPZZJszbTPMKbgGLUe0nUsyywIAVqeecS+GpVtJh5/5
         ymqVIJMKOYdAMOsfkw4BSD1nbXcMazb5ff/TCBgUuGDi8XwLO6hBUVlyzg1wkaY8AZ54
         7BEZNfdnkfqqPKiiV+0LvDUT1iD7xKyCkOuJ9deRqhccRoRJ8/ONhFjcrZc/pCI55G70
         ds/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ffMBajTL6Nz8q6evxLu9k4sljfzvWuKzldEDv2c+7M0=;
        fh=bNtTbOVQl9i3MUfkPQPTrTcyzrvJ9XyNsEAOtgD05eU=;
        b=kxeBRXsZbxhGztxhEnjRC+alBgnM3Yh5VlKc4NYO/b42+71nZ5cLT+pnBrLmQ38TEY
         cfzXDI3emSqk5gjDGQejvNyDRNG3es/si1Oh7r/KzPXVp10QXh+wQ33S3tyMr7Hy714o
         VhCuHtOFpjMGFOzPlCJsaoVY6Xh6lvnA4FA7meQKG8ayMxt1xt+J3Z6T6fz/oWJ9uz26
         ju1+2mL/G6nCffpJ2bQ6G9/UxDP0vEux1u4T5knHmQ9dTxE0QVF4DA2Uuc5zAT09dur3
         JFFN193VAcwYokbsrCMuiHmQUIk4dknOYL+MBEyXfuOyUx/Bi4cBEFs9vbWVFmR8w2pQ
         wsuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117282; x=1793722082; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ffMBajTL6Nz8q6evxLu9k4sljfzvWuKzldEDv2c+7M0=;
        b=A18zgnQwuwZSWVntRFknw0mMD++F9+U2h5FcxIhXsikfrofj8fyjTSXeFkL5wNyweM
         BL5ne5/cNi8QZMmEsNlGhYwpfSFLsabbFhAoupZvZKqhflVr7MwIqflEEVOpp2L5rHG8
         h8GNrnMQdOm21g3WzHwSOA4s45ynsDrHLLOMSuKBPWUD/viVy05Zpg3JJE/Fu06iBUnD
         29eodM/XcBK89NIxV8vXs6nsm6o/iTLExhe0iDWyyFYRFt7orDzm/n8tSrrv8B29jVDk
         ySLKmJtmFSYwbIOCy/mogYbptpm/hr2ejktgu778NWx0FGy8lojgfCGXktLP352Iav2e
         GpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117282; x=1793722082;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffMBajTL6Nz8q6evxLu9k4sljfzvWuKzldEDv2c+7M0=;
        b=fZRGfNAEEGUEUU8yPxcYBUgARnQWXS0WqRtb7FvOPr7OtdqsFv6rJEcdj/QhwVgRQG
         yx2gyMH4WeIwFxFaHo83SJ6PpJXN56UX+i0tF1gd9MzKL986llwjcwrA0KEZXYJKBSHM
         wYpAup9oj+kUWrXdkXg5d9yRRFzu5mR7SajzMTqfN/nTc2ptMtX8dwKUXhBYm47WUs8a
         yZQkN7u2CGw+EBsW32O3cIlElya5rH6nq2lzP72oLjnfxEWpqqVBTE1Yu1CcgFb2+ayr
         6mpZ94y2CvOuezsEK0dkLvvYbqKwRMu52t9+HWQSHyXLaar0AGq7FsQ+La7nZB0bHi+V
         IxAw==
X-Gm-Message-State: AFq9FYL8Cy6SiElqoV6IZMGXXvcjIlctRsa8BuQqBN5v4CCwHikUDkgH
	g5JhR0rsOlHnv2J9CJZB95W7+NPrO8gIoxcn4511wZ+DV/5hwUipAqBSVnkTS6pqJ/8KZeZQ3c1
	AppYiFvb3QqFEuzvC+1F/idXj+J53LZB38Hwc
X-Gm-Gg: AYBFou0vjhl+A00vx2koHes9qF2e5CQ0HZ0flzBxF9IAs7aw1agE2VZ/FKMPJUAqFve
	lcozfI0n6qxMNY6uZu85ucG74MdtD2seNKm9gwimh6J+Z4V+sjQFBqNbzxkRd0TeDUjS1/o9OEX
	JQIZTiv63G+1N19LzLiX4upcNqRZSYNDM/+Z/iLWSgTBuXK/I9UGB/nsRjyhlcpxD9YS8gvoGCl
	uIgv/0y+jyVrBmYf+2/6erdyluK0YgH6Z1yC+q74cQCEEEeMuOvsrMi3H0iJLPkwk7J2MtUu8hl
	ezpmFmhB7OU9oH81oK+x9aQy15jqGrAo4uJvvfCsAHbIOD4X/r0Yaam9Blg6CeHCY2QeFOS5rhf
	A2+qnIyzmPzc5LMNhA1yeU9nijSCp1nW1k3yBrl0CzmugtBy2WbQlHOgZXj8kpASFkDR4DTaz/s
	+UEcN1Nn0+F5JTcws6uFn8hGklJim1d7GdUiCgWoU=
X-Received: by 2002:a05:6402:a6c3:10b0:6b3:d0a0:39c9 with SMTP id
 4fb4d7f45d1cf-6b47bb19003mr1959908a12.6.1793117281425; Tue, 27 Oct 2026
 09:08:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?7J207ISx7ZiE?= <ihopenre@gmail.com>
Date: Tue, 27 Oct 2026 23:07:48 +0700
X-Gm-Features: AclHuK8vEWhEfLJm_6w4F6_smp7IV3SZemLFoGqvJivCEaGtkqcRTQMAWDLPr_c
Message-ID: <CANTrAmxiBn6GT+N5qivdf=xtGg6yFksK5qN_PhpoNdxXDSpikA@mail.gmail.com>
Subject: Backport request: ksmbd and smbdirect fixes merged in 7.4-rc
To: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

```
Hi,

Please consider the following fixes, all merged into mainline during
the 7.4 merge window, for the stable trees listed. None of them
carried a Cc: stable tag.

1) 4ca76b89917a ("smb: smbdirect: don't wait for
RDMA_CM_EVENT_DISCONNECTED in smbdirect_socket_destroy_sync()")
   328c7e307e84 ("smb: smbdirect: release failed pending sockets of a listener")
   5c171c90c446 ("smb: smbdirect: don't hand out already failed
sockets in smbdirect_socket_accept()")

   Trees: 7.3.y and 7.2.y (Fixes: dc691b91ad16, first released in 7.1).
   Please apply the three in this order; they were posted as one series.

   Without 328c7e307e84 an unauthenticated peer can permanently stop
   ksmbd from accepting SMB-Direct connections: every connection that
   fails before negotiation completes stays on the listener's pending
   list and counts against the backlog of 10, after which every new
   connection is rejected with -EBUSY until the listener is destroyed.
   I reported this and reproduced it on 7.3-rc2 with a small rdmacm
   client; about eleven connect-then-disconnect cycles are enough.

2) 68f410faedaf ("ksmbd: wait for negotiation before receiving another PDU")

   Trees: all supported stable trees that contain dc8289f91238
   (Fixes: dc8289f91238, "ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr").

   The receive thread can read and dispatch the next PDU while the
   negotiation worker is still running, so a pipelined SMB2 NEGOTIATE
   after an SMB1 negotiate replaces conn->ops under the worker and the
   worker reads past the shorter SMB1 request buffer. This is reachable
   before authentication and leaks adjacent heap bytes in the response.
   I reported this to Namjae and reviewed the fix.

3) ef85bad39cf2 ("ksmbd: reject FSCTL_SET_ZERO_DATA on a directory handle")

   Tree: 7.3.y (Fixes: 25e414db7033, first released in 7.3).

   An authenticated client can open a directory with FILE_WRITE_DATA
   and send FSCTL_SET_ZERO_DATA on it; ksmbd_vfs_zero_data() then calls
   kernel_write() on a directory file without FMODE_WRITE, which hits
   WARN_ON_ONCE in __kernel_write_iter() and panics a panic_on_warn
   kernel. I wrote this fix.

I cherry-picked all five commits in this order on top of v7.3 and v7.2.9
and they apply cleanly without changes.

Thanks,
Lee Seong Hyeon
```
