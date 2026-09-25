Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC446D0B4;
	Fri, 25 Sep 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322364; cv=none; b=ngQfWsSe7RTmnPrf44asFd45ymPWVVGyg3EbIKutovIqpSOcydFb2egL33QQvfeu0WZMYA740QO0u/8wUTqXBUvm4EEnZO8IQqINMTofv2m6cHy4qH5iRXlL+Pd8Ay/NmPxakrR+WgUeTtQbKihADoMtg6sKGf39q+saF77tX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322364; c=relaxed/simple;
	bh=riYq6OKMYegM1B0GVCH0DJyK2fe3mY/rTPYTYYmVUro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZSXK+un9cO/wvsb5wf4TZbCobF6Oht2NkjcMU+9kknvVhXPiieale6sM2KUU57kWsXRYVYzgLuCpCs47pMz8qrVwFYC6Lt1m9QkU2EbhDOGBrpL03Sxubh2R+ksvZYSWQaduEUHrlVb7pD/DO3Y+YBdsDZHROCQSPAXDCSmtTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxCIJSeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxCIJSeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27451F000FF;
	Fri, 25 Sep 2026 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322362;
	bh=fgp57Y0foq2G1j/7LLzFZqIU8Hc1ayNJsYPGWIzRsfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LxCIJSeMqhoPioUankmKaNl2HWqPiEw9oHZCqMKvK0/LShJicYI6q9WFH/rDMz8QW
	 AaMeJPrRxZDdYkpH7ZUaxQuAcNJ8LaN1VibtFu6BpW7KdR0uohl0O+nMI3OS/QsSGB
	 rPCK7mFl9lYZoW92EkV+LMmU4hYbHhbiiBj1eFtpGG1CmkKJ5NJKOuR0X9jhVdKnb8
	 cPfEnwLSR95Grj1DzM4P7q/Oj/53gJhih7Jh4MTlZrV7O6U08Gp3djcMWfdVqIZ/a0
	 ERRfZ+HMRQKNrM4ac23/Q8V2m1SVFwfQeEWlwkKdclvZKjseHl7dOuqdTtDWS+jQTo
	 d6FYaPMLURbDA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
References: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
Subject: Re: [PATCH 0/2] HID: bpf: add one ssize_t check detected by
 Sashiko
Message-Id: <179032236044.351067.2844140440422327024.b4-ty@b4>
Date: Fri, 25 Sep 2026 09:46:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 15 Sep 2026 17:46:56 +0200, Benjamin Tissoires wrote:
> Sashiko detected an existing issue in hid_bpf_hw_request:
> if the transport layer returns an error code, hid_bpf_hw_request
> returns success, which can confuse the caller.
> 
> Add the actual fix and a selftest to ensure this gets properly passed
> around.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/2] HID: bpf: cast size to ssize_t when checking hid_bpf_hw_request
      https://git.kernel.org/hid/hid/c/3afefbfe55c2
[2/2] selftest/hid: add test for negative return codes for hid_bpf_hw_request
      https://git.kernel.org/hid/hid/c/3f35b678a1d6

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

