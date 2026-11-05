Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881838;
	b=osBEgFqYvYfrWhkFjYJJFrjmoTCI9soIusAzNF8hmByufR8te+0qOdNSkmFPEBzujeE3
	 WVvnvkFg+uNj/+UpS1+e68jGNiVY5OVZ8GTHYOThJxZAfXmRvyLj6k13Gmb0+WN1F3XuC
	 F6jm5FnWd2aPW6MU64npvHlLusVuihz4w9sg/Q1JBoljvj/m31+lgbMHxAE6qX1cFNeQr
	 6IVPFH2hsmpKfxwy92UXPDU7W2Rl7FB6/ZgF4qBBQ/WebdQ0Mzq9tQe7Ufj/bqFbPNbM3
	 VhiLkzvivtxywrZqGAsuraHHUYCur50/DszGNDpn0BlOZ2eEqQCTDHyT6uWClq8HzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NXQY59s7bZpTSHFUOUk0f+WmyGheH78ucLM4Hd8zHqc=;
	b=oWSYdgtB6jum7PDLTuE1gJQ3fUU//+QXaKqea9HgzFP6OSZRN1jtLkxfIKybDIq/PBi/
	 OVv3+wb1G2PbEa40jOiKxhqBAUsfMwHrx13Nsplr28KGIDKh/uQWbdstLxtDeMxoDjEcL
	 iqF35xvltj3/alSF4nqtOZW3JiTaBrqPDC2dd8AxJNBx0Bj1YhaNs9OCa9DSfUYMC4p/u
	 +xHoJqi7Is9JLCLrY0dXeTgjs2e+26Pcx7MGDjTYwUiqgT4C47lFsq2ImJTYLUhhdjhI4
	 thBwaZoqZkzrsZ99m1nGGZQ0vSOLoY2NFCrhEhVoTjponVCAjJIkZx/SdYZQZs4HNJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPhhH6+N;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB5606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPhhH6+N
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so11057975e9.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793881836; x=1794486636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NXQY59s7bZpTSHFUOUk0f+WmyGheH78ucLM4Hd8zHqc=;
        b=nPhhH6+NmaqLVBTjCn6gLiWxt54G0rgpmjDMCOOOwIWuE7hkwZaTwdHSUcbLz90bV3
         +ZhYUFxfNS7WxFP0TCpE2V3+vHO/juXGoxxLRmQAG1M0RU9BwCAIC6xrf1jMiPl7o2Ys
         87goIbnEB+AfvUgROipi1L6JBvIsJ37EY/02vV4hcGgnLBoV06mTIbqcKsRj3vaIT1H3
         eS7zqYVWOirImhoCWwjmNkft6z7CcanMqZG7wJAvrrmk2Ge6lrxeGZdEDDTTyD8TFphY
         Ih93YOQAnCpD94CVFIldfnCL/sushsVq1Om2ZW5GSygkVHDGFcvj0LHnRYakzU9XaN/D
         x+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881836; x=1794486636;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXQY59s7bZpTSHFUOUk0f+WmyGheH78ucLM4Hd8zHqc=;
        b=tHK6oEnTJsmJd4aRpB20kZtFA00txTeVHY8D2YPYCmyVTjvVAppms0PfKgLxIv99HK
         k77i5Z09kmo+HY67Ct7YtDJN0kcdZ3MnioeLDggBLTj4QSCfhqUVqU/GO/3TjCPthlat
         PKCvK44ZddmhDTAqTDKWFFewl4By63aCTznh0EpLJAoG3oz5bk2824umgR0N8BoV7aCL
         skpU6zwrFS7+hHwRPPlayTrTzbGlqMk4cU5An8WsYCoj4dKt1pVs/RQFyyc+zXUGhTAk
         jb1BJg3fD6BbbP19ohKVBGrovOVGeK1wYJ/HtoeQK2FpIe2An46iGHCUnQtc8NbAU85B
         bIGA==
X-Forwarded-Encrypted: i=1; AKwUvBwO5eFVhb6HiL2SZ33XhoyFNqg2bgaLH7pG222bZqnWDzaLKGR9wfjbPi4wootnjIdmLAyjWBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fnumjxcvCPUsablgOzHAQMaVY7Am+n9E4X2pfjFqTh98qdt8p
	m4fUk/jHZCXDmkdS2AEb2I1d6EOFnDtzEs+eSyi3dtgz4CS5O//tonSB
