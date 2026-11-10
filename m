Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315015;
	b=S0gbVmlsoxuhtpk4lnprB/HoHDSuu7OrBjNoVd1hK+6024uDXvWonlVMyYb8p66uP4Dr
	 XcxAEYsjHgvJDkY+OtK6e6SzP+lKKEGEf7fqDGgM4jedtGq+PY5sz9+xDP5QFBr6KrH7p
	 wb2xoRDsHoMi8RfH4i4mcW+PyvJKoXwNy4D4jXb6eQfdN7J/E1H25rWQ6XYXJmLLLDcpX
	 pN+yDU1YhxzhuiqHYr0nPU6e3pheCTmi7JPxXNn2MO9g5rCIaiakuve1/L6yZmVS+ykob
	 iRI44y8kjJKZbWHPs3STkJtZQbWEvI1uugqnaD3hl8owx6aXLTgmSsEAFBXNkYV/jHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2+X51G9ewXmU9QYzYDv2H+VC+EelW5F82dLqqoHsS6I=;
	b=QoxhVhgJvS3GX+SsEpM+ez9HP39+24pk51vA2h1t8C0lBbi7+BRyRM50hIqR2vIkDEHN
	 1PvfFTNNe7t2wdDZNyFf9qhTp9JKnkSPKwfGUIV1nW6aZy4qyAhZ3tE9vE1hlS2m2zaJB
	 gQ+WzOI0kGZDUI7K8KZexQY1sjVi6n7hZpReAYDMipWt9I4drSIoxIol9YankEltMqidT
	 F5/giktyomhhxErteAU1N34WT5uO3iSqVnX7ZnrxcQfIh9gvT9HwnHHKexaALN8sWYQc5
	 B/5TwuyGP+KbmgW1e3lWXK/6T3uWi2xLXlCiJweQoOH4ei9K+BdT32XXadwO6rYlD8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tMx4qIBi;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821F606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E821F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tMx4qIBi
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so1563902c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794315013; x=1794919813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+X51G9ewXmU9QYzYDv2H+VC+EelW5F82dLqqoHsS6I=;
        b=tMx4qIBiX/Uugv0/DNFM26eD9UrYSRPguP76KC696Zof9hAN17qIBq6iuqCZbjYNwH
         ySMO9ZaQiEC6IURNxgTczWqU0cu6JTqaGZmlerI3ly0pP7GrHTAZ5+4jlr8jpxw7tNah
         H8eaS1s3x3DrsGD9+RpVpLiES2aZRh/QjBhD8rONImwSl+BHLDXlNYigbFyqD19J9SLY
         4E23uUT3ylf/zq29tbmIWFCB//tDnBhM5xlb/qSlk2UAuNGyAnnnRfjQKT1lr2FUv7Uw
         hDCCGDUInXgbfXTv7jA4f7J4Jbqkffhz/9afxBhRHWsqrkp+0Gn+YbpW4Mmr3eh3jh11
         JaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315013; x=1794919813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+X51G9ewXmU9QYzYDv2H+VC+EelW5F82dLqqoHsS6I=;
        b=HkBhiDZOlJFo2waA1C4KglA85wNKWRTZ4wdlhh0r2+Pv7a+ARZqS0iVE+aZRMVGxDk
         7hRxorfYuPN1RMzDlzOAUE0aTl7ksM+bl6a+tAQJ+GjQlPA106B7G1LoxPVhuDQ569vf
         VIVUUtq+/iAr2wALu7Fh5ITON+phIJu6140F1Xf+yHPXhTgXO6YBcx+evwx8mqGf8woZ
         IbwBEfyXdfUb9ZiP9Mr9hy6t4bz8wFNA8SybsYaq5R5sIQsJWzEZYWZcnMXK4Ye+qE+e
         6w0/W8oZ51yf7tJKDaSPcWFyjPAeDEhokkET20v+9x4qP3kAlM7IZtGggZnl+nn7C9kO
         q7vA==
X-Forwarded-Encrypted: i=1; AL+hErEk0wsTHXn1OTJ0FwpZT8YptrT+kQn/mrJedpX3p00VooiODzn8UYYL5oK9MZEVJLTh6M+gmy0=@vger.kernel.org
X-Gm-Message-State: APuU4Z88i2HOJsgbuwzMCsq4vXXtRVV0+DCxNx8638w+l6liS2QzW5bY
	fNnYUWwahtTCr5aHVN+ZGkldENE8LQj6q/DTQyzl33C+75HPmRg0YF7XP3modQEK/Qs=
X-Gm-Gg: AYBFou0YMzj+OAjgMKfufcbsMJSj3z5TEnnNesdx41JHTC0yfxRDBDenFAIQQwCbldM
	x8wZGgq7uwbYYs0U25vMr7qAm0GZvfrIST31I6taGnrWR60x90mL+evTprm2aM7di3ibhmWPMCO
	9Gddv4bgfg9f5V9AsfU+/z9sBv8WAGDoUfm4tAWc0+ifFuGpEa6mObpv0HDhvE2FzqkCEHAQouh
	cu9E1EhiyT54p5nDa5ChUbMKF1Uk7S/Sf98MsilygWlICKHLI6SwbAIYrsPRIJHdeuI8CCXlYPT
	MXcsBjtCbG78XbkTZDCd57kAfV0+zgBvQ2sWBoL9yVnlOffEh8mZMFhtkimN3FjnrQBD+CFJbxa
	8Ahys4WxSDgjcc3I+mlq2f3SD5K9xmIb36gmVLK+LLTYUpCkTIOSnXZaRLNn+KIBaKyfh8zVk+T
	ldBm8SlMuKdOXU5bJYw74j/MLwIl6fYX/FyZdLOB8EcknzwMFEPaC2G15GVPKlaZDWHs2DsMdP9
	o7OjMGUJwN4/EWmjIGSM4sln/rDbex2GMKhxp+9IGp85fVpyUY3eZRRXWo2j6nVI6v0gNRkffo0
	uBU+OO6SHff9luvk0Psghjo4uC9bsc+fqfkylGDBmad05qX+RndQB552vyM/WUqvspRZchKuX9p
	ZNWsxsBN0CYexnltaUMO2ziyxQPnQkZyjQDncsw==
X-Received: by 2002:a05:7022:3c18:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b3b617f6b5mr3186213c88.29.1794315012523;
        Tue, 10 Nov 2026 04:50:12 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:88e2:4271:a9b8:cc50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b79649sm7614830c88.21.2026.11.10.04.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:50:11 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] xen/pvcalls: fix the backend error path and a workqueue leak
Date: Tue, 10 Nov 2026 21:50:00 +0900
Message-ID: <20261110125002.46683-1-yhlee@isslab.korea.ac.kr>
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

v2: 2/2 destroys the workqueue right after flush_work() (Stefano).
    Picked up Reviewed-by.
v1: https://lore.kernel.org/all/20261109122324.30134-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (2):
  xen/pvcalls: unwind pvcalls_new_active_socket() step by step
  xen/pvcalls: destroy the per-socket workqueue on release

 drivers/xen/pvcalls-back.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)


base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.43.0

