Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0392392822
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507993; cv=none; b=XO7+dobMp90SjoSkpIoMFG4OIfbzcpdjRnNaIyShPCUep8z6LZ/IJgUiNwf8Ju58ZppmuBu71ZXW74gwQlsrVdT6E4Hy9VUSjkOanf4bokXl39CfY0wags5U1XbgWVmdoQVK6cS1urp6kSyoDdqWDyPSdcGLKNzo/jM+zpx/UXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507993; c=relaxed/simple;
	bh=Dzfwonr9rKeQnkqeStmW/2Bvbf4Y0mUvyLlk4d31nfA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RUOQcF9lH1A5NX9qoDaYJOWX4C8PdzB/KJmXUYqbN4CCYdP42YZWWiQNBsLB/wqfa+EoM8/sFdMR9LagGoh071GbS40ROG2uAtWYsYym1ESFvKPMnXEqei6FIF7Jn9UTfteWP3LDC2o6v+zeXv28GHYpW5fK1VJ5eUc9lDZXpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebNFBBId; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebNFBBId"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-529a1ee0e62so1712061cf.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786507991; x=1787112791; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WoA62XvqBE/bJkGlo+pvls7iLFgdIjTnZ2CNMnT1eiI=;
        b=ebNFBBId2fv/SUOpopDfigYvG137FWd9dsh6zNOBMCIxpQ9Y1BkzD1wbDdXZB4qoK+
         hffx1Jex9QWamcN5Vc64ONrR5hbZiQ2R+FAcvyyBH5hnFG4r+Xtldxj9d912uMA7SvWM
         SNPuntLjHP0ftdkjAzWIi1cVejTP6Btf+29QTTeEAJZvn+ZIT3glhUv0ABU2m0Iy45jg
         rTGas/2JHMQ4KL9WWISURBLd0jrylJMlTZa9I2oNooSFRgcrZT1VyjDETHoY0dht10it
         q/Hx6xzmlOIT9HTHm6Jos+skzKuvjF/PMu/H6zUo9/Ubmxk91xT/ODJNvdjNkQ0xWmBT
         PD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786507991; x=1787112791;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoA62XvqBE/bJkGlo+pvls7iLFgdIjTnZ2CNMnT1eiI=;
        b=CZ+v4OeXa1uM58T39lQD9LhPEdLONTi2M8jxy2mTaSnhu5l1HdV0i/C4Va/kWUdQnz
         F9wNTWlmzhVwxDAQV68gSRZ5/sWzwNOjirCDs6m4WdrA80QgXkMZ5aAIiAXfLX38QJKI
         uE3Ya9SBgN7Q51Wxn2KPrW5D0bUXrEHYh3VWbZKwXaQTORqf021NKk3LM0BUZzj+tqlB
         +qeBRiWxK9FmNbKrrNpPheJocncAcue48dZTCq7TCqsCl0Cn2bS4Ik3/WgNQnCRBty1Q
         zlVnKXyWQF945wpa0J2FJOEEcQtB3SMXoQ6jhQXJukgWCxx+NHc0qOLSQUeHrnJRojVQ
         rSmw==
X-Forwarded-Encrypted: i=1; AHgh+RqfdGaMuNoIIszBCS4cAUGWLeXL4cZ861ze6HCMkeB136DSYvaaKLHgn4JcNefhnCwPXvKLzD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyveTnT4CHb+Q5q40ro34sbVYqBzISnhSFINuxFu3W0dIrtVFXb
	gpcVMeQ0S0TqxJpZ2pV55cOKyCpQEup+7EmlNSIZcT0zxCHrkZy2xVps
X-Gm-Gg: AR+sD10O2QeOI+qGH/4wzb70sYhfmoP3VXm7qP9goYZDfz9aXTuyDEAD2nHii9v+YF0
	b7Y7JkRv8R+PqeB8XPHPjmIuYLWHqnPIHRx1AeHGv1bIJU7Kt6QPs0TS5nQbsanq+KYhKzlpkff
	n/wpfBreS7bdx0SPzBzk5onb3z8GTNKUvUUxIyun9kfxDQhPulCLBMIxH0ia70+uaKtoPnu3MrP
	y5LZEvcklDQykAaYIvqO0+tkXwenCT6h+KVdskUdRmoiGgtoJpnJ7uheydkA2mjpS/X7Dbia1DR
	MRms7+VwvTrRC+ipaNFzABfsb1gtuKBhjc4ek7bi4wWCG079JT5UJ/0yYvOrQSVfnXOUbc3L689
	4HgqohWL4Ohu6CriT6e2Quzkd9jV8bjaJsvCOOtFP/3Ug9dwD7FwYEDrrSPybLHhXNVHUilbTWN
	JcPYcOoIxsvKZG2ZAxzjoeLJJESsr7AzYsX3dpvcg7RGEOWRoBfxENETFiUoxpouHjo0dMoEveA
	nhCryqqprjQlj9PUh6Eb5fxBgNq/rwb
X-Received: by 2002:a05:622a:a0a:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-52d6483fbfbmr18441601cf.37.1786507990610;
        Tue, 11 Aug 2026 21:13:10 -0700 (PDT)
