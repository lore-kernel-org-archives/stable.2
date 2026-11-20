Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211118;
	b=nz9jR+59oXPS++bszSTfcACuwEGKZY2x/0ZvXpuwK51k7hWe8KLOEiaYvMagFKcPNeKC
	 r4Mm6ErKQzP448EX1uNXlmfgaTtNIz0hKAgD3kvTH/rUgNdBlTUrtqxwgDRSdpGMt4QIp
	 ajoCot2+pKhP2S5c27+rxQ3+IavwiFtAlrLkQ6s6weZyTVIU9re6mO0jcF3Y7gpVIUz0t
	 t0Q7we9CFrKJchihUUtAUIjjUSsdCnRH7ojvihNlgWDJvfreNqp8Dy0vPl155wXuO6SzO
	 c8T7YiK07E8/s/BqY2I0XZGQcoksX18nPg9bwoOYS+22HPtpwoIX8uDTQ/bMK74XUqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
	b=q9Jeh3dBBFNpkyKSHZw6Bk/xbWc41DD5dWQmwKQiNeYtoXiMelw5JYQyye3wj3KT6eau
	 61CtDyA+5O0XoMQ1IDEBO2J/34VafiIeWK0RBoghqLHKSSRmLBCsFMDUcf1k5gdawIlhx
	 w0IS0utJmGbGhqHCy/WujUt48Capv52cYwEZ92wyAao6ZNMnPvHvPZZHZ7uImwbGcNSUY
	 SBvQ+4fqyqeX69S2JA7sTxnq+3nvQRyXULkERdXuO0xSWioOX+Zy0eNWc64NguuntJHms
	 NdHK8CHebmiYm7V02/NfR8/s7zTPe3tLwHq6K9aTFA5zqxrRn3XaAQb2y2g35/9CF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=C2jpFfSu;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A2606A6B9
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6A2606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=C2jpFfSu
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b190cdc9feso901009b6e.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1795211116; x=1795815916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
        b=C2jpFfSuutuCZeuGrrbB6CPrXuCLHPjsYbHeZ0INc6l3v8QadfuYXncjt5KuVqhCt7
         3SGz83K3k0XfOMALHygvAHc0p1IU97YYD7qpD97CXDb1KaWyKI9wQnFAKN+YjHjDDrKi
         mrAFEuwoV4wVp4oMYecBLnGPaSrvpuSnn1QWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211116; x=1795815916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
        b=lRFpRuWBhROyInCvaD90r2nn0csiOw8zTxuV+c7ahLLK3xA6FakzQ4i47tmutj0+1X
         weDeEqtraiPS5X25pIretc9VKuv1I0BuCztPqdVuHuClaxBYdovm/BOmCUoD07Jim6gO
         mdgYY9hFtXegU2B7zR7MvzewWjNFlN6uuzU98JTBbHPjc8xH5qN/muwglzPZLXaoqbvw
         9hDQeFRG4PFBPU7CU+JtZneeBKRC4CUoFeqhsMr65ZWoDxCJni0C/TitBvL1lU6ojZZB
         Cossemt8+lK6Ml6hD+vwcjgubpkdFLprMdd2JLvstah+xk+CBrqYokS/CoD18rKOtr+p
         LPNQ==
X-Forwarded-Encrypted: i=1; AL+hErG4RFIa/seGLWXYXqYZJ7J1Y6mL3KsEJ4HPtzbnoGUlglRUnr3sBg3Gs05PsGShxD1NA6QwH6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z99imhKyqTqtFtofunJaGbaMiJxKc7OXc0W4azQPQTKcCGFdAPy
	CCybKAupgcJJkjGa3WxYdqZukl2KpvS9OG6kEd8R5g5tytRxym7o7FSDnjCARGD/Gzc=
