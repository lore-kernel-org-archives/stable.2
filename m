Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77443E087
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390821; cv=none; b=Y3iSvet/W0Zkm1yTq6uEga/gYIs6okwl0Oaf+URiAPGny3R/2B02wR7SQNXDC9vL4gOWVAg8MEw9wlRauLx2GeSh+0UQkRMx3UmE36elkinyoQHDMrPKUgeXedLHAhZs1ICXeCmehLSonAanCqnPjGG8W0i2Rv1wa7N7rqEWnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390821; c=relaxed/simple;
	bh=2LEh4N21WEQPtgsS/wklt177lc/JUP+Si+EuLT16XJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LabFpkoNfR+LG32rdctCIR4SFlpUaOz1Atm8aUozbmNLVkt0r93QOKqFFVkDKcI5RArUcBINur1G8D/ttND9B6Sgi2CUgskeiQQ4hrwHccgaunIPdrM9WBIS4bzu41VP32H4DUz/Iu/OAJsyhWGJBm1o4bR+1LNV6DtIrXbf3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgRp7vRO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgRp7vRO"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1670dad7a8so316203966b.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390815; x=1786995615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRKEDfsj3neRvHaPQAcC4yHGhjyN32qyFm0f+mmrXno=;
        b=jgRp7vROUkEtxTU2BcrmcGFPcb2nJO4t6WhS3WZ3yyXJ3YAPaDV4Qq/c+7YjH1jz9/
         CZzds5tkjddT0Eer5/kg+M7+79At1xF0azUA8XLTNGaCai2rz/I8bVYYRj7F5nN0w3el
         MImIiBuuklKGmmjg4z+EHwfHgSOn6lMf1A43r4OGGLmgjmv9apGJfy+ImpQGB1x++xfp
         t3WXUplrMtShwMeFcD8FscrgU6Lhl4BCqRoLP7xpIAf0+F22QVUozoNg91XWROLA3NYV
         S9qJDqkNmP/ywAu6uARxtKNE4HoD4UL3d+CCzdVAABdnIVE5Da82NywHdsE7DYl3Ywq+
         calg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390815; x=1786995615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRKEDfsj3neRvHaPQAcC4yHGhjyN32qyFm0f+mmrXno=;
        b=nh/D4gVlSjE3pnQhURQQUFfEp4fajHpaPJIShjCYpUzj3BiQXL+ogHfEKLACVc2VL8
         5L2xVAH9gN0V5qiaBY2E4N1nwR8EoVSTPJZi/keQnTjSpwbmCiBFbCHnTpqpyNKDQUfp
         IgOCazxnvBMGs+AJV+CPbXIw+teDIm8LT4xUiKsNw5x8qFpssg/RPuM9EnWISjo39D66
         73eDcn5azujZn01DtOcSGw0vmhqkSsqiN/hAoaRlfP5kzi8RBTot0xZpVVOsGyA9+EPB
         BgdYYl1qXrkrEa1/LsOp4SBzInV3zzzUYtuR54HHniEJ+pXi6STXw1/LAwL/wMcc/Hsq
         GSmw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2R+/WmKDYJcc/WQbIzI55FZAcbyaiuADnqZ9SCOhb2drSb8piaWUU8/82M5nBagSOZmNEjqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JpkMQ3AOd3leWFfnlAAVY8W1VsWBSwGIeSIRjb1I4PgsjkN6
	EkivsJy8y1rFqcl93n/JyXEjJGIBCefP5eeYNDU/9sgJgHaJSvHRwEjm
X-Gm-Gg: AR+sD12Uh+wG3FP/ltZ0Z+1snvWj0odxrvTn2CeY+3fMW46NBrodp9S/vWFWsb4I6dJ
	m6kaPG52CwapeMl5pdGREdEOqUggvmUHesqkJ7nOOJJ7SwFtL5CQHrTjEciGx/VgnvAKqYxB9BC
	kw59BICMyV8R5ivp4bmnXomvh/5edUXUzR8TnP9rxFlWjIeql/2dr1RALdHhbIQTMgBaAsvC/5P
	/RUSJODN2VidMX1CM8Aw0csGmy4eS1cnySZxNwqriRIs044DaaYaIVQFjCn5fwRReon4iLPusdJ
	fzLok4Fpy2dmpXeSlaaGuTS/dFB7Qn9IznCEQdhARFiGrLT3sVNm3wlwc7gTXmSYkibZMBjB/1Q
	+pE08/NuZaPNH/T7fUO3bbq3aTCXBM7l0BLxaevWqEk7sFfkAF2liqFvVopRwrrugqpKkvClmV2
	X1NhK5awL381ILTW/E3W6DtkBRAHu1X2elN2tlG3dg4D5OT4ocbyMfVG0cLG8AOcPj0RWN3ebiF
	1FE5Ly5mylyosrP2q43BhtPoWfAbz4/xkp8KTpT0A==
X-Received: by 2002:a17:907:5cd:b0:c1c:3b06:ed24 with SMTP id a640c23a62f3a-c207ed5cd1dmr1368830166b.28.1786390814821;
        Mon, 10 Aug 2026 12:40:14 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:14 -0700 (PDT)
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
Subject: [PATCH v2 2/7] alpha: only use a targeted tbi() when the target mm is really current
Date: Mon, 10 Aug 2026 21:34:53 +0200
Message-ID: <20260810193902.3286353-3-linmag7@gmail.com>
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

ipi_flush_tlb_page() gates a targeted tbi() on current->active_mm.
tbi() acts on the address space context currently loaded on the CPU, so
it reaches an mm's translations only when a thread of that mm is running
there. current->active_mm is not sufficient: under lazy TLB an idle or
kernel task keeps an mm as its active_mm while a different ASN is
loaded, so the invalidate hits the wrong context and the stale entry
survives. Nothing retires the old ASN afterwards either,
mm->context[cpu] still being valid, so the resuming thread can reuse it.

Test current->mm instead and otherwise fall back to flush_tlb_other(),
which clears mm->context[cpu] and forces a fresh ASN at the next switch
whatever is loaded now.

current->mm can be set while the mm's context is not loaded: a task that
borrowed an mm through kthread_use_mm() has current->mm set, but
ev5_switch_mm() only prepared the PCB and the asn_lock it set is still
held, as described in the previous patch. The !asn_locked() test keeps
this path conservative for the whole of that window.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..1ad448105201 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -669,7 +669,8 @@ ipi_flush_tlb_page(void *x)
 	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
-	if (mm == current->active_mm && !asn_locked())
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm && !asn_locked())
 		flush_tlb_current_page(mm, data->vma, data->addr);
 	else
 		flush_tlb_other(mm);
-- 
2.53.0

