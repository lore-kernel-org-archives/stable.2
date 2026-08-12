Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20138DC47
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507124; cv=none; b=IL+bgh5nAEeGUBbQOEsB387Lz+zTJLSGUzbeU2/307Xsi/Hjeh4bh0s9OiVg+v9wWWn5X62VSzXPdx1fNa5UJIWgBpV7Inq9O3hrlvE0xehVuRW/PhrCD058/+9KEuYS3Panidc4kC4tnF7qci4AKxXk35ajwgOrdeDh/3RPvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507124; c=relaxed/simple;
	bh=39p+/hRGdW2JkBC4Q61Oue/5/kbA0dBnNTH+zRAOmEc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jiLq9yhQARevcYcffDFwde6/RLAKXWy9Zu+1SCW9ljTHuV6cCcEOv0Ec3PXujdezm2crh+iXR8CF95ZV8dD27vMp55zpH7mjcD6x0+iPK0PGRLvEqOqnTaicMXkAeeic7vTrt8A0ond+RMQSia23e6565HWMjYuWcWlLZCW/Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQcykUne; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQcykUne"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e512a9a6bso14688285a.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786507121; x=1787111921; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p1ustWcvblwbfs6YObNVhPj8bLhBv9z4SEr4Hg478cA=;
        b=sQcykUnetaoQhVjhXn6kDa5dl9T2SfQJxvKQ7hf3pGnIySGuFs4rh0XSSDdxLcLSbC
         /xyVbapmKCVTXDswu+hZ9aK31eOReSal4r3tvciXYQwQhO5Vqz/+8f8WzktHEyuFAIdJ
         uSzGUTG5z/Pk+IpCikIvLFPMuL//DFEESDyDOXt8O2z+YMrxkbfTv7iTRkWMzxGvGXfw
         +Zrx4i/SkaFXGN7vZ9tJZqj/ZYanKow5iBX7SRelE0SkcD74Qr3gPpMhMlA2P8YghmPZ
         6vB/Esxjex9/h+hbuOKEt5hMfqPfNK0EFdtCU2pZ6wDeZCfxIGp/HUVQ/DMoQZMk/1I3
         KIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786507121; x=1787111921;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1ustWcvblwbfs6YObNVhPj8bLhBv9z4SEr4Hg478cA=;
        b=epDpA/0JqJDQAJC5iIPWcddD0WGtMGBWJtMk+fvZsGOsJJAS4sIOWaBkMoKdA1r9Yv
         d6MKJqp9OSJJhGGnd86P7KFOHzf42YvW6CLPcSquoEj4mZeyTZYbSQav/+sUZ1B3uue+
         I+k5IlqeWT+rDttyLXESenVB7ADxOqyO3hjA3Op99RJycKngt9aTbPC8U0zOT3KkAvZy
         KO2oQQUadIp3chJM2hEZQMAZ7W8cLYbx4uVCGbUzjPFslEeRbrBGdd78McXl9E3vcor8
         dStQKhsdZ8yobG1pHMjzR9IlO+Y0qq49MlWJZzoAR9hyoPuEBNUb6/lNo02hDK0JjM7x
         nkoA==
X-Forwarded-Encrypted: i=1; AHgh+RpL5S97w5wAPpW3pSYsgE/ybPP1bZr1/MWmPxzbAUUqV1hqZ3wGmduVCATc+NJwvTS9AHKYtFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10VR7qH5XZ1iNk/fn0HmfcMsXHWU7W34AbA+gtoBf9WtDAt2U
	wvRazk98RKGIPw+Zw+QXDbse+0duAcsbC8ysj6/jyBNowOGLyY9yyIa0
X-Gm-Gg: AR+sD11WupbKui/2Ajzxrnl+80R/uX9z42fcf7t6hf++ndhV/jlTAB3aA9AnT/gedUc
	D+2xZk/QY56dwqa7x/jascvk221JgS8dZdQwjpC35S5pGJDVrDz353sqJlBuAB58eXcYY5LNvjd
	6+pyYci2udvzFXzr06jZOaMEKQ9A6nrqO6rV8YZmvnIRslmM+CQKGKTjc5+wQRkrHbW98Wqp4/3
	WEjHWJYoEVGTyvVsKE6JrXPFzu1zsui4dPTDG1S4Kqqxk53UdWiJEVotf72Tt8+ttLV3lHQhxQn
	F3ewcMz3aNu66OO+Yq2TaJi/LoU7j9vBMZ8KNq1Y6mfoJ9FJe2VBnDLnr8XCfbt3xbOAQG6p/os
	SJy61S/fOQJxAIzyNX5nXjO5+Emo7wSVFR+fteddtdUV8RUX9mmLiDXEJNs6yqBr/yWhWa+qXp4
	i3RAUzzjaF3vHPiaAPNdxXsm03KAnnMsjkMa6Q48qY317DC2ToGUSuCMpflm8G73kr5Mkc92dlo
	pSzyHqs3ZpskuvMufVkYxugN/kSedij
