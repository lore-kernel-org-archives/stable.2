Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082242;
	b=oSfwsTnCe3SjBI25rKfkVCoCva9CjwchZO2eGhWP9FQvPDZ3obcOR7u9auLU8eSUO/Wb
	 tT2KHAUubDpBN3x2dvdBDDtAE2fEDLYT5Uz3byCtKOKft9csCF1jQRYQKf5v8IHFORunY
	 2q5rdECUdY2SRaLB8YMk9UaI4F2Wan710HgWqLf/3DmEkuSSKuNzYDYfEzqR6+k1Qzjpg
	 +yGJ8DWENpIfUehJ7XUXJ9jDSkps0jQ9noUM4XaqaIrYAB6Dy2RVfsnhZVTkaEC71Te5X
	 zViE/X77oX4+1hDzqKeGVON9NsXMlPJkPg4g+HJFNbn7J71rsHfdkXUXSp4gEl85GnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2V+wGVkR/bmuUwxagpFjiS03nC66w3wqlw9sy1FL35g=;
	b=pX/fyR6ss0nBJWSnYZIxfEyAaUGzsFLjQXTe3wV6mH8CROsCJu4k4WpxT7wNhK13yznr
	 ukGptl6A3esCB5LTQr2D65103apfGI9ILytmx2a1FJshS2+CpO2wfHv1jUc91Uv6IMleE
	 etpCmBL3VkVNuotcI3atJAXzeBlci7K2+qKK0HXVJ10F0fdaOLZPm8J5SvuBA+2CFYQRy
	 6XR2wtujsmVaBsw13IgP02EK49n3pN+1+SB1bg7f16rAZqcWKZb3SXRN9vsbv4sCSuVGa
	 BozFefaJdpy3JNf6sz4lZsUGc6W8Kt2ffsLptgYGPPIxoIeO1K7HiYkxP+l4TkFgEEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOOvgliG;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B3606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0B3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOOvgliG
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so5472608eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082240; x=1795687040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2V+wGVkR/bmuUwxagpFjiS03nC66w3wqlw9sy1FL35g=;
        b=mOOvgliG/IXzKqHUJra+5P9TKS0iPzaUt8dyPM425Qo11zKK59R2lrMDP0jwsZnSui
         0evw30p1b8ZMLuxaEwjDJJSENgZ8DRtfnIHZ5kdovnZvzMvg7ePgWfikU0AHOW/eNJCQ
         RHYO6zkU0JLh/QMfGNZO9Qh3erPMNaq7oP9X1N7g3vnteWNmpYke4uB6XQY5jDmT8vYu
         Dt0DbnVWxxcWreHW1C1UcEJuQ8aUWcdJWY/PXgSLTNj2Qn7+mxqLMv21rEVLa8815prH
         76z/dy6w9Eegcz/W2AqOPLXJDtLpfASR9XsJ9D5aH8gle4US48OJX3R3jX4hlTG0WJku
         bjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082240; x=1795687040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2V+wGVkR/bmuUwxagpFjiS03nC66w3wqlw9sy1FL35g=;
        b=cNhKLdPfSBOJpANFLjj1NNZ6LmigIGAiiAqxNN7gs2qWlCUP9aCwwsovHQ6GgYo3ZT
         +NdBVuxekQcmkCW44EKdpj5upt37CFpRyIYT+Y0GJ+0764XbJ6TNg+vLhHi+yXWnkofw
         dF8xWi6xEnHIrHHh0AJM4Pau7bvsP7wgIsSlD+vgG58aLNPtSe2tvfdfDgRnFXO0Ivqa
         FZcQVkAiegk3LCieH+VTrQ0ArdjSVaNicRboNlArEa8kvtME28tcMG2Ze2lgNfR1Mpv1
         R74pC4NotcCsQzVNKY0PkBrdUwPBZoCheGODR3fEiAxt6i9WWogDW2+6ROe7VfYy8zbW
         fYiw==
X-Forwarded-Encrypted: i=1; AL+hErFeBvdzV38n2i90Nq1u9RxgovXvDYzho1NO8WjkZvc8cghifzLNfuSzYbpul1UpUNqVVwc9l7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sUVrUuA+UGShnfHEZ8AtHzhC/l//P6BER/HVs6kOA3tgNI2PX
	6JgB87KLBciESRm6ST0pEBIKiV1HgN3cEmZvrcOji3Not06Gb8Ouio+TisSpgA==
