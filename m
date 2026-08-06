Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AF2FD696;
	Thu,  6 Aug 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984289; cv=none; b=tq9hyPjwBBg+CCGt96auF31oXXfJrkGy7UCXxSSQ28etw4lwa46eryxso2LfFa7RXnXV6AGwFcYFQce+Lhnv9UTlcXs8gmCSvJXI+ZhMvJ3YOzDkS35PwIfGk9RZIKkESdaWSSAx0AQ9+lOz8YrtuVTOX6sJG9D7ATpY67dnUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984289; c=relaxed/simple;
	bh=dlqyYmVKeqyVIUQmPyqZFyzV7xRFXPloCZDvdepy43U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MpKIiwaRzYFxQjYgGOjigp01z7Ml5DvkZTZuXQ7cF/YHSthwE1x6oC/5Tsb8he8xFhv9p+rCGTgl8s9/cKNSuhOg/xcBpgt3cSq2ZRT3vrQ5LO2PmUWeOIF5yRleyeMpE9JvdBKKsGfcmylH6LLY/myV/b4bCF0m9+qnbO5Yx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqiB5cci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqiB5cci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6671C1F000E9;
	Thu,  6 Aug 2026 02:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984288;
	bh=CiA7EOsZf1u31c7ZK2OS7J7IWSJm/ecqwp0+2UUVfkM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XqiB5cciERKd1+gcdfpX74rbCDBckILJJE9lwPZPccRKQgjift/VpL1v0JTXaGGzu
	 6KAM29U4nZ7sjk7OrvdBVIlxikf/Wabx12MbVUWNxvEXZBduyl98FTw4aGEew376kf
	 JV6qfQ0Gdf5jmBqw6OyUfoDj8BmjP7Mb2C5E1Ucprv8XsMG6hfq0zp9GOqmLgY+Qwq
	 Dlhkkc/+ByT4ikQtiBKDFS4XQwWzHM9r5ASJJIGAHFpcMZo89bbQP+WmKmdbCfl+Ch
	 89Ynv1386dJqJPTrM+y5+RMX7Mbbg1f1vwYjAF9JpyADCvNaLfY5oyGFIsvtasN2OW
	 5fzeDubkwkeUw==
Date: Wed, 5 Aug 2026 20:44:46 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Peixin Xie <peixin.xie@linux.spacemit.com>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
    Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
    stable@vger.kernel.org, Sunil V L <sunilvl@oss.qualcomm.com>, 
    Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v3] riscv: acpi: Handle LPI architectural context loss
 flags
In-Reply-To: <20260803-riscv-acpi-lpi-timer-v3-1-520fa13732f5@linux.spacemit.com>
Message-ID: <e9ccdf60-481a-39a3-f0fa-428f47d838b9@kernel.org>
References: <20260803-riscv-acpi-lpi-timer-v3-1-520fa13732f5@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Peixin Xie wrote:

> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
> 
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
> 
> Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
> Cc: stable@vger.kernel.org
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>

Thanks, queued for v7.3.


- Paul
