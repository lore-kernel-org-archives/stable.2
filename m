Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550270;
	b=vYge1d1LdUpAIrqGszS1HhzL8BkC20jJvEpj0s0St2HHC4NOEpoNEGInIupjOgdi4hKi
	 CYyFOUs9/AlLcMd7BcSKuABZ0L4S0AGiRSv8w6892DJHeOQ3vmvBqlP/Cqd89qJzaAfHP
	 r2NVTFRzoDSP7Ku8pmwkr6Z975aAMEhpZJMn8aWtcBFZ1rbNtD6V7uES7gwIdgk9Y7R8M
	 lt1s++ry0jGEAQk1kRDr5Arb8mkzcoyv3A6pGVa3638lYg7jkPWtDID6c7JXdnKIDAMTy
	 5GilqJKjc3Y4REKwIJPskIcwpdpUKLELsEaegsIQFVwwKniOFWPozxeydzxDXGKAemQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FpZc+8ubBDCMtZDWxsPNubFaGS3JiUnCD4SYOTvBTss=;
	b=SHJOCX+TJSmoq07+56ZxrATEmK3G5LGj6SIGKQ0DxwdmNtl9SUeddXhQR42sNdPgZpC6
	 UDVVSk4ST2+y3W4kWeznIGxGDozXEHvJ1xX2Ux9MWJrCijNYnp23/J1qmvtnBDga5sM/y
	 NasCLDTbCk4uKKaO8d9uwOV3xdhnN6moPvPHLgqiYVMmtcoOWC7IMVezRKJRStdiUnDNS
	 6qNL4GYTLioFtiKt+r1ryU4jBjUd7TNXKWMAm9LtT8dmdaOSIctLiLLC10w6Was0ki1i+
	 eDbJTM82WH8D/YI/xQJr89JmAJwmP1MZPZTTSL8RErlec25VqA5XyfiGhLfQLrjLp6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4WGkEtg;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C3606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4WGkEtg
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so457243c88.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792550268; x=1793155068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpZc+8ubBDCMtZDWxsPNubFaGS3JiUnCD4SYOTvBTss=;
        b=d4WGkEtgYjT9FPw0LenT848WVmz+lD49zl4yFoDt52v8dcjTxUqHJgFpBoCCF+cbSL
         1sVOgxl3LyhJmrLTz8mStV9YgsY1y4HVRuEyz6JdZO6sriJ7/YD2H4J4gHJ7/Syk76Q3
         IWZDGvIoagyBI5YBwadFMJWJG1H+MDupQYuV5F9gTmGf0mOfBqNicE0QUHRS2BwPi7Tl
         p5uKJJcOvXN49HhlkcXoOGpQNPUNNH5iwzBX+9WuSXSkOxIZ74HckdS8OmQ0PMQLWlKw
         kDYUk3xzE1tBZcjxQeOyzwIxaVNhPaBOJSothLf17jeVAntebHESTOuWvHA4vwt52mip
         tgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550268; x=1793155068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpZc+8ubBDCMtZDWxsPNubFaGS3JiUnCD4SYOTvBTss=;
        b=CQ0heB5ozbsadq0lWu4zuTr+OCw/XFg6/cR4GpHdUroq1EG/kUk09oAvW2EVIAbqS9
         VFuSCLTBCb7BVJTYPANBwk8lMpraONyy5s39EYj0IpHzBYkk37rfrQ0UAo38d107+TrB
         sxFfcz0IIZwNcZXUiBhUtOn7l4wMRPsntimVf6JuDVvP1zfznr2j0o55F0iua/vReeDJ
         /UQcdzlgmcbCp7Gkjd4M5UIEA0hOscZM45J0lFaASKt6+jqVeBOEyOUWf81iIqGQ4K8B
         gxcRivmGbnfM/6mI6EbRhap7aBw4PhdNPxtQoi8nPWgT4gS0pa8mtJcZrrIqZZiM4mzl
         yGfA==
X-Forwarded-Encrypted: i=1; AKwUvBygu8wkyTRjMNtgL3x1u/hLJhi48hP3rXod7BZxiejVJ/jzKdjzqNdYhdIEJEhoEvglPBy6Yz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkYAFmH48KYiTCk4RA/uYPAOCvC7jUqYgES8w06JYjdrX+N+sg
	jGub17rgMs4FTvcD4Ccij1rltcJTMuotQrLKOaxhXVB86SinfGNMHlMB
