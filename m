Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853537E5DB
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101097; cv=none; b=g9XDTzw4k/pfHSlRcTl4SrZt26iuje6/KOZzamxsE1uBC0jzHM+FQqc9t1Ocpe//bpCRFd6+Lk1c7dTT/+x0/PhHc6BYENv8wVO+5c3+mvoR+GKSU4/5QU0akO2ctV7ViZPhPwnaFGEDDhSdf0FGRamOmXtqB6GDguQ0XEDH4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101097; c=relaxed/simple;
	bh=OJhn531bgDCXZHrDZj8guf+W02daXYyYRUz7+0blsBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNa/HKa2NPr/90KBiKcEe+5xdkhaPeqwkkahr3NUEqOYRwFFMFnSlYNRtlCyimFzNJrbGCq2m+6So62VOuOeDgkwr2MtOLB554XNNd4ZRyq2bKEY76AZhjR795yGBVhH1TVyxDylNEVy/wteEP6AtgSocZBP9LCQ32AqzwKID5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw6+Xu4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw6+Xu4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75041F00A3A;
	Sun, 26 Jul 2026 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101096;
	bh=wvzttw6GfF8SoPQ705868+0rFPe8smjyBzuj6rPkSBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rw6+Xu4fdP5uMkGHAGJDEOo20zFgFbHXm6MnhYGa5FSSWfCP+cgoTe4K5Ao59mMvA
	 rj5Z4HaiO5D+8GbsqmlLk9LKLKq0k4SJbSLiKFxrcGlKnifMfG/ROMCCcmQASnizJU
	 Cq8Yjg0z0Lah3eW+3j8yFK+VFyX9suV1v3QPVYoOMHX1hGbywll26wsKCaubWsHZnQ
	 qrCKl9EW0irVt9BffKDRC1LR6nU3gFVWJkko1SXsu4aI2sntUXLYptzrHQGZoXmKdG
	 XOaD4GrZhvWojhEVBQ0MqdL8PV6p/JYdfie0K8fycpRr21lv2eBHvh4/mn3hE2yam7
	 u2LZZBznUt0qw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	jwlee2217@gmail.com,
	oleg@redhat.com,
	qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.12.y] posix-cpu-timers: Prevent UAF caused by non-leader exec()
Date: Sun, 26 Jul 2026 17:24:48 -0400
Message-ID: <20260726195203.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87bjbukeyv.ffs@fw13>
References: <87bjbukeyv.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 920f893f735e92ba3a1cd9256899a186b161928d upstream.
>
> Wongi and Jungwoo decoded and reported a non-leader exec() related race
> which can result in an UAF:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