X-Gm-Gg: AYBFou0R8CgRv7ZxxH576jIVVzYIJ6xYbMppuiU+nG9z2hec6Q3+2Y13JF8qDv+NzFb
	+2llx2BMfG6jFIuC7Zy/zi8e2iYeRN2s8B837U7fvogBspKiNKWe2b8YHuBGiYrME/gtRTOSPqF
	gqsvqXhXgaMjPPQwxC6WtSOXhac7bH1Bxx4Ouz8dT4T8o+1DhYdrfnjaABqyb5Wf5NaRe/igzm2
	x7lh+JGiypj8ack2pLWs5f7Pkt6rJYx99zQTaFTU2aDdtGN8Q6D5Bb5PJrC42Gg7ntBFVKZCXZp
	skRRBWl2IPDDQ2xrFF0m4ZyGu9FwJSX98qXc0J2++LIjgQIncwwkBzT/34c5NJ0mwhqFVomw/RQ
	zle13VEry6swfKWEIsK+4mcR2Y9LgSgdWfjCPW3bAPS4bLc8DzKioJDVuovq+PMjvYo5LCauVCr
	0FpSLztJM2wWOZRqrRXNFp1d/Jr0asDby+ghkXvHI9+lOnEfKLqU6hQLq+Si0CLM4OzIG7vqFEx
	MCXND507gilv15Fj7Nhtmw6/ao2sREH2H7sprDQFAAdz/LvBcUaItGIRzVNwJOhQEBdsCsWk62a
	hfAwZnKtMpc6LEOmAiPNXqnUQHyuOOv6I49ddMt/aemZ4ZrDh83hWTPbGV54HAgQuKUYeIkc6v7
	fOytJmFfRW8LuWiq5Off3fp59l9N4BGqNHcLTyBh+ZJEAZ/Q002g=
X-Received: by 2002:a05:6808:308d:b0:557:308a:9e9a with SMTP id 5614622812f47-57a095037bemr5687975b6e.21.1795211116347;
        Fri, 20 Nov 2026 13:45:16 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35c5ac5dsm3222237b6e.15.2026.11.20.13.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 13:45:16 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] net: skmsg: fix copy cursor when coalescing clones
Date: Fri, 20 Nov 2026 13:45:11 -0800
Message-ID: <20261120214511.25934-1-kylebot@openai.com>
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

A splice or zero-copy append can leave the destination copy cursor at
sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
sg.end does not advance and the cursor still points at an unused slot.
sk_msg_memcopy_from_iter() can then walk around the ring and write into
older entries, including file pages spliced from a read-only descriptor.

Software TLS can reach this with an ordinary MSG_MORE send after a file
splice and a splice from another TCP socket. Both TCP and the TLS
encrypted-message allocation can use the sending task's page fragment,
so the TCP-sourced plaintext can be contiguous with the next cloned
encrypted-message range.

When coalescing with an exhausted destination, move the copy cursor to
the tail and set copybreak to its old length before extending it. Find
the actual tail on each iteration using the ring iterator, including
when end wraps to zero. Leave an existing copy cursor unchanged and
preserve the normal coalescing, reference counting, and memory charging.

The issue was found by an LLM.

Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v2:
- Rebase onto the BPF fixes tree; no code changes.

v1: https://lore.kernel.org/bpf/20261030042138.73739-1-kylebot@openai.com/

I have a reproducer for this issue and can share via DM

 net/core/skmsg.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8a3b8536c0c2..f47c59ba1ec6 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 	}
 
 	while (len) {
+		int last = dst->sg.end;
+
 		sge_len = sge->length - off;
 		if (sge_len > len)
 			sge_len = len;
 
-		if (dst->sg.end)
-			sgd = sk_msg_elem(dst, dst->sg.end - 1);
+		sgd = NULL;
+		if (dst->sg.size) {
+			sk_msg_iter_var_prev(last);
+			sgd = sk_msg_elem(dst, last);
+		}
 
 		if (sgd &&
 		    (sg_page(sge) == sg_page(sgd)) &&
 		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
+			/* Start copying at the newly cloned suffix. */
+			if (dst->sg.curr == dst->sg.end) {
+				dst->sg.curr = last;
+				dst->sg.copybreak = sgd->length;
+			}
 			sgd->length += sge_len;
 			dst->sg.size += sge_len;
 		} else if (!sk_msg_full(dst)) {

base-commit: d5ba86298b45e1a81c578c499e9a222a3b734d5d
-- 
2.55.0.openai.911.g06873a30d2f3

