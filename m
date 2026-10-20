Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504435;
	b=Jlc5scM8zj3h+k4h24sDKd8p4GDLS/pCVqPwlK8pfIii1M/zrVGzn++HWHQ5iKQ0it4a
	 bIEy1FzOY3UBwX4HoQTbKnMg2X9jYua/wTdM9Hsr27Z+pA0rlPr1ufZ4HgZHYD4dxAKX1
	 iF+qX16H7mFaKnukqVsBwtOpUcKrS8E/f2XURWM7KZdP16j29fFEhgy/CXF0A8W5+Y8qC
	 t6KrEI6wrHKjyMubF6++MJsoDsZEjYIpEE7Qpha5k+14DKUyen4iEOVCgGpT3NiSRyCLs
	 1AfFdR78Dsb5B/nchU/eNS8aJX+Hn+2n+u6/tHHVHpwozG40P6/E9gsGqFUeErec2iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
	b=cLldnpDudDiELYvEQBBd7MZIwgnCA0ABLL5iefvrN/wjDZjmuMIwMPti0cOOtJI2CQb0
	 fQyMAC5YcurtjBjshilNMxsIZeg9ZBmEvMykHYOKtW3OqbjVQyUdb/uvzPvh5J4QuSwg/
	 kdQQaqm4rxNEIWCQ6c9FnVmeUubwAz3akdBBp/fQe0KUYPJA3uPHYq2vCFGwryw553pod
	 Kr28kBJRSAPjHPB/sTNECTI4MlOBfKc2PWJ6YjLOxcNHItlREXgPx8urYCkOH+ZUT7F3w
	 p9D9ZI5+sKfVmyjv6hepSD9rv1hrQBKXnfrdFCglKEIuYEAf5zr2uqsDk5m9pa/Gmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DNI/c0Gl";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB8606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNI/c0Gl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so21061145e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504433; x=1793109233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
        b=DNI/c0Glu19KVbXdrcsZDBVHr/o1y1q7ftTjBHkscyJsr4xq1wT6ttvP4qz0Boqcha
         ZH/mF1PJxNuvG1Y8GnpqjBvq1dSum/g6n+7gciaY1PYXG21EONxrGtcj7dMUTnv1dWgE
         QLEmfb3MeaSfVRnUt1O2RwqyAmC/UI5+caKFEHj9PKiKjQ7J/M4meo/dZ9/QQ+MBD71l
         4lXkr0O6shR14m3dDEjqtcsNfsJ6qY984Q8/6fKZ2boar+feHOdFlaSECZrsOCd1E+JS
         Ly9307HnZCJ27m+OIHMt1NKv8IlYYdPvGKEUgsCWpFYLjQcyxQsKBdFf84lQRSvaLF+L
         1Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504433; x=1793109233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
        b=nSBEnKMA8WO9Ndt7jwTjZj/kmSzCU9/bdyGFsCyyyDAZDR+ngPpnXvql550c80ocGZ
         VgH/99v2EMkH3ZlqNgEe6JrBt2+HaxRWW6kJuqitLjzWHRkV/8nFSmwC+q3xObGjEogu
         4m6zuOSq5xKGsj9UKttAmVBxrkkWfduZElhAMPCsQQmQuRyTovhAnq+IvJwh99GJ1Abq
         HbxHOAzdkAEN8WddyXtFcD2tdhuhQEYwoJsCAOuBHnjFItFU/RoTLeAvQr3vdsan9PLg
         fyIh3EWIfXtNoCpejns6PjkAq+HI7L/KmLLqqSRfgYalZ9IRF5/XMpscxJORveEaeGtx
         OrdA==
X-Forwarded-Encrypted: i=1; AKwUvBygJ22QqQXdhH1yB3Ec9Wd+tNHSIrlUjrgluNvOrPH9UzM5maVYARdL6oipWDxvLmPm7REtujo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRKXqE2TuHkHVtXFFq/dOnjJ1ndntehzNLkpszdsgTkJezZNX/
	SHhNPuU3NLqEJZhZNXDkNvDQ4XKlQlyQxjPNVOx4Q/ThPYgmUSoasFpb
X-Gm-Gg: AYBFou0+UynmPaxXAOXy8sjMB5xXkza7Jrb08hYU+wH2WQk4khrpdekXzbGgQ4GIkrh
	EHJ9oSlNLCeCiQNRTgpQI6ORdGSDH+Hsj654+jqutRY34nhPnXQ+CX3SSOpT4WM/WHbxbycv+te
	E6IxVcgE1okxiK49PSJoaexxZYwoBNwp2vfTInh/yZFhWLlq+Xq0AQzYIrxnwrbUOTahdfiLXBb
	IHCHpCC53JeeGBMMNIRwZ2a/sHfyaj5ZUoDO7SLiPqOA2FNPHubBeFjNoH6ysPMYs7BE9rsej5o
	Md/JDlfRkwoIKYym4eo1i+SsmvEeG+phCpgqCcJ3ru608D6XuQwLzC1kuludE4lQn0CYwws0RFn
	tILe3oHHCD97A1iN6I/VSJEPtnTha+T8fEAIkd5PQLSP5KPqf+7MX0SQD3a/H6yTUgg1eecQQsK
	z6qYjumEM3pLfhhuK9VmTU1TwXiWJ2KRVUby7/A2nuDG8o/1X5h37SmzQK+PSiyM5cFF+SQ9EZC
	sa/Ww==
X-Received: by 2002:a05:600c:4e0d:b0:4a1:e7ce:107b with SMTP id 5b1f17b1804b1-4a1e7ce1570mr128096285e9.2.1792504432871;
        Tue, 20 Oct 2026 06:53:52 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb6d82sm68132705e9.5.2026.10.20.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:53:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:53:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: s.grosjean@peak-system.fr
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan =?iso-8859-1?Q?G=FCnther?= <stefangun@pm.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
Message-ID: <atdybEUQ9EUdZ9A4@stanley.mountain>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>

Could you please slow down.  Only resend once per day.  Otherwise it's
a bit like involuntary pair programming for people who are on the list.

regards,
dan carpenter

