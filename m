Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227016;
	b=Elavn0UYgwzS3GwOvdD9e3q27oATvLAMwpFxLg3OAHvHjxqfoZrg1MLUcmjGirJ0/LSs
	 IRyCMajfmvXD4k2HJ+B0BIdSxMvPBZy51zgtkj5aUChIxpGVrUxZq6bckO3M7Dn8tOtFr
	 gwkuyQlFgVlljMW9p6sYLLbcPNYc/ViI+MbVGy56SdfSSMsZgiwd+OQNg4uo6Rl1FgVZr
	 MSzzuqboCcxyICyIzU3ksMjk6ZwEuTf1k7duhwqFOUkY+iKKON82BonPYnpuQ02PdnIHO
	 GrKKyEaYurG4GYtFFo4pvzYLJEc4emNw+5SOyErDmw9PhxKcL9F+S6AgddP+EDgEuBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I1mjq6MyeA/h9ILt+jeLEku3zY9kIcs3gn2aPes0dRk=;
	b=p60eALes4dlLKFf7y82x8BPXqd7EfGYm5ZITLGaC3p+MgAVc4QxsGP0nzDs4g/mWAof4
	 jtoyFyhA2Gyg5ueZ6XUB4pz6ruBKPu/jRAYdamk+r8m6k6JG2267hv8bybVw3MYNKFnVu
	 yheFJAoI2y8B7Q9+UNzHqYDxMjC6DAWYRGv9ncGc7liSNU86kWEAiqsgNSPujiSk5QM8F
	 ihgmenzvbWow/8IsfU6q8FEcoD0HIIP0nOjSwxc3Aa+PDWHqyxyz/248YHP2+HoSkS6at
	 fkzHJj5X2ZY4sNNOFGkENoxyMPPSeiVwG9CXtPKZj7P/QQ8JUn31Y4Q0NL424yH+qdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oE1OXjCD;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B932606EE87
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B932606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oE1OXjCD
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso412296a91.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794227015; x=1794831815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1mjq6MyeA/h9ILt+jeLEku3zY9kIcs3gn2aPes0dRk=;
        b=oE1OXjCD1DpIKNeiacZTe5qFOQPlRvEVUaYSMjxdseIcXEIoxVKsxJwoMNHPHl0eQm
         77xmvJGbjA48NOVhuHY9Kp4gV+X3ElYpVTkAP0viGlzHRrZWlK8+5dIrmEbsA+QXvOM1
         0JUcmBu6t4JGBmAKLc7ynYEb4I5UxTaU1WOkVCNoITIgEc20K5OZkzzAvDMb3UEaWeKL
         FtRXWXZmosgwdJZ/9Zg1bjmvqxIsZdU0pl3n1K1S7bfSxu6lb1twcZyVa2iScr0KAbnl
         ku13Zlz9fiGdnxgaKF043Hc7AoQDsX2iI5HaIMtKWIkuWcmmJQIZry6w65rL0dDJY3H0
         YYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227015; x=1794831815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1mjq6MyeA/h9ILt+jeLEku3zY9kIcs3gn2aPes0dRk=;
        b=yuRXuuAZmlWvcQI5khqI7HRA/AWU06g72mE0zi1YuSLOqEikaibGidg3mItA63+nNX
         FhWaMd6jtXNrVtezwelGKTYhP8IQuhbPzla9SNXUAXPpfXEfi0kdv/0lZJh9iiFoyj/1
         +C/2N9HBWfI1lp/Q6pqjv7mcauW8523AbpbI3nxCkv3/6xCAQwVyyQS9hvVS8We3x91V
         zM9ZGYozY+VLEEauFb3Dk14vTZK3JMCoR0DNFiZJwEo1M4bRYeAaRax4WljDYq5hHuJZ
         CGSKA9I3jBpw3JdrwR8P4/fP2zKVOYxQzU9S34pj/3IDb5hVU6kuK3Bf03IG6Ubc/7k4
         X7uQ==
X-Forwarded-Encrypted: i=1; AL+hErEpaLnlter302asY4ciE2AVJHJ/77cD/Zq26L0uTH+MLEzWRRFMc7e6lrS7cZXeHmv5qVeISq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iPG3OcYHuc/SWn6mvl+lFZ3Y9EWqZkMTYhFQV8jT3xOvJDHxX
	1SxDcEY4hpO99RZ+pv8eMRVa8NTIKzdQYb4SaBC8rvXvkkhoaQUzlG8KBc4nN68eVCs=
X-Gm-Gg: AYBFou3g0L2v//SCKzVpHMsTZfHJ1IzPc0bzkWgYjCUGFYevctg07j2aNrJeQPHzGVd
	+PAd4n7q7JrQn2cGiZ8epmr3n3omj5zbIZuQLbLKuEUdeIYvOWh9VFm1I+jjvjlrv4zE6mTRVYg
	p2COVJawHcT5I4Gkgec7lwkd32n5/svDS3vvucaaBF2LP8500s80RWGF+ArzMbWQfKcCIvbRIor
	UayXcfusmiEgbairklWAxJyA74l6T8/e+YZEZ57t5CpHnOAJ4xEaW8vY71CE8HCMKrVyWDlJ4iy
	S9JBMbh6y34am8H/e1RNeriQJRHxTMoOXGpC+J/Kso1jIBwFV+4iBIRs+/tPATyA6aPp8l03gYO
	fd2dOMqpYRW6iaAgRir7kheLaU9dpGj3EXO8st6XvShSrPk+RjccbaUC3GmB8U/ipvXfflnH89Q
	RW1+08YCOkw7CSEkh1TtthUE3dTUOWWJfnAqUkZKlPUjwmA1VMNYqCC8j8yDcONiYtN39zWwqFJ
	hblifI71iSSzaXnLuPDtjsp1xtMsi7F50mEvzrwubjEnHnuVAa8zKPfwYLY73PYwgE2zQl2ie+f
	kLyiihpp/bs9bYs5cFtGzfoWRmfo0Cm45HiRJ+cHZSeY0L2SjPgZp7lxl2Jk2fqfM3ImHF0whCI
	OOd1wGhvKXxpO/PITFP0yi8vetEwbB4hgfEhLlr76b9aUE18t1eUXp2byx0o=
X-Received: by 2002:a17:90b:3dcd:b0:3b0:b35e:b373 with SMTP id 98e67ed59e1d1-3b12d0e71famr3766813a91.4.1794227014043;
        Mon, 09 Nov 2026 04:23:34 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:3d70:1891:1a66:b169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127912d62sm6836905a91.11.2026.11.09.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:33 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] xen/pvcalls: fix the backend error path and a workqueue leak
Date: Mon,  9 Nov 2026 21:23:22 +0900
Message-ID: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

1/2: every error path in pvcalls_new_active_socket() runs list_del() on a
{NULL, NULL} list_head, holding socket_lock.  2/2: the per-socket workqueue
is never destroyed.  A frontend reaches 1/2 with one bad ring_order and 2/2
by connecting and releasing sockets in a loop.  Nested-Xen lab: 5 of 5
cells oops as shipped and 0 of 5 patched, a normal connect moves the same
bytes both ways on both arms, and backend/pvcalls/<domid>/0/state after
teardown reads 4 before and 6 after.  Reported to the Xen security team
first; PVCalls is not security supported, so posting here as suggested.

Yehyeong Lee (2):
  xen/pvcalls: unwind pvcalls_new_active_socket() step by step
  xen/pvcalls: destroy the per-socket workqueue on release

 drivers/xen/pvcalls-back.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

