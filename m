Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1814378833
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821375; cv=none; b=sWlHo1F33hBDFMeh1VcYx3L33Uq7DREw8EGYKTH92gaNQI4Aq/Arddrv9LeDICXPt+4fYoaaGsRMof/39uNQ6/d9McqnkDLGT7WOsvVqmbXC+BTp58gsNZqi1F7IALbxhLuYJIGHlUSYC0Ucq2uXBhNWpzz1DDDRnXVYLFIB3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821375; c=relaxed/simple;
	bh=99I9WI10yhgdycaYQdOR7KxDqwzWqjCnddeIITPX87Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohoU2Uy8siHItM7aV7Ekc0LhdrsVqdtDYDbvl+HavpPoZKB9n7Xq544T28zkqn0BxTIf0L8LdlFJaMhE9sUQpdarGVU7CS4n8nwMslr1xsbT2L6MCcTDcA1Hi2fSOrQ6WxEr3lBKNmwRTHDE7uMhpMEwwXLTcYgNdehaRmDWL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeKobOYt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeKobOYt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d049069377so35635125ad.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821372; x=1786426172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhvTHN2T2zF1L4JuI+XVqt6JmwKsZDHz84ZkqvimYzA=;
        b=XeKobOYtTH+RHrJuJq0oYPSPcNEoORZrP24bovlOHSXGTiMI/LcpsCa9xJ6i+Fy+UO
         SRsJwTi2IuFatNYh4urOnCg/OtzSip0TI7xcZL7MDB+mkIfQh9IiIQBNeTDeQj91+Ld1
         7yD6jEHwwGXjYtVqmXkBcp5vUSnal5Zew92bvgchclE4F1wjngs1/5QrpIoSdaGvPKBR
         a/XUyhYB0V9a881h5dzBvcNDdbgHoz/cXrv0Qln8066+Ir0KVsf8/6XGaMuhvjvriBzU
         oseLj+OtJnoGAFooMJyKHLbehVS1SWOqy75PlbTGQBWBwx9u9rpQ2P3v2IEzEGOKxho5
         EpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821372; x=1786426172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhvTHN2T2zF1L4JuI+XVqt6JmwKsZDHz84ZkqvimYzA=;
        b=iyzQ/B053PVM3UIJUYZaKH3oX0DoinVECbKbcPN/1p76dSTpc2cqsfA4RinucSyALY
         eaU5MC5RKX67aflvV/p+3ftN/hVHaoUtXE0PHn994i/26JKBk7uthS7jAsLWLXeQVCtY
         yS4yS6XHlffoNGD1L8nHaMXLL5FOabgoTi7qCT5r3+4xEHMW4sA6ILGS3s2g1HF2Z/fi
         +U8pxZH1Itiq79k4/cLSXLC0aFuXKhmOBR+omld4cxKS20wsvqXIwEA67bDQOPx0twJb
         j3qcAfnhFxe5Mak24GI83ZvSgaS6lDCrHQgA8mse3j5TpIquLStYR0loW/0N48FpWPYU
         /bGA==
X-Forwarded-Encrypted: i=1; AHgh+RpZQDdsXUOd/YSFwD8fsEUJdDne0GFr4/uesCglH3CYkQ8Lfr0fBc/9PkZfrG718a/PKlnqoDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyApISX3PbtHFfKv3Iwa7exvE4dpXj/QExWKUm4N+ZsqpHsj808
	9uxfdIc2qzkXW/oRLG59epeIO3RJugRInyJmyQbhQFq0oMBfH6o8to/P
