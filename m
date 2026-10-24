Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852017;
	b=jLK67UqO+dAzIkwyTkcS8Qh+kZhyPuCDmWoEbZ77Rzos0e7OiO7DmGtVsEm6K9uJCxO3
	 gacbnzKEhWqgq8l/hyQQ+E/xmfkpCCawAfZKRZCyjp4eEiZBD+GB9Um5Ey3Uj4U6Lkets
	 5n+c4+MmfDqWkZvojQtusvj6VYivLzR6X/PWWhE8gurNNTll9v0qkiLl6AdvrB56P+lqk
	 S29ZbtkOYAD4+GReULgrWlQZ7XYkKZ5r2CdtZTgKSp+nYaGioMRs+OCn1HFY12yjyEyiN
	 m9izBMm28FKelbrUtuEKhLPjATqW248FflD3uecYs/kYXJ2ZD1fkkI1/aNoPnIhfo1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Aw9CyRwXWhjuRQErrwHfSvtvS/PCUmiVKLi6tpdKac=;
	b=jUqeKseB/GQYyIMAjK8aIj33vMSbQSkt5tT78k37vKTMw+l38A4yxWLSeG/aSMbUCUDQ
	 4gJCb624SbuQ/3rZFIbKm1O7CWvi3+B6ZNvfZrE2O6VDgE1jmAWvsPCM2YorYQlhvjL+g
	 ovFFQXe4Q0FkZx9HOJVL3JEjiUADLI/qrv4Y7My+liDZd009VHq2KSPMyF2Gz+NOiA9kz
	 CvU0C2Lk3m4BbnEawuaGxCpmnZHZaojpzMitq02xYJ9RdDbSr1Hw5MNmTp8HxzOkiTtlW
	 KZAcFSwKMyYhrQbV7DJWQbn2UnhSnJoPbdJ4JH+XGWZqgyXuNHFBG33RYqxblHY3eIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNcZPZI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3F606A31A;
	Sat, 24 Oct 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNcZPZI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F112E1F01825;
	Sat, 24 Oct 2026 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792852016;
	bh=9Aw9CyRwXWhjuRQErrwHfSvtvS/PCUmiVKLi6tpdKac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNcZPZI0/QIZzVuWY+3Vcgvb+TW90UO1ysmml3yCkf3DwG5m3zZAXQ/KpzwNufAvv
	 Z+oCfHgSNVWawBBRehmk2UsU7ttqyswnQ+cWuVHPU91MCTPEyLZhuz0d8sq+cyoy5i
	 61lEUqTEE7bAsxVJlZsXNKuvTYBZ3oR4uILAoMBcGNDSCeDncG9iiZxTob8egGKV79
	 eoTkZMrw9Gj5FxwcqNy58+ayTGgZxNz4V+G3NJzT9KhgOrcsxf56AWVOOjCyXuMnav
	 N7KlXld05FEg/incPdb1S6+h8C6PhDc3+6Ou3EpCMiLRyokAGIhvVD9zT4xI7iANXn
	 P+3fAPNeNrXnQ==
From: Sasha Levin <sashal@kernel.org>
To: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Date: Sat, 24 Oct 2026 10:26:52 -0400
Message-ID: <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
References: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
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

> Suggested fix: backport f4203ec64e11 together with 52d864019636, or
> revert 38c79dacc806 (and its dependents) from 6.18.y. Note that the same

I have dropped f4203ec64e11 ("ACPI: tiny-power-button: Convert the
driver to a platform one") from the 6.18 queue. It cannot go out without
ab06eb920401 ("ACPI: scan: Register platform devices for fixed event
buttons"): on its own it would break tiny-power-button on systems with a
fixed-hardware power button. Greg dropped ab06eb920401 on October 23,
together with two ACPI resource-overlap patches that broke the 6.18
build, so it is not part of this release either.

-- 
Thanks,
Sasha
