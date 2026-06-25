Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC3CF942;
	Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384132; cv=none; b=WAHri6YBwrEDZuIGJ3si1mBwdsjsra1OBqq2xT0TgUCKVHg9NEGn8IIsrsn1drrv5vpxtJoWbFRKiAvNbOFJlxXEzc1OZgLXuW86KC2cRd33Dd+OxtkUx2+TVYXrZ31NSkmhxATItVvG1ztmxr2fLNZs3h8LrmDTF71/zXSit3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384132; c=relaxed/simple;
	bh=xYiaKsbHa4PJszD1tJWqPxsEZKpm9szbZV9x5R3aK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJevUMmATxplGPwFIOPHnrJHn71oPp9n3cSkf3x0ZJdoiZRdxXKjDlabwhVdBbTL0Ke6wv11x/zX/7O8jYOyeviTXv8yUdyQ7WZMvDRe97JjA202hXeYj3HiRVb8ZckjwbHzgrNw8JR6CsauqpUgDaaMnCbgWyQ32vzynF9q9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX503ZcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX503ZcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D621F00A3F;
	Thu, 25 Jun 2026 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384131;
	bh=xYiaKsbHa4PJszD1tJWqPxsEZKpm9szbZV9x5R3aK6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZX503ZcAO4QSK+tX/zaQ3UaiwBmBcnpJFnTnGGhZihwJZNcyJY+14k7w5MfMhWktn
	 43gNGELYh5RdMLzQqHBRQqLNQVMLGVBUmPQ7nVUSE+nOnp3nAWCpV/xyWr6N3IWBVN
	 R1JeXmvciZ9XgM5X+UD56iQa/lvpVcEoWagW7OMroRWvyQtX7uS01OflX1HwoZgEop
	 MbQBIklDm5xDmCexg6Y06pDhxRsIc/u1hKhfwiKkrRN2g3p0D+XAnFNWZD5QFnO9Y8
	 xf/8h0/9fWwbyKzRuZ5ynVmb+WoRxHYRvpvh9Y5mHLWs8YV0j62F6ynW3YsJvyRwDp
	 nd7tdVnPMJBtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yicong Yang <yang.yicong@picoheart.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH 6.12.y/6.18.y] ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()
Date: Thu, 25 Jun 2026 06:41:53 -0400
Message-ID: <20260625054005.0006.acpi-scan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624-acpi-dependency-thing-v1-1-ec0d99e5bf0f@iscas.ac.cn>
References: <20260624-acpi-dependency-thing-v1-1-ec0d99e5bf0f@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y/6.18.y] ACPI: scan: Use async schedule function in
> acpi_scan_clear_dep_fn()
>
> [ Vivian: Adjust system_dfl_wq -> system_unbound_wq in removed lines ]

Queued for both 6.18 and 6.12, thanks.

--
Thanks,
Sasha
