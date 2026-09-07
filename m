Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339722D24B7;
	Mon,  7 Sep 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787932; cv=none; b=CkoX8z8t4jEy2MgerDHlTIdimw/5KI8cvHjl/M1y7T9FgsxwgE8GlWWJ2UlFAcyMmxeU+2XoL2ZC70cywvPtOuc7y5+6Xl6bM1yySjW/rht9KIAFOzVZIHhXnWHHdk4Efwp2JYXlJzRRS2qATsEQtwCQiGI8lEP4BebItXeuw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787932; c=relaxed/simple;
	bh=LNgLVh2LEyFp+dxb/P6eP5bhbpkGuM2YBO7SGAPxfM0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OsKqBuLzAQPUx0HmAvltK2IeCTj54ugSRz45Z6DDtIfjNSooJYCu+yfvNesckd60g/K2YH1nERGIrq+7O6T2VseJ4P3KUdR7bkNWP+06g6yug+TxryGicBTQAdIs7TgXIVnCld5jx2cTYUrf9477r5YCMp2WWAbklTWa+OwIfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0bOJ3Hz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0bOJ3Hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD581F00A3A;
	Mon,  7 Sep 2026 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788787930;
	bh=jwSHrTCT673iDqk1OZB0BpbsW42n919ohX4bCR7DJGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q0bOJ3Hz2J0IDwPJq+HS9oEw+u7m18d8cyjSSm80x5kFWaOe7wG7hlne5ezo1kX02
	 z9h0UeG1FpaWsa3nlPD0FBSkR9dpE3GIABolpRS1cGuK1w1Bej8hKr/nZl8dDHZBB+
	 UA/aTuttYlDXlbIEPql+OrYKAEuH1AF0kzQz6KHMRaqAhxhFTb70X44ubpRtk6LB59
	 s9wKCCTp2ozlmM0/1FAkxzHfqSYNvjFpcmNf90Iqi9sLnr8Qz97kImdbuh01TEf08g
	 GeTwgCzhIK/9dYaWphMiV/S3Bpv0JLICiLJBa7IEwrj9GARQM6vSYnmFT1q4RHwJPr
	 HniLgnhCDoAIw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Junjie Cao <junjie.cao@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marco Carvalho <marcocarvalho.web@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20260824031419.316315-1-junjie.cao@intel.com>
References: <20260824031419.316315-1-junjie.cao@intel.com>
Subject: Re: [PATCH] HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION
 gaming keyboard
Message-Id: <178878792895.118170.7245212292320678316.b4-ty@b4>
Date: Mon, 07 Sep 2026 15:32:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 24 Aug 2026 11:14:19 +0800, Junjie Cao wrote:
> The SDINNOVATION gaming keyboard (USB ID 36ae:feab) stops reporting
> input events after its RGB lighting mode is switched about twice.
> Disabling USB autosuspend and unbinding the other HID interfaces make
> no difference; the issue does not occur on Windows.
> 
> HID_QUIRK_ALWAYS_POLL alone resolves it, verified on 7.1.8 via
> usbhid.quirks=0x36ae:0xfeab:0x400.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard
      https://git.kernel.org/hid/hid/c/cdb669a3b8f8

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

