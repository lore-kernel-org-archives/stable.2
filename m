Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5E477298
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401056; cv=none; b=dTvvJ4iO1rrqrFcWfRJ6KgFBR4rfdKZPjnxJuLJogREkeRGtZNnkcB9Y81Ty3N18Tug1Y4WaNo6q2ugLdU5GROsuqxH/1zbgal7Re3Lg5i41UZON9OCo5HbQwxYXG236g8vyNQaXrobVEArXTeZa6YCQ0Bq6qA0obYLg+6LkUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401056; c=relaxed/simple;
	bh=p2hR4i0PtZDYm3RY39xCiepe3yjrbz58yhqd2vSyzJ8=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=b86nzVWz/W6QGzk3ZtbcW4sPJ4gHIbBIG8cocG9O1GeGPKrGAknr4LGBEl/mxywY1Jp7fWDmHViyzTtkX89WMIEcSXuofYvFJhtUS+NHQqLeWx3NIlrVvxyVGcu8Q8cbbU6/xIrc2G1RcmRNgtH6xidT/yXlHmxlN3DxGvR6JKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz; spf=pass smtp.mailfrom=swiftden.buzz; dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b=Q5z5Za34; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b="Q5z5Za34"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so253411185a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiftden.buzz; s=google; t=1789401053; x=1790005853; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2hR4i0PtZDYm3RY39xCiepe3yjrbz58yhqd2vSyzJ8=;
        b=Q5z5Za34i6nrFwzrvft6O0pVtk/MhTcA/TpaAfJRVKGwsKmqyUunyPReRetgGaRWjk
         aM5BVJKyOOysDCs9bsPGrCapfo6Ji5I4lSGpDUvyG7wvPdZDxOww18+m8mQ8LSrkw16p
         ITowCreUszW/4UFKeMzG2dGWAanvdn/0GAH11iETH9RVktQVQYnVMrRzrs6ypv0xoMR7
         +KomUNR0byU2nzUD90xrh1Ma2sNjUcqiXMAOtprUQpG3FjtuQtFjyA+fuJnxzxC9odxX
         sKAWg0z0aXmNKtT3hEVjUfzhoIpyDnH2MPqv5fRVAf3gflIFT70/m14mkWXSn5mHZRUt
         PzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401053; x=1790005853;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2hR4i0PtZDYm3RY39xCiepe3yjrbz58yhqd2vSyzJ8=;
        b=eTEO33VAwRmI9q9FWspD5uSan9CIqgLqteeUF0gfZ3ozS/Y/hvaWww6ZvfxhShyVcw
         M+vxN3VjjuWbSp5eNgrQglvyaxSgJbUMA0X08bDb8anmf9jawubIWhqd/WOo4ytlXNpe
         w1uv5GhpycfprJJT2caugb/B/EaeeBEtJ/BhpRNvdLxMvg27kmTTcnrZ13a0hbJwi83v
         nOdpMRwFkZHVAGmH5X5BqtqCpUQcUXpFa7xUcFowOL2ob9KDfbG5FrYPAqVCVhqeiq93
         ODfzrNE6/tcumUpfyqIFmaLjHI9Y9QK49ErFt9GkI5VRayjxOu5S0alOzHc9UB6udZ9F
         I+3Q==
X-Gm-Message-State: AFuF++l0V0GONYRT939rZMnV166uJOHHmjtAWjN/3mPMS5poXphXBtKH
	KWyGHBq0DXI5YRH0GKpD66bHYHj9vL7lkA2FtD2aC1xrb2+WyLNNk9RDzFI9x8i7xg1610sU6a3
	3PgBySQ==
X-Gm-Gg: AYBFou2xtfB2mrfNC9YyzNus4SK6AgMgBdjpg4BT1AeRSIcC9KalkJ6OLS+704sZb/0
	RhQZRCp+J+gpPJ6mP1R8/2MC5iqDqlF7esA5SAyyE46CDqh4nwkF12wQkZxQjIqA65z2fGeyCTK
	WILqx+pJKkxSHwkJ3Rlr0qaqVvLa6I6T78AJwXe02twOQoUWv/BKMR29q4V+waLkNIqVqwQSp+G
	qRE3P0bwKKmZpzwDX+rugG93Pkw5NNK0zDFICk0O2vQsMN1M6WLglpXwGasEDMlaZlLYhUtO/Ap
	dsja7mqctlBQcpkh85o3WoCsr3msvcNuBpSK8ibkgk/iLMr8VdSplPfY7c83gjE6UkEDBucguoc
	4LpfADOF2R05TQXfyV3QBntLWvdC35qy103vW1o537HPWzyDMzwTFuynijytMumCSANkpYQrwRt
	7GzwcUAaHGXwKcJ+O7efuaBo0y/PKY90HzabbYpXqjFYFGgep2FC2G8DZXcntaHGSHUCEZ+pLZO
	axk7ZNRz09GCB725nxUj+kQCT035h/vnKSUfqc+b3r0hMwcFgHo2Cimns70F6bdfb0IUlknhgvo
	Rrhq7Gd73/Jq
