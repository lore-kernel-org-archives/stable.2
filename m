Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEF12E1DC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135242; cv=none; b=rYUUtsPXqKgYCorOLshPPB+LYiOUavluOwI+Y+f4sZU4n1k8vBm0PybIy2nLS1mNzm8E7RH9aLKlYPXvYy794ez0q8CBDPJHvRhDBt3XDX0ZyJQ0eUO3wKzPIY/p3i7+0pFzfW/HoLqDrypKNhz0vwxslhLuYlBl1LXQofqHgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135242; c=relaxed/simple;
	bh=0rjnHHDdTC8ssXKpL/DGKwYQeYfI2LwYwBxMucf9uPE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QIcCbkWdxWgPTgN3C1ZIhZwY+SVJNIvHwo0oZw2jXqiBG8ltVnUPS6olZqW+5udyMs0F647iy+c0S6e8gg5jSZwP36yBYtd7fHfeVO1KxcApIA8psHTk3GyvTpw0BG1z9it36RR0ONBIxKudHJW7d92eeheOL05WTjXe+M1govk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDDBCs4l; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDDBCs4l"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9390f8a1c9eso187636185a.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788135240; x=1788740040; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KeqftXhgmq02BoO6G1HLtpAULPLshwJFEBqpXSiTygQ=;
        b=dDDBCs4lx0tam2Czn3STuTYRw43h0/BUodcBP8hQ6HXxRSyHUNExCv0WkO58tP5WPs
         cw3eMb5Y4qfss7bjTl1pfgRKs5lFTbFROmhthMvqTNqKGB5m/QotcwJ8rVPhNl0cAaM0
         sVE/h7NItHobzzk115kRyPQNoZR7S60Wu2qqQlWwgOdLK8KY5O+o44jA+/etpGgRE0ha
         Zi1gRIABRHbd8cbFKWOr/+UFY+ywhjC/ZP2pRxV4a0z+w+OEYX8H6CBfDmsKuGbwU8lw
         OSwwC35ZXJ17ZPVhnnSvf3rcbVWGIKKKyppY1KtoH3KNDXBRsacH0MRNUFLKUCDjtZ8d
         27xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788135240; x=1788740040;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeqftXhgmq02BoO6G1HLtpAULPLshwJFEBqpXSiTygQ=;
        b=A7lVurwhbVswnn+Fkah7b/0gLssr1jGBYkHAJHlx/a3TjhNyIyX0yu3Jpr0aiqiVt/
         z3ZNwX57r68SkTpVSaRWDo0JgbB6pmYRtsObEYxjNFbr9WJg/g8AR8ecaw7+ZULaG/VJ
         Lqyij31jnogR3crxd+0goe3lJxsdm4BTXNcxLKBEFEXZoR20KA+6VaOBC+wNFgR5RxjK
         2/Cij31FQnDSqIDG6r9d9CCgqvJWOyJ8j5RqTdJ+RhEWukZ7nJ3vpKlkFjsMeubvGaw9
         ui9JmD7HR1N44XHiD4tqGRuzmTRtyGHX78R0O15HffsazwynUzUOPVsevwz1QMkKmScs
         Azsw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2TgOXt6FfIYZviCRjZ4cpoGrM2J6fkyxibanCpwornjIBlGwfQj5K4Vuw9nZGVwU+x4sNzlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kAdC/xt0SnEvLFJ8ea+x/XemBLzTIh5onj8tI0gyrlpHKHJqG0
	4vkJBmIBlGhjM7KLS/2jI62asF2gdzcQcXjBZYITXUD4i/M+j/Njzc3g
