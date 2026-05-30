Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC822344DB9
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163034; cv=none; b=G79cLW9XYnL2P7RQpKDOA1lxNfx8FmLQAIMi40G//PHZ7UZod+SqjYnZ0aHBjVCMg5beUuLkW0mJG0qt3FB685mncYyDiOt0FRRk+4qTT2jKnqsOjiUoQFaNrHYqa8Pha58iOL77pjXZbTRsBEXorXa7bDdcJmp23u1tU/KDaws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163034; c=relaxed/simple;
	bh=V183WnI5pnoKUBivwNX7yBT6eyXdkhaOPmmYa38jyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di+My6OkNRpIEfYbWr74o6oDuWHWxAMdoyyuAF/kIjdMAj1AzPiT6nALCDFJgj37ChNZD1A+e9CDUIM4S5MIUQJcbwwTBInhjFnjc39RtGVd1IDNByMdAYXbjumYX90x+vYyECjd+e2fYFr4PmQxWnMPqVoOxpXOM1iSKurjQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YprZPr7h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YprZPr7h"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so65ad.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780163031; x=1780767831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOyDHP4ZxCe5uNffp9qfUHpgLGSQaBL/VpuY0l97f+w=;
        b=YprZPr7hw0gVeUdsf1NoyIA+yaNO7E17rk5XHbHAMqI9mIJnd3qaLM8ROpL2Koy1K4
         ZW2Pr5ISj4teWjqPqGNebb+G/NhAEqqA9umtOUHyyp41opJRy6S9l61sw2JcK9CrTm8+
         dtR9jOK0IawCl/QCqxrfZxzVYcH+RD5TjglYSDiBrKiPTJkx2j1/vHPtlhgdH2IocP48
         xZQqfEU0JjtPRhY8DXNJlK5AQsomz+2XPwrnQHDT/i6ktRkXvKQT/JJWuwWcAJc/OTFr
         ZUXL6lucOCo4xJlXHvSJrfjfDr/LN75syFqoeA8HsLHkRkK0hjqQSyAUXl8W6Lmsx75D
         y1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780163031; x=1780767831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOyDHP4ZxCe5uNffp9qfUHpgLGSQaBL/VpuY0l97f+w=;
        b=WRVR4XKpJS0MouzBaPLS02bFpP+dXXdGStE8wi+WAg528uU4mZJU3CXIPyAdWZTRCK
         pFdx1MCXWM3X3Qnz2WmHELQE6XeyJwwaVdWdgoxVB0mqiKXjILj7LzqdRxPlE7Rviae+
         eVfIGEpS2afNZ/LkKCurgXaiFZu6j22UdCtZ7gM8NEcyINxZBoNmkbuMjjNgknDR83V4
         4CAvMi2o5dwcSdwxghVtaauhC+5XwQp7zIvg81wVoCR6wG24wJPUtn+8+C4z4gdN790Q
         1i5TVHgF3IGdBwwOk9+iY3Zi7jJUd4pQ1Yp454oBVSpiQg5keDWl7DanmGjvexBmDbbq
         CYTw==
X-Forwarded-Encrypted: i=1; AFNElJ+dcmMFNMQK7nj8vgcsRfhMBDe3xlNHr7ar9sE8UsbBD0Ev01VVZwK1mUxSy3xVK38ZIcQEMps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYF+jeTEWeoti8umVmt3FzdbQvjGs84R2rg+nIrd9ISsOk05Xy
	tejjxo6Mja0YsnKjyU2U3+XSqR1rXVFfEbqCSqQCfgEimkHrrc6nSYczJnF6KARjs7T6OmO3O9D
	dssihLQ==