X-Received: by 2002:a05:620a:170b:b0:939:d38:3ab8 with SMTP id af79cd13be357-93a297e8fadmr449869685a.12.1789401053349;
        Mon, 14 Sep 2026 08:50:53 -0700 (PDT)
Received: from 01a0a09d-3541-71f6-9bf2-3ece56b80167.local (ec2-54-91-206-84.compute-1.amazonaws.com. [54.91.206.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a4fb3e4sm78414266d6.24.2026.09.14.08.50.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:50:52 -0700 (PDT)
Message-ID: <01a0a09d-3541-71f6-9bf2-3ece56b80167@swiftden.buzz>
In-Reply-To: <01a08bce-0a4c-7572-824c-296398214cf0@swiftden.buzz>
References: <01a08bce-0a4c-7572-824c-296398214cf0@swiftden.buzz>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a0a09d-3541-71f6-9bf2-3ece56b80167
From: Todd Ford <todd@swiftden.buzz>
To: stable@vger.kernel.org
Subject: Re: Offline bad review
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:50:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Reaching out one last time,

It seems like getting rid of unfavorable =
feedback and bringing in new customers isn't the focus at the moment?

Kind regards,
Todd

On Thu, September 10, 2026 2:52 PM, Todd Ford =
<todd@swiftden.buzz>
[todd@swiftden.buzz]> wrote:

> Hey, I'm a real person=
 not a bot lol
>=20
> Would removing a few of the negative reviews help =
bring in more clients?
>=20
> Open to explore this?
>=20
> All the best,
> Todd
> On Wed, September 2, 2026 4:49 PM, Todd Ford <todd@swiftden.buzz>
> [todd@swiftden.buzz]> wrote:
>=20
> > Greetings, just wanted to follow up=
,
> >=20
> > I also came across Wendy left a review saying "This was my =
first visit to the store. There were lots of cute clothes and some good =
prices. However, when we checked out, an item rang up as 25% off instead of=
 the 40% off that was advertised. When we questioned it, the cashier said =
that was how it rang up, so it was only 25% off.
> >=20
> > I walked back to the sign, which originally stated 40% off, and it had =
been switched to 25%. I=E2=80=99m thankful that the customer behind me in =
line spoke up and said she also thought it was 40% off, especially since =
the sign had been changed while we were still shopping.
> >=20
> > Another employee later told us that only the sweatshirts on the rack =
were 40% off, which was not stated anywhere on the sign. This felt like =
false advertising and was very disappointing, especially since the only =
response we received was a brief =E2=80=9Csorry=E2=80=9D from the cashier."=
.
> >=20
> > We can eliminate multiple bad reviews to strengthen your =
online image.
> >=20
> > Can I give you a quick call?
> >=20
> > Best,
> > Todd
> > On Thu, August 20, 2026 2:35 PM, Todd Ford <todd@swiftden.=
buzz>
> > [todd@swiftden.buzz]> wrote:
> >=20
> > > Hi there, are you in =
charge of Offline?
> > >=20
> > > I was browsing some of your Google =
reviews, and one from Angela Russell caught my eye. If you=E2=80=99re =
interested, I can have it deleted for you.
> > >=20
> > > They commented, "Had a staff member order me sweat pants to ship, but=
 they ordered me the wrong pair. Apon the returning I was asked if I wanted=
 a refund to original payment or gift card. I asked for my original payment=
 refund and they are now saying a week later they can't (only able to do =
gift card apparently) and now I'm out my own money because I will not be =
returning. Worst online customer service with little to no help and a bunch=
 of "I'm sorrys"
> > >=20
> > > Would you prefer this review gone from your=
 profile? We focus on removing unfavorable reviews, and I observed you have=
 a couple of other critical reviews we could help remove.
> > >=20
> > > Looking forward to your thoughts
> > >=20
> > > Stay awesome,
> > > Todd
> > >