X-Gm-Gg: AR+sD12XC8+O2qpNNSxOkg1OnIW0R/74vqM5hX0yzvQQzq40MclLgeW8Dej96slhNFY
	LI5rD2Lg98i2zcfmSKKM5/13ROQU+gGuK63XUdHUUrtDlBic4cFIjwFCVzGpegh07aKIfBcJXXN
	OOGHCNgpeQGtAJAHfb5SjBDOrKIO3S7gySTQkHTUqQI0lVgFdlzwUGNS49Ik1RTUNQQKimULOa/
	1+eCB9zCMfihEZigHJNv5Uha+U89JYmaGZ84r0ez5EcHe1rQmbhqOtyhLOW2+JQ++Dp08e4vZhX
	b3nzumBQauHj77awtQyNJcN6bA1Mqq9NnRFP31TbKB4o6m312wdWpEA6rwkCSlGmby1QzJ7wZHv
	ubBPUHcRTbekUz4vV5p0WTVZNq42pjYF0NCYPCXcRjdb3xSVAHmoiX2z1b8nXYZSBMfGv/a+b2G
	7aCyiCiMkOTMNK8Ux84oLF7jCMriWS6IdDSiJWgzo5I+HCJcPCggKGsttXdx+OyAMVkXYcolWwL
	8l/YwdElqV/wqTF5f6wzoRT4+vN+g==
X-Received: by 2002:a05:620a:4556:b0:939:28ab:e90 with SMTP id af79cd13be357-93928ab142emr1090242685a.0.1788135240228;
        Sun, 30 Aug 2026 17:14:00 -0700 (PDT)
Received: from smtpclient.apple ([199.30.143.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391703a49asm665449285a.11.2026.08.30.17.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 17:13:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <apSwfmDiwsuyQT6I@zenone.zhora.eu>
Date: Sun, 30 Aug 2026 20:13:28 -0400
Cc: intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com,
 tursulin@ursulin.net,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA6527E9-BF25-4EAC-AD11-7B2F92A3A01F@gmail.com>
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
 <apSwfmDiwsuyQT6I@zenone.zhora.eu>
To: Andi Shyti <andi.shyti@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Andi,


> On Aug 30, 2026, at 18:44, Andi Shyti <andi.shyti@kernel.org> wrote:
>=20
> Hi Shuangpeng,
>=20
> On Sat, Aug 08, 2026 at 02:43:02PM -0400, Shuangpeng Bai wrote:
>> heartbeat() detaches engine->heartbeat.systole with xchg() before
>> checking whether the request has completed. If the request is =
complete,
>> dropping the detached systole reference may free it. Concurrently,
>> idle_pulse() can observe the empty slot and publish a newer request.
>>=20
>> The worker then sees a non-NULL engine->heartbeat.systole, but =
continues
>> to dereference its stale local rq. The newer request can therefore =
make
>> the shared-slot check succeed after the old request has been freed,
>> causing use-after-free accesses to emitted_jiffies, submit, and =
sched.
>>=20
>> If the detached request is incomplete, heartbeat() can also overwrite =
a
>> newer request published by idle_pulse() when it unconditionally =
restores
>> the old pointer.
>>=20
>> Use cmpxchg() both when idle_pulse() publishes a request and when
>> heartbeat() restores the detached request. Drop the detached =
reference
>> when restoration loses the race, and reload rq from the shared slot
>> before dereferencing it.
>>=20
>> A KASAN-enabled i915 mock selftest reproduces the use-after-free =
before
>> this change and completes without a report after the fix.
>>=20
>> Fixes: bf9bd6a5128a ("drm/i915/gt: Track the most recent pulse for =
the heartbeat")
>> Cc: stable@vger.kernel.org # v5.11+
>=20
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>=20

> Your patch looks correct, although I don't think the Fixes tag
> is.  I believe the actual fix is:
>=20
> Fixes: 4c71fd099513 ("drm/i915/gt: fix refcount underflow in =
intel_engine_park_heartbeat")
> Cc: <stable@vger.kernel.org> # v7.0+
>=20
> That commit introduced the early xchg() which hides the old
> request from idle_pulse() and replaces it with a new one.
>=20

Thanks for the review and for correcting the Fixes tag.=20

> I'm going to resend the patch so that it can be picked up by our
> CI.
>=20

Thanks for resending it.

> Thanks,
> Andi


Best,
Shuangpeng=