X-Received: by 2002:a05:620a:6912:b0:92e:e2f4:e652 with SMTP id af79cd13be357-936b3a44f20mr220782485a.16.1786507121508;
        Tue, 11 Aug 2026 20:58:41 -0700 (PDT)
Received: from smtpclient.apple ([2600:1016:b10f:b114:6c29:917c:9735:8846])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f64f8esm35682885a.46.2026.08.11.20.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 20:58:41 -0700 (PDT)
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
In-Reply-To: <yzfnzbtsqjvk4y6vhn7uvdrzew5hqzfo4khdsx226ppqdjgm4q@xzysjj4fwcwz>
Date: Tue, 11 Aug 2026 23:58:09 -0400
Cc: intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com,
 tursulin@ursulin.net,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1734D14C-BCE0-4B86-8FD4-C1A989AC629B@gmail.com>
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
 <yzfnzbtsqjvk4y6vhn7uvdrzew5hqzfo4khdsx226ppqdjgm4q@xzysjj4fwcwz>
To: Krzysztof Karas <krzysztof.karas@intel.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

> On Aug 11, 2026, at 06:50, Krzysztof Karas <krzysztof.karas@intel.com> =
wrote:
>=20
> Hi Shuangpeng,
>=20
> On 2026-08-08 at 14:43:02 -0400, Shuangpeng Bai wrote:
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
> What is this mock selftest? Can I see it somewhere and confirm
> if it works myself? A link to a public issue would be cool too,
> something that gives more context as to how this was discovered.
>=20

Hi Krzysztof,

I've put the reproducer here:

https://gist.github.com/shuangpengbai/1410664bc909e8c834311576d6242103

Tested on commit a59f57e2aa127c5354168d2ec4bac920df1be4f4 (2026-08-07).

It uses i915's mock selftest path, so no Intel GPU hardware is required.=20=

Please apply 1_repro.patch, build with 2_config, and boot with:
i915.mock_selftests=3D1 i915.igt__36__mock_heartbeat_uaf=3D1

Expected result:
BUG: KASAN: slab-use-after-free in heartbeat

Best,
Shuangpeng

>>=20
>> Fixes: bf9bd6a5128a ("drm/i915/gt: Track the most recent pulse for =
the heartbeat")
>> Cc: stable@vger.kernel.org # v5.11+
>> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> ---
>> .../gpu/drm/i915/gt/intel_engine_heartbeat.c  | 22 =
++++++++++++++-----
>> 1 file changed, 16 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c =
b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
>> index 6424ecce8bcb..fc6c53c93cf5 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
>> @@ -81,10 +81,18 @@ heartbeat_create(struct intel_context *ce, gfp_t =
gfp)
>>=20
>> static void idle_pulse(struct intel_engine_cs *engine, struct =
i915_request *rq)
>> {
>> + struct i915_request *systole;
>> +
>> engine->wakeref_serial =3D READ_ONCE(engine->serial) + 1;
>> i915_request_add_active_barriers(rq);
>> - if (!engine->heartbeat.systole && =
intel_engine_has_heartbeat(engine))
>> - engine->heartbeat.systole =3D i915_request_get(rq);
>> + if (READ_ONCE(engine->heartbeat.systole) ||
>> +     !intel_engine_has_heartbeat(engine))
>> + return;
>> +
>> + systole =3D i915_request_get(rq);
>> + /* The worker may have restored its detached systole in the =
meantime. */
>> + if (cmpxchg(&engine->heartbeat.systole, NULL, systole))
>> + i915_request_put(systole);
>> }
>>=20
>> static void heartbeat_commit(struct i915_request *rq,
>> @@ -152,9 +160,11 @@ static void heartbeat(struct work_struct *wrk)
>> if (rq) {
>> if (i915_request_completed(rq))
>> i915_request_put(rq);
>> - else
>> - engine->heartbeat.systole =3D rq;
>> + /* Keep a newer pulse that raced with the detached systole. */
>> + else if (cmpxchg(&engine->heartbeat.systole, NULL, rq))
>> + i915_request_put(rq);
>> }
>> + rq =3D READ_ONCE(engine->heartbeat.systole);
>>=20
>> if (!intel_engine_pm_get_if_awake(engine))
>> return;
>> @@ -163,11 +173,11 @@ static void heartbeat(struct work_struct *wrk)
>> goto out;
>>=20
>> if (i915_sched_engine_disabled(engine->sched_engine)) {
>> - reset_engine(engine, engine->heartbeat.systole);
>> + reset_engine(engine, rq);
>> goto out;
>> }
>>=20
>> - if (engine->heartbeat.systole) {
>> + if (rq) {
>> long delay =3D READ_ONCE(engine->props.heartbeat_interval_ms);
>>=20
>> /* Safeguard against too-fast worker invocations */
>>=20
>> base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
>> --=20
>> 2.43.0
>>=20
>=20
> The fix looks sane at first glance to me, but I'd like to see
> how it was spotted before diving in further.
>=20
> --=20
> Best Regards,
> Krzysztof


