Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854013EDE7C
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822104; cv=pass; b=q/N3xI3T0sc7+ulo6DH7Lfmpc0YSgpUyi6bWn1TvxEZF3HxQ7CT27BSbWMMz0ezmMIjyXBodKgMAFfZcpOKv1rS6/egMOq5KNDn75oKBLBXeoij+xfdI87Q3FIEShdoClRhV9bXOgKMPZxZ73mYsZT8YJyAQnEgRcAwg8K0igRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822104; c=relaxed/simple;
	bh=rc9GeNxYacpB0CYdtKD5SwN4Gkn3z306jaLlyKihy/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZjnmVZ4k/IVH+wRQYJ4wJogLuxFuYIyrRoV4zPolZsSWh69KOQ+4ryzDF07seaI0UBsZAR+kYfAGq5qSvCLX2Wiy50mt5Lk7GLYVykLpKMpyPvV+/J98FDzug9nvoKBhjhXN1mUcFQXseR/4Nt79KUej8r+f+slmVrfM95ZLk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArA/7I1e; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArA/7I1e"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso2874562e0c.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785822100; cv=none;
        d=google.com; s=arc-20260327;
        b=lftROPNPsApceRiWaie7aJ47J5t/A6bVESZ5ywnSrePUqC23N5bcOKoYBYZ3sNgatF
         AUmxNJheYIECGZL3PKDjhBsBwyNTJgintIUrFpZw7zJ0OafzBjP8JPqlb7kHjCjJkxmD
         AjpIY3/RoETczR6vPl4oOhYZqLohaxHNbwYolgdiHXUD9LupOg6XKg4gOnGOO8oCwWdn
         2w9fuLtdOEyia8DRdSvbrbAvv2THj2mkbtHRJz/cn3/8kArCGS6sUwvDSRtwaY8rzSlo
         68QDN2Mv1+qt4JXD5x4pWPJaxxMJ9aFjlQL6K8laaIKPJlSyi9tnlg+yPhC8ZM13W0Yr
         Ymhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        fh=Xq+yPWobIq7aHFO42cTV5ea4b9k8sx20VYX5o6UhKwM=;
        b=obAV7CUtnLoPRHqonxSPQw1pU0c9owYUGFHPeZ/RzS80v7AsJJ3YJFYfcv71HGrsmr
         lejafyw6Ll4ATEWSo8lSXzbIdXn9CsL0AC4bgIUR9ElRNIRFOFlr9DzOyXwlUdOolird
         yAoFmg4HaA0ObXZzDRp0TnXiSYfxYKSkh7OXjCvl1FipRB3FhvtC4ShSI85uGAoji8xl
         UOVs6ahjcFsEkZ6Ds9Zy6X3LcFLZx24pnw7E29u7kh5k20BOGzqAqGEeBC932gxtHHl6
         0o2nB8edQhAGhnsZGU7SmXe/4U4JFjpfEDK929oQ26jpTvVP/C1iCULrpGvYvSpW37Pf
         e47A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822100; x=1786426900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        b=ArA/7I1epmEq1FcuR0jPbRr+NDW4ixF65EgSLV+Q55l2e4pgWImltE6JVVzTwwdbFK
         SdOH44qoNMMbRwhtRKjJBhhzVpNlDCejhxpggxElI09K9pQsEF7VieRBRpKc1/0vrgGL
         zJPxm71lgp1sKJiwB/sgtppoQaDvmnPLuv3IRU/aJFZo1AYWGWdL882H4KpXju2paxTG
         GNvjz20DmOGy7s1dXQQceJ5NyRYIKW+euAkFvvrr3xUlXUCeyktSQ+TNqvTpl1I5p8vL
         kSa15CkulS/Kk3hD/khk52wgSjEaisyEmgfOI4XxRpxSQ8yVgh+KzPFPRWHbRFsYwsTA
         DQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822100; x=1786426900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        b=Yj/lLFS/UuvzMUJG/F9WCZg8HX/X84yihSKO3A2INiqnxfZgBFI6CZFWj9ut0/FkVH
         td3WfQGvP0cBWp4f1Nvz57LXiagid573vfalDNA+wF0BkyQsH2K1LsuZwAFMcVm6W/7a
         GgaioTb7sL8wySFDO8OynUbBY3SmnHp2R0SrUXUbadH0DkrU0S/jCRG//WGqEWYw65wQ
         2us7TMboVxQFmjVOUZ2SzHCJp29PD6JXEWBTtD6ngpu5IHwt+2HrUO/G7hCMWDL4urGI
         7zaF91xDger0GtMIZU/h74XYjUDKryxzFj93UBlFYJSrdVfBTKwObHT+Ucgz/VQ601Sv
         DT8w==
