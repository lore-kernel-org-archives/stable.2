Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099568;
	b=P7OJt8kQ8vTjtF0D1ROmNg+fWBAIr3QFAoIepbV6o00v2mbCvPjUSaT2LlYjfithydMg
	 bfocvv+TSMmMrMdZY+1AS/n5sv554F5HXX7vjwXsgFjOWvYZqoMwc8EE4Xy4alofwsCd7
	 0zdBbv6B6CigBY3nMgPS0+950PmCWwx5kr/Zt2DEwb8rrCjTIX3qrXewMc7Xp/DG1VJG9
	 hb9EGqMEjtCnq02WQlrllEBEgA0kyFk2D26sklS1esU6GLfYbyaxEhZxg3EeVlEC3gKXT
	 JeKgme0dwrhFho6OnQ0jSv9oQuiKl6Hs4ogHx4DDEY5OO9Ws3DFiyXIiKJM3R2AIk9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJa+BAJ5ls8qNQp19xprXvh/jhBS4rsJ+TLQrB6w3yI=;
	b=chrDg4seWWzFuYVUsPCjg/bHthgP1GscAOIlr9Higd6RM+C+t9hN6dKy5gm8hnsWPg26
	 0CSJaKCdG4qaDR40sxLCvGAtkhULqI/1YzYX1HFDxU+WCOykvkxK+5V4gI1wha5gfW/kJ
	 iL7YZUihDy8HlRQnyNbBY7g9lnRbSePvKoZUtrp37FkrcMIzjVzmBm0JhAVBy/CxvDKO6
	 5lQFFUakkoOOK6QPNFwz/HQhHo2ynpF0yeRYTcr7xMiEjViA0Xm5z4pCCBw09gI5c3TCt
	 GAtAXl0rtmcwSs3wMpIG6P+fvpIErO05kuGPKS9Y7I1h+lFKubMM5uTDH19AWcQ5ySw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yle2h7Dm;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3A606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF3A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yle2h7Dm
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cddee4abc57so771632a12.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795099567; x=1795704367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJa+BAJ5ls8qNQp19xprXvh/jhBS4rsJ+TLQrB6w3yI=;
        b=yle2h7DmKHSURwluxZyGpRDTP2SARDUKcw2L8XSCXEwiHo5e2yQsrojLEGRN9U5TKH
         MOsdiL/6k/MPZ+ANt89864EjULdhYQgs26QG3DBIoRORPatWgchIcydz2CMKCjP3rDj0
         Q1mLQDpV4raBzEok73E5H9eAMKcJ4J6FqbxX8/xM1JgpA7w/+hMyiOthjEzqtwVowP04
         xdIaQV8BvTjB+pW8hfz1K1XGiydG9BAGwxA5F3Z7bPkdbC5KL8qW+NZHtn00HlFQxK2S
         r9V7c741FmEKrIKzhAMapFit8cHtd6UaioNPyWx/FmJh8MHb4UGOPjo5RHZhoHwXJorM
         F8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099567; x=1795704367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJa+BAJ5ls8qNQp19xprXvh/jhBS4rsJ+TLQrB6w3yI=;
        b=WGc8+uqDAdkBE4g+wcPyNvacPsDzK2g4nOF3b9LcQG6MpD+M67Elf/KPyy3vaOyaNp
         L0ptx3+pPPFWTueCOoJ7ZQ6lEewrLM2O8wBTtIfywPAFaK56uO66q5sUyk5Lp5JzRFLH
         lKf1nkJrDc+9WOUdtHYkdmxz9ySUVS+rEUVcd/FOGRuxnrXG5UeMM8m3F1/r5X4OzvPL
         zClA1ueR0ZlkqWJNNyaMax+hK1mYOfmDF/XjOCoXFy8HdT1Y6grdfYEqCjyekcgjyB+J
         o9NwIGlqPJ5/cxVa6qdLwIBnE6OVfUPM5/z/GXKNgN2hogLRcBeX98/SoF+/WYxdjXId
         WWEA==
X-Forwarded-Encrypted: i=1; AL+hErHgDoEbXb42mDsLXPdEDRoLlmSXa0HzIrVMw8at6qTYdh9xpSlNzwZ65i4UNNcNMRHlRtzznPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0MEY/K8uzs3/bo7upEHe8naZzIo/4L1eOMNRgVXNMpnB9SaCM
	/oT4MOTDhVy8JUgWwRivbrAE6vnVPLN4B4zva7GzSvgRA3cLd6QlrbnN
