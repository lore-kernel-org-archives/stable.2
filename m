Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560337;
	b=mX8GUvDJMNoKY3ajXI4yu3JVr03w/reZFhsHLb7om/ckNr+1DE85Ena8W3DdIxlOWemG
	 jNVzYxSasjGQTjM6TO/7hgsSC2ofr45st80A984v+TaFcHrizZC6GTHlEK28+eVJeMgnn
	 6ITHDcBbh68GFn/FKX6AHeJ0gQ276S9TdVckJcX5SFUVhnQrXZ4IEv+bQ8spXDTgL6sFg
	 vfXaTJWHZUo2b3ONQ4Kp4JxBcda/VUc8pxU0423MI2glCv76UayNYaiqtBHC2RhNjmiKX
	 HkWciNhhBFTxdI9prInQ0hOrEdqe7ZIMxmPkHtKG69KiERwQQ6IFQ6b7IlfsmuskH7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=V5sYfwDMH/K5iSEu23/0IBbtSjF5KPb2WUam7m4LP+k=;
	b=rMYCjCybMzShkWUJvKv/Yzr7ZaIYVytZ29vda08yJXy0AD2nK/Sd9pX95n2lLtCFdd4w
	 gQjhbyxRiZPXvm5ADDRwWM/nSPArmkR+//aTDeK2kijROVgXI1mCPZllpy1lyMsMiNMGL
	 8Hi7d7nUGaYkhMBvToBlYZTSJhPMI9EVqu40ZMphYsTpYh6uybULkiTGBAlnQr+wQjczu
	 Xj7QSsdqZIIr3tlj4fMoRqglX/UGozhyswxy8BlFOMxw7DevDRn5BxzdkxSNbhMEtNv+u
	 07KFXkjRi+9oHZuHzLMIxLmgD+zD0+4AhM0ztVKTLJOtBHv3C2hmx0/ZWxaTGDglEWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="IbPW/3nb";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC0F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IbPW/3nb
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c516a192844so441878166b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795560335; x=1796165135; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5sYfwDMH/K5iSEu23/0IBbtSjF5KPb2WUam7m4LP+k=;
        b=IbPW/3nbi7ZvK2Cr6RWP39Ces0R00/NjmV6EEjpjtit+MG8J21HmhPjo92clz92nBb
         47p7y94ilg5HwlMdqOyL3QCZ6O1MePR/DwWf5/yCB3DRqlamX92BXoOnoRsLWEp/TdrX
         iGJkI2SaV6Gl22xmjifdBg4VYWTQ//Ff4IVMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560335; x=1796165135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V5sYfwDMH/K5iSEu23/0IBbtSjF5KPb2WUam7m4LP+k=;
        b=NLQtWi3dBZNSsSEPV2+875XvOS3RIkZ0UjjfFHkFKZPEJIrjF14pttcL8EqH3eAIvM
         GwCUaex+CF/HfvBDtcWbs1uV6aSP84aETjeYGl+Ru/oQJoa+g+PoHAY8/oXeYwWdkxbt
         T1VEzgZ/9Feo5MOw+nfxOdVPcSeZJTRgTnnhw3F0PwIcPH49PYF7IHbQ1uNvbhjEkETt
         3ea7xSZ3Kkv35RnVHyhx/nNA9RlXlQbdwkFyCuwJwjwzHQvNukbr3deNbJxz7TZeb+ws
         rRFS9F4x4Seu9aldx+Q3ywqzlSdKvGbfSDiGzW1qRkreftkYp9qLihMDAywAD0+bCpCz
         TqOw==
X-Forwarded-Encrypted: i=1; AL+hErHdnjlfF5fq/Do0udGOT811a8DZPMNDDex75iVNlRrtQ9BkCZ0UDE0rPFDgO5WHx3F42hxYAig=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rxhVTMF5qskeTZ2o+99Zk4gyOr/6x6QoDZdEDLjZyCn9fwcQS
	qbSnNDB+04HFgLz2BVWjFJNTaumzHwxwugSJ2x9QTWaucX+RqztKk+Fkj1SJeHQshKmEkXD/scj
	RQpNwsirHbg==