X-Gm-Gg: AYBFou0G+0DtLwzOacgc9J7P2nKCyT6w3s3nozOhzwSFbayt69HmSFq4r4VZ866JoAQ
	EeTZqoEtUlrgK/wYbE+LGlcCTWJQ7+rPpfqdh7lPN6SyVcEc2vJg26LJ/wJe9kjMno1kLbP9TQP
	GqCjiB5h9FHaaL1Iagfz0XfbtE5HI6KFSiGFjqG2kr1D27LZs7zgm78bef9VxhZQxcw/7MxHqrR
	XDirmoWpKjtJyGfKJKHcSkIO/beBztR5V2bxqkJdJ9yhl4/be0ZI6myODN0sV44tOBmgqAqywOY
	mwyPKAhDBUYpoXXF+Vc2hAhAVAml4I5sgtjWAjqP7S9F2VjZmbK6ey82ybQl9wT+EDrBSkVBjtN
	rf5PLU3VS+FGGeRL72s70kd6hJqgl1NBC1WeSb0Rb/75uuLVQCL3MLGKq6eDQGwGr1GTZ0154zB
	5jJJ9Tcmx4oLcWHyr8d245v4rEzSYUrGnFnyo3UfiqKpZyBuyNmtKDYVmDRvP39XQWjfgSX73KL
	88fkagFT6l86qJgBxrL3VEU7QiyAVd8vmeCtzkUhNfXtf1lixxkIzLq5CT9njweK7l6H1FeIbKD
	7vDVoCegEF1SYMtnxs/sdUGndK/SQDHR/FNOhH4=
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4ac185bd1e2mr417810655e9.16.1793881836320;
        Thu, 05 Nov 2026 04:30:36 -0800 (PST)
Received: from foxbook (bfg124.neoplus.adsl.tpnet.pl. [83.28.44.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180ee1sm11450138f8f.4.2026.11.05.04.30.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Nov 2026 04:30:36 -0800 (PST)
Date: Thu, 5 Nov 2026 13:30:31 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pengfei Lv <lvpengfei20@huawei.com>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, xuhaiyang5@hisilicon.com, xuetao09@huawei.com,
 caiyadong@huawei.com, suzhuangluan@hisilicon.com
Subject: Re: [PATCH] usb: core: hub: Re-guess ep0 maxpacket size on reset
Message-ID: <20261105133031.6a49f1cc.michal.pecio@gmail.com>
In-Reply-To: <59b0cc88-9ac2-453b-bd68-56aa356c0fc0@rowland.harvard.edu>
References: <20261104124402.1269650-1-lvpengfei20@huawei.com>
	<b9ac3c8f-7ce5-43d1-bcf1-d2ce9877d914@rowland.harvard.edu>
	<20261104183603.17d663ce.michal.pecio@gmail.com>
	<59b0cc88-9ac2-453b-bd68-56aa356c0fc0@rowland.harvard.edu>
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

On Thu, 5 Nov 2026 00:06:24 -0500, Alan Stern wrote:
> On Wed, Nov 04, 2026 at 06:36:03PM +0100, Michal Pecio wrote:
> > Were there known devices with bMaxPacketSize0 <= 16 which required
> > the whole transfer to complete before they are reset?
> > 
> > That's not what happens in the initial iteration, so it seems any
> > such devices would always take two iterations to begin working.
> > 
> > Is this what the only correct Proprietary Operating System does?  
> 
> I don't know offhand of any positive or negative examples.

Pengfei believes that the current behavior has only existed since 2023,
so perhaps no device depends on it for enumeration yet. And proposed
reset matches initial enumeration, so it seems low risk.

> But if a device was going to hang if it was asked for the remaining
> part of the device descriptor after a non-initial reset, how would it
> ever get through initialization?  The procedure does two resets, and
> after the second reset the device has to send the full descriptor.

I guess a device can harcode enumeration, including the 2nd reset, as
fixed sequence. Or it may send 8-byte descriptors while in the default
state or when wLength=64. Not sure why it would do that, though.

> I don't know what other OSes do about this.

I tried W10 in QEMU with qemu-xhci host controller, the device was an
audio dongle with a HID function and bMaxPacketSize0=8 passed through.
I disconnected D- to get errors without port disconnection detected.

Windows doesn't seem to switch packet size back to 64, it only disables
non-default endpoints, checks port status, resets it, switches xHCI
device state to "default" and then reads 64 bytes of device descriptor.

This succeeds because host kernel has already configured proper packet
size by this time. Not sure what Windows would od if this hanged.

Later of course second reset, address device, normal enumeration.

Regards,
Michal
