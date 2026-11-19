Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122794;
	b=kA/OJOeIcJqTsBCmzAgA54WPigwnHw3IwaLbxywo39gDfCXLdHYPtnjJsJl+2OWfqCM9
	 GC4G/G77VtaZWkyVbkWokyvZspIYBDJbM58+XQWA7PKwvclrDxZWqpNV30iEmCrfohNBT
	 BQ6rL8AgtdFfXX265szdHeUPVt6ypmi9DsriXgHZZOwYv4pC9HgKXflj1VtLrq9F6O4gl
	 0KFRW2YapJHVy9ZK9vnz7V3tWmcC0CxeV4CGW68/4/48GDZARl2ovJYkrVziyh1h4rn8C
	 kfNm6QhtmD3fiQazigm0Cvh3byDyX/HAPBs0lhUaRJ1MmngM0iUhMzsHXDK+7ot2RYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
	b=Thyrg1G6n7qSOfAcwOoyB5GhWtRAuRr1P0CKigXlpJELHk4dWY+M+Uh6bNbhK4//upox
	 vaCTe2DKeIeTFKpFlxm8xApvI1zPUHMl5VenghrK6Za17EjGHv3alzz3hPt9SLBBl9+CY
	 aaYz4kqYBMgzWWiXJZgJXAG/P2c41mBP267ED0tUl2dxu4ySTmhD/8f/zNYYgvlx9Czhk
	 MxOoo6RHI644K0KS+FsKpHJ7hAfN1+8dha0a+rpdVWPX92MO8qvvFKbicpU2+A9z9mN3/
	 CfPyoZU3UKIpBt/kQyCwAH83DupoIIbW98cLbexiUlyKGf+uq5ytsXSAI3hUHvO/sXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dl5GeA+;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D2606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 21:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4D2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dl5GeA+
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso241614c88.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122794; x=1795727594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
        b=0dl5GeA+cuu98eSuEIfdB5v3gs+RER4Sz0Ip2hbbediS8SRXexbHcSDI+c7udg/BiN
         PkvXk2q1Xe6/Blxx0anGyQ7Vy+QA50JzBwM279PPaciCEmS7p1pqpVpJIl+GgPi6jtkP
         K7/tFf9ITvg4gpMgW/tMXw6+TRyDFZE2eavjWGya1JTEU9+wAQwRWVoNtw36VTgtk3Fn
         PR5uXmjYo/MrrnEXFlch0KoAnv7ozu5OxPVWVBK5Zc97A6Pp59otBuv27siSN3IGAYNj
         Dv74+sAK4mbHLHsEjk+wA3ACpL3HBJx6P9dfa+/NmXPel5duaXGaOmr5BvOrI3F7eoui
         Xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122794; x=1795727594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
        b=eoH9wRbHvVNMOR3x52tgF/Q/yBrmdn7UVYVyTpi3a0IPkpTJkCdon+eU4XxpRbBw7G
         LlDbXPdIP+0A2jtTGY9lnJaU5CNEgNO6C1/jdxT239Jo9gDgnCTs/VkdSeprpbzdc45Y
         FDXXTw3ol+G+zsBBCXSOf6wEhNfxrc33MMdeZNAYMpYpbP4KvHKobTbvaAOLeYbZvO7X
         uMXAHwDreO9Cn21hBFndu8DbCA3zP0o8tw7TsP12+wiFvIoBSNkgzwNcZ31HHt9bqDF5
         iiJS3CQibCKZaOTp8U+clNNQmi3Tr1Gb4/xL5wrU1BTDmGrXey95o7fCC80NZCnNCeP0
         jfog==
X-Forwarded-Encrypted: i=1; AL+hErEMamtcucP1zUbyFn2G5bL0fCFb5ucSY2dJbeOlDfwQnbGQUSXOEZqX77uY15cIOV/2H2bIEdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sd4892MUcC8RFyU04fYeedMLNHXz0ttKJkXZXgHUS6y4uw3xu
	LtK4yo9ZbVruWHzQCE0YB1f5VIWm+uzN588BvMYVkB461nfDOYh3xB2G
X-Gm-Gg: AZFdTZdOm8DenwxvrF4UrSM9KzeMx+3GNaylR4Eqd12kEzL2GBBQHIUUdZ7gZUz2VD/
	KiwEBL/4E7TOVEN0fcPTZrOVYfNPRS1JFOOq/4jy93Pd/ICyZfMbAcK6GQ+PbP2wSiN6IBr4daR
	kmFaBlBxAiXP75PHV2UEJOb73JiVm9drhSKzgPA2JPBrxA5DnXNs5HN37NUceVWdwLt+3Pa/8UV
	9MrB/WMrhuEowY0kvYADYN/9x9qHNj24ufE6cwJVADO59rR2gjM+eyKvWCt1T2nwdzdKezG8YCh
	JSp3dWXGiTJHt8ykLtU2eswNdOem3/n7eNyeiCzV+1nIoNEtcY2UMCRWkZLVYYbC9ENMJ3hNsDN
	b3aD+NNL/OACA5DThfcr0bAt0j1A1s9vJrHzEExLw2tJ+rvqCEWWIUFgoMJSnJptA8OXjX6b4z4
	zSlB5DEjRdmystWkWzV8Bm6cQSMYFZrI3w/aFPb2EcbR8aEusavOyTqlKRDy0SsBTH3lj4Tpy4V
	w+Q2ojPenncbOxyL9PG2WZoVCDS/4nU+Symkw1zNr72GfbI+hEUdwCJ2FRkBobjv28koAJQmu+7
	yqkGiI3Hw9uMp2hoOoqUOI83q2sqJ7NOfrnET6ZA5gZvXhO3EsHiXFqcPAkHO/z8Z0fZO4I=
X-Received: by 2002:a05:7300:d218:b0:378:1191:43ca with SMTP id 5a478bee46e88-3856fe552abmr460254eec.18.1795122793583;
        Thu, 19 Nov 2026 13:13:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:861a:3517:4ba8:8641])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm1288871eec.14.2026.11.19.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:13:12 -0800 (PST)
Date: Thu, 19 Nov 2026 13:13:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
Message-ID: <av9mLqY8TMOhJK2-@google.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
 <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
 <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>
 <av9lbJa8VlQTeatR@google.com>
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
In-Reply-To: <av9lbJa8VlQTeatR@google.com>

On Thu, Nov 19, 2026 at 01:10:45PM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 19, 2026 at 09:36:07PM +0100, Jiri Kosina wrote:
> > On Thu, 19 Nov 2026, Jiri Kosina wrote:
> > 
> > > > Wow, what an endeavor. Thanks for looking into all this.
> > > > 
> > > > I've finally got to processing it. I've applied 1-14 to 
> > > > for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.
> > > 
> > > Ok, now I see that you will be respinning. So I am dropping it for now and 
> > > will wait for respin.
> > 
> > Are you planning the respin to contain differences only around the 22/23 
> > patches?
> > If so, I'd prefer to still take the first 14 through upstream-fixes, so 
> > split the series.
> 
> I do not have any outstanding code changes for this series unless you
> have some comments.
> 
> I think if you simply drop #22 and pick up Gideon's tested-by you will
> be good. But let me know if you want me to apply the tags. 

Oops, sorry, I forgot there were couple of Sashiko comments. Let's me
send out the updated series (I already made changes earlier).

Thanks.

-- 
Dmitry
