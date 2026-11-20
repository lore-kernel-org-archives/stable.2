Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198136;
	b=DcrVj59UlRavQrCAJkIzCk/07p8XQE2EExV1HwG7SjSqGagTFNPWznAdsvYL/lace7UR
	 8QRH4g6QEiSbR3WXODE3PXYAPoxWaBhcGWz9vPDraUUQkTX1ztbBk6jAnqPqCg4xh5wy3
	 wHcBeNvIujJxD3HPLkDw8F/AAVpZc2SEj7zdyex3GCKSUK12b3Ll0E9pS1Auep2gtObi/
	 bsx9Yd0rqbAVbjsuSVnayiFXScOXI+Gc9qH2LL3m8Wq5om7xBNAIZr1BEQdmthBqalXvj
	 hxqkiILjCPDbhyckgdOwJxHIr1Apol8+b4Ms9FuEXC2UbKCg2AdAeNQS5ZIkKG7kSaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
	b=YS6R0snZcgzn9T8lHJRLPPCHKA+OVcKFnTiKA4HOXCNijbgN1cI1+BmBcM4S+tBj6mwC
	 W4qe/HSTZXabPZshOLVcJVe/NlZ1pqLi7NlNLZhuxtt1aLqvAwQKZtcoxsdjIsyU0nxkc
	 9F+l7/a36F66rDNY9y8itS8MfrtkarSxw+w22PSMGIKVK4auG+k6y+1Z9g1UDChrIarPC
	 pQ5cdl72hjWY6SHzefZHGM6J5iCQ6X16Ud13RrQ0pspPserPR45O+J7Vzll5QMWNJ9AXu
	 y3l0sIKcFeMIFCM47Vyjhg1rHzy6WX4bL8A/g1OMVGxk5mHyIkF/InkEP9D5uJ94nAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFc1VxT+;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBB606A89D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCBB606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFc1VxT+
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so1947876c88.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198134; x=1795802934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
        b=yFc1VxT+yT2G1I/sGQRx4QibLodUnLsBaTiSPX4XJ0/pE8Jva6hBD3bLnvD/yNGTQp
         uz9nguZM9AcuI9q4QQNXAClP6zHpfdRgmQ1nbf+drQcjiJfvlHeh9uKJtcLWxDQ9BcN8
         0ySVL9Xj1upl9OvwyIQtqzNKBTaPmsSJr9VQlx0bC5R8IHXoUkCPkuQrDshql5pcDHc7
         t/r3cfkLRToAOdxiRN4DWhyq0wY2GLff8p/bGpCnaj1X3kjIIy6Q9v5mO65dBQJIfZDe
         tmzw8Lmj84ze00OeZ2ZWqnceTXtnkPhauJRjBeOxGO41qYPyYlc6zCYkNx8NjFouSd22
         e0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198134; x=1795802934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
        b=dYwYE3nPqJpfoo3pU9IKSK3RLedAJxMApC2XQ8syT+Yca4vyt7ukSOPbeCJPLi4N3w
         cd9EhfQmm1s7mXncYKN7QZCLo/L9sXkBd0VgDjUT0HyPNVkjkxIMyecKML0Dpm2kz4VY
         qswuqvy8KWP1DHPfTRGU5pTaV0Emm7vaoJwZhZSE1a8ow7kCVxawikIBSdox4w9EpOUA
         NZTnoA0fyiDu5psQj+bj9NXw6vnNGqlReYutdAtLV/LOw6AL0goH6ZuPuHYkpDIXAjXY
         rS3L/cYbRkMXlEB9bhxJEtbAtud6STjqyuGgNNl4QoBkTWQyVsQ6ZIT4p28rVY2lwQrG
         BJqA==
X-Forwarded-Encrypted: i=1; AL+hErEDJJOS6JSSSyFBGvwtPH2+epkT2G7KHndYxirAqdUqQ0aXoebmAMRjX0KWN3BxJgeiJFy2uwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3GgZHP8CosNJLiyNe+xvMgPGWnlwJrvIgiGB5sQoznySZD6jT
	K8h8O5TcwFPBTPD8jcYse3Mw0pE+w4/sAP0wPfeeJ5QuSmiWiJxrTTjp
