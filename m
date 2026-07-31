Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFC3537D2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468260; cv=none; b=KKPlkLZE8mLQfc9TGIjVGboXtoKdwI9ZnREcNF8/7YqEh1+AIbkaWOF53tKcf9ACq59jLEbckH+GjKTvB0flHEdQj64eaJsEWLMR3fMZ0RNLN2nRi3M91GyVdLSD8zYQ4lN/g9TGiNwsDVHGRJ5Y3KNvBSERKLPccCklMdPymI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468260; c=relaxed/simple;
	bh=RTtDn8xLk4cqizbu/eCai5rh4lCOJEd4o/Ihvcc9P4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvFDxnPN1SNwW91R9t9v3RSHX/6DlxmN9xIfqE+dF0XV3gaMhIyFwxtdWbkoqgBCfifOOWa0fS2gegB23O9Cojv0pS9Wv7IRYv4AbOUVho1S2e32A8J2ygx3q3GlU2IzGDJYekygFupT7+EKyvsi3BR4qt3/g2+NKaN+paq7v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmdZ0yvB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmdZ0yvB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so403860a91.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785468258; x=1786073058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgtOPZlcFx69TNmsMfc9ttGlQcFwyZj8UdAlpvl+1TI=;
        b=SmdZ0yvBbtiIENE8Z2WPaMJSFNd7b40OaqtYAM//jmikx8JOAOlxmfRSSJ39sNy+HH
         yQOsEU73smnNdL0JJD6sL9UMLjBQ7GGAow/S3+dmuSsaLaBLiCzJHhywoN4EiefcU+DZ
         2mgWj6QxrWfeMQENNNKcRxq7yfsY1j++glUG6U6Olzjm2tOKL+UYmtku/YON12jfbOxl
         2RaE1LfUo++hyYfxnpr0bSXi2y/oKAxkoU20c480Qp+9mJu8eGZ1QKxZps816r+28fDH
         AKqIpaygnjxvMOVEcWt1AVMgSpsUjoS2ZH9T2UbqNMw4JLtCtstLBhh4SDeqoprjWIGL
         WygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785468258; x=1786073058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgtOPZlcFx69TNmsMfc9ttGlQcFwyZj8UdAlpvl+1TI=;
        b=BsIinhNQqsoRj86PAOya+gKt838s8bhJ7yjC/fuhEh59ewpmf9jYBcR4zwiiJxB1nL
         fVG6BJb+jQz7DbzTnPLJuYhLr9waGDK7aT752ED5AQtI9YODEXZhwnOFwEXPRzr2tg2k
         udPN6h38V9zZLxLJuzGsviOGDfII/wC7ycVhQ0upoSYU6Cuz4Wt30nZr5w/Afax0HsW6
         VdPXpyRfuU3svFFPO8kBmBsvTTuu5Bbyv0eMBStAfzl7V64lIOEGj0dM420zIwpIhHHv
         cnw1rqS0qgzy7NdU/LyN+drApP1ZiQdas0mHquaxd7Mh8xSaO0h2AV9uRj0S6tyhYvbG
         uVSg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1/XAFnbFXc7vcSm4i6r0bw7vmMx7Hst2l/WLVoC/NjBrFW/UqUCfDo1Rt/WaKMt4xxqT+e0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAE7VhxxMWNDZCpEBDB+0o9F5BYhtLnf31wsOADS6OmKZUgZDP
	RLQPWXfTU4L/TZWdN62iqA9/Za+736QnDml+LY6SVnMNFr5wXUiYzMM8
X-Gm-Gg: AR+sD10Xk2bzyb3H2uWpezdpTnl3m1brWOVcNxREwjxMmBLDqr3K9ggqt2qaJrqrSdQ
	jjpSm4nVF/p5lAqHtuaeoZlUK4KromIA7sfxVtsUJChj2Cg1x+7+8i211wio7kI+Q+vl485thO3
	olcusgix3a3YVPTDcX1cr217k/Xm0UbGct0lgTjzORGRLNi8cblciqy/z9GzrSm/pKm3UVLRJ41
	WtrbVwdJhtngrClNRCeLFN6Z4jWYArzkaL5L6tE7WUIMADA//Z0pZm7WWUJtwT62c20Ux3xpoDR
	ryg7dBMxKGZ+jno1O9eKlGO4HHPbxzqpWE428lDw6nxLi4+UGp/FVghbm3zf0uJpEqwVDW8cNnO
	HxZOWeCqbn86yhRzMn1SNBCYcr4KhzYCAHwZvp4zDlTKI6fPWAxPh/8FLm3DFVoOP73GM632Z17
	NKNFKYt2sHz+dkRiytlzLf+cv7YQ8buqU+TAOZtgiw9hTU/22mBu7FK0mbQtTW5kakkbirQDS8/
	2n8Z/oXmfaeh9aVomlSqT+LFZfDxBU59WcStpOzpOo7XP5F
X-Received: by 2002:a17:90b:4d8e:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38fb149bb44mr351802a91.30.1785468258030;
        Thu, 30 Jul 2026 20:24:18 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047c42b4bsm869275ad.78.2026.07.30.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:24:17 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: fix skb length accounting after generic XDP frag adjustment
Date: Thu, 30 Jul 2026 20:23:56 -0700
Message-ID: <20260731032357.6114-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/core/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..5c37cf6c4aa1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	}
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
+	 * from skb->len before updating data_len, then add the new one back.
 	 */
-	if (xdp_buff_has_frags(xdp))
+	skb->len -= skb->data_len;
+	if (xdp_buff_has_frags(xdp)) {
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-	else
+		skb->len += skb->data_len;
+	} else {
 		skb->data_len = 0;
+	}
 
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
-- 
2.43.0

