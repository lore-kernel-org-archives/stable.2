Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202625;
	b=PaIyYw0NXLkDyNL4pMuarlW5OR+kqb/LesZaaX9gVIkNPTs1SaG2ati8KK/eSCMxG3Pn
	 Dw/yYuEOQ31SFIgBkNSf710aN1L3yP6TQqkjpJJHi5N8kpOZRTVuLKw4FhkBp01iQrEPC
	 Y2GUzsAPUxDpwZFZrjaN5OnIkdbQ8Zm4OoMoPEyOBSmbON5j1c91qT5gfqUUmBzSDlBSo
	 8QG7oUzrPnWbPnQLzq0yxmoi6CFZMesp1a3dqaASb8PfQguO3nFyFFg4HY6AZwa3s3u96
	 vZ/ZCbDPC54O//wkDhTC2FH6QYvwQg3j4Oi3KGzXncFWUl00Nelbk8sjBcMRUoQrCSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202625;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P5gHNQzeRGB5ay4L4jhyXK5TgEBlTihVO3XydtF8iLo=;
	b=0wQc6HHilAXOQgBxWGt+MQMkqfEYq+78Pboj5If1hgoz9Luafte4V5s4rdwaaggeVDvS
	 RBQIphAfJbmwzU8oA3uaVAvxmhojZHrKtWkTM5N2ip1QqyrqyBzKN+NSimDAAY0xIBjE1
	 YEDtdZTS9Lc2afFxs3gSG3jbAjmqwCccUlQ4sQTbsY9RAVWGLhpXrMBYtJE2+ZFZVQ+uw
	 6MQJo6Ii7mQn6kLzp19L6s1CX0dDx6REEBM1bdNwIqB11fGkDtAUIpxHGf6dpsGwDNhZQ
	 iqcKsdELXc406SxmoZR22G619Un2p5NHQtIMmF0vcQTcmHKtGgXcK5LA1H9OMuRkMbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=UrYt0Uum;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A19606A320;
	Wed, 28 Oct 2026 15:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A19606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=UrYt0Uum
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=P5gHNQzeRGB5ay4L4jhyXK5TgEBlTihVO3XydtF8iLo=; t=1793202625; x=1794412225; 
	b=UrYt0Uumkdz+F5h4ZhOsNqk2D4rGB1hrpFKYPoaougQP8jXBWwnLnEzYZ4ecKTV1dfACJJulkk7
	f/WZnpk8R3lRFCkbkJ8SXL0ZZMYDsRQz+wzHWtU7MCK/TQfCtxBrxO4k046lUMs74auazBeBk6Ezw
	4zkY3i3E6mog0PpaYDz3CLTUXxJ8QdzcW1PMQ+scGRujt/OF+R1hkvGrJ1TCapMySI52l0L1xlVZX
	n/pysFJLJOJgab8RlFmprCKLarF/XazWxZqlKHlpmh0cYzMTMVr8gO/gCOW6kiHLJ3mTIHA8/1yx4
	eESTfRvLUA+SYCyvqCJbZKInZWJ/7ulSdZyQ==;
Date: Wed, 28 Oct 2026 16:50:03 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Kai Svahn <kai.svahn@nokia.com>, syed khasim
 <x0khasim@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz
 <sameo@linux.intel.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on
 teardown and probe failure
Message-ID: <20261028165003.60d0c033@kemnade.info>
In-Reply-To: <20261027093306.2812695-14-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
	<20261027093306.2812695-14-lee@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 09:30:42 +0000
Lee Jones <lee@kernel.org> wrote:

> twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
> and checks for a non-NULL twl_priv at entry to reject multiple device
> instances.  However, twl_remove() and the early error paths in
> twl_probe() never reset twl_priv to NULL, a failure when adding MFD
> child devices bypasses twl_remove() by jumping to free instead of fail,
> and twl_remove() tears down the IRQ domain and dummy I2C clients before
> child devices are unregistered.  After devres frees the underlying
> memory on probe failure or unbind, twl_priv remains a dangling pointer,
> causing subsequent exported API calls to dereference freed memory and
> blocking future probe attempts with -EBUSY.
> 
> Unregister DT-populated and MFD child devices at the start of
> twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
> reset twl_priv to NULL in twl_remove() and on probe error exit.
> 
> Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
> Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Hmm, couldn't we use devm_add_action_or_reset() for resetting the
twl_priv pointer? Feels more clean for me.

Regards,
Andreas
