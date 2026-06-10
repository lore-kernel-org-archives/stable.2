Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1301230BDB;
	Wed, 10 Jun 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116372; cv=none; b=rjqzav8xDgEhlqsOkuCDZ/Z+VRYpRrRPvGk+2mWVsc9bhJ6GxQyUOvyyReY/TwW+QFhP7Azp3xuH2+5/CjtR6zVtnqWiD2d9kV6j9Z+axqPpNtvF7Ic1FrobxmP88oeDAXMUwBt87bELkeY8a/ykD+0+oQQjDtHO8jAtgpCr/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116372; c=relaxed/simple;
	bh=QrrLgJmid1pcjdifn1cSMHyFkEv7i9QEuCmUJw9vzS4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o1SJv+WFEb3Bi22NKN5/NpqYplWpu+c2jqLZ90pZJytZSpW9S8p8V0Vyea9ozNeQPlHDtmzwBeGGRLKJR6N1QoPmOEA7VFgh4iDxnnwOlKGnTk+Rl6Oss/ia3VeTeKrmb7soHqrzpvS/IVM4tHmN8c9ew9ZWGcmb79O0edkPbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuwFyV4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuwFyV4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77441F00893;
	Wed, 10 Jun 2026 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116371;
	bh=dUGweDSziW71Yfh7+Ix3Xp/cFCJDme2uhYtUanaAjn8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=CuwFyV4iWtnjeemUsC4jMGcJ7JbQK902oozFNPkgrfXATD7IcJzmngQRwI1K0GhiT
	 SjnrvgZObZGFf/LJXiRDI+B2uxp309FE/Yg3A2FlDpC0YrrnmDIUbXYJmi8t+iUqlN
	 SIwW07u1wts6QEOmxL1FjsQECXHbdDqHSNTD/gG7PcJ9GP8ccUnGk92js9ojLWtVL/
	 9yye0QuEiPuTGyktwfmXXm7Q6HMYDZfxyOPenkIkLJT1hKo2ZOi9aEHza4sFveT+LI
	 p0tks5fDaBNBASb41OaLUfO+qpB42+6YqPvweVzpJfNIbbPl5OJMKxDa0wA+kqMwTS
	 XuNlcYNaMSOFA==
Date: Wed, 10 Jun 2026 20:32:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
cc: David Rheinsberg <david@readahead.eu>, 
    Benjamin Tissoires <bentiss@kernel.org>, Lee Jones <lee@kernel.org>, 
    kernel-team@android.com, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, 
    "open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: uhid: convert to hid_safe_input_report()
In-Reply-To: <20260606181552.3095967-1-cmllamas@google.com>
Message-ID: <62ps4q24-o804-35ss-8pqn-8n32pnp7sr32@xreary.bet>
References: <20260606181552.3095967-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 6 Jun 2026, Carlos Llamas wrote:

> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()"), added a check in hid_report_raw_event() to reject
> reports if the received data size is smaller than expected. This was
> intended to prevent OOB errors by no longer allowing zeroing-out of
> shorter reports due to the lack of buffer size information.
> 
> However, this leads to regressions in hid_report_raw_event(), where
> shorter than expected reports are rejected, even though their buffers
> are sufficiently large to be zero-padded.
> 
> To solve this issue, Benjamin introduced a safer alternative in commit
> 206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
> forwards the buffer size and allows hid_report_raw_event() to safely
> zero-pad the data.
> 
> Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
> the buffer size. This prevents the reported regressions [1], allowing
> hid core to zero-pad the shorter reports safely as expected.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

