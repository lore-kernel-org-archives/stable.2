Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55382F0673
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122049; cv=none; b=QARAM9yA8gWEkTdHWQr4vdb37+w7RgqcgSqIT8g/hAgQZHSreUXYqRr7pK1vpgcLlIGDCsTwoJMtlRgr0J4DmdutgV6pyCBtoJpknNsExWDvn4yyu7mgJ3UuUfiXcA6vrBYWfRVaHxqFuuoFNWE5AYvLYikMTa/k0EXLudioolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122049; c=relaxed/simple;
	bh=J+IH0iBWUho0n59I4fFvUXGr07W2uQyqez732m0nLkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbADl07gQtM27cIbjrl0L5c5Mdq6eA800jXTKbgmKYy/je6Pqc2q4uQhskquw2aiBAtwVTYGIz/EPQokCD287D05UNjTQLQ3yCe06prnE+DYGO4Eex67z35WXlmkxM1nB8KOgm4XMXxkNURDC7s+odP45Pm4EMyLHsB5ZaDq8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QBAEF1C0; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QBAEF1C0"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451fd21113cso810956fac.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787122047; x=1787726847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qmx7PRjO8t3Kyi4PLheaoV8VPnsksfNJxeWi0FWrHIo=;
        b=QBAEF1C02y8RgR5++m4LnzVId3tdZuoNnukytGd1353+pQxlYYURb4JiEneGGe1X9w
         ZX+pM4+P3DmMGdnd/RLNtlVmJA8hFRR0/Z7c5InfTLsn4If9zZ6K3uAzaHm22KNwZfWW
         1NAaQqxt/iJJRRlPgQEJ/Oup1fcbLNfxzm4/IzalxN74Gz/XbvDwob6ZJ1a/w+k3cZpT
         wOW4uVepLHruXp+y/jOjI8qVhLPlkNEAaw0t75pzZhA4mheTH14Qd3HEzqP8iP4fgyTJ
         fbxmPeVF4JkJ8svR5a/fGk3jHqQsEx7q9RfSzfzOqabZyU8xjMZtBcMT/7Ex7QdQeesG
         IsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122047; x=1787726847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qmx7PRjO8t3Kyi4PLheaoV8VPnsksfNJxeWi0FWrHIo=;
        b=SxAMBQ5LZY6tnPV1Pm7tbdt90PfJ4gIU4V5nDnrUAM4rxHF2o/lJLnI9yBaLIyAcz2
         M9WdFvofHm3+7jaIXNuAkK6Kv56kPQuO2Q80TeiQJIeYPMOCEMGhQuoFgNbBc2ORibsr
         P1Y57Vjuf9JZFYpaLZDKcYVDiFTZRXZ7YGxWqs3lfjYn66HPVlTiT5eU4GpLIw92V7Pp
         WSoduwIu5W+iga7orbb1AgElWYEHo4ekUmG3JRhfvdKFfd4zhkcbvNsvZ/bEJDBAuGx1
         U6vFX05EF5DpStI+0Aql4hPVPdxUTppYIdAbbFGFlH//R5qpH6F04CdD+qke06g8JEsw
         aq2w==
X-Forwarded-Encrypted: i=1; AHgh+RodiIB0toZCA37N5m+RQ6wVmnBj51JF9TbFqXTk8pG0EkIzd+ZTSniz7pesd/X/S+Tj/LWzP0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPQZWHkj3UPjhg7t+jLrWv0qbrWdzLyDiTVmxMRuhEaOvHlc4
	BuOqHp2UjWKEtvI1p0T4WjM4KJjI9ZO34m4d647YPrf3hZoMFFtWmL5XFFs3unbbQnA=
X-Gm-Gg: AR+sD11ueAxXCNoaKS5zVLL7qlSseLTSPMZL84Pkntg3VfmioMg5CRjzXnEpcVTWQgF
	AXauDzpx+UVAMhjfmu8LOz7iZwtYDqhI1JlFOmF/ZrNBb1gru4eaKmFFR57JhlQUQ8ioG1iDoYk
	UZb9ohq+qwGu89szgmgl/69LVutvqMl4eu/FFpunsUN4aYc8uF7VHjXykkAL3eLIpTM5GYe7jqf
	lxk57PL1tXFl9kJ9ywJTCZX47O6S3Z+CUTpXUaE/1UXn66pesPKZ5FIDUbI2QXzD6dPgD08WFPj
	RHwIAWIy1E4p0uS9XXjtF74dso5IRVOq0XpWYSLV1QEBWRzIOVqEAohAEoXBIsG3nm9D10TceL+
	FVstvqwoCTCccofUp0ADuroPqOqzHPmLQFKhGEMndXkIbfMxDm3or8F3UZh5teg98aAzzVKz7pj
	qsdOHAfHYTM7O3b2mEF5a47jTab34ewr+fzuA7KG3qoKaQA4BTtpnUESPnWO4LRxhBowV5pgv2z
	pI0CcsVl7kmbhc=
