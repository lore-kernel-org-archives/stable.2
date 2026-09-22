Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D195616A9;
	Tue, 22 Sep 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091551; cv=none; b=NkNhqsEqgHnzo03Zj2n3q9AIq/k48vwKbxCDytK+Iedm1dqizTuKBDQYzJjqjR0MeeQojyG+v7NOxVAOuxu0eIpLlSgw1x9pa8u6FKNQQM8tP3i8R8t8APSBW4/F1pceoOJYxvvf8dJFoRRKYNCckzSK6VSTU4m/XI+puMQJIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091551; c=relaxed/simple;
	bh=J8gtASVf2ZCBOhs0YoN57vOdmTFG9Wz0oy8DfqcXF9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUPnWAi3PMrdhJ1VohcV1K2At9oI63SNqBPQvCxhPvUCQPgAcxZY3d7OCAah7FSnr/ojPCdpfIONr+OnIbZRc9bnddspMr6eN55cmYEtpaULAn8WNVcQBwxgrl9k5Wf6yIQ2A7txmiatD4mTrPLYniI866cwRww2ypQSCnQfnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ZJxzn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ZJxzn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF811F00898;
	Tue, 22 Sep 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091550;
	bh=PjgypYmRhAqvP/YXsH7ILQ63kUcsnyoWe+qNLLaPITo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7ZJxzn4Cb/hn2ax8mPwh5TNt4r1LbBytJy1vHc3Hlv6GpffcVElv42SZnAefAY6V
	 Dueba0OkBtctne2seDwJRHaErBhlBt+eyOl3FIdc0yrW7IFIEbgYmP9Wj/SYkGKhH2
	 zKAPRAD/gENoi323TgI/qeW5EW/6jwLzfvd36UUcXxQzJyz/wIH0Qq59I9heTu0O/c
	 yObgAOuMT0JsG2Qjr8lCYQm55FjDklw7ENkIHnztusRHWQGxsCB6fo7/wqiHN6X6Nr
	 f2+hHwVC8dA9uXzilPuPskOKQ15t/5LpT5Fbl1UJ4XC9a8TZoG0NT1ZuKOMacUEoGZ
	 aWGAF6NYteW+Q==
From: Sasha Levin <sashal@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-input <linux-input@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Grant King <gking@serow.io>
Subject: Re: [REGRESSION 6.18.48 -> 6.18.49] hid-asus: ROG N-Key keyboard dead, also in 6.12.y
Date: Tue, 22 Sep 2026 11:38:58 -0400
Message-ID: <2026-09-22-daily-reply-0005-re-hid-asus-nkey-regression-report@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74>
References: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> So either revert d0754db7883c in both trees and rework the hid_is_usb()
> fix against the old structure, or backport 0919db9f3583 alongside it.
> The revert looks like less risk for stable, but that is your call.

Your diagnosis is correct, and thank you for the report descriptor, it made the
-EOVERFLOW unambiguous.

I went with the forward fix rather than the revert. Antheas named the right
commit in his reply: e82ae34af29e ("HID: asus: fortify keyboard handshake")
raises FEATURE_KBD_REPORT_SIZE to 64, so the GET_REPORT for 0x5a is large
enough for the 62 bytes your controller declares and asus_kbd_get_functions()
stops failing. It is queued for 6.18 and 6.12.  Reverting would have meant
reworking Jann's hid_is_usb() fix against the old structure on two trees, which
is the larger change of the two.

You offered to build a vanilla kernel and test. If you can confirm the keyboard
comes back on the GA403UV with that commit on top of 6.18.49, I would like to
have that before it goes out.

-- 
Thanks,
Sasha
