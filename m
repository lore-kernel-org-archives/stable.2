Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687003;
	b=wEibuYfQdGE5DrTOGxYaKb9dhEUio8GqLiViFqwFKQ8QLcTrqTTQ1yrCJENYNzaDr08I
	 t+Lpjp6M9LJgGu0lYlJIkKrsdHb0MD5xEhk1PnvQ4kWM1fIHUk3FR1HcuHmCUE3jbplhy
	 U5kPvHjxCdvmQiGevLfkZ7HWbEvoHCShDPv+KU7Sr7KS+ykeuS95a1gRSwiwe7Idd1Ord
	 AyL+J3QtnusuVEjdfBhqNZnKaGkbkQDEDgWD/isUPVLv2GbsFgJcKozxV8GvIntq1tycs
	 kNF0QFO6fL7ZBzOwEX6QS5OCN2mGfDoopNVTz+B/iKfvdRMNU/7CZELOgjf22XIWbdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
	b=Tc8ViSdPHH0QRbnUuzxAZW1OlNUgEygSKhKjczN+LgUuoVSeoAQZnPdJeJJLwBPbnoSr
	 hMw/sVJrfTmDJRs+8/H4hTCwsX2vbArRaXBpLKITbdoQ6CsFpjhT4rYVBHNwl2ISzEEZm
	 xL/I8YCOliipS8rKmX7Ss7I/bcHPSr8ZBmSSMBgMyYJAt+pPpKAAORttbBnE3mEuJNBaP
	 UFsP6UA0IHsVIC7JdaC+5trrFAMEIwWil/c0Ysk1mSWMz8VnNPCAtceOVK2T02fXVBx/L
	 FlCmJzvqd+XE/FfM98K0bfWXBECDi4zmdADK/4ElOmcKwxvTdCTpak9vpAdXSDBBIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Vokx/Tg8";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFC606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vokx/Tg8
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso48705e9.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687002; x=1793291802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
        b=Vokx/Tg8TYjm7F/SKH8DDaZUu92EOwWBEPcfCIIyGelydx+ks+r3kdT/Q7Pf8xeFu5
         Q93181FjebSTzRVLLMCnCIgs1ZtiJPV3dJTwJgt3PsEDXNq8O0NssbWA7dhYpG5cdMa6
         rv2M7wIv4eaS+CHYapfxkr5yKhlLjjGMdu1R/j2MjAIXxwdQabrnCVh6EnCXGziI0K9U
         XlO4jocMxrcN1M2TjO2Qp8EUHcTGoxAeWykVXoJ3K2NFKCv8ujmiHjJGh/puVnGVBQIs
         LVhhycFDpcGDnbNeR7uxY23W6NEAzsNdg0eK4riZzHlw4Jgm45N8SCjxNdT2OQjGo3b8
         aq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687002; x=1793291802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7l9GBldBqggvq/zvWK0w7jaQ7qb61TWRK+g3QMrrtM=;
        b=FB3l9kBzkQGnohOvG6S8yvVdgAccoOnkBRXtx8m7dEpu1FRI/vNra3CRYK09m3vqwW
         fMOG5AtsN16o/Tx2fGBTLjukOj7wvGXB+dFqfOazMQowR66Fo0kOWnOaUYFhpJ/tDl9z
         HebMu/MCRMKbodPPI1a6pbLsdmohuelu18rKPjHSOo4KCnvPciMlVurriUpzGzP6z29O
         Lj452b7Bjo5AAuvzeDl8HliftdFryzpSBbjQR1dHyGVSNUWLQsBmzv3+j+EG1wbsNqll
         2ew85w4g72dJfXn5/BFJOXJ0wu05d6pSEL88W256BIiEmJlZ5aC345HWcMprnpXYIG9L
         f7QQ==
