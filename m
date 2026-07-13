Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178033090C4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966754; cv=pass; b=WwTFPJ1g+XIQuy3HDlvD5ASplvXjRoRfoS9BzHCuK3/CZNuK/PBnciJ8luk001EzuNo2qeGL925WesFvV6+1OEFP5OmZwPguNzl6AAlHLgWXVqCw1r0lgGdKfrpc1f/AyQaiIf5GlAwgq8Ye+f2pj462uRNqG50CxlXnwRLu9nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966754; c=relaxed/simple;
	bh=a7J2o/Uawyqjxcq822ubh31HNGfGy3Dyi9p/J54OSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GscpQkQS1XT5lWspMn4wtyOiafFRcrbjOB/QRrcVDo6MQTIyI7SMhW+Q/qrAZfF0Ug9JVT88OOZwRZGffP2CGSIep0LMbfabl6uNBH9CDvkSvUKlULRd7dCA1pJcd3nX+OWHNDNBPc4iG/nwMY8jHfzTUs/LYB/QEI4qLYdj6xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=akfdfwC1; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="akfdfwC1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc73e322dbso39396055ad.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783966751; cv=none;
        d=google.com; s=arc-20260327;
        b=D1GQuJA4hRgj8fRfTDYW2oWIN0ktyfGoVzfAoYxXFhWw4VZzOCmWiosiPaWb7cTns/
         HgZsWuaZ7i57hlc0kSSLuuIcEIybnwUQ+zvApHhjcC+nOml4naewNeRDpHWRwqRUZd0S
         sL36vn+z6JE5MlFH6qUovyw67cP5WY/deEY1gjQDTGKZv8glplxDEpcMEAT5wsJd9glZ
         GwYyYZ1+EwT7w9URdDXOihXtGvODgYM/D2ityBB09Orw5aeWQblHXebHmINV8ZV85H/v
         FN9+OHSajlgTlnT5cMOC8fG47ylLa2a5p/TBlbbcjNyahDuBowBT0Z0lmQP6lvXVaM6u
         rRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        fh=CPc9RWFT0ec6lEmFHXRWzCpaWu7wKRhRHIyRo9TlCzg=;
        b=JMmJrLDWQQfcSbWxEM3rp3zVegevVJngnJUjFXSX4Fpo1Npka3JoH3uG5qq0KXvj/Q
         4JqiXUWXvaD47kTWp7aVcBWoT8drTma4/8nPv7A89/DbXPfy833/Rq13oUtoQSPwObz3
         2ieiTVEzavxYr/qoMCZX7x8CeTTRnVpg1TcrVTIdjlwniOr6nCZzYHs8ZCmVXv+XwtKo
         hvBxeeNpoQsR/8QEAcLR2yMcHafQQ5wsV2HCAPlF16zgNgvfK1cBNqYt3Sbi1iZ4umpC
         VbIKwZh+Mr1GxqeiJ2uXK7DLHaFRFvuwCBvSRb7Q5ROO8vgq7/8T8m5GInzxxlrA1HbZ
         WFDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783966751; x=1784571551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        b=akfdfwC1gWKnXlOaKIrr36v1gDkMDXb3e66zZbNTLs8iYvzO5smFEeG/755bf3KEPS
         zDONj3HwK8nJC84vUIXOObk1HYVdSXnbGCZjI0FaOCcJuroaV3/9+18hGC2kfaAuZ3mk
         eZWNxSXk8/q1lWnf5CBggcdOUSzBRgNzuZaCqg4qUl3vVxQNm+0v8X0x1vI3tnT05NI+
         jG405xgRp2dcJUEIFjNw9c+MQLq46HAgq6KZ7qas+PpVnsfvARuFH7r7kcBQaIl7XWua
         yo5fnimRe06QyVVY5DqTdjW1skDNLgIKCNir6aVSGxii2vkAmmf+SVEgB/Ez3kZI5VyM
         toRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966751; x=1784571551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        b=Ml8CAucn+JigC8mfPYg5gih/5L9nciEu2vyejJ1M0GcL+4Co8B/FGRjOMarKbVxJUr
         ta7k7kZr+mK9LS9CiBRy2sibmLK93m1GkFnF2vMXUkytHh/aWpSiBtn0nzXmJ+7lxeDO
         3ag0h5x2SCCETDASOEefiY3qvZiB2hQpb64BZGYKM4443nxaJswBiVmaFQGuCfBrG/TA
         3dvKFhGS9DB/X15zPaqBv/101txPUFfk7lrhCg0Y/a5huBaOk0XQ4vKyAdXXkadd4/mU
         9MEZxnidWEvfPa9eeoiAPbZnAO04w3rh/2coZsLHpYkGRM4T4izSGtZCsFGFN6Hba0bX
         M8QQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr7wDxreV4rcRM3vTMu/CIkVfT41HmOq5cudrFGP7Ewt8a9D9n7inJabAr8O4z/oH87vY4ybU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdVtx4AW5HRsOpU4D6AdKuTE42kMeh2QDXFjGXVOgiP+DmBmH
	Nb6O9rNinz1m3vfvKv73Lw1ofrvXLtOFSIE53LPMcOaRbbUN9rdHf5MYHH03ISZAcAwUzpEw5pC
	GUBm3/H7EriaIheuNifbL5RQAmPqNbnVFQ0rkjEvW/J0=
