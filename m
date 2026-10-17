Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8D134CF
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195781; cv=none; b=Nq2so5k08ymItnL0mrSzNiB+EcqIAMHcTTZ9Jt/nL56GSwdFeY3DPr2k11tyF2lNcF2I15X0uOyPFR6yyqOdsnYtj5BqbUa6E51wz0uTJ6TXABXvJ8vGVIy/4MxgQzDlyBD6rGL5NEYZjW+v+rv3r3Stc9Id+lCv2yQe7iiIwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195781; c=relaxed/simple;
	bh=R03FmR3pbbWZC6kdWDV0GBdzqk7u8iUUBNKqb3kTguU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHQYFLYJgciI7Vaa99DIaHSypdEnGmhYIofQXp8Kc64XUXPS6B1Yj8mi1fZehPo4+ePHRcATEkVk7pTcCBeNun7+Qa0XPV+h1GeYVkbZo4vrlzDR4DQOXbn3XSbVcGaCzYSAdJurd2FkfqmCfUZlwcUnmUC786ewS4SMR5rbK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYhoZuxo; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYhoZuxo"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so917181c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195779; x=1792800579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hdEgyaxXnBWSRhuv+q3gw3+PLLgLDUmHWnxnCGdLz4E=;
        b=CYhoZuxos8RpvjncbtcsaUbVHCqs7SZstFBPOOF1Q/f1JhphMfe1HYVuJXOzJO0r4z
         dNAHPTKL6A0Yc9sdOuPJS+eYLaHW67xgWsExF1h0M+I7rDbp/F6f15NcZNSyyiF0KGrP
         FuPnKnSma3J73splMAY0tU5Mw86vsAJOeSh6l+SPt5myf53s3GmHSHbhvrxRlmkY9ITF
         74ozvUVVej+yw8LqSvpNYeeiwFxo6k8M2ZMKlKzzov6EctpxE2Z0OCR1PPvRQZMvV3w2
         QVvkc9mg23s22xFWRDDqdTe27JCxgNJ6kJ7L6v9nXdM5nPzCQ89JPsWrNXIL4rlcZu0y
         kfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195779; x=1792800579;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdEgyaxXnBWSRhuv+q3gw3+PLLgLDUmHWnxnCGdLz4E=;
        b=KawEg9UvkE2059EY0AywM1KqZ8l9EuvzERX4C6pbZZzUM3MONqZjLbvw9bQ9xtPACK
         YX2FuEU5nJPlPL0GhA5jtI52miRhK/UGPlltlY37xleV/qt9Yp1BliqTB9kQTTHtRi4/
         1p7Zx75BhWCWuu79HGSvH6yFAYhQLlGR79yFPNehqR7/4gniJVnOHRJKHG6dLeWrht29
         kStzshdzZ5aqqGApUPkkGxpQtAifIN3kwpJdR+HYoqQQhJF+tUnzQ6RQtqeXkr75CZDP
         eWK1DajgUovyA539gr7yuOPVM3Dd4jCu6ObRipU13GMrdkafESJ0F1ah8CQZMmCVZcfn
         kMXg==
X-Forwarded-Encrypted: i=1; AKwUvBz94IXKUR40x49UFNy9mkYcC3KvXQhCW86uqBmxDhJVAvBJBVImoUbH34NrPVvCxvsNRg8QJS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsCR5vbR3Yr7T+68eDwV7awzPkYutFaZjxtIyiAqlpq2ZUlfuH
	isuZuMWQuP4ISguXBcHHi6TAryAhY1LV+NgW2nDZ1k436WeGcOOxaWV5
X-Gm-Gg: AYBFou02/smSuMhK9IbbEyfs2tiM6MyebCFq2lYODk6s2tBfajyW4TNx4+A6iDyJ7zi
	13r+EoXwXfGkZ+8/mmqMc1vqClwZ/0wH7w9QeuA6AjMzH/qAbeMvL0nNQ1yXfhssMS78sQGx16h
	pHj3U6gM3NCg4Z7BIH4t+hNzEzJ99+mSXa8+V0iMEqVWWJIl04kzXS7x3kznZUD1a/Cy10/mbpZ
	7tNFex4LlqMgUQuLxBmO50DV/Njc5aHD9C60j84MlfyEmVGbg24yoRm5u8vrtPM5gEzDTLH4FJP
	t2iZLY/FLalZTWJ9gY62oJ4B8MymCppG3mmptDhOohbDiN++mnXdh8qm2l2sUbHq+SgAJ00/pCe
	iYyauV6UCRyeRKhMqoIsdy9RXZZtLU+iLvXYTtpNxeiJw//DuR0PddVcrS9L08cxHGRDi8KctMu
	SmPejQgjohW0rmwr8VbxEXQLnMgTnAaD85nOA6LN3hlMt1pr+RuPjxisHdpW0kPsaXYZ2swxm7e
	qMh3a/G
X-Received: by 2002:a05:7022:ebc4:b0:14a:fe37:cdf0 with SMTP id a92af1059eb24-18514bfa955mr2412948c88.45.1792195779041;
        Fri, 16 Oct 2026 17:09:39 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10982553c88.6.2026.10.16.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:09:37 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: qchcio@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dev@deq.rocks,
	me@freddy.us,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
Date: Fri, 16 Oct 2026 21:09:04 -0300
Message-ID: <20261017000904.8663-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015181837.41690-4-qchcio@gmail.com>
References: <20261015181837.41690-4-qchcio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the patch.

I applied patch 3 to the 6.18.49 kernel I use on my MacBookPro14,3
(Radeon Pro 555, 1002:67ef, subsystem 106b:017a, rev c7).  The kernel
also carries my unrelated PCI and ACPI patches for this machine.

After a cold boot, amdgpu logs "PCI CONFIG reset" and "GPU posting
now..." while it loads, and VRAM ends up at 0xF400000000.
MC_VM_FB_LOCATION reads 0xf47ff400 through debugfs.  In my tests in
September, a kernel without the reset left VRAM at 0 after a cold boot.

I then suspended to RAM three times with rtcwake.  After each resume
MC_VM_FB_LOCATION was still 0xf47ff400, the screen came back, and the
kernel log showed no VM faults, ring timeouts or GPU recovery.  After
the last one I ran glxgears for a minute and the gfx ring kept going.

I also closed the lid for about ten minutes.  After opening it the
screen came back, MC_VM_FB_LOCATION was 0xf47ff400, and glxgears ran
for a minute without errors.

Before that I had also tried it after a warm reboot, with four rtcwake
cycles and one 45-minute suspend from the idle timer.  After each of
those MC_VM_FB_LOCATION was 0xf47ff400 and the log showed no GPU
errors.

Finally, I reloaded amdgpu after a suspend, twice, with modprobe -r
and modprobe.  Each time amdgpu logged "PCI CONFIG reset" and "GPU
posting now..." during the reload, VRAM was at 0xF400000000 and
MC_VM_FB_LOCATION read 0xf47ff400.  VRAM is no longer at 0 by then, so
I think the reset came from the existing SMC check: with amdgpu
unloaded, SMC_SYSCON_CLOCK_CNTL_0 read 0x01000000 and SMC_PC_C was
about 0x205xx and changing (read through the MMIO BAR).  After the
second reload I logged in again and ran glxgears for a minute without
errors.

Tested-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com> # MacBookPro14,3

Thanks again,
Francisco
