Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D16469855
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851041; cv=none; b=ABKZRVcgkn/aAzFvTmg0UDQJ053MTRlAgIzAhs+EypzCiJMdVB2IxBG7R8lhxxyz1c3nbiMbxsoHFKqmaNLekktZV3cq3CmOXbmixK98dswv/Izk9uN5E6z92lygtrAa+mm4njqgoofD4FOlDX+5B/Cf1VNnbmqaiaS4dh1kTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851041; c=relaxed/simple;
	bh=bBqHo7cgMcMxcURN8Wd100oKaEzAh6562DoBdEg7bfw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=uY2AOVktJvlSf4keuLCIbj6kNQFe8t1wKQNlTFyh6gRZ4WDSRfGbhbnhQerzddDMLZ6KtxVspAOxj2g+Uf9DGo1stIKV3vAIY519PhG1pz73ata23E66etexCBGAGbt/IgyggPkyN9rA3ycVtiAoVJ/u6WzAjrwZUO6m6wCcbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=DoaUVbd/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="DoaUVbd/"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so3922317b3a.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1785851034; x=1786455834; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAxXDfQTeUSwzSc1A2mLr5Ub4YRI9H9bgObn+nrblJU=;
        b=DoaUVbd/kHNtWl33evFF7d4KyPwty9T3erOO/VPoE9OeQaH9SNK2FvXdGL5fui0kdt
         LuOf6A5GhjrwCqlA3x9MjffFmh2guj6b/rQHcoCqrmqt7/BNl4Ccz1ccl9FrclK0r4Lv
         dS/5Koy61KZDspfootHoxVO5GIZLGPJUXVKfxMd/+NLT5O+Rc6f8ghq55EjYtRjUaSsq
         fJN7RBMkyweb3Trt+GTi1PRgwd0wWaaGvTUYrtT9bG+WwrXLfBti9v19k75VGjhKU/7D
         iUuoEDpldBcfxkOKzBPBYIa/GgglV/GEwWkVbS09D6nEeCfF16Z4071Yk6WrfXmYf9vs
         o3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851034; x=1786455834;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAxXDfQTeUSwzSc1A2mLr5Ub4YRI9H9bgObn+nrblJU=;
        b=XQ7+zJO9SeDelFIdZPkrESww9JXRSwEIa9JfkX1yGcbJJJqIYdSrcpKRehKIm/YrYW
         nWoDRjaeCmI1nsnkpt5TRHS3Sd2J2USorElj5zkwzbbKf2IHUuejAmObP/sXEqKbuf3e
         ywp9K4YqVycgKXmL8D9j4Hkal4URdJbLUNlPb5ANw1vGR1++aDrKOq+B8TZHZ8TrqNco
         aOzQvlR1OV6CB/Gk3+h5GvKCxh9qZC5VU2g9AsZ4/m5AijCeeGpa/P8zQ072JqztBJhE
         2neOiarzoAPjUKt2wa/T7ZXnspcUB2Up5BOBHJeHFlK+vndVqNBNl+PouFGXcpdHUchP
         UfkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPR7UVeZT+Qk09L1BqSN+WNahAO+COGcLU0qPMysx//a6VHB+AbFZ6Hhgzxe/MRpy8OuzGYzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfhoFqlClqv8aaqXLRnO743QJ+kW4K3gwdwyH0orR+X6B79P9
	ktyO4XdRK25eOU2PpNtlsrSfO6ElipWndnc6tV0+t7C069zRKXGBDDHkCprzbLSHog==
