Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854972;
	b=uOwpy3pEdhQiBi0nWzNf/Z49gN9BpnaVkpUMxGTbpXaJbse92OXIHJ6bBb9zeEpBakwO
	 ttjz1i3roC1TpyzupwY9fO6ec3vt7vVAx7Te09V7wCxRVxg870Zp3TklwIo/q4QfaO9zE
	 pgdATeCX365YjbthB6fwdKImhrflqmwzO6ns0uvc0YebbXUSd4JaGkRtIZp9478bq7NY4
	 b6RfFcbcXGswO89CLKTgsaQed6smQYZoFiCBkzo8JLnaPTPdeQZthgWw9pDLazJ5DCAmf
	 WqDZ96qxMs+EX4XYzT0gC8fS14lFvR2F9yoYqrjzRRouzAP/Q1o1QMN+W9XzZD8scEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
	b=cTxfGXPITNXEsf5PTJC7C9VeJ4hRREFth8m4wJQ3DRTNvAlXtvPqjXwIMTOjsNxG4ded
	 YIyGsJP+alW2ffO9JfQH7NGuAgmtlU/znWKZp509+7rRBx5wcHULR2IjVdrmVzMbL3pTe
	 zPuSSPDneCVu2m1ioOPXu9Ki5C/JhWcPCQRHg4a2VvrMSxDPh7RtLxRcD745rEL2q/9mY
	 4eUd4VB90ImAc3d4JDyOEaRiPgfuQ8dTcirQ4unQgR+Atvkt+9WMFSPgMdo9CRl1lSPz0
	 uqPn5ileCwQlPBzghjp1aUdFzQmypT97jM81WfdMMa/ySy0jOybfFv/L6rk4SDaFqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxNtRLI3;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5E606D821
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A5E606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxNtRLI3
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1688752c88.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854971; x=1794459771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
        b=VxNtRLI3j9T/8JzZeBa7Vg/9x3/kswBzW6MPGKAqaXfVyJ3lITbV4/VITEAICjFfMf
         eMk2B5AHjHt7knwLMB+T5Dshpo8fW5iugQoOKGXGvPz3mr5TGAdRRLcJWqL3TK8DyxDq
         cnBt51+U0LBmPPBvJyvPOSnvB5X6rTiDbKxi4szD6gQ51Oksxy/4Bf9/dg7xdWFE5xal
         ezJPO7Yz6vgEQ03dSP9ltynu3OCWaAeHuPGbVFyqCwv9sIQRTT5BErN8iBOywapHneTH
         3W9KbNFG6O4UgwRN8R5O6iyiVcff28vJEYPlqlQ4lLwQII/aIh2g+A8eGVJPWgXFSnUN
         Tt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854971; x=1794459771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
        b=SyTIyYORHqyD95NE4yqLZWq6PaRIcM5DQiHIBz+UxEqUa7HFiEfQKrmHKM/niV+AS4
         4peZ17Z3FEU0w9hc/vZkKNfQnSVXEYtcRRKWDwOBeX+6l+lqeJ/ZPavjP7vYj5n5d9K5
         /7G1WyICgcY+4CDbKZ5oSV+6d3hSU31+vQm6atBjJiqy268SRmpt12My3skXNpbZici5
         B+iR7yIWGS8vu4qc6dxFrFR1P96ScxbbfarIP61zKmPBtG9dYZrF1Exs/nALwJV4wI2X
         qPswmjAh8Wyy7d/N9E1u1oAfPhFELWg9dYW+q4jA3CheuEGXOAm+IExPgzgq1GZBhLiJ
         gwag==
X-Forwarded-Encrypted: i=1; AKwUvBz7kBhWWZr0d4u9t8v70/fFFvJBwtIBRWzrxPPzBXgCBBQyP+0q8tX5N9o/JC6dhNWPJfu0CUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nphvvPVJsnazHJhcxXJ9NtEvgrZ5p7KVha95Yt0Q7fQ3lIY9T
	OCcpJyKsjis5ZwWKWZ+TMeIrpicC1Pxp2Mm3apU7CDtH27vYO0nzCAQX
X-Gm-Gg: AYBFou1xJt+6OifksilAWrSNUtrfDh1Q9UouXdUOMyDRSsKOUnFPRbNsdp0udhYcAqp
	xtdVhRcIxuy/yeE9N/80VTZP8GwWV/NId/d4pzopcHe47HqGQqavQBus4T+9iqH0novkn2Z7asM
	fp47PlEMCFJoAS9eBh3LciMaUTkWCGgUAlRb75DNo0RJZkKQmLu41nRfKrvMc7KMqjydNZ3V6bk
	3ZYkmv8r5/JSOr+4+slVJ9Ai/rWbsfMtDNRXb+t2aLDv46J/xqmYnnVtrWOGKlQGSRgrtDDWOcO
	r7pcTa2i7FknLbTUGWNFCzN843o5rAMXUa58dkS7W6u8oyatnEpYKwQlUIt/A4PjiwkjokydqG/
	PuGviemcRuQuooDz+oTYJsmjRWtOdEVumN8fVu/vRxU5PlIeK7iCsArNG1CLDPQEzinmt2mT6C3
	//kOgyvL/2flmNEZ3aJCKcmuJHQP3P2bFSem/5CVoze2N9xLFUrj9npyWD3Rls8csT3Johey8OB
	aujIXBm7V+sHJGoRxqw5Eu4lopvdYci/y12gHhh/Y+d95Yd6ntK6/1fyOCU9DVtXZtFvx5yFnjB
	mPOw6kxsSzP+Y4nmyOViDzqrwPz1EAhywv9rp5DlGLo/1G92ls9cqh0/tylTuAoA1iIseoybFLY
	=
X-Received: by 2002:a05:701b:2816:b0:182:94d7:f76a with SMTP id a92af1059eb24-1ac6088a34bmr25504978c88.43.1793854970493;
        Wed, 04 Nov 2026 21:02:50 -0800 (PST)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm13626735c88.4.2026.11.04.21.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:02:50 -0800 (PST)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] sctp: report the partially delivered MID in PARTIAL_DELIVERY_ABORTED
Date: Wed,  4 Nov 2026 21:02:23 -0800
Message-Id: <20261105050225.49292-3-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105050225.49292-1-tim.budding@gmail.com>
References: <20261105050225.49292-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips the message being partially delivered on a
stream, sctp_intl_skip() passes the MID from the I-FORWARD-TSN to the
PARTIAL_DELIVERY_ABORTED notification as pdapi_seq. That MID is the
highest one skipped on the stream, so when more than one message is
skipped, the notification names a later message instead of the one
whose partial delivery was aborted.

Report the MID being partially delivered, sin->mid_uo or sin->mid,
instead.

Reproduced on an unmodified kernel with the pdapi and pdapi_uo tests of
the sctp_ifwdtsn.sh selftest added later in this series, which pass
with this fix. Reproduction and fix done with AI assistance.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179293012867.3134.16497481637722705271@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 869940001588..e239da686f68 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1257,7 +1257,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	if (flags & SCTP_FTSN_U_BIT) {
 		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
-			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
+			sctp_intl_stream_abort_pd(ulpq, sid, sin->mid_uo, 0x1,
 						  GFP_ATOMIC);
 		}
 		return;
@@ -1268,7 +1268,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 
 	if (sin->pd_mode) {
 		sin->pd_mode = 0;
-		sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x0, GFP_ATOMIC);
+		sctp_intl_stream_abort_pd(ulpq, sid, sin->mid, 0x0, GFP_ATOMIC);
 	}
 
 	sctp_mid_skip(stream, in, sid, mid);
-- 
2.34.1

