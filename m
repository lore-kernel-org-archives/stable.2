Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1D47F782
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367797; cv=none; b=PAVCxVZCQQ/0QKbwcrl8Y3v0PQodpiNn42OofqtDWMPNJo8a8aiAl/yG9xgQRs+4hl4y1t95/CqdMFO/OqTBySjmfPbacUdn7PUQAOnzr4algAftlIhLxD2C1Z1oPT7zdDrCDAcko+0YfUEw783GSLS6JInHQK6Lg5Hxj4hqQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367797; c=relaxed/simple;
	bh=R/smS0tOr3pxPdM+ae9ZvTyZypQLiz82z9m+C4C4jPY=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=IUEnCNu2g3yNn/PUYTkzsvzM5fZ9Vm0SwrUrGtTgd/cqwjZsQFiOaPnt7yMScf+Bu0R2oPNrc/F4OLCjNIGeLt/CDdmKW76dXMxua9zJxkWZQgOvKcU3AWtvi3hehUEZMuOlhGJ53K28YDUoAeAb88Z1kEfKNC90ueCX+FhBOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz; spf=pass smtp.mailfrom=swiftden.buzz; dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b=duC/r3mT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b="duC/r3mT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f1a320162so11757391cf.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiftden.buzz; s=google; t=1788367795; x=1788972595; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/smS0tOr3pxPdM+ae9ZvTyZypQLiz82z9m+C4C4jPY=;
        b=duC/r3mTeatLf2GA0KYXp1aPV6IBLviwmQgqWgxuXx606rttAB4kFWryptYMQEc3cd
         qcU74JlWfRMFSTgucO+6Qd+u34u3T9nhA0tpzE2TJC1FcePraRY76pyiOHbEW7upO0vp
         ccE6Nbgk31aHqiMEhSkYk3KEYX/PUNPa9Jp6ZEE0AHHnq/gP2niAt5h8yNT8ANZHrMp4
         jXpDGuQSiXDuWBXATcdG1D+X1HExnX79OxMa9uNcw9FpFWoGxANgsebfFTF1mJc4R1l3
         wrDR8/i3hJolQNDc7Gt2Q3A+Sf33Ov/2YMzoFKxg+Q92TPM/gT/QdDsYOczOCRnhRVQe
         46iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367795; x=1788972595;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/smS0tOr3pxPdM+ae9ZvTyZypQLiz82z9m+C4C4jPY=;
        b=nc7OwW8z6ptZie85QL9LDd/hOAk4aposTpKc0sZJK0Y49nQW/K79PZqJglIwI8hmXx
         Yg9BRdKgVDiZlzwdSxZGoQ5hl7QzPOB3hEpUJrvqCi0ccETAkQ/CDPKVRkVxohXAyfje
         RwZ8LJc7PHAfOrxNtFeTAWu6X2DTN5zAnWITL/bF6N9qBTLfSUwWzwrjOHJ3M4dE0iGN
         1sbZwBrIdHXAA+OSgdj+nkErWhr60z1fQ5HdSBjhJaFuLdbMcWqrI+UzhcSXyKamyLlD
         0xpLREq5iiFLxnejM1bdUjf7N0XjaXbuE6SnfY69DcTJ7gjAoqP6Omp+uT7MPF2cvfVg
         6+yg==
X-Gm-Message-State: AFuF++nEhZHWqeTgKqFeJQNXY9JdkEs3HVTXZh3pw99YJUwGGmdt+yAZ
	MWCUBMgR5OgNEOE6SqyAyy82faIL6QPYaCmRyGNUfXtvEmgeac7NATWNV1gmfrpN8HpNeR1drY9
	Sk/7EQQ==
