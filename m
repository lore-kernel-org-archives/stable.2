Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212987;
	b=z7ZSk6pm3f0oYbLVxUyFni9vhLxKBoAtUT1Ag4f30qikEV9PjkzRiUdclJBScDJdIJN+
	 eVfJdbqMCy4Q9hr3WjFGPOwWG3bKIIBVVJZw4XtH7yyK86/egt+3du9b0gDd/ChJ80iTf
	 inuT2FrskuSqLf0aGg0TIy7w66SK0d3cO3pbXb+y3Mn9eJ9uHUqS6PO0Sf3py+2sGGlPb
	 ez+BMVy9LlvqyXEzzAhq4wey97v6zKZyr5q7KMtOO9H3G54zx1wQ1l+Wyn1XurQ+i19hH
	 2pdxY0Mw6KyGReDpliPq9Z7zq5o1WZB97fr0Wl5EyAiYpu53SxuVJZUAakXZoPuVrFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
	b=vnyoFR+pCaRYuVX2WVr4aCTbWqssSg4BNHNbuCdiLq0mID8TesaBo4uRgd258/s1/Fdu
	 v6XTl3FNtb2ZiigUzBVeWtbJjtUkpSjkmAsq9pryfKa55Yxfg1sdZHHekdby0ZxxzoiUC
	 9Cv8DdL34xuza9SA234oRGjd8M4betB2m1hcUqwh2ZMQhevZ7wMV+kqkDY987U29Ptki6
	 tg+OSUmfGlNhodotUgz/8N1vf9tU6XMKNg8qgVaqPEZunngpbIVZ3TrBipnTEv4jtn6M6
	 D+cmGJilNAiryp8vNu9UyqFtXEDAzsWU5SRKos5CJpOMELXa4iOG0CNUb8hYDbr+daw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbWXu4G;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019A606A6B7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E019A606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbWXu4G
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2818308eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212985; x=1795817785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
        b=CwbWXu4Gf67XgRQAKW83cKuO1Tx7sE4RkWJwMBpwgx1bN94kAgrbAq0z24RU/nxf+N
         r89b9CwxyQrRXre5mk27unPLZEFEmxfR4d25UpRNK4VbTjRzGlRlul0SLmH2eeXBh0IM
         R52jhZbmX9rsTNqqfWeXVsv74sC9jDPseXP9nMaUeUlUPWn6A+EroFQP4MoGbl+iiQv3
         73AdQQtnBebyldtmb0kpmdwnzrWwrKaTzHqWziOcMtbnKpwsVwq4QS/62g1LhHqAzfi2
         E548CbBRuAMcp7BrPq3IUIu29xFjFcxgNgh2krPHLKpkJaEbMYDFJoEUcktbYO/59PQp
         3fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212985; x=1795817785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
        b=aqaYVFDEImXNZz+LCZ/AH5RJd1ByF/mSgynixYAWmnc+8KpDCB/ZKJ7/Vfts9SfYFR
         99q/P+RuU073DmOwpx8SQrUJ8wxRSHaiXGafYjwkYVco/5tIOFQcOzP09WtBQ3nx7bn5
         ZP77RJhjJZoppgYhzboKEGvwS+pFqYxUkns1yfv4pxTP9fnnLakY4u74z7cfJqevA86E
         qI0RG598o0z7n9pCnEbCVVHL/o3GYAeKAq7aPrSGIH2ogw60nAYeoOFtlVgXo95y3YBA
         ciln1+fOrQhUQeBg1edeW6ZsNRo9qi0VtZH0HckWF8iMCNdqJWDG7DQoo4YHLMcIO7iN
         HCVA==
X-Forwarded-Encrypted: i=1; AL+hErHxzRFTaJMDYhAXrUTytYW+67hHeJjZIH91E3neivRmjczr0935jHMkWKda6Yjjh3dJKDewJsw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3WI7N/7pwYp/c9XlWS4GZ3vI20rwbj+wVqDKx/PnCAPG3VS5Y
	6MBM9JOKn47+8LZqc94W4bvpqNOTwVfJik2yFHIVmDVLqnkvZUyJs9Ze
X-Gm-Gg: AZFdTZcBr+Cyfey2FsgQGs/FQox6K9MEj89mGjTQRA7D1AAYp2HHSPpt2z7rdMaqFCM
	6wdQPGbBzhOoG89bFjupQZm6C+XvnoRvGQV7104HPHGGqEpb/5id+VOEzM4cqqzTGcoYEPkFcGE
	lfTP4ndZgoa4Ae2myw9l3xJOYlZGa6auKi8tcEiuEiyl63bNYL0nfYzaO6xsYI/tHnwO238Azm/
	hg/GbUvm+VkqIpxKr+9ML79LaC7OhcLakRjMghwAOLJsWhEAzTn6dKD6fhvXvUIktW3spubKkJk
	WH3RqOizdXDxNyZaM7KTFjZtiLOA++gELfx7LeMLbirgz8F5GziHx5OalF+3fJFk0tCebqpGMOg
	vF//ovBGPLlEitvakjd11kHuJE459hGRt6HVWPsZ3ZDSSxVCSuEVSEsxDqMcoxYm4KQZFfi0jFw
	jkTUyMdqoQBOxdez/D/r9PCGjlUkCWpb/c22QPwgmdkFTnOohIsINvpI+1kYRYA1aEQI4cBzFLw
	rGElp4RksPdz1ZTT9iHN07EB03smZxVJzxGvySPuZ/SxEdYhGwxLyA9jRA8YXg78eMbedw3mtNT
	8DIaFmZ9PyU3Nfc+ak1qprInexcuNnqx5m35SECIC3d8Yt9XqskmnU80g7mLt6QmD5Uv9L8=
X-Received: by 2002:a05:7300:f483:b0:384:e31e:3c58 with SMTP id 5a478bee46e88-385714160f6mr4024577eec.33.1795212984850;
        Fri, 20 Nov 2026 14:16:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm10787009eec.23.2026.11.20.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:16:24 -0800 (PST)
Date: Fri, 20 Nov 2026 14:16:21 -0800
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
Message-ID: <awDGXhaRpNcNirgq@google.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
 <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>
 <awCMOvYf64DZfuWF@google.com>
 <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
 <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
 <op182q3s-q21q-2r18-9p5n-60p7003o64o1@xreary.bet>
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
In-Reply-To: <op182q3s-q21q-2r18-9p5n-60p7003o64o1@xreary.bet>

On Fri, Nov 20, 2026 at 10:45:21PM +0100, Jiri Kosina wrote:
> On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
> 
> > >> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
> > >> just applied.
> > >
> > >Hmm, but that cleanup is sitting in hid.git#for-7.5/hidraw, while this 
> > >build breakage occured in for-7.4/upstream-fixes, which is based on Linus' 
> > >tree and doesn't include that hidraw cleanup ...
> > 
> > Doesn't next mix it all together? 
> 
> Right, the build fails on for-next, which is a super-merge of all the 
> topic branches. Sorry for the noise,

So how do you want to handle this? Keep this series as is, and apply,
and drop either entire hidraw rework or just the offending patch and I
will resubmit it once Logitech rework settles in?

Thanks.

-- 
Dmitry
