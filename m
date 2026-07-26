Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB522D4C3
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092848; cv=none; b=pq9sCi3UnHpfH+aHnJLsvtL8T816W+KXSx9RACbOz0+/f42P6VA6WL1VBNOLYxdIx2l1EK3fR2ITP+6f1lzERERbu/HiVcNhYtFbmI8qPoF9fuMGsslqyFmaon06Njq74Ol83aN9rqoxt35mF+bmAMSGkt/DmAVTk7E/wfy6Zn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092848; c=relaxed/simple;
	bh=aeR6qb99/go93Xe0zf/SY2jIefv0FIAp2SuMPVC3hfs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WOStqJ/TwTkKNSYXuAy0MbR6xtEUR+/jtXS3x9m+1JIsosaKi43tXT7ZuU9p8pACMv/LktyQJ+JYuCG6YcKMnMUolbo+mEu5seEfGHJQdPwCaC9DkmJOuaRsZpweRhvDSGNnwBycghd9u3qa6Hq9/F9jEyrFiTdzUWl4dDZO1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=mE+0/tAS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="mE+0/tAS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1025643f8f.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785092843; x=1785697643; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aeR6qb99/go93Xe0zf/SY2jIefv0FIAp2SuMPVC3hfs=;
        b=mE+0/tASVYJZBf3tA+tjxne60SXy4niOo0WVuy8GT3XQGCOeQPjugx1UNcaPgSaa4O
         gtRF63SP4hIqOLnkSiff1Z3Opi/qSIOpfgxOvm+sufnyTknsURZsuz1aBf5g3lzdV0Ek
         UqKkZ4FvU4fXAZGXJcknkvBuua0ZBfhj2YUA+ahYoK8lICiuT6vvYBwz2gw57HGvIzRZ
         XkjwcCBifpiu86LOcUSwT0ShC2HxA+sHLkeqEa+889TD1m2L2wRmtWECdg6WeViF3Tf7
         HkNtgVd9uUs8j4AiSm9LyqzGiF3pJqo3MZqASb84CNov8hafuWJBKmyOg34mCgfIqQLc
         ugcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785092843; x=1785697643;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aeR6qb99/go93Xe0zf/SY2jIefv0FIAp2SuMPVC3hfs=;
        b=GhYMokf8vIef3/JRyGRtEG2IuIyQtoMuxGWp0dYBCLwj67zb84cPMExvrFtcdng2ED
         gQ5hhSg1e1bmjgdtcWQCIaH3m/4oqv5SayqPCqAujV6WdKyQLOCMrGW7qnhv/r18+U4A
         RL3gsyLdhDHaFVtg/+o56QyYvP4sHBBPivGMbGnMdnLa+bQjuzx//yZtPUr0I+ahhxgR
         4rbHdung9rJ8IhfWaoVHGsmztYRl25Zp4svi+FCeU2dvA0Y8MsqCXkoqZVSWuhdls3fn
         X88aFQBD+m4H41Uhs6OO0iStdw3ispzw7BQjIZEuay9aiUtmxubthlU7ufGmTptkqpfx
         OJZw==
X-Forwarded-Encrypted: i=1; AHgh+RqDZsntqvWpPmsuuMfIavo0yrB0/P54z5E4+WFXTzSUlOFYGl6ETCC7bNf6XKdpEPRKWb3h2Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87DPUkVvnNdz6HMai0JXvhnl5UaWJW/oNFRWZxc/A9T3ETBVv
	RholFbXqmB8XyXPVFcTwtepFqGs8oCKt9g2NnkA3otC7G/qV+JOFNAN/FHWwH0C/pdmEFJRKcF9
	0JsqK2w==
X-Gm-Gg: AR+sD10XrtjvpyPKW5+zDv/vFYDG9nP88FtAfRjatejqmOc/dfFWLn4n1NE95tgAlcg
	GHJgcQHuF7YFbTWWWvG9Khx4TtG5phK6dDT3Km4MBseOSlZnnuh85hmLqZmRoUimsAYxRPetE9i
	w+00bP3UTwTKh0jHDvKymloa54QCLtjGU5GGZ7t3J7iE4yjR0N56cH5GG1zGyP5iDohhbVQRamS
	g5+xTQjiM/dzH/0TwhhjrOHVvPEM2/T6WS/zp1eetcPBSEf7HTYmA6FTRyx+FJCgXI2WA1+yn/3
	/genBBKiH0CQrbJQHQ+M6/W7gPE1D/nYh1h3XNCFtbjFSvn1LiGFTeZFGVJXLsKHwHbi+7TZh3w
	Tl9X72b1EEXAeBzTadR+yqw/aFIrVbGuaUnO36njS06+FHRw3QHeDouuVsJgkrzkG6U+udivlX2
	B4wI+GSidlAD7ezU1f99lJT0hNd1iM1B3GoV7EUYdZmYfMgCiFXaM8YROZDH5m12ted7D2ToNy8
	tLAhKJ3D/KkiwwMk+dv/qIKf1lPGlJa5HM=
X-Received: by 2002:a05:600c:8485:b0:495:6713:9aa3 with SMTP id 5b1f17b1804b1-496b57281d5mr75357285e9.30.1785092842714;
        Sun, 26 Jul 2026 12:07:22 -0700 (PDT)
Received: from peakbook-mini.tail8e484.ts.net ([178.197.222.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm42226357f8f.2.2026.07.26.12.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:07:22 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To:
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org
Cc: tristan@talencesecurity.com, vasanthakumar.thiagarajan@oss.qualcomm.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath6kl: prevent assoc info length underflow
Date: Sun, 26 Jul 2026 21:07:21 +0200
Message-ID: <178509284111.44012.4392862410372916703@0sec.ai>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

hey Jeff, sorry I was prepping a different patch and sent this one by acciden=
t. please take the original one from July 13th. appreciate it!

-- Doruk