X-Gm-Gg: AR+sD13jGjVNZAiozQN1XclHD3aBnDDil+WX1qHtib2P0NZmqUyNP9jev26PK7x9n9N
	kW/GlqynsDYtY+t5aEB/a+v7wdR+wRqx48XmHW86fOG0y8j4dVbsudk+Otf2Vky8JsBVJPJjOfS
	PyOZ64ARixs9hR8Y/s/w8YyxYOZRVPxHZy1lAXwR9Z0gS3i88sjkSA90qo6HPizquSH6iMghCcy
	Q0mQ+Lxuzk0iwIHnt0TCNFM/mYEg3Ovf8tnSF8VjyID84vf+w2bZk+8hDUBgUvsZGpx4dVq3SC7
	uTw2CpphXtvC4qYQbpBovcfFhaoSEm/aD7zklV1WNzzbrmTSTwnX94dlCuIe1EVVfLUnHwTaOur
	OseEHMVKAnFK2Sr855nI6btuhRIfk6/IBJKFGZCZQjPj+Z+gMo/a+tc1GSmmaOAuDXHWUXL7NOc
	wUGPibxOAR9zqkTE/MKYGgvSjnyo7FySlki/9NUhJ42USy4R/3WRWt8zwX4wVEauj1hEOEZmvJw
	cI/2YkWSOx6EciQm7aiBkb7Z/pyqCj6b9A+RhM6hYe6A4uehx9Q2jUreQb+GjwyAm8Xme4cI9p2
	saF7
X-Received: by 2002:a05:622a:6207:b0:52f:9eff:959a with SMTP id d75a77b69052e-53036bfe464mr82368301cf.11.1788367794569;
        Wed, 02 Sep 2026 09:49:54 -0700 (PDT)
Received: from 01a06306-ee90-713d-888f-101a10980a7a.local (ec2-3-238-127-148.compute-1.amazonaws.com. [3.238.127.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53033277f37sm23521211cf.30.2026.09.02.09.49.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:49:54 -0700 (PDT)
Message-ID: <01a06306-ee90-713d-888f-101a10980a7a@swiftden.buzz>
In-Reply-To: <01a01f99-890e-7294-88d1-d8968c57eaff@swiftden.buzz>
References: <01a01f99-890e-7294-88d1-d8968c57eaff@swiftden.buzz>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a06306-ee90-713d-888f-101a10980a7a
From: Todd Ford <todd@swiftden.buzz>
To: stable@vger.kernel.org
Subject: Re: Offline bad review
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:49:53 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Greetings, just wanted to follow up,

I also came across Wendy left a =
review saying "This was my first visit to the store. There were lots of =
cute clothes and some good prices. However, when we checked out, an item =
rang up as 25% off instead of the 40% off that was advertised. When we =
questioned it, the cashier said that was how it rang up, so it was only 25%=
 off.

I walked back to the sign, which originally stated 40% off, and it =
had been switched to 25%. I=E2=80=99m thankful that the customer behind me =
in line spoke up and said she also thought it was 40% off, especially since=
 the sign had been changed while we were still shopping.

Another employee later told us that only the sweatshirts on the rack were =
40% off, which was not stated anywhere on the sign. This felt like false =
advertising and was very disappointing, especially since the only response =
we received was a brief =E2=80=9Csorry=E2=80=9D from the cashier.".

We can eliminate multiple bad reviews to strengthen your online image.

Can I give you a quick call?

Best,
Todd

On Thu, August 20, 2026 2:35 PM, =
Todd Ford <todd@swiftden.buzz>
[todd@swiftden.buzz]> wrote:

> Hi there, are you in charge of Offline?
>=20
> I was browsing some of =
your Google reviews, and one from Angela Russell caught my eye. If =
you=E2=80=99re interested, I can have it deleted for you.
>=20
> They commented, "Had a staff member order me sweat pants to ship, but =
they ordered me the wrong pair. Apon the returning I was asked if I wanted =
a refund to original payment or gift card. I asked for my original payment =
refund and they are now saying a week later they can't (only able to do =
gift card apparently) and now I'm out my own money because I will not be =
returning. Worst online customer service with little to no help and a bunch=
 of "I'm sorrys"
>=20
> Would you prefer this review gone from your profile=
? We focus on removing unfavorable reviews, and I observed you have a =
couple of other critical reviews we could help remove.
>=20
> Looking forward to your thoughts
>=20
> Stay awesome,
> Todd
>