X-Gm-Gg: AYBFou1WoMLIU00eEzem0YwTGdgPe40gvpv/G2USaqUYx0EYmF0BSmg5R7Y8diVn/TP
	/QJL0lVOJ9J811mSN/QEJYn4oB1BU0uVH5LILfjsagwJgkPJ9DfvUErnbbZZD95euY8S8JoUG60
	MeBxtOJ3A1nS54blHrFPKWOlacePNYvpXK7whNmAMwOO87e7UjuhrLCBbX90mnswfrxXPwrhWCi
	MHGraKxKjnT3XZ9afuXsqrTsDZ0kzv9nNkggNUzkbUcP9YBlhZv1W1C0p8+dRof2dchExzFmprt
	xx6EYCuI+nUO0Q2wbyBrSffnhyQxS15V/3iFX2LIERJ5wk0clNzkSDERHPnVyXTf08EcbIevLDU
	s4wLH9HhAEc0XYh4xhZobzWA4Sitwk/x+oiq/KpvS9epozuzg2pmwBH1elz3ZiGIq64sXXF2pou
	ENKJ8lu3Lo8CIiOPUprZYFqEq+lhMeOvUnzgdyKtDIpWSLmAwATy8buElu10TO7uh8qTtkflTwZ
	lunrCH1ruGs800zZGJuvlXxeVI8aggLGzw/H82ad29xnc5RY9rQ7rJxaid0Bp4jDdXJ4uFjUTyM
	1JMDUek8RS8C4K+GPRwzusKCpCAyWqjLBKPb9ADZJBc=
X-Received: by 2002:a05:7022:6613:b0:151:d6e5:596b with SMTP id a92af1059eb24-190a4f064ddmr1285033c88.9.1792550268259;
        Tue, 20 Oct 2026 19:37:48 -0700 (PDT)
Received: from muumthf.localdomain ([123.215.20.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm3354183c88.12.2026.10.20.19.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:37:47 -0700 (PDT)
From: Hyunsol Mun <muumthf@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	bobtobabz@gmail.com
Subject: [PATCH] nfsd: truncate LISTXATTRS replies on error
Date: Wed, 21 Oct 2026 11:37:15 +0900
Message-ID: <20261021023715.315727-1-muumthf@gmail.com>
X-Mailer: git-send-email 2.53.0
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

nfsd4_encode_listxattrs() reserves 12 bytes for the reply cookie and
array count before it starts encoding attribute names. If the first user
attribute name does not fit in the client's maxcount, the encoder returns
NFS4ERR_TOOSMALL without initializing the reservation.

The generic COMPOUND encoder does not truncate replies for this error, so
the reserved bytes are transmitted after the operation status and can
disclose stale reply-buffer contents.

Save the XDR length on entry and restore it whenever the LISTXATTRS
encoder returns an error. This also discards partial output from other
errors after encoding has started.

Validation used nfsd-testing b4e06bef3884. On the unpatched x86_64
kernel, all 1,000 NFS4ERR_TOOSMALL replies contained the extra 12-byte
body. The leaked windows reconstructed another client's exact session ID
and enabled cached OPEN replay, stateid use, creation of a new session
for the victim client, and callback-state modification.

With this patch, two runs totaling 2,000 NFS4ERR_TOOSMALL replies
contained no extra body or leak window, so session reconstruction
failed. The victim's cached OPEN completed normally in both runs.

A patched-kernel smoke run also completed a successful LISTXATTRS
through an NFSv4.2 mount. NFSv4.2 and NFSv3 read/write/unmount tests
passed. All test kernels built with GCC 13.3 and CONFIG_WERROR, and no
kernel warning, Oops, or panic occurred. The reproducer and complete
logs are available privately on request.

The vulnerability research and validation were conducted by members of
the Tobabz team as part of the Best of the Best 15th program.

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunsol Mun <muumthf@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c4fd840da4d9..c7c2be555b59 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6438,6 +6438,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_listxattrs *listxattrs = &u->listxattrs;
 	struct xdr_stream *xdr = resp->xdr;
+	unsigned int starting_len = xdr->buf->len;
 	u32 cookie_offset, count_offset, eof;
 	u32 left, xdrleft, slen, count;
 	u32 xdrlen, offset;
@@ -6545,6 +6546,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 out:
 	if (listxattrs->lsxa_len)
 		kvfree(listxattrs->lsxa_buf);
+	if (status)
+		xdr_truncate_encode(xdr, starting_len);
 	return status;
 }
 

base-commit: b4e06bef38843c8b909d0b4317dfaaf87dba6d72
-- 
2.50.1 (Apple Git-155)