X-Forwarded-Encrypted: i=1; AKwUvByN5B3aoAQkZlXXuwc6PGcibwnUimjo6HDAjNpfc+k4eY2QXMIAZs7gab6cBHYguuAaXEwXzsA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEYb5Z2/oO7JTx1OjUSjZItCyZrCyC1s4t2wfqMkGo9EMgEi0Q
	AmD56kiWCym4spUDiM/aDlSPj6P7rUa1lQmLdllkJYItHZG6al4Ocem+
X-Gm-Gg: AYBFou13Ch8eJup9hhuWHNnJUiF/NUUhRbtPeXRw+sR+hSWxinejqnXZJmZ6cQTw+H8
	A/+TDEJXnLKR4b6dGsknDm0EdkafZQqMJW0ufThQ2IpsxYnO1Owexte7COt4s8vgz3x8TW805zx
	Sx8CkMmYTMtTUrMvPSrhmad56Aom4Diole8eqKWiVKoCjlm3kHbaHSC4DJ6A+jPbiUmdD2nHvY1
	0+nH4yG5PcuFVk+190I73/GVtk9/74jcqlx2dlc0xVm8J0paCF8aq0Yql/ImeeTybCQkOGZNcK7
	AF3d+e49c/huGjIVYEbf6i+OjSDlPIhgBLkJsYPAMWPg4TlzQPQ67ht25nmhxWbtiU6f8OVBApZ
	1EnZagDKHNSA+lDHONJ7zSlQ4xPLUNM89lBaZkVdlNRw91aOIwk6+M1AltkSwTjsXNJ8A0LBMHO
	eRuglUWHe57VBqeHC3Go3CCWh2vyEuzv0WwyiQH/lgoXX5kxz/rIG9qTmtJyI81N4uxA3+pSoHv
	KZSqeiu2RFkTRvWCTq+4+sHJ72fh/LH735WzAMcE1nMKVGVsFM=
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr102596995e9.7.1792687001668;
        Thu, 22 Oct 2026 09:36:41 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210299910sm8263415e9.1.2026.10.22.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:36:41 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
Date: Thu, 22 Oct 2026 18:36:39 +0200
Message-ID: <20261022163639.2566945-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
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

Commit 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in
DEL-IP processing") refuses a DEL-IP of the transport the ASCONF was
located by, so that a later wildcard DEL-IP cannot use it after free.

This also breaks the single-homed address change (RFC 5061 5.3.2). The
host sends [Address Parameter L] [ADD-IP S] [DEL-IP L], the association
is located by L, and DEL-IP L is now refused. The sender never gets an
all-success ASCONF-ACK, keeps src_out_of_asoc_ok set and stops sending
data, so the association stalls.

Fix the wildcard DEL-IP instead: look up the transport of the packet
source rather than reusing asconf->transport, and clear
asconf->transport when a plain DEL-IP removes it.

Fixes: 9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP processing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 net/sctp/sm_make_chunk.c | 15 ++++++++-------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3150,9 +3150,11 @@
 		 * packet MUST be deleted.
 		 */
 		if (af->is_any(&addr)) {
-			sctp_assoc_set_primary(asoc, asconf->transport);
-			sctp_assoc_del_nonprimary_peers(asoc,
-							asconf->transport);
+			peer = sctp_assoc_lookup_paddr(asoc, &asconf->source);
+			if (!peer)
+				return SCTP_ERROR_REQ_REFUSED;
+			sctp_assoc_set_primary(asoc, peer);
+			sctp_assoc_del_nonprimary_peers(asoc, peer);
 			return SCTP_ERROR_NO_ERROR;
 		}
 
@@ -3165,13 +3167,9 @@
 		if (!peer)
 			return SCTP_ERROR_DNS_FAILED;
 
-		/* Don't free asconf->transport; a later wildcard DEL-IP
-		 * parameter reuses it.
-		 */
-		if (peer == asconf->transport)
-			return SCTP_ERROR_REQ_REFUSED;
-
 		sctp_assoc_rm_peer(asoc, peer);
+		if (asconf->transport == peer)
+			asconf->transport = NULL;
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
 		/* ADDIP Section 4.2.4
