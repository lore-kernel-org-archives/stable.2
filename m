Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776215;
	b=Sp5Tsncq0ZaBLIgyhmsqMZGDWN72wBie5ohbxOrYh/o3oRKNHm2hpR2MRfnLxo6OSo3W
	 2tFlxqmsTZ+nZrSG5fZPtZsWssg2ZQ/nl0TTAGe4F8P3JrdITcpcCs8X/0TcT7k55R32V
	 bhJf4yossL45ATtvCQsIL19Ohwcd6vGNYYyKnyVhIh6+Pg8iNZKcQlsYo123/ohSbRArP
	 1yiSpTJrLEiQAeH+NAjqfcoFbfd+TF/0CMCqnHoc+kRwCNo0VaKd0QDF5DZrX3g43IpXz
	 VdcQlb/M65VkfrZvvIzZfcU6tMu1etyWLIL7JwcdZSkWe9dHBbrKUtjBheRMfEnY9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
	b=AP30uuJrAM4VvxrdWeLMBQL4jFSbjjFqv+VZdl8dTqOCIZd8ZSshTNHqWk9yveavsHSC
	 TQRBNgpT56RMnUp0//cTlqpPJDuVukJxKjRRYOnXoizs7Z6CzmoyntXtn2CfvS0TtvN7e
	 6PlEBd7kKFZ8MW5AB0glVTv2wO0vl/lvhs7lTK0l7M/md3b4OFBZUUUPz7X/nwe0BfK5T
	 uQvgzWka/pCn44gLf+ukE/G0PnoatNRRUl5x9rQE3bvt/PuY0cmfk5TvPrdPpScHqi9NX
	 2sz7x1+JYomYTSrM1RldQ6nvN2hBzAnR8vKAvCqGzOF2RS5D0Aa7+M9iFZjTny3IJuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p3JF/d5q";
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F760606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F760606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3JF/d5q
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3566so164105a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793776214; x=1794381014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
        b=p3JF/d5qISNlqFT8OHEBgICb3Nz4rS+wiVeNnS+hQx/BN++8gSH5sfDjH4SDdBMkRB
         P72mhK4HcwoBvvTPGgp4OyotjrneiUBfr+wUwqbOKHlM7+8XXkC+Co2xwWP879/87T2G
         /gO1TwrduiV6PJwI0iTyJSBEvpa+3FSkOWicE668nQljYiTT4rzOmOvMwO0DxMg9GQu+
         FdhZXTa/U6ldQbVuBNJxuueELNJFDRtoVA8jYzKmo0J14558AaK26jhBJd5HT1CwAZDK
         sJeP3IMXZYmPhfrMURq7GME+pP3ANCz171B9Ls2eWpnkb9026KJFtEvVURdySo6YyAg/
         YwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776214; x=1794381014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
        b=Z3V2cQfg6dZj//xvwEALUN3SJsKZeZCoyn4JMnxYJqWTuZTLWXm5HtabIyjiqZ2dxm
         EliNNy8Hsy3GtatuVIA053JbSTsS9vHp0LiR/uG6IZzhwdh3tJw3b1woerbUPodEzwdT
         BQOtYu3LhqFdp2GPjE78U9IT0LKjHbibws3fahtDL9OB1c0kEyPf8zole09TThufpkOF
         V7IRtSWo5eJlV//VNzyqaPiNiAtvo79asWxS7aDxfeGghyQIawe+x1CEUIJh0weSGPrt
         Hj4NmO6nJ0bBXAEMFLDNf5MmDWFlhdJFy5z8fcNFKohzCUDeh6ULKnGXUO4WwMLOY7Jz
         FyKA==
