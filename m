Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F481D54FA
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754828; cv=none; b=tiF4NRhyrNxpJQeHUYZIw2BeCUU4+y/xcK7aXdr3Oob8lC1fFy0MbjZL/LpQMG0h4bHfUXC7WQC6yRTrBqqkk4VlV/psec9b5o3dmumitUHkBPvGnCUGduX4q/ibt0PwwGonc21UGe4VFKEcUTFDUJbnaKIxCpior/oPT/KYMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754828; c=relaxed/simple;
	bh=6/vKUtPPzvuNE52W1vzgh44bVwcsydD2eMshQV62Re0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipJz4kLz3/5Xy+1bvq1c1SZlxc/1cepCuQ4ZbAQHeglU1YA6XFfZidkyjoX5Hn3vf8WSpa+Rv65u8Y8d21JJSLcxxZZfhPozAFn3Jt7aUrnlFobz1Obx5D5EOblkb8Zjp7VX1Z2xHBn5va06dmn5Yl7sYxhBuLwRTUNwq5han4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Mvneh4l/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Mvneh4l/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629051c9d1so912111f8f.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783754825; x=1784359625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1XGKV32BMtMot+0VfEXaCXl+nOm+R140hzMoZufQh0=;
        b=Mvneh4l/vQAqCfkG5LE3Bai326zvNRxaqYsoKy8z8BSA83+BcHn7nsjkg5Mzj2RYHr
         1+PNUhj7kqASiMZ/MiUdrAlwgioze+AUpBbs7fkXW6Oa5tSbs/KeE/AzI2SFEXj7ZAkv
         ivbL0zK0tA6VB84CRCKzpnqpeZTnDaOWS+pFa9WMBFn5qvKngjJCR/pyKjixkhNPv6bZ
         XQV2ZUBKRkUKMoG/VByekyUDWbe1aiWgmOZk5vECjEBzClsb113aP7DzT8OX0bvtpIUv
         0stpMkMuPfLlAzmc1JfXS74kcCZRL4WJqxDwCl7mhYXDoOj3KVmg88RkgWLGvw4XCJ3d
         DsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783754825; x=1784359625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1XGKV32BMtMot+0VfEXaCXl+nOm+R140hzMoZufQh0=;
        b=HYX0g+0BA1fH4mwmnv/htmxG994hHvZw0vIPAj7JN3HRMb8yf6+GCq0OK5XsNrRQJq
         THOB4UDtC5JOgLQMHBW1VYrRdmWesDHjXyvrJnghpGc6SeDAvITvyki4rkCHoR59vC69
         xjuqbTfKGHlmBtA/vslMW10/MA5KJrtr1RGP8mDYfroki3JysGQh6oehske0tucqc+X2
         7H7naxSqwoDAjHs3ZH2emhoAYUoaK1ubGhUhErP8Lkfe8MmmYQIeE5kGU4NpZOBMWsQO
         uydlY6Y/Ns5BmajRfMoFO6AKdKRVSMna7FHpbUEegyxRuVRiaFwNhH3A9JngDDFmXoH2
         1eUA==
X-Forwarded-Encrypted: i=1; AHgh+RqQ9pLkND+t6iLjyJBI+mM/D1+RBqX8mbReV/5puM97GxyISRM0JtsX15CTkFl4tDdJdvsY+bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweTah8elCsfN0NiuSFL77tGLV4GM1OIRTZOHoCp6I/Vq67EOux
	LPaEIYG/HimuDuYcazoB9SOd/4kEWmkFIfjs1Yp1uLOJPa9zkLRe74Z+ZGDqn/3vMR7T
X-Gm-Gg: AfdE7cm1bji9hHFYY5XDLz8bQodPTCo7OLKqy0/exf9GKy5jdX+s4BYBN5xOEepRu8O
	idlFGTVBBHmhPPE28QLHDInfuhXWu5lRZrfV0kPd0LfSvcaLtI4g4Uu+JFm5JsGg87+GzkHNU9I
	Yn1OJSFgj037wO0c1UDdZefKlxvbahOXaUl/VRpY9ies1g80xu2SMxNgvOOIY8VDTnaZeorbOVr
	gjxy8zfhMShabmO8fh/XBQVc+6ejvFvJ69h1BZ2t8VuPM4SsSalFHERDxZ6st1jaRrgH+eA7jqG
	g1hD+IG+rzzMTuIoB+xb01VTWzP/DCZr7DFSLjeBj0hqZgTRtok0UgEDEZQsmXAdcp6m9TAPkGs
	qoUpx0gOyvdkEbA5CpNFoW7R51+1VTiTa6dPodShA/AXgNdH33Kn+/ZdXbD7aKTNfx8Gl+gZthk
	uqS+IYDAQc/TG1x0KpMZl8C9GHcs3H3IUSAii7G7RKa0q0Rj5EWxnfwkFSdbsr2VIngNrCVFoow
	UwDJwYpqMnMZtzQ+8JRJBD+h9oed4LuMLU=
X-Received: by 2002:a05:6000:2004:b0:47a:c103:8a2e with SMTP id ffacd0b85a97d-47f2dce3062mr1867745f8f.45.1783754824681;
        Sat, 11 Jul 2026 00:27:04 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm66844821f8f.28.2026.07.11.00.27.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:27:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>
Cc: Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Sat, 11 Jul 2026 09:27:02 +0200
Message-ID: <20260711072702.70231-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_rx_skb() reads the two-byte LLCP header (DSAP/SSAP/PTYPE) and
dispatches by PDU type; several handlers then derive a TLV-array length as
skb->len - LLCP_HEADER_SIZE. Neither nfc_llcp_rx_skb() nor its callers
guarantee the frame is at least LLCP_HEADER_SIZE bytes, and a sub-header
PDU does reach it: digital_in_recv_dep_res() and digital_tg_recv_dep_req()
strip the DEP header with skb_pull() after only checking the DEP header
size, so a DEP I-PDU carrying a 0- or 1-byte LLCP payload is handed up as
a sub-2-byte skb.

For a CONNECT or CC PDU, nfc_llcp_recv_connect() and nfc_llcp_recv_cc()
then pass skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv().
For skb->len < 2 that subtraction underflows: truncated into the u16
tlv_array_len parameter it becomes ~0xFFFE, and for a CONNECT to the SDP
SAP, nfc_llcp_connect_sn() uses a size_t and underflows to SIZE_MAX. The
TLV parsers bound their walk relative to that length, so they read far
past the end of the skb.

The aggregated-frame path (nfc_llcp_recv_agf()) already drops sub-PDUs
shorter than the header. Apply the same guard once, in the dispatcher, so
every PDU type is covered.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing guard is evident from source. Compile-tested.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/llcp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..e3b3077e0e83 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
 	u8 dsap, ssap, ptype;
 
+	if (skb->len < LLCP_HEADER_SIZE)
+		return;
+
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
-- 
2.43.0

