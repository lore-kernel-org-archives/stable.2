Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839451;
	b=iOQelF0yztoEPznKfRWio5OUhV5PYQfYtgXiuF78McuUbg4Esct46+B6IWtuILj1JfO1
	 W6BKjvOCRRQpYtqqWbgVvNETP6KgTVVSOaWSV8JIlcTuFr29OH+1m50t9rSFVHw0ejwmm
	 DZnfT6crr4If4+AmQJgHlyPxfHCKt1Pb+PplWOTD9/b9epVSW4nWnP1NjWH6miPFe1yFQ
	 GYnyOB2lpPx3gAcfSUBdzXL+lmVbR+4x7emsV8Yyp0Jk40VLQh3li9PzNJHucIzOtiV8f
	 cjzCb0GgpGhCii8AbCcIFwdFDKZ2ESkp3Q7+lgO4zwjyjLDpZTncm4r4Phgru1FWixQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
	b=XxQf94uwnL/GlvUP+aKl8OY+iiVJyKL+N+Wt6ywZnVepWU/bey+DCIBCm671qyJWtem1
	 HMNBxGgc6DoUpL5VF8QhsXcch+lF6vNKRFb4dDMAY4Yle7Pvb8Bwf45TreFohmhl1ZJIY
	 t3wiWTOdv3GLXJ3f0owrv2A6y8ZBwUeOcAhYw7MkUchTHqFwmoYqXtZ67VoqQW/KCGdCj
	 QxRvlc4YEVxH+0jLohh6o6jyfiaHOLnMeS0HqFcM2XI6Y3RSqksprhFKMZsZm7/ZL31du
	 O41KkQVIAqqnvzjiK0pbdTTSAR7xXUf5JZjzDWMYivWme9oV4QhIsdH9v+7LxC1LaeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtsSnhaK;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89B606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A89B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtsSnhaK
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1024077a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839451; x=1793444251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
        b=PtsSnhaKNy7zuuC1jzn5M8tSZnUWzQVOimqzvd/oMTLGQ0JIftq7HcenKp+pm7zvEf
         RMXi1g57G651zbesgra8s4jIX+5Q6SDoDbsK0DNpBpy6/Cmy8h49FYNdCUE0Zh0/MH4V
         9937ftGKKkWfkvrn2Un2WASg7brppYjTzKVLS4epPjE1Ga+inRucDAiQ98mJw2fywDLr
         pSosMxGI7aObzbmIQXB8GRPAlAeYcY8Kvl3uxw6mjP+lpEKoTDabsRqigw2mYB5JmgZI
         /TrDsJppi5FOTFKQ4HwXSsuyGGmQEQqB7ziOJcdCYwji1ster20u4rDCWKptAcxecr7S
         8iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839451; x=1793444251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNICyH1Z4rTOKjpfX5U5n8hb8jDB9RXey0UpM4q24ek=;
        b=15W0lXjNwhXbokan8VBLOtg/q4169VTx+T3n+1Q5MugwikfV9SegG3DPzNXcTsPNGO
         fw/Q3vWazrpEwa6ZbQUt2P2W51R4MMyQwxse+vNFbi87NMbRCEAI6Q77Y2jqZtBUM3Rx
         YOTyZiQOatBZrNkcmD7rhCeSS1ZrjTRHjG6RN0tjlhhMeVKkOY+htBIAfb8YKmhYEUWt
         Dl1XH3YQsTM8b+Vrkq2YYSnisKBj6R8X/Z5spZwRk0rsjFfkhCXyXSByIpgiDx+qHYHo
         SDwoUIPZZII7nUD1e2KH9vVwpTb0NIiz/hhA5ikVqS/wekHiw0sm77Af/5NPKycOALA/
         GOew==
X-Gm-Message-State: AFq9FYJmESalt1xiDSWiQYPKTbODQZfWoiJv6RxGf+Oj40+5IzsDdVFR
	11+fo8L+zgOzjFRBl+nHu6WGr/iQKdJ9F1n+GjbCgYxsbBCkdmtD1B/R2kqNbXWW
