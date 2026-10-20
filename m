Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521723;
	b=2ZRzpL+IPK3RLw6jVvxWcT2zR+BFmCIGYlxTh4UGoWZpZrGyIRJgM3FcjUGuoxN6OCw4
	 AVYBeQzst6lYpVwwwN96h3ElXKhSyB5kAE+tQZW339rUJBNNgTgfmANM0E67n3x+NGaFN
	 geWzZmlmJmVAs2QTaYehzRmbB6mi+8z9E8aUe3mVjq8gz1+HK6oruuuJELbVFmgA3Bn7J
	 mRn3nyHU2i9ChmLru14jFQN9xnwxf2dPWGRTMZcJpJ7aJcKPstrGSnaz9yF8fLQQL/OPq
	 cJGxZwI6Gf+0RTEQKM27CQIA5x4iSjLUBYK+S3KC6wLmPEiLHtTC6YnClZZMY7Na06g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
	b=QMZ1yuYZykYLS9jvIF3q4X7sB7oRRKwcU7svjySHbs2gZhbIJW1TybvgS3lEfGozGSHE
	 FW2FZRwpbcHmnaOF1SQBqlfVtipbu8pxGafbhY5mhZINFA69r3FTSQznxmqYUHNQFqAKH
	 FkRP2XpFvmPrDE0djtD+gwtS7fWiMuntJVBlcsnv/cPH1zk7XJdugrkOVG84nB9PBgf+t
	 LnunlggRydP0KvuXPB402AIoClp6ofMV6PedY1rQnbXSIp78z8BYiprqnvbiKfdg4AOWn
	 nwEk5YojCaJtZaihQxBwvRQbUk/Om0jcrvZH3Bq8GIulfcqsFGCx7Plfp65eIvsdoLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=QhL3ORmx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCA606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=QhL3ORmx
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so1375992eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521722; cv=none;
        d=google.com; s=arc-20260327;
        b=GyawFrBYFxKZeIS1poFTf01ZoCUg7lGZUEN+3GMwpTxGYflm+RbAsCa7ko6wxCApJ8
         r3k36XYWaC+adWLGcXwpX+SzHzVxBgdivCYTXSr5JufLzUkJrLrwcUurdn5NocDznvxk
         y0bUqK/Kp67Y8siQE+S72ZszpbbqaNWPDTdlLrxpSo+uRwiIKlb2tG5Wqt6wysl0OU2v
         GW5LkkASUgwF1tGlpycmH+Dy//rcxQ/t3ZMBMz/5J/SHe6I0Ot+/lBPh0ZPXu1xrSDkE
         onQBZokIl8mqS56AJruq3Jt/KpxsBFKZWrKDG8q50rUqsziTDmFNmUVnXyWZYielB3Yf
         2wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        fh=BhPfK1YOWC1PEHOuT23vQR6dA4vWeiUYMa/qy+Px2tc=;
        b=B70PdVysT7EzStZ4CsdckXNAvI7jvIfP4ntS5zUSbu8W34GRd1qhCg5Ehtg32nbzSH
         G1o57gjI+ynOBEn/fOQHiH4mUveIBuz1gTjm3BR5a317ZGier4vH/6ZsMraQLVRu7IaK
         3W4FCvx8XqJu9KFZ20Ffjtu+OQjC5Onssqko7+Lhvkbq+c3AhNRwfz6voiiMnFFbLlo+
         L3q440goPVKhgzj/oBrgFo588ecTAJO5TyYAPqjq0mYsdGvryOrZCRqvqXX7XVllh6gt
         yg9vRxd3l5d4S7mSRkGngWtzVXpmii9wUvetUTnmY4tJWb8I8Du9mkuDoc+QQCn1HGYH
         +zqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1792521722; x=1793126522; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        b=QhL3ORmxarlU22wLJWF/w+12na8Bv71OTWBMGCmGh6nYC9t8oTNHCSpYbpB9jJB4YR
         GBdR2i0YIkJojp3Am9+G0hz8WJa+YBWaXorEh2FXUQ0p8le9BWJ+B8AD6XbL6FkhQrSN
         9/lKBLH1h1X6hcVGIAcGMhQKqoU+zafSQ4V1eQalLxZjojIbzPq6raCapl85AnGkyDqy
         DLioSm/mFCaRbwZUCFHkIprUtREUgHZLbSDL4Anlu2RU1QSdrB15YxWHoLDbnVPJQffW
         6X/VBZXKXfex4ImuB9fPqNJKtBKtKTILOjC8eSDID6H1LqmKXTAjYTm/t62pJEjeCuXw
         4uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521722; x=1793126522;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        b=qT0u//bOd+YXb+BMsgOjJsLsfs86iEliiBIK0LzZGqAa2P4Ho8rohiIwm+z9GVA4hb
         7COLbmQyzvl3ywh7xBDL18cpdtL8P5kDOZe7M+zgDfz17F5uCNEIabc8467QNW4pzjMe
         p2z6QCuekumWpk4IFToyEl21M4glT1PehWZdOnFqTxBRqUgxvWVe2d+Ab2jXYLK/j532
         +aVHqpjlVTXL+R4bJL2S0M2zLMv5c1gjQ29a9A48LDlaxp67E/7xLdSpvEvvJHkzP9Vo
         kRgPqtJXyVe/shrduiEN0k9cWHCDCx4bSRMs+Wey3QERf8mFYBNrXEi/bVlv8AFk1IyB
         2jAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0VBDabvf9iX82C3/+8cV11r6N+mJslztRVt8fAcX0gnLLQolaxhyZFnsxWZ6KuWSzqiDAecw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRBvhq4wd3WSGTynTuWnSa2QbMOkJnQODU0zFdpIlopvqso98e
	fHYfcuIYJitJ80NBgbHv2BflEzMZLIJnE1o+bLOIq93M9+cDPjxNHzOhYRVmL9Y7z4csZfbLS/M
	sWtsHXTAMuQSgDrggQtiTEtQsW0pVacUN4JjtypuaJw==