X-Gm-Gg: AZFdTZf1/w8m/OyY6sZoalPtmuUo5rVLajsQesA12M5tUP5QzyQ/EuTPuAs/MrCKeD2
	ovMS2JiVaXXtKwGMMldLg82tj1guh9BYh2qC/siDr8pHh2lSTosPy1Kxn77YiRqse2dp6ob3eR7
	bL5TUnaXKQAIu9niyFKcDIyrk+IL3RZ36ZMiTZHxvocszx8/l0ol7W+kC+0MPsgN2UhC9KNNSI6
	QXFNi+y91AR7e9aqCKZ2wGLfPsSJzeNgTNaPa9l0egnIyVfpJlNF/rY2eZS+oRwtcw0AwT8d80d
	OQZY/9cMrrmv5bsIyTdfpdXxLa0REaIwVVkSl3M+jo1X1QnO6ITefT7KRT49Cn6xHyJCvAncb+L
	oA/d0qm13+DRsx55zSY1wfhF5jMOa+/o1+yOtp2z5bVJH2LelzCFl8pAiYwHvZBeH3leAxUtN/K
	oD+O41dK/Ds4ffrdxClmXOBGRV7CXZH+hozfLSxoK4X6HooDoTWqZf7Lx/l1VnGROnqp9UT+iIX
	TZeReD+ro1UcEIkozC8mf5iI5FmJ/uQBjZHWX5Ammivg1wwrFzHYsPaO99VYXlwcWB0FOKmHZ9V
	TZreKuqi5O7qR27e9DTC9eV+vG9ICrRNN32K0dwf3JHagHoeS7LpodpNKjNb3hftAqNp34Mr2TA
	5mek=
X-Received: by 2002:a17:906:680c:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c513aaacfc1mr1017882766b.38.1795560335041;
        Tue, 24 Nov 2026 14:45:35 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6841asm577672366b.24.2026.11.24.14.45.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 14:45:34 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c516a192844so441875166b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH1DJhBOgLms4u/+X2pRwvLNww9zYXsO/8NWvXJRvS+NVQZCIRvyialOcfAbJpjJZPUlwRQ6cU=@vger.kernel.org
X-Received: by 2002:a17:907:3c8d:b0:c4d:8e7:29b9 with SMTP id
 a640c23a62f3a-c513a43532cmr1247732366b.5.1795560334053; Tue, 24 Nov 2026
 14:45:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <fb224bad9baf5f44cf17e1d664776a4e@kernel.org> <CAHk-=wg4jAWZvxWo0OZ+fFTU=SBtQ7dnsUCV7hx+UAifkwPUwQ@mail.gmail.com>
 <avs4uWg9ch-Bqobj@slm.duckdns.org> <CAHk-=wg+MO19H7KVgA+SaZvvt5O+3Tp8AxHVhpN23JtaSq=G4g@mail.gmail.com>
 <CAHk-=wjm3vbiNYsR+aHxmM3KCEgsSWb379ZQbCuZEsN1dhvbKg@mail.gmail.com>
 <20261123120125.375076-1-tj@kernel.org> <8f4845c5a8f9f8927ab3903d6938b3f9@kernel.org>
In-Reply-To: <8f4845c5a8f9f8927ab3903d6938b3f9@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Nov 2026 14:45:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrKQDEtPjHv4COh3Y+PHVntX2V6gZeLqWV8uHUz_ePFg@mail.gmail.com>
X-Gm-Features: Aa3M54r4Obmz65qTRKcahDOrnNP6nsZ9FLK3p7kXHoVLqWiGH_ZNRDKlgOkrm1U
Message-ID: <CAHk-=wjrKQDEtPjHv4COh3Y+PHVntX2V6gZeLqWV8uHUz_ePFg@mail.gmail.com>
Subject: Re: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue() missing
 work items chained across pwqs
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 13:59, Tejun Heo <tj@kernel.org> wrote:
>
> Mark Brown wasn't happy about the missing author SoB, so I made myself the
> author and switched it to Originally-by.

Honestly, that's typically my preferred form anyway: when I send out
my untested patches to maintainers, they may work, they may even look
real, but they are quite often meant as a "maybe something like this"
kind of thing rather than necessarily the final end result.

It's just easier and less error-prone to send out a patch than it
would be to try to describe what I mean some other way.

And I _really_ don't need the credit.

So "Originally-by" or "Suggested-by" is obviously fine, but I will not
be in the least slighted if you don't even mention me in the commit
message at all.

              Linus