X-Gm-Gg: AZFdTZeagk/0+eiVNBtqHVxXf3qIwD+6vv6F0817qM65jcdkPZZTqKwVRRyEo3yOF8M
	B8UFG2RsUeFA+VLTrdPEDhhkum+1NM33bvWScqWJFZYFOMSJJwE2CsLA5AiYd12+fDTwvwGMLNt
	YRI6zUz9OeN9tpMtudkv7INbJgBdUpDLf2IjjfM5Fem9BTzwC6kukMHOJCW4Hs1WEhuTkYrxm9B
	2qMI7IeDUfBhh5lJUG7JmTsZh/7fBA9TS+az8F3cpxc6aAAnc3w6IaRAcqobombdnKF7Jt1V+ty
	jzSK4+Ef0/hIjhN9/eX3qUvUJ1aF6nphjZ5ZjDWpa4IvsRqXT3QScrHRPKd0u09MDAqWPlMXkly
	DMnIf2vqb87TXh4QB/YBGosNEPzlrFPv0qgq5dmOXdvg0wyxFaPH3nnveKDwh+nRPIPyg9aZf1U
	6IniatstE2tBJ3fpXISRz38Qt7QSIuz3vidAlcpxg349yI0eyyW+zMZdKUxFMFVFcmI9G7m6nLt
	gpQ9yrQ1IWujGCdnH0dbH1V9qe6VQ9ZHBCBIvW+hFuT7yomjjMmlJ8Q/swYESaTpTOrI2OlhvAf
	DBkIzxPwU7ueWf0OUGN4Fogl3xGLYqegTJu9bpy8Et8ayR5ivgiMoWimC7VKLE8hQA7f0SAL8S0
	=
X-Received: by 2002:a05:693c:415c:20b0:384:4451:f6d with SMTP id 5a478bee46e88-38444511167mr1764888eec.11.1795082239992;
        Thu, 19 Nov 2026 01:57:19 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm24172665eec.5.2026.11.19.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:57:19 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ath-current] wifi: ath6kl: avoid A-MSDU subframe overread in aggr_slice_amsdu()
Date: Thu, 19 Nov 2026 17:57:14 +0800
Message-Id: <20261119095714.991770-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

For each subframe from the device, aggr_slice_amsdu() checks the
payload length only against the range 46 to 1508, not against
amsdu_len, the bytes left. A subframe longer than the bytes left makes
memcpy() read past the received data. The u16 amsdu_len also wraps
when the frame ends inside the padding of a subframe or is shorter
than an Ethernet header. The loop then reads past the frame.

Check each subframe and its padding against the bytes left. Treat a
frame shorter than an Ethernet header as empty.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
nothing in aggr_slice_amsdu() with this patch. Not tested on hardware,
only compile-tested with W=1 on next-20261116.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/net/wireless/ath/ath6kl/txrx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 609d458ca6c5730..7ae14d470627276 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -997,14 +997,15 @@ static void aggr_slice_amsdu(struct aggr_info *p_aggr,
 
 	mac_hdr_len = sizeof(struct ethhdr);
 	framep = skb->data + mac_hdr_len;
-	amsdu_len = skb->len - mac_hdr_len;
+	amsdu_len = skb->len > mac_hdr_len ? skb->len - mac_hdr_len : 0;
 
 	while (amsdu_len > mac_hdr_len) {
 		hdr = (struct ethhdr *) framep;
 		payload_8023_len = be16_to_cpu(hdr->h_proto);
 
 		if (payload_8023_len < MIN_MSDU_SUBFRAME_PAYLOAD_LEN ||
-		    payload_8023_len > MAX_MSDU_SUBFRAME_PAYLOAD_LEN) {
+		    payload_8023_len > MAX_MSDU_SUBFRAME_PAYLOAD_LEN ||
+		    payload_8023_len + mac_hdr_len > amsdu_len) {
 			ath6kl_err("802.3 AMSDU frame bound check failed. len %d\n",
 				   payload_8023_len);
 			break;
@@ -1035,6 +1036,8 @@ static void aggr_slice_amsdu(struct aggr_info *p_aggr,
 		 * Round to nearest word.
 		 */
 		frame_8023_len = ALIGN(frame_8023_len, 4);
+		if (frame_8023_len > amsdu_len)
+			break;
 
 		framep += frame_8023_len;
 		amsdu_len -= frame_8023_len;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

