Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C72E414;
	Fri, 14 Aug 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715504; cv=none; b=XTo2wRVLTFGo7q7wNkXr99V8zETPwIS8dL8C/8ZemwPrjxmDBmjfFvZb/RwF7Sw8a91bQpPgpVey17RD/KK7N6/exu7XRFCc1Edtx0EsTHqHMMVTVNFc48rUgGDIB3Z2sev3Os+6hWo/HHZLuIxOYKyv1xbOQfOJsWmmn1tXGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715504; c=relaxed/simple;
	bh=E7H1ojTyUX0fYUbQROAiYtU0SVZ9ansdWsy7rQb/FRM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JLLxrW6CFpLy5M/MIzhIF8CqbFx9UEt1pDRc1z77nhvN5pVB2t9II5HuBhyqjESTDLb3BeYPyVwU/3Kya2hmmz1vvpXH5/qqsidn6cbCkEQ1ZtJ1dgiXW7ua/e9zjYO78dBdWCTG1cV3u1No/z26dlkE4znfg3c9j/SmCQsB3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPbPXuS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPbPXuS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BEA1F000E9;
	Fri, 14 Aug 2026 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715499;
	bh=j2AywTzHhtcAnP7j4TL7RZ3klQseKPpqxzrbU1dAtmQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QPbPXuS9X+DUwDge/oAhDOQu2MgyKFVx44U7rrAberY6tF4X3WqrjKZjQXaFMRInl
	 KEMQYmDXd/p3CWCUl3mv7yICdzppwzOgP3IIRzilnIDEmmu4jrCxXHCGqyb2BvVxNE
	 Icvie4FZ/X45Ziu1F7g9gm0b9G2Zz2PDlAbhOvclU5rbNJOz991I3nehXmcwWznduh
	 pno0retE3WRJeGfcBq/qz+BvP3zXffI/bFrmWTP0Mswzfe2xJPOxN76QNLWKGvMB+4
	 Xm3c0LIIYgzFMcO7zNYCICPWXaOAW1c969zR2uS1mhSPJHClPTNSJn98FUaVevsWBk
	 Vp4EjwK8Qo18w==
Date: Fri, 14 Aug 2026 15:51:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
In-Reply-To: <20260806145619.3386809-1-sammiee5311@gmail.com>
Message-ID: <7172o4o0-nr26-rpon-65o0-64n84q2rr489@xreary.bet>
References: <20260806142321.3383353-1-sammiee5311@gmail.com> <20260806145619.3386809-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Aug 2026, HyeongJun An wrote:

> quickspi_hid_raw_request() receives the caller's buffer length in len, but
> quickspi_get_report() never sees it and copies the whole device-supplied
> response into buf regardless:
> 
>     memcpy(buf, qsdev->report_buf, qsdev->report_len);
> 
> qsdev->report_len comes from the input report the touch controller returns,
> while buf is sized to whatever the caller asked hidraw for through
> HIDIOCGFEATURE or HIDIOCGINPUT.  A response larger than that overflows buf
> with device-controlled content.
> 
> The intel-quicki2c sibling already passes the caller length down to
> quicki2c_get_report() and validates the response against it before the
> copy.  Do the same here.
> 
> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
> Suggested-by: Sashiko AI <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

