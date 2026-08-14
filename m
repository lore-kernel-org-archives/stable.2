Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67A33998;
	Fri, 14 Aug 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715862; cv=none; b=LwUc0wkrOUp3p5dwNYvnXWn6kd7Vl1g3iNRfq+YiY5KDNTFbeqjV18di6ey06yIMY0uSTc5ItPhSkYtd4/vtTtpQP+HaRVSpg6hesqPFMynIf0mBuRZzY3+GVqvXXrHi3GHcDw0UADvrsLPSIDX9RLilbzhMilG2fKNMXGhJbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715862; c=relaxed/simple;
	bh=E/2f2TlfNMOrVKU2clZnHFHA2uiMXq3C9GevSB2akrE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VJYrg8j7lyg4qfpaFYaQEPlwgieArjliF+bpiQgkYAGJHwVXOsB21Em6MMd2NvGkp8R0mDH3sgTpPKuhkT/7VfS4Pq1SXsOp2m1uO3yqTfA+WbBih6XgFBHBOnRnrgFqh+uRwflFbjIGSf1qWgKta1Gzw2UIVhmiZ1GYZvw1oJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6n8zaLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6n8zaLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807531F000E9;
	Fri, 14 Aug 2026 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715861;
	bh=NP8z+ESGjMEtKt8r9GOcL0yI7hvXgD6vPTVZp3mQtck=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=W6n8zaLzkAPSDvi5c75PAfiQASrwBtD+O3LdCf3Am96ygJ0MziBHi5/z09Kn+eR64
	 Hj2qfw6mThOve6pHNiaS9LphaZo/7/jdDyeKns3jDgKDSl6J5MMq2tOoSgadYZQZFJ
	 8FpvJtx295qlQRIFy74+1/DRpxbixEmoQKFKP6Y9WAvXCmXkxi42a5W8CIXVwXIfI7
	 hfqeJ2E5mf7tenkljNYCkb6iRUJXfNU2EOVK5pGsuIW9RO3jKGq53+v4owJJBumDZZ
	 ToedG8dfQJ0U5wn98prPAwOLFOW2rGnTtRRg4MP5Ux8h5VJMmA+S2rqAIbBJnDY/iv
	 louJbrJ/U4/Dw==
Date: Fri, 14 Aug 2026 15:57:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: sensor: custom: Fix use-after-free in
 enable_sensor
In-Reply-To: <20260707071545.3087073-2-haoxiang_li2024@163.com>
Message-ID: <r48p57s3-5prp-3rro-oor2-499271s8s52o@xreary.bet>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com> <20260707071545.3087073-2-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Jul 2026, Haoxiang Li wrote:

> enable_sensor_store() can call set_power_report_state(), which
> dereferences sensor_inst->power_state and sensor_inst->report_state.
> These pointers refer to entries in sensor_inst->fields.
> 
> Create the field attributes before exposing the enable_sensor sysfs
> attribute, so enable_sensor cannot be accessed before the state it
> depends on has been initialized.
> 
> On remove, delete enable_sensor before freeing the field attributes,
> so a concurrent sysfs write cannot dereference freed memory through
> power_state or report_state.
> 
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260623021950.1736413-1-haoxiang_li2024@163.com?part=1
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

