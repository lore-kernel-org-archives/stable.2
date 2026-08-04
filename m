Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C03537C8
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804580; cv=none; b=DUTfzyos0jOKRx9+qxDTnK6zPRPmw0TjsmqrPphHGpeLG3vsxDmUCx2rHlidOzHrDZRgqtVvNK37S4tmI89ZPLT89rjrDA8FjvmjHb8HznXyFS5yBxdhm2Ro1CNSK3LXtcPY5hwx0+vEqY4xZPXb8fjByAQcPNOGKIlv4A9u4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804580; c=relaxed/simple;
	bh=oa+H6nWC+O0SGtuz+1s7AAMO0NBQhgXa1uTfnS6jUk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltBqxAy79/rmVo3wKbOBCvQhqQKfOvJOIcKFLKOd03z0VkatOTIZpAwLc1J9AiK+A3yTzNk+1FLUrzCMp3J0AKFOkauSsMPGI+PsxjBU/+ZGOSt1GMRHFHGEiQK8nHIMBWPw/BXnpHUbZYQXTgWS9jgb7EENMCcq3BTdzwGle64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3QoWO+y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3QoWO+y"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so3087209a12.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785804578; x=1786409378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7vHz5OIbygjwNdyPf22CXsjNKdQWVu+Ycy4+8mUpd8A=;
        b=O3QoWO+yq4TphsvWi3Mp8Ybbh/womT5q8Z0yh6gxeC1OOxqvkKjo8h74vYw2aJvdhc
         wS88Ggka+F/1WqkX+GNPUEYL5BGUwQxrKROUm6e9XNRa/kQ+xZVCnLXyqcAnXsfOdfEu
         rZQ/8eGvmINH3uRX5k7ClGg7WyhZ+4vj80AhmCgFEiyymZB2dTDHmA65/SaS1AB7g8cV
         8iKJHEXgIDFVXHeQeQitTcqAGIZ2ql7H6zN44aYMFVafhr32grTlPU4gb8vNw9M9Q/Gr
         /5u6Icft6kRfjZoznJkC+9h2FQp8U948A2fFl4xDk2EdlZ0KxfREP6nhcfy3sBI74veM
         oAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804578; x=1786409378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7vHz5OIbygjwNdyPf22CXsjNKdQWVu+Ycy4+8mUpd8A=;
        b=q9v7Y/wYxXGvoLt4w4F0pqSFUV/Kxuc0/27SMm7X9R8oMvayWN8bG+Kmz4AaFiqP4N
         O4tlDd1Ym2rntBtdDlwsXey5SzWDIoUsFQkXdO9YmpFQkTuKLL2UqsOBDikvqmsOcoBP
         lrIrL6rYW7JVgyOFH3BHRoqYv4xJTOwnO3UCcMPFE+3oeaHQavyoziIeunu32jC25IwI
         PBO6b3bMuxv10MPAoLZ0xefWQKag4dvA+4+clnxlqr5U051TASO/qItSg5cWyw2Ln82g
         GQgiFTkUxlYFrYXlC8LujHL20VYdtuDsm/aY3gob5xDsY16DFEh59D8Li7qVbIRMEPqU
         EwvQ==
X-Forwarded-Encrypted: i=1; AHgh+RoANw79lkBEJw1wMoXxZ1m/7sgJqmvQAz3iCS5RylXoFHiQW/WoRmpflywtsgOf0JqrT9PWM3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxub0Un537MwKo/PdnVxc4fB3H0kPMzg8JiSIqunp4pw7xYW19b
	UiwPvPG6fBuaABrnMnYiQQoNXxThLdVVk5tbYvOQALnRtDgbTEb6DlicJjcJkQ==
X-Gm-Gg: AR+sD13G5aSkt2yl0B8mjqKNPLbYO5Pefsd52hC1diBEFE1+vhfIQ6mkwR87/rsz845
	pDRJLEGg9WDpf+jh7m2tIdL9pCHMtrgQ9Vo1MMrzpM9HDC5a770pgh2VKZZ+9BGMpx+HBJLAP9l
	9atGfDfgEQgSYG9cPVBNA0U/mCCpEzI0+rANPVl55DtxzaG6D64NQmgAZb4vcT/evlgP8moy50m
	zbEm+M/iRBeA4NC8je6mCgyPfwKg3TUaZ8QKbVNMIbgDc3CIATfU+0mxekfj8VpgI2M+Zuz1bOP
	AmnzvBJn83jSkSERf/NPsaXKGCsJYSZpOV1o+q1cMF+hPmn4Y9OW0/jTojZQaNCDcgBnZHQ27E4
	JVzu+Wk85vYIwNsGuMFwqG3nYmEUQnSmHD9FMjq/6Pag5ooTyBtFE3U8yUUTDx/YvhL0R4HKnq6
	8ZJcmeSi9mpWsnvgN31KlkVrPPSsyqghNYwJpihCGLnwTW0xONbQhpqQ7+Zk/ek2BqaRPoz61ag
	KCIvLQyaqBNDA47Hn8RBWcaMqKo/g==
X-Received: by 2002:a05:6a21:6cc4:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3c92a89bebamr11916363637.37.1785804578109;
        Mon, 03 Aug 2026 17:49:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f0f0sm41716849eec.2.2026.08.03.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 17:49:37 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:49:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Message-ID: <anEuB78-HMX4Dwx7@google.com>
References: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
 <anElA4get_VxNuB4@google.com>
 <anEqUZyJGBrQ6HIW@pve>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anEqUZyJGBrQ6HIW@pve>

On Tue, Aug 04, 2026 at 07:54:57AM +0800, Shengzhuo Wei wrote:
> On 2026-08-03 16:33, Dmitry Torokhov wrote:
>  
> > What stops these jobs from re-arming? Should it use
> > disable_delayed_work_sync() instead?
> 
> Agreed — cancel_delayed_work_sync() only drains the running instance; it
> doesn't stop the works from being re-queued from the raw_event / sysfs /
> LED-brightness paths before the device is fully torn down, so the UAF
> window isn't closed. I'll switch all three calls to
> disable_delayed_work_sync() in v2.
> 
> Do you have any other comments you'd like addressed in v2?

Since you are addressing work-related UAF, fixing it on probe failures
would be nice (Sashiko mentioned it).

The other Sahiko comment regarding global instance would be nice to get
fixed as well (but separate patch and only if you have
time/inclination).

Another potential change is not to create device attribute group by hand
but attach it to the driver structure so it is created and torn down
automatically, and control visibility of the attributes through
is_visible() method.

Thanks.

-- 
Dmitry