X-Gm-Gg: AR+sD12PgKB5dCzSvsl2qVFqrZYKUn3U+mSpeFiRqK2n1gNpXqQo19cMLZjta/28bE1
	eifLCjHjCvPIpl6aPagE+bzKg6Lvm+rd5W8O4vwUD1G553HnEtLXzSvlz8xAGHGptNDrJvSmmfr
	EOj16Oui4b9z+jSXK8BMSGhQVqrgSxIMnnM7xky5c1wlvt+DmRe/VDyl/y6XtDLeqsBqk8Ic8NW
	kuaJ5wgMoXlIsGoivv0wDrckDoHYCSE4gPCG4eBzWOeoAdjloXi6RUNqTM8G55wrHcB9GW1v1uV
	+r1gNpI292lVxx39+Ptzat7QBx6i29L4GIl0Qr0eIG+FYltxlxdnXsiP/fD/tvfRmyARJbCDkEw
	gg3AWHbCdp7hAAUUiuHDUj4gAhhFmWKAnNIb6xyyUyXPMwI62Q9T/iEJZ7d30WbpCnNPYscjW/q
	yO9DJUDrvh4PF3OXCee1/V7AiHGk7InhJZjy8LcQ7hmGkJXMOew9bYCGMDr9/qhfpd771DWyONY
	n1igO1SPLOMkB3+L4Tq2o4WPV2Xpu/6BA==
X-Received: by 2002:a17:902:ecd2:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2d0523be26bmr118407965ad.29.1785821372144;
        Mon, 03 Aug 2026 22:29:32 -0700 (PDT)
Received: from anna.. ([114.70.9.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a904sm47056345ad.20.2026.08.03.22.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:29:31 -0700 (PDT)
From: chanyoung <ppoo1220@gmail.com>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	chanyoung <ppoo1220@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] tls: don't leave a full plaintext sk_msg ring unpushed
Date: Tue,  4 Aug 2026 14:28:35 +0900
Message-ID: <20260804052837.49015-2-ppoo1220@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804052837.49015-1-ppoo1220@gmail.com>
References: <20260804052837.49015-1-ppoo1220@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the copy path in tls_sw_sendmsg_locked() adds the fragment that fills
the plaintext sk_msg ring, it does not set full_record, so the record is
left full and unpushed.  A later splice() then adds to an already full
ring: sk_msg_page_add() has no fullness check of its own, so sg.end wraps
onto sg.start and the ring appears empty.  Fragments added after that
overwrite live entries, and sg.size no longer matches what is reachable
between sg.start and sg.end, so pushing the record runs the scatterwalk off
the end of the scatterlist.

An unprivileged user can trigger this on a loopback TCP socket with the
"tls" ULP attached:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:memcpy_from_scatterwalk+0x32/0xc0
  Call Trace:
   skcipher_walk_next+0x1d1/0x2c0
   gcm_encrypt_aesni_avx+0x1e9/0x220
   bpf_exec_tx_verdict+0x3bb/0x860
   tls_sw_sendmsg+0xa1a/0xca0
   __sys_sendto+0x1da/0x1f0

Set full_record in the copy path when the ring becomes full, and push a
record that is already full on entry to the sendmsg loop.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: fe1e81d4f73b ("tls/sw: Support MSG_SPLICE_PAGES")
Cc: stable@vger.kernel.org
Signed-off-by: chanyoung <ppoo1220@gmail.com>
---
 net/tls/tls_sw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d4afc90fd79..d2e399be8ef 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -832,6 +832,14 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		if (!sk_stream_memory_free(sk))
 			goto wait_for_sndbuf;
 
+		/* open record may be full if we couldn't push it in the last sendmsg call */
+		if (sk_msg_full(msg_pl)) {
+			full_record = true;
+			sk_msg_trim(sk, msg_en,
+				    msg_pl->sg.size + prot->overhead_size);
+			goto copied;
+		}
+
 alloc_encrypted:
 		ret = tls_alloc_encrypted_msg(sk, required_size);
 		if (ret) {
@@ -921,6 +929,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 						       msg_pl, try_to_copy);
 			if (ret < 0)
 				goto trim_sgl;
+
+			if (sk_msg_full(msg_pl)) {
+				full_record = true;
+				sk_msg_trim(sk, msg_en,
+					    msg_pl->sg.size + prot->overhead_size);
+			}
 		}
 
 		/* Open records defined only if successfully copied, otherwise
-- 
2.43.0

