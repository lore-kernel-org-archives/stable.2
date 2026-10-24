Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843627;
	b=Tyj/hvfojDvBxpDLrzGGByd+AjEXdfou64cFZh7slZPilhEYUUboEl//VtRFlcOAt02W
	 3d8VyNumVBpPqN3kA50zz2yQtXx89YlP6GjADqqJ5aueRTCxpWWrZfg0pMNYIWMHzNhCe
	 fZ3WY0PSSdZxvrbgjDXjH9GM6P0wiPQyY96gaTiEgDgmE1il4JtBzNk+FRQICU0wFe2Vp
	 yV0xoutgi9fGboDirmZTRd6oHBqoT5aVY1QjMY96tnn67E7bBJIJAou8BDmQ0wKLjvANc
	 GoSJT/i+MFpZfRCclS1ewh8QnSgnq2Jaows95eRUOKMg2f9rOG5TrAYN+8RbnzE38zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
	b=vqcX/g6aqc0gczLrrTmJ5V3/kbDtKRbG11by6GsONBmuw7h4KWWyDqA/f3LgWjVV6hkW
	 mn2qndGR+wyjp7gOCocvw8/eyAPvaepktZ9mtK3ooyrC6arOBBdBKQZlDliFbG4TE3MN9
	 rdPJDFXxjRx6rng10u9tpZbClUZXhPLF3NTy3m4EzjQ22hoKFhgVVVzY31J+n6+arnhOU
	 8QpUW21/dwlz1zP+9tqj00UNiovrVaKW0rrSLisPwz3IKM8X0Fu22iWS7OWLLhHs/7Fd/
	 xE6VFSNDloWHnxXFjyeGvsn4nbOB1W9NLlZvmwuTIpMj0jDSLfO9VssX5KNGrrgor2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSY6OdDC;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21297606A325
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21297606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSY6OdDC
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35f036b17easo3480957eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792843626; x=1793448426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
        b=XSY6OdDCSUlPOYv4PuPcxjInaUc3nzXMpvI8UYrp5Z4UXpyCr2KHLZRhqqkK3mbiGT
         EYi249un6JB5e4nmMahZ5NCubG4heReC1qXTKlOuJOZHZL8X2AnA56Qe1YVookEARxLG
         hfzgK1l9BzyWOBdfd21r/jlfhADCh1UJf2DzZAYn25t2pDyqrCVH6DxBLpST4JiGoks7
         RHs2HhOc5DFabGn05StfUXP7GRnO2A6nkhLjnjhzHLjcbOwJn6g3Rf3tchbuQ9ZNzVpr
         mIMJ5yCf3dpPOLs7SB4kWN4FCaqw0hiIlb14dGvdW7SPlHb9Jyp38OOazErINnS8VeAx
         MD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843626; x=1793448426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
        b=rWCepZncq2UGIySS6lrTik3cRre+WLhGdQD/WAhErnr+P9yjCUPY/QyLCQ4XNLBJs0
         EC/5gsoIe+raZCa20e0hqPH0J30ejpuczkOoU0BsSLPIHw8WonQfZKq2NGv/05WfLP64
         CYDn2iBXe43LZPaH2OFL8Vfitm8r3SPbukWEQSVrJOUxBOk+7zot3v06+Ainy+JwQqQc
         k+3xvsf+MebINAsl0aQ/fB5W/RRznW11fXIENYpHA24gRKQjF9hDAfOmCeip/d1V5hRd
         XaNYH1Dq4bGwRP+6n/LcSQIcYmLYmkXEUgck3xkAjFXjwKj/BbI+qKRKkIS7WCCnaGaC
         mybQ==
X-Forwarded-Encrypted: i=1; AKwUvByjHs4OcUkQI5F5t63fSqrYL6hTtoFkFaPTWF26zQZi65xx6G6N+LJdHlrl9P5JqW06vhtuK+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkUCR83pIyScDbDavvRCMjJCDnACCEryj01Xj9AztSWwtLSL0T
	IEUAqodoZ/6kkY1phGd0VeZPe/ne+wDszCx8SW66kf+p5HS/R/IOU/DcIEQA/HGSXeg=
X-Gm-Gg: AYBFou37aWQGWAFMb7S+W16hJwvx0D4J82IRHXR69hRX4lVJ4oMJw0QBvYCh8oXLPGw
	B3CkPliaWyt9Pn56e2P5nXYrOLsZWb18Cp43+4GYlwSQRMUD+BlADQgoB0TYgQVB0Vn6JAQsNJw
	Ozmto/kxmHQwOF7bqg9V2GUq4XiDon4THL8JH7KKLCD9XjbjYyagJN2Mo5Jvi2O3GGZXLEqtvfU
	PAWfNkB57kOYVi3llkUy8UF/tUcBbz5rE7xlHDv2gulNIpFw8e9AdEwaDWV+sxOHJ3OwH3fa6oa
	Ncn02VBdSc3IWUzhKrS5876i7Nw+fiesz2qlm+VBahjlLu1fFN5D3srLzg0X/Jm4+hWadPj2iV1
	qaNNE3+swhjvntfgPyeG2Tc0WIZKyJvl4bvv4zRFsM8TPr+eKTzE5l+6mcCo3af9n+53T4jVzi9
	V/Cy7WqgEnAcMkaAXNAZVrcVfYVj2GlAq2UwcxTywisQn/l/9kcZ8Gx9tRTjw4QiJFufla8fZxI
	9F9X9CV9r51pwkndNJOELNcU7+IYfiqUamYyJy9gaD+6M+7KlR3AXn2rE2l7QSaXBvzuY0gnboA
	MtM8gq7g62qVccDQXwgJhjCuKg==
X-Received: by 2002:a05:693c:41c3:10b0:369:efd5:9cad with SMTP id 5a478bee46e88-369efd59d94mr691961eec.8.1792843626034;
        Sat, 24 Oct 2026 05:07:06 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d95e91sm8120722eec.15.2026.10.24.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:07:05 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/4] sctp: abort unordered partial delivery when its message is skipped
Date: Sat, 24 Oct 2026 05:06:25 -0700
Message-Id: <20261024120627.837568-3-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024120627.837568-1-tim.budding@gmail.com>
References: <20261024120627.837568-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips unordered messages on a stream,
sctp_intl_skip() aborts the stream's unordered partial delivery only if
the MID being delivered is lower than the skipped MID. If the skipped
message is the one being partially delivered, partial delivery is left
in progress: the application never gets SCTP_PARTIAL_DELIVERY_ABORTED,
and the next unordered message on that stream is delivered with MSG_EOR
as if it were the rest of the abandoned message, so the application
sees the two messages merged into one. Until a later unordered message
on that stream is abandoned, no other unordered partial delivery can
start there either.

Abort the partial delivery when the MID being delivered is at or below
the skipped MID, as the ordered case already does.

Found by an AI assistant while working on the previous patch. Reproduced
on an unmodified kernel with the uo_pd test of the sctp_ifwdtsn.sh
selftest added later in this series, which passes with this fix.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index f8c818a5533c..77fe0db5ff77 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1246,7 +1246,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	struct sctp_stream *stream  = &ulpq->asoc->stream;
 
 	if (flags & SCTP_FTSN_U_BIT) {
-		if (sin->pd_mode_uo && MID_lt(sin->mid_uo, mid)) {
+		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
 			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
 						  GFP_ATOMIC);
-- 
2.34.1

