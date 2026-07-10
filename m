Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5D428842;
	Fri, 10 Jul 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688282; cv=none; b=Gz0EwBD+O1B4x6RyPTnwGiS0GdHudtailsm9ep0IpRqgtIcpOPFOowwqGhhd3SHocQgQRHcKPxi9uUWeGXRfS5nCXIiBGabfwFe16luY9Pbb/0O4ml7+cG8Bp5mzgjM4P3m2WldgSVMVh1GnCwmChBnIDQz9UfGESszQgipPP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688282; c=relaxed/simple;
	bh=FZzevKoiVmYopHirOVuR8oaLAU0WoRckWAOK2bddIyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtW0Hij4419o4GmQP3a5IaJCYcbk6MQEQzCbdtT+Q2TbjCY67JxIurjgtZrMR5FLehEr096syYYHFZf6HcbFj4P3TBe1DVZE9ayuIa4lxaPtNGj15Fvte6IX9iul3dzJ4KJk/2VWLEhOSAVVn9Vb+cTVhZatIj9NtM1a4a0FCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwJAS4i9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwJAS4i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE51F00A3E;
	Fri, 10 Jul 2026 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783688281;
	bh=D5H3agfHV0HoxY6q5W40qXcJSpS0gvK61uD/YgXU8Aw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JwJAS4i9OT34p/KfLkl61WaLkIArfYzCNqPK4A5V0bW3Kl5zrlAz7ct4Iqt8wYzqr
	 Wj9tE7z7CNKdbXzQwxFQcqekVvLtXzggK4PqkjISeY2kwarNl9hr/G7DJaKjaYTaL9
	 nFIIXpmh58WTEGIJmTDhun8QOn59SDs5NtWo1QX+KfpB1Nr8OHJNcXOaKsoX9YCITB
	 E8PrAcbxMi+RnGO7BSdVeg6UGWJNjvsvvfjK2Bzv9uD/wi3/nUEJZaOodrem939hsI
	 RhIAzkbgyk8rsAHY1JVgr3zl8BeVwFLYdNsBzX+o+p5FTfOxYOdDDB55yavpgXrOar
	 dbO2c4U9l9dhQ==
Message-ID: <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
Date: Fri, 10 Jul 2026 14:57:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: Lorenzo Stoakes <ljs@kernel.org>, "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org,
 thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org> <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com> <ak_A6Yc5mBXCrtXr@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ak_A6Yc5mBXCrtXr@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/26 17:44, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 05:19:10PM +0200, Gupta, Pankaj wrote:
>> Hi Lorenzo,
>>
>>> So under what circumstances are we happy with totally breaking dirty tracking?
>>> :/ seems iffy, and exposing this to drivers generally is a bit worrysome.
>>
>> The intention is to allow long-term pinning of file-backed mappings only for
>> migration avoidance,
>>
>> without kernel GUP writes, and therefore not impacting dirty tracking.
> 
> OK as long as that's made clear in the patch, commit message, comments etc. :)
> 
>>
>>> Hmm I'm confused, you're then allowing FOLL_PIN | FOLL_LONGTERM, but disallowing
>>> FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK?
>>
>> Yes, I addressed this in my reply, but it wasn't a clean inline response.
> 
> Ack yeah I assumed it was a quick proof of concept and just overlooked it :P
> 
>>
>>>
>>> By the way I think this should be expressed better if I criticise myself here :)
>>>
>>> So like:
>>>
>>> 	if ((gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM))
>>>
>>> Or even:
>>>
>>> 	/* Only an issue if we pin... */
>>> 	if (!(gup_flags & FOLL_PIN))
>>> 		return false;
>>> 	/* ...and that pin is longterm... */
>>> 	if (!(gup_flags & FOLL_LONGTERM))
>>> 		return false;
>>>
>>> But I'm confused as to why we are suddenly allowing something broken and what
>>> this hack flag is supposed to achieve?
>>>
>>> Shouldn't this rather be:
>>>
>>> 	/* Only an issue if we pin... */
>>> 	if (!(gup_flags & FOLL_PIN))
>>> 		return true;
>>> 	/* ...and that pin is longterm... */
>>> 	if (!(gup_flags & FOLL_LONGTERM))
>>> 		return true;
>>> 	/* ...and not overridden... */
>>> 	if (gup_flags & FOLL_LONGTERM_HACK)
>>> 		return true;
>>> 	/* ...and dirty tracking is required. */
>>> 	return !vma_needs_dirty_tracking(vma);
>>> }
>>
>> Yes, this looks much better. Will incorporate this.
> 
> Thanks!
> 
>>
>>>
>>> Yeah this is just a bit horrid having to stare at a this a while... So
>>> FOLL_LONGTERM_HACK would enable here.
>>>
>>> Be nice to avoid this form of it as it's difficult to understand, do something
>>> like above or a clearer version anyway (probably best abstracted to a small
>>> function).
>>
>> Sure.
>>
>> Also, I am also planning to rename (FOLL_LONGTERM_HACK ->
>> FOLL_PIN_NO_GUP_WRITE) in v2.
> 
> hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
> without - any checks that exist for that btw should be extended to this noew
> flag).
> 
> Also don't we want to encode the legacy aspect here?
> 
> Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)

I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.

We want to longterm write-pin.

@Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
write" ?

I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
I don't see where this is "no write" or "readonly" ?

-- 
Cheers,

David
