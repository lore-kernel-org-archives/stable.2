Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB530BF70
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958335; cv=none; b=UU9YVouBvI7ggF6RvIvTUjNxvbDl3jC39HSJ5j8iQOcFAzMUtmebH2vK0yjW4Os8PTZ6P+aoe+CSIzSiyvm+3K+8FkzLA6CsbKCAKRr/X6hwGMPuyHVLdxufcnJeNdgbv/ym6uh4Knj+wgcrT3xI12rYKeptoVmutGrD8ehUFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958335; c=relaxed/simple;
	bh=UPM0BjavTHeN7FjPEDHtX5K0N+psJJcGHmtOEuf1xbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r95YtE7ytS/6oOn2QyNxoU/LJwUJejG+NNRRtQtO4Uecyf30GE0svuP0ObuKvMa4jllCxm2hRsf31srTa7NndK3iA31YCvLbHqek74dfEPfz6aQpIV1brC1jMLEmrBaBk5rn6QlQSQEHsBg8yERHaw7Y8gLinkm3DDoUZB++AQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=rmkDAm5Y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="rmkDAm5Y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b7612475so26411225e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783958332; x=1784563132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fcync883JEMNF+UENDQLMgM7eZIOfrN4gu6gzZ2ECRE=;
        b=rmkDAm5YxRGQm91xPyY7/3FBlrX1m4+Lb3owsYVAuwA/VOxqrZmfcCvp/eO+ZmKABK
         6F8EJXIBgEHggDTEVuJ0RBpN/Sp/dOKnpMyyVV8suE2WLhJFvT3EijBTpa4BCF+vs3tg
         +iaJEBQGhbduzfHdnL751xkkLspMOwp50QOidwvl06XzWcG4IJ8FBap5PeEhfgxAXDUF
         v12KUujAG/Bj1wLvZL0Gb0PwBGRvf6F0bJkS6XdT65CSE/oSU7XaE9UHFhG09F3E5yZU
         BQIUGjCNuhuVOtBoNM4hpcGeiYTMN/7r91La4zP+leCyI7tPsOBGwpS7upJ/aVOxiJII
         QLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958332; x=1784563132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fcync883JEMNF+UENDQLMgM7eZIOfrN4gu6gzZ2ECRE=;
        b=FhMKwVyARzyi8kvFeLJpwWG/XmkriWZlX5wjI9fk5jQuNq60PZOkTetiO0mcf3UfW8
         LGfCDNuF4EFPDtCv4d5ZedGJNu4//TlCm309zptSoO0p/kqLxVfk5TSwhs5XfWPVHbYQ
         HqOF/+MYBuPRWy3vRa2qeSBvU/Z7QHplNoDZbuuv1kV7LUqTrbgWG4+wxCtAbpO8W2Cx
         AV8C5/AKyFzvLTr8bUFB4CXHTKNRb2+F4RjO0Kmpu1AI/bQzjyFSbSh9zOIfzENQAlZA
         CalQNTzmjUao9+ZRSeZBfssnPREkZJnMk/FGsC0qCaYlWMBDeMSFa5WaP2Ybd4YytZa1
         PNhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWmALGpvZLTiRekvgQRiRCYXNwUTof7EeYKiEXqh6/nDkrbYn3SSz1MWti9j9vyVs9s8zZ2Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrdnhsgeKdBjGW0HmtbrBz6y/to5lo5XqisKBSwUpvzj17I0ia
	9xM2/PKHhp/fwr9QlMquydhAI2Lxcw4psRG65fOgvsKWFapES7CQg3PSWJ9V7i0N+fSl
X-Gm-Gg: AfdE7cm/kWeO9l6UQwcN2a5VtB5thY31Q/KLIXgCe2Fi9Y/KUHBj6+7ymGZGNTIShXY
	CFS4CwJJCTDKRjX1e/HMb/jj806OsqxUB44HqvtGCqezbNy/wACWoqq970YjdmzpfqvGOuWiHCS
	/eujT5tUQleuoO1OotnCbs5s0hnuzh2jznoTztKKOpfDVhRiejE+9Gu+S5dM+Sv6yx7qa+M8FSf
	Q4frsJB3ruuNI76dhDINbNCBU0gwCRnGMpdjq24IdB7CDh6//xG1Ee+EA3ViUCtajKjgQkqoWOQ
	sXJMkoSDEajXScC2bqCTzPQ0y115PPpHhQGO90Nf5ElM7vzXZzQ18i3pg7J2Ab2l9cAZgAhlHwM
	veM8+WUVjMD4GVBour1DWFJz0hCsXgAMe/aOmogWdF7UprP/5srBjo9QYAqnL+psJsKgltz3OEd
	MLkrUf2f6g9hf0ApAIGkhNxR19T41aBgWbl5ML4sLXMitxNvK+2j7zyUe27p241p4JfA4NH4tbQ
	ILZETV9OJbwAyCA+rYR6SCAWYPFobx9AFHeAI6hMWnz9A==
X-Received: by 2002:a05:600c:4f94:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-493f8829926mr95921725e9.30.1783958331815;
        Mon, 13 Jul 2026 08:58:51 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f3a60404sm255840755e9.1.2026.07.13.08.58.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 08:58:50 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: vadim.fedorenko@linux.dev,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Mon, 13 Jul 2026 17:58:48 +0200
Message-ID: <20260713155848.55530-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
before parsing it.

A peer LLCP PDU travels: NFC-DEP frame -> nfc_tm_data_received() (target /
NCI path) or nfc_llcp_recv() (initiator data-exchange callback) ->
__nfc_llcp_recv() -> rx_work -> nfc_llcp_rx_skb() ->
nfc_llcp_recv_connect(). For a CONNECT (or CC) PDU nfc_llcp_recv_connect()
computes

	tlv_array_len = skb->len - LLCP_HEADER_SIZE;

as a size_t and hands it to the TLV walk. When skb->len is 0 or 1 the
subtraction wraps to a huge value and the walk runs far past the skb,
causing an out-of-bounds read; nfc_llcp_ptype()/nfc_llcp_ssap() likewise
read pdu->data[1] for such a short frame.

A nearby NFC device can reach this without authentication; LLCP link
activation happens automatically after NFC-DEP.

Reject PDUs shorter than the LLCP header in __nfc_llcp_recv(), the common
choke point shared by both the target (nfc_llcp_data_received()) and
initiator (nfc_llcp_recv()) receive paths, so a short skb is freed before
the rx_work worker is scheduled.

Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
linux-next.

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: move the check into __nfc_llcp_recv() so a short skb is dropped
    before the rx_work worker is scheduled (Vadim Fedorenko), which also
    covers the initiator nfc_llcp_recv() path. Reword the commit message
    (drop the "same guard as AGF" wording) and add a KFENCE reproduction
    note.

 net/nfc/llcp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..72b6e707ad0c 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (skb->len < LLCP_HEADER_SIZE) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	timer_delete(&local->link_timer);
 	schedule_work(&local->rx_work);
-- 
2.43.0

