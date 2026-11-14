Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=fBA1YP5kjANZRau0TDHNX8aKQiyeXSfPDMFtS6hm81M2D6EFmtF4vwPCbE9jRmR137Hm
	 dLebms09HQfZeC5QAmTC38yAgp4IBmeSdQRmj6eKMYp8/teJromNRVeWFiOjlDww+WsdK
	 +7kCXBFR8Xu4aeiekRRwACJ4P41Jx2Z+/CV5hPj1svpt2h9IrP0R/DClHSDvCIoFTvSmK
	 gLgPVQ7oKhTsBPcPXjz6lrHhajox/CSAATPsfGmy2jZkSHK4nwCX1tZiMePbVSLFUMHhM
	 Wf9SzEPc+6kEAQoGNgSi7bTvAAg802f9CirnV5BVE5PXK6Ojs9Gc/goC05IAP437G9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=5jSoKMbSOTXUjt8rCDmEapsjRXDqmXHu01hf/OUw4kitV1BUBgP2Z0ElTmR2LKyYftwu
	 EqZbWe1/MmpfVJnqdrbpPouJMswHVi3tuo3VBPl5KiG2r2OkRq2drWGLgPz3WMlh1xhPG
	 ZuoWUDtVBRy3WboDF/ECo2F8wkoR3NxLU+3K0OusoRr662MEOBAto6HMgNocRFkZm15EX
	 qHeqiR9i4DlVlJe94AjWq18D2h0Czaa/bdAPN/CueFc76NB9PosoJVztOwSN3oczedQKg
	 hDWxNd52hrK6/YUdReZWfjsBphp3g+n9kZ617DjhGPMbkVDfUAaY2hErFXOsyGRBTHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BF606A335
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50BF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b2382bf051so1354514b3a.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=YWtetj7p0FSjBBxIDTkHbLFNu6mbnvH32CO6mbBDZdckcEVcNrzrMAin9Eg4dGlf9u
         kak/4UcWjunuaw0IkupNTtE14H5FedS7+SrTzdITabEH05KlZkky06uP2c/8losLUqHa
         UMK+aEH6bEFMTcQzAJ6oO3mRITS5J5C9Sa99L7Mdpj8bEWvf/mH3DmYOS5DaBbjIpSaU
         qIlcx9VtDtAj8PvoMnv36Vt+qV9pfAnhZO3Adai1R4vaa4xrCPeGvsWT5gZoO5qsOhl3
         3Sxhr9gLMrlaTx6D/hcVTEtxOj68ZcAeacIRnAQtchVEgEvlhS9Oxn+qOOaHab1lHXf/
         hIeg==
X-Forwarded-Encrypted: i=1; AL+hErHmmRFctRQVv/sAJMyrpJUPPjai0mgGjlXZI8KZ8VLbT86ktPx0K1UwKZdJlS6RjJST8AJv8l0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QElfVFh0LVy68KVBxS/gBg/KCuewdCHyc3YXpl+yPwI5Bupwv
	ZQ3yDPthMIXsa/afRVpZC/zbozCTTpb/zS778HyE3J8Zs/aqbt8/q+kzYkePS68MNMY=
X-Gm-Gg: AYBFou11u7zZuDZGxv161wpWRYqtBQDIou7jd9fMb0cMWPBlN/42lQnObtDydBLd9y4
	7m7wSuw5qUSFx6O9YuewTjrx5QXgtZfzUWJxkTLuxeymqEpk3BxbZGsoGN0z95FtGi98D4UEVuh
	fecP1egX4Ncm2+ozLdwUO7C4/1YPmerzQhEIjssb3fhvaFY9xLlUzlxVOYNgoSVYhR9pc8jko7y
	mqFAXucVHZBr8fqlOCnkfr701jGUL63CTtMCMRIL84EjmSvky9LXKa1ZK3AGwDPPYSX9bqv97ez
	Xjtwi05hBgWl1zrVaIHRvGYF9GlNxJMKY/aFME/V1V3VTvMOa6eoAxG+fVjepImmSNBCCXBquDb
	PU04BnOlJZLF6fQTJkDm3Eouy4TDG8/5QZD4IdWPSUOSeZxrAknvlOWa9GGjV3INU7xqIcv8hyU
	t+N5a8EQM8QO344QX1iFIfdDocqB0KPPfJOeyaw8F+jMj2PORrQC+3xBmKB48C5RVT5oM/E90tf
	OXNLwAewtQ4Gu234IH+BGf9UIDZzeXn3s8Vr6vSod9uN9u2gdp20wolOgb/dmbE1ckYzGL/XWYd
	JXDI7fOeA4TjUJiCIY5bCuTP3XDLXZm7lchPpG0cHn3Edd1UEdSL7ZSUddqUgGIV9VvNtpT9/Rf
	8df/GY3fLyYpa2yEjopg+Wd0E6ilamG0Nwm5v7MgVOZzhs+ayBOPJpT+30evAKAVKD+Jh9fH/6Y
	Lm/JkY3dIJWgytzLpYI7Fa1lbzZxghjiphPDqssPzx1yNDsZ+NvMo4EqyE
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