X-Gm-Gg: AR+sD12yhiBJ34inbctarz8mQ527yKONV19cP87+DHdRr2NYb70+Xmx1g6xdfsmmEDJ
	3LcBAeGegiO17M76bP9yjN5qiKGH67Uio7AB1BPpNZEHE7XuVy+8v9BLuCqLx8ta9ayovD2hB7b
	WYIILK6Cp9rBkiBcwpJ0RtQi04eMN4bqAlZqIRofraA1E5Os6NRC3rufE1ImSebNwfSgP6rlfKj
	T8m+1QcnGK+dgZEHV05OlJvUuibZ7qcCdIE9MTgLRG5+pJtReAJYxYDu+akVaSiHHX8zYlq30DL
	5ocGRjnYx2x4s8GPQWl37APkabfR2IOB2e9z8V24/ez3nm9UeHV2ui2C52E3ZZCWZ79pAv63RwB
	hooxMmZ+231o4oj73sKrsXGZDKSKhDaRSlebVA8TLgVKtB3kKrmW9gl8JSBARJIORYuHpnFXRap
	1TUQZiW4TWJja/M4Bi28Chr3IUiuRTAHiNbtlf1KzlxUaMbPMz648dgmJ9wME+bOrRDnPZ6XLlp
	oglQ5IaNgwAJ9QC
X-Received: by 2002:a05:6a21:9985:b0:3c1:657:4c95 with SMTP id adf61e73a8af0-3c92a75a3b5mr15448830637.15.1785851034479;
        Tue, 04 Aug 2026 06:43:54 -0700 (PDT)
Received: from smtpclient.apple ([76.14.8.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0bfesm5304154eec.3.2026.08.04.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:43:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
Date: Tue, 4 Aug 2026 06:43:41 -0700
Message-Id: <0B39A63B-3697-4FEC-B6FF-2F4D5901F7E9@amacapital.net>
References: <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, luto@kernel.org, linux-mm@kvack.org,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
In-Reply-To: <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Mailer: iPhone Mail (23F77)


> On Aug 4, 2026, at 2:34=E2=80=AFAM, David Hildenbrand (Arm) <david@kernel.=
org> wrote:
>=20
> =EF=BB=BFOn 8/4/26 11:25, Qi Zheng wrote:
>>=20
>>=20
>>> On 8/4/26 5:05 PM, David Hildenbrand (Arm) wrote:
>>> On 8/4/26 02:37, luto@kernel.org wrote:
>>>> From: Andy Lutomirski <luto@kernel.org>
>>>>=20
>>>> When zap_pte_range reclaims a page table, it does:
>>>>=20
>>>>      pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
>>>>=20
>>>> and this is unconditionally wrong: if this code executes, addr *always*=

>>>> points one past the end of the range covered by the table.  The addr
>>>> parameter is used to flush the TLB (really the paging-structure-cache)
>>>> to drop references to the to-be-freed table, and any architecture that
>>>> cares about the parameter will flush the wrong address.  (But they'll
>>>> still free the correct page).
>>>>=20
>>>> I think it's worth contemplating why the kernel works at all.
>>>=20
>>> Note that this only triggers when someone does e.g., a MADV_DONTNEED ove=
r
>>> a large enough range (covering at least a full PTE table).
>>>=20
>>> So this isn't the ordinary munmap()/exit() page table reclaim code.
>>>=20
>>> I'm still surprised that it took so long to show up; likely we need more=

>>> targeted tests for PT_RECLAIM that
>>=20
>> We backported the PT_RECLAIM to our internal tree a while ago (excluding
>> the rework patch being fixed here), and it has been running stably ever
>> since.
>=20
> I'm wondering whether we should have a selftest that triggers this exact s=
cenario:
>=20
> (a) Populate page table(s)
> (b) MADV_DONTNEED to reclaim the page table(s)
> (c) Allocate plenty of pages for another purpose (draining PCP where the p=
age
>    table likely ended up) and fill them with some data that looks like pre=
sent page
>    table entries.
> (d) Re-access the reclaimed VA space, expecting re-population of anonymous=

>    pages.
>=20

If you want a better chance of hitting this bug, you could try:

- First DONTNEED the range in multiple calls so none of them reclaim the tab=
le.

- Then PREFETCH the range (or use your favorite speculative read gadget or e=
ven do a real read and ignore the signal).  Maybe also do this from multiple=
 CPUs.

- Trigger reclaim

Then do c and d.

The result might be so specialized that it would be of dubious value.

> I can find someone to work on that.
>=20
> Any other ideas what we could check? We could certainly also check that th=
e page table
> was actually reclaimed during MADV_DONTNEED.
>=20
> --
> Cheers,
>=20
> David
