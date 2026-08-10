Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025E442B0E
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390834; cv=none; b=XeWotTM9aNdxBjCHtxvNNoD7A1lvRlCIGLniuow5IozP52pNTI2dW1RPN7/Ac1RlTNW/MrhqY9hvRrlQIvkmY2DHl1TsgXCd2pyfoCkV72ycWj95Rq5pwhSfoMzz7R8aV6GKZbkLfrpceN9x2+64bh6uk3wbr15h6mwkJZSm0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390834; c=relaxed/simple;
	bh=HHYWIbYZQXa9nFoSOde0y7v8SzeS8K4QFE8dQsCXdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX889FeuyQFpv0m3CT01MpmW8B/1o330UH74pyLepRrK2uy9J2m0EKVMAf8ah3i67CBKIlKLUcLSx05bfMcOPX0egVZpg+2S0NVe3xxl3rg1/ssRYPqNPc355GLCo0XU9lrihbAsLPARhvdFMLS2RBXepJS5TMn02WEJ5JnYmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aztu9krM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aztu9krM"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so222997566b.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390819; x=1786995619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMDjp/2Kph0Q/Gm3PYQzClsmsJVYRNh1rwgrPz5zZYY=;
        b=aztu9krMkzBKQde2jDf5M+Z9GZmONL/rsmIxCIp92K+m1GwhOqA9mUqXR2ISJ0qsO2
         veVkeUtncRX4ZsQFianopBEpU+2zWwdsHyOJWylGaAqOh0dKDtTyI9Es2Go5rX+7RJGN
         ycb1nMlo44ImZHsAJXmpgAw3uwPT4zIpSDfo+ZdKZZx3no5hH0RVv8OGlC1bj+IBViMI
         LS7Q6tZrY4dDVkRE38FmdfyZR6tS6tOJ8NZSdcE80PQSZ24j+RNUbx9IMdgw3A9JkAGF
         RfnPiALFYfMpx+HqIYmR/Ahtz0pScXjf3hAqMZRcOfe0cwGdMQSQoCfBhAiFIBz2QUP9
         bCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390819; x=1786995619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMDjp/2Kph0Q/Gm3PYQzClsmsJVYRNh1rwgrPz5zZYY=;
        b=qBmQxvIDMxCjEAYi183RfCowuS8m3YeW/WHlHwZ4oW7S2Azzjx18RSidAGvLF1sp/v
         B5yDwry9DgtqZW9sW4fOA/pm6bpHZUk0Dfx7jg3bMqe/MkacceZ0yO1JJdYYhtix8lLh
         7OX0VHlLiH/5+SgmH/0pxF50jXDVU0rnQRBr1rPxIqMqzLui1IMgJOyMyWt0n6Bh7/4P
         mH+xgd6BrMH+ys4Qvvfo2Gn7KhPE04Q8Q95k8bRnUMek3MDwcuBkRpY5DVhhAWc9ubwS
         2/qrntCeypwOrLYxfgDD/yusoai92fYyvBXc6ivlTKqqJnZ+M30mI5v6yiZEMZOFQ4NX
         jewA==
X-Forwarded-Encrypted: i=1; AHgh+Rp04l+PkFjxuQWJN1i5QYtGboSD8pDDiyJDq0I4BzUE8/x8gQGB5H/yohe0j3qjUwsrpZt8At8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWAwN5vG7WSv3se2zcfV45SARNryGueDlrATzVaVOxrWlJ6Fb
	kYeXReSSonzcgYp1hjQC5STub+ViWZmuwNRU+A6KJtsmLhwm8j8DjM4V
X-Gm-Gg: AR+sD13FyzGlxDm9oPdbbo9re9j+bhOB3pQP+GGQQS+AlOD2fNReB84ufNAjwHYoo6y
	qm0acEiRFVjQoS52v6KDRMbvvKZS4Xtbucq5JdrK9TpcDhBR+XbcpFrbt5W5M32fTeioMY9UZ+i
	PVS9Sga9zSwNtMIS86AO7gIWPUUJo8iV+grTsPARrI61qJf1d+OiQ28+xc02W2XKSEjyFF9R4lP
	B9dDbDa3rroJb7Y2fAX85tk8eTRqaqh0yFNGeDRpnCTSyWPpZR4ybfpQPemY0Vf4gYisurgpb1I
	bNYywQWzveVMzzyoo2uYg9GmW2If3Nq4Cb8yAcjYGatYGvlNl20GmfJdH804KKvmH+Rx+wZuhmX
	Fjno4fQMpadtglhIjKLpqGakxmgABEctSYrrU9fZ7yeOcpAd5dhiIp9w6olN7yFmb8gRbSRXSd9
	hjNdisR7xs51Y2EYiU1vYUvyv9H1v/S5+cwsMyatzMIPmsTO/FNKVkmBfSta4hS2ePwJNyzvR10
	P9mn9RNIH1GdQ4dtXzcLxeHvV1+4H0=
X-Received: by 2002:a17:907:3e0a:b0:c15:f4bb:e663 with SMTP id a640c23a62f3a-c20871dba75mr1097344966b.10.1786390819229;
        Mon, 10 Aug 2026 12:40:19 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:18 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	macro@orcam.me.uk,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/7] alpha: invalidate the local context in flush_tlb_mm()
Date: Mon, 10 Aug 2026 21:34:57 +0200
Message-ID: <20260810193902.3286353-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193902.3286353-1-linmag7@gmail.com>
References: <20260810193902.3286353-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_mm() has the same caller-CPU omission that was fixed in
flush_tlb_page(): when the target mm is not the calling CPU's active_mm
nothing happens locally, and smp_call_function() handles only the other
CPUs, so this CPU may later reuse the old ASN together with the
translations it still holds.

The active_mm test itself is left alone here. That path calls
flush_tlb_current(), which loads a fresh context through
__load_new_mm_context() rather than issuing a targeted tbi() against
whatever ASN happens to be loaded, so it does not depend on which context
is current.

The uniprocessor implementation in asm/tlbflush.h already has the missing
branch. Counted over a fork-heavy run, flush_tlb_mm() was entered with the
mm not this CPU's active_mm 2934 times, and 632 times while otherwise idle.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index a5a42ae4a7d8..988e397b0b8a 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -649,6 +649,9 @@ flush_tlb_mm(struct mm_struct *mm)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_tlb_mm, mm, 1);
-- 
2.53.0

