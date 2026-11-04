Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777606;
	b=gp4YtpVNqE5l21721YmaKC6QumChByCAqmxjhoMbpMWPRr6hXDCIG9VBIs9pcAYaL665
	 gF9Of+H7bgZvsF0Ni3R7Yn2aDquUQ64G1E9YBZEdccOMOS9vT1gh+wAllfjuzELXpPVsQ
	 rNy6dsbUns7Sy7CfTgevM7ttgJwNhpk4P3Psu0LxLic5E+pYHtk1YSwwVGZ2F7NLhRXlx
	 S2CpJHuTeRxggAi2SRw2NiD4RHjtpQJ0WxTCfuOYtmfVN6YIFFd4QoGDOqe8GOHLab5q+
	 ZbwMTzWWuWD1tIvYKEq5nSr/cRfNUEVYOkOEXJpxs8om8q3gKU2YuV+MQU3+ym02cZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/XbaYXLldoLvnznmVKhXjejOBcwlPqhhTJlN1aaHsr8=;
	b=WxtdpXYNzDl+rq1lMhPuYiN5D/DAUdMD8ekbCWFXYgronLzqPmNeCj0TTst5oSvNlLC3
	 Hff6ooyZ7izsmXYM1TjwIZgn50OVmtBLNtQUR4IqDV6RxQQxDAw7es0EFGax7uygC0Rpi
	 DxfW7C298BguXRM6XnPc1rsbdAu38qyZFdff8vBCVzynBQOKwQvHf53CqNYmygkSpclYg
	 vq8KxZ7A0LS72NapH344mv+SlPtqlzV0s2UcSCVlnm2p8+STocUjZdBrLwjQdfzgn6Mkd
	 55FaGxHdICI9F3PyQKnkOf07Xane8aJlmYk6YAJg28lgmFWCkZX2S4PgRp5Z8MB9wiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4n4POhV;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAD606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCAD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4n4POhV
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a1467ca93so32701eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777605; x=1794382405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/XbaYXLldoLvnznmVKhXjejOBcwlPqhhTJlN1aaHsr8=;
        b=p4n4POhVx9ba4qfgRBLJJq8iWcuZ9DZsljroi72/xuvSDxFpnPH/z6NYQshuozLHhB
         tO100+TqBMwO3xdU3avBYX6dV6aozpDqJZTrnvM4UINs6mA5Q0TR0I6uDD8zAwGl/DAf
         ca09IoryiQOrcVkKZyXe92jtaBzh7UOjI3lt5ioUT3ji920tg13glhupiSQAIdo2d/Na
         AfEwP7fHphjrftjd0wCNtoy4Mfg5KghwIXEFSxhmBRQsql8eXS7+2sdk4qLIHRtk/yqG
         lYrKXMhRWJPgv/M0ajgyCXQhtmyHKbio58Ja7U1fKdtDWKTfNxtymbIOMbrX2P+HCugl
         vhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777605; x=1794382405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/XbaYXLldoLvnznmVKhXjejOBcwlPqhhTJlN1aaHsr8=;
        b=j81NnuvqTXHkPzFnXNDd0jy75s7LWlGBRlsbvIM7+dU6oZLvd1/pvaL1JSeHMmrlk3
         mtRdFoCEvDL2WUbFl6oJJ0Ge+UEHrVmqFO2ydqrJKBRu5viHO7TFwctPvAB6NR6Q8Txz
         Epr8Vf1pTU1NiYBdia3O4hDjCbLEScnweGQOEZb12IX7+XG5iFl7e0afyGLMCM/IVrgR
         0FWiZfgaD+vfST5U9zvHwDzaTiht3DYTpCEtoTBojnE84Gjho1zHvOwrlm4+0mZ+TV1X
         5JnjD37V+d1+YYp+BQefFyu87iTOXogZEjboMFEkw450jIlC+p12d99xpd1cG0fTrbHB
         sDFQ==
X-Forwarded-Encrypted: i=1; AKwUvByY/luBBN6g2D8CF34YTtMWwmMTnbEJchQ3GXwpJvDY0L5rgziGBA73rMYu78nSRQ0/MRZCClI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/C20ku86mW79/LCZ1hkOMx7F0nypK+AF6Xt7vMI0Qiedz2Xl6O
	wTRYkMnLL4m2qRarejuJjw996YHOlFBSLaT5SKnNJyzzmaxdLvpQHEzD
X-Gm-Gg: AYBFou3wk55PSs4suDE45yibdvIRSh305Xbjv4e4YcaxyWavYyrJ4b29b/P5zxqiPcf
	Kq3EeuOrFkx7m7td+vAJa1fUiBb1fPaqOKA68CvgNe0/pjro+68gOFwkCLzNO8MUkMRJuT/nPFa
	bCusI09OzXR6sYFXIta/mvk+7RhjBt+jqM0mBdQJCw5pAquRIvhbTMgNI4kbQhG77GsQfP6Hofo
	enwtTxRbHDVIXNp7Z+msPmk5ARui9q5+VMnktk1pSjzIFMGlc6vGp2u8zIBdc4gjD7CF65xZ5X/
	GxAO9bdrTAdrChRguA+yHFvuZOO8KCA41Djq2PPZWmw3LYvgMIEb8rztcwe1AHuuCDV2Q0CEZDW
	pgamEbuL6J70OoEPj9JCJQKJXm6+RBSvT40SyYnoevAn3+WS7ENvCkAFObFAtKaFcm3205Ihj3h
	WBZ1Kq3PPP1hxqd9DTCfTFLuI/dDy2OXCBOJWw2Am2ijBAUeh9ETBK/sddBysEeH/cqVV8se9h5
	ynLfMThPrrpJ1r5s4BJPk0wCJW/aZV/YzFECp2T9GmjgnmdZR/gu+00zy1idQpgigYnIrgdlVki
	dIcP4q40T+bJ5insjpNlwnTtBqCM6PXKHmTV3ldkgQ==
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id 5a478bee46e88-36a4231f8e3mr35132513eec.1.1793777604980;
        Tue, 03 Nov 2026 23:33:24 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d3754sm6295359eec.14.2026.11.03.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:33:24 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
Date: Wed,  4 Nov 2026 15:33:10 +0800
Message-Id: <20261104073311.1617823-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104073311.1617823-1-lui2012qwq@gmail.com>
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
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

gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
in the field.  i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(),
which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
dereferences pd - with an ERR_PTR that is an invalid dereference and a
crash (in the async release worker).  The free_pd() right after is only
guarded against NULL, not ERR_PTR.

Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
likewise, so an allocation failure under memory pressure stays a plain
-ENOMEM instead of an oops.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 438cd4724a..72a9ad4642 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
 	struct i915_page_table *pt;
 	u32 pde;
 
+	if (IS_ERR_OR_NULL(pd))
+		return;
+
 	gen6_for_all_pdes(pt, pd, pde)
 		if (pt)
 			free_pt(&ppgtt->base.vm, pt);
@@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
 	gen6_ppgtt_free_pd(ppgtt);
 	free_scratch(vm);
 
-	if (ppgtt->base.pd)
+	if (!IS_ERR_OR_NULL(ppgtt->base.pd))
 		free_pd(&ppgtt->base.vm, ppgtt->base.pd);
 
 	mutex_destroy(&ppgtt->flush);
-- 
2.25.1

