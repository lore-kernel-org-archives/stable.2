Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C94562B7
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850952; cv=none; b=gpmPZ/W2EtQqwJAvfqFKJlf0fZ/iVZVuwASQCoKrq5UT24SVD7AoyIhX5D9u22UFdpYN6++s55lV3yGrZa79/JU0PEthEI+znnU6AEHiyql0QY4dhg07UE3NN95cA689DYJr8olANdCVVM5L/pGbHHY5FGoDpaYBaRSjtylnnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850952; c=relaxed/simple;
	bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3/L89n0lUhKGnC3WpdX05qABHxkmpfk7RAMiVpXK8PhZ54kqz+Sm33o9wmMryXgmD+nGaqKOOZ8ruo+EkcqK+gIKZpf0k0B+IDntilpkbcfWBlWhskkBh6Bd/rpIznzZFPYHW1vnNDH2qBfNuWRT+1I76j7QJF/R+Grj6/gYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HVNDJ2sl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HVNDJ2sl"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e27035206so4714844b3a.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785850950; x=1786455750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=HVNDJ2slChBLAnAtHJWsuM0GqQ+U+3j5u8Cc8lkAul0O+w064O3addkYOLXF8JgZA5
         JVvXgnopt/Ar23f/ERGQYebRecvOLu1bnMh/KasRc4bAUdtPyEymba/0tQk3od0O1/n1
         seakULTsJyWKgcz8t2Th3LZwg9ADI7IyEVMSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850950; x=1786455750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=UPqhj+i+275PxA/6+3nQ6A64XAHSiZg8+5P573BBraLoBIupqDC5mYZ47eu9IU90bd
         5RHgwltpAQYG7D9XYu0QTBw0uX3AKi2S+YAneJ7+MFvg+jwLmGXsBalJmQ0iEKZ4lLmW
         0wxRCKWJmIXOa4RaWLWl8rQPprfW3i+B22WW9kI+SO6OuD6vN8IVhEuwKy3p+tZXp9p0
         wqlprzhEJjQZnxmkUhQggyzqSAP27u/RE2YwoEXGngtuPiekwEdVnNpB81QBWBAz5s9/
         pbfyYLFi8dlwg1NXQj7HqXCPrDiGewZjyZMTLqoLCUfxqVNrxgZJTRU/BPYCDgnZfBRY
         cCvA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7QWOiyr6M2SEpYxJo9Klp56xQd9omxbuMHEWkKjC0WkjDGpn7yhTVOpcL7qxV6U4d19MVUtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Gdx/bJnThwIm2x2bk7TChCJ9GHsxb5LWwqJ5OzJAFUVxlPaO
	8lD9RpTBXYA+BJYeavOZ+bLr/Z/KLJZ17GWJRetsiAzW77Da8T23nUG1M9EnmYM8sSxYb9AbZ8w
	NkaztmCw=
X-Gm-Gg: AR+sD12JGhBxUZVoKurAsLQ5zywit5+EQTf9jfl8pOTUnRQ8hvFUxUK7n6Q4WC7/Qle
	hJjAgPImTC94OGUw0FQQXWEMiMiaQE3xbuaFF37cnKLeZzS64NqxP5yxf974WNojeKwFFYZBs3J
	cqUmeSEJu9tRnqFQ6d46cUk6d2gFcMEa8o4KZB8ByMyMozWJxlyQ+bmG7STq0dguR8bkSFsIXtU
	jo6NIhg7Qyz6f38yt9y7qLi7ktA8EJqQKIb/PGig60FFJwD2AP0SmbD2/3oqfuRFZhGoXYN8Wen
	Ttom814esB9Gh2kBlpjAiJGgeU/nkjb38p1mCA88N3jFo7JFQGcWxyf07IefKe4BZbHKs9LcWiL
	vA4vReRNrDI9v7CN2c70dUR9Stdh5NEpvUkxrsvTbXqPMRSVC4Wpp2D6pTnfpPAJaCO37YpeaTF
	ElKiWgYN7DISDrKY0Pe+Elf/RVV41WlizvFG7i19NG0+3IparGlKs=
X-Received: by 2002:a05:6a00:12c9:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ee4915d1fmr13645029b3a.58.1785850950265;
        Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:e3e3:8255:fe3e:c7f5])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm5258690b3a.39.2026.08.04.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:42:29 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: jkoolstra@xs4all.nl
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	farid.m.zakaria@gmail.com,
	jack@suse.cz,
	jannh@google.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	mail@johnericson.me,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Date: Tue,  4 Aug 2026 22:42:25 +0900
Message-ID: <20260804134225.3631912-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al_MqBrjDW1QjRau@daedalus>
References: <al_MqBrjDW1QjRau@daedalus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry if I messed this up. First time replying via git.

>Afaict, currently read_code() may blow past what vm_mmap() allocated
>there, which may result in memory corruption for a non MMU system.

I ran Fable on all of the "nommu files" and it found the issue this
commit fixes and the above issue,
I sent a patch (co-written with fable) and we proved this is an actual
issue on nommu via a reproducer tested on a real system.

https://lore.kernel.org/all/20260710121443.1059549-1-daniel@thingy.jp/

Thanks,

Daniel