X-Gm-Gg: Acq92OFMY1AtvxCjlPbZe0SKz4EHFj5jGg/ghp92plV4H+bDRqx4LB1FAb4wvK3B2iI
	Vvka+0su4YffgFXhkQ2qlaIjUmkIKKgqAOjNbpqspU/BYw/UawuP4kUCU88mUoGNPWcpmG1ceUr
	RwtQ4JQ3UZUbelbjdkVT9qtYshdYWJVzCg3hqc4DfbhNF1JbbAyAJQCXjmVU/RF44Jr/bM2L0Y9
	LoZx7nVLWs788yr0wznFUOn+goh/Zk5rLzxalxUvNSgyp+UmFHu87dqS9kpGR0TCbFLdLC9sCt8
	aV/q2/7co5hVeq4+VTQGzzFX3A7f+zEsfkwZlKJvujphc0CzCe9hNAaovw4b5AAm6TIFwcmr6sL
	e2cMgJkz+2udg3Q8fWHrJIr0/REpRDAtxbATSlcPMnNdZIvcsTVxANVPMLmPnOX/l4tdEIqiP1s
	XZbOWW/0QIfxTuvcU76P0RIvN0vx2ILc2bpYOeX/UDotPlA/CMe/Je3muWlxeWLQ8IMXaP9XbhE
	+EIbQEgS5uwOQLgfft4fPWHKow7Mu6coGcc6BSZcaHpQNBvdJ6iNEES
X-Received: by 2002:a17:902:ef44:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2c07cb2ec5bmr239755ad.13.1780163030509;
        Sat, 30 May 2026 10:43:50 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85a187eb12sm203716a12.6.2026.05.30.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 10:43:49 -0700 (PDT)
Date: Sat, 30 May 2026 17:43:45 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] HID: core: introduce hid_safe_input_report()
Message-ID: <ahsh0UtTX6e0ZeHa@google.com>
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
 <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org>
 <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
 <CAO-hwJ+EgC0pM6L6vGFEaRFt2Nwj5b-CCf_5e5VkvrXgdHrjNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+EgC0pM6L6vGFEaRFt2Nwj5b-CCf_5e5VkvrXgdHrjNg@mail.gmail.com>

On Thu, Apr 16, 2026 at 04:46:28PM +0200, Benjamin Tissoires wrote:
> On Thu, Apr 16, 2026 at 11:41 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Wed, 2026-04-15 at 11:38 +0200, Benjamin Tissoires wrote:
> > > hid_input_report() is used in too many places to have a commit that
> > > doesn't cross subsystem borders. Instead of changing the API,
> > > introduce
> > > a new one when things matters in the transport layers:
> > > - usbhid
> > > - i2chid
> > >
> > > This effectively revert to the old behavior for those two transport
> > > layers.
> > >
> > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > > bogus memset()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > >  drivers/hid/hid-core.c             | 21 +++++++++++++++++++++
> > >  drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++++---
> > >  drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
> > >  include/linux/hid.h                |  2 ++
> > >  4 files changed, 33 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index a806820df7e5..cb0ad99e7a0a 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -2191,6 +2191,27 @@ int hid_input_report(struct hid_device *hid,
> > > enum hid_report_type type, u8 *data
> > >  }
> > >  EXPORT_SYMBOL_GPL(hid_input_report);
> > >
> > > +/**
> > > + * hid_safe_input_report - report data from lower layer (usb, bt...)
> > > + *
> > > + * @hid: hid device
> > > + * @type: HID report type (HID_*_REPORT)
> > > + * @data: report contents
> > > + * @bufsize: allocated size of the data buffer
> > > + * @size: useful size of data parameter
> > > + * @interrupt: distinguish between interrupt and control transfers
> > > + *
> > > + * This is data entry for lower layers.
> >
> > You probably want to explain why it should be used instead of
> > hid_input_report() in this doc blurb, and modify the hid_input_report()
> > docs to mention that this should be used.
> 
> Good point. Sending v2 ASAP.
> 
> >
> > Maybe hid_input_report() should also be marked as deprecated somehow,
> > to avoid new users?
> 
> Well, it's not entirely deprecated because, for instance, in uhid we
> only have the buffer with the provided size around. So we can't be
> less restrictive in that precise case, and then switching to _safe
> will not change a bit.
> 
> Cheers,
> Benjamin

Hi Benjamin, our CI started failing with commit 0a3fe972a7cb ("HID:
core: Mitigate potential OOB by removing bogus memset()"), so I was
hoping your patchset would fix this.

However, I just realized our call path goes through uhid precisely,
which still triggers the EINVAL error since uhid as not converted to
hid_safe_input_report().

My vague understanding though, is that uhid_event uses a static buffer
in ev->data[UHID_DATA_MAX], so maybe we can use that through
uhid_dev_input{2}()?

I ran the following path through our CI and it fixed our issue, so I
wanted to get your thoughts on this.

Carlos Llamas

---
 drivers/hid/uhid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 524b53a3c87b..37b60c3aaf66 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
