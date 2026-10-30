Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393655;
	b=yWMAloXef09ZwsaRPzXSm4pbn7IYZj1Ml6NvW203eIdVb5zLc+jniJ6eZQyyzYhp5k57
	 Kl9Ngbk3Wzqr2vCU7nlLUOQNkk3XkB+GqcSudW7/SqrRcAHaS+USmwpktQ7BJ45PfA8lr
	 TdXtRlshS1RKyuIZzkSqtb/I3ZWxwUKB3TOYGRb8C32/g1Hxy3r0GBJAsjoSrdXfnAlLP
	 HhiN/uVnkYqESgxobh+3M2+NtH5h0y6bXhosO938XGolmCvWqgT5X0aWuz5Ttq/TtbzCD
	 nmj5jh7JVIyiXc9iuyhtDnHvSFNEQNKNrUSvPhok9lD2pvhTUqlakRG1aGk5VBTXgGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bB5SIDYKhbqtcIKkrt5NcRHUgd1XT7IAiLd0JoBmmiI=;
	b=RiupfxzSycSz4+6cp5RTrhe/8W4so5Hz+2js66JKCCvPAfhrrdoZvDOdl3h+2sekiEGF
	 et53/fjadIVNU+kiKrB5Xyh6+Az32iQvb1a/aGklmtTXuyShFOSIhCrleKRXhVMel1Oo/
	 hxWaN8kdFuDRE8QthNnKTosUWdbrxP6gnFw2xyrjTQVSyPUxzQ4jc4d2MxEd7NO2VYZIl
	 o7st2kkEkmrCXfoDUU+db7XpsG/Ndh1GyjOFCyyZStnqkytKQu0LlF/h1O/jq/Qq7Zo/o
	 mqAXfVTwXI1SV1r4zcy7DY8td62QyVq0sqzFvwCQipTLftbSk2LI7iZljOezBAHFvpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvRdmJmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EF606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvRdmJmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44101F00A16;
	Fri, 30 Oct 2026 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393654;
	bh=bB5SIDYKhbqtcIKkrt5NcRHUgd1XT7IAiLd0JoBmmiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cvRdmJmxP6NYCYorGUHHD2MdrlrqVSm2rHv+Bd1Xxf0/qh2Cprlz7KVbJQqw0qDlf
	 9byK860nct3y7is0sG4SlEMudlaG7qJ2q8GKDd751rVxclUHo7topHTyvTpwX2of02
	 awzlz20i9oVVp4rKAYwTMeTv5tFtLMo/OMZ9Pnjj1lVDrbs5bxPVqQERLrL4v1evBj
	 QtQ/zlhkIajo2F70pb3kK0EmUxvY35bzZbZq9rWK+LQy2dpivXdbNz/GOV4VYZE/Hf
	 OuKSeewK5gAoxrBjsReqJwwvkRBncHW2zAT8ZBDfqkoVE5Rwn1HPcEFSioRokxO/V1
	 RhBR2ZsLFsimQ==
From: Sasha Levin <sashal@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg KH <greg@kroah.com>
Subject: Re: [PATCH linux-6.18.y] hwmon: (lm90) Consistently use our own mutex
Date: Fri, 30 Oct 2026 16:54:05 -0400
Message-ID: <2026-10-30-1-daily-reply-0002-lm90-own-mutex-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026103057-sinuous-halves-9ba7@gregkh>
References: <2026103057-sinuous-halves-9ba7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Oh that's going to cause problems over time, right?  Why can't we take
> the change that did the port instead to make this easier to maintain,
> otherwise we will be hitting this problem constantly for any changes for
> the next X years that this kernel is alive.

Agreed. I queued e9b64fae44be ("hwmon: (lm90) Rely on subsystem locking") for
6.18 instead of the stable-only patch. It applies cleanly and leaves lm90 with
the single hwmon_lock model that mainline uses.

Jean, thanks for catching this.

-- 
Thanks,
Sasha
