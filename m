Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122650;
	b=t6z9FptLN+CYgsubKXRYyftf5GuY4McY6XjqM8dMqddIwFTahzdmembetY6dU3G3r1Ml
	 5alxFdnMKkuigKylyxFEo1V6ESGMalfX0vOQD4/F6WuqBZePLZb2sNH7Z1vAbn9z94vU2
	 QvTP2VcumMdB/31zZAHSbS+LtmvAj9pqbWcnmZnIl4kTClT7H+mqFcKJVViDzYnYpsT31
	 yanP4AeXyCBvxBoKm3895VFOapfdt93NoC0Srs8UhxKxq1Y/LWveaohtXJpEWzbc/oeEd
	 tRUogIV81DYVY/hjqHN2CVeusNE1/Y1Cdd8sbu1bmH3Pb8K9fxyVsDy8hQiNicLoR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
	b=maj6mOmMmnHqHkNkI3pOKtG3GtLEDaXn0YjEk+6p4Umbe8cI9QWu1tl1QLXznV1tcB+2
	 NIpqjEtOySqNR3lh537ZU6YrNLMeFZO4dbND0x0yJ9z1NORyC3IUX6FK9pFqXkf0Wm9gO
	 t4KrBo1HrfgaYAZ3WpTiD+ST9ZepNPPNOWa9iSIBhZUDrARiWhbC5OdZTAINFJos9Mwk9
	 wX4VW705yQxMr6N9AxxgKreMKMt+QR1vWDnpibj9gEv9d2A5WHlAC0Aj0TmsuoYEFSCe4
	 qka2IavFP/1u9ZbuSu0yP96zZxIJrPbzrMwrbREnOiH8Ck5a7UxC8WDFh8zCOQsN3EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCP3kLMX;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5D606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 21:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD5D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCP3kLMX
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso238973c88.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122649; x=1795727449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
        b=iCP3kLMXRPed7S9bJiG09JN/i19X4EoKdfuX47yJoyHTjU2fP14WJ46M688r92Qp5q
         +huNC4FWM7X7qXkM5atVyXyOoxBHx0L7e84UdWP7l0GkReWXfnyI9t4tJxbquQoQsLhe
         1pe1DSTPLjKf+XC5qZQ5FGRSAFvEhvosPiuS/UfhKZzWwsWKs7BKZXQK0L3TFb2gsCpQ
         EfneK5gQPeWRs1j+tvebD0EgjIJldr4OasjqSLqWiRc8H/CX1ztng4w+nrqRD4ZX6tkY
         SBp/yjLUNhxsdMtp/92gznC4m3/M8+m5OlxJ1bCEbbCvKFkN/lCpi0suNNxTzyoKfC5A
         Gvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122649; x=1795727449;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
        b=pE/bSn3DpYgdAZTa1V8ceYbg7LM907Yp3DYDKuR/gbDPB5kRlMoNi/Vt2Wln/jQk/D
         fuf1ikMIIfiLfjmUipqxt2+rpeh3/6xo3e2v15Wn/g3D13Fnhd8Fr4lyzSfb6ETKGaJL
         2N4XZnjufgKYq/4dfRy+jjGhT5TkAmfMWe+UuNzoYx1KFHupfyKQcacH66PEMBvYl7dk
         UWcAHU8lSz1nWH4aPTfC6ixj0bVBIyzmhgkqwBMhDN/EBSi/SH7WSXdVZPoaqrLw099N
         88+4UqQApEpcd+FES358FwY7wd+RHU53h2NoTQUnttihF0QJdDF3StbKyLwDMLCO/FiC
         n3dw==
X-Forwarded-Encrypted: i=1; AL+hErFl4p8az11dJtoqUuNovvjcdRriL/2Xih3ilY9KOrx7EZaQ2ljJmkIuWa2XRU2TYc+vzycMd3U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gu9anMcC8CMatESaReYP+gfAaQuwrlLJ5gIi4e5yiqIxrxyE1
	UpwzG57/ZVD/MGEpmo+InCmtPiBQAIyZs9FboN3sQe3Cj+Ynis4ltazc
X-Gm-Gg: AYBFou3H0MHC+Q+04TPmTduc1zyxSop4XHioy+Z88KAysnzCa+z6SBYfUynNKG+wkYQ
	fAwNRH401m4OZrEByLTEgkVxnPzwjXIEdpPoWMKQlimusDmpysX5Kb3WIM5SfvKUsqtpajsa0eH
	RzN3tvVpUWzZS3FLwRlfZDifb+m+y7TV7BoWb6o1wJsFtt4qN3LACVybn+uRYuElYaTcXu/daiw
	IO63xvTVJu8/juhUD0wJMZ463X03emOwVvJFWP9llDJhX6YSzkAbMVfyjfx0+LottZAjExAOYXA
	pM1avukBIbsdJmur2YML/NV92J4ey3P5TXd5Vi9LVel1icoDH4O1M761nK3Kn7d0/A9pPj0gN7r
	wK4mULDChxHkjrK1mDeeuebxuFY+hEcCJgxp8kYznFH/5096XPcp/q2167aXrNgMeQ+NkvYfzpU
	SqSdoHaPIiWRGNJkpK8lmwJk6stQcocLhExsluhv/lrj2NDMjkwjDFPjwnVLaOAGjaAAg5DbE7t
	YSiHda05KLo29qkfkhRyXv1WTI+LayYkcyQp5yfl352ybsW+jbZyvvtcu+OaCDauKubOeI8eUGg
	hzK7b+gKp45bH/uAR7AZLE2QGle1qWVL8JPyxhh0y3mdZCbL1V6PuSzaOVrD3SQZlMXLwx8=
X-Received: by 2002:a05:701b:2091:10b0:1b5:3616:59a1 with SMTP id a92af1059eb24-1b55687e5b9mr800510c88.8.1795122649174;
        Thu, 19 Nov 2026 13:10:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:861a:3517:4ba8:8641])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm1312003c88.0.2026.11.19.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:10:48 -0800 (PST)
Date: Thu, 19 Nov 2026 13:10:45 -0800
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
Message-ID: <av9lbJa8VlQTeatR@google.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
 <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
 <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>
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
In-Reply-To: <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>

On Thu, Nov 19, 2026 at 09:36:07PM +0100, Jiri Kosina wrote:
> On Thu, 19 Nov 2026, Jiri Kosina wrote:
> 
> > > Wow, what an endeavor. Thanks for looking into all this.
> > > 
> > > I've finally got to processing it. I've applied 1-14 to 
> > > for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.
> > 
> > Ok, now I see that you will be respinning. So I am dropping it for now and 
> > will wait for respin.
> 
> Are you planning the respin to contain differences only around the 22/23 
> patches?
> If so, I'd prefer to still take the first 14 through upstream-fixes, so 
> split the series.

I do not have any outstanding code changes for this series unless you
have some comments.

I think if you simply drop #22 and pick up Gideon's tested-by you will
be good. But let me know if you want me to apply the tags. 

Thanks.

-- 
Dmitry
