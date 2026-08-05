Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAA471242
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936926; cv=none; b=Gy0+1x2VqMoX83ZfVNlY5ewIS5U+QynY9ncChboMmx1AumYPAhKrkvgILUj/PzAn5UN9sm7YoOW4wj4Yz5hC9eUpQPdiDvDdgO0a6lisRmaDvgLKHXlly8hQPSeaG59FFxNQ3KBezJgDxe6RFIlLtwEOviVkzgGZdAVJM9UMaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936926; c=relaxed/simple;
	bh=jxuQfWhpYl66LtBJmNq/vF46Y1oRiue7ltLsrXhWh/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WpyPbmtF7Vin12BPR39G0JRJJU9YYhtGKfw8Ihba50mwrsHg2ku1BLN6MkLCjouDV4EHHm/lXTWeFiK97hiOX0IrS6cf8U+Y61id/HbPi9xqbuTmd7fQcABUL1IZsiqMg2LKSJoKl2iOdfO96SLcsfK7bM0QEjFc/MXsPsAfzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIhTG1yB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIhTG1yB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66804667af2so806631d50.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936924; x=1786541724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1nzsLI9q7XCEJsy4/q+r9IZRB1ZH+YkiVaabrqN9eo=;
        b=pIhTG1yBriM5SYeDCRFEKAlrNMPQgd2CvBU60wPD90/QGvESNAgNEPCONIQNOwSvNf
         hh3vQafJfeZxtZDTvqhBuz9UJaLGytFdZDYLf+ZmTFtj35cPhKo10Eis6OzHRNClz+6z
         iNFL3JYBVS+wXziRr1xk6EKMx6EiPTek5+RkDDrOXyL5nuypWjcUdtmuEJCiWjgrR72l
         J8FR+1NA4ruwHetyvQRHSWW21ZYwtjYVnhj8XUbySIRwX6JS5F7KK+wM+7MZTnSlDTtm
         +tvA4fXQSJa3dkh+ARNBEt3Ue/d8suvtFR1S5vKOUEvLLCaoLxDl781SAqgV6+nhwX6a
         Fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936924; x=1786541724;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1nzsLI9q7XCEJsy4/q+r9IZRB1ZH+YkiVaabrqN9eo=;
        b=ShWBi0mVvJWEjjFP/0fIR72dztlkL/HxIdqIGZdgVaDEc7y2Chn8k6nProzuTEg2Yb
         /MCXai565RmmZFp3JOeWDz/WM4LmuO8rGppGk8rqapy+smAT24abmm+Cwlu/xIxS/6DC
         saC+Fha4Ct1cX/6enV33oE0LxWdIw+n1ZeXt9zfEruEH1sSlfY7Eh+fHyRhLsQ3QJD33
         R1L0d6DyhXo/rI10lR4QmXjFTEQZQWhTrdnITxrj6CNLa3XhQ/Vl3iFQRgDQTYCfVY+R
         oVya9AnN6m5vmypzUIOMPe4y2flIpQF/recA0fhWQ7B0mL2pXOJ51yHXVtTnL3SyVq6X
         zp3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrUrByh/EdBaabsLP1fWAaabqBGOIlUjGyoamdIpBRrX+TdWWBuse1w9T/LWUXhp4U/GoSd3wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+J+Szwb7OAfZm1yqO+eDW0bNN5KLHZG/HHlYZtkAWZJsBbGG
	oEHMqhV/RZDK2FJaR5ig0FO15ydPDakgpQ/kocgRgHBq+HLshwlMn8bt
X-Gm-Gg: AR+sD13iL8rdybAmhYx7teISfQ6OmXVYhhPEruf9YOmzTljM/7jlTto+PIEnmiUyqIf
	3N8HkXWpgJol/78m+0IxNQVhcSV05ZHa4mKOqPy8XUQTkAuHyzC/C/wh16pybNr7zF+ve41U+Tw
	t/hNoWJMAUlWpOoOb3JLb18Q+u8nrC0ypz8PtuNvhZoi9EmYYNLyPv0OqGZvEjfWPipXVjzUBxq
	ro7zkm774htRBUppTwtbFqhBx8abHFCLn7zCg51w0HDTYHZ79QzkmZinJ+EgN3zawIivpE3cOUV
	4sON9jjDR+gwlsM73SBcxe1B1ywy0fE1+/eMYnVz48KoxpwkVeGgc8mAGlR2Ue8dphAzyy3bv0n
	b8wffSzSyqrwpQ20ObmIVJ8IqEKD4BQoS0wklAVSGrzkomcaNF1Bio642VH4xKfYV2ia8hbkVz5
	/sMD0OGlnwlVwzJw/yzjUa7G2D9o1D2WRNGmhRkgiVB0AUjvyfzXSaP3FBMRW3vTZRKKAlpX9R4
	xqh5nPeq1AufYDtTzqwuguHSBQvDeV4Y4l+
X-Received: by 2002:a53:e30c:0:b0:668:9e51:5239 with SMTP id 956f58d0204a3-6699ab2455emr2737422d50.44.1785936924056;
        Wed, 05 Aug 2026 06:35:24 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a6asm3005487d50.12.2026.08.05.06.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:35:23 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:35:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.251660d5aa3e@gmail.com>
In-Reply-To: <20260804164324.49528d7c@kernel.org>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.f39af6152c60@gmail.com>
 <20260803192228.49a49867@kernel.org>
 <willemdebruijn.kernel.ad7f187edf35@gmail.com>
 <20260804164324.49528d7c@kernel.org>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 03 Aug 2026 23:04:54 -0400 Willem de Bruijn wrote:
> > If I read Gemini feedback correctly, all reports are about the current
> > solution falling short of fixing the instance of this race condition
> > with dev_hard_header(), which reads dev->hard_header_len directly.
> > The patch indeed mentions this limitation.
> 
> To be clear -- prefer looking that the netdev-ai instance.
> It cross reviews the feedback with different LLMs
> 
> > As well as the same issue with dev_validate_header(), which the commit
> > does not list as limitation. But that one is only reached with variable
> > length L2 protocols.
> > 
> > Side note, in net-next I can probably remove header_ops.validate now
> > that ax25 is gone, and with that all of dev_validate_header. No other
> > variable length L2 protocol ever implemented that callback.
> 
> Let's do it.

Ack. Once this fix lands and makes its way to net-next.
