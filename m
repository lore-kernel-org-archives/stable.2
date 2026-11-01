Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515085;
	b=pIvOyZinZAUh67uMsCnwUsNvkgSre8rLyZtNCSTJqtWOzPWJZvayV4LVNUovmcu2fFhe
	 /0LspQna6eMNZyv1logz+P0BeuJl95/X0DEv/rSrKqToVMa1vI7S9H4K3/6qcxHWitEX1
	 Ts8LEXy1hzIxko/niRCwZZODhHY9uk5GGVRh0BVHIeFD9oWtQby38MHQNq4A4duaCEacy
	 foTjx48DMk8ZAYxkIfBvdjhFtL5y3mGA3Mn4Bee8LMQ0Myoa6gjgTAJsA0IfoRVcAk3ey
	 pAF4eQhixfrXwn0KivM8WKj7f/9kW25WzhFmnlAcrvQQT1WEzUqxHY3sCshsP1NO23w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e+pqb9ytLIFYoIlSdazW6GvKKk9NtjSLduFPWkr+QGQ=;
	b=TAq3MkVy4I0jufkePZ6hby0tAYvopSgoGasABoYRPtArp4aegm1FliIzBbZC4d2rVLwx
	 mqlt5fRnsJ62dvg20BN7YmG69oeByq+FI1/XU23ASzNMfUrfR2SPlm2akUp20+r8amvtN
	 ZcNFaniQ+emG5ZhNBpAw/GVf7x6PaF+q3SpO9AM0ZiNwrafu4MZ/yrP1t5Vm/hBDWM6YB
	 ANK/UzuR6HLWJxZ2BPgZXCEGEoqzxb/R0MtaO0Ky9fpiLnQxRxidraT+KOMoiCfKw8OEL
	 QgG8lQ+1tEmOw8gsh2u0NPXfNJGqgZnXsrYna0c2SjhIDSs6HfvSSY3WGPBqRjN7aGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wn7Myod5;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E000606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E000606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wn7Myod5
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1648211a91.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515084; x=1794119884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e+pqb9ytLIFYoIlSdazW6GvKKk9NtjSLduFPWkr+QGQ=;
        b=Wn7Myod5gDe4z5Vw03yTXiszN/cbKBQeNsztxuV7XgI24iJJI365keCvyL7aHrQm4P
         ZbIkF7kEnRgrb/ZoJlDmokWgsKHIHfm+oJ+xQrg5E1SPLtuaRWD9r6b2C2rb2h+h8Tfv
         NuLaJ5AksPGg4R9IGacllS3+KviLjfwg3ZEAbftKwzNoy/KJ2ULqusVNSNN08bE4Win+
         UkqYpLghC5gmaFwWPTlWwfGzxLkbscrhJlD0eOPKWtDJIcUEWVeK9/LATf6CflAG+1U7
         m3zhacMshTyaS4MqVPb8o/DTYN02YY9jQ6IK3ulwUsun7NU+c2W2udupQgT5q2fobIlJ
         y6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515084; x=1794119884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+pqb9ytLIFYoIlSdazW6GvKKk9NtjSLduFPWkr+QGQ=;
        b=LVp4cHL4OM+0o1S0M72ODxGGIZzeNPKcgF0EYMDik39Q9yPdcTeSI7EyXVGQd+JxLn
         MJ3p7aPdGkXLgOWORZ3BJUDJC6r+wiulk4fE1t3K690MJKgyc7sdc3tSLGzgoRu60T12
         1VWDk9BEhRJ8C4fslDZ02MxQt+KM4fQ/AMJfh9GTCMIdsN2OcZycgCOe3pix8pb/QTu1
         4fZokO6HDMWIr+zULKHIrVJAdAvcY08Bg9pQMrQrwkt5OpyBp8sp/TkEyFiVXHFqKfaz
         1eYev7hZstcQ4m9BGAAQ04jwstsSgEuhr2xzEGutKkv0Pv1adMGrx1lJCMkbVznuNmI+
         O6Ow==
