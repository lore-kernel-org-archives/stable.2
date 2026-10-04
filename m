Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62669227BB9
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791126671; cv=none; b=A/8Nn9UfDnVb+CVTMawG2J+1t27AHfDW8VpCvBopgCkkAeVrxLenKr9X/yvhCTzBMgIdTE7PjjofzsGMPaEPBbyRzfEcThQ2lWenWzWV43c8wppqp3B8JDVAoT1ms/JoZsiFIwf3Ir+wpbi8qnucrhjwb2nv1POTMTlEQUsyYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791126671; c=relaxed/simple;
	bh=vx0BjKnpiC1scEj/tpuIdyMemtVNN+ToNuFPBQdmNHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lphja7sfRUlxdGL6f4LoyCmcCCmNcX7kSuuxvLzjH/j6Qc3EkcMVr5dCuMCGGKmnsYPxTBcBht4omIVFHAASpRXwVTDKtzGmDUoyBri05MPOB59CWutMLY6gjuW8F5AFXSFRhUFhEs00HKwWEDbXX249/NZWcEcqKlqlH0qbTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaNvaAie; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaNvaAie"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a7d725ca09so134677a91.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791126668; x=1791731468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vx0BjKnpiC1scEj/tpuIdyMemtVNN+ToNuFPBQdmNHI=;
        b=UaNvaAiekSrTzaKiSFveFaDsk543NMnM/d6WrfAhb1bBLAFYAkk+Ix0a6RZGqnbi8o
         M0eAXjp3h66W9S7lR+bKO8YAUD6cWgIXbtUvwDEzTmozoKexJjuiJ6AWISM2LVTyyroq
         QH+xU8gcgzkQzbsq3P0nXatQPp8G1hkqxfQNcfgmp9o+G3qB8z9nbclw8NKEBk+dv0xA
         XVS+CS+xPEn7P9305WbgNTppQ5X9MZ/CkbMb5qqxX+lGe8efizu1JBZuuXvfluCc839M
         yJCRlMAR+0J0OLw0aNGTrvdF/bjtY79hPDV78WeLNLO4p9GyXgLGKG0zD6kPqtw7Dh1m
         sOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791126668; x=1791731468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vx0BjKnpiC1scEj/tpuIdyMemtVNN+ToNuFPBQdmNHI=;
        b=MglVsaGzDsvpgv2qYjyWSQNO/zws+uSl/2mxDkTD9vFKKO5H8iRT40XQhqa/cWG5w8
         7RKxU+RWfyGrF8m/eND0dIpylnj5YY+1xM592fda1Too8Dp32pnhgYuC0q1eoGwCGQxy
         LQxFLrg6Pq8L2jCHEge94hkphozDkS+9CRMdsPGNEhdOq7IRHsoC2sPKGVqRAA9nM77l
         xYady+Ikj9hUGuBrRtVSKys56HyVJ7ll/f+bePncUlzp4M8RBPrAra9FfvWtnHQ55AZc
         vxDYIqehD8ehkGAFBP8lYF33L4uq4g6OwU60tj0JV0PFbmRsP178CpMy1vGqHiPoYBDo
         2UoA==
X-Forwarded-Encrypted: i=1; AKwUvBycyEM3BG+nR9fVswxxpju28WCUj6UnIpHusyuPUv50Ni6XNrEmXvyyVHybm2+Tfw9jbT4ufOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtyfvJ4HPCm99kBQ4vkw4ljAKEK+Vz3rDVIwJnxnJiwQohbHZm
	otfOI+tMl4jfn2yrbJ3sjLWCx5L3TxFZjmz5hkM3Tv4kdFhOHp0ysC1d
X-Gm-Gg: AYBFou00zMsqDkE8dNZ3SjwZRZ07EFGcUqhYNJRYlZKqCH2N2jIQiuZWsUlR+C0LJgS
	rMtwaynIjmNCzDzP0fQ22UrPG6tasMkdbYuPcSDFZYS36qzO8x4fxJpzF1nDo0h42ZMwkdRiDfI
	2n5uWDxlqQVROkbimnDxeDXR5V7xb7Dcilqm71jTIV8MRJcD6WjCpiBfyDn9IWos9a7jwkUtFV5
	b+pPIckTx9X+/4WMxeCUyIgk8RlKe1zHijz7Q6rpYFt+E+x7EgIV2pXiah2KbC2I4gEslxFuNgo
	WxDIVJ7P9Y4GZdecAUSqRLFopGYsopExQzGOGewOYhd1CcDYL1Umw9pHh0V5ntETCxLfCXky/dD
	j71n8ilKwJ98wOQ0O9X91Fb18Cytyk9wnTlsRpbB/iNwx2tXS1oDw9upPKsqhtoFdgWyT/cTcBw
	HgHP78omSeTkDVOXQ/WrE899xX+YmSBVFxIjty7e1k8RvaAA+uoSzpzOvDgEkgtGMS
X-Received: by 2002:a17:90b:39ac:b0:3a4:a7eb:1da7 with SMTP id 98e67ed59e1d1-3a6ce7f8bcbmr6285829a91.42.1791126668026;
        Sun, 04 Oct 2026 08:11:08 -0700 (PDT)
Received: from localhost ([8.219.43.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d59f1cdsm6969270a91.0.2026.10.04.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:11:07 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	senozhatsky@chromium.org,
	tom@talpey.com,
	pc@manguebit.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ksmbd: rework ksmbd_validate_name_reconnect() to use a dentry walk
Date: Sun,  4 Oct 2026 23:11:04 +0800
Message-ID: <20261004151104.2196869-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930001605.1917523-1-zhangdairui@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Namjae,

Thanks for the patches. I went through both and they look
correct, including the failure-path refcounting. My patch was
not good - it was too complicated. Yours is simpler and just
as effective.

One corner case: if the share root is unlinked between
kern_path() and d_path() at init, real_path can end up with a
" (deleted)" suffix, and a later cross-share fp at that
literal path would pass the prefix check.
