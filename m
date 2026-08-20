Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EC26B2CE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236555; cv=none; b=G7615L3Fu9BUvsH/VwR6vYpY3oGOnCbnSEXa2bsVUPrAK/Fxn7meQIlI/6BiIF4yIlt47JcXQo5kloC5gqugOeA8SBzh9zb2c5yJqF1GXNIdWoZPfYvAXh1vMSbJ/r233wbbFSr0WjreRqIWh46N8g7F7lj9zU5HC+p0Zouh3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236555; c=relaxed/simple;
	bh=SjMnUrjVu5nFW/kPbyyJJ9Vb22y7TY7mwDMF7oOQJpc=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=fQqGGzXjUgKQu6+TOepgUVLACHEJ5KJXm+cnYfU0IBZomr9WNycRCvCBqBT5rD38/NPHbQ5IUw+ZS8g8VLatDxuhkm+At9E5GL60VH2e4zdsHgNkC8H7QFU7I9/0gP/ZT05zdegNSzu0c6vF+0u7rDhc3qcaTb8Ek7jNj71Yp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz; spf=pass smtp.mailfrom=swiftden.buzz; dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b=PuAfVIwZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b="PuAfVIwZ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso3961842a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiftden.buzz; s=google; t=1787236552; x=1787841352; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjMnUrjVu5nFW/kPbyyJJ9Vb22y7TY7mwDMF7oOQJpc=;
        b=PuAfVIwZtWDZK/RYaGfc0xWRxXgVbZEBRbC1ovgny/aL4H2eW7vy2stzVkxG8H8TT0
         9eJ7AzhUvNZtNWl4Si79cvOrHjKcYTW08wJfj5XgwDQwNniMjSF1lq0Qh3Gji6AnRhgA
         5j7UzwOc7PDAf0/XzQH8Su0b5ASkc71XrtnzGTCsJ+p+aaejJL6/VSQXqMnV5OnIvUkC
         Q8EC5p0XWUSaorxESz0F8a/+e1GSusGdgMet9y7WzsAIki+dxtAzPZccCRkSWWZQDA6I
         hk18UJlvt2VJwQFsw6mv4iPHafCuskec+FjRL4n6fkBpHL2jmQhZPJzIzUVS68yWHeZK
         59QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236552; x=1787841352;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SjMnUrjVu5nFW/kPbyyJJ9Vb22y7TY7mwDMF7oOQJpc=;
        b=T8FSScz++uAwQ0dUtMkzJc0Cj3dWzfpCozWDXEP7GBd0yl8Tk/QxTZJBS47EzDwZ+H
         K9+HKZ9+8PloZcoGG69tOi4p9BWqTuo9GG6LHFj8UPRXNNN2xzGi5LGfZ6hl0GVWOhnL
         KEWtH0xLAwAXudIpirsQWK4GV+EeuJAz+U1Tunwbmz67Yw/pnnm6eZBaEr0ltOJAYOXo
         T32jGPHcDmXYPSdlOY+G02RQGaDKMU7XVrdVuKMq9xiUi1OYrezE8Y/eIhN3reEpAfU4
         nfkW02KCEVhk5Gx252JQj3HxklV/2IqrzFyK075SjWvO3qoBv8UG8/Qf1zHX486yhV3y
         mHCQ==
X-Gm-Message-State: AFuF++lK2zKj7OKJ9Aagnkqg/oCcEosUnM5TRHJCrh0qq0GmkScB9gj4
	/P/4C6GNMMgqDQ5LhAuG3KphyDUue7sy4VSKNVvmCQxDxVfSoibmgTZ1gbOhyKSVvegybwZsKa6
	6Uk7pzw==
X-Gm-Gg: AR+sD10KRfY6HpvEP9Hs1T9nvEzv0CoUe9yFPqqOcxhxfV0O3BfzMH53PeoM45wMYbL
	cgmdbPwRnoy++fzAgmqKx7Ym7EUnYmldCE5+UqsH4oebMPn9V7wpIaX2R7nxw2Oi+2096YANKjO
	dHqDCGYGQIR8hC2jvRQvpqJlWMMGtDUXKOTMm9aZJ2l9g61Yf65TTUJ4AnbwHiXP82FbxUB00Jq
	RSEzZnu79PkgH0ecfnjNLfmJMTk69C8JqObgA1KdgHl40voCAiTnYOvhKmaw5dMqKTK5lk3seLG
	jO283r52Y8DZSJCokmwWxG1oD3+sb9UxX/7yDhu9Gv4bbbuyTlWhCeK3nXKsuZejQNpjfJwL3jW
	s0swDeHSxEYao88a0utvIWEDmMfHsxLBcZRopDNyz8fr6enqBBeadHkVRB2D4aZtMXJVFHcC2XQ
	1zqaJ6u5+6GYG336PCGX7GYpeaGT0SxOucV07n0OdNKHA3fYlO00TuYs59aXI+CsY7DGT9KrlMD
	EV9qZ/lLINJH0vPOhWaOAqL45r4RasCQeyRBKacf1OuAGDk9sSFYPvnZZLerf8zHD6Kb/PU88ut
	sdh+EfcY+FbZgLzEZw==
X-Received: by 2002:a05:6402:320e:b0:6a0:eb:ae41 with SMTP id 4fb4d7f45d1cf-6a4032fc4c8mr10287627a12.10.1787236552154;
        Thu, 20 Aug 2026 07:35:52 -0700 (PDT)
Received: from 01a01f99-890e-7294-88d1-d8968c57eaff.local (ec2-107-23-20-17.compute-1.amazonaws.com. [107.23.20.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c3bbsm2222669a12.24.2026.08.20.07.35.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:35:51 -0700 (PDT)
Message-ID: <01a01f99-890e-7294-88d1-d8968c57eaff@swiftden.buzz>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a01f99-890e-7294-88d1-d8968c57eaff
From: Todd Ford <todd@swiftden.buzz>
To: stable@vger.kernel.org
Subject: Offline bad review
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:35:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi there, are you in charge of Offline?

I was browsing some of your Google=
 reviews, and one from Angela Russell caught my eye. If you=E2=80=99re =
interested, I can have it deleted for you.

They commented, =C2=A0"Had a =
staff member order me sweat pants to ship, but they ordered me the wrong =
pair. Apon the returning I was asked if I wanted a refund to original =
payment or gift card. I asked for my original payment refund and they are =
now saying a week later they can't (only able to do gift card apparently) =
and now I'm out my own money because I will not be returning. Worst online =
customer service with little to no help and a bunch of "I'm sorrys"

Would you prefer this review gone from your profile? We focus on removing =
unfavorable reviews, and I observed you have a couple of other critical =
reviews we could help remove.

Looking forward to your thoughts

Stay awesome,
Todd