X-Gm-Gg: AfdE7cnQ2Zi25/+tbMJgcSjEopDgphcbnozyR/TfwQfIA3jIQu/tm1Ehbeq8fnjL2fs
	423bv8+4huxcHa59wLans80ursDEH9dFy8C5OJOZYt1PLLITd7pvtB+3TRFefrcm9yvgaPu4AV1
	yhVfCFMAc4Be/Is3tLEHTnrPBqH3KpN1k/YO4jKpmJn+sGh0H9NI5sEiAFm2rWSZJPqV0KkPrCw
	FIJPwnAhhy44OfjAu06BtI6z74ao4fUsxwtrXML5Y00zmHOnwYtBiwwsTTpWKhWtdGJBvdwMgW/
	+/pfByqSMpzLMLH5btkfPE2FA8sHUp91+1E4atgJzNaNtUmPtmegFmEHJ9XFHgOQZcRRWd0=
X-Received: by 2002:a17:902:d546:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2ce9eac212bmr103069735ad.17.1783966750843; Mon, 13 Jul 2026
 11:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711071336.58324-1-doruk@0sec.ai> <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
In-Reply-To: <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 20:18:59 +0200
X-Gm-Features: AVVi8CenKr8Md-_ghFq-SY_VTIPefNoGzVmvVLnHgY8iSBM67OYes4dP0hXi20g
Message-ID: <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: jeff.johnson@oss.qualcomm.com, linux-wireless@vger.kernel.org
Cc: tristmd@gmail.com, johannes@sipsolutions.net, 
	peddolla.reddy@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 7/11/2026, Jeff Johnson wrote:
> Some aspects of your patch are already addressed by:
> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
> So you will need to rebase once that lands.

Thanks for the heads up! One thing that looks like it may remain after
Tristan's patch, in case it's useful: the aggregate check bounds the case
where the declared lengths are too large, but ath6kl_cfg80211_connect_event=
()
still underflows when a length is too small. It does, on u8 values
with no lower bound:

assoc_req_len -=3D assoc_req_ie_offset; /* -=3D 4 */
assoc_resp_len -=3D assoc_resp_ie_offset; /* -=3D 6 */

so an assoc request/response shorter than the fixed offset wraps to ~250, a=
nd
cfg80211_connect_result()/cfg80211_roamed() then treat that as the IE lengt=
h and
copy that many bytes out of the small assoc_info buffer to user space. That=
 path
is separate from the aggregate over-read Tristan's check covers.

Happy to send a small follow-on clamping those two subtractions on top of
Tristan's series once it lands -- or Tristan, please feel free to fold it i=
nto
your series if you'd rather keep it together. Whatever's easiest for you bo=
th.

Best
Doruk

DORUK TAN =C3=96ZT=C3=9CRK

Co-Founder


0sec

Universit=C3=A4tstrasse 33

8006 Z=C3=BCrich, Switzerland

www.0sec.ai | doruk@0sec.ai | Linkedin



On Sat, 11 Jul 2026 at 16:39, Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 7/11/2026 12:13 AM, Doruk Tan Ozturk wrote:
> > ath6kl_wmi_connect_event_rx() only checks that the received event is at
> > least sizeof(struct wmi_connect_event); it never checks that the traili=
ng
> > beacon_ie_len + assoc_req_len + assoc_resp_len fields fit within the
> > received buffer. Those attacker/AP-influenced lengths then drive two
> > out-of-bounds accesses:
> >
> >   - The WMM information-element scan builds
> >     peie =3D assoc_info + beacon_ie_len + assoc_req_len + assoc_resp_le=
n
> >     and walks up to it, reading past the end of the event buffer when t=
he
> >     declared lengths exceed the buffer. The walk also dereferences
> >     pie[1..6] and pie[1] (for the advance) without checking they stay
> >     within peie.
> >
> >   - ath6kl_cfg80211_connect_event() subtracts fixed offsets from
> >     assoc_req_len (-=3D 4) and assoc_resp_len (-=3D 6), both u8, with n=
o lower
> >     bound. A short assoc request/response underflows the length to ~250=
,
> >     which cfg80211_connect_result() / cfg80211_roamed() then treat as t=
he
> >     IE length and copy out of bounds from the small assoc_info buffer,
> >     disclosing adjacent slab memory to user space via nl80211.
> >
> > Bound the declared IE lengths against the received buffer, bound the WM=
M
> > element reads against peie, and clamp the assoc request/response length=
s
> > before the subtraction. The sibling wil6210 driver already performs the
> > equivalent length check for the same WMI connect event.
> >
> > Found by 0sec (https://0sec.ai) using automated source analysis; the
> > missing bounds are evident from source and cross-checked against the
> > sibling wil6210 driver. Compile-tested.
> >
> > Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>
> Some aspects of your patch are already addressed by:
> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
>
> So you will need to rebase once that lands.
>
> /jeff
