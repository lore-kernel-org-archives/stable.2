Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3A3ACEFE;
	Mon,  3 Aug 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779116; cv=none; b=t+LJLIuXUush58KCiqYliMr2AQpvcnwy1xfcN2qDjaylSnMcjPD4h15urFiiXbl6ya/o7hHufuhXjoGrSQpIGN8OZUHs1+kif0wDNIHK26xqoU5r6fc3rbrTkQBZkAu19qn7CloYt/YWBCOORIIPcKrYTxcKMMvZGZ+rjYbPNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779116; c=relaxed/simple;
	bh=zXA2ATgQTPB1ju5czj56/Tz/TUIemGsEmQpiCv9gQA0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lGl8aR2SQ5A77gu5FgFoGrQkd9Sw1TkdaH3XEb/LlUhHe04fW1Mto693+4CzPOzh0qZNhqezyP4AvRtTRLx95zVI8LiY3bdknwVex7nccWCYcgFGc1E38QG7UlZiW3CjRIafo0Y9toTDswhk+up22kt+HdNPEWr4vASMHVeJYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+GbrKPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+GbrKPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CF91F00A3A;
	Mon,  3 Aug 2026 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779114;
	bh=mGBFmHNfBUGTqGEWJcOo1gT6ZzC8uqhNtXHM0AWf7lc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=S+GbrKPcQkp9c++V8V2V5J5ZwCNP/QrZkRR1jdIOk5qEYf19btttI1fqmzj/NKUFv
	 kY9tYCPK49JFpT8oBD0yncCNQYtj6zB59Ngq70zPvwEAMUj2CkJ/j8rM/+ZrRhfUvp
	 kk0xsjhLQrEIb873Mz8E/qKHhB53r9cKKctPxLoY4K9z0QGOEdMt8PYngQVinjVq78
	 6NwkuYO6RBOYi2gzfes9Ft3elJmD5+Gr6igu5KgPyya9AyN6hQrNO07iQS1Hs55OfW
	 5bE/rvDFecItQ782B+paTBOoiTbh4EJuEXb0xDOKS+yR6KclVK2l6/ijO0dhpjrO/0
	 ifzZfMzwwM39Q==
Date: Mon, 3 Aug 2026 19:45:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report
 size before copy
In-Reply-To: <20260717091622.1744196-1-sammiee5311@gmail.com>
Message-ID: <6r18qns9-s199-01ro-np6n-0s95378r0o5n@xreary.bet>
References: <20260628133717.941389-1-sammiee5311@gmail.com> <20260717091622.1744196-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Jul 2026, HyeongJun An wrote:

> write_cmd_to_txdma() builds an output report in qsdev->report_buf, a heap
> buffer allocated in quickspi_alloc_report_buf() to the device-descriptor
> derived max_report_len (a few hundred bytes for a touch controller).  It
> copies the caller-supplied report into that buffer:
> 
>     memcpy(write_buf->content, report_buf, report_buf_len);
> 
> The HID core caps a report at HID_MAX_BUFFER_SIZE (16384) by default, and
> quickspi_hid_ll_driver does not set max_buffer_size, so the length reaches
> the driver unbounded.  A hidraw SET_REPORT/SET_FEATURE ioctl carrying a
> report larger than max_report_len therefore overflows report_buf with
> attacker-controlled length and content.
> 
> Record the report_buf allocation size and reject reports that do not fit
> before copying, matching the equivalent guard in the intel-quicki2c
> sibling (quicki2c_init_write_buf()) and the hid-goodix-spi fix.
> 
> write_cmd_to_txdma() writes the output report header ahead of the content
> in the same buffer, so size the allocation to cover the header as well.
> That keeps the added bound from rejecting a maximum-sized report.
> 
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> v2: Size report_buf to cover the output report header as well, so the added
>     bound cannot reject a valid maximum-sized report (raised by the Sashiko
>     AI review of v1).  No other change.
> 
> v1: https://lore.kernel.org/all/20260628133717.941389-1-sammiee5311@gmail.com/

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

