Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681959;
	b=3bw26vo6GqgtJQdXrKvlUcEihocL7DB3iF0aNBbckN7UYevNWtUMj8EjNUi051ZfIeDA
	 sBywaNSdjj4Cnh5D/A3anj+JGXS5fYTgpTVSB2SCadg+itEcqC3GhZo/KZ+IL3MuJaHCk
	 wzQhMKQwDVRQsDIKoGi7M8lxte544amIqasVGdvsKbjp/C9HSLjtIDeq2AOM5BwyUDXqw
	 ArSxSnJlu/6sj30hLEq5KvBJvVil/+N8Qtc7cCzNEHPY/8ABFGNcZofUFR1xEFxzNwmxe
	 F2QdU6Vv4w1xLCI6d+fGFcuZIxfz8iUhMIeDPnseCzaAYNF6vZo12WqFO3GHmHSfePA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wzjJUYtJq/00jKf5atGKZJsY/VwF/Fx8FYMZJrmIn00=;
	b=3kC2qOgXI5nXIBU9BaBRO+afaTXq/vBbhhI1g6U7acpoG+NWft1lN9MOrdVPMWatwqe3
	 rPqOLTUUeJaLv5+LdEV0akQX6PzeVqCu0wAlYV0zpV28zf5A2ac4Syy5B3mcMc90d7xHo
	 Nl2yns4tYpSXLFP1+dHzyNL/Z6WSd6akbJnZtrShrwETpTkFJFB0jyyq7nT+VDRhoGja2
	 6oi3mO72VBluN88fjoEI7rBWQRhdJOAMDaYYnh5FM7RfWzVI/ZCAyQQmke1QjKE4iA+ER
	 CB/3k9VGCV9LbCEdAcBbfBZyasvir/odRJic49mTQ1VBd98mZeXb0cgrN7EYOzIe+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PtljBC/O";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15D606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D15D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtljBC/O
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cde84cb8803so1754050a12.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681959; x=1796286759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzjJUYtJq/00jKf5atGKZJsY/VwF/Fx8FYMZJrmIn00=;
        b=PtljBC/OMu+gIK/pomFMLQGhgxHPIInM/bASFncZErxN1Fh+6ARFHis8rY2E5+SQD+
         lsd6H9QCdPp0ip1ywkclyQ4xnl7YY+YKdBxwSqfcYR8Xl2XZvCS98wYnLTAhPZEpabth
         n3Gx2NdzH6fKqxvzmE+k6obTbVvKLeFJyBQpIP0D2mV52IpdmiHxSHFblwnfOOcGCllL
         Vx6ojvnRiftGdsBzA6nULK7j6kslBFvMBjlzna7uQW91+dMl2Jis8aaHYkEMWSTU6xcl
         T9+2TglB3CKoc5mO/HgDaVCO/JvgtIVa/HFpzD+e6vih36CySWblXmmx0uQNRGn7EjQn
         r6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681959; x=1796286759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzjJUYtJq/00jKf5atGKZJsY/VwF/Fx8FYMZJrmIn00=;
        b=VSEkbzOrKvjNLP5OoyX/8TdyBePtrmqePuUcrcJjme9lhVjF2NOU7Dhag2kJ7ILAVn
         cwD9MEXYqxUpsipBW1zANTmtvGcvpf1/ho8BwUQuTDxpAWT8wTBK5nOtLxTV3q/wihP7
         Y+ytM4TMLGdYWY9S4aCUVUxIBhxLuhfQxSAqUk8PvAVIcOL+pnZAFD7M7f4YubZnH8sb
         v1lHwVeir6Ir1YnkkeKaKIyj1GaZpvT6iwHRL9r9U1NKrj08XKYNq1rR6ffeDeRU3hgt
         /DQfeAYWWBr0PgLiMp4o1oqhfMTLGVpdEdUyovM6ktGehfdJUf5pBPHa7XkFA0C9BIho
         TH5Q==
