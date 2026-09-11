Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D4371885;
	Fri, 11 Sep 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145806; cv=none; b=IV04RFl1OHIWRULrNgo085qWPn7qygHft0OwuhL2R3MGxVt5pq93V0ami2+P83n6VUK/d75LTVdNz12gzCtuWkFNrypY0Pq9jhfyDg+DN+TOFAWbBbHg0RhL0E1gRkOD6V1ZyBb92+tINwCYlB5hJyxheXnMWnFk7IQPWCjisaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145806; c=relaxed/simple;
	bh=k7z4er0JwzR+YuF/5rlsyLW8xGf7sQsjApta0sWIf/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i4FAxLZmEiaOwAKlxi0yGVULzSkIRZ66UiZGeJbtPwJSyn3tyH99h3zWTmMD/DoHmEaP9je31pW9+DD6vp85N5m/gahkvm34bje7IdOpaoEEIB8y2CgNXAcoHik4O6oaquoT6vr0p59B2RKQp/2YYDUoLSH3gWTIiegVzYFrn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSfnvcZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSfnvcZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139191F00893;
	Fri, 11 Sep 2026 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145803;
	bh=PeInbayzaYLsQW4IFz/XdJ1TU4uee9RiAssjmpuH2bg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GSfnvcZb4ShqmO9x1b6NNyP6aIruAw0NWNXLEnZkZKo8+PcLji/8N+X8Ur+/Z8eVY
	 3VZIFjsL0J2hWkchxk7YKygekiffDyQmQJ0FDyJDSkJnI1sJ9srtYo1pyNnLz4eXkO
	 IcyWgGkwBXdsBIT/7pM0Zk5f0DurqSJAG6ZrukVmT7muE3NFxQaJmDZ3s5aoCmY585
	 HWDnTMGlpADXrxUG4Yl2xlQpHXX211jQsm2PHQtk7ySDRZQeCKb7CDk80DA+LbvRUh
	 C5AnDPo77uh53DLNKmqG87w+gmrtjT8p1aZ+O4Zg2H/8xSCERMEQADIZqmYTjYrGqF
	 tkh6595yeAAFQ==
Date: Fri, 11 Sep 2026 18:56:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Panz Dev <panz.development@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Denis Benato <denis.benato@linux.dev>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: asus: do not send keyboard init reports to
 touchpads
In-Reply-To: <20260818151431.939132-1-panz.development@gmail.com>
Message-ID: <2965696n-2r93-q045-pn5n-4n72n9p66o89@xreary.bet>
References: <20260818151431.939132-1-panz.development@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Aug 2026, Panz Dev wrote:

> Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
> loop during asus_probe() to send keyboard feature report initializations
> (asus_kbd_init) to all ASUS HID devices.
> 
> On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
> keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
> sends invalid feature requests to touchpad hardware, corrupting probe
> state and causing the touchpad to become unresponsive.
> 
> Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
> keyboard feature initialization only runs for actual keyboards.
> 
> Tested on ASUS E200HA (where touchpad functionality is fully restored)
> and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).
> 
> Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Panz Dev <panz.development@gmail.com>
> ---
> v2:
>  - Keep asus_start_multitouch() inside the HID_CLAIMED_INPUT check to avoid
>    any UAF risk if input registration fails (as pointed out by Denis Benato
>    and automated review).
>  - Focus the fix on skipping keyboard report initialization for touchpads.

Applied to hid.git#for-7.4/asus, thanks.

-- 
Jiri Kosina
SUSE Labs