X-Forwarded-Encrypted: i=1; AHgh+RrfujA4XrpuxITU2SoM6f9jVQei6In8AQ07p1QZd8rrmUYUy8E/PtWT6aCIXjntZ/QBP2U7O8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6gbUsyRhy5dcCeijoDGHQbOmTqyO3HBZpEwIkxzgeoI/wHIr
	sDrdQWKoko49jmPoIiRy0xfuHhSUNd5JrtsB6yW+so4cg9atnBHsfirDdI4bJjbZtz6tAwlt54n
	dD9Acsjf88hW9l0/5n/3tZZP/mwKsdg==
X-Gm-Gg: AR+sD11z6IqrpTNqwcAs9Xo5dNd3chnS3PD2P0Qn6g11dZXEeqhK7vRjH9FTFJwi2mR
	dSKFo3GS71icuSVwSVZA46Fmo5HdaeuC4tjGmAA9SK3klNPN615WbqT0T9B2OsXUAkc1tXWvRN5
	r0LyQqvWhrKQjnkfAv1SJOvd+vuNMOBSXMl10qI1p60GpypITGSzdD6WyXBKU1g5rl3JlJK9VTM
	c/X2Wby2FcFuOPxJd1dfcRSAZJ1yql3XIc1HEQLcpLvIO+kE/oaoepP5qrYHpL/OxrJBkDDbAoY
	kWFZEdcBUkTHC2F5ZJfgjkG6SkXS6qsYEgJiWgi9Hbyj13D9ELpJm/o0wjNOxNKt+YDKTQlSBOf
	U44HIsgZm8KA=
X-Received: by 2002:a05:6123:161:b0:59b:396b:cea7 with SMTP id
 71dfb90a1353d-5c3877df378mr4440525e0c.9.1785822100407; Mon, 03 Aug 2026
 22:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709131904.596684-3-adhikari.resume@gmail.com> <20260721164027.637078-1-adhikari.resume@gmail.com>
In-Reply-To: <20260721164027.637078-1-adhikari.resume@gmail.com>
From: Ramesh Adhikari <adhikari.resume@gmail.com>
Date: Tue, 4 Aug 2026 11:11:29 +0530
X-Gm-Features: AUfX_mwfI0PujMCVMpuXqdjToL4iEJ74LCkACizhvZz_t7EWwXIGY2aXg00R9eA
Message-ID: <CAC-THR8O=g=566evNCA-fmiprLaCL2f15w3dEjz8MSgAG4cMRw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
To: colyli@fygo.io
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens, Coly,

Gentle ping on this series. Patch 1/2 has Coly's Reviewed-by, and
both patches address:

- an RCU stall / kernel hang reachable via the nvdimm ioctl path
  (badblocks_check() looping with a non-advancing cursor)
- a 32-bit (arm/i386) build break from 64-bit division helpers,
  reported by the kernel test robot

Both are tagged Fixes: and Cc: stable, so happy to resend or rebase
if anything's needed on my end  just let me know.

Thanks,
Ramesh

On Tue, Jul 21, 2026 at 10:11=E2=80=AFPM Ramesh Adhikari
<adhikari.resume@gmail.com> wrote:
>
> Two related fixes to block/badblocks.c:
>
> Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
> modify their argument in place, they return the rounded value, and the
> callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
> discarding that return value. Depending on caller alignment this could
> leave sectors unrounded or, in the reported case, stall the CPU with a
> non-advancing cursor when reached via the nvdimm ioctl path. It also
> fixes a 32-bit build breakage reported by kernel test robot, since the
> old rounddown()/roundup() macros pull in 64-bit division helpers not
> linked on 32-bit builds. Unchanged since v6.
>
> Patch 2/2 hardens the same three functions against the input-range and
> shift edge cases the round_up/round_down fix exposed: s + sectors
> overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
> per Coly's review of v6 =E2=80=94 see the changelog in that patch for det=
ails.
> The remaining open item, bounding bb->shift where it's populated from
> the on-disk MD superblock in drivers/md/md.c, is being sent separately
> since it's a different file and a different root cause (missing input
> validation, not a rounding bug).
>
> Ramesh Adhikari (2):
>   badblocks: fix in-place round_up/round_down usage bug
>   badblocks: validate sector range and shift before rounding
>
>  block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
>  include/linux/badblocks.h |  6 +++++-
>  2 files changed, 38 insertions(+), 8 deletions(-)
>
> --
> 2.43.0
>