X-Gm-Gg: AZFdTZfrER2KbpHqGRYqjzicItxp+4w94O1RLZ9x70imv/bnmMzDcZ/YBcjw4zYRZEN
	hl+1W8TmkR6hlbioAa/AuPBH70NvfWgoTxdECHlHP/GTFNNfjJPGgnlZNcC+ZbguR61VAyDxODi
	p7RgTLbPztpHl+Keh6qKkzb6GHgSZTqu/kkzL5lwZCFCnm8Y3z9YybhMwoHcN0W8E7V6nqJwqx9
	bN4mQYONVy8AUVU0zeCWJiYT+Z34QEII6y/JQnaFUya1PLxSSGgmDzUCc6aKX9pnMYQiu39F2Ns
	idpcY4Mslbt0qtSATnbZMeIs6YwF6nQsh/uHrGakqk7yucA6J0fVGT74j1QIxFBStDBLu5ONEZK
	zASGAxBf3afYqrhOJv3GRXm2QntkVGkkv/3egdVV1AkYaLvPwUeTJclbeeEwxBaiQrjLVeHzNCC
	O3NaHzQADezAjV8cINLo/bOMBeH7SDoE1Ju6M7hqieqARx7oG6M7n20Kuj3tmJT50qknEORxu0E
	t/A1/4GlcqddmMfanT2dQzF1OdPDA5bsHVeY30w7mb+5P/DXfepJh7W5wLi0p/uYotXwsrWuLrz
	KGOBu6uAJxWQE21oTTwdrtmhQx0+Kn9r5BOmTNBDjWw8yzdB1lW+VYPjZDFFfkXD241FmkbPGmt
	DdzwDkfnz1BgXXhvPDEUw0X7eQhHWTkyAgHA0ZuyEygXT
X-Received: by 2002:a17:90b:2fc5:b0:3b4:52b:4dd with SMTP id 98e67ed59e1d1-3b4052b0c72mr1925315a91.65.1795099566707;
        Thu, 19 Nov 2026 06:46:06 -0800 (PST)
Received: from visionx ([202.51.89.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm3283266a91.8.2026.11.19.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:46:06 -0800 (PST)
From: Vision KC <vision.kc791@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: linux-ntfs3@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vision KC <vision.kc791@gmail.com>
Subject: [PATCH] fs/ntfs3: fix check_log_rec() redo/undo region bounds
Date: Thu, 19 Nov 2026 20:30:21 +0545
Message-ID: <20261119144521.86377-1-vision.kc791@gmail.com>
X-Mailer: git-send-email 2.56.0
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

check_log_rec() validates that redo_off and undo_off are 8-byte
aligned and that bytes >= lrh_length(lr), but lrh_length() only
covers the LOG_REC_HDR header plus the embedded page_lcns array.
It does not check that redo_off + redo_len or undo_off + undo_len
fall within the bounds of the log record buffer.

A crafted $LogFile can set client_data_len to a small value (e.g.
40), redo_off to that same value, and redo_len to 0xFFF0. The
kernel allocates a 40-byte buffer via kmalloc() in find_log_rec(),
computes a pointer one byte past the end of that buffer, and
iterates 4,095 times reading 16 bytes of adjacent kernel heap per
iteration (65,520 bytes of OOB reads total) in the
DeleteDirtyClusters handler of log_replay().

KASAN report:
  BUG: KASAN: slab-out-of-bounds in log_replay+0xb0b3/0xe8c0
  Read of size 8 at addr ffff888009117228 by task mount/85
  The buggy address is located 0 bytes to the right of
  allocated 40-byte region [ffff888009117200, ffff888009117228)

Fix by adding bounds checks for the redo and undo data regions in
check_log_rec(): verify that redo_off + redo_len and undo_off +
undo_len each fit within the log record buffer.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Vision KC <vision.kc791@gmail.com>
---
 fs/ntfs3/fslog.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index bb8d40bb5..cd251ee9b 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -733,6 +733,20 @@ static bool check_log_rec(const struct LOG_REC_HDR *lr, u32 bytes, u32 tr,
 	if (bytes < lrh_length(lr))
 		return false;
 
+	if (lr->redo_len) {
+		u32 rend = le16_to_cpu(lr->redo_off) +
+			   le16_to_cpu(lr->redo_len);
+		if (rend > bytes)
+			return false;
+	}
+
+	if (lr->undo_len) {
+		u32 uend = le16_to_cpu(lr->undo_off) +
+			   le16_to_cpu(lr->undo_len);
+		if (uend > bytes)
+			return false;
+	}
+
 	return true;
 }
 
-- 
2.56.0

