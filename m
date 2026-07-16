Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197434574B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184177; cv=none; b=gXxFOJeVCg2YGmJDwipGBaPZXGfX1Il+fG5GhPGTRZPK1H1ic35qpKDgLQR3lelIBi+2CO/l4Kp6pEcZKLGYRYimgTKDM1nHpUuH5hLa1eKhB/97T6uxLiEB4bKN3f7cVGSojbeJZg9ux6uJ4gxDqby4ldyKBWcQUSjT2cC/elI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184177; c=relaxed/simple;
	bh=bxP+Iob0uYXZx1jF+aVrA8SMBuKJ+8H47+0ZSsb5mBg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MVC3mmPqyUDMPBcuvjKR16uO/Gt5dKkXUXk0QgtVUNqXyLdlzCtw8e2Lygdeya3XbJ1FJCFc43FPw6oEI7Na/9M6N6ivPl0gGuDJq9beek6rpvydRxN2Lb362l4bWj3tTMQNpBHLjjsh8zyU+jz5IF8LSi9dqlc+1VderiNCWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQhH76x1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQhH76x1"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47df440fcd5so3457280f8f.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184174; x=1784788974; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bxP+Iob0uYXZx1jF+aVrA8SMBuKJ+8H47+0ZSsb5mBg=;
        b=dQhH76x1GdkpGTgqIrHGy4i4mj8SgO5hRt3kCUa0VhcPN9Mvg972W4qGfidk30cFUg
         zqToWIek55URk5P+rHJFVXjenBxeiuO7ZTDxc+bGpQ8fqufInUOQAwcTsdUy3vGyhp9i
         g09EE4+hVtwwFjuSNShDvnwXKbNyuJo5CScpv76Tpe8umDGsVU2knWXBfFXWf1WVbGB6
         zpv/8A3vRiTYMJa2Bl3KJgAJPjhBIKeK1GqFXlOOm3FOnTmcpt1mV5cnk9s2mn7FNfxW
         KAZk5b3asFkcwqxEFZQj8t/EIJbTVH0wtDFj2qXVk+4R6h2w/FoZ+WvpjAiGodZM81VE
         YM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184174; x=1784788974;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxP+Iob0uYXZx1jF+aVrA8SMBuKJ+8H47+0ZSsb5mBg=;
        b=U0196aBGXfAWd7b+lshKBAolo442zQGhZRPfyC5aB+SgXP+0xsbELYK77kryRQoqQJ
         rMhLBdlXUgb1wVtqLa2kmMywHGppyIPkl6ebexZbbxOgW6or0qOCuTQHIIdav0tda7p5
         E0rc3tTdmZcANTXKHhpIl9YOvfTfwchm0e3ODPkqUSwXlVW9nc5JYOUdyWSMMC13PZDV
         Io/w66Zqk8MmTnJNTDZmy7Xjs3cGYfD38k2e+SeqJTbSm5sy0nkiWGXgON2nUUJEhc+/
         t2KGjSNBC3oNe5p+7dBN/jvK/k2YcXHCwKSaAtdjRyrZ4PhTlLx/n+2fkBzgLNbCc6Pa
         gUBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVl81Fj+5wBdJ0VppBd2Y89KpIoTwaIJuy4LWQkYYoGVXeo8bu4zBClZoo2j9oK+LpqPHBpiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsABy1xOefc69veZ29f+1qpCqcReWpFDakRm0oAAVH6xyEFmz
	mWQd54L75BY8+W0dUTb/CFhlkb6WJX2qE5JlQbIdC5Qv1eoxZejwU0Iu
X-Gm-Gg: AfdE7cnNweBL2nWujzYWz+bW4JugmcQnQ835Mbolc0i5xJTlWp0wkRc2+k5JL2+tCtk
	eTC+dhFKDDzTTjnVe3XyV5/LIxoyPZXVn2rmE3Aq8VVng012d4gSyfB0teyrkBIpk1HNm0zDaP3
	Nu/vC03GaYT3uLj6FVZd8xHODIgZLPFonjZaOjRori97Zd+zTDsfhImx+G+ubiFVnmVFJyIJxdm
	cOLn+TpNchJ4hEGziW5vvpwID08KcBlLr3n4Xs554s97T7oWMxA0QOBiIYnhDwfMTwxW3mbCIdN
	S+K0iG5QqCNOg+b/gVQJDTXRDjBL6cTZgRoxJmA5tr10PvWg3+APa4v7kNRj/apD/PA/haIN/OB
	gBCGty9aDhaXXBVOTpYT2HYfvGOwBv5N6eFlHAJOXr/MMejJy63BS1tVTgIMfLP2PSc8wA5KcOO
	fRbBuVbuNpkSUKWMZRubAIfS+1reeehbt5GMHlyhZPJFCzgI6vQFTFGM86iGvJOsk1j2wlyseV
X-Received: by 2002:a05:6000:288a:b0:470:3edf:e2a7 with SMTP id ffacd0b85a97d-47f4fce455dmr6663447f8f.37.1784184174035;
        Wed, 15 Jul 2026 23:42:54 -0700 (PDT)
Received: from smtpclient.apple ([151.251.247.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635c86csm22075375f8f.16.2026.07.15.23.42.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 23:42:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
From: George Valkov <gvalkov@gmail.com>
In-Reply-To: <alh5y74H5bJyDSSP@stanley.mountain>
Date: Thu, 16 Jul 2026 09:42:42 +0300
Cc: briannorris@chromium.org,
 kees@kernel.org,
 bhelgaas@google.com,
 s.kerkmann@pengutronix.de,
 linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <55FE8005-625D-43FF-BA57-E2E94C6EF694@gmail.com>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
 <20260716061638.GB9973@francesco-nb> <alh5y74H5bJyDSSP@stanley.mountain>
To: Dan Carpenter <error27@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 johannes.berg@intel.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)





> On 16 Jul 2026, at 9:27=E2=80=AFAM, Dan Carpenter <error27@gmail.com> =
wrote:
>=20
> On Thu, Jul 16, 2026 at 08:16:38AM +0200, Francesco Dolcini wrote:
>> On Thu, Jul 16, 2026 at 03:17:28AM +0300, Georgi Valkov wrote:
>>> Replace deprecated one-element arrays with flexible array members.
>>> CONFIG_FORTIFY_SOURCE reports the following warning when
>>> one-element arrays are used as variable-length buffers:
>>>=20
>>> sta_cmd.c:1033 mwifiex_sta_prepare_cmd
>>> memcpy: detected field-spanning write (size 84) of single field
>>> "domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)
>>>=20
>>> Convert affected structs to use flexible array members.
>>> - Preserve existing wire layouts.
>>> - Use DECLARE_FLEX_ARRAY() for structs inside affected unions.
>>>=20
>>> Tested-on: WRT3200ACM, OpenWrt
>>> Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
>>=20
>> Cc: stable@vger.kernel.org # 6.12+
>> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Are we CCing stable for this sort of thing?

Yes, please add stable if possible.
I am new to this process and still learning the rules.


> How many FORTIFY_SOURCE
> warnings are still remaining?

So far I have observed only the warning on sta_cmd.c:1033.
I made the rest of the changes as preventative measures,
because they are flexible arrays used in the same way.

Georgi Valkov=
