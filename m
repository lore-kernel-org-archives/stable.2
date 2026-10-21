Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549226;
	b=iQcShsenu5Jlnh3pmEaGqhlwAhbZmPlzzRuofXMENwgUak4ssnIZiTSH2KFdfg+jT2V/
	 Fy0r8Wvp9KFPv/S4XyzdMhLaeC8eWZRDx+bprDwhGB+DHhAfFz9ZZHkuCQJn2ZTi0AvCr
	 1K/JS56STT6FPQoGlLsP1zgjh3WEAJp+IHOap+omiwiojhKdVINhlaL1FkaOJ4NlHfHBD
	 tI8Dud+MzJCHYwsGLV73ntlIM0YU0QZKcYRjYulvqmfYkUv3OUXfg/sTUTczHdTXI/lZm
	 /xWdzSkeqBnSeQxAsJGcmd/8t4UTEZH3p3l1oc1L7fq3x2Sg/S3Vhm3RWTMrIMbAk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
	b=XYAzX9yOI9a24Z3pxeunwT8+WMBN8i6fyeDVv+sIxJECkZlKF9O8KI3QG/pPxhlp/LAe
	 DlZooF9xA0IUppur4YhxZVCG0uPB9oLlykxYLFcvQoNX0IscuIzD3iR5mvvcBQuO+taiT
	 1c3j9fK9gUYy1pWk2TZgzBnp1tVxloE+2qE6feoW2FDhkUB1yTkVTc64JZDcI7KZlh+ak
	 CLNF4fzhosJXPq7hyzZD++iyQNtE7XXP9X8lwN9giX/qBxhbJAhN7mp0S4lAk0tj7B9Hi
	 kPHDjfKX0nLbbVCgImmGQKDgoA1cn8vHtgD0mYs9D69VQpa1rJ/MI0q8G97Iyy/s30w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtGhLxtH;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C1606A323
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25C1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtGhLxtH
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso1307895ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549225; x=1793154025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
        b=mtGhLxtHMUFPemGwSfIV1NL33M11RBxtFzcOHulj34SabBPdQXFIALEwlXrhDDBP8u
         SmWPgpNEZvGL2uAl6a9uximQp88MOK+j7A6fgv/JTIlKjeqWOx6anRdd6W+gJmKXzjuw
         Mo8ZiDgqmL8mnRwim9BkDtjYYqHZGIfpQFdyvLzpltu7NTI9ZspJYEfDo4qHmUsV0Xz9
         YFpEAPLXHs/smb6KgefJ+d1RqZsbjE5FgqPmvQYZZy8sd7FoG9JIw5vr0mg+CQ794E5K
         1uDci0Z7HcQ1JCKajfyvtQFLA+LoqqE64VfRe3WBh38z8U88pwWvSrZoOnPoyW7vKE/o
         hmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549225; x=1793154025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yos1+3QwUjrDuAOazo5OswZ8Efjv4lBkArOWfigb8n8=;
        b=lwD6UdWG3/z+3uYGtzDMiXHghYPzxvapONcT24jhhy0Gd1agq1EPKnhCoSAVsUzslZ
         jhlE44P/MK9UMc97eRIcMgE/dksB6WVFzNMJguvOzAWjB2GaLwIsmL5P3RHmz5TF3U/9
         d2IRRxRJN8xIthEwPK0P+Rl3Zmp7miNoVEIRm6iqeXbdD0qRa7TXttEAphOyEKrRc/n3
         bx+BjjAtpCH3VgampZlssnHKLUsXguLR/H5/J21TJ2flu/xVm0QOt5LuCKFYiZ1+9/MN
         irpQSY1V09gz3l3j6UfLr46V93GP0cE62RRLL5jP+widtxoIr8VjdaVLEnYWUZGATXdc
         vWig==
X-Forwarded-Encrypted: i=1; AKwUvBz+5xxOIsUjci7GwJ/LHx1XM5DNZkrywRh00tjMIRH5AVMg8IA7ma/s4jDoFsvcLrU1N1z4SOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVwZSGOPosxwDA9rtVCO//M0eWLaaOP4UqrBHtqZYcF9CdMoIg
	4wlRvwEcng6NriN40Cn+vYexkviWtaQDHmKN7HX/SUnkUe9/sXzFEvl6
X-Gm-Gg: AYBFou061zLqOs/ef91xuqaxar94ICt0g/oY4ZV10MYF8y1JIWk7I07+bsxAxmzRZa1
	h6MypUY6r6zs1sHxAh8ZXtq5SVHsDI9/mO9HLotzG95hsVdUfsZPahvh1aAhZAFOeDSgBb/YviG
	0HLhLlT+oYyyVWH0AWF0bGwqXHN2qbzy5LTCGdW/qcPypR693cO59Tzbx3EgAHz1UgnZjgB4vj7
	ShginnVv6TT5Av5XOOTgN1v1pyk2E2QtDV584qXsrXNRATH6UI2mS2f+ZJXCDezKv1DF7SzmeGy
	DigtfvzGnL5Q6JGGx/MXoi9inrN/6VdIzwNzjpUO4Y8hAIBcK69oqbfhBFEpBf05gGkAy4WUXGd
	jH8QLQ8OHZr9slLDgOxHuNVLDnDReMCURm49Qa+hj52bb34TjnQmXDvoZnOCawbzTbxFtBad9/6
	DODDqM1aEePtiHsvv5eFMBjiQxKIKcZT8mRZvl4nbZRX8mBDBtP+x79nAvxsRPQKPznO/bAN2Cw
	UgAM1vxafR22AdCsvmFPzu3zynT0nmOCda60iyKFN/Dx3ObZZKNzg0ewDVYbC6V1Bi3Ba7N
X-Received: by 2002:a17:90b:39ac:b0:3ad:85fd:711c with SMTP id 98e67ed59e1d1-3ad86ce82a7mr635334a91.28.1792549225142;
        Tue, 20 Oct 2026 19:20:25 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm1979077a91.7.2026.10.20.19.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:20:24 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] tty: sysrq: reset the per-device key state when reparsing reset_seq
Date: Wed, 21 Oct 2026 10:20:07 +0800
Message-ID: <20261021022007.1717207-3-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
References: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented.  struct
sysrq_state is allocated once per input device in sysrq_connect() and
lives until the device goes away, so both accumulate every time the
sequence is reparsed, which happens whenever the mode 0644 reset_seq
parameter is written.

After writing 56,29,111 and then 59,60 a device keeps all five keys in
reset_keybit with reset_seq_len 5, so the effective combination is the
union of the old and the new sequence.  Holding just 59 and 60 counts two
of five and does nothing, while releasing a stale key drives
reset_seq_cnt below zero.

Clear both along with reset_seq_cnt.  Also delete keyreset_timer: with
sysrq_downtime_ms set, holding a full sequence arms it, and it is only
deleted on a press outside the sequence or a release inside it.  Dropping
the old keys from reset_keybit removes both of those cancellations, so an
already armed reset would survive into orderly_reboot().

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 4fd5b3ace9c40..bb202fc1ccf0b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -691,6 +691,15 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/*
+	 * An armed reset belongs to the sequence being replaced: once the
+	 * old keys are gone from reset_keybit their release no longer
+	 * cancels it.
+	 */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < len; i++) {
-- 
2.43.0

