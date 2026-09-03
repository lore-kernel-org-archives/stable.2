Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA24A8A09;
	Thu,  3 Sep 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439257; cv=none; b=KKnNlMReRycMPSpqW4hjmTENG2U4T9EFmrnb1ZCiq1gwXkjhrpYdG1PR0to5TDETK9pVAQZElZ+0p7UFgbkenoZKgcNANKp/YvbuagY/wXI/0j00kLicjIOK8aT8nMg/SZErhc4c5d9jpBHIRiepuLyI5MBlMjvage4+XIRXuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439257; c=relaxed/simple;
	bh=ZD3dQyJAxu0TJMKJm0s6MCvTM1Nx9fBW+1vG9yorNtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/9z44qyvsGJ05qE7/JiccF6coC41jBfDp4aWV7Oey0voBiOcPMCZmvQgNVrz+XiBKFDISfpFsb9uRz7mjB9++UZLaDmBvZ+lDcPBGX5iKAaglByUxeWnjnCOIrnkcAnjEaa85/+jUaO92Nzz5AiXyghm1imgBfYz11X73LS60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDDMp1wB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDDMp1wB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EF41F00ADB;
	Thu,  3 Sep 2026 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439255;
	bh=wdl9ZnhdN69qpVgnEuB/oxRMf60WEpbQOzfRFr3d1qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KDDMp1wBSOf9oB65PQQ1G0XijtsiUucEA9i0BzkxagOXeLVIrRhG4gY07keWEibSQ
	 UvA1/0xBmdHQAsWmMBMccq81Cz66WUgfDjdlxCB2WN/ADRrm4BOzIJBu6/aCNCz3Zh
	 oTtqxNqpmr7j6OgGX7S+c2TAZWIfHGqL7t1KeATtKoVdje2jiSMeyWFIrA6ifiCsMa
	 qQLoGWH2vKDYANtE9+db8sIL2HLS/XNrFt+PriR6ho5g7P8HzktH4B7jZqcQub14hI
	 pgI+wx2I4d3Y92zrv6NEpQa0sGmqlDDw/lZ29p2svZrPiLyCTdNtU1wVnMP1bNUZur
	 7Vu+uiGN82yLQ==
Date: Thu, 3 Sep 2026 13:40:52 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, breno Leitao <leitao@debian.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mailbox: pcc: Serialize channel updates with shared
 memory teardown
Message-ID: <20260903-solid-unbiased-hog-26c0ef@sudeepholla>
References: <20260903111328.805352-1-christian.loehle@arm.com>
 <20260903111328.805352-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903111328.805352-3-christian.loehle@arm.com>

On Thu, Sep 03, 2026 at 12:13:28PM +0100, Christian Loehle wrote:
> mbox_free_channel() makes a PCC channel available before the subsequent
> shared-memory unmap. Without serialization, a concurrent request can bind a
> new client and replace the mapping, which the old release then unmaps.
> 
> Serialize PCC channel acquisition and release. Keep the channel unavailable
> until the old shared-memory mapping has been removed.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
