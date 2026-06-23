Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6513D47C5
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215724; cv=none; b=OWwyYFoWWJxJ946Cp692630ZABWU69UJJAEAtDRnkqevQnX70stFFr5AcQo2ybERBpFGUqmrwIXCS8MhJKTcR039ld53gbB1p6w8HK3FMvvkPyXL3hJiLtWEY6TYH9GjAV8qryIzsxe7Xt4aSkGWox8dd/vdqHXRNiRwjQnBFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215724; c=relaxed/simple;
	bh=h2Rwr37eMoGme/d9wKqtjK2U64WXg2RRslmQ/9OCDWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsVDWeCMvDkybRh/Rzb/Bn1QpLlsyQR189imwDw3mu3h9XLf0pcOzbo25zzIO4+BmPJH6g/Mq/KJfnmREC3ZAQvnvw9kQWyqhbbC4ebrnA7RJEBHeu6osOHNZNgeufFlpbnznOH3muwNIfu9kcuherer17zz5ctGer+b+J+rYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOSCPC+A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOSCPC+A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b613a17bso46093295e9.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782215721; x=1782820521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx0STp9J5MD57IIANrpjIDVf2U7oRAYtvaIvJeF38Lw=;
        b=NOSCPC+AdZS7XjzzPf3YH5zhsi6PcezFTVP9rr9WzHZNx67chgHnIH+xQtVeuIy3oy
         WbUjeg7HzoE8o0DWW/SYogLYK3zuGcn8xmHjI9PXWGEAW7d3zsLRk8qOyUOB5Q/Q+znA
         uN70PyNf2vLjwgWPW9+IKW5NEJVEJQ1oJuHF37wJaI/hJS5Mfk8YqcVciZr8BeClEcXC
         ESb5jAfaLB5bt7e2LXRW0CYxUVI+RjViUOH4NDvt+ZHrRxFJuPBDoRiDMpN8vRklkS5U
         FRYgYJyE5kPPjUOsC3PozGmma+zxPV38to7EBS1uH/X4Gj0WglPNTAJtPpl2+tU702iI
         f/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215721; x=1782820521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lx0STp9J5MD57IIANrpjIDVf2U7oRAYtvaIvJeF38Lw=;
        b=sFRIwmp45x/uWj6cQJOBaIbiOLfcbGVJxvc+jPhDS89SL7hPwRlrPCxCGNYcSnoCWo
         6JaossFDArA3Aegi2TYwICTL4jEKq2+bPQ70WS8AF3ldgm5eqXaBVl7RxI8OKQiFs/Cx
         gBUYsPb6JOmNQ3M+ykJHj1asqlF2RX6FwO8oRfi3O3278dm12BXw8RsoNz+kFYruGv4J
         JbY602TzIvNeWp065q/Qm60xE+EXP3bHK06VaTPdQt8f/RcjG9aZButqDb9zHcRkaGKe
         gY63fq9+pVyjFnwWPwJ0Ty5yei79VOUZvL/ugn2bI+FmThwvRl8ICoHt0zNiJJR8rXFc
         2gqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aMdYlNT8+PQpRfgTzBbBW48nwVHtRKB+JSTwffi1k8icT+VGhOUCqc+Y2EPl+V9CqmZbumwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucBuAn0OwL7k5sM1qft3IEfeDlXYYMaBzhjtn/h4gAowhzHsY
	Lqwk+E/zkxsx/E1PAxgU6/QJwEYvO6nzhCqbJQnEzbqh7JuQhuYu5pOW
X-Gm-Gg: AfdE7clrtdHs5/2RnKrA+2nOBev7tquzrt4qEJMMnN/BZRrMTKYw0otVOqiKsuPWn9E
	2GbF5nrKqfNNjXxHxMxUQZVGe2RNWjqh4giKBeOHNs1h60kMyOK/W8fecGS9Avx1anrM/KHNbLZ
	1TI213M2GEfyqERwXsGv5dJ7L5q5e/sLhNncBfLWi0sKx9nxv0o6Wwj+kIwbHbg0vLrjXx/u9vH
	xX9TJ7rxbmUHSKKsda4ajrYZDZ0IEL+iw3pwOBzfHcV2wGYZLsKSb88QkhuSKPTmtXR6ocWudkD
	d3/Gcgj+g9ZSdWgC3UDzVJpF9m48UQaSAM/wO6xtM9jfjF54phVpDpFbvwca9woSld3CzVAKnf+
	Z/YdzsY0HIeo9bTGaSCRJBPb4Tr+qimZg2FO7cPBbeZiP5kIAWsiHeuIxALgtExcipVBDFHqOrP
	ook/YQ6DiCCvqFrKet+BV6OA==
X-Received: by 2002:a05:600c:3113:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-492490a790cmr200461135e9.22.1782215720987;
        Tue, 23 Jun 2026 04:55:20 -0700 (PDT)