X-Gm-Gg: AYBFou00CTXr4qz0P17eUBU8Z35/BmUI5UNUvhTMyaiWuG4qsYHFuAgzpjSiL1czp4s
	1fz8ARGggDQyF1psFRjhct752dXL5szVSWhqvrXX1F5ICt+IEFnZ+7iqUK5czXZoeRcu0LlcnfI
	+yMv2XX4PXN+xPPk1mHUk4ebovT801OVqif1O9+ctn//tkAt3+pIJ6w3N0zCkCbAHrhTRoW3mZC
	EVVp+a31AsL+/tkY2SDfWJMLf2fqvfWHEYEnqkWv+2maLs5+rtf/7T2VXNY5TswU2stVEm5y1NR
	Jzpb73nZwXeHoKb29fQ/L8f+wn8tNWmzV42Lsf+PMy93meg+o8EIzJLaaQ==
X-Received: by 2002:a05:7300:c00e:10b0:35b:d329:9f3e with SMTP id
 5a478bee46e88-3674e842a86mr135963eec.28.1792521721089; Tue, 20 Oct 2026
 11:42:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
In-Reply-To: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
From: Siddarth Chilukuri <siddarth@nexthop.ai>
Date: Tue, 20 Oct 2026 11:41:50 -0700
X-Gm-Features: AclHuK9vLMZF-AAKuV86zplYxOP7GeZc2vlcY3CCw4_yPy_9puJFU1MY3JTp13I
Message-ID: <CABAykku7MDTF7jTg3OdY=AWCqrBUTS_sNAoVTHUBM6yM=NKjUw@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 5, 2026 at 11:49 AM Siddarth Chilukuri via B4 Relay
<devnull+siddarth.nexthop.ai@kernel.org> wrote:
> When the controller is the master receiver, TX_ERROR is set once the
> core has NACKed the last byte ("transmit complete" in PG090). We have
> [...]

Hi Andi, Michal,

Gentle ping on this one. We've been carrying it on our Xilinx AXI IIC
based switches and it fixes the spurious read failures described in
the commit message. Happy to rework it if anything needs changing.

Thanks,
Siddarth
