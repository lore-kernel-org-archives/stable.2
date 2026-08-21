Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F6495515;
	Fri, 21 Aug 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320924; cv=none; b=adK8OZFnHaZ1ah9Ghg+adXMBIj0STaPbqZ9Uiu7CPWWDvHkIuXoWEioUIL0jIcpX9Oleyz4DBYQ0uNw3xZusR+Yga8WXgU0dLiX14l3JYVuCY+YPTjNxwXzRPHM2pFlF8yGJ3u9GurQv329V7QXlC7ojRwf0FX3C2J5n80ZuUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320924; c=relaxed/simple;
	bh=++d9mCMwjnMXWCHic16LQXHvDDypmgfWeNueyJz6v0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DBvQmnCakvGUAjFO3SFFWlqsDBQerm7rrFJPCdV4bVyG0a7/77V4RxBH1YT5XcowCn51c0P3JqG++vZLSCbKfoxum8vqXST7b1PIEMHzQrRMePV92VPbdH4QsS4Zk9EPa0sX/2FexjG11OJPPjxxX2XtXGU9AaMT3CyzRMVe0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7TBD9nM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7TBD9nM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702E1F000E9;
	Fri, 21 Aug 2026 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787320921;
	bh=cx2XI9PQp2DXvmn/DmA8f6SA3tqene5xWRQ2GfaQDeQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=h7TBD9nMyI/f9j1EBFWeOKHNQDjKqkYCGpO+BV6J9XLZRq/durf6/fWt2ucTK62z/
	 STwQP05mvd1gOrl/ORcIZq9yyLmXFxhMmR1NjHI6mf2pE8w+t0JIuNo15gNOXBXuXn
	 xjAWaqh1BBSpWUY9zvxKPKCQgeoyNTb9gSrHOImWV+VwLVSItToMfsfJwfz8ql+FEA
	 ujHOfr1Upv78/hqOvOlwOmYo84RMe3BkIgiDm1OlI/whFjvtuWA0vRG5KKrH+f5RNY
	 dNiCMavXpUyCmbvlTRQCwv5Y1+zJCbK5IOTVDHabah6mT3bk31SC+byjBuC3eDhEf1
	 Ech6AqnOU5nVQ==
Date: Fri, 21 Aug 2026 16:01:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: validate report length in
 wacom_intuos_pro2_bt_irq
In-Reply-To: <20260713093414.94337-1-security@auditcode.ai>
Message-ID: <o740son2-23s7-7r26-r4rn-qnqnoo37026o@xreary.bet>
References: <20260713075110.92469-1-security@auditcode.ai> <20260713093414.94337-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jul 2026, Ibrahim Hashimov wrote:

> wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
> but never consults it before parsing. After the report-id gate it
> unconditionally calls wacom_intuos_pro2_bt_pen() and then, selected by
> features.type, a fixed chain of sub-parsers, none of which receive
> `len`:
> 
> 	wacom_intuos_pro2_bt_pen(wacom);
> 	if (type == INTUOSP2_BT || type == INTUOSP2S_BT) {
> 		wacom_intuos_pro2_bt_touch(wacom);
> 		wacom_intuos_pro2_bt_pad(wacom);
> 		wacom_intuos_pro2_bt_battery(wacom);
> 	} else {
> 		wacom_intuos_gen3_bt_pad(wacom);
> 		wacom_intuos_gen3_bt_battery(wacom);
> 	}
> 
> Each sub-parser dereferences wacom->data at fixed offsets. The furthest
> byte touched on each branch is:
> 
>   INTUOSP2_BT / INTUOSP2S_BT: wacom_intuos_pro2_bt_pad() reads data[285]
> 	(the touchring byte), so the report must be at least 286 bytes;
>   INTUOSHT3_BT ("gen3"): wacom_intuos_gen3_bt_battery() reads data[45],
> 	so the report must be at least 46 bytes.
> 
> features.type is selected from the VID/PID id_table entry and
> wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
> for that type independent of the report descriptor, so a malicious or
> malfunctioning paired/spoofed Bluetooth peripheral can advertise that
> VID/PID and send an undersized report that still satisfies the
> data[0] == 0x80/0x81 gate. The driver then reads past the received
> report and forwards the bytes to userspace via evdev (MSC_SERIAL /
> ABS_MISC / ABS_WHEEL on the pen and pad input nodes), an out-of-bounds
> read with a concrete userspace read-back channel, and a true
> out-of-bounds read on transports whose backing buffer is sized to the
> (small) report descriptor rather than a fixed-size staging buffer.
> 
> This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
> out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
> sibling wacom_intuos_bt_irq(), which guards each report id against its
> minimum length before parsing.
> 
> Guard wacom_intuos_pro2_bt_irq() the same way: before parsing, reject
> reports shorter than the furthest offset the selected branch actually
> dereferences, warn, and bail out. Because the whole pen/touch/pad/
> battery chain runs unconditionally per branch, a single up-front check
> against the maximum offset (286 bytes for INTUOSP2_BT/INTUOSP2S_BT,
> 46 bytes for the gen3 branch) bounds every sub-parser. Returning 0 on
> a short report also skips those calls for the same malformed report,
> which is the safe, conservative behavior.
> 
> Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

