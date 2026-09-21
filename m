Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C93471274
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004319; cv=none; b=DxOeNflwZrZ49GE6gMvGcutLM3kkkPoagnc9kU+a+1OtWM+OboSoMatC4+8EF4AykuaZ2Sj4oU1RPh30Qxl+wt+LoTxS4lVt5BK3aPf2O4C0p4HTFwdu9vSYzTZEEQFlC+2Lu0zbGzw2Ipcn4NhOeUqG4vCBUH9PRswYy/9rnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004319; c=relaxed/simple;
	bh=ceIWGaK0yaMffpuhVyrXzV9aOWlqXkxFNwOJ1Bu9KsY=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=u8bojm6JptvuifEWvsMlsbS/OEvQi1m21tBjXqWjpWgFtg2u4Texfk/yugExDIHoJ0CHuwozL+YOw/pZ+mBjkIKCW9CZRjQPbyEEB4nVMQ/2r9bgJu6gAsopDVv0mZ0M0HMVoP/RTywVDrvKumiyGF8K11EV1vnmo6B5Rrqcz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz; spf=pass smtp.mailfrom=swiftden.buzz; dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b=x1nVPHeR; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b="x1nVPHeR"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so153168385a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiftden.buzz; s=google; t=1790004316; x=1790609116; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceIWGaK0yaMffpuhVyrXzV9aOWlqXkxFNwOJ1Bu9KsY=;
        b=x1nVPHeRG10k219us5Hie+0jBlq0rTH+WrTnPSG5L7gFgr8cP8vSyzPR2FYIUwNHBe
         pjd6aJ6FdX04Jz9J/1xEVn2vhgGJ7n33qonIQyet6Dn+LN0uTxWWZ5rEh5dnFGzy+Zfp
         xN1VgrgEGd076mP9jhoac1/jFMh3ZJ7qFfSTGgLt2YlH/i2IYpMvgvKCqJKG2GMAIH2d
         1KVxzMS+t8Z6Mzx3LbeKes3AKIt/lwRMe7kJtdQWdVlVWbam5YA217Fnlyafn7/YqocX
         IT+dIvoK/z2xtRyRG+RiL2iHs0URo7+ltygHevbRIhmsbJw3jU+UXkEO17bxPBoa590I
         JLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004316; x=1790609116;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceIWGaK0yaMffpuhVyrXzV9aOWlqXkxFNwOJ1Bu9KsY=;
        b=pXLxAtEHDrM6GLO67H8UE/5io5OtgPICj+Ha2gstYrdimG29bb1IdTGGUdpABpjw7w
         JrZhSD4KGM1jpbhwt2V3kGQ2XMQnjZi3s64XrwGnCDhOEGYjuh9DsjWD3bTR0cM8dCog
         7kKw/BGwouiR2Q2Nwl2RMBLc6IgzXx0WRzKLvnlp+Hw+w6we4Z5MiDRd6QcavsdOW5Qy
         7a6wrACgUJrE3wucUwPi+X09uqUjEsNvq1/Ry22lei7xgmDkwn4c6+mnjeigekJ9T6Zq
         YvkQthreRkVmcRzBrFa0El2FY9sY9oy6eR/80BC7JkHGqvBflIrEGlD1j13Q4lKx5oV3
         g98A==
X-Gm-Message-State: AFuF++mmldBmjALgMIEm2VYrFDVKEJSel4xWKll55dfe/CLWcdt8WhwH
	WaChDh8xRPigOwYLyiKPJeZnzUpjFcl9OEWK2iopjGiPd7gQ9nnl8eeVWdWig0Kzy9x2JgXAuUs
	q1GdJig==
X-Gm-Gg: AYBFou04mkYsJo2GKArVy2yzSVsf2ie+Xd4Osn5oavG1SN3mKVbjkrGE3e000SOwxjk
	7c2cz13WGJc8fVEm1T5otGpN2LnWTueE8bWdO5k6JKE1FdrzSWV28uwHWn9M6uVbhad51XkfZX5
	A1EWGXATT94WS1/10e5qb9aTdLpHI4dt05ZByRqtK0qiYcfYR9C5i0yxVwGdZ2F4JkV+VaC+r4V
	s3lRPB3cpL9zXj0b3mJwH+W1Qh4NtAWA4DNAKWPjprRrdAFcigFWE9B5PZ5G+ePAfUV3QDmEJkA
	zncmy0rFp0SlFy7htrQHyxx725tV9xJGpllvmIz0ILFEV87i+q/BpOO5qLViwZbxg5wzhD/9Y3m
	rw1Lh1BMOo6MgYvRAlIAHoUOl7PP9tCKRvz0yeqbkSXwqyb+0GtSQeruPeVkoAYvWoXMnyncW8T
	ZC7bfvhq7ak/WWHd/jftHdtSlUeGPiH++ZbETsjVjdE3Gh3qunv/bUDbGO9l6rJcvbbzhDn6H4s
	MTXMd9TqSxtWnnjSGe/erVqlfbj8ELbJDbkcwouy97/Rdu8HMrQ2vOnj1QmBqeSVxcmrVHwmAng
	2gkwnl+otNBHiMPfdQ==