Received: from foxbook (bfg19.neoplus.adsl.tpnet.pl. [83.28.44.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496d8sm289452405e9.9.2026.06.23.04.55.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Jun 2026 04:55:20 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:55:17 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: raoxu <raoxu@uniontech.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
Message-ID: <20260623135517.2b1f0809.michal.pecio@gmail.com>
In-Reply-To: <c4ef0081-fbe9-47a4-b5d5-60665564ca02@linux.intel.com>
References: <20260619124234.0a9e4670.michal.pecio@gmail.com>
	<237BFC17C62D63DF+20260622062117.56278-1-raoxu@uniontech.com>
	<c4ef0081-fbe9-47a4-b5d5-60665564ca02@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Replying a little out of order here.

On Mon, 22 Jun 2026 14:31:58 +0300, Mathias Nyman wrote:
> Cancel the realtek URB we tried to soft retry earlier.
> 
> > 2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/3) [200cb341b0/200cb341b1/200cb341c0] xhci_urb_dequeue cancel TD at 200cb341b0 stream 0
> > 2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (004/3) [200cb341b0/200cb341b1/200cb341c0] queue_stop_endpoint suspend 0  
> 
> queue stop endpoint to cancel URB for realtek device.
> Endpoint context still shows endpoint is in "stopped" state.
> Note that we restarted the endpoint 20ms earlier, endpoint context
> might not have updated yet.

This was business as usual on uPD720200, it seems that these chips
don't update EP Context until the first scheduled service opportunity
(though no later than about 30ms - long interval endpoints must have
different rules) and they cannot execute Stop EP until then either. 

Some of them complete the command with Context State Error, others
delay completion until the scheduled restart. If we wait longer and
then queue Stop Endpoint, it executes instantly (fraction of a ms).

It seems that 201/202 chips still have the same limitation.

> I think there are some steps we could do to avoid soft retry,
> restart, and stopping an endpoint we know is behind a disconnected
> parent.

Yes, existing logic can be trivially extended to cover children too.
Of course, this does nothing if the device is disconnected from an
external hub or a transaction error occurs without disconnection.

But further experiments indicate that disconnection from the root hub
is actually a necessary condition to trigger this bug.

If another SuperSpeed device (even one without periodic endpoints like
UAS) is connected to another port, the retry causes another Transaction
Error a few ms later, the pipe halts and Stop EP completes normally
with Context State Error, as expected. Then we reset, remove the URB
and never restart this endpoint again.

The same happens if I trigger the bug and then connect either the same
hub or any other device to any SuperSpeed port before command timeout.

[  +0,000009] xhci_hcd 0000:06:00.0: 6/6 (000/2) [ff8f0bd0/ff8f0bd1/ff8f0be0] queue_reset_endpoint tsp 1
[  +0,000009] xhci_hcd 0000:06:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
[  +0,000504] xhci_hcd 0000:06:00.0: 6/6 (002/3) [ff8f0bd0/ff8f0bd1/ff8f0be0] handle_cmd_completion cmd_type 14 comp_code 1
[  +0,000025] xhci_hcd 0000:06:00.0: 6/6 (000/3) [ff8f0bd0/ff8f0bd1/ff8f0be0] ring_ep_doorbell stream 0
[  +0,006627] usb 10-1: USB disconnect, device number 22
[  +0,000016] usb 10-1.4: USB disconnect, device number 23
[  +0,000005] r8152-cfgselector 10-1.4.4: USB disconnect, device number 24
[  +0,000190] xhci_hcd 0000:06:00.0: 6/6 (000/3) [ff8f0bd0/ff8f0bd1/ff8f0be0] xhci_urb_dequeue cancel TD at ff8f0bd0 stream 0
[  +0,000011] xhci_hcd 0000:06:00.0: 6/6 (004/3) [ff8f0bd0/ff8f0bd1/ff8f0be0] queue_stop_endpoint suspend 0
[  +0,000009] xhci_hcd 0000:06:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
[  +0,000655] xhci_hcd 0000:06:00.0: 6/6 (004/2) [ff8f0bd0/ff8f0bd1/ff8f0be0] handle_tx_event comp_code 4 trb_dma ff8f0bd0
[  +0,000023] xhci_hcd 0000:06:00.0: 6/6 (004/2) [ff8f0bd0/ff8f0bd1/ff8f0be0] handle_tx_event stream_id 0 trb_len 2 missing 2
[  +0,000013] xhci_hcd 0000:06:00.0: 6/6 (004/2) [ff8f0bd0/ff8f0bd1/ff8f0be0] queue_reset_endpoint tsp 1
[  +0,000008] xhci_hcd 0000:06:00.0: 0/-1 (fff/f) [ffffffff/ffffffff/ffffffff] xhci_ring_cmd_db cmd_ring_state 1
[  +0,000012] xhci_hcd 0000:06:00.0: 6/6 (006/2) [ff8f0bd0/ff8f0bd1/ff8f0be0] handle_cmd_completion cmd_type 15 comp_code 19

I would guess that disconnecting all SuperSpeed ports causes the chip
to turn off its SuperSpeed schedule altogether and wait for SW to stop
all endpoints which aren't halted yet, but in case of pending restart,
Stop EP is scheduled to complete at the next service opportunity, which
never happens.

I also found that disconnecting a different affected NIC from the root
hub itself also triggers this bug, but only if I disable protection
from queuing Reset Endpoint (including with TSP) to "inactive" devices.

And the bug doesn't trigger every time - sometimes the unlink happens
while Reset Endpoint is pending and then its handler removes the URB
without Stop Endpoint.

And cable connection isn't actually necessary - I was mistaken due to
the randomness of the bug.

Regards,
Michal
