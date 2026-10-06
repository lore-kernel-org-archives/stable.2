Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78434A791
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262323; cv=none; b=tAq8eyvjiceVaRfkPkfr3v+JvH15nSqzOOWkfMlA/2W/7Ix7G/0HXFkKibu13mk1ufhAeQ46pz7z0LU6pvKpTEZpu4adPEtBLlQY3Orhk6Arg8LxCuoMMDdQxFca3cbbbA3jLIxr8HN2v6/uZ9Q71wOX5ZY1jPhppjiSku4l2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262323; c=relaxed/simple;
	bh=tNa2lptrWw3cyveg0myvYrhG1Z8itS2A43/mqGtb36Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTTYOTbPgoRlR3V//gR7NzePk2kKKqu3aIsxbk6LAz3+FL88s7jHwtIdpJwK69wIIbT8HdGSm5qWSaNDjnfXHrWYGczaAt6yl2fZSOEzolhaC7HbVMztN51qOfMDlPUw8Jqjo943eXYxJexIGhcNf0jXOEVHxUXLRJg8a1gmtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmRuDczq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmRuDczq"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-34ceab2900eso155233eec.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262321; x=1791867121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26jPmwk/kB3l2dhl5l0yo+wFBC7eHrahpCgj50b3t24=;
        b=KmRuDczqkpXYzb6l7VRv32J+WGiKJJTWkJ1MhhF39XNdHeyrIL5zTNVzdKxzrMbrU0
         a57Bnphl8Sjy5i7FoFPATyP32NIHbQ2Lgf3hRKtXmOk+4IDTbsSsxQE4AM4mF4CT7qB9
         aQVwGdDRWZn08aPSho2xog/rf+rDlS9Tdy8L9yGoR1AO5xZB4T6idhiF/Uv99rk+7FiV
         7V5Shc5/2bVvF4Ppwjp91FR/xZvkEgPpy+YscCZLFgO+/AHJdKR//+QEmUh/5tHZx3fU
         FL+TDqMQA2heX+5tXrwkkVQvPb0RgDlfH1PVF97WQAO7yxKE58TZNFwz/Hy8FmgwGfyE
         ycFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262321; x=1791867121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26jPmwk/kB3l2dhl5l0yo+wFBC7eHrahpCgj50b3t24=;
        b=KzvTlGo0GDoFMXiFOJP+wkpPrjUcv5l/xTExqHe8+KI7HElj7WtUNYxJw+6fFyBoVr
         /l2Ofy3IH4Y//GdbvRKd/XYm8AriWl5PfV6H2FjdohGbqqRyNXUgKTqZfafSB1L7JQ8a
         5EhmtisNuHC+R6im7a2zDLyR78dLsP1q/dXeJhTCOx5kQJ6nW1oVwb6nqJ4DmEe76Ptb
         TdnjWSQErJlqIYuVV7gL0NBZgRSk5iVZBBgG54koqjsx0SJ68bz4KTleq+k8jB4FvE7g
         o1496OD9W017fpPNtSZhdmeEyq2sKwYxsIw25ep84TdeT6noirr1e80cl6kIax8wBRbB
         Z/Yw==
X-Forwarded-Encrypted: i=1; AKwUvBwwEQy/AbaD8Aslj6rx3e1FP/SOxR0f8GnfvF0vwGWWdRkvwbbrDEujKOQG462ZsjBYOKMdwe4=@vger.kernel.org
X-Gm-Message-State: AFuF++l3OUatS9eSaBYXXKwbYck4PKgiYJ6XTAuNFzgRL8w9zuWpBNf7
	8TSwGW7N3GWA+hPyrHZFE6xF8NyARHwg3AAb5X+S9kivzchisbPsi7xZ