X-Received: by 2002:a05:6870:d405:b0:44c:5514:80ae with SMTP id 586e51a60fabf-462f66fbe27mr2314998fac.3.1787122046507;
        Tue, 18 Aug 2026 23:47:26 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-462fb003c0fsm612872fac.16.2026.08.18.23.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:47:25 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: bp@alien8.de
Cc: Smita.KoralahalliChannabasappa@amd.com,
	dave.hansen@linux.intel.com,
	dgiani@purestorage.com,
	hpa@zytor.com,
	jrangi@purestorage.com,
	linux-edac@vger.kernel.org,
	mingo@redhat.com,
	msaggi@purestorage.com,
	rhan@purestorage.com,
	rjethwani@purestorage.com,
	stable@vger.kernel.org,
	tglx@kernel.org,
	tony.luck@intel.com,
	x86@kernel.org,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Wed, 19 Aug 2026 00:46:00 -0600
Message-ID: <20260819064601.1972932-1-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818190250.GAaoSsWiKOuj4gRYsl@fat_crate.local>
References: <20260818190250.GAaoSsWiKOuj4gRYsl@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm ok with the queued patch because it still fixes an important bug
(disabling interrupts on storm end is not correct). The rest of this
reply is talking about the concern that storms are not handled
properly in the AMD driver. I can make that a new patch thread if we
agree to make the behavior more Intel like.

On Tue, Aug 18, 2026 at 12:03 PM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Aug 17, 2026 at 12:51:08PM -0600, Jasjeet Rangi wrote:
> > Inverting `on` in mce_amd_handle_storm() alone is not enough because
> > clear_bank() will immediately and unconditionally enable the interrupt
> > again.
>
> And?
>
> What would happen then?
>
> Did you read my previous reply?

On AMD a machine_check_poll() call will not necessarily set ErrCnt to 0.
In fact, it will not reset ErrCnt at all unless the overflow bit is
set. And the overflow bit gets set when it's time to generate an
interrupt. (Yazen and Smita please correct me if I'm wrong)

The threshold is not always high on AMD either. Since eeb3f76d73ba
(x86/mce: Save and use APEI corrected threshold limit)
it gets the value from the BIOS. The default on an AMD system I was
using was only 10. So ErrCnt will get reset to 4085 on that system
when the overflow bit is set. That is enough to not meaningfully
reduce the interrupt rate during an interrupt storm.

Unlike Intel, the AMD driver doesn't set the threshold to an extremely
large value when storm mode is turned on. It keeps it set to the same
configured value (default from BIOS).

So if interrupts are left enabled during storm mode like they would be
even with the queued patch, the AMD driver doesn't really reduce the
interrupt rate during a storm like the Intel driver does.

If we don't want to diverge from Intel, then the correct thing to do is
to update the AMD driver to do what the Intel driver does. I.e. don't
disable interrupts, but set the threshold_limit to a large value like
THRESHOLD_MAX during storm on, and restore it to what it was before upon
storm off.

> Yeah, we don't protect users from themselves, you know :)

I don't think having threshold=1 on AMD is too crazy. On the Intel
driver for example it defaults to 1 if not overridden by the BIOS.
```
/* Linux non-storm CMCI threshold (may be overridden by BIOS) */
#define CMCI_THRESHOLD		1
```

> We do clear MCi_MISC[ErrCnt] to 0 so that's the "highest' value we can do
> before we raise an interrupt there :)
And on AMD it does not get set to 0 after an interrupt. It gets set to
THRESHOLD_MAX - threshold_limit. So if your limit is 10, the ErrCnt will
get reset to 4085. This is the behavior since eeb3f76d73ba
(x86/mce: Save and use APEI corrected threshold limit). Prior to that
ErrCnt would get reset to 0 by default on AMD.

Thanks,
Jasjeet
