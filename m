Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052422931E1
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785040902; cv=none; b=l7wateXe8GP8ypzd2404pqxZpQD7bOTyRXppioEeLqQKbpjQI3cZuyX390er4+LiW9jQSxog2/e88D7O+fOuynyq5NIFymgny8Sr449svrN3nQn4Iidh5bonIkEwMAhT1p3YlONyRUSp/wnSLtPF74lmW81KQz1psWEhwV9KydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785040902; c=relaxed/simple;
	bh=kyGd78izF7DUIxRHpsyewhXGCUb6Jsi3bPLBZJEtxf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO21OthwNFFVDOaRQc70QCcOhfB2wxVPdK0MLaTlvj2WOsgHTcO3vtWfaRDv/aihzzKMbWu7M4p+XLUWM0BwcQLHKg7nktM5miUSAawUpHBM9us2d5KN/7ddDQAE/agWv18EcNhkzxTz4KzXPmTz3J6LQsbNrlI7mayBw9S4V1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svF3X5gh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svF3X5gh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so15316005ad.3
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785040900; x=1785645700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJF2WM1XXyEqYRVgvX1/BaeT6htc22K6urn/DuogTt4=;
        b=svF3X5ghmnJROyIPTdk/V18dLFxXDaWYLQE6eHhGjrxmKG90kYTr8vgP1TwPXqTJNh
         +/RPICUGQ4U09MyYn/YKCgDQuivr/VWzuSei5J0pjQxKoONKZXKnNv1BX3MzSTJnIGKp
         z7SNQBZcYNI66tM4Ps5Yb+ThbvAkYr01ag273XddCDSNgpjmypgxQJ1yYw61XoelwsEZ
         KVRPiG+bt1mRYPMzvKJ+QzudyppQ+NY14VDYCAgpSTr9EzwmXZaQewOe4xTZTWH3Goon
         2absWwGQ/treUt4Vl8YChFOhezcX5G8MVhoZQ16AD3HSHF8PSQbFogYrn8Q6r5BuV4Qm
         6d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785040900; x=1785645700;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJF2WM1XXyEqYRVgvX1/BaeT6htc22K6urn/DuogTt4=;
        b=O2UqEwCvyQcM88WMfc+OIMZOOI0meaTDWPOLHAUZij5ABNo5N6HzvIX00Z9RDKJzor
         ntgsDYodsco8mHdkLWt8xIfO9FrbSUUoOhUIH7JkWxrcX6K3TckdgVTT29ZyjUBXg7aY
         zlyUbLPglbW4d1HYwya2dWZP4mTHDsYljCmCGFUdaY1WVuGDPNrkUnuyV/kEp+huBlyy
         bvWRD5LELWVNvfpGKGcAcA6xjtj5cQePlVI8IPntcMWLqCTvKDn9/LKGktclPmoc9MAc
         wmg5+nxRTds/lSzN6qLtPfaDSJqg/NzJ3oBq95/OUyTZ0UPOcPM0DlYWTGHHCYD0XZmx
         y7dg==
X-Forwarded-Encrypted: i=1; AHgh+RolpX+Q3pXyHjjjeEm1hlTcOhiaNjzRRy/VFnh6XRfkP2nLcbxI3mTwyAimlj23iIOQLApSvY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTd2wFfYUqKZ17Y77UiuLMoFGR4ZmJbggqVgwjmC2GdFvDEzq
	7k1F3/c9PGfuFcr74UYVJ3DZMFaUOPNe9KT6Lr1FF8BofOP+PaLh8jGryGHPOw==
X-Gm-Gg: AR+sD12AHZclrAxYY55LZRBmMM7mdouf0FEo2kNfIUny9gPzla/b5PAtSjaO8+ZwGZ9
	izeOfLlNPrGqeBK8wqs7gG9jJeTWOXl7gxv2GiF4U7iBDhnQ8CKnuVE53Hov7CXgLf8K7Nq6D/b
	pf8o5d4cLAg4ui7SZt04Zpem1XWzjqwdo3wAZ+sS/DtRIYWOOQ+4II7a2mp8J05FsJQbePkCD8k
	xgUcLMqMGHiYXzulNMfcSzZOPRJmxpT+xUfHjPrG/dQx3If/KciusQDsenGeqY2yoVZ8e7JXqjm
	27FBGUm38woFSKxV1sh44yY4TqvFuntCSgTcNEew9795/j1Kp7so9LMOVZz7+ENODg8kKfZ8W1i
	lLXU6y2TAN25Jm1VrqD92QymT2v9P2TgXLkBdXRLQgNxEE7DmxYtglb1+PsPXJmzjC1aOiO5u/u
	GUhxi1+vPJzTCp4kX+Fgzlq+Fdwtue+DTbE7jV4bSSGGDNAfpJ/mu+PA==
X-Received: by 2002:a05:6a21:6494:b0:3c3:9aff:7a5b with SMTP id adf61e73a8af0-3c67df803fbmr3581873637.50.1785040900193;
        Sat, 25 Jul 2026 21:41:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e2c2:1f24:32d5:9d51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm12943132c88.8.2026.07.25.21.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 21:41:39 -0700 (PDT)
Date: Sat, 25 Jul 2026 21:41:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liang Zhan <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: tca8418_keypad - fix potential infinite loop
 and OOB access on invalid keycodes
Message-ID: <amWPu_sGMCFJLN5E@google.com>
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
 <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com>

On Sat, Jul 25, 2026 at 04:09:47PM +0800, Liang Zhan wrote:
> The current code checks the raw register value against zero to detect an
> empty FIFO. However, the TCA8418 datasheet defines key code 0 as the
> empty-FIFO condition. If the hardware returns garbage data, the loop may
> never terminate and the extracted keycode can cause an out-of-bounds access
> on keymap[].
> 
> Move the empty-FIFO check to operate on the extracted key code so that
> the loop terminates correctly. Additionally, validate row/column indices
> against the configured matrix dimensions before indexing into the
> keymap array, skipping invalid events.

Unfortunately your mailer line-wrapped the patch so it does not apply. 

Thanks.

-- 
Dmitry