X-Gm-Gg: AYBFou1j4B3fI92x5nucXn+I3bGUTURyEl/342drnFxYs8eCxg9KDnJgVDe7QsS3mKI
	oXPHOsU9mwFqf7ZubK2BXqGqLNZ3RpgtPTT5J5hS1KDhDoDcDyXwePUwxsmG5faYC+xciR1jCoW
	86wOtJPE+RH+6X4HTNZlYb+Z6WKlmAkkkvaWPzgJ/xgcDjhHx41+SIjIVq1eYt7RXsm0jdKyDOx
	yXQTpjwKJcXZQ8f7GIE4xRrFtpl7QY0gTk2y0oWDGDDNg6h0fxGLJIpO+gA6fatZm8yzNfO1T9p
	/FdNN720lVsJOW+HJPFVfIl6du8l15oTJmnYYILdq/JJUXeK/RhK78zU1HNBz+KCpcleoqI5J6h
	kfAK7MK9Aj8x6rD/ieL0tSBXOiXYr0rglkI5ASviSKLwbp3MVqd+8YYlcBGFLiN04olyXYi8soY
	tUwancX7RqVjCxivxVUU3tf2wgT0no/XAppF803JHUb9so22N10IooO+xSAiiPM9KViYQN+vKB8
	WMKgwoblBRNhaYhRC59NEX55RpdgXbePG9wb6kAe6ZJr17t5HErwdp1sDX1loqQPYg=
X-Received: by 2002:a05:7300:a98e:b0:351:4648:3611 with SMTP id 5a478bee46e88-3514e334d5emr262924eec.26.1791262320917;
        Mon, 05 Oct 2026 21:52:00 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:de2d:6e5b:74df:ad41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm3550227c88.10.2026.10.05.21.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 21:52:00 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:21:56 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: Ciro Pedrini <ciro.pedrini@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal
 profile support
Message-ID: <asR-FLwLfpyT8uOz@archlinux>
References: <20260925205226.883724-1-ciro.pedrini@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20260925205226.883724-1-ciro.pedrini@gmail.com>

On Fri, Sep 25, 2026 at 05:52:26PM -0300, Ciro Pedrini wrote:
>The HP OMEN 17-ck1xxx (board 8A17) isn't in omen_thermal_profile_boards,
>so hp-wmi uses the generic thermal profile query. The firmware only
>stores that value and never acts on it, so the EC stays in its default
>mode and the CPU is held at 45 W whatever profile is selected.
>
>The board uses the OMEN interface (mode byte at EC 0x95, thermal policy
>v1) and also needs the timed profile quirk: without it, the EC drops
>back to the default mode about two minutes after each profile change.
>
>Add 8A17 to omen_thermal_profile_boards and
>omen_timed_thermal_profile_boards.
>
>With this, all three profiles work and sustained package power under
>load goes from 45 W to 56-79 W.

Hi Ciro Pedrini,

I was working a patch[1] involving omen_timed_thermal_profile_boards[]
and needed some diagostic info. Would you mind attaching the acpidump
for your board 8A17?

Thanks!

[1]: https://lore.kernel.org/platform-driver-x86/asPy5Q5wNYaMzTqJ@archlinux/#m922ff6cf9a68285d2b0f64e578fd6d2d6fa573f4

>Cc: stable@vger.kernel.org
>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
>---
>
>Notes:
>    Tested on 7.2.7, whose OMEN profile code matches for-next. Without the
>    timed quirk, EC 0x63 counts down from about 120 after each profile
>    write, and at zero the EC resets 0x95 to 0x30.
>
>    8A13, 8A14, 8A16 and 8A18 appear in the same DSDT. 8A18 is in the OMEN
>    list but not the timed one, so it may have the same two-minute
>    fallback. I can't test it.
>
>    I used an AI assistant (Claude) for the ACPI analysis and to draft this
>    message. I tested the change on my machine and reviewed everything.
>
> drivers/platform/x86/hp/hp-wmi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>index 7ab81ce5f..76f489d5d 100644
>--- a/drivers/platform/x86/hp/hp-wmi.c
>+++ b/drivers/platform/x86/hp/hp-wmi.c
>@@ -207,7 +207,7 @@ static const char * const omen_thermal_profile_boards[] = {
> 	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
> 	"88F7", "88FD", "88FE", "88FF",
> 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
>-	"8A15", "8A18", "8A42", "8A43",
>+	"8A15", "8A17", "8A18", "8A42", "8A43",
> 	"8BAD",
> 	"8E41",
> };
>@@ -226,7 +226,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
>  * "balanced" when reaching zero.
>  */
> static const char * const omen_timed_thermal_profile_boards[] = {
>-	"8A15", "8A42",
>+	"8A15", "8A17", "8A42",
> 	"8BAD",
> };
>
>
>base-commit: f475845eaf3d749114a63270bf2efea459e14dd2
>-- 
>2.55.0
>
