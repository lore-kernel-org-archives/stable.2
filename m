Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66D489FB3;
	Fri, 11 Sep 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134282; cv=none; b=P3+ZRuWMwqfspqyE9GULunAZneNtxj0EQa8M/Oz3y8PT134j2zmOo6wHgvc9kp2NzOTXfZsuWdMSWpBRt7OkxA9zARrwc1fNGkHA2zceDOp1e0l9JA3F8FqLFk/1LvtPMmjEpQ7Ma/evL3Si44SzlnXEJzpMc4zkXNAQAGkWK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134282; c=relaxed/simple;
	bh=2HCQ0onCOv8t4cSd08pv7aUL7n0DeKsvmk1ezOK3lbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fxxn6duW/lm52xorvLO6bNMD+g7HQasHNbTp9nQBIrCPtch9ftoSyHv0QsG5g71zuNPBB1Qp80shgVzx+MtHZ4WdQkh0SC/Vs11FMbZezGO2fgT+rtUWjMl0oZqhuZxE98PmtOmgn9NXvHNLauOktTZxH4OdM6SUzK7M9yc+jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF9Gnvt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF9Gnvt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C351F000FF;
	Fri, 11 Sep 2026 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134278;
	bh=SlEKdTbVEoutjYOksHy3BUmRBcFogtPtsUCMkHNfLow=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=WF9Gnvt3RyqjxWIACb+JywubqoQswMfbwZH1ZlSuad6HozbtCij/3fxIUZO7g25XD
	 wVi24rfBk+XyDcQt5Jz8hYpy4nHWIYhx2TAgetWcdP38j4KjlU3fy2IHwZa45/ATHk
	 kyaY5DMLQWTqkis9XZh+dKhvWI7xf8+cAkNlgm0Km3iK0porqvVBoMn4mz8JHLRfKW
	 zk/eFqTAiK+4pPfXXKyBpzkr4OKUWkMRaaUOC6tqTMyiVvwZTulkYQ3syAoxRx/6Oi
	 6ROqRPE3W8pKmWD0C7uHyErVoj761761Mnw9l6BQd8FQ/PSOryeFKDng9ZvhepJET5
	 UY5kwW52Qz7pQ==
Date: Fri, 11 Sep 2026 15:44:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Wei Jie LAW <98lawweijie@gmail.com>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v4] HID: wacom: fix OOB read in
 wacom_wac_pen_serial_enforce()
In-Reply-To: <20260909011515.2314-1-98lawweijie@gmail.com>
Message-ID: <362p32oq-pp7r-44sr-s0ss-8snn6q9r04q9@xreary.bet>
References: <20260828033323.82958-1-98lawweijie@gmail.com> <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com> <20260909011515.2314-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Wei Jie LAW wrote:

> The 'wacom_wac_pen_serial_enforce()' function may calculate and pass an
> invalid offset to hid_field_extract(), resulting in memory reads at
> incorrect addresses -- possibly beyond the end of the report.  If a
> field in the HID descriptor lists more usages than its Report Count
> actually reserves space for, the function's inner 'j' will walk past
> the end of the field:
> 
> 	for (i = 0; i < report->maxfield; i++) {
> 		for (j = 0; j < report->field[i]->maxusage; j++) {
> 			...
> 			value = hid_field_extract(hdev, raw_data + 1,
> 						  offset + j * size, size);
> 
> A descriptor listing 12288 usages against Report Count 1 has the loop
> extract the usage at index 12287 from bit offset 98296 -- about 12 KB
> past a 2-byte received report.  The value is stored in
> wacom_wac->serial[0] and can reach userspace as an MSC_SERIAL event,
> making this an information disclosure.
> 
> Clamp the loop to field->report_count, the number of value slots the
> report holds.  Value slots past the last declared usage are still
> scanned; they reuse that usage (HID 1.11, 6.2.2.8).
> 
> Verified on v6.12.105 with a UHID reproducer: a 2-byte report from
> such a descriptor trips KASAN before the patch and not after it.
> 
> Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
> Suggested-by: Jason Gerecke <killertofu@gmail.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Assisted-by: GLM:glm-5.3
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

