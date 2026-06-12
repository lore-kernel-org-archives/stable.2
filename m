Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035E370D4F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250460; cv=none; b=d7B/LMrVRuaxhVXstoMS87o21MUk/akT4MmMRN264S82wIiTVqulZDvncqWyI4RBXxEw3kWQh2merTZLiSvPdw+DF3kLUt7q1KT0nYUzDs1lD0D4P17VVFHTj9gmcbc0W+bjIXGEXl/sgyFUD/5VkpZU1Q5Ilg5TDMku017vgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250460; c=relaxed/simple;
	bh=eHmMfifAH+b/pWnLwnIAEeQbfu0AqydXxKUsBJd0qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EO8f9cFV1hkpvtK8dvsprfrLcomlLrsz0f39/izQdd/tE9HmPC1N+Q70ai7UqpFqRcKMm9biQl37rKb2TvjJLVEIt2D9/ctpuByZCO4DYNvgj9Wvu4b8QMe/TyQJS9xlN+2WPV5MmyP9Of2qpBJeZ2bKq0EJentx8VCVRaIrGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMuSIQPJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMuSIQPJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423610ec93so640025b3a.2
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250458; x=1781855258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=RMuSIQPJAfK1o3ep1fZHK6FXPoVi9kJL26sCNz32rS3chkAWxU2Pm5r/TGsIcqhiIY
         CVYkAL9QNVvZGqo/WbJQcsqV16AztBncgV2L/BPFkBkXbi8Rjg+5CL2vXqNFTy38O9gq
         RAYYxfopApSbGY5Ljjn6bKkfLHjQQCvDf/fIKtvrQR79szWInJiJzERVOWYRwTkhTdfZ
         grAlV1F4BUqyDqxwZxaX52mnR918Hu5Ji/VhFGOoAfSCMzDb50e6Dn40HTM3478ZiW+T
         a6rjbUDncnckNhSoLkYm2XQZwn/4K6twUsakmciT8dTFnFp/vXYfc1S6QoooNVVozupB
         yjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250458; x=1781855258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=Z9D8Ka+gQlm4fXtfVr7JQFsGv3R1/FLRRt5kGiWPJDcS50sNVqZ7fC6l4se9StYfrF
         hmtTJzjts4hYtIKu1hy9YN+gcMWhVjWbzlIUlqzqitwBZPFc8jAwQ/YIiNsxRcyww+xf
         xUEtKu91F1Lgnkbd7ovxLonRixqB/q9H/TW+LJXFqb2BUYPmFCgpSw2T3jwxvzJg0E+n
         Ek8fTtvUWq4pIyBa2I6UvfgJe6vaIOUOE8UIpn5puR2OcOQyIdlou+ipe/GBI41+yZN+
         LV52C0NgK6hzyxC17RFSGoV1l3nLOWWoYddDPpxx2477eyQx1wz6VHSkEKv1Y5Zj8krY
         2Grw==
X-Forwarded-Encrypted: i=1; AFNElJ/VjvNs3/VXiRRiroZH2DsYlNgCH7+nDA7DVXC/VJgoJMZm5SL82IqNSJYW9ubM2003hUVXuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdtv/6TZ88xlOtdfQFDOmG6Mp8gwgShrRiWLTDIa0IHZrQsiI
	lcHBeOvc6GXOVWrv6xgq+GZTCVcUcjuIby/yVocA5HG7JO38+YqQ4dAf
X-Gm-Gg: Acq92OENZfVPwuGel4PpXpt+HMcBj8AzY5g6l4GQYRjDMw8B4ACFGAo4FkvNUrGUtGA
	MROEm4rKUEEQVYE9Qchfg5I2iaMuPnw30h8IV2eowRNLOZirVMpa8/ljsEzR3NH3HZDfbG2lXYl
	DbyMtPDGdDgBNDgd8NXvS7/vbk8JoggHCcgWCjHU6GHn7WcdHXSV2GBHXXTthiP+qBpbqi7xek1
	Y7UstnycnOmMsOvG0/3gTuUwA2iD9ayb2f0e7f1hKt8HsbdOd75pc/8CUcU7cLosCGyIUv3Mbje
	8ogEHsYUjt6y7resWGFF4QHBaezpYCJFYDAkAgcdEgdg+IQFiC/PkjwxSlhw0jumCw3ikuxNvtU
	N1ZPS2qpRErsIIpQbmsBakFmnwzbfV3CO0FttO5m33dloaMn4sbPDxAG8M6AkfIMJ1kuAA3YXS0
	7AB5nOiYGObsMMX08MIs8qEWInBg4VN4Jrtt4ebwcy4ZV3Dc5fayDlKQA=
X-Received: by 2002:a05:6a00:84e:b0:841:d7f6:7297 with SMTP id d2e1a72fcca58-8434ce6b927mr1957626b3a.40.1781250458164;
        Fri, 12 Jun 2026 00:47:38 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd50e6sm1337683b3a.30.2026.06.12.00.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 00:47:37 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com,
	trini@konsulko.com,
	fberder@outlook.fr,
	Piyush Paliwal <piyushthepal@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: cdp: reject CDP TLVs with a length below the 4-byte header
Date: Fri, 12 Jun 2026 13:17:30 +0530
Message-ID: <20260612074730.82719-1-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdp_receive() reads a 16-bit TLV length (tlen) from the packet and only
checks that it does not exceed the remaining buffer (tlen > len). It then
unconditionally does "tlen -= 4" to skip the TLV header. As tlen is a
u16, a crafted TLV with a length of 0..3 underflows tlen to ~65532-65535.

For a CDP_APPLIANCE_VLAN_TLV the underflowed length then drives the inner
"while (tlen > 0)" loop, which walks ~64KB past the receive buffer reading
*ss each step -> out-of-bounds read (crash / info-influence). A length of
0 additionally fails to advance pkt/len, hanging the parse loop.

Reject any TLV whose declared length is smaller than its own 4-byte
header. This is the same class of bug as the recent bootp/dhcpv6/sntp/nfs
fixes (unchecked length field), in a sibling LAN parser that was missed.

Verified with a standalone AddressSanitizer harness using the verbatim
cdp_receive()/cdp_compute_csum() routines: a 16-byte CDP frame with an
appliance-VLAN TLV of length 3 triggers a heap-buffer-overflow READ that
the check eliminates.

Fixes: f575ae1f7d39 ("net: Move CDP out of net.c")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 net/cdp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/cdp.c b/net/cdp.c
index 6e404981d4a..300b3d5c409 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -276,7 +276,13 @@ void cdp_receive(const uchar *pkt, unsigned len)
 		ss = (const ushort *)pkt;
 		type = ntohs(ss[0]);
 		tlen = ntohs(ss[1]);
-		if (tlen > len)
+		/*
+		 * tlen includes the 4-byte TLV header, so it must be at
+		 * least 4.  Without this check a crafted tlen < 4 makes the
+		 * "tlen -= 4" below underflow (tlen is a ushort), and a tlen
+		 * of 0 also fails to advance pkt/len, hanging the loop.
+		 */
+		if (tlen < 4 || tlen > len)
 			goto pkt_short;
 
 		pkt += tlen;
-- 
2.41.0

