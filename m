Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532A5038F3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898446; cv=pass; b=oYaVyI6vI7G+RujGYbceUDOtQYFH6mNcMdvtrulzPci3r3o/1ESapTW/nkJQ9ssR6AzlJsi/1kfiPVmce8/z3w7YI/iIQ/HzF+3mnSMM1V7NJyJ/YuEmDo4OUIkYw7XQ8FgApf5EM6xqDQ1axpSRM9fIay8e83MfPeB79xZx3VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898446; c=relaxed/simple;
	bh=g2IBQVq9CabMttw1l3dEAhRw8JS4FDGb8SVrYlvFAg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mmLKaLYk1XDCSQxyViSI1iTxJM8JW9Nt2AHjSeBy5XcICqteW1qlAkMKMe7S+3aghrnFoT3SuwOLT+Egb4PX7nme5GdMvZwckfKi+8g+Ki7DrXqgPjIKn46uM0VnhIXHul4kH7uPYkJkdTMqaQOVxKOUbMLW8YQh8jYpm/MLQLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antithesis.com; spf=pass smtp.mailfrom=antithesis.com; dkim=pass (1024-bit key) header.d=antithesis.com header.i=@antithesis.com header.b=AJOwDntD; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antithesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antithesis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antithesis.com header.i=@antithesis.com header.b="AJOwDntD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso1462997a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791898445; cv=none;
        d=google.com; s=arc-20260327;
        b=b5hy9Vv732d9aoxLSmT8vRP5R1q5AIojSffTpYBs+HrJGZYswalGQtMS7gS2ozBVzE
         JM74iZAHXL03pnnD57mqUQbCuwgrQ82iEtJt+Kqe8CZHd/O641PpMc2Cch3S8IRiPd+8
         d7bYnhu5XTiX98IWXW9Yhhus0KU3cYbTO2rNfmj3s1nNkD5AmWrwozGYNslua+4HFQ+J
         HTVnTpYEME8LjqM68AG+uqj5+05YWcXjjHtOu1DVRKSkaxbD8+ytZIfCSXZrrfd9/EDX
         MWoi1f6UxT83cUKHdX4WfP8ecBeANEE97JEeUNGcLtQK+KfjGUo70EQlZT+sHxxPyQjp
         bfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4E98OAS2nEkNBGwcfAXAZO7AtpPdbTQcWCenrE9MK/U=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=BWf1m2adQ9Q8HxcY5myR8B1A4F86Olczzg9VvTJH+d+VHS1YsVsLJ/UYhaFwKs+Afo
         lcRtCNo5T9OK+tppeOhU7DWVkWhn/sYIFg3HixNukbyGUjTQtRCFCTl+VjH1dOkuLu2V
         XWz2NPjEJYKzTF7jdIIbzok+QQFJuq43g+mhC5nVvdvJvSTxZ20OMAuzFEAfk7jEd+SE
         /MZHjnv2KiRMfmbItxMec8nguStZ6poHX/EgO0lRjXl/byPvnssMMjbI5XU15d0fVLLe
         22tfkheXEzvz50D3hguBm3eKhiQr33Ux55LMCvEz5B4wM2cHMat9aCb9YzfieQdqdtuQ
         X2rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antithesis.com; s=google; t=1791898445; x=1792503245; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4E98OAS2nEkNBGwcfAXAZO7AtpPdbTQcWCenrE9MK/U=;
        b=AJOwDntD+YB8sFY3ETvkZpVvtZC4xAKCjP3xyhQ8Epm9zvz+Y38igGW5TLuxj4rBM7
         qL6dKTyce1a5f67rEFxyzof5isPOBnM+gVva4JzY49gFE4HJfdtOH4SPHx9iLEA1SA+c
         UJgg6rwXrU6RfXuJ+O08Kxup02VYBfUkCkwQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898445; x=1792503245;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4E98OAS2nEkNBGwcfAXAZO7AtpPdbTQcWCenrE9MK/U=;
        b=cmycUXE6PBdJJ539JAI4IAjFHdho5+qa7O9mjNYRiJz5qTfwK8WWWr7JkND6QffYoS
         YPl1FWKsrvwj+bcfULWvY1HFDd6XTIP02/XPdmwqsLWvZUHEezkbDVYkKTxVYdsYTnF0
         gmRdHzt+2Va4WjWdhqjlRV7N+M5B4fr2modE2+3w68SbCSYRBB1A8aQJ5t8tCTiM2/S2
         WpXTsnXvG3Qbz3PBA5dvBVFBDV4TLrae5NzeKgBrBV5NWlmrg8RHiy9A8B1hZ4YOvYls
         fDIgC5jCNzFJwbFq6sQw4ChGxScB1YuImDPp5uzkme+rV/0sHKUbadJWStA1ESVSiS0L
         uh1w==
X-Gm-Message-State: AFq9FYLfqlMjwsirJoAoPjHIo1Pvh50jtcjA9+jMxfVmAcV+EqtMBjet
	j9IXJVYvOzvTiq+QDRzmarPat37s2Q6/Zd3f6P0+GEHfWSM4p2OT4QHsONlDQWmAmu+cFwloVOF
	1D/lFVccTQNk90erLzHTcaSR7rCuJhQSCT+Ti55XWfdIhTIoQSdwPfeC7VQ==
X-Gm-Gg: AYBFou0Y/IA7YC9QRC8lqOXuzaVd0AiLOlyTg6iK8V5vdNIr7eWlADuRkA6+KaScNKK
	hgyuiSp6/clW2f9jkvimyj37NfGcmtxF3FL0ukH286MamaMmfDhHsVfsc8v4UkoMhIMhHgeTU1f
	b5B9b7Kjl5OtjmFTFgWnOk/S+yE4Gyms5V7BKUOfMkDx6UJHFxja+JoOEv4ljHelhg/EfF8/UPH
	wnVCKThO7Uss69Q38mK0uTdtc/H43E0v7fJ6EIu0mGtkuU8XQZp/mEPJ/KrBneyMrf1jzL69fO9
	sQ2zYuW7VssAIs/Bfd+4WI8Jlj315k9QbrY9+UT/sY8hOD4M1vT4oaSN
X-Received: by 2002:a17:90b:5864:b0:3ac:38dc:6b9e with SMTP id
 98e67ed59e1d1-3ac38dc6d80mr2423528a91.25.1791898444649; Tue, 13 Oct 2026
 06:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenz Bauer <lorenz.bauer@antithesis.com>
Date: Tue, 13 Oct 2026 14:33:54 +0100
X-Gm-Features: AclHuK__i27KbdnIIXFdrD6YDSeVr5VUbeM-Hkgm-UihKrIyNCiJ1-3k7lPx5tc
Message-ID: <CANo-qm0u0NegPA7x_ymsLeC7f+v-nR8w9BEQTndvVbetYtUmUw@mail.gmail.com>
Subject: Request for backport: "drm/amd: Create a device link between APU
 display and XHCI devices" to 6.18.y
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please backport

   07c93d7eeb0d990bc1b8e3b1eafa464bc9feee97 ("drm/amd: Create a device
link between APU display and XHCI devices")

to 6.18.y. It fixes a problem with my webcam not working after suspend
and resume on my Lenovo P14s AMD Gen 6.

Thanks!
Lorenz
