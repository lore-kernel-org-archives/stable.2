Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E33939DE;
	Mon,  3 Aug 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779606; cv=none; b=tq0QebuyeSOSit1skNLScCx3snLRMzqG2V8W9lsfC6Ki5a7ANppfwefxSp8rX9SRWnFwZTo/aNajKDsS1LZftHh+hgxPwVu4tAo0NPT7th3JuUpmTO/TmUy7If/54YEkDSZ8obnsWLdwfhNZwNtIRgMkORPhSNda7/LqQN1Wn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779606; c=relaxed/simple;
	bh=KC4jzyV18aH5jLT3s0LJ/V7gNKedg6Xf+Wmrp1qX4dM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dvBE8cSVHrjxiclgmFqxE2Q45QEcFVqgjk9ApJZrRt56/ePRcY3KLpLrUl3PFW3YoJjlEqZD+cCUjOZuntUM1XvmGehFt9lH68ShUnGeJ1eZT9kabodL3XXzyNCCWanpK1Y0OmQCl+PWroyf6Zx9NWvVMna4nkwnGThltyKXGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0lGZ8qS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0lGZ8qS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EBC1F000E9;
	Mon,  3 Aug 2026 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779605;
	bh=BEI9gv9XuoWaOV5/tFo7a/2PVn1ghLCs3P8wnkoWWkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=H0lGZ8qSBy+MS5xb6DBwEFErjRxfTph/e+lsWjjVPLxtL/KS6O0pLsrT+Fa9Xcq5n
	 kPbdpaC8teKWPPnAhX6VmXiqus1VyhVnDQR41mV5JkJqaFQg9qiING4u9DXvn959QD
	 g6YgRtsxZumLtjuhhWsadZBz4FmJWAdVpOE+88Mn36Koip0LuBtBUOeWFQUEYhuXne
	 SKL9sdZJIjOVxOJfXw9MKUpJVSNyO1XSV2j2uxAZtoBHuheRq0z5txev5n2RQykWKj
	 gea7CVXysasdNLKVYvEaklpFxtRNvACW+kLic+gnSDjfcJLt0WxYE/CDr2wohCIEhR
	 QnYAPChtrWjtQ==
Date: Mon, 3 Aug 2026 19:53:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: fix out-of-bounds read in
 joycon_ctlr_read_handler()
In-Reply-To: <20260715115253.91029-1-security@auditcode.ai>
Message-ID: <o01s84o0-so32-907p-n0s2-p74r36210n22@xreary.bet>
References: <20260715115253.91029-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jul 2026, Ibrahim Hashimov wrote:

> joycon_ctlr_read_handler() casts an incoming HID input report to
> struct joycon_input_report and parses it, guarding the cast only with a
> 12-byte length check:
> 
> 	if (size >= 12) /* make sure it contains the input report */
> 		joycon_parse_report(ctlr, (struct joycon_input_report *)data);
> 
> struct joycon_input_report is 49 bytes: a 13-byte header followed by a
> union whose IMU arm is 36 bytes. For an IMU report joycon_parse_report()
> -> joycon_parse_imu_report() walks that union (struct offsets 13..48),
> so a report of exactly 12 bytes with data[0] == JC_INPUT_IMU_DATA passes
> the guard yet is read up to 37 bytes past its declared length. The
> over-read bytes are decoded into accelerometer/gyroscope values and
> forwarded to userspace through the "(IMU)" input device, leaking
> driver-internal memory. data[0] and size are fully controlled by a
> malicious or spoofed Joy-Con/Pro Controller.
> 
> Receive buffers are sized to the maximum report length, so this is an
> over-read within the allocation rather than a slab OOB, but the decoded
> bytes still reach userspace.
> 
> The sibling subcmd path in joycon_ctlr_handle_event() already bounds the
> same cast correctly:
> 
> 	if (size < sizeof(struct joycon_input_report) ||
> 	    data[0] != JC_INPUT_SUBCMD_REPLY)
> 		break;
> 
> Use the same sizeof(struct joycon_input_report) bound here.
> 
> Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