X-Gm-Gg: AYBFou2XBSPTkSNQNBQMNuo6lnslPaKDWF2KsH3uLmA+tSezSQZG0kTiQ6I7P1A+6PP
	Ooy0AnZVAq4j9mcZjSfSNIk8uxzokvFl2lTsZk5hpmzdoBPw7tN1Fx1H1by4SFvDkLzcuqZo9aj
	2qfiyLqjrYht9FuvujXGNTTX7MkK9IF3HvVlJD1YDNp4lnKUufo84BuvZCePM1TzLbvNuC7z+9K
	C12Iqw1kfGKgrwG0yQxfnu/mamh2w5k3Ojag0zPhicEcLb+gDM0QoE5OYKQZpiuZt52zm/OoVs0
	Q0hEwI736GD9YWpHlX5AFWnGFkUTIBhSUg91woSSc37v/0+6YmvHjUJLHWnyCvlxnq0yYXL7f1n
	fo3gmKPL/sreWtlbhAog6FTV1w6k342kYu8TtIszzJN4yFHbqB3Xzi0w82xF3/LSP6s/1FaBxmP
	WfNGiyBQwDZscEZuEXoX/zc6TJtkGr1O2R9WtCtqc8URRRdDBEQpH11sOk08Bg5IwdAtAmtyZwS
	WDprcwwNbLUBodIVBs/dt5Lpvx0TAFDlIruKyrYuXCUpShtXY6gBGAMBUq3CVva6DA9sf1h2eoC
	zjIfyEcIy3HUtqYV1lScOPH+UC2KoVmh5ZUW2gr3kMz8QVlErqqwXj9nhBgM/9z2dMbWOdwH2iJ
	xsK9yNsbt5Dbxy1V4dIyU5gMA5WMcRrCbDzd9AOcNBSJLG3daudWJyUkdcTe10Q4BNv6Va8U8jO
	tkIjGb7c01UvP8xmZQghU/Ax9OBNnNCdkiwVVd0FmMK0UpeGG8d87tGjrA
X-Received: by 2002:a17:90b:2e03:b0:3ac:928a:68ce with SMTP id 98e67ed59e1d1-3adeb64b96cmr940283a91.33.1792839450816;
        Sat, 24 Oct 2026 03:57:30 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:30 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.18.y 3/3] ACPI: scan: Do not combine resources that overlap completely
Date: Sat, 24 Oct 2026 18:57:10 +0800
Message-ID: <20261024105710.593-4-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-1-ue081723@gmail.com>
References: <2026102308-twisting-bazooka-12b5@gregkh>
 <20261024105710.593-1-ue081723@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 7617cc05df28dcae967cca109de74084321eaa62 ]

Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
with resource overlaps") attempted to avoid platform device registration
errors due to overlaps of resources of the same type returned by the
same _CRS object in the ACPI tables.  It did that by combining two or
more overlapping resources into one, but it went too far and also
caused resources that overlap completely to be combined which broke
the arm-cmn driver that expects two MMIO resources to be present for
each device it binds to and it expects those two resources to overlap
completely.

Address this issue by adding checks for completely overlapping
resources to acpi_platform_adjust_resources() and add a comment
explaining what is done there.

Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://patch.msgid.link/12955564.O9o76ZdvQC@rafael.j.wysocki
[ Ting-Han: __resource_contains_unbound() was added by edfaa81d5da5
  ("resource: Add __resource_contains_unbound() for internal contains
  checks"), which is not in 6.18.y, so use resource_contains() instead.
  The two only differ in the IORESOURCE_UNSET check, and the resources
  returned by acpi_dev_get_resources() never have IORESOURCE_UNSET set:
  it is only set together with IORESOURCE_DISABLED, and disabled
  resources are not added to the list. ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/acpi/acpi_platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index abdd8893e..29b197440 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
 	for (i = 0; i < count; ) {
 		struct resource *res = &resources[i];
 
-		if (resource_type(new_res) != resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that would
+		 * cause resource insertion to fail down the road.
+		 */
+		if (resource_contains(res, new_res) ||
+		    resource_contains(new_res, res) ||
+		    resource_type(new_res) != resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;
-- 
2.53.0

