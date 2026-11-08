Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794097383;
	b=PxQ2FCfsQ2/TSxDKuNS/tfKHLTa11+wr4JA5pe6RoZtEaQqf6Geaigmush38Lw9438DM
	 9YwWxM+yaTjgtUKfbBjuUMmRNfHMWhF+tgmXmoHPORiWDlK5RM7VufGkGggAr0tbyWuFq
	 WvHMgroNRxVe23BXJ+qKRys7kQxPfogMhKFyM0ASpulY8JmQC99DdSTsUui2a4jH6JbVH
	 UfxjPG/c5S4xC/9ixKNpyJA+B4Xf/pncT2DTxrrLQSfX1yS0lDkbksRONlPdWIxswMxyS
	 OGPt1k4lOyAqkvbZIdNWGQukBEkg31+a6gQyVgsMXlVclQfB0XxCELSPwXvKBBjuxHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ea2CBL5o6b9BYNQenIRPos251w2nWx2DahDIHlSjd90=;
	b=cnnQYhsj4z3fhPcXcxsI6Mq2HxVwnPTDVSlQd+ZtNYhZUfg3iRTPomjATwC5PQvaetMJ
	 HAnbmqgSzkZyqAONdOylCh82CUVQGTz7sWew6fNEPjaJ8hlpAGzT0U8MKa5iRfj1GWdpT
	 5kJ7KEo1i3WO54yZ6jtxnkmDL14pusXchsFltwTD5fpYYeSOzXQox2iLXyFhnDgH0DTgV
	 63Q8VUepsKempQrU3PTyWZ61D/dKh8Xviln2B1PDSWp7WjaRJWmm99L2fT8jrVOO9uhYQ
	 10uVQsOk2lzakO6vnQzpLR8cerEAPy/3EZAI2NK2NO8WXP7abG9ennSknEwndskMQjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PL+vS0Ld;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1A606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B1A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PL+vS0Ld
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so74678a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 16:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794097381; cv=none;
        d=google.com; s=arc-20260327;
        b=FJRAidtiHKNgLELPxlu0mEY5vtRMxfL9JrdWknp7FnQIRH8bVMFCIZC8X7dJ7nuxb7
         rJex5Q0OtLBFp/fvXPQKPgnRIppTyJ4nJBGQKPn9nj69XVPKkfKMRKjRUtC11jNkHk+W
         9Sg30wNY+/QG91Io4BzBbqz73sAKUFlwlG+2uMZJzbrWh5ObMgDzqOvVO/o1hF34+rWu
         39FFXDJUUX+O/LhdbgVKgGqTPissBIXJz4fxqS+NN2BuxB7GACMVUG0onRsyXhnYMtiw
         rMFuLN0YKOSuGlV/AFvB8PHSBzYO7AOdxc2OQjgsE0J2QjLh+88bhpyWRq9OMPbZN3r3
         mPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ea2CBL5o6b9BYNQenIRPos251w2nWx2DahDIHlSjd90=;
        fh=YknLOQB75vlLPIEwI+MrJevfo/l/mBt3ZJgZTppUyOs=;
        b=cFzAbdAUEuyitqYrIHaOVwGYmGbAAylhfQVAwejvetYe25vQ7jgPng7OXUxK6hkKYU
         7MozuRrdtOu+x5V53DFTCiRaovQj6SGxFtRc09XFtQzD0WpPXEbze7eOTGjqmHvSfqjm
         4s+7yUU6JtsAlVyIyUCgVsFULwuXKOS1GrY69Nm1Ejp4besDzQq+tKrV3/xnyN7i5/+P
         3p/kQW5u7nAKhMW+mHk3DubD8HlIAPU2nmvBYZQF9wY8L9SaQ6smaRGntZ65SqdTBsYl
         B3pMRGAjlEcw0inqmtJ0OGhjsa/mjSg1b2tPDEcXyG8dCe35GKZlldP4rfmRMDZvdQfO
         3ZjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794097381; x=1794702181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea2CBL5o6b9BYNQenIRPos251w2nWx2DahDIHlSjd90=;
        b=PL+vS0Ld8Xaz3qYr/Mc5w6ZDElASyUyRzK6aw84yN3tmK4Gntx4TN57sxwIJVoYpOW
         B9U+2eDO3/B3GqWflngV7Wexh30Q8WicKPPBeU/e91v+klaB7spN/DomlHYP7lL3ncbL
         0EcyeMkllJ60q7qldLayaCcBfCLjpxeQ2PUzdeEw9U0yeOsz5Z3DHjuPhNSavf2MBfL1
         M4n3sdhaBB+Nid6P5TtQHAtf0pyoX13Z1AYdtFqQvkMHUAD0TcE2rqxo/IxqZyQemTcz
         p3SmYWhQ6aAVlpUwzaegkTSb+c3d7LYxq3/4HqUgOm9/ihOK+I6BjL/EzmEAr1Us9LJ0
         Cwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794097381; x=1794702181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ea2CBL5o6b9BYNQenIRPos251w2nWx2DahDIHlSjd90=;
        b=ZQpsbU1x6f7v5JXNA9HEs5UT4zltQTug1nM/edLTC3PItA6GQrfP90zvHPu5Of+vaY
         OtLprcMCoMJnjizXwrd1oqd+yMe6y9OE9KiVbNkBjxT85kWT3FekopNHK5NbeGvsvPwC
         GMwJ8KY8g7tin1+lAa1ZOMDG27sz3SLiPdW+f0DcLTCQ9lqe1rP+u4SzDFM71a3NRpMG
         4ennq+8LsYNZ9cA5LY61mtODw+xeZgdYAVszkMwNbdZXS/0ATAd80W4WMjUBwuCNPYTz
         MVFIr0xGC3vkyxdj/meJ/0J5vGEd48yDy+C4p65TDRsFyRWOXHdm+rCAFQYnzU67iUqG
         kw1Q==
