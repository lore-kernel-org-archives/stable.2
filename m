Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E037A839
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434754; cv=none; b=uBeow/okwYSXM6QN1HcNsr2UsMJvRIv8QKXo0WkYz6v8pNMIlicq1MwXiVLExhuLpw5r5UM8Jk3Pif7a6wjJHJ/iqNeQnLH4Jt7n0tJIL+JyAmqA2vYs59wAGkU0Rc8TBN01z76rvOYJQl1bfiAlj+JR3S8qlzqAau3rhN+VAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434754; c=relaxed/simple;
	bh=0vLf4wsautSGPoindTukbpU3HzvGRz/8vbGGYbIW4Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiuI3z/gqDNORnlecLAyaAt6lEn/QxAgVUCTFXyLSgPjZSzhJfPcmX0Txo8riGaq2ToKN3IfT4lrEtm2lO1BOlCEYmb4c6qDHBTf0mld0STbEQ9OvpeVWl19+A9N8IUNYNhV2r5wB8A7IxlCA6Tk0VEjU/LIaZZ8OOBHJWzPNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUyb0VOk; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUyb0VOk"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so995336eec.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790434752; x=1791039552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7vjDxNGtx5H9Ua7b/Rh8PBSRk9w4/mM73r+TwEkNiRg=;
        b=mUyb0VOkxarFhTkKvX/1taZ5w/BDNwKB5INM+90jsjQVsiFT4AN5RyyY/UX5J9F/hN
         V6EGztJWCeIEMuqNQYy4sVoE1uf5XD192L6TP2R8wmTK2czRiJpHH50efnRqE8FWsSXc
         tP5tX1B4YKRjUYl3BsyEEh007S3vrhaXJKCeO3mJ1/87k/HdDmOhXm5+Lbl702H9te8B
         +c+hKtJH2ohgDi4kee7S7LIfdryq3tVQVO7/8a2ty3n6jCxP/jHB2j6dc+q9p0IfSjEG
         LME0IoC1g0BSM8i+fxPAHTKr8lBKgzQGeQlAMJhgUrCW67T+kvT8PYMn1+LMiLWisvv4
         o1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790434752; x=1791039552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7vjDxNGtx5H9Ua7b/Rh8PBSRk9w4/mM73r+TwEkNiRg=;
        b=A1YZYe+54X73X41EuMn4lMHVeptMTcCpFSetxOjMPF/EPM1qcHoOJ49q4zK+cNleRh
         KTTrXzqHMBEfJmKca24TJSDlbDuALZKR6ZyNbPA/JD925TNmuXL+c6p2/VtQtrFUCcCt
         GkqUy8oGNiBCXDd2tPW6HGfOzNH9M1LW92enuODxiRhwDK0WmfHqz1SOWAJzYBnmTEkQ
         9YtPoUX3cI20T2C6cegyrmYBWPd2cjmutTuFpKKFQiKQVN9wAIMRCIZjN6IoxpZR6j28
         odWGwWzXR3BLSoFVZT+uG+Ox0mbfcOyTzQZ9M7OiK4Uz3fHumY96/vDf5mdpseXUusKq
         wY6g==
X-Forwarded-Encrypted: i=1; AKwUvBxtV6D6crnaJiVKpaIggM4pXyaflOa6FU7w8FE/6jxjFe4cSa0yGh2Tnm3jjdzZ3/FjExtiHBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+Q+nWVib2gYthwJwsMJSkkdXGhvcDqd3rSiQ/iIujwu1mzTfO
	RE76jyM56g229ceMFzkDRzUlkuFJ3kDEMGMuhwEdk78zw2rh8VJKKnIi
