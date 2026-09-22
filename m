Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612243B47D0;
	Tue, 22 Sep 2026 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051529; cv=none; b=gy2A1jb4CRRAVPdB+8FybVNuMvutCiYCpk/bvCVMnUZwnKtstiO8q03nf7w1dUAmbuEzpv5K35/FTQz+dmh4l+ID3Mnfuz0vTfq4Ivis4kT3imHZx0ZNLmvShS7492R7yEPdRjZYVpvqKJc5yiayxMNt+1meIptDcJRr1SZ9G9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051529; c=relaxed/simple;
	bh=DjHw8hZU7vSzTR3L6D6wwac1WPZ2EGWKP+/hY1vRd44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiP8l4PI3PVxHj5T0SPqeyMcmgho92xyQRD1vca+9dJQd01RFXNgu3CC9utfmlhHLvb1+r1LIGSXLzTHn29b8V/BPUX32sE9uLyCRbMJzpWhIW3kmULH/uV55atH4U5ymWeQIsRgf4rjJaEk9C26wVsouaRq0lxkhIQPgBwGtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBglCDyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBglCDyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7B1F000FF;
	Tue, 22 Sep 2026 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051528;
	bh=fDQadVyU+9FKqB10K9OxyyKBHbc9CGmeSJopJlqgsnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBglCDyg4gkQVPFAyNM81VdJqTRLTLE8iN48uyogSDpsom0cuwTHSVWy9rj1S/yVE
	 DM/2czpqNjQJ0YKETKPJ+intI1QrtHpw2EDIzCoFvESJQOUFKLx8Ra/cYHD6Z8qWoc
	 hfdWdB9F1c2umG4pYoJC4VEuCT/HYDDtPlNPqNzfmiD3Dc1WaRQTKpxfrE4tple9Qq
	 j6o7yBDLjdaaHXfR3N4GqVO/Xv1qHKIA++NbPov/QdYaKQEUfjX+gzMjUWTaf7Ndc+
	 IWxRckCWPCDK9Xyjd97KteLcBxnXoYfoJRpisQw3TvbIi8L3tFThA7CnlGyHC73Xjj
	 rearcam+Lcy2A==
From: Kees Cook <kees@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted
Date: Mon, 21 Sep 2026 21:31:43 -0700
Message-Id: <179005150120.2593645.9527324861942717309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922023204.2504832-1-benquike@gmail.com>
References: <20260922023204.2504832-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 02:32:04 +0000, Hui Peng wrote:
> In seccomp_notify_addfd(), when SECCOMP_ADDFD_FLAG_SEND is set in
> addfd.flags, knotif->state is optimistically transitioned from
> SECCOMP_NOTIFY_SENT to SECCOMP_NOTIFY_REPLIED before waking the tracee
> and waiting on kaddfd.completion:
> 
> 	if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND) {
> 		knotif->state = SECCOMP_NOTIFY_REPLIED;
> 		...
> 	}
> 
> [...]

I renamed the empty signal handler and added a comment, but otherwise,
applied to for-next/seccomp, thanks!

[1/1] seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted
      https://git.kernel.org/kees/c/832b9b176be0

Take care,

-- 
Kees Cook