X-Received: by 2002:a05:620a:468e:b0:939:2c5c:7977 with SMTP id af79cd13be357-93c15d9ca6cmr110120185a.20.1790004316207;
        Mon, 21 Sep 2026 08:25:16 -0700 (PDT)
Received: from 01a0c492-4568-7248-97d0-4da0177aabc6.local (ec2-13-217-144-131.compute-1.amazonaws.com. [13.217.144.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93befd5c2d0sm658385785a.4.2026.09.21.08.25.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:25:15 -0700 (PDT)
Message-ID: <01a0c492-4568-7248-97d0-4da0177aabc6@swiftden.buzz>
In-Reply-To: <01a0a09d-3541-71f6-9bf2-3ece56b80167@swiftden.buzz>
References: <01a0a09d-3541-71f6-9bf2-3ece56b80167@swiftden.buzz>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a0c492-4568-7248-97d0-4da0177aabc6
From: Todd Ford <todd@swiftden.buzz>
To: stable@vger.kernel.org
Subject: Re: Offline bad review
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:25:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey, did you see the 1-star reviews I sent over?

I wanted to get them =
taken down for you...

Can I give you a call? @ +1 616-286-6687?


On Mon, September 14, 2026 3:50 PM, Todd Ford <todd@swiftden.buzz>
[todd@swiftden.buzz]> wrote:

> Reaching out one last time,
>=20
> It seems like getting rid of unfavorable feedback and bringing in new =
customers isn't the focus at the moment?
>=20
> Kind regards,
> Todd
> On Thu, September 10, 2026 2:52 PM, Todd Ford <todd@swiftden.buzz>
> [todd@swiftden.buzz]> wrote:
>=20
> > Hey, I'm a real person not a bot =
lol
> >=20
> > Would removing a few of the negative reviews help bring in =
more clients?
> >=20
> > Open to explore this?
> >=20
> > All the best,
> > Todd
> > On Wed, September 2, 2026 4:49 PM, Todd Ford <todd@swiftden.=
buzz>
> > [todd@swiftden.buzz]> wrote:
> >=20
> > > Greetings, just wanted =
to follow up,
> > >=20
> > > I also came across Wendy left a review saying =
"This was my first visit to the store. There were lots of cute clothes and =
some good prices. However, when we checked out, an item rang up as 25% off =
instead of the 40% off that was advertised. When we questioned it, the =
cashier said that was how it rang up, so it was only 25% off.
> > >=20
> > > I walked back to the sign, which originally stated 40% off, and it =
had been switched to 25%. I=E2=80=99m thankful that the customer behind me =
in line spoke up and said she also thought it was 40% off, especially since=
 the sign had been changed while we were still shopping.
> > >=20
> > > Another employee later told us that only the sweatshirts on the rack =
were 40% off, which was not stated anywhere on the sign. This felt like =
false advertising and was very disappointing, especially since the only =
response we received was a brief =E2=80=9Csorry=E2=80=9D from the cashier."=
.
> > >=20
> > > We can eliminate multiple bad reviews to strengthen your =
online image.
> > >=20
> > > Can I give you a quick call?
> > >=20
> > > Best,
> > > Todd
> > > On Thu, August 20, 2026 2:35 PM, Todd Ford =
<todd@swiftden.buzz>
> > > [todd@swiftden.buzz]> wrote:
> > >=20
> > > > Hi there, are you in charge of Offline?
> > > >=20
> > > > I was browsing some of your Google reviews, and one from Angela =
Russell caught my eye. If you=E2=80=99re interested, I can have it deleted =
for you.
> > > >=20
> > > > They commented, "Had a staff member order me =
sweat pants to ship, but they ordered me the wrong pair. Apon the returning=
 I was asked if I wanted a refund to original payment or gift card. I asked=
 for my original payment refund and they are now saying a week later they =
can't (only able to do gift card apparently) and now I'm out my own money =
because I will not be returning. Worst online customer service with little =
to no help and a bunch of "I'm sorrys"
> > > >=20
> > > > Would you prefer =
this review gone from your profile? We focus on removing unfavorable =
reviews, and I observed you have a couple of other critical reviews we =
could help remove.
> > > >=20
> > > > Looking forward to your thoughts
> > > >=20
> > > > Stay awesome,
> > > > Todd
> > > >
