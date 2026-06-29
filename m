Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD774416D0B
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782761182; cv=pass; b=XP6buIQukTnOmt2hyhuOOZdAg8lAAmkDGCUawk910kJIBq2/6kqepGOx3ykcwym1aWCjIyujFg3QrCeyxJgo7xzuudLnFxlzBtwYSyRop0ZUcg7jREH9UymbkcN3+zlNfYUmeuAMelor+AVIity4abHaslGXbwaZeHVe8edNe2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782761182; c=relaxed/simple;
	bh=hqeITJcmzESdb8H22X37VmV0f9rGwZrzNOxw/dDpThg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDgaUyBEJBUkVOxQsLltbjX/5JUGJ3c0IOONDPb4+OiTvRHCbUfFdnFZprV+XisB8Vs8kw8gtLr4yKeJqHr6EzOUwDXE/4Rf1iaT0ETHxdrNN3H2Y7WMV1rcwMhw8jG/1b0/kKHr/jICqjVcZCwwo8+dpH45rr4YxhHjEcBWimw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJhwnM+s; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJhwnM+s"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1679729f8f.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782761177; cv=none;
        d=google.com; s=arc-20260327;
        b=cg+GxwlgDXDqGDVb+/T3lPaaSnEwF1aHBuEdRqftNbhL2nNGV2YD/6Y+8UNsxxn3HP
         hQTBkWFftEeieXETPMXz/07oiYqX2COnlqc0sYwTEzMXtybUdDQoLRjCV287K32PC+hg
         X1r3b2B5jelsSizPispjT3XSlsbiu21jTGgnnOCcAHCXI2ssGWEmNE2OKkc128rIBt5E
         ltbN6YIWDuZcczpQ8czvtWybpf6Q15Qhvj2tikNZVcEhVcdWA/2TgEP15AjSn3Py1cjC
         tLVMBGRy3Hnl2x+SZW6i6XvQxwblg0kFItKDiZUmnjQqlFhxynJl1FCZixdMdutDDP5t
         qX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ikcNibTeUf+UPMUiFV8fQCysHoWKcq3FilBwnxi5AHA=;
        fh=CWFxdju8lHwNwpyT71qDrwiaWZNrEYrarvRDc6ugtyw=;
        b=n1/uB2fcrDQhunk032/DOmq4s9AsKR8j25ob3idGtty9tGfS/xjL1aQqzOqTruzC9E
         3b5Wc43fG941Idt2OUusIMXEiuC0kV8zDvQRkW1LheXy6ZYEqn42cOt2+iqfj/NOWbfD
         b7uefpJTcj12DnZi2oAlG6HnbaDpvhq9YCD+3GZSWIDI24ZV3yMyQIxJyaGVEFEZzS5n
         80zWhMktd4tf9gDm8FW32NQ1AXzv6bhVmdHP3o9AWYBSFtWhEkT8wtM3+Y7eFgcnqZ3D
         0wGPSOwgX/zO2XrOqorAfvD6IlAaYXHJuhEBeTt0fzet3OmB+A5QwE3yajL0COMCsxWy
         UILQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782761177; x=1783365977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikcNibTeUf+UPMUiFV8fQCysHoWKcq3FilBwnxi5AHA=;
        b=HJhwnM+staapGFHwqM808eeWNnUJZe5blKYBHytAshQ0R4cD0s/2bIoY7UPdFNHzWN
         8Lzhz40YD/asdAi/2VM1/lpYEkIGW82FSK1CepGND16DwoImx9o2vaeBU/7MazJl+2hW
         9enHuZY1BYbPqDDbYvYcM9K6Vu+yEZoOFi3YmMiiw1JchXIhHC4tjOWFwf+VUVNZarAr
         gSyHzfMozR6b08+MS8JH647bbcGooDHe1Y6QGk2AoBBjZMHFh+Q703hU4khl4WjOCmGA
         nwu4zPNKSN99x6VUtk/b93lZpMI7QfSJPLRmgm2XKds6De2peb2dXQfpwLr/iTF7U3cv
         xI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782761177; x=1783365977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikcNibTeUf+UPMUiFV8fQCysHoWKcq3FilBwnxi5AHA=;
        b=U8qwnGelbLF88tUWYyUrY7qK6YKoccCOt8hc5bVCvvdTCi8Xyg/9ttLM7Fd3ZYsE7Z
         Qr0M1XIq2hCRNuStqG5T9PEeIOOnwyt6b+D1Q+mQjsBqt89mlCEpGMkDS9oJRa1Sdi/Z
         K0TzsvvgAKxualCNx2svCNeanrMNaVrjiyb7p6zm5QXy49DoUckTN3fJqfpnOBj79BD2
         kQUZoE7JqsRSgmE7SfEf4HTgjGxNsK5cFDus0bPeRUSP8Usy/5eD8ZcARFm5IPLl8uiH
         Jt59TSAShI8ug+5Xl4AZBOycoyRy+YxuROOj4OsPPLi+garl82nTgwtC9qRUKkNIFeVJ
         v3CA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ZqshfZykWRKwhLYXjKOLpEHtmuv6lRUrVjFzaASArIfYLpcwsEQ9P+ymKt+BMEkY3WVVMGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuJhDgJyPf6TKEe4oVkiCQmxD0tPaDonhCLpxdqRZCWc99a9W
	bb+/Mij4SYHXHW0EhRIYWlQiiV+MMdVp3IFSWcO/2lFmWRlYIfU1RPRcFrgPU2jqxNO92DPIVjp
	plobh5ekvlBBZtVjrw+ahQ26EPgtNxIg=
