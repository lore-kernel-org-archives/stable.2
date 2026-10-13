Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCD5187D1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897299; cv=none; b=ZPQHGrIAZHg95jlGHgWILegDDOn96BIb/o0o/ecIuN2yDGIBNTyAKxVvE8TaTNor38mMH/qSi34TQhQNzig8QlRZ+muqy2a1XAYOJDlcMNoFV2DLZ+MBBrbiWPPbaknjeG1+L/aVGIUsZLYylQa95igsEV9pg3NVxK9EN5sKFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897299; c=relaxed/simple;
	bh=0fV3ANaLM6I/JweRjyqGgPdr/O3IoIHM7sDBOsZsjFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKb40sk6wKyl+n9O8ale905du/wzEOdkDAVSteV7PU1REkDemZG/FEz8WvBGDiAbrWM8mL/cRiweTXpbILooHkZAoHxcRy1GVubQAmNROzORfoM6q6o5xamZl4Xi74OjIYfY1cFeOA2zWegZsTAd5xRPYXDsHoBvG4VLjfw2jDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooDT349h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooDT349h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3641F0089A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897298;
	bh=TyGH6GdHih1QQ8QFEiJNBr1trBQdTr947Zk5c3LahUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ooDT349hExUcHsGFec+u0PeSnsNZZXt2KFtvc/LJC3jZE47c5q1wFDALeEwlcguUc
	 T8S3jLCHxI1UjGYWNS3AUeZcNB8Dl1SMsD5FD+KBd9e/t0Q9vDYf9kWC+OOawerWYf
	 zWW8DeAnCUtfo7gn3ScHXlil9zXGimui+r5oo0CAae/yb/FOXnBUhLTFhp+TkH7RSM
	 DFtv1UpOLoa5TyiZwTaHBECY3n9wgcxG3xI318QCvtb2tVvpg4naRNHY7BYP9ubD52
	 95BZg8q3dfZdAm02l+DEgIC5gn8sAqyhQVnAIMSCA0aPmbmd8uyLqOnrC6GwzEbLO2
	 lXSx7OuAS9o2A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba357a1929so2554659e87.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:14:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxV8zQamOOGhbA7cIWewdwjeY7vAvNuHAJJSW18GiNJ/w03wleYqkSbyrsu5pZDojgPyNgdgPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXCQMxe78eNYeey0r3DP2YE2UBwiAwI65knJ2YDNHvoYVVAdcD
	YhYCnSN0l9scufxoBOiAs/EyfvdueIlb9LQy11bsXFTs654Qs9ucWmgopyy/uKdL5M3eeyj8qG0
	+/tygrgIyteauqdHvWkbDmwEBZYMgTQI=
X-Received: by 2002:a05:6512:3b0e:b0:5bc:b23c:f7f1 with SMTP id
 2adb3069b0e04-5bcde8d7662mr4490203e87.61.1791897296680; Tue, 13 Oct 2026
 06:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com> <20261013123055.46306-1-aliamemis@disroot.org>
In-Reply-To: <20261013123055.46306-1-aliamemis@disroot.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 15:12:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8G+H9kNbUEsjoBVMVQD3UcvpbxTVtZZM=CedS+EONsA@mail.gmail.com>
X-Gm-Features: AclHuK9hBROyGubJc7w6LulOME4sELoZkzJ6owxrsFXl9zDy-hFQLKHX4hitTlk
Message-ID: <CAJZ5v0j8G+H9kNbUEsjoBVMVQD3UcvpbxTVtZZM=CedS+EONsA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, johannes.goede@oss.qualcomm.com, 
	Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:31=E2=80=AFPM Ali Ahmet Memi=C5=9F <aliamemis@dis=
root.org> wrote:
>
> On Tue, Oct 13, 2026 at 01:58:15PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > An alternative might be to introduce an "exclusive" variant of
> > acpi_evaluate_object() with built-in locking and use it in the cases
> > that are known-problematic.
>
> An exclusive variant would have to be used on both sides here, for
> _BIX/_BST and for the INT3403 _TMP, since it is \GTST in _TMP that
> switches the page.  I can do that and test it the same way.

Sounds good.

> Should this patch still go in for the regression meanwhile?

No, it only addresses system resume while the same race may occur if
user space reads the thermal zone temperature during a battery
notification, for example.  All of that needs to be addressed.
