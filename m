Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFB3C09FF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629013; cv=none; b=T1wcd52clKhBKP5zabQiOOOmnLcoB6ze+zJKBJqruAulYXwPyCJsGZw3vQkgY44SfFVFhY0lgLhUxIK0NLdB7ip9OpXnmgPOxTk8QLlEIgQj0Tybgnlg8buj8LsmK7ut6OKIloXNTE+0gUwlFsxF1LDPYHBCq0j47M/T/zLbul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629013; c=relaxed/simple;
	bh=Hh90mVt6XcR3iqrqcDw0knKu1XwU2GWLwg4NQnXR5F0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lLEUuUGptIjLvmdQ7qtiKxlprhAsIH6C85VME4A14dCcgtDPpvY5s47dY6ElZQGjX78vdjMOc6hdsAR/Z5grtAek67jUBZxPzQZSJu4s5xc90zftWAsLzsGUJEUrm9wa8ddW2cSK5QOEUXPRjF0G/tA7otRl68t0a9AyYlGgh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpSoI2Of; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpSoI2Of"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4909b046dabso270577b6e.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783629008; x=1784233808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzslN++gvwF111Oxj75aJ3QDVnvg6D0q7xeFijnE/DM=;
        b=JpSoI2Of0uH/DQ2oFiL8Rc8Sk/60qO9R/psr4pVf0SqiO9y5CRJvh25xNwnieAftbi
         9CRNo5zfXvOzImFTVimsNDEnzMV2hrQL3Rrug5NtL88NKJU1WUqyirPa/U+ePJOj+xuT
         xxvbfxo4f5HZ4M0QfUJPVQ//CgyViOt7o6NKaEaj1dehPMjDEQrQ8hGubQVdugIy075H
         GJhNR5uI9IkS2J3wh5+cPjkD8WpwryAqnm4AXL35UPcK+lWwr96wPHxnyuIbsmv4mr+x
         TtrvTQCa+ud4RMg2Rb4G32jPIMYbJNdVWneiKNbA3LiAqnM9DBuRl7Lg2RdN78m8Amaq
         aJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629008; x=1784233808;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzslN++gvwF111Oxj75aJ3QDVnvg6D0q7xeFijnE/DM=;
        b=AhAWRayLYfF5RrNN0BYLyrifTEQgLGuKeim7ME5cHvsyI2Iv3+JqNlSVKckKqhgbQ0
         h8IN/KobCsRhdHZuj3LOCOhCcXp9itzFX9vI5GbMQCp7j9w2GFNd75FbgzRGlK7PJ/AO
         Vye6jakVdmL9o6xEtBlDi5I8IqzMtaNZj3wRS4mE1CZzVJfVa3hNfoiDvSpbsHUHtn7y
         5RXwlw3Vc3lyqwkLFRO4SLLjlfff5+VYde0mpyt9DwvsA/gLJ/myALWP2UWqZGQ4XFbn
         OERBaMtZ9obvdmc/am8SOG/QOKSWNhAFuB5RUL0eyGcXOOsB48RqfW1NSm+xC/7fZtwu
         0OVQ==
X-Gm-Message-State: AOJu0Yy5M5wGn4J11SmcaccImqFJ1+C5CPu9rhSA63XMmvVwRUI93KRB
	mw4O+3Rb2wtDkRc9DT+7sv64Gi17hTx+S1Jd+vxPZb3iJ+xu0tvRvACV0APu6mF4yUkWWINg3Yg
	2z7RNeftzn/aR6Uid4sAaWIE1mQ==
X-Received: from jaaf25.prod.google.com ([2002:a05:6638:c7d9:b0:5e9:4c3:fe2b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a1a:b0:495:f85b:d08f with SMTP id 5614622812f47-4a20241e89cmr7170981b6e.18.1783629008168;
 Thu, 09 Jul 2026 13:30:08 -0700 (PDT)
Date: Thu, 09 Jul 2026 20:30:07 +0000
In-Reply-To: <87y0fk5uyi.wl-maz@kernel.org> (message from Marc Zyngier on Thu,
 09 Jul 2026 11:16:37 +0100)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntjyr36h4g.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 6.6 v2 1/6] arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, oliver.upton@linux.dev, sashal@kernel.org, 
	gregkh@linuxfoundation.org, mizhang@google.com, catalin.marinas@arm.com, 
	will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, ahmed.genidi@arm.com, 
	leo.yan@arm.com, miguel.luis@oracle.com, dbrazdil@google.com, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Marc,

Marc Zyngier <maz@kernel.org> writes:

> On Wed, 08 Jul 2026 23:51:19 +0100,
> Colton Lewis <coltonlewis@google.com> wrote:

>> From: Marc Zyngier <maz@kernel.org>

>> [ Upstream commit cfc680bb04c54e61faa51a34d8383a0aa25b583f ]

>> ARMv9.5 has infroduced ID_AA64MMFR4_EL1 with a bunch of new features.
>> Add the corresponding layout.

>> This is extracted from the public ARM SysReg_xml_A_profile-2023-09
>> delivery, timestamped d55f5af8e09052abe92a02adf820deea2eaed717.

>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
>> Link: https://lore.kernel.org/r/20240122181344.258974-5-maz@kernel.org
>> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

> Please read Documentation/process/backporting.rst, and in particular
> the section indicating the requirement for your own SoB.

> None of these patches can be merged if this is missing.

That taught me a few tricks. Thanks. And I'll make sure to include my
SoB.

> 	M.

> --
> Jazz isn't dead. It just smells funny.