X-Gm-Gg: AfdE7cnzu/tKq/lK2sfxMlm0eVCKGCZ3UMrwAVJaqmeoEgHEQUdAhRSoTHWTmsrZhLR
	lD40vMzU1RWj2d9xdaAlutyrQ1HkT5WCB3zeWmv/nrr9X9ExpqJnwdLZ3joahvIaJEIhU0vERYL
	p4/gH6KwfqWTHSv2MD7JPieah7OvJ9oDzfsGxyoH/ZUVAeaa99uGyBnv+djUtbP3cIxtPb/PswJ
	XFo8GqkcOHMWwmlHERd3/xX+Nd/opF6bsW8QaqxNbrLJdsMkdVZWI7LJNqqcXscWtJ/xD8Oy2d6
	4NyyYsGzrNUq77gCANmFm3WgzNZCE4YL/+6cDCnJ0n2SKS/zoOZExVh5Bb3jqv293HCR7WK7a2p
	fhXyFXSBGM1J7F3FNT/srmiL/ZkL1Toc0hnGQv11phLHub/o8lizBn7414rYU/0yr/PoxlP/Ylu
	+sBI6k/uq3
X-Received: by 2002:a05:6000:1889:b0:473:1ccc:15be with SMTP id
 ffacd0b85a97d-47553028b4bmr602442f8f.39.1782761177156; Mon, 29 Jun 2026
 12:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com> <20260629-add-kconfig-deps-v1-3-8104df929b1a@gmail.com>
In-Reply-To: <20260629-add-kconfig-deps-v1-3-8104df929b1a@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 29 Jun 2026 21:26:05 +0200
X-Gm-Features: AVVi8CfEl_y46MafrE7csTYiPyLlcXEigCUk7Ai-r1lwTXi99wRl7GGWu2NrwYs
Message-ID: <CALoEA-yewRwGCVKUS02m3WqPsVF5amF83HZTsk0H+QW=8fKKvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (max6679) add missing 'select REGMAP_I2C' to Kconfig
To: Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 21:17, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> The Kconfig entry for the MAX6679 sensor doesn't contain a
> `select REGMAP_I2C` parameter, causing build failures if regmap
> isn't selected previously during the build process.

Oops, typo in the commit message, it should be 6697 in the title and
body. Shall I send
a new version or can it be tweaked when applying?

-- 
Kind regards

CJD
