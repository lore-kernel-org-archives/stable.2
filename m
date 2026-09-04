Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC804A8A3E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530739; cv=none; b=oPe4gAt3CU/ZyunxDgjDJR9ctCVUw1lv4hSfqB1aJ3v+aZkfC47qou9ExkGl3x7dldrDayfy5ZBem25KV4wjaFbB+Ex+vwSi8myZzqE4jAL2rKrrYcbu5GEX8Qf/2DvJ9A1s+LaFn6QsrS3yITG5ulWkYifi6t6xgoTC4etz3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530739; c=relaxed/simple;
	bh=74j3fwyacQITliuGsMZlTzpkrfqOUEWVeCXeNha+g+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwVC1Q8FP0li8q7sAETXrRW1gcGqiT4pl39qOuu+qKRakznQmd/1+P93EHBkMirc6j/vWD1TGGbPs7CzA4RmFb+OAMPA/Oit2p0sTpLWQtn7WRFzlKr9LmnJGRaqWFwLbI9w/CPJyHfkjWzYa7SStC7R3uv2O+CVw9klxmfEe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=S/aOp+/K; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="S/aOp+/K"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848643382fcso1098230b3a.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788530738; x=1789135538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Set7xBiEVWYLIBwmw99LbgzIL/a2lqsWrI9NiV/oNhw=;
        b=S/aOp+/KlipcPJE4avbEo+Qd8kMLK/sKuvTE8ai/yTh1MsPb9KKh9sSRaYkgyV7GKR
         EAevDulyr7dCvgeNZQWjfSIJUwO7bS4BW9U5Qy1YSq2fS8jf/15ylscPD4CELTldr3k0
         LUVeqx/lSyjZWxQk2ttPXXOcWa2k4FkefoebKqGbO7AVCFq9eFw4IkvqvFSFjS4LXJYO
         VRsy8EriuZZxgV8z1PcHMtA8YAKsUENxaFYv3pzy+GOmzgTgC1oFjlufkqeZMSmsm7v4
         PibPhvj5leqqxK+9wpOPfRFsCseP94Ff0ns54MByfWONlr9mSzOijVvhkyegVp1pNQ39
         e8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530738; x=1789135538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Set7xBiEVWYLIBwmw99LbgzIL/a2lqsWrI9NiV/oNhw=;
        b=i4cTmC8K7GrUBvyiljaPN32wHt2PISs5LFvcYigIfD8HLEv1+EMizDtD+gnUkM7F4M
         v/MsMhPpyINL9KYpsSbCVpcrRONxFVueTmFdXSlT3D0hsANR2clB+tH8HFosim5K+342
         jwC6aQ3XZrjPDnEAy+Xuw2n+o+Lpl6DW8mD7bHMmKrM3yi/Z0pz1TEq14lSUYraWdUQO
         jHxIOX9e16vVlKzZHZtru2YLUA0edxZpOLpyRMy9klaHUuP5pOFlFBqv9pCZ/lgZ5Sgb
         +ZP1vnNMY1zVFVtldTBZrTKETNZ7+s9/HTu45LwexUCnjbJAD4Qqmp3oZf+JugAbMlfb
         hytQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqNcLhXk4yDSYvZyXtsvCwRz33m3ia+VcPU4+dbVHVkSe8/hPcz+kgVEnoveXImvhEpPc1Xdc=@vger.kernel.org
X-Gm-Message-State: AFuF++mTKietp358q6h68rlSNRHDY/kVfQXM7mtgLf67Q1tJ7ejxFSXn
	wxspMz/4GOTo1abOuYem0bVgGwrSgwsi+EsVRlZKEyT8a9+wSSGXTB1F7u/HJDQ/f9fY
X-Gm-Gg: AYBFou2dZ6JQ1utpoj+xvtZqm9K1bOYNqCzjLcoD1wi7HXFzo3rAOBMFaOT/1goizF5
	FJOyNS1M4LfuoRJfdGYTm1Y9SQvMuvDSOFh4uHhqCx/dULfo7iBudKZQaZBf4ZyC5Pe73iaLW+7
	KsGX2uPltyym4EhM9VB+PjZwjDc716F7FskU8PDuh+BoTXADcDoHvYvXvOa212fuGm5iQwTwzH1
	uyfXMIyw2ckukKWSStDEPl39vAnZVzdhwMMV0pLmLWG1E2QYNOeiM2STOe5Fdp+HknnSmrvt5Xr
	mvNncF496y9f0v5x0ZcZmAQdj/K9MOYPbqadF1UkDO32KBO04x4vz3Wse2qwEPhYQvfU/cFcMXA
	fxS7WD9Taab3fGwLEpbWygJ2vLHxh97f3tKBycNQ3lW6LsvYTOjnHvX6BLieejyVSJfSGGYF/sP
	9X71N8Bqc6n1siQMkrxx9aYlIEAGSe90DJw8UK7A8l6G5sbjr3bzcXKX53/3EHO9IqO4os0P7ac
	nLGldGq6LRJYz1m6Xs=
X-Received: by 2002:a05:6a00:f04:b0:851:ba04:ca02 with SMTP id d2e1a72fcca58-8616a36cc48mr9997364b3a.16.1788530736532;
        Fri, 04 Sep 2026 07:05:36 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153e3ac30sm1165524b3a.56.2026.09.04.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:05:36 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Steve French <sfrench@samba.org>
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Pavel Shilovsky <pshilovsky@samba.org>,
	Aurelien Aptel <aaptel@suse.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] smb: client: validate POSIX create context length
Date: Fri,  4 Sep 2026 14:05:18 +0000
Message-ID: <20260904140527.62354-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788516372.git.zihanx@nebusec.ai>
References: <cover.1788516372.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_posix_ctxt() reads the fixed nlink, reparse-tag, and mode fields
before checking that the POSIX create context contains them.  A short
context can pass the generic create-context checks and still make these
fixed-width reads run past the declared data.

The current in-tree smb2_open_file() path passes a NULL posix pointer,
so this handler is not reached on ordinary open.  Still require the
POSIX context data to cover the three fixed fields before reading them,
because the helper itself performs those unguarded reads.  Keep the
handler's existing soft-failure behavior for malformed metadata so a
bad optional context does not fail the open.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v3:
  - Resend after no response on v2; no functional code changes.
  - v2 Link: https://lore.kernel.org/all/cover.1787486936.git.zihanx@nebusec.ai/
changes in v2:
  - Add a handler-level DataLength check before reading the three fixed POSIX fields.
  - Attribute the fixed-field read to the POSIX create-context introduction.
  - Preserve the existing soft-failure behavior for malformed optional metadata.
  - v1 Link: https://lore.kernel.org/all/eb1bc35611f91bd10a4772400b37fac26f660956.1782579150.git.xizh2024@lzu.edu.cn/
---
 fs/smb/client/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 95d862a1241be..e3973d331633d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2405,11 +2405,14 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 struct create_posix_rsp *posix)
 {
 	int sid_len;
+	u32 dlen = le32_to_cpu(cc->DataLength);
 	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
-	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u8 *end = beg + dlen;
 	u8 *sid;
 
 	memset(posix, 0, sizeof(*posix));
+	if (dlen < 3 * sizeof(__le32))
+		return;
 
 	posix->nlink = get_unaligned_le32(beg);
 	posix->reparse_tag = get_unaligned_le32(beg + 4);

-- 
2.43.0