X-Gm-Message-State: APuU4Z+Mtqep9qYNCxw6u64YbAEF16siEAqG+tFtq2xL/Oxpl3qDpuVK
	ODPC114dgQGb4Zlp0XCpAiT08Kz+srlmj5RUI/XnQbyIsmfZxE4ZT5BpG/EPC4SU11fGLOfyUXP
	zOzEW+mPSazMwivgNxHM2LWgxUuuIehpDTucqfjZpJQ==
X-Gm-Gg: AYBFou3hSBtzfDa4QFyiZXHOsgRm88DmdBfqHgzY7pYtH0PT3NE8l7bw4txi1aPEtbM
	grsAVQa4sk3XxlZWfu5SfLMkBmtPyBtp81KvFockwq+TAZBnok6jPJHBSfbGODVeXS7Z5JZuvE7
	YW4P2hWH4bvadjtteH0E5YGYVeT6ddkdO5mrdPSEXxPGCs9CpI1a7Upl79z5xJC98b25tJawCev
	sPOo50624OxCbrNAguaBcZzGTFWCNg+DqS1Er6qiQ+d2cYOI+Ixlr2qNJhKem+cSaA3xNKofM5r
	YZQWOYUp7NMTLcgEd3uej4P6n/S/nEUaifSrR8akFTdiT/xf8c5gMxKFah+tamPBRoNEVaw7NT4
	7YwZ2jI6kh8waeQ96S4R7adht03ZF0V2jkApaAfgAHtV5m66J+7VjNF//AGcHbGlks1rNsX7m6i
	fFmKq1RfyXDSEeajCayxLVgrgwMFz05ctDPVBVVSRM
X-Received: by 2002:a05:6402:e8a:b0:6b4:87b8:1348 with SMTP id
 4fb4d7f45d1cf-6b722454d2bmr106410a12.27.1794097381188; Sat, 07 Nov 2026
 16:23:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammed omran <sanhokh30@gmail.com>
Date: Sun, 8 Nov 2026 03:22:49 +0300
X-Gm-Features: AclHuK_a2mPRAwpEks-bMX6Pt1cMaCXZ52tKFzWO371mbPLmoyYkH4f7LOgAPJA
Message-ID: <CAGwSD7Q7FEw6O6Bm1CwCYb3=5pRAzB_heC7HEVheZdjNbaEAjA@mail.gmail.com>
Subject: [PATCH request for v5.15.y] ksmbd EA alignment OOB write fix missing
 (CVE-2026-31705, CVSS 9.8)
To: stable@vger.kernel.org
Cc: linkinjeon@kernel.org, stfrench@microsoft.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

the ksmbd out-of-bounds write fix for smb2_get_ea() landed upstream in
April 2026 and was backported to six stable branches -- 6.1.175, 6.6.136,
6.12.84, 6.18.25, 7.0.2 and 7.1 -- but did not reach 5.15.y (5.15.225):

  ddbbc8b2a09d (6.1.175)   ksmbd: fix out-of-bounds write in
                           smb2_get_ea() EA alignment (CVE-2026-31705)
  ffbce350c6fd (6.6.136)
  98f3de6ef4ef (6.12.84)
  790304c02bf9 (6.18.25)
  922d48fe8c19 (7.0.2)
  30010c952077 (7.1)

Evidence:

- The CVE-2026-31705 affected table lists the issue as introduced into
  5.15 with commit f2283680a805 (backport of e2b76ab8, first present in
  5.15.145) and fixed on every later branch, but the 5.15 row has no
  fix commit bound (affected up to 5.16).

- linux-5.15.y's history for fs/ksmbd/smb2pdu.c (latest 30 commits
  through 2026-10-30, branch actively maintained) contains no EA
  alignment fix. Notably, the two commits the fix description itself
  cites as the same bug pattern -- "ksmbd: fix potencial OOB in
  get_file_all_info() for compound requests" (beef2634f81f family) --
  ARE present in that same 5.15.y history (2026-04-18); only the
  smb2_get_ea() member of this query-info OOB family was missed.

- The vulnerable shape is present verbatim in 5.15.225's
  fs/ksmbd/smb2pdu.c (smb2_get_ea(), around lines 4452-4493):
  after the value memcpy, only "if (buf_free_len < 0)" exists -- which
  allows buf_free_len =3D=3D 0, i.e. the value fills the remainder
  exactly -- and the 4-byte alignment memset() then fires
  unconditionally, writing 1-3 NUL bytes past the required
  buf_free_len boundary; buf_free_len is only decremented after the
  write. In compound requests the response buffer is shared across
  commands, so a preceding command can leave a tight remainder and
  the memset overwrites past the physical kvmalloc allocation into
  adjacent kernel heap memory. The fix itself adds a single bounds
  check ("if (buf_free_len < alignment_bytes)") before that memset,
  skipping the padding instead of writing when it will not fit -- a
  one-line change, trivial to backport.

- Severity per the CNA metrics: 9.8 CRITICAL
  (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H).

Could you please queue the fix for 5.15.y? The fs/ksmbd/ path form
applies to the 5.15 rename, same as the recent get_file_all_info()
backport on this branch.

Thanks,
[bnomran =E2=80=94 scofaild23]