X-Gm-Gg: AYBFou3HFHCBjZpTnC6tFKmOcvuzMeTpNS/goZQIRcgromW5DDbXtYewYn0Z/aQg+VP
	ZHP60yyQPz3RmQKzcegBzPr6bl9hVdLSvJwnYkV5gfUISmvUdJaq6/1cbZY/2boqSz2WIsRy1Cb
	vjk47+JDW0xsmDS2o7x+DooES64Nnk+WmquCKBR1TvQ5tGRs2dCCFpPcK6ovMOP+398Q4zwXhq7
	ggHg1oABRSNjpG78BS8PnvGUFPcS7bnHAXHXs5cr/be7fIJ8FSpql8cvcCJhXEVWfj5eWkJz1HH
	ogPUbM/+uElBa9HZ+jWnYQOmmRNt42LT/o8zw/xynqqoldy5Vl+Wxvox6AxvvqRXcPS8eBeCOge
	BkyHZPFOWNUqLYW2LGXUCqv9SaQHZotNkj0uFgSvj+J3NkwmIRwRss5xB8CK7taDDARTj/C9HoK
	9FWyceBWs0aSbHQe7rEPmPeD0UewDUKrxOwqUlQeuzZmlc0OuiduRYu1TSF6VhcKw5gZG4Icmlv
	vRDm0oFqm9+ZuEgyw==
X-Received: by 2002:a05:7301:4301:b0:343:311a:372d with SMTP id 5a478bee46e88-343311a386amr2050888eec.28.1790434751423;
        Sat, 26 Sep 2026 07:59:11 -0700 (PDT)
Received: from kernel ([103.219.206.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm14171312eec.28.2026.09.26.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:59:10 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: herbert@gondor.apana.org.au,
	ebiggers@kernel.org
Cc: davem@davemloft.net,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: x86/aes-gcm - fix always true check for last AAD segment
Date: Sat, 26 Sep 2026 20:29:03 +0530
Message-ID: <20260926145903.6061-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gcm_process_assoc(), a segment that is not the last one must have its
length rounded down to a multiple of 16 bytes, as required by the
assembly. The check for a non-last segment is `if (unlikely(assoclen))
/* Not the last segment yet? */` where assoclen is the number of AAD
bytes remaining after the current segment.

Since the conversion to the new scatterwalk API, assoclen is decremented
at the end of the loop body rather than the beginning, so it still
includes the current segment when the check executes, making the check
always true.

As a result the last segment was rounded down as well, causing some
avoidable extra work: an additional memcpy into the temporary buffer and
an additional call into the assembly afte the loop. The GCM
authentication tag is unaffected either way, so the self-tests pass and
this went unnoticed. It is purely an efficiency issue rather than a
correctness one.

Fix this by moving the assoclen decrement back to the beginning of the
loop body.

Fixes: e9787deff49ea ("crypto: x86/aes-gcm - use the new scatterwalk functions")
Cc: stable@vger.kernel.org
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v2:
- Use the correct Fixes commit and cc to stable
- Change the fix by moving the assoclen decrement back to the top of the
  loop body instead of changing the condition as suggested by Eric
  Biggers.

Link to v1: https://lore.kernel.org/all/20260926040614.8683-1-raizudeen.kerneldev@gmail.com/T/

 arch/x86/crypto/aesni-intel_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index f522fff9231e..1903ed8bbe3b 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1293,6 +1293,7 @@ static void gcm_process_assoc(const struct aes_gcm_key *key, u8 ghash_acc[16],
 		unsigned int len;
 		const u8 *src = walk.addr;
 
+		assoclen -= orig_len_this_step;
 		if (unlikely(pos)) {
 			len = min(len_this_step, 16 - pos);
 			memcpy(&buf[pos], src, len);
@@ -1320,7 +1321,6 @@ static void gcm_process_assoc(const struct aes_gcm_key *key, u8 ghash_acc[16],
 			kernel_fpu_end();
 			kernel_fpu_begin();
 		}
-		assoclen -= orig_len_this_step;
 	}
 	if (unlikely(pos))
 		aes_gcm_aad_update(key, ghash_acc, buf, pos, flags);
-- 
2.53.0

