Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13731126C02
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790409738; cv=none; b=jfviGAT24zftWGe1uJirRpNLUFVxJG3JeEYss67YEsi68aDvnVdl4NFILwJPPCJSCfDyaUa45TiepRE6KxEkRy/y7zrUA0I+1hygD2nn9z2Vd0wCXLSnr12oIBNvh+mNrvLyl3b1UfNjjeFX+ImXlGHOEK/6+xKKeM9WjNBVozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790409738; c=relaxed/simple;
	bh=JO526X/6Tt2mXMMyzxnEn8I9inabf6bHTO7ljFpjf1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4okUUPwDzk4MI6J3N48gNZMMSaFja3BkHLS7DIEFqlLnwb9D7U3DLibmaTHcouc6EUSL2FxueUfEze17gr14GBcQ8Va9V25fq8ScNEcG/SOUi0HGeWBGpb5iiLQcTEyeyjymSAUPZsK1nxppjUVFUAVxdAiLBK1Jx1OAXAA+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnFKI6jf; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnFKI6jf"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dadso602079a12.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790409736; x=1791014536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1QOIpORY6Eh+rWA+8y7RMDhGXP2bTeo70K5JN02r+40=;
        b=MnFKI6jf0N5lYK3hX0YnOUPgn1wKgd83/PcYHxcApRIg5thxrRjluqGmtaUR7M2756
         no5lwoIYRPf5byniUNe5S8o2JmmNtowYKF9vMDhNv0kDhHsfTPkI9uUHXH2e15xKENky
         qryZ9s5yWirA3/c+6+yfMDn9tMbbNcNsWnUHiAgiq0jwZTKY8GpYNorqP4WWpRjaeTS5
         nRRXgDjjB3Ml5cBTD4Dy9YiHg/kt+CnJo6trVvsDgZd6XHONy9K6sJbiXJHfk6oDH/8n
         WWIWR3QVgnMoSxqEqSy8lmKvEg90QEaeORYS03emrY5Afm29flpygz6CPkLJOYVlg3wN
         FygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790409736; x=1791014536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1QOIpORY6Eh+rWA+8y7RMDhGXP2bTeo70K5JN02r+40=;
        b=OD5bD8DDZS4ZRDoRb5ZW4OC/rY/xrnHR11NFMDhrxVRVqgSkcQdfFAXR8dnlLW+ORQ
         iwo9JAlV8GHy12tmrEuZuA4gxqrS5ZBE5O1L/G8lCvAX+PWQp1D0JbVC5TPqtjdSVaCn
         0KH0kh8qZGk5kYGmxTQlYdaq4cCpWApbD+O3SWbv71Rpe3h7HK2xV9eTmDzxHZkoaWU5
         kT89E73P3yi7/Hc8V+fPtlGmPTwIDUKjnvgbk80VhZkIY1RiXgxN6PpHBYUUWaGUlk/+
         rKx11ux5evDfFtKvyaxVL9V9zVorr9lBw51RPPcoErUZf5qte+SjhLFuFiBVdeBUhvmS
         waWw==
X-Gm-Message-State: AFq9FYKtFR3LOqM2DOJmutfr/RaeLcxqYKhVJPS5VN5wyjKEgJcnNgXf
	GX7G/1CHQD34bR1nxmdrasbMYUyBCjEa/BrX458nXIK10hSLeHBpHGJjq/eKnjMoyAoLZw==
X-Gm-Gg: AYBFou3/KFBY6pa1RNSU+Rrp07sYBFohOLVMwTG+KYhmE/E+80vBdfSkvXQagImIviy
	vRGpM3AbSrM3mP5wORJhDaSUxqA2/EmuPmgQIP9WeONA2vrGchXHfXfOa9olCtT+XnDBMxsH3qF
	pLEuEUEGL6Kp02tPU1qt5d/bKLlb5wE3l2nbCUVfh2vvfHHcKqGJkXlLrhddSVds93cM9emNhQf
	g2KzH9nekBpSnsgAEY8fOoVoRX/wYZKDozhoJ0U9GdnfvsJIe3Aqz2SCSy6D7zIUoOipyT0OgNI
	oCslqiHV2GeyAHj7H1bYna/KCYYxeDV6W/Sk4Dl7/NFVSrapMtKxWSqjP5tDAxdjs2pPfGXz4Ey
	5qlwTno71djHQdi5q0VUtO5T3atdUo5PfYhJ5aYgp252JyoDUZ943Ov1P81ionBVg+imrmOnrAf
	YzxyYvKkwG3kOnRKNPqzPo96VuzhAu9umH3RHPSXZY698bfd29RPYX4yh2WjIkKxIp0y2bJ/Cv
X-Received: by 2002:a17:90b:3b8f:b0:3a0:e76e:ae10 with SMTP id 98e67ed59e1d1-3a0e76eafc7mr518174a91.28.1790409736118;
        Sat, 26 Sep 2026 01:02:16 -0700 (PDT)
Received: from localhost ([101.126.46.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b998dbf2sm8709168a91.12.2026.09.26.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:02:15 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: zhangdairui@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
Date: Sat, 26 Sep 2026 16:02:12 +0800
Message-ID: <20260926080212.1671197-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The decryption key for an encrypted request is selected by the
SessionId in the encryption transform header, but the request is
then authorized under the session named in the decrypted inner SMB2
header. Nothing compares the two, so on a connection carrying more
than one session a client can have a request decrypted with one
session's key and executed under another session's identity. Since
encrypted requests are also exempt from the signing requirement, the
AEAD tag is the only proof of session identity, and it is checked
against the wrong session.

Per MS-SMB2 the server must verify that the SessionId in the
transform header matches the one in the decrypted SMB2 header and
treat a mismatch as a protocol error. Compare them after decryption
and drop the connection on mismatch.

The check only applies to plain SMB2 payloads; a compression
transform payload carries the session id only after decompression
and is left as-is for now.

Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
 fs/smb/server/smb2pdu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4cf7083..e4cfbe6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -10890,6 +10890,22 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	if (rc)
 		return rc;
 
+	/*
+	 * The decryption key is selected by the transform header SessionId,
+	 * while the request is authorized under the session named in the
+	 * decrypted inner header. Per MS-SMB2 the two must match; verify
+	 * that here and drop the connection on mismatch. A compression
+	 * transform payload carries the session id only after
+	 * decompression, so it is not covered by this check.
+	 */
+	if (((struct smb2_hdr *)iov[1].iov_base)->ProtocolId ==
+	    SMB2_PROTO_NUMBER &&
+	    le64_to_cpu(tr_hdr->SessionId) !=
+	    le64_to_cpu(((struct smb2_hdr *)iov[1].iov_base)->SessionId)) {
+		pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+		return -ECONNABORTED;
+	}
+
 	/* Drop the AEAD authentication tag from the inner RFC1002 frame. */
 	memmove(buf + 4, iov[1].iov_base, original_msg_size);
 	*(__be32 *)buf = cpu_to_be32(original_msg_size);
-- 
2.53.0

