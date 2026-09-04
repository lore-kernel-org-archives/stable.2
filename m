Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE54A2621
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529659; cv=none; b=AKcpk0HTlLbIgWcXi9VwEKqr3mWcm390utT3/mjfX9WvJZYeqYECkvVnb6N5jhzeWznbejhTa0UmU+ZyciWJ8YtYETJsL9kf30u+Om65UOdStY1omEzujuTqNoO+wDmFHZyV4OSgdHljXF6+SGDQ7J4GSk+cgXLZ+gbs/6Q6XpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529659; c=relaxed/simple;
	bh=aNqgWwe6w7iIetL2wRN+5CkMwLkyN9UcPyvXc+6jOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGlZg/LqW6CeI5/gQQcEoKuAT/5qk7OAXTbOgzsoLWu/GyQ2NyEA6TIEFK/Gs3HR4XRRJyGYlK2qo5Z2VyEU4QugwkfTUY0/xscm5An4+R2gaB0TRI2s6U+1Y3w67AlGnhpjwdqjIAm9sJcH+Vtz0uaydXI6kF52/GrddhSF4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmjJ8ozs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gevfXS1D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmjJ8ozs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gevfXS1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCMi+6BZZMHptPD1vvY/JYA6n56u3aMMfK68ZTPqfUU=;
	b=XmjJ8ozs/iRJIdP4rrEhgkNCf4ff3FPNML/zuHqLQ0A0alp8NNphNJJprDJXawrv+ZH69d
	11vYEbgAeV3H4JbSE78ROm7NJ+IRQyaG+24RC2+6AF7a1ELb/5dLr9MSJg/DF+cER6mHaU
	EZL8c5DXxFVrnoX6aPnJKZsR0UFjwVs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Gyvb5QzZP6qZSy1O8ki7Vg-1; Fri, 04 Sep 2026 09:47:35 -0400
X-MC-Unique: Gyvb5QzZP6qZSy1O8ki7Vg-1
X-Mimecast-MFC-AGG-ID: Gyvb5QzZP6qZSy1O8ki7Vg_1788529654
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c255e9a2282so84206466b.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788529654; x=1789134454; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCMi+6BZZMHptPD1vvY/JYA6n56u3aMMfK68ZTPqfUU=;
        b=gevfXS1Dce1QGCJ/8bT++FltyXRhqRKWGjJiTZWDyNguI9xfTMeMwf4nzsN5kvKxI2
         LuQMfNqSkOgHK4HhqFLHv3K8AWG8Cwk8Ei/WNoSQzdXH6T8kunAYt7XRfWMKf/zYTAd+
         2wOzp7yMoy4ojpOumrnMVbOj+gnfprwlqI887HefZoY2GtHkCiLWHdyES01y6LFay6WQ
         pCRc4nR+MBT2AoER4cvtriKUJcglH5FGIwVFeY8CubiFEFf4r2eHrhh8PC2oN+5SeAi4
         jH9SDbs28xpHSWxb41gTQNi1l8XeuQCGSFNA4y/O2TmgsjzRKXJwBQhUDl/BG6MaB3YT
         7qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529654; x=1789134454;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCMi+6BZZMHptPD1vvY/JYA6n56u3aMMfK68ZTPqfUU=;
        b=iCxBkwuVbZoUnoQqCUiPGJ7xOxfH1MKHCUpHl8Ja5jLPTUjlNbfVckq/XO643V/xcU
         LCZBapmK3OLqgXrtGlVT3T/BrzVsp8K2L/GcMjWvPcpTdHib5MONGaH04eAThw2r3z0q
         kszr1b1PI3RRMzLfmc8HMTd5Gd6G78RkFvT2iOYkYpuhWNNlXIwT4WXUWm9qfrEBNvUe
         aO3Oihbn594vcgUkjAjagxYZ+dqQUW24k12g8wNTG6aPkFQZC6jYOYicUutvVAIZ+ErU
         IoO6JT9eg8cIam5ouZNeZIpweXoe6Sb7l35wih19THkPUX9Uyh69vMgKa0aX6TUE3nzn
         QVkQ==
X-Gm-Message-State: AFuF++kwGMmt7kbdgkjBy70qvFIaZlPlWFUSt6AEa705UTtW4nFiu7CL
	JeLZpip4VfP4ZiQDrogW0jv6NaRWQJeX5opL2c2XRNQHxDOEWLKOWmmEz2nenp0pGq2XLO+2Sgf
	fdx3g89tJB6ArYhO5dq0Llp5/oXRIzbKvQYVsY9CWQqRrRri2V6lZTPdKxA==
X-Gm-Gg: AYBFou0UTA6nw5dF+s2KLvsneueGmUQ6G4AW/aOkr1yTkflmPvTHfBgilIQQ7Jf2PXg
	aUn/hxMJfzQKGeRm32psuPHGrzVOOH+X0/dRXrF+H4yR74GEtBgVRHAE09/f86xzALeBKBJED7X
	vp8zkA1i4GUIzFVIA1ctuz59rYfGR2HCBiOLqADsoIg4hARamjQrupbMOZG5A3jgYnFbIWvSpeB
	xUatCE0TKgaaaEIW7y68X0edhSGoWkOMPQDU5GUG68JGfVOaw/B1arsmoJhOQbtk5z1SSoZtIsW
	1MofuBJJSkT4BZ8vCH27qv3QjSumLslSCTALPp3lmZdpxPSEgQ8K0ZNgAwwE6szkR87iynjMD9e
	zjYuPDWQfNCgq8D+idv+g6Ut8WzDPizNTuzDg6gAILqyfT9i7
X-Received: by 2002:a05:6402:90d:b0:6a6:757d:6311 with SMTP id 4fb4d7f45d1cf-6a7e8d5e9dbmr3436152a12.9.1788529653739;
        Fri, 04 Sep 2026 06:47:33 -0700 (PDT)
X-Received: by 2002:a05:6402:90d:b0:6a6:757d:6311 with SMTP id 4fb4d7f45d1cf-6a7e8d5e9dbmr3436110a12.9.1788529653224;
        Fri, 04 Sep 2026 06:47:33 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c1bee2sm1212418a12.29.2026.09.04.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:47:27 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 6.1.y 0/2] Backport
 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri, 04 Sep 2026 15:47:26 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <B100654C-7707-401F-9807-E0CF73E155AE@redhat.com>
In-Reply-To: <20260904094111.1816002-1-i.maximets@ovn.org>
References: <2026090350-galvanize-epidermal-77ae@gregkh>
 <20260904094111.1816002-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 4 Sep 2026, at 11:41, Ilya Maximets wrote:

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):
>   openvswitch: Fix CT limit teardown use-after-free
>
>  net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
>  net/openvswitch/conntrack.h |   6 +-
>  net/openvswitch/datapath.c  |  10 ++-
>  net/openvswitch/datapath.h  |  26 +++++---
>  net/openvswitch/vport.h     |   8 +++
>  5 files changed, 119 insertions(+), 53 deletions(-)
>
> -- 
> 2.55.0
The backport looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