Received: from smtpclient.apple ([2600:1016:b10f:b114:6c29:917c:9735:8846])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61e017bdsm10172371cf.27.2026.08.11.21.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 21:13:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] drm/i915/gem: Fix request use-after-free in
 active_engine()
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <zmincd7ubpkwasily6fegvx7mz6zkdw5oglbj3ynpgqovpkszh@un7lyxy6dgly>
Date: Wed, 12 Aug 2026 00:12:38 -0400
Cc: intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com,
 tursulin@ursulin.net,
 chris@chris-wilson.co.uk,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0602E2B1-4FF4-4496-916D-D4DB1C1B0830@gmail.com>
References: <20260809173646.3292361-1-shuangpeng.kernel@gmail.com>
 <zmincd7ubpkwasily6fegvx7mz6zkdw5oglbj3ynpgqovpkszh@un7lyxy6dgly>
To: Krzysztof Karas <krzysztof.karas@intel.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Krzysztof,



> On Aug 11, 2026, at 05:37, Krzysztof Karas <krzysztof.karas@intel.com> =
wrote:
>=20
> Hi Shuangpeng,
>=20
> On 2026-08-09 at 13:36:46 -0400, Shuangpeng Bai wrote:
>> active_engine() walks timeline->requests in reverse under RCU and =
takes a
>> temporary reference before inspecting each request. However, it drops =
that
>> reference in the loop body before list_for_each_entry_reverse() =
advances
>> the cursor.
>>=20
>> Concurrent retirement can unlink the same request and drop its base
>> reference while active_engine() holds the temporary reference. The =
put in
>> active_engine() may then be final, freeing or recycling the request =
before
>> the loop step reads rq->link.prev. SLAB_TYPESAFE_BY_RCU does not =
defer that
>> reuse.
>>=20
>> Open-code the reverse walk and cache the previous request while the =
current
>> request is still referenced. The next request remains protected by
>> i915_request_get_rcu() and validated against the timeline before use.
>>=20
>> An i915 mock selftest forced retirement between the active check and =
cursor
>> advance. The vulnerable tree reached the final request release and
>> kmem_cache_free(), while the fixed tree completed the same ordering =
without
>> accessing rq after the put.
> What mock selftest are you referring to?
>=20

Thanks for looking.

The "i915 mock selftest" I referred to was a local temporary mock
selftest.

Because generic QEMU does not expose an Intel i915 PCI device, I
used the mock engine/request infrastructure to validate only the
ordering in active_engine(). In short, the test forces
active_engine() to hold the temporary request reference while a
worker on the other CPU retires the same request, so the
subsequent i915_request_put(rq) in active_engine() becomes the
final put. That was only meant to show that this interleaving is
feasible.

I can clarify that wording in v2.

>>=20
>> Fixes: 3cfea8c97c93 ("drm/i915/gem: Hold request reference for =
canceling an active context")
>> Cc: stable@vger.kernel.org # v5.10+
>> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> ---
>> drivers/gpu/drm/i915/gem/i915_gem_context.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c =
b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> index c58ffa5a8fa6..ff5c892a0176 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> @@ -1361,7 +1361,7 @@ static bool __cancel_engine(struct =
intel_engine_cs *engine)
>> static struct intel_engine_cs *active_engine(struct intel_context =
*ce)
>> {
>> struct intel_engine_cs *engine =3D NULL;
>> - struct i915_request *rq;
>> + struct i915_request *rq, *prev;
>>=20
>> if (intel_context_has_inflight(ce))
>> return intel_context_inflight(ce);
>> @@ -1375,7 +1375,8 @@ static struct intel_engine_cs =
*active_engine(struct intel_context *ce)
>>  * (and onto a new timeline->requests list).
>>  */
>> rcu_read_lock();
>> - list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
>> + rq =3D list_last_entry(&ce->timeline->requests, typeof(*rq), link);
>> + while (!list_entry_is_head(rq, &ce->timeline->requests, link)) {
>> bool found;
>>=20
>> /* timeline is already completed upto this point? */
>> @@ -1387,9 +1388,14 @@ static struct intel_engine_cs =
*active_engine(struct intel_context *ce)
>> if (likely(rcu_access_pointer(rq->timeline) =3D=3D ce->timeline))
>> found =3D i915_request_active_engine(rq, &engine);
>>=20
>> + /* Cache the cursor before the put, which may release rq. */
>> + if (!found)
> You could skip this check here and unconditionally set "prev".
> Its value is going to be used only once if found =3D=3D false anyway.
>=20

Thanks for your comment. I'll simplify that by assigning prev
unconditionally before i915_request_put().

Please let me know if this addresses your question. If it does,
I'll send v2 with the wording clarified and prev assigned
unconditionally before i915_request_put().

Thanks,
Shuangpeng

>> + prev =3D list_prev_entry(rq, link);
>> i915_request_put(rq);
>> if (found)
>> break;
>> +
>> + rq =3D prev;
>> }
>> rcu_read_unlock();
>>=20
>>=20
>> base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
>> --=20
>> 2.43.0
>>=20
>=20
> --=20
> Best Regards,
> Krzysztof