X-Forwarded-Encrypted: i=1; AL+hErF84NalMER7CRV8EukqWl7FRWrcOXKaguGHwH+8fVgbPttlA4aEy8tQNHnVYj265DmIPnlsfqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vzmcIShlwtwXJjqWjfTHBO5jBfaefES1EwmxCeXmGLDy6ELeO
	3FqQo9Ckl3rkDbRM7LxXQAwFkp4zx8MbeZ0UvHdvmNNgKvDoFAhQtsRk
X-Gm-Gg: AZFdTZfK8DM5XSak+w3H+AJlbCJbpEWqGKCpDSPpxyIuKb2zaTTNFqQsaaTXZSMsjkX
	QW2/plvgO4js9BIULOA8a/u9rNbTMpeWSf45IAY09WMfUaJ+Axa+1pLGkZYTr94QhNW+TksXU8a
	OoEdNa59UUqgoB+5OXgxn2GKoeythABi91AcHrr9a5PqMMT8s6QIb/wxZMsk2NBsMThPxgdCNj5
	2D8YN2O/CUUi+R7e7qh93iYCB0i4u5dK0e257/2sMJbfLqNWJbGBIqpLCD6EPTHanqIzvSCZB/o
	oe5Gfbnm1s3Isf6NtuUFAvnv03S7I67ouYMru9wrSABHMgWlmGwir8ojv1e8hzkRqLjwE/Mt9JN
	O7nmmlZTRnd4mhNN9MlezRxawjF2y0cCREoAnV++gOkWgqGbWhPG18fLHX59fBTg4z5zrQezuQN
	Z3/WqMMbS1oYdTMCr22QAoaoGPDyZorlmAWe8IPzFrZcvjZmtedXW97oKMr2GbDpiUSkXxT9ZOr
	Nx8eCkm8iNaJIQu827euvUvWKAWOIlBbhNUclPwTLxFXr5IyVBwSNfhTmPx/Yd7tgBdW9/oLDxN
	1hAXcGLUImg5FeChmhdHHCdmqguVFgI3N57hmdHwk4hSH9QPV2z6nTk2LJ0eZ4CS7JuNz2NkQQ=
	=
X-Received: by 2002:a17:90b:4a48:b0:3b4:1884:984c with SMTP id 98e67ed59e1d1-3b41c7b573amr19343527a91.6.1795681958544;
        Thu, 26 Nov 2026 00:32:38 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm13834575a91.4.2026.11.26.00.32.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 00:32:38 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jbenc@redhat.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: Lin Jiapeng <jiapenglin@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] openvswitch: reject negative L2 length in ovs_fragment()
Date: Thu, 26 Nov 2026 16:31:41 +0800
Message-ID: <20261126083218.55429-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Lin Jiapeng <jiapenglin@tencent.com>

ovs_fragment() refragments MPLS packets from their inner network header
and saves the L2 header in a MAX_L2_LEN-byte buffer before fragmenting.

POP_MPLS can leave inner_network_header behind skb->data. The signed
offset is then negative and passes the "> MAX_L2_LEN" check, so
prepare_frag() widens it to 0xfffffffc for memcpy() into l2_data. An
unprivileged user can trigger this on both IPv4 and IPv6 paths. KASAN
reports:
     BUG: KASAN: slab-out-of-bounds in prepare_frag+0x3c2/0x4c0
     Read of size 4294967292 at addr ff110001059cf044 by task
     ovs_frag_trigge/132
     __asan_memcpy+0x23/0x60
     prepare_frag+0x3c2/0x4c0
     ovs_fragment+0x578/0x860

Reject a negative offset together with an oversized one and drop the
packet through OVS_DROP_FRAG_L2_TOO_LONG. Valid offsets are unchanged.

Fixes: c66549ffd666 ("openvswitch: correctly fragment packet with mpls headers")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..9c19fe8676a7 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -788,7 +788,8 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 		skb->network_header = skb->inner_network_header;
 	}
 
-	if (skb_network_offset(skb) > MAX_L2_LEN) {
+	if (skb_network_offset(skb) > MAX_L2_LEN ||
+	    skb_network_offset(skb) < 0) {
 		OVS_NLERR(1, "L2 header too long to fragment");
 		reason = OVS_DROP_FRAG_L2_TOO_LONG;
 		goto err;

-- 
2.55.0