X-Gm-Gg: AYBFou0F7x7dMVSdvLtNaBDyieSrhNCIrJtrOWcxQtz2QPPL5ILXTBTm9+eIfanh6Lp
	PGboHuJPG9ctmm2c7ywsuuIPJdv6Omm4B2b51G/bjQI2xS7llItAhhTTTnaaB2yfB+DFa8Ky+08
	K7ai0/k1oeFBBm6XZAJYLeb8VhZ8Xaw+2vdHam6OWLJWHhG/LqUY79tqrtKcf5DgOzAPPwDK8Rw
	9t0ryannEOtkpfYh1ZcTCvfrZwa8gQjD0S6+bRu/4UDC2AaUG6Os0fYvcz8bZRCvoYIGWGFhStU
	95yYAQbrKZG3I1N/obH/ui6x7ero61JLRU9Nx1/czMH6ajh7yjITAzBaMuzJOFslpcC92FWf0eD
	ypLZ1PGLUTDGUh6M9UoxW7oWsi102iWQPyqGy12ENfASXysVgl80Egvdgcrr0kplZ/VFg3Hmre5
	g2MbDDkedP83O5v55FzTL9evSXSSt8NqfPvqZYhWdPs3tsbMGAyHeTw0VygWy9N/ujvjWjBWmiw
	P9e5d6DK/eVVAQMD8kPvY4W5cBeNRSpQfjYoa/vjn7HSiYEobTAJlFSv5kK5zI5dBVhhQ//Divy
	Y0SJfuL0pIprh4v4JElsQ2GsXN2g+4iNIlp92Ljd4kXQTy4CvKLQ/PWPamTR63YSODuO3cc=
X-Received: by 2002:a05:7022:ea56:20b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b5568a65ccmr3689459c88.19.1795198133548;
        Fri, 20 Nov 2026 10:08:53 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm7761240c88.0.2026.11.20.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:08:52 -0800 (PST)
Date: Fri, 20 Nov 2026 10:08:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
Message-ID: <awCMOvYf64DZfuWF@google.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
 <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>

On Fri, Nov 20, 2026 at 02:51:29PM +0100, Jiri Kosina wrote:
> On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
> 
> > Device removal and the probe error unwind path cancel the connect-event
> > and hi-res-reset work items only after closing and stopping the HID
> > transport, leaving in-flight work handlers able to issue HID++ transfers
> > or register power-supply and input devices while transport teardown is
> > underway. Moving cancel_work_sync() ahead of transport shutdown is not
> > sufficient because incoming reports remain active until the transport
> > stops and can re-schedule the work items before hid_hw_stop() completes.
> > 
> > Disable both work items synchronously before closing or stopping the
> > HID transport on device removal and on the post-I/O probe failure path,
> > and drop the unreachable cancellations from early transport start and
> > open failure paths where incoming packets have not been enabled yet.
> > 
> > On device removal where HID core enters with device I/O stopped and
> > driver_input_lock held, temporarily re-enable device I/O to flush
> > pending work handlers and disconnect input devices before stopping the
> > transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
> > reports can still wake synchronous commands without dispatching events
> > to the disconnecting input device.
> > 
> > Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
> > Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
> > Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index d5f53b35ac6f..0e1a9fd98faf 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  	return ret;
> >  
> >  hid_hw_init_fail:
> > +	disable_work_sync(&hidpp->work);
> > +	disable_work_sync(&hidpp->reset_hi_res_work);
> >  	hid_hw_close(hdev);
> >  hid_hw_open_fail:
> >  	hid_hw_stop(hdev);
> >  hid_hw_start_fail:
> >  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> > -	cancel_work_sync(&hidpp->work);
> > -	cancel_work_sync(&hidpp->reset_hi_res_work);
> >  	mutex_destroy(&hidpp->send_mutex);
> >  	return ret;
> >  }
> > @@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  static void hidpp_remove(struct hid_device *hdev)
> >  {
> >  	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> > +	bool claimed_input;
> >  
> >  	if (!hidpp)
> >  		return hid_hw_stop(hdev);
> >  
> >  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> >  
> > +	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
> > +	hdev->claimed &= ~HID_CLAIMED_INPUT;
> > +	if (claimed_input)
> > +		hidpp->input = NULL;
> > +
> > +	hid_device_io_start(hdev);
> > +	disable_work_sync(&hidpp->work);
> > +	disable_work_sync(&hidpp->reset_hi_res_work);
> > +	if (claimed_input)
> > +		hidinput_disconnect(hdev);
> 
> This fails to build, because hidinput_disconnect is defined in hid-core 
> and there is no declaration for it in logitech code.
> 
> I'll drop this series for now, please fix it and resubmit a version that 
> compiles :))

Ah, yes, I un-exported it in my hidraw cleanup patch series that you
just applied.

Hoisted by my own petard ;)

I guess we need to re-export it now that there is a valid (IMO) use case
to have it available outside of the hid core.

Thanks.

-- 
Dmitry