X-Forwarded-Encrypted: i=1; AKwUvByZ+H/Gesujl1Wsyq2TFGGXd8JBeCyJ/HwDy/RKJSRb5/5K6pVu79+TkUvbcOq6NoD0tBep/w0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lVKD7LWmDkXi8Dx2pjvGw11bb9GdW90xz7W1sztqYXsZRIU/5
	KAQ2HhP6flgXMWoa3APR7wIMpevF/AKMZ3lzTYiyIF0v3V/ykIMOAoM6
X-Gm-Gg: AYBFou17WhLR8QSQrdFwtrFqwiHMA9EBzt0qEWXNfTUWe5tOtFJDnvD0qwuYAcT51Zx
	QB6nBRladIAX7iK3lVT3JQh68nrGQO/Yi2ECLezY7Wtnw5+lPyB6O6cLQv/hMkijoaRNe6iOqbg
	TyniPDEOOMpB8wt0t0+foZ/l5uiVMUb6ZGRYsA2NGMTQDV1545M2ZzbUCIHS+B7iEeIcdGVuJp5
	dCJMTSDIy5jpvquE0UnkF3reGZkc8jMRyzo3gvYHolV1l8l65zkwzp7bHjQm6tT7t7bS9gfzlTy
	+JLlEg71ZGAUYp3BDc2mVQ8RVRNEDmDegoPEiBdtZJzA90XRe86cRFsC+8Ls/4FZCw/jtcEQ7bK
	EXjLcIzGfwtAVg+drnZ1GbUl3E0mqJOM87lS2uaeNUcSpdkYEKl6t6Y+OanqSX+JnBuDhErGUgy
	kCEMNr5E53wgPb9N+41uesSIqa40O0T9QdzE2xMgevB+z5Es4ukETbz283OgVg1Rb1cy0kAgdNS
	R98674byDATNfum3hSMEf1ADL3XVIF1/VagDFTcGesaaJE586Vr99ApdwRSZWrBNi6POEOG9tJN
	3KEveRLGpcCMHIfvje8UhQ31COT5C8jI5C2qQ6fnwTd7pJkAkLgZiwWowHMlg1OM5n5mWbpMzQq
	MV7Mkhtsh781BbwOiMZ8v7XxGQ4dI4q0ewmnnNg==
X-Received: by 2002:a17:90b:2547:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3ae89536c0cmr12582654a91.6.1793776214401;
        Tue, 03 Nov 2026 23:10:14 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm2651997a91.1.2026.11.03.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:10:13 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: kas@kernel.org,
	dave.hansen@linux.intel.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] filemap: prefault writes starting beyond EOF
Date: Wed,  4 Nov 2026 07:10:02 +0000
Message-ID: <20261104071002.49693-1-dennylin0707@gmail.com>
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

Since prefaulting moved to the slow write path, a buffered write can reach
->write_begin() and ->write_end() before discovering that its source buffer
is unreadable. Several filesystems can extend i_size in these callbacks
even when no data was copied. For example, a one-byte pwrite() at offset
4096 into an empty file can fail with EFAULT but leave a 4096-byte file.

Prefault the source before ->write_begin() when the write position is
beyond EOF, and return EFAULT if no source bytes can be made readable.
Overwrites and appends continue to skip this prefault. Keep the existing
slow-path faulting for forward progress after a failed atomic copy.

This also leaves intentional zero-length ->write_end() calls used by
generic_cont_expand_simple() unchanged. As with the previous prefaulting
behavior, a concurrent userspace unmap can still race with the later copy.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---

 mm/filemap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6f318333427f223b9f42061a6213..30414d55412b84f11ebe98b8eea607ee8c04eef5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4389,6 +4389,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
+		/*
+		 * Some filesystems can extend i_size even when nothing was copied.
+		 * Prefault writes beyond EOF to catch unreadable source buffers.
+		 */
+		if (unlikely(pos > i_size_read(mapping->host)) &&
+		    fault_in_iov_iter_readable(i, bytes) == bytes) {
+			status = -EFAULT;
+			break;
+		}
+
 		status = a_ops->write_begin(iocb, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

