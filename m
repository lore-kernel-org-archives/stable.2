Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56F577E34
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882951; cv=none; b=m5O6eD7Bm5btu+uzNyk8CpF9e7/goCzUZybpocHDMvilV7caFDRH4p37RIrTa3ejeElntdpAiqUjljkAZjTfG4wwgbtqPqyvOzscIG9CMU4vEzOuzbleG3Y1HXnRkwqCCnQ0OrrnNdIksXtb4yvNDzkixdYqMOBA9LRVUnAg1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882951; c=relaxed/simple;
	bh=TckXPuonbCjW3ll7vU9025NMYhL42FTH72OM8FtKwpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ahc8nFjDLL7o2iLbwtfdbWo00UjDDAj89Llx+8B8uCY1VnDQJHuGh9XEL6hJFDebL1IF4MjrGg6ADe+RQeBr+cds1+gHVvBgudUD43nSClVRcw9OO2gh1Y5a0ZojMcL9bhH/st7W7wvBf15iQvE/RJ/XUii/nURvFtx07x1qH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BiiqCaip; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BiiqCaip"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37F1E1A1A5A;
	Tue,  8 Sep 2026 15:55:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B41A6031F;
	Tue,  8 Sep 2026 15:55:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18B6111C7AF29;
	Tue,  8 Sep 2026 17:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788882947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TckXPuonbCjW3ll7vU9025NMYhL42FTH72OM8FtKwpE=;
	b=BiiqCaipRCamk0P+DqN11XxWdSy4g9gVvsyt5FfiOOlp5yNf2KIHo7imzk0DFw1h+2+CZW
	/GhhUBzehC7Cx+qialfYsmDwJ9K2+qigt8EvXg+hj3OMtYyVWollUUprBYOv8WPpr3ZOKH
	ilr/fRiu+9Hkqqgn1uMg3epX/WfaxgSWLcRJgbSH7YfTCLxIwrAaSjVzv7Xo4BCvR9fRH9
	n7VPPfYD6lorWP/tTMdFLEck+0FVHA7JdBqaqEYH7Yum626QcbzsPvezTblfTvLzEcE5TB
	R3E99OJFt0I0gK5v44auBg0T+kpbEGc3ww77arkQtiurLSnx3KlOFSiU6d633g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,  Boris
 Brezillon <bbrezillon@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-sunxi@lists.linux.dev,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: sunxi: fit maximized ECC step to page
 size
In-Reply-To: <CADvTj4rFxwgYZgKzcHZG738UV0_94gxG1Dhy--ET9jC=E1dgoA@mail.gmail.com>
	(James Hilliard's message of "Tue, 8 Sep 2026 09:27:08 -0600")
References: <20260904-submit-sunxi-nand-ecc-step-validation-v2-1-6e3ba6200948@gmail.com>
	<87zexst5ze.fsf@bootlin.com>
	<CADvTj4rFxwgYZgKzcHZG738UV0_94gxG1Dhy--ET9jC=E1dgoA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 08 Sep 2026 17:55:44 +0200
Message-ID: <87y0dbspof.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 08/09/2026 at 09:27:08 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> On Tue, Sep 8, 2026 at 4:03=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
>>
>> Hello James,
>>
>> On 04/09/2026 at 16:39:27 -06, James Hilliard <james.hilliard1@gmail.com=
> wrote:
>>
>> > When nand-ecc-maximize is set, the driver unconditionally selects a
>> > 1024-byte ECC step. A NAND with a 512-byte page consequently produces
>> > zero ECC steps before the available OOB bytes are divided by the step
>> > count.
>> >
>> > The older sunxi NAND controllers support 512-byte ECC blocks. Select t=
he
>> > smaller of the page size and the preferred 1024-byte step, using a
>> > 512-byte step for a 512-byte page while retaining 1024-byte steps for
>> > larger pages. Unsupported smaller steps and controllers without
>> > 512-byte support continue to be rejected by the existing checks.
>> >
>> > Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>
>> As reported by Sashiko, there is another use of 1024 down the road which
>> must be modified accordingly. Although, in practice, 512-byte page NANDs
>> have disappeared for quite some time, so this is a theoretical fix more
>> than a real problem.
>
> Does the v3 I sent look like it should work?:
> https://lore.kernel.org/all/20260904-submit-sunxi-nand-ecc-step-validatio=
n-v3-1-931cec317c10@gmail.com/

Yes I think so.

