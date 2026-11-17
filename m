Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955752;
	b=wdzb5ppOEPAaCvpySK01rjvPTdh2fT1TcWO9TnPXF7M5wNL9K/tNk/KdwlA6JikTBc6L
	 5TXzGrFHWoY3YMa6isdK+pehzoQHoBjxdrQOCh8eEJWrXV+pVAX3zB1zFlvY0cr16Oyo8
	 iabw/SWfvMMb8lzQYUcky9uczOtJdx6fGyqbL9R0kuZPe+/uBnTYKMbhAIZdBfEA5WNiP
	 yfRBXvzjTNHjkW/ruXnZa7+zBA8G1Frd4mlZzDw/j0B2iUZTWwlDAFyoxIVKWUwg6zY/V
	 NIRAYzOB6uEZGt5htfVT5iK6ipYeVLR/Ebbl8tz9FhF2QjnWlFcSD2lzZyrStZeszjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
	b=JZjOskUwB9ca7GhNUV4lRAenDRaR+++NhZFiUwl8q5pVolkSMDf5Pain/1XbagDnu26I
	 +GQJocmvJoJ0X3WvPk5Z63nkxiO8q5bYJADa46l5dIxxzmsZMif/Wofpz5um22o2Zay+u
	 S61S/bfbEQUmUNv7Gq4ogCOKyTsPDWNYm0oF2Y/RV8tNYybXUdiiOoClIU9PIO9yXqDUq
	 uuVhdJngPIQtGzfrgmIaxSwa+GJuxH5Oc/DE0F2Efilsn6DtQf4OjP5L5teLOQ1kOjIxf
	 TgNam+qEOqHhbaD1G5qhHhGhQvfzTVJmO6YFa1ytJaOZ5dnMMrenCyoH/WBAwyWZNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcwrOPy3;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C960A261C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 060C960A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcwrOPy3
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4adae187d94so238414fac.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955751; x=1795560551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
        b=PcwrOPy3tfi3YBg8v5BHLPacqa4Td08uSUMN6sTMXCUIRMVBFU0iUEooEMj2SWEqLZ
         zXlwALAmDbfl86YT3JmsMoeUpVm2mCP+trIJhMj8bvOQjrGYGtgP2z+G43mSEWRN9teR
         JhMPLX+NEdQv4vbBfnEVSh7rUZlShSX/6NR4yFEuWXTL0eX+/+u14h8hHqBL/SlEM28c
         P9km1wHqaeOSrIpkNIoiX3N3TPYTq99ghrE0V2/OZDo7CA/+S7MwKVMnM3OINxV9XdKX
         nAD2227a7/DYkwBSGKsGxWZQP79S+NhVi0P7S5Z8G0smZSgYa35O/rJx0/w+yMbJe8lY
         CYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955751; x=1795560551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
        b=UJKT6sZOCh4N5KyQJDOf2X68RFbTGfmisufPl+0ovsRQPN0nQzuIDpTraBsZxBy3os
         Mw5v0SpuugZfCXgQZiPOHaZMwj7qRb162UzRrBg+V96PRkG26B84W2/uTpai9mIb9Ydf
         uNNPrFHxIJMC8/ck1mwIJJg7muGubZFANjJNxBzq3qKzXnTmIcVZRAiqs2H1hovmeW18
         W4O7jwJR0FT439KAxbeklfMbPI7q0M88RBF8bHAtc9/vdfC4i8QllDNw94JBROrNN25+
         iX+bEw18q++O909Ei7ADKaNIlyyBsXUDZ/QdifahuteMZePV3IEyp3b6g0/lMosL02Dd
         MbFQ==
X-Forwarded-Encrypted: i=1; AL+hErHhPezt7WP/raUSp2jTjx2VP9uwYeXUc63cVLARkgigYLKvCzj8rpIs9aBv8waOhT0xO6rCW+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lzP6UUxxiru6Dd6pKi1lo+5ZJl2QDB+zymk+XeBtLgrtf+7qf
	RSeauPFGwTHK1SdDmL27dncD/ogoquSin25H/PS+UiepFCUsyhPaLiu0
X-Gm-Gg: AYBFou3hRS/9+nscBkk+hzXduRX5P8PyeYnY5j+hSPEnzMdatGOskM9z82kCrbqzMur
	OEDyV6iIe82C7CfI2ZqL24sZCqXlaMyhv/3s/68QR3E00N8Q/mv/pTapUHD7eJ8xJeksx7z9tC4
	CHm8b2NlvlYT/kbZjbYM8YfLla2KH+Y/0C4huh4gO8z8p/pEElcfLv80louKn6skE+4sGATtP9h
	Jb35JSuiOmUyvw+CUI5K7D8DSxATaNfvcr35rd7sOQ+/zhIGEfvKx5tOZJ49u2dOM7lH5sEjyXO
	Akh5X0GaQQLrWmWJs1Bd0e9+R5klYizad0e26PfcAjYSuvl0xwwOHX+wTno7y0eU3Gl7hIjybA5
	ZjEQJhcUSqah/EZRwd9q2LzpDOkUPk2SAve9aNvqwsO4v8VWRvdsf7QeXw/XjcGUS0CqSN5dS+S
	/zouiZGdVsP6kwmRd+w99vLVhtYZ8bnI+IryT/vIn12FS1l9m9CP3WanS43T3xi0bhD14idBmU1
	Bi5rfzCUXW4nsUFdMnbIBnKz7fXRvSMymWHYNipVza+15rbLL0IKBUxsN6PRYzpVM06i5aEl/oF
	eQdG1yGVECKDHTLQFpcBnnzP7ZShCHagQz+wgGO7N0/RyhM8dFh3H/ZCQ8Ola2huTvtwgaW5e6D
	YwT3ouCviRCbwGOMce8Ep5uJdulPGfxqFraMfKOLG2bVzQ1Kizh8cWs4eqzEFCPaQd24ioqrsdF
	lI6JNI/Fen/TSAqWf2JmpjD6Gz902dQqZjnrF6/GZdY5tzTkKL3oo=
X-Received: by 2002:a05:6870:17a7:b0:4a8:ffd4:9a6c with SMTP id 586e51a60fabf-4b75d850d84mr521682fac.45.1794955750772;
        Tue, 17 Nov 2026 14:49:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:41 -0700
Subject: [PATCH v9 6/6] dmaengine: dw: report residue for queued transfers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-6-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index c138008d7cb0..1786dbe2e850 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -867,9 +867,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