X-Forwarded-Encrypted: i=1; AKwUvByw2ifRWElH83wtlEthFTfraYdAXVP6cNVhgM+Ngnva/R833SjcYx4/faK4fdEhXW0YPnnOqZs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mvRxYHEhhGqzmiE/AJHZj/FTcPd7hNb+n78mAyWgymhuTut24
	4iE3+l7ZqZH7dN94scTbtEZtQZA22qiUJcA3oPWdPtj622O6F74bCvvxLmJDsXEDWBzQFsZr
X-Gm-Gg: AYBFou1jhlBJbWx0WgjW/Uy0b94iBQdsLfrwYGAekJigGfatJ5/9ghdD3TSlodQWmb4
	tUZmG0qsd/JOlZ+gIN4fB+HXzDGM7PgNQSSWyeNq5FdX0HWZmslmqZ60i0hStQtQZKnJalNbQwu
	QUNCHRWNAPGpI7NIisiZAfiuZ2TU5Me1xv5NQ/WyK5dlWx+PF6m4STbTXO4Fbc+1C01uETCfBUO
	JTXnwJ2W7JGrq8fH660iTISLjNOFG1P4WxZVCvalkHPhmurPeispo1B9paQKo2ddoXluWCF5n3o
	GexFNFnB3apKWxXYSDEJjfCs9UO8+grDile5B1A+L/SC7XyCwac4gSfd52y5apQydiYWTnuRsog
	Wsl7SpBYtDl0NYYXli7dhnAox2w3EQoTLHCd5zpDjqcO6WA4l7oQ5YaR9GIxRsAbnkJoaI63knj
	3JXVgfFhEvnr5C7+QA8PpvzE6oKJk1i1RxWHuyZsRdphVAaqHhVOKWtd2+uX5FcPzZ97wzFH1LT
	KITRjTy560l5T/ZfhaCrc1qDH1hKxgA2J7iUcWxiR186ucq9zUxkTZA+0JK/5FHHgrxfwf2gDAh
	R5nAl5P6jlOTd9w5vXOiVY/kwiCoc1uNwrHd7hU8VjrkxsM=
X-Received: by 2002:a17:90b:2d8b:b0:3a7:ab31:2f4f with SMTP id 98e67ed59e1d1-3ae89749f9emr5379084a91.28.1793515084445;
        Sat, 31 Oct 2026 23:38:04 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm14036712a91.9.2026.10.31.23.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:38:03 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 0/2] scsi: be2iscsi: validate vendor command buffers
Date: Sun,  1 Nov 2026 14:37:52 +0800
Message-ID: <20261101063754.89598-1-0xbeac@gmail.com>
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

These patches validate the vendor request and DMA payload before they
are accessed, then bound the WRITE_FLASH copy by the remaining buffer
space. The first patch also keeps the allocation size valid for the
caller's error cleanup. The second preserves the existing u16 offset
interpretation and scatterlist copy limit.

The series is based on mainline cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a.
Both the first patch and the complete series were object-built on
x86_64 with gcc 13.3 and W=1. An ASan/UBSan userspace harness extracting
the actual function detects out-of-bounds accesses in the original
code and passes 2593 boundary cases after both patches.

There is no kernel/BSG reproducer or HBA/firmware test here. The BSG
entry point requires CAP_SYS_RAWIO; no unprivileged exploit is claimed.
The local harness can be shared privately on request. Feedback and
hardware testing are welcome, especially on valid vendor commands.

The analysis, patches and validation were assisted by OpenAI Codex.

BeaCox (2):
  scsi: be2iscsi: validate vendor request and payload lengths
  scsi: be2iscsi: bound the WRITE_FLASH copy to the DMA buffer

 drivers/scsi/be2iscsi/be_mgmt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)


base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

